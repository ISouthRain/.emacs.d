;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; lsp-mode
(use-package lsp-mode
    :defer 3
    :ensure t
    :hook (python-mode . lsp-deferred)
    :commands (lsp lsp-deferred)
:config
(setq lsp-session-file (expand-file-name "emacs/.lsp-session-v1" user-emacs-directory))
;;=============================================
;; LSP
(defhydra hydra-lsp-mode (:color pink
                  :hint nil
                  :foreign-keys warn ;; 不要使用hydra以外的键
				     )
"
_rn_: Rename
_ft_: Allows  _ff_: Fold
"
  ("rn" lsp-rename :exit t)
  ("ft" origami-toggle-all-nodes :exit t)
  ("ff" origami-recursively-toggle-node :exit t)
  ;; (""  :exit t)
  ("q" nil "cancel")
  ("<escape>" nil "cancel")
)
;;=============================================
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; origami 代码折叠
(use-package origami
  :ensure t
  :defer 6)

(provide 'init-lsp)