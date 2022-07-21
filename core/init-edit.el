;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; projectile 项目交互
(use-package projectile
  :defer 4
  :ensure t
  (setq projectile-cache-file (expand-file-name "emacs/projectile.cache" user-emacs-directory))
  (setq projectile-known-projects-file (expand-file-name "emacs/projectile-bookmarks.eld" user-emacs-directory))
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; flyspell 拼写检查
;; ;; On-the-fly spell checker
;; (use-package flyspell
;;   :ensure nil
;;   :diminish
;;   :if (executable-find "aspell")
;;   :hook (((text-mode outline-mode) . flyspell-mode)
;;          (prog-mode . flyspell-prog-mode)
;;          (flyspell-mode . (lambda ()
;;                             (dolist (key '("C-;" "C-," "C-."))
;;                               (unbind-key key flyspell-mode-map)))))
;;   :init (setq flyspell-issue-message-flag nil
;;               ispell-program-name "aspell"
;;               ispell-extra-args '("--sug-mode=ultra" "--lang=en_US" "--run-together"))
;;   :config
;;   ;; Correcting words with flyspell via Ivy
;;   (use-package flyspell-correct-ivy
;;     :ensure t
;;     :after ivy
;;     :bind (:map flyspell-mode-map
;;            ([remap flyspell-correct-word-before-point] . flyspell-correct-wrapper))
;;     :init (setq flyspell-correct-interface #'flyspell-correct-ivy)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; yasnippet 补全
(use-package yasnippet
:defer 2
:ensure nil
:load-path "~/.emacs.d/core/plugins"
:hook (prog-mode . yas-minor-mode)
:config
(yas-global-mode 1)
(yas-reload-all)
;; (add-hook 'prog-mode-hook #'yas-minor-mode)
(setq yas-snippet-dirs
      '(
        ;; (expand-file-name "snippets" user-emacs-directory)                 ;; personal
       "~/.emacs.d/snippets"
        ))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; elec-pair 自动补全括号
(use-package elec-pair
  :defer 3
  :ensure nil
  :hook (after-init . electric-pair-mode)
  :init (setq electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; indent-guide
;(use-package indent-guide
;:defer 3
;:ensure nil
;:load-path "~/.emacs.d/core/plugins"
;:config
;(indent-guide-global-mode)
;(setq indent-guide-delay 0.1)
;(setq indent-guide-char "|")
;(setq indent-guide-recursive t)
;(set-face-background 'indent-guide-face "#6F817F")
;)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; undo-fu
(use-package undo-fu
:defer 1
:ensure nil
:load-path "~/.emacs.d/core/plugins"
:init
(setq evil-undo-system 'undo-fu)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; workgroups2 保存当前编辑的缓存区，下次直接打开，光标位置也会保持
;; 命令使用 wg-****
(use-package workgroups2
:ensure t
:defer 4
:config
(workgroups-mode 1)
(setq wg-session-file "~/.emacs.d/emacs/.emacs_workgroups")
;; ;; 支持的buffer
;; (with-eval-after-load 'workgroups2
;;   ;; provide major mode, package to require, and functions
;;   (wg-support 'ivy-occur-grep-mode 'ivy
;;               `((serialize . ,(lambda (_buffer)
;;                                 (list (base64-encode-string (buffer-string) t))))
;;                 (deserialize . ,(lambda (buffer _vars)
;;                                   (switch-to-buffer (wg-buf-name buffer))
;;                                   (insert (base64-decode-string (nth 0 _vars)))
;;                                   ;; easier than `ivy-occur-grep-mode' to set up
;;                                   (grep-mode)
;;                                   ;; need return current buffer at the end of function
                                  ;; (current-buffer))))))

;;=============================================
;; workgroups2 保存当前编辑的缓存区，下次直接打开，光标位置也会保持
(defhydra hydra-workgroups2 (:color pink
                  :hint nil
                  :foreign-keys warn ;; 不要使用hydra以外的键
				     )
"
_c_: Create  _o_: Open  _k_: Kill
_r_: Restore
"
  ("c" wg-create-workgroup :exit t)
  ("o" wg-open-workgroup :exit t)
  ("k" wg-kill-workgroup :exit t)
  ("r" wg-restore-frames :exit t)
  ("q" nil "cancel")
  ("<escape>" nil "cancel")
)
;; =============================================
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; rainbow-delimiters 彩虹括号
(use-package rainbow-delimiters
:defer 2
:ensure t
:hook (prog-mode . rainbow-delimiters-mode)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; linum-relative 相对行号
(use-package linum-relative
:defer 3
:ensure nil
:load-path "~/.emacs.d/core/plugins"
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; bm 标记文件
(use-package bm
:ensure t
;; :defer 2
:init
;; 加载时恢复（甚至在您需要 bm 之前）
(setq-default bm-buffer-persistence t)
:config
;; 在哪里存储持久文件
(setq bm-repository-file "~/.emacs.d/emacs/bm-repository")
;; save bookmarks
(setq-default bm-buffer-persistence t)
;; 启动时从文件加载存储库
(add-hook 'after-init-hook 'bm-repository-load)
;; Saving Boomarks
(add-hook 'kill-buffer-hook #'bm-buffer-save)
;; 退出时将存储库保存到文件。
;; 杀死 Emacs 时不会调用 kill-buffer-hook，所以我们
;; 必须先保存所有书签。
(add-hook 'kill-emacs-hook #'(lambda nil
    (bm-buffer-save-all)
    (bm-repository-save)))

;; 不需要使用 `after-save-hook' 来实现持久性，
;; 但它使存储库中的书签数据与文件更加同步
;; 状态。
(add-hook 'after-save-hook #'bm-buffer-save)
;; 恢复书签
(add-hook 'find-file-hooks   #'bm-buffer-restore)
(add-hook 'after-revert-hook #'bm-buffer-restore)
(add-hook 'vc-before-checkin-hook #'bm-buffer-save)


;;=============================================
;; bm 插件
(defhydra hydra-bm (:color pink
                              :hint nil
                              :foreign-keys warn ;; 不要使用hydra以外的键
				     )
"
_j_: 下一个  _k_: 上一个        _m_: 标记
_s_: 查看当前文件的标记       _v_: 查看所有文件的标记
_r_: 重载当前文件的标记
"
  ("j" bm-next  :exit nil)
  ("k" bm-previous  :exit nil)
  ("m" bm-toggle  :exit t)
  ("s" bm-show  :exit t)
  ("v" bm-show-all  :exit t)
  ("r" bm-buffer-restore  :exit nil)
;;   (""  "" :exit nil)
;;   (""  "" :exit nil)
  ("q" nil "cancel")
  ("<escape>" nil "cancel")
)
;;=============================================

)

(provide 'init-edit)
