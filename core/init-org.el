;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org 标题加密， 只需添加 :crypt:
(use-package org-crypt
  :defer 4
  :ensure nil
  :config
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance '("crypt"))
;; GPG ID, 解密一个文件可以知道这个ID
;; (setq org-crypt-key "0EF4E70FDD97880B")
(setq org-crypt-key "885AC4F89BA7A3F8")
(setq auto-save-default nil)
;; 解决 ^M 解密问题
(defun freedom/org-decrypt-entry ()
  "Replace DOS eolns CR LF with Unix eolns CR"
  (interactive)
  (goto-char (point-min))
    (while (search-forward "\r" nil t) (replace-match ""))
  (org-decrypt-entry))
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ox-hugo 导出 hugo
(use-package ox-hugo
  :ensure t
  :defer 4
  :after ox)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 美化所有
(use-package org-modern
  :defer 3
  :ensure nil
  :load-path "~/.emacs.d/core/plugins"
  :hook '((org-mode . org-modern-mode)
          (org-agenda-finalize . org-modern-agenda)
          (org-modern-mode . (lambda ()
                                    "Adapt `org-modern-mode'."
                                    ;; Disable Prettify Symbols mode
                                    (setq prettify-symbols-alist nil)
                                    (prettify-symbols-mode -1))))
  :config
  (setq org-modern-star '("◉""○""◈""◇""✿""✤""✸""⁕""⚙""▷")
        org-agenda-current "⭠ now ─────────────────────────────────────────────────")
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-fancy-priorities 设置事件优先级
(use-package org-fancy-priorities
  :defer 3
  :ensure nil
  :load-path "~/.emacs.d/core/plugins"
  :hook
  (org-mode . org-fancy-priorities-mode)
  :config
  ;; (setq org-fancy-priorities-list '((?A . "❗")
  (setq org-fancy-priorities-list '((?A . "❕")
                                  (?B . "⬆")
                                  (?C . "⬇")
                                  (?D . "☕")
                                  (?1 . "⚡")
                                  (?2 . "⮬")
                                  (?3 . "⮮")
                                  (?4 . "☕")
                                  (?I . "Important"))) 
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-superstar 美化标题，表格，列表 之类的
(use-package org-superstar
  :defer 3
  :ensure nil
  :load-path "~/.emacs.d/core/plugins"
  :hook (org-mode . org-superstar-mode)
  :init (setq org-superstar-headline-bullets-list '("◉""○""◈""◇""✿""✤""✸""⁕""⚙""▷")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; deft 查找目录下的文件
(use-package deft
  :defer 3
  :ensure nil
  :load-path "~/.emacs.d/core/plugins"
  :config
  (setq deft-recursive t)
  (setq deft-use-filename-as-title t)
  (setq deft-extensions '("txt" "tex" "org" "gpg"))
  (when freedom/is-windows
  (setq deft-directory "F:\\MyFile\\Org"))
  (when freedom/is-darwin
  (setq deft-directory "~/Desktop/MyFile/Org"))
  (when freedom/is-linux
  (setq deft-directory "~/MyFile/Org"))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-roam
(when (executable-find "gcc")
(use-package org-roam
  :defer 3
  :ensure t
  :init
  (when (string= "windows-nt" system-type)
  (setq org-roam-directory (file-truename "F:\\MyFile\\Org")))
  (when (string= "gnu/linux" system-type)
  (setq org-roam-directory (file-truename "~/MyFile/Org/")))
  (when (string= "darwin" system-type)
  (setq org-roam-directory (file-truename "~/Desktop/MyFile/Org/")))
  :config
(defun org-roam-db-sync-myself ()
  (interactive) ; 如果不需要定义成命令，这句可以不要。
(when (string= "gnu/linux" system-type)
  (shell-command "rm ~/.emacs.d/org-roam.db")
)
(when (string= "darwin" system-type)
  (shell-command "rm ~/.emacs.d/org-roam.db")
)
(when (string= "windows-nt" system-type)
  (shell-command "del C:\\Users\\Jack\\AppData\\Roaming\\.emacs.d\\org-roam.db")
)
  (org-roam-db-sync)
)

(require 'org-roam-protocol)
  ;;搜索
(setq org-roam-node-display-template "${title}")

;;补全
(setq org-roam-completion-everywhere t)

;;一个也可以设置org-roam-db-node-include-function。例如，ATTACH要从 Org-roam 数据库中排除所有带有标签的标题，可以设置：
(setq org-roam-db-node-include-function 
      (lambda () 
        (not (member "ATTACH" (org-get-tags)))))

(setq org-roam-db-update-on-save t)

(setq org-roam-db-gc-threshold most-positive-fixnum)

;; 创建左边显示子目录分类
(cl-defmethod org-roam-node-type ((node org-roam-node))
  "Return the TYPE of NODE."
  (condition-case nil
      (file-name-nondirectory
       (directory-file-name
        (file-name-directory
         (file-relative-name (org-roam-node-file node) org-roam-directory))))
    (error "")))

(setq org-roam-node-display-template
      (concat "${type:15} ${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
(org-roam-db-autosync-mode)
(setq org-roam-database-connector 'sqlite)
;; (setq org-roam-capture-templates '(
;;                                    ("d" "default" plain
;;                                     "%?"
;;                                     :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
;;                                                        "#+title: ${title}\n"
;;                                     :unnarrowed t) )))
(setq org-roam-capture-templates '(
                                   ("d" "default" plain
                                    "%?"
                                    :target (file+head "${slug}.org.gpg"
                                                       "#+title: ${title}\n")
                                    :unnarrowed t)))

;;=============================================
;; org-roam
(defhydra hydra-org-roam (:color pink
                          :hint nil
                          :foreign-keys warn ;; 不要使用hydra以外的键
				     )
"
_f_: node find  _i_: node insert
_c_: capture    _b_: buffer toggle
_u_: ui         _s_: node sync
_g_: id create  _t_: add tags
_d_: deft
"
  ("f" org-roam-node-find :exit t)
  ("i" org-roam-node-insert :exit t)
  ("c" org-roam-capture :exit t)
  ("b" org-roam-buffer-toggle :exit t)
  ("u" org-roam-ui-mode :exit t)
  ("s" org-roam-db-sync-myself :exit t)
  ("g" org-id-get-create :exit t)
  ("t" org-roam-tag-add :exit t)
  ("d" deft :exit t)
  ;; (""  :exit t)
  ("q" nil "cancel")
  ("<escape>" nil "cancel")
)
;;=============================================
);; use-package
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; websocket
(use-package websocket
:ensure t
:defer 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; simple-httpd
(use-package simple-httpd
:ensure t
:defer 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-roam-ui
(use-package org-roam-ui
:ensure t
:config
(setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t)

)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-download
(use-package org-download
:defer 4
:ensure t
:config
;; (require 'org-download)
;; Drag-and-drop to `dired`
(add-hook 'dired-mode-hook 'org-download-enable)
(setq org-download-heading-lvl nil)
;; 文件目录
;;(setq-default org-download-image-dir "Attachment")
(defun my-org-download--dir-1 ()
    (or org-download-image-dir (concat "./Attachment/" (file-name-nondirectory (file-name-sans-extension (buffer-file-name))) )))

  (advice-add #'org-download--dir-1 :override #'my-org-download--dir-1)

(defhydra hydra-org-download (:color pink
                              :hint nil
                              :foreign-keys warn ;; 不要使用hydra以外的键
			      )
"
_y_: 从 链接      _e_: 编辑  _c_: 从 剪贴板
_i_: 选择路径图片  _d_: 删除  _s_: 截图
"
  ("y" org-download-yank :exit t)
  ("e" org-download-edit :exit t)
  ("i" org-download-image :exit t)
  ("d" org-download-delete :exit t)
  ("s" org-download-screenshot :exit t)
  ("c" org-download-clipboard :exit t)
  ("q" nil "cancel")
  ("<escape>" nil "cancel")
)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-cliplink 提取链接标题
(use-package org-cliplink
:ensure t
:defer 2
:config
(defun custom-org-cliplink ()
  (interactive)
  (org-cliplink-insert-transformed-title
   (org-cliplink-clipboard-content)     ;take the URL from the CLIPBOARD
   (lambda (url title)
     (let* ((parsed-url (url-generic-parse-url url)) ;parse the url
            (clean-title
             (cond
              ;; if the host is github.com, cleanup the title
              ((string= (url-host parsed-url) "github.com")
               (replace-regexp-in-string "GitHub - .*: \\(.*\\)" "\\1" title))
              ;; otherwise keep the original title
              (t title))))
       ;; forward the title to the default org-cliplink transformer
       (org-cliplink-org-mode-link-transformer url clean-title)))))
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-appear 自动展开链接显示
(use-package org-appear
:ensure nil
:defer 2
:load-path "~/.emacs.d/core/plugins"
:hook (org-mode . org-appear-mode)
:config
;; 链接自动展开, 以及光标停留多少秒才展开
(setq org-appear-autolinks t)
(setq org-appear-delay 1)

(setq org-appear-autosubmarkers t)
(setq org-appear-autoentities t)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org Basic configuration
(use-package org
:ensure nil
:defer 3
:config
;;Windows系统日历乱码
(setq system-time-locale "C")
(format-time-string "%Y-%m-%d %a")
;;自动换行
(add-hook 'org-mode-hook 'toggle-truncate-lines)
;;设置打开某类文件为org模式
;;(add-to-list 'auto-mode-alist '("\\.txt\\" . org-mode))
;; 当它们处于某种DONE状态时，不要在议程中显示计划的项目。
(setq org-agenda-skip-scheduled-if-done t)
;; 记录任务状态变化,可能会记录对任务状态的更改，尤其是对于重复例程。如果是这样，请将它们记录在抽屉中，而不是笔记的内容。
(setq org-log-state-notes-into-drawer t )
;; 打开 org 文件 默认将 列表折叠
(setq org-cycle-include-plain-lists 'integrate)
;; 隐藏语法符号 例如: *粗体* , * 符号会被隐藏
(setq-default org-hide-emphasis-markers t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;代码块高亮
(setq org-src-fontify-natively t)
;;不自动tab
(setq org-src-tab-acts-natively nil)
;; 直接运行语言支持
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org 图片设置
;;打开Org文件自动显示图片
(setq org-startup-with-inline-images t)
;;图片显示1/3尺寸
(setq org-image-actual-width (/ (display-pixel-width) 3))
;;图片显示 300 高度，如果图片小于 300，会被拉伸。
(setq org-image-actual-width '(500))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 字体格式化-颜色调整
(defface my-org-emphasis-bold
  '((default :inherit bold)
    (((class color) (min-colors 88) (background light))
     :foreground "#a60000")
    (((class color) (min-colors 88) (background dark))
     :foreground "#ff8059"))
  "My bold emphasis for Org.")

(defface my-org-emphasis-italic
  '((default :inherit italic)
    (((class color) (min-colors 88) (background light))
     :foreground "#005e00")
    (((class color) (min-colors 88) (background dark))
     :foreground "#44BCAB"))
  "My italic emphasis for Org.")

(defface my-org-emphasis-underline
  '((default :inherit underline)
    (((class color) (min-colors 88) (background light))
     :foreground "#813e00")
    (((class color) (min-colors 88) (background dark))
     :foreground "#d0bc00"))
  "My underline emphasis for Org.")

(defface my-org-emphasis-strike-through
  '((((class color) (min-colors 88) (background light))
     :strike-through "#972500" :foreground "#505050")
    (((class color) (min-colors 88) (background dark))
     :strike-through "#ef8b50" :foreground "#a8a8a8"))
  "My strike-through emphasis for Org.")

(setq org-emphasis-alist
      '(("*" my-org-emphasis-bold)
        ("/" my-org-emphasis-italic)
        ("_" my-org-emphasis-underline)
        ("=" org-verbatim verbatim)
        ("~" org-code verbatim)
        ("+" (my-org-emphasis-strike-through :strike-through t))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;默认笔记路径
(when (string= "gnu/linux" system-type)
(setq org-default-notes-file "~/MyFile/Org/Note.org")
)
(when (string= "darwin" system-type)
(setq org-default-notes-file "~/Desktop/MyFile/Org/Note.org")
)
(when (string= "windows-nt" system-type)
(setq org-default-notes-file "F:\\MyFile\\Org\\Note.org")
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TODO Configuration
;; 设置任务流程(这是我的配置)
(setq org-todo-keywords
      '((sequence "TODO(t)" "DOING(i)" "HANGUP(h)" "|" "DONE(d)" "CANCEL(c)")
        (sequence "🚩(T)" "🏴(I)" "❓(H)" "|" "✔(D)" "✘(C)"))
      org-todo-keyword-faces '(("HANGUP" . warning)
                                 ("❓" . warning))
      org-priority-faces '((?A . error)
                             (?B . warning)
                             (?C . success))
      )
;; 设置任务样式
;; (setq org-todo-keyword-faces
;;    '(("未开始" .   (:foreground "red" :weight bold))
;;     ("阻塞中" .   (:foreground "red" :weight bold))
;;     ("进行中" .      (:foreground "orange" :weight bold))
;;     ("已完成" .      (:foreground "green" :weight bold))
;;     ("已取消" .     (:background "gray" :foreground "#72DBB8"))
;; ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Agenda Soure File
(when (string= "gnu/linux" system-type)
(setq org-agenda-files (list
       		             "~/MyFile/Org/GTD"
			     ))
)
(when (string= "darwin" system-type)
(setq org-agenda-files (list
       		             "~/Desktop/MyFile/Org/GTD"
			     ))
)
(when (string= "windows-nt" system-type)
(setq org-agenda-files (list
       		             "F:\\MyFile\\Org\\GTD"
			     ))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org 通知设置
;; ;; 让Emacs通知
;; (require 'appt)
;; ;; 每小时同步一次appt,并且现在就开始同步
;; (run-at-time nil 3600 'org-agenda-to-appt)
;; ;; 更新agenda时，同步appt
;; (add-hook 'org-finalize-agenda-hook 'org-agenda-to-appt)
;; ;; 激活提醒
;; (appt-activate 1)
;; ;; 提前半小时提醒
;; (setq appt-message-warning-time 1)
;; (setq appt-audible t)
;; ;;提醒间隔
;; (setq appt-display-interval 30)
;; (require 'notifications)
;; (defun appt-disp-window-and-notification (min-to-appt current-time appt-msg)
;;   (let ((title (format "%s分钟内有新的任务" min-to-appt)))
;;     (notifications-notify :timeout (* appt-display-interval 60000) ;一直持续到下一次提醒
;;                           :title title
;;                           :body appt-msg
;;                           )
;;     (appt-disp-window min-to-appt current-time appt-msg))) ;同时也调用原有的提醒函数
;; (setq appt-display-format 'window) ;; 只有这样才能使用自定义的通知函数
;; (setq appt-disp-window-function #'appt-disp-window-and-notification)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; hydra-my-config-org-syntax
(defhydra hydra-my-config-org-syntax (:color pink
                                           :hint nil
                                           :foreign-keys warn ;; 不要使用hydra以外的键
					   )
"
_ct_: 粗体          _xt_: 斜体        _cxt_: 粗斜体
_t_: 当前日期时间   _T_: 日期
_k_: 块             _K_: 代码块
_sc_: 删除线        _xh_: 下划线      _fg_: 分隔线
_lj_: 内部链接      _wlj_: 外链接
_yy_: 引用          _yt_: 嵌套引用
_1_: 标题-1         _2_: 标题-2       _3_: 标题-3
_4_: 标题-4         _5_: 标题-5       _6_: 标题-6
_jz_: 脚注          _id_: org id
_bgz_: 表格居中     _bgy_: 表格居右   _bgt_: 表格居左
"
  ("ct" (lambda ()
	 (interactive)
         ;;(insert &rest ARGS)
         (insert " ** <++>")
         ;; (backward-char &optional N)
         (backward-char 6))
	:exit t)
  ("xt" (lambda ()
	 (interactive)
         ;;(insert &rest ARGS)
         (insert " // <++>")
         ;; (backward-char &optional N)
         (backward-char 6))
	:exit t)
  ("cxt" (lambda ()
	 (interactive)
         ;;(insert &rest ARGS)
         (insert " **//** <++>")
         ;; (backward-char &optional N)
         (backward-char 8))
	:exit t)
  ("t" (lambda ()
	 (interactive)
         ;;(insert &rest ARGS)
	 (insert (format-time-string "%Y-%m-%d %H:%M:%S")))
	:exit t)
  ("T" (lambda ()
	 (interactive)
         ;;(insert &rest ARGS)
	 (insert (format-time-string "%Y-%m-%d")))
	:exit t)
  ("k" (lambda ()
	 (interactive)
         ;;(insert &rest ARGS)
         ;; (insert "#+BEGIN_EXAMPLE#+END_EXAMPLE<++>")
	 (insert "#+BEGIN_EXAMPLE ")
	 (newline)
	 (insert "#+END_EXAMPLE<++>")
         ;; (backward-char &optional N)
         (backward-char 18))
	:exit t)
  ("K" (lambda ()
	 (interactive)
         ;;(insert &rest ARGS)
         ;; (insert "#+BEGIN_SRC #+END_SRC <++>")
	 (insert "#+BEGIN_SRC ")
	 (newline)
         ;; (backward-char &optional N)
	 (insert "#+END_SRC<++>")
         (backward-char 14))
	:exit t)
  ("sc" (lambda ()
	 (interactive)
         ;;(insert &rest ARGS)
         (insert " ++ <++>")
         ;; (backward-char &optional N)
         (backward-char 6))
	:exit t)
  ("xh" (lambda ()
	 (interactive)
         ;;(insert &rest ARGS)
         (insert " __ <++>")
         ;; (backward-char &optional N)
         (backward-char 6))
	:exit t)
  ("lj" (lambda ()
	 (interactive)
         ;;(insert &rest ARGS)
         (insert " [[]] <++>")
         ;; (backward-char &optional N)
         (backward-char 7))
	:exit t)
  ("wlj" (lambda ()
	 (interactive)
         ;;(insert &rest ARGS)
         (insert " [[][<++>]] <++>")
         ;; (backward-char &optional N)
         (backward-char 13))
	:exit t)
  ("yy" (lambda ()
	 (interactive)
         ;;(insert &rest ARGS)
         ;; (insert "#+BEGIN_QUOTE#+END_QUOTE<++>")
	 (insert "#+BEGIN_QUOTE ")
	 (newline)
	 (insert "#+END_QUOTE<++>")
         (backward-char 16))
	:exit t)
  ("yt" (lambda ()
	 (interactive)
         ;;(insert &rest ARGS)
         (insert ">> "))
	:exit t)
  ("1" (lambda ()
	 (interactive)
         ;;(insert &rest ARGS)
         (insert "* "))
	:exit t)
  ("2" (lambda ()
	 (interactive)
         ;;(insert &rest ARGS)
         (insert "** "))
	:exit t)
  ("3" (lambda ()
	 (interactive)
         ;;(insert &rest ARGS)
         (insert "*** "))
	:exit t)
  ("4" (lambda ()
	 (interactive)
         ;;(insert &rest ARGS)
         (insert "**** "))
	:exit t)
  ("5" (lambda ()
	 (interactive)
         ;;(insert &rest ARGS)
         (insert "***** "))
	:exit t)
  ("6" (lambda ()
	 (interactive)
         ;;(insert &rest ARGS)
         (insert "****** "))
	:exit t)
  ("fg" (lambda ()
	 (interactive)
         ;;(insert &rest ARGS)
         (insert "----"))
	:exit t)
  ("jz" (lambda ()
	 (interactive)
         ;;(insert &rest ARGS)
         (insert " [^] <++>")
         ;; (backward-char &optional N)
         (backward-char 6))
	:exit t)
  ("bgz" (lambda ()
	 (interactive)
         ;;(insert &rest ARGS)
         (insert " :-: "))
	:exit t)
  ("bgy" (lambda ()
	 (interactive)
         ;;(insert &rest ARGS)
         (insert " -: "))
	:exit t)
  ("bgt" (lambda ()
	 (interactive)
         ;;(insert &rest ARGS)
         (insert " :- "))
	:exit t)
  ("id" org-id-get-create :exit t)	
  ("q" nil "cancel")
  ("<escape>" nil "cancel")
  )
)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-protocol-capture-html Capture Configuration
(use-package org-protocol-capture-html
:ensure nil
:load-path "~/.emacs.d/core/plugins"
:defer 3
:after s
:config
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-protocol-capture-html Capture Configuration Linux
(defun org-web-tools-insert-link-for-clipboard-url ()
  "Extend =org-web-tools-inster-link-for-url= to take URL from clipboard or kill-ring"
  (interactive)
  (org-web-tools--org-link-for-url (org-web-tools--get-first-url)))
(when (string= "gnu/linux" system-type)
(setq org-capture-templates
      '(
	;;TODO
	;; ("t" "Todo" entry (file+headline "~/MyFile/Org/GTD/Todo.org" "2022年6月")
	("t" "Todo" plain (file+function "~/MyFile/Org/GTD/Todo.org" find-month-tree)
         "*** TODO %^{想做什么？}\n  :时间: %^T\n  %?\n  %i\n"  :kill-buffer t :immediate-finish t)
	 
	;;日志
        ("j" "Journal" entry (file+datetree "~/MyFile/Org/Journal.org")
         "* %^{记些什么} %?\n  %i\n" :kill-buffer t :immediate-finish t)
	 
	 ;;日程安排
	("a" "日程安排" plain (file+function "~/MyFile/Org/GTD/Agenda.org" find-month-tree)
	 "*** [#%^{优先级}] %^{安排} \n SCHEDULED: %^T \n  :地点: %^{地点}\n" :kill-buffer t :immediate-finish t)
	 
	 ;;笔记
        ;; ("n" "笔记" entry (file+headline "~/MyFile/Org/Note.org" "2022年6月")
        ("n" "笔记" entry (file+headline "~/MyFile/Org/Note.org" "Note.org")
	 "* %^{你想要记录的笔记} \n :时间: %T \n %?")
	 
	 ;;消费
	("zd" "账单" plain (file+function "~/MyFile/Org/Bill.org" find-month-tree)
         " | %<%Y-%m-%d %a %H:%M:%S> | %^{prompt|Breakfast|Lunch|Dinner|水果|宵夜|购物|交通出行|其它} | %^{金额} |" :kill-buffer t :immediate-finish t)
	 
	 ;;英语单词
        ("e" "英语单词" entry (file+datetree "~/MyFile/Org/EnglishWord.org")
         "*  %^{英语单词} ----> %^{中文翻译}\n"  :kill-buffer t :immediate-finish t)

	 ;;Org-protocol网页收集
	 ("w" "网页收集" entry (file "~/MyFile/Org/WebCollection.org")
	 "* [[%:link][%:description]] \n %U \n %:initial \n")
	("b" "Bookmarks" plain (file+headline "~/MyFile/Org/Bookmarks.org" "New-Bookmarks")
	 "+  %?" :kill-buffer t)
	))
)
;; https://isouthrain.github.io
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-protocol-capture-html Capture Configuration darwin
(when (string= "darwin" system-type)
(setq org-capture-templates
      '(
	;;TODO
	("t" "Todo" plain (file+function "~/Desktop/MyFile/Org/GTD/Todo.org" find-month-tree)
         "*** TODO %^{想做什么？}\n  :时间: %^T\n  %?\n  %i\n"  :kill-buffer t :immediate-finish t)
	 
	;;日志
        ("j" "Journal" entry (file+datetree "~/Desktop/MyFile/Org/Journal.org" )
         "* %^{记些什么} %?\n  %i\n" :kill-buffer t :immediate-finish t)
	 
	 ;;日程安排
	("a" "日程安排" plain (file+function "~/Destop/MyFile/Org/GTD/Agenda.org" find-month-tree)
	 "*** [#%^{优先级}] %^{安排} \n SCHEDULED: %^T \n  :地点: %^{地点}\n" :kill-buffer t :immediate-finish t)
	 
	 ;;笔记
        ("n" "笔记" entry (file+headline "~/Desktop/MyFile/Org/Note.org" "Note")
	 "* %^{你想要记录的笔记} \n :时间: %T \n %?")
	 
	 ;;消费
	("zd" "账单" plain (file+function "~/Desktop/MyFile/Org/Bill.org" find-month-tree)
         " | %<%Y-%m-%d %a %H:%M:%S> | %^{prompt|Breakfast|Lunch|Dinner|水果|宵夜|购物|交通出行|其它} | %^{金额} |" :kill-buffer t :immediate-finish t)
	 
	 ;;英语单词
        ("e" "英语单词" entry (file+datetree "~/Desktop/MyFile/Org/EnglishWord.org")
         "*  %^{英语单词} ----> %^{中文翻译}\n" :kill-buffer t :immediate-finish t)

	 ;;Org-protocol网页收集
	 ("w" "网页收集" entry (file "~/Desktop/MyFile/Org/WebCollection.org")
	 "* [[%:link][%:description]] \n %U \n %:initial \n")
	("b" "Bookmarks" plain (file+headline "~/Desktop/MyFile/Org/Bookmarks.org" "New-Bookmarks")
	 "+  %?" :kill-buffer t)
	))
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-protocol-capture-html Capture Configuration windows-nt
(when (string= "windows-nt" system-type)
(setq org-capture-templates
      '(
	;;TODO
	("t" "Todo" plain (file+function "F:\\MyFile\\Org\\GTD\\Todo.org" find-month-tree)
         "*** TODO %^{想做什么？}\n  :时间: %^T\n  %?\n  %i\n"  :kill-buffer t :immediate-finish t)
	 
	;;日志
        ("j" "Journal" entry (file+datetree "F:\\MyFile\\Org\\Journal.org")
         "* %^{记些什么} %?\n  %i\n" :kill-buffer t :immediate-finish t)
	 
	 ;;日程安排
	;; ("a" "日程安排" entry (file+headline "F:\\MyFile\\Org\\GTD\\Agenda.org" "2022年6月")
	("a" "日程安排" plain (file+function "F:\\MyFile\\Org\\GTD\\Agenda.org" find-month-tree)
	 "*** [#%^{优先级}] %^{安排} \n SCHEDULED: %^T \n  :地点: %^{地点}\n" :kill-buffer t :immediate-finish t)
	 
	 ;;笔记
        ("n" "笔记" entry (file+headline "F:\\MyFile\\Org\\Note.org" "Note")
	 "* %^{你想要记录的笔记} \n :时间: %T \n %?")

	("y" "语录" entry (file+headline "F:\\Hugo\\content\\Quotation.zh-cn.md" "2022")
	 "> %^{语录}  " :kill-buffer t :immediate-finish t)

	 ;;消费
	("zd" "账单" plain (file+function "F:\\MyFile\\Org\\Bill.org" find-month-tree)
         " | %<%Y-%m-%d %a %H:%M:%S> | %^{prompt|Breakfast|Lunch|Dinner|水果|宵夜|购物|交通出行|其它} | %^{金额} |" :kill-buffer t :immediate-finish t)
	 
	 ;;英语单词
        ("e" "英语单词" entry (file+datetree "F:\\MyFile\\Org\\EnglishWord.org")
         "*  %^{英语单词} ----> %^{中文翻译}\n" :kill-buffer t :immediate-finish t)

	 ;;Org-protocol网页收集
	 ("w" "网页收集" entry (file "F:\\MyFile\\Org\\WebCollection.org")
	 "* [[%:link][%:description]] \n %U \n %:initial \n" :kill-buffer t :immediate-finish t)

	("b" "Bookmarks" plain (file+headline "F:\\MyFile\\Org\\Bookmarks.org" "New-Bookmarks")
	 "+  %?" :kill-buffer t)
	))
)

;; (org-capture nil "zd")
(defun org-capture-Bookmarks ()
(interactive) ; 如果不需要定义成命令，这句可以不要。
(org-capture)
(when (string= "windows-nt" system-type)
(find-file "F:\\MyFile\\Org\\Bookmarks.org"))
(when (string= "gnu/linux" system-type)
(find-file "~/MyFile/Org/Bookmarks.org"))
(when (string= "darwin" system-type)
(find-file "~/Desktop/MyFile/Org/Bookmarks.org"))
(org-html-export-to-html)
(kill-buffer (buffer-name))
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 创建org-capture 按键夹,必须创建才能用多按键
(add-to-list 'org-capture-templates '("z" "账单"));;与上面的账单相对应


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Capture Configuration 记录账单函数
;;用 org-capture 记录账单
(defun get-year-and-month ()
  (list (format-time-string "%Y") (format-time-string "%Y-%m")))
(defun find-month-tree ()
  (let* ((path (get-year-and-month))
         (level 1)
         end)
    (unless (derived-mode-p 'org-mode)
      (error "Target buffer \"%s\" should be in Org mode" (current-buffer)))
    (goto-char (point-min))             ;移动到 buffer 的开始位置
    ;; 先定位表示年份的 headline，再定位表示月份的 headline
    (dolist (heading path)
      (let ((re (format org-complex-heading-regexp-format
                        (regexp-quote heading)))
            (cnt 0))
        (if (re-search-forward re end t)
            (goto-char (point-at-bol))  ;如果找到了 headline 就移动到对应的位置
          (progn                        ;否则就新建一个 headline
            (or (bolp) (insert "\n"))
            (if (/= (point) (point-min)) (org-end-of-subtree t t))
            (insert (make-string level ?*) " " heading "\n"))))
      (setq level (1+ level))
      (setq end (save-excursion (org-end-of-subtree t t))))
    (org-end-of-subtree)))

)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; htmlize 导出 html 代码高亮
(use-package htmlize
  :ensure t
  :defer 2)

(provide 'init-org)
