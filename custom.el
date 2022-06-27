;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 中国日历
(setq freedom-calendar-chinese t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Network proxy
(setq freedom-proxy-enable t)
(setq freedom-proxy "127.0.0.1:7890")
(setq freedom-socks-proxy "127.0.0.1:7891")


;; 自定义目录
(setq recentf-save-file (expand-file-name "emacs/recentf" user-emacs-directory))
(setq prescient-save-file (expand-file-name "emacs/var/prescient-save.el" user-emacs-directory))
(setq bookmark-file (expand-file-name "emacs/bookmarks" user-emacs-directory))
(setq org-id-locations-file (expand-file-name "emacs/.org-id-locations" user-emacs-directory))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Courier New" :foundry "outline" :slant normal :weight normal :height 129 :width normal))))
 '(hl-todo ((t (:inherit default :height 0.9 :width condensed :weight bold :underline nil :inverse-video t))))
 '(popup-tip-face ((t (:background "gray12" :foreground "green"))))
 '(pulse-highlight-face ((t (:inherit region))))
 '(pulse-highlight-start-face ((t (:inherit region))))
 '(symbol-overlay-default-face ((t (:inherit (region bold))))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(use-package)))
