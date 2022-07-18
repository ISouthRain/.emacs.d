;; 设置编码
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 设置 deamon 乱码
(when (eq system-type 'windows-nt)
  (setq locale-coding-system 'gb18030)  ;此句保证中文字体设置有效
  (setq w32-unicode-filenames 'nil)       ; 确保file-name-coding-system变量的设置不会无效
  (setq file-name-coding-system 'gb18030) ; 设置文件名的编码为gb18030
  )
(require 'subr-x)
(setq freedom/is-termux
      (string-suffix-p "Android" (string-trim (shell-command-to-string "uname -a"))))
(setq freedom/is-linux (and (eq system-type 'gnu/linux)))
(setq freedom/is-darwin (and (eq system-type 'darwin)))
(setq freedom/is-windows (and (eq system-type 'windows-nt)))
(setq freedom/is-gui (if (display-graphic-p) t))
(setq freedom/is-tui (not (display-graphic-p)))


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

(provide 'init-system)
