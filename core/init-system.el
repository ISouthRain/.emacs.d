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
;; (setq default-buffer-file-coding-system 'utf-8)
;; (prefer-coding-system 'utf-8)
(set-language-environment 'Chinese-GB) ;; 设置为中文简体语言环境
(set-keyboard-coding-system 'utf-8)    ;; 设置键盘输入时的字符编码

;; set coding config, last is highest priority.
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Recognize-Coding.html#Recognize-Coding
(prefer-coding-system 'cp950)
(prefer-coding-system 'gb2312)
(prefer-coding-system 'cp936)
(prefer-coding-system 'gb18030)
(prefer-coding-system 'utf-16)
(prefer-coding-system 'utf-8-dos)
(prefer-coding-system 'utf-8-unix)
;; 文件默认保存为 utf-8
(set-buffer-file-coding-system 'utf-8-unix)
(set-default buffer-file-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
;; 解决文件目录的中文名乱码
(setq-default pathname-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)

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
