;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; vertico minibuffer 补全
(use-package vertico
  :defer 3
  :ensure t
  :config
  (vertico-mode t))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :defer 3
  :ensure nil
  :init
  (setq savehist-file (expand-file-name "emacs/history" user-emacs-directory))
  (savehist-mode)
  )

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; Optionally use the `orderless' completion style.
(use-package orderless
  :defer 3
  :ensure t
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; A few more useful configurations...
(use-package emacs
  :defer 3
  :ensure nil
  :init
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Emacs 28: Hide commands in M-x which do not work in the current mode.
  ;; Vertico commands are hidden in normal buffers.
  ;; (setq read-extended-command-predicate
  ;;       #'command-completion-default-include-p)

  ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Search content in the file
(use-package consult
  :defer 3
  :ensure t
  :bind ("C-s" . consult-line)
  :config
  ;; 添加 evil 利用 n 进行搜索 consult 的结果
(defun noct-consult-line-evil-history (&rest _)
  "Add latest `consult-line' search pattern to the evil search history ring.
This only works with orderless and for the first component of the search."
  (when (and (bound-and-true-p evil-mode)
             (eq evil-search-module 'evil-search))
    (let ((pattern (car (orderless-pattern-compiler (car consult--line-history)))))
      (add-to-history 'evil-ex-search-history pattern)
      (setq evil-ex-search-pattern (list pattern t t))
      (setq evil-ex-search-direction 'forward)
      (when evil-ex-search-persistent-highlight
        (evil-ex-search-activate-highlight evil-ex-search-pattern)))))

(advice-add #'consult-line :after #'noct-consult-line-evil-history)
(setq evil-search-module 'evil-search)
 (define-key evil-normal-state-map (kbd "n")
    (lambda () (interactive) (search-forward (car consult--line-history))))
 (define-key evil-normal-state-map (kbd "N")
   (lambda () (interactive) (search-backward (car consult--line-history))))
  )

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; counsel 搜索
;; (use-package counsel
;; :defer 1
;; :ensure t
;; :bind (("C-s" . swiper)
;;       )
;; :config
;; (ivy-mode)
;; (setq ivy-use-virtual-buffers t)
;; (setq enable-recursive-minibuffers t)

;; ;; 去掉^前缀
;; ;; delete M-x ^
;; (with-eval-after-load 'counsel
;;   (setq ivy-initial-inputs-alist nil))
;; ;; 调整 counsel 搜索的方式: 忽略单词顺序
;; (setq ivy-re-builders-alist
;; '((counsel-rg . ivy--regex-plus)
;;  (swiper . ivy--regex-plus)
;;  (swiper-isearch . ivy--regex-plus)
;;  (t . ivy--regex-ignore-order)))

;; )


(provide 'init-search)
