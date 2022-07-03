;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; evil-nerd-commenter
(use-package evil-nerd-commenter
:ensure t
:defer 2
:config
;;======= 注释插件 evil-nerd-commenter
(defhydra hydra-evil-nerd-commenter (:color pink
                                     :hint nil
                                     :foreign-keys warn ;; 不要使用hydra以外的键
				     )
"
_i_: 注释or取消注释   _l_: 快速注释or取消
_p_: 段落注释         _c_: 复制并注释
"
  ("i" evilnc-comment-or-uncomment-lines :exit t)
  ("l" evilnc-quick-comment-or-uncomment-to-the-line :exit t)
  ("c" evilnc-copy-and-comment-lines :exit t)
  ("p" evilnc-comment-or-uncomment-paragraphs :exit t)
  ("q" nil "cancel")
  ("<escape>" nil "cancel")
)
;;==============================
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; evil-escape
(use-package evil-escape
:ensure t
:defer 0.5
:config
(setq-default evil-escape-key-sequence "jk")
(setq-default evil-escape-delay 0.2)
:hook (text-mode . evil-escape-mode)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; evil
(defun freedom/evil-hook ()
  (dolist (mode '(custom-mode
                  eshell-mode
                  git-rebase-mode
                  erc-mode
                  circe-server-mode
                  circe-chat-mode
                  circe-query-mode
                  sauron-mode
                  term-mode))
  (add-to-list 'evil-emacs-state-modes mode)))
(use-package evil
  :ensure t
  :defer 0.6
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-respect-visual-line-mode t)
  ;; (setq evil-undo-system 'undo-tree)
  :hook (evil-mode . evil-escape-mode)
        (evil-mode . freedom/evil-hook)
  :bind (:map evil-normal-state-map
         (";" . evil-ex)
         ("u". undo-fu-only-undo)
         ("C-r" . undo-fu-only-redo)
         :map evil-motion-state-map
         (";" . evil-ex)
         :map evil-visual-state-map
         (";" . evil-ex)
         )
  :config
(evil-mode 1)
(general-define-key
 :states 'normal
 :keymaps 'org-mode-map
 "TAB" 'org-cycle
 )
(general-define-key
 ;; :states 'insert
 :states 'normal
 :keymaps 'markdown-mode-map
 "TAB" 'markdown-cycle
 )
;; cursor color
(setq evil-normal-state-cursor  '("DarkGoldenrod2" box)
        evil-insert-state-cursor  '("chartreuse3" (bar . 2))
        evil-emacs-state-cursor   '("SkyBlue2" box)
        evil-replace-state-cursor '("chocolate" (hbar . 2))
        evil-visual-state-cursor  '("gray" (hbar . 2))
        evil-motion-state-cursor  '("plum3" box)) 
;; 粘贴不复制
(defun evil-paste-after-from-0 ()
  (interactive)
  (let ((evil-this-register ?0))
    (call-interactively 'evil-paste-after)))
(define-key evil-visual-state-map "p" 'evil-paste-after-from-0)
;; (define-key evil-normal-state-map "p" 'evil-paste-after-from-0)
(defun freedom-evil-translate-word ()
  (evil-a-word)
  (when freedom/is-windows
    (gts-do-translate-my))
  (when freedom/is-linux
    (sdcv-search-pointer+))
  )
(defun freedom-evil-word-translate ()
  (interactive)
  (run-at-time 0 nil 'freedom-evil-translate-word))
(define-key evil-normal-state-map "w" 'freedom-evil-word-translate)
(define-key evil-motion-state-map "w" 'freedom-evil-word-translate)

;;=============================================
;; evil-window 模板
(general-define-key
  ;; :keymaps 'dashboard-mode-map
 :states 'normal
  "C-w" 'hydra-evil-window/body
)
(defhydra hydra-evil-window (:color pink
                              :hint nil
                              :foreign-keys warn ;; 不要使用hydra以外的键
				     )
"
_s_: 平行分割      _v_: 垂直分割
_j_: 向下          _k_: 向上 
_h_: 向右          _l_: 向左
_d_: 删除当前窗口
"
  ("s" evil-window-split :exit nil)
  ("v" evil-window-vsplit :exit nil)
  ("j" evil-window-down :exit nil)
  ("k" evil-window-up :exit nil)
  ("l" evil-window-right :exit nil)
  ("h" evil-window-left :exit nil)
  ("d" evil-window-delete :exit nil)
  ("q" nil "cancel")
  ("<escape>" nil "cancel")
)
;;=============================================

)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; evil-collection
(use-package evil-collection
  :defer 1
  :ensure t
  :after evil
  :init
  (setq evil-collection-company-use-tng nil)  ;; Is this a bug in evil-collection?
  :custom
  (evil-collection-outline-bind-tab-p nil)
  :config
  (setq evil-collection-mode-list
        (remove 'lispy evil-collection-mode-list))
  (evil-collection-init '(calendar dashboard markdown-mode popup neotree bm)))
  ;; (evil-collection-init))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; key-chord
(use-package key-chord
:ensure nil
:defer 1
:load-path "~/.emacs.d/core/plugins"
:config
(key-chord-mode 1)
(defun my-vim-autocmd-find ()
  (interactive)
  (search-forward "<++>" nil t)
  (delete-backward-char 4)
  )

(key-chord-define evil-insert-state-map ";f" 'my-vim-autocmd-find)
(key-chord-define evil-insert-state-map ";o" 'hydra-my-config-org-syntax/body)
(key-chord-define evil-insert-state-map ";m" 'hydra-vim-autocmd-markdown-mode/body)
(key-chord-define evil-insert-state-map ";;" 'my-config-pyim)
(key-chord-define evil-normal-state-map "b," 'next-buffer)
(key-chord-define evil-normal-state-map "b." 'previous-buffer)
(key-chord-define evil-normal-state-map "qq" 'evil-quit)
;; (key-chord-define evil-normal-state-map "mm" 'bm-toggle)
;; (key-chord-define evil-normal-state-map "mv" 'bm-show-all)
;; (key-chord-define evil-normal-state-map "ms" 'bm-show)
;; (key-chord-define evil-normal-state-map "mj" 'bm-next)
;; (key-chord-define evil-normal-state-map "mk" 'bm-previous)

;; (key-chord-define meow-insert-state-keymap ";f" 'my-vim-autocmd-find)
;; (key-chord-define meow-insert-state-keymap ";f" 'my-vim-autocmd-find)
;; (key-chord-define meow-insert-state-keymap "jk" 'meow-insert-exit)

)

(provide 'init-evil)
