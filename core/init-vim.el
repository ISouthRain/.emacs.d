(use-package vimrc-mode
  :ensure nil
  :load-path "~/.emacs.d/core/plugins/"
  :config
 (add-to-list 'auto-mode-alist '("\\.vim\\(rc\\)?\\'" . vimrc-mode)))

(provide 'init-vim)
