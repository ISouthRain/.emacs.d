;; ;; 不同用户使用不同的配置
;; (when (string= system-name "Jack")
;; )

;; ;; 区分 tui 还是 gui
;; (when (string= "w32" window-system) ;; w32 ns pc x nil
;; ;; (message "这是GUI方法")
;; )

;; ;; 上面方法可能不太好用
;; (if (display-graphic-p)
;;     ;; GUI 代码放置，多行代码的话用 (progn) 包一下
;;     (progn (message "这是GUI方法1")
;;            (message "这是GUI方法2")
;; 	   )
;;     ;; TUI 代码放置
;;     (message "这是TUI 1")
;;     (message "这是TUI 2")
;;     )

;; 设置编码
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)


;; 系统区分
(use-package subr-x
:ensure nil
:config
(setq freedom/is-termux
      (string-suffix-p "Android" (string-trim (shell-command-to-string "uname -a"))))
(setq freedom/is-linux (and (eq system-type 'gnu/linux)))
(setq freedom/is-darwin (and (eq system-type 'darwin)))
(setq freedom/is-windows (and (eq system-type 'windows-nt)))
)
;; 关闭 native-comp 错误警告
;; Silence compiler warnings as they can be pretty disruptive
(setq comp-async-report-warnings-errors nil)

(provide 'init-system)
