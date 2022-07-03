
;; 设置Emacs标题
(setq frame-title-format '("Happy Emacs - %b")
      icon-title-format frame-title-format)
;; 光标闪烁
(setq blink-cursor-mode nil)
;; 显示电池
(if (display-graphic-p)
    (display-battery-mode 1))
;;显示行号
;; (global-linum-mode 1)
;; 相对行号
;; (linum-relative-global-mode t)
;; 空格代替制表符缩进
(setq-default indent-tabs-mode nil)
;;高亮当前行
(global-hl-line-mode 1)
;;关闭启动画面
(setq inhibit-startup-message t)
;;自动换行
;;(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))
(setq toggle-truncate-lines t)

;;显示时间
(display-time-mode 1) ;; 常显
(setq display-time-24hr-format t) ;;格式
(setq display-time-day-and-date t) ;;显示时间、星期、日期


;; 关闭启动帮助画面
(setq inhibit-splash-screen 1)

;; 关闭备份文件
(setq make-backup-files nil)

;; 自动加载外部修改的文件
(global-auto-revert-mode 1)

;; 关闭自动保存文件
(setq auto-save-default nil)

;; 关闭警告声
(setq ring-bell-function 'ignore)

;; 简化yes和no
(fset 'yes-or-no-p 'y-or-n-p)

;;隐藏菜单栏工具栏滚动条
(menu-bar-mode 0)
(when freedom/is-linux
  (when (not freedom/is-termux)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(tooltip-mode 0) 
(set-face-attribute 'default nil :height 150)
    ))
(when (string= "windows-nt" system-type)
(tool-bar-mode 0)
;; 滚动条
(scroll-bar-mode 0)
(tooltip-mode 0) 
)
(when (string= "darwin" system-type)
(tool-bar-mode 1)
(menu-bar-mode 1)
)

(when (string= "windows-nt" system-type)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Courier New" :foundry "outline" :slant normal :weight normal :height 129 :width normal)))))
)
(when (string= "darwin" system-type)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Courier New" :foundry "outline" :slant normal :weight normal :height 195 :width normal)))))
)


;; 自己的配置文件
(defun myconfig ()
  (interactive) ; 如果不需要定义成命令，这句可以不要。
  (find-file (expand-file-name "init.el" user-emacs-directory))
  )

(provide 'init-basic)
