;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; elfeed
(use-package elfeed
:ensure t
:bind (:map elfeed-search-mode-map
            ("q" . freedom/elfeed-quit))
:init (setq url-queue-timeout 30
            elfeed-db-directory (expand-file-name "emacs/.elfeed" user-emacs-directory)
	    ;; elfeed-show-entry-switch #'pop-to-buffer
	    ;; elfeed-show-entry-delete #'delete-window
      )
:config
(when recentf-mode
;; recentf 排除
(push elfeed-db-directory recentf-exclude)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; elfeed-org
(use-package elfeed-org
:ensure t
:config
(elfeed-org)
;;(setq rmh-elfeed-org-files (list "~/.emacs.d/elfeed.org"))
(setq rmh-elfeed-org-files (list (expand-file-name "elfeed.org" user-emacs-directory)))
(defun freedom/elfeed ()
  "Wrapper to load the elfeed db from disk before opening"
  (interactive)
  (elfeed-db-load)
  (elfeed)
  (elfeed-search-update--force))
(defun freedom/elfeed-quit ()
  "Wrapper to save the elfeed db to disk before burying buffer"
  (interactive)
  (elfeed-db-save)
  (quit-window))
(kill-buffer "*elfeed-log*")
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; gnus
(use-package gnus
:defer 3
:ensure nil
:config
;; ;; 存储设置
(setq gnus-startup-file "~/.emacs.d/Gnus/.newsrc")                  ;初始文件
(setq gnus-default-directory "~/.emacs.d/Gnus/")                    ;默认目录
(setq gnus-home-directory "~/.emacs.d/Gnus/")                       ;主目录
(setq gnus-dribble-directory "~/.emacs.d/Gnus/")                    ;恢复目录
(setq gnus-directory "~/.emacs.d/Gnus/News/")                       ;新闻组的存储目录
(setq gnus-article-save-directory "~/.emacs.d/Gnus/News/")          ;文章保存目录
(setq gnus-kill-files-directory "~/.emacs.d/Gnus/News/trash/")      ;文件删除目录

(setq gnus-agent-directory "~/.emacs.d/Gnus/News/agent/")           ;代理目录
(setq gnus-cache-directory "~/.emacs.d/Gnus/News/cache/")           ;缓存目录
(setq gnus-cache-active-file "~/.emacs.d/Gnus/News/cache/active")   ;缓存激活文件
(setq message-directory "~/.emacs.d/Gnus/Mail/")                    ;邮件的存储目录
(setq message-auto-save-directory "~/.emacs.d/Gnus/Mail/drafts")    ;自动保存的目录
(setq mail-source-directory "~/.emacs.d/Gnus/Mail/incoming")        ;邮件的源目录
(setq nnmail-message-id-cache-file "~/.emacs.d/Gnus/.nnmail-cache") ;nnmail的消息ID缓存
(setq nnml-newsgroups-file "~/.emacs.d/Gnus/Mail/newsgroup")        ;邮件新闻组解释文件
(setq nntp-marks-directory "~/.emacs.d/Gnus/News/marks")            ;nntp组存储目录
(setq mml-default-directory "~/.emacs.d/Gnus/.gnus/")                            ;附件的存储位置

;; Set personal information and password
(setq epg-gpg-program "gpg2")
(require 'auth-source);; probably not necessary
(setq auth-sources '("~/.emacs.d/.authinfo.gpg"))
(setq user-mail-address (format "%s" freedom-email-address)
      user-full-name "ISouthRain")

;; ;; 收取首要邮件来源
(setq gnus-select-method
      '(nnimap "QQ"
	       (nnimap-address "imap.qq.com")  ; it could also be imap.googlemail.com if that's your server.
	       ;; (nnimap-address "imap.gmail.com")  ; it could also be imap.googlemail.com if that's your server.
	       ;; (nnimap-address "imap.qq.com")  ; it could also be imap.googlemail.com if that's your server.
	       (nnimap-server-port "993")
	       (nnimap-stream ssl)
       ))
;; ;; 第二个收取邮件来源
;; (setq gnus-secondary-select-methods                  ;次要选择方法
;;       '(
;;         (nnmaildir "Gmail"                        ;nnmaildir后端, 从本地文件中读邮件 (getmail 抓取)
;;                    (directory "~/Maildir/Gmail/")) ;读取目录
;;         ))

;; ;; 邮件源设置
;; (setq mail-sources                                 ;邮件源设置
;;       '((maildir :path "~/Maildir/Gmail/"           ;本地邮件存储位置
;;                  :subdirs ("cur" "new" "tmp"))))   ;本地邮件子目录划分

;; 设置邮件发送方法
(setq smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-stream-type 'ssl
      smtpmail-smtp-service 465
      ;; 发送方法
      send-mail-function 'smtpmail-send-it
      message-send-mail-function 'smtpmail-send-it ;设置消息发送方法
      ;; sendmail-program "/usr/bin/msmtp"            ;设置发送程序
      mail-specify-envelope-from t                 ;发送邮件时指定信封来源
      mail-envelope-from 'header                  ;信封来源于 header       "nnmaildir+Gmail:inbox")))                ;邮件归档
      gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")

(setq gnus-message-archive-group                   ;设置消息归档的组
      '((if (message-news-p)
            "News:nnfolder"             ;新闻归档
          "nnimap:inbox")))                ;邮件归档

;;Debug
(setq smtpmail-debug-info t)
(setq smtpmail-debug-verb t)
;; 常规设置
(gnus-agentize)                                     ;开启代理功能, 以支持离线浏览
(setq gnus-inhibit-startup-message t)               ;关闭启动时的画面
;; (setq gnus-novice-user nil)                         ;关闭新手设置, 不进行确认
(setq gnus-expert-user t)                           ;不询问用户
(setq gnus-show-threads t)                          ;显示邮件线索
(setq gnus-interactive-exit nil)                    ;退出时不进行交互式询问
;; (setq gnus-use-dribble-file nil)                    ;不创建恢复文件
;; (setq gnus-always-read-dribble-file nil)            ;不读取恢复文件
(setq gnus-asynchronous t)                          ;异步操作
(setq gnus-large-newsgroup 100)                     ;设置大容量的新闻组默认显示的大小
(setq gnus-large-ephemeral-newsgroup nil)           ;和上面的变量一样, 只不过对于短暂的新闻组
(setq gnus-summary-ignore-duplicates t)             ;忽略具有相同ID的消息
(setq gnus-treat-fill-long-lines t)                 ;如果有很长的行, 不提示
(setq message-confirm-send t)                       ;防止误发邮件, 发邮件前需要确认
(setq message-kill-buffer-on-exit t)                ;设置发送邮件后删除buffer
(setq message-from-style 'angles)                   ;`From' 头的显示风格
(setq message-syntax-checks '((sender . disabled))) ;语法检查
(setq nnmail-expiry-wait 7)                         ;邮件自动删除的期限 (单位: 天)
(setq nnmairix-allowfast-default t)                 ;加快进入搜索结果的组
;; 窗口布局
(gnus-add-configuration
 '(article
   (vertical 1.0
             (summary .35 point)
             (article 1.0))))
;; 显示设置
(setq mm-inline-large-images t)                       ;显示内置图片
(auto-image-file-mode)                                ;自动加载图片
(add-to-list 'mm-attachment-override-types "image/*") ;附件显示图片

;; 概要显示设置
(setq gnus-summary-gather-subject-limit 'fuzzy) ;聚集题目用模糊算法
(setq gnus-summary-line-format "%4P %U%R%z%O %{%5k%} %{%14&user-date;%}   %{%-20,20n%} %{%ua%} %B %(%I%-60,60s%)\n")
(setq my-mail "isouthrain@qq.com")
(defun gnus-user-format-function-a (header) ;用户的格式函数 `%ua'
  (let ((myself (concat "<" my-mail ">"))
        (references (mail-header-references header))
        (message-id (mail-header-id header)))
    (if (or (and (stringp references)
                 (string-match myself references))
            (and (stringp message-id)
                 (string-match myself message-id)))
        "X" "│")))

(setq gnus-user-date-format-alist             ;用户的格式列表 `user-date'
      '(((gnus-seconds-today) . "TD %H:%M")   ;当天
        (604800 . "W%w %H:%M")                ;七天之内
        ((gnus-seconds-month) . "%d %H:%M")   ;当月
        ((gnus-seconds-year) . "%m-%d %H:%M") ;今年
        (t . "%y-%m-%d %H:%M")))              ;其他

;; 线程的可视化外观, `%B'
(setq gnus-summary-same-subject "")
(setq gnus-sum-thread-tree-indent "    ")
(setq gnus-sum-thread-tree-single-indent "◎ ")
(setq gnus-sum-thread-tree-root "● ")
(setq gnus-sum-thread-tree-false-root "☆")
(setq gnus-sum-thread-tree-vertical "│")
(setq gnus-sum-thread-tree-leaf-with-other "├─► ")
(setq gnus-sum-thread-tree-single-leaf "╰─► ")
;; 时间显示
(add-hook 'gnus-article-prepare-hook 'gnus-article-date-local) ;将邮件的发出时间转换为本地时间
(add-hook 'gnus-select-group-hook 'gnus-group-set-timestamp)   ;跟踪组的时间轴
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)              ;新闻组分组
;; 设置邮件报头显示的信息
(setq gnus-visible-headers
      (mapconcat 'regexp-quote
                 '("From:" "Newsgroups:" "Subject:" "Date:"
                   "Organization:" "To:" "Cc:" "Followup-To" "Gnus-Warnings:"
                   "X-Sent:" "X-URL:" "User-Agent:" "X-Newsreader:"
                   "X-Mailer:" "Reply-To:" "X-Spam:" "X-Spam-Status:" "X-Now-Playing"
                   "X-Attachments" "X-Diagnostic")
                 "\\|"))
;; 用 Supercite 显示多种多样的引文形式
(setq sc-attrib-selection-list nil
      sc-auto-fill-region-p nil
      sc-blank-lines-after-headers 1
      sc-citation-delimiter-regexp "[>]+\\|\\(: \\)+"
      sc-cite-blank-lines-p nil
      sc-confirm-always-p nil
      sc-electric-references-p nil
      sc-fixup-whitespace-p t
      sc-nested-citation-p nil
      sc-preferred-header-style 4
      sc-use-only-preference-p nil)
;; 线程设置
(setq
 gnus-use-trees t                                                       ;联系老的标题
 gnus-tree-minimize-window nil                                          ;用最小窗口显示
 gnus-fetch-old-headers 'some                                           ;抓取老的标题以联系线程
 gnus-generate-tree-function 'gnus-generate-horizontal-tree             ;生成水平树
 gnus-summary-thread-gathering-function 'gnus-gather-threads-by-subject ;聚集函数根据标题聚集
 )
;; 排序
(setq gnus-thread-sort-functions
      '(
        (not gnus-thread-sort-by-date)                               ;时间的逆序
        (not gnus-thread-sort-by-number)))                           ;跟踪的数量的逆序
;; 自动跳到第一个没有阅读的组
(add-hook 'gnus-switch-on-after-hook 'gnus-group-first-unread-group) ;gnus切换时
(add-hook 'gnus-summary-exit-hook 'gnus-group-first-unread-group)    ;退出Summary时
;; 自动更新新消息
;; (add-hook 'gnus-summary-exit-hook 'gnus-notify+)        ;退出summary模式后
;; (add-hook 'gnus-group-catchup-group-hook 'gnus-notify+) ;当清理当前组后
;; (add-hook 'mail-notify-pre-hook 'gnus-notify+)          ;更新邮件时
;; 斑纹化
(setq gnus-summary-stripe-regexp        ;设置斑纹化匹配的正则表达式
      (concat "^[^"
              gnus-sum-thread-tree-vertical
              "]*"))

)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mu4e
(when freedom/is-linux
   (add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")
  (when freedom/is-termux
   (add-to-list 'load-path "/data/data/com.termux/files/usr/share/emacs/site-lisp/mu4e"))
  (require 'mu4e)
  (setq mu4e-maildir (expand-file-name "~/.emacs.d/Maildir/QQ"))
  (setq mu4e-change-filenames-when-moving t)
  ;; (setq mu4e-maildir (expand-file-name "~/Maildir/Gmail"))
  ;; (setq mu4e-drafts-folder "/[Gmail].草稿")
  ;; (setq mu4e-sent-folder "/[Gmail].已发邮件")
  ;; (setq mu4e-trash-folder "/[Gmail].已删除邮件")
 ;; (setq mu4e-maildir-shortcuts
  ;;       '( ("/INBOX" . ?i)
  ;;          ("/[Gmail].已发邮件" . ?s)
  ;;          ("/[Gmail].已删除邮件" . ?t)
  ;;          ("/[Gmail].草稿" . ?d)))

  ;; (setq mu4e-drafts-folder "/[Gmail].Drafts")
  ;; (setq mu4e-sent-folder "/[Gmail].Sent Mail")
  ;; (setq mu4e-trash-folder "/[Gmail].Bin")
  ;; (setq mu4e-maildir-shortcuts
  ;;       '( ("/INBOX" . ?i)
  ;;          ("/[Gmail].Sent Mail" . ?s)
  ;;          ("/[Gmail].Bin" . ?t)
  ;;          ("/[Gmail].Drafts" . ?d)
  ;;          ("/[Gmail].Starred" . ?m)))
  ;; QQ
  (setq mu4e-drafts-folder "/Drafts")
  (setq mu4e-sent-folder "/Sent Messages")
  (setq mu4e-trash-folder "/Deleted Messages")
  (setq mu4e-maildir-shortcuts
        '( ("/INBOX" . ?i)
           ("/Sent Messages" . ?s)
           ("/Deleted Messages" . ?t)
           ("/Drafts" . ?d)
           ("/Junk" . ?j)))



  ;; ;; (setq message-signature-file "~/.emacs.d/.signature") ; put your signature in this file
  ;; ;; get mail
  ;; (setq mu4e-get-mail-command "mbsync -a -c ~/.emacs.d/.mbsyncrc;mu init -m ~/Maildir/QQ --my-address=isouthrain@gmail.com;mu index"
  (setq mu4e-get-mail-command "offlineimap -c ~/.emacs.d/.offlineimaprc"
        mu4e-html2text-command "w3m -T text/html"
        mu4e-update-interval 120
        mu4e-headers-auto-update t
        mu4e-compose-signature-auto-include nil)

  ;; show images
  (setq mu4e-show-images t)

;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

;; general emacs mail settings; used when composing e-mail
;; the non-mu4e-* stuff is inherited from emacs/message-mode
(setq mu4e-reply-to-address (format "%s" freedom-email-address)
      user-mail-address (format "%s" freedom-email-address)
      ;; user-mail-address "8744243@qq.com"
      user-full-name "ISouthRain")

;; don't save message to Sent Messages, IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; olivetti 居中模式
(use-package olivetti
:defer 1
:ensure nil
:load-path "~/.emacs.d/core/plugins"
:config
;;=============================================
;; olivetti-mode 居中模式
(defhydra hydra-olivetti-mode (:color pink
                  :hint nil
                  :foreign-keys warn ;; 不要使用hydra以外的键
				     )
"
_m_: 开/关   _s_: size 
_h_: 减小    _l_: 增大
"
  ("l" olivetti-expand :exit nil)
  ("h" olivetti-shrink :exit nil)
  ("m" olivetti-mode :exit nil)
  ("s" olivetti-set-width :exit nil)
  ;; (""  "" :exit nil)
  ("q" nil "cancel")
  ("<escape>" nil "cancel")
)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; writeroom-mode 写作模式
(use-package writeroom-mode
:defer 1
:ensure nil
:load-path "~/.emacs.d/core/plugins")

(provide 'init-reader)
