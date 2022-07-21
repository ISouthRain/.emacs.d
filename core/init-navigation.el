(use-package switch-window
  :defer 6
  :ensure t
  :hook (after-init . winner-mode)
  :config
  (setq-default switch-window-shortcut-style 'alphabet)
  (setq-default switch-window-timeout nil))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 窗口透明
(defun sanityinc/adjust-opacity (frame incr)
  "Adjust the background opacity of FRAME by increment INCR."
  (unless (display-graphic-p frame)
    (error "Cannot adjust opacity of this frame"))
  (let* ((oldalpha (or (frame-parameter frame 'alpha) 100))
         (oldalpha (if (listp oldalpha) (car oldalpha) oldalpha))
         (newalpha (+ incr oldalpha)))
    (when (and (<= frame-alpha-lower-limit newalpha) (>= 100 newalpha))
      (modify-frame-parameters frame (list (cons 'alpha newalpha))))))
;; (global-set-key (kbd "M-8") (lambda () (interactive) (sanityinc/adjust-opacity nil -2)))
;; (global-set-key (kbd "M-9") (lambda () (interactive) (sanityinc/adjust-opacity nil 2)))
;; (global-set-key (kbd "M-7") (lambda () (interactive) (modify-frame-parameters nil `((alpha . 100)))))
(defhydra hydra-AdjustOpacity(:color pink
                  :hint nil
                  :foreign-keys warn ;; 不要使用hydra以外的键
				     )
"
_j_: 增加 _k_: 减少 _g_: 重置
"
  ("j"  (sanityinc/adjust-opacity nil 2) :exit nil)
  ("k"  (sanityinc/adjust-opacity nil -2) :exit nil)
  ("g"  (modify-frame-parameters nil `((alpha . 100))) :exit nil)
  ("q" nil "cancel")
  ("<escape>" nil "cancel")
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; which-key 按键提示
(use-package which-key
:ensure t
:defer 2
:config
(which-key-mode)
(which-key-setup-side-window-bottom)
(which-key-enable-god-mode-support)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; awesome-tab 管理 Buffer
(use-package awesome-tab
  :ensure nil
  :defer 2
  :load-path "~/.emacs.d/core/plugins"
  :config
  (awesome-tab-mode t)
;; 设置标签栏长度
(setq awesome-tab-label-fixed-length 14)
;; 高度
(setq awesome-tab-height 150)
;; 按使用索引排行
;; (setq awesome-tab-show-tab-index t)
;; 如果使用 helm
(awesome-tab-build-helm-source)
;; 隐藏那些buffer
(defun awesome-tab-hide-tab (x)
  (let ((name (format "%s" x)))
    (or
     (string-prefix-p "*epc" name)
     (string-prefix-p "*helm" name)
     (string-prefix-p "*bm-bookmarks*" name)
     (string-prefix-p "*Compile-Log*" name)
     (string-prefix-p "*lsp" name)
     (and (string-prefix-p "magit" name)
               (not (file-name-extension name)))
     )))

;; buffer 群组归类
(defun awesome-tab-buffer-groups ()
  "`awesome-tab-buffer-groups' control buffers' group rules.

Group awesome-tab with mode if buffer is derived from `eshell-mode' `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.
All buffer name start with * will group to \"Emacs\".
Other buffer group by `awesome-tab-get-group-name' with project name."
  (list
   (cond
    ((or (string-equal "*" (substring (buffer-name) 0 1))
         (memq major-mode '(magit-process-mode
                            magit-status-mode
                            magit-diff-mode
                            magit-log-mode
                            magit-file-mode
                            magit-blob-mode
                            magit-blame-mode
                            )))
     "Emacs")
    ((derived-mode-p 'eshell-mode)
     "EShell")
    ((derived-mode-p 'emacs-lisp-mode)
     "Elisp")
    ((derived-mode-p 'dired-mode)
     "Dired")
    ((memq major-mode '(org-mode org-agenda-mode diary-mode))
     "OrgMode")
    (t
     (awesome-tab-get-group-name (current-buffer))))))

;;=============================================
;; awesome-tab
(defhydra hydra-awesome-tab (:hint nil
                             :color pink
                             :foreign-keys warn
)
  "
 ^^^^Fast Move             ^^^^Tab
-^^^^--------------------+-^^^^---------------------
   ^_k_^   prev group    | _C-a_^^     select first
 _h_   _l_  switch tab   | _C-e_^^     select last
   ^_j_^   next group    | _C-j_^^     ace jump
 ^^0 ~ 9^^ select window | _C-h_/_C-l_ move current
 _R_  remove window    | _C-w_ evil-window
 _s_  split window     | _v_ vsplit window
-^^^^--------------------+-^^^^---------------------

  ^^Search            ^^Misc
+-^^----------------+-^^---------------------------
| _b_ search buffer | _K_   kill buffer
| _g_ search group  | _C-S-k_ kill others in group
| ^^                | ^^
+-^^----------------+-^^---------------------------
"
  ("h" awesome-tab-backward-tab)
  ("j" awesome-tab-forward-group)
  ("k" awesome-tab-backward-group)
  ("l" awesome-tab-forward-tab)
  ("0" winum-select-window-by-number)
  ("1" winum-select-window-1)
  ("2" winum-select-window-2)
  ("3" winum-select-window-3)
  ("4" winum-select-window-4)
  ("5" winum-select-window-5)
  ("6" winum-select-window-6)
  ("7" winum-select-window-7)
  ("8" winum-select-window-8)
  ("9" winum-select-window-9)
  ("C-w" hydra-evil-window/body :exit t)
  ("R" evil-window-delete :exit nil)
  ("C-a" awesome-tab-select-beg-tab)
  ("C-e" awesome-tab-select-end-tab)
  ("C-j" awesome-tab-ace-jump)
  ("C-h" awesome-tab-move-current-tab-to-left)
  ("C-l" awesome-tab-move-current-tab-to-right)
  ("b" ivy-switch-buffer :exit t)
  ("g" awesome-tab-counsel-switch-group)
  ("s" split-window-below)
  ("v" split-window-right)
  ("K" kill-current-buffer)
  ("C-S-k" awesome-tab-kill-other-buffers-in-current-group)
  ("q" nil "quit")
  ("<escape>" nil "quit"))
;;=============================================
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; avy 单词跳跃
(use-package avy
:ensure t
:defer 2
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; winum 窗口管理
(use-package winum
  :ensure nil
  :defer 2
  :load-path "~/.emacs.d/core/plugins"
  :config
  (winum-mode)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ace-window 窗口跳跃
(use-package ace-window
:ensure nil
:defer 2
:load-path "~/.emacs.d/core/plugins"
:config
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l ?r ?i ?t ?o ?u))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; zoom 自动调整窗口大小
(use-package zoom
:ensure t
:defer 3
:config
(custom-set-variables
 '(zoom-mode t))
(custom-set-variables
 '(zoom-size '(0.618 . 0.618)))
(defun size-callback ()
  (cond ((> (frame-pixel-width) 1280) '(90 . 0.75))
        (t                            '(0.5 . 0.5))))

(custom-set-variables
 '(zoom-size 'size-callback))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; buffer-move 移动buffer到其他窗口
(use-package buffer-move
:ensure nil
:load-path "~/.emacs.d/core/plugins"
:defer 3
:config
;;=============================================
;; buffer-move 模板
(defhydra hydra-buffer-move (:color pink
                              :hint nil
                              :foreign-keys warn ;; 不要使用hydra以外的键
				     )
"
_j_: 向下移动   _k_: 向下移动
_h_: 向左移动   _l_: 向右移动
"
  ("j" buf-move-down :exit nil)
  ("k" buf-move-up :exit nil)
  ("l" buf-move-right :exit nil)
  ("h" buf-move-left :exit nil)
  ;; (""  "" :exit nil)
  ("q" nil "cancel")
  ("<escape>" nil "cancel")
)
;; =============================================

)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; switch-window 窗口导航
;;(use-package switch-window
;;  :ensure t
;;  :defer 4
;;  :hook (after-init-hook . winner-mode)
;; :config
;;  (setq-default switch-window-shortcut-style 'alphabet)
;;  (setq-default switch-window-timeout nil)
;;)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; neotree 文件浏览器
(use-package neotree
:ensure t
:defer 3
:config
(setq neo-theme (if (display-graphic-p) 'icons 'arrow)
      ;; neo-toggle-window-keep-p t
      )

;;===============================================
;;====== neotree 文件浏览器
(defhydra hydra-neotree (:color pink
                         :hint nil
                         :foreign-keys run ;; 不要使用hydra以外的键
			 )
"
_n_: find   _q_: hide   _SPC_: goto-char
_c_: create _r_: rename _R_: change dir
"
  ("n" neotree-find :exit nil)
  ("c" neotree-create-node :exit t)
  ("r" neotree-rename-node :exit t)
  ("R" neotree-change-root :exit t)
  ("SPC" avy-goto-char)
  ("q" neotree-hide :exit t)
  ;; ("q" nil "cancel")
  ("<escape>" nil "cancel")
)
;;==============================
)

(provide 'init-navigation)
