;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 中国日历
(setq freedom-calendar-chinese t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Network proxy
(setq freedom-proxy-enable t)
(setq freedom-proxy "127.0.0.1:7890")
(setq freedom-socks-proxy "127.0.0.1:7891")
(setq freedom-user-email-address "874424374@qq.com")
(setq freedom-reply-email-address "isouthrain@gmail.com")
(when freedom/is-linux
  (setq freedom-agenda-dir "~/MyFile/Org/GTD"))
(when freedom/is-windows
  (setq freedom-agenda-dir "F:\\MyFile\\Orf\\GTD"))
(when freedom/is-darwin
  (setq freedom-agenda-dir "~/Desktop/MyFile/Org/GTD"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 自定义目录
(setq recentf-save-file (expand-file-name "emacs/recentf" user-emacs-directory))
(setq prescient-save-file (expand-file-name "emacs/var/prescient-save.el" user-emacs-directory))
(setq bookmark-file (expand-file-name "emacs/bookmarks" user-emacs-directory))
(setq org-id-locations-file (expand-file-name "emacs/.org-id-locations" user-emacs-directory))
(setq eww-bookmarks-directory (expand-file-name "emacs/" user-emacs-directory))
(setq eww-download-directory (expand-file-name "emacs/Eww-Download" user-emacs-directory))
(setq url-history-file (expand-file-name "emacs/url/history" user-emacs-directory))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Courier New" :foundry "outline" :slant normal :weight normal :height 129 :width normal))))
 '(hl-todo ((t (:inherit default :height 0.9 :width condensed :weight bold :underline nil :inverse-video t))))
 '(pulse-highlight-face ((t (:inherit region))))
 '(pulse-highlight-start-face ((t (:inherit region))))
 '(symbol-overlay-default-face ((t (:inherit (region bold))))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(rime quelpa-use-package ement pyim-basedict pyim zoom workgroups2 which-key vertico use-package solarized-theme rainbow-delimiters pretty-hydra posframe popper ox-hugo origami org-roam-ui org-download org-cliplink orderless neotree markdown-toc lsp-mode htmlize go-translate general evil-nerd-commenter evil-escape evil-collection emojify elfeed-org doom-modeline diff-hl dashboard consult company-prescient cnfonts bm avy all-the-icons)))
