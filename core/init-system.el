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
(defun freedom/sudo-this-file ()
  "Open the current file as root."
  (interactive)
  (find-file
   (freedom--sudo-file-path
    (or buffer-file-name
        (when (or (derived-mode-p 'dired-mode)
                  (derived-mode-p 'wdired-mode))
          default-directory)))))
(defun freedom--sudo-file-path (file)
  (let ((host (or (file-remote-p file 'host) "localhost")))
    (concat "/" (when (file-remote-p file)
                  (concat (file-remote-p file 'method) ":"
                          (if-let (user (file-remote-p file 'user))
                              (concat user "@" host)
                            host)
                          "|"))
            "sudo:root@" host
            ":" (or (file-remote-p file 'localname)
                    file))))
(when freedom/is-termux
(setq url-proxy-services
        `(("http" . "127.0.0.1:7890")
          ("https" . "127.0.0.1:7890"))
          ("socks5" . "127.0.0.1:7891")))

(provide 'init-system)
