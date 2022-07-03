;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; lsp-pyright
(use-package lsp-pyright
  :defer 3
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp)))
  :config
(defun RunPython ()
  (interactive) ; 如果不需要定义成命令，这句可以不要。
  (shell-command (format "python %s.py" (file-name-base (buffer-file-name))))
)
)  ; or lsp-deferred

(provide 'init-python)