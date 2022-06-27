;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; company
(use-package company
:ensure t
:defer 3
:hook (after-init . global-company-mode)
:config
  :bind (
       ;;  :map company-mode-map
       ;;  ("<backtab>" . company-select-previous)
         :map company-active-map
         ("C-p" . company-select-previous)
         ("C-n" . company-select-next)
         ("<tab>" . company-complete-common-or-cycle)
         ("<backtab>" . company-select-previous)
         :map company-search-map
         ("C-p" . company-select-previous)
         ("C-n" . company-select-next))
  :init
  (setq company-tooltip-align-annotations t
        company-tooltip-limit 12
        company-idle-delay 0
        company-echo-delay (if (display-graphic-p) nil 0)
        company-minimum-prefix-length 1
        company-icon-margin 3
        company-require-match nil
        company-dabbrev-ignore-case nil
        company-dabbrev-downcase nil
        company-global-modes '(not erc-mode message-mode help-mode
                                   gud-mode eshell-mode shell-mode)
        company-backends '((company-capf :with company-yasnippet)
                           (company-dabbrev-code company-keywords company-files)
                           company-dabbrev))
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; prescient
  ;; Better sorting
(use-package prescient
  :ensure t
  :defer 3
  :commands prescient-persist-mode
  :init (prescient-persist-mode 1))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; company-prescient
(use-package company-prescient
  :ensure t
  :defer 3
  :init (company-prescient-mode 1))

  ;; Icons and quickhelp
;; (use-package company-box
;;  :defer 3
;;  :ensure t
;;   :diminish
;;   :defines company-box-icons-all-the-icons
;;   :hook (company-mode . company-box-mode)
;;   :init (setq company-box-icon-alist 'all-the-icons
;;               company-box-backends-colors nil
;;               company-box-doc-delay 0.1
;;               company-box-scrollbar 'right))

(provide 'init-company)
