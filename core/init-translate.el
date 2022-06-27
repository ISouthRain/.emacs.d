;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sdcv 翻译
(use-package sdcv
:defer 3
:ensure nil
:load-path "~/.emacs.d/core/plugins"
:config
;; 翻译后是否说话
(setq sdcv-say-word-p nil)
;; sdcv 字典目录
(setq sdcv-dictionary-data-dir (expand-file-name "emacs/sdcv/.stardict/dic" user-emacs-directory))
(when freedom/is-windows
(setq sdcv-dictionary-data-dir "C:\\Users\\Jack\\AppData\\Roaming\\.emacs.d\\sdcv\\.stardict\\dic"))
(setq sdcv-dictionary-simple-list    ;setup dictionary list for simple search
      '(
        "懒虫简明英汉词典"
        "计算机词汇"
        "牛津高阶英汉双解"
	))
(setq sdcv-dictionary-complete-list     ;setup dictionary list for complete search
      '(
        "懒虫简明英汉词典"
        "懒虫简明汉英词典"
        "牛津高阶英汉双解"
	))


;; 翻译插件 go-translate
(defhydra hydra-go-translate (:color pink
                              :hint nil
                              :foreign-keys warn ;; 不要使用hydra以外的键
			      )
  ("y" gts-do-translate-my "翻译")
  ("x" delete-window "关闭翻译窗口":exit t)
  ("t" beginner-translate-main "状态栏翻译":exit t)
  ("s" sdcv-search-pointer-my "sdcv翻译" :exit t)
  ("q" nil "cancel")
  ("<escape>" nil "cancel")
)
;;==============================

)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 输入中文后自动翻译
(use-package insert-translated-name
:defer 3
:ensure nil
:load-path "~/.emacs.d/core/plugins/"
:config
(setq insert-translated-name-translate-engine "google");; ;google  youdao
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 对英文单词编写进行提示
(use-package company-english-helper
:ensure nil
:defer 6
:load-path "~/.emacs.d/core/plugins/"
)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; go-translate 翻译
(use-package go-translate
:ensure t
:defer 3
:config
(require 'go-translate)
;; 配置多个翻译语言对
(setq gts-translate-list '(("en" "zh") ("fr" "zh")))
;; 设置为 t 光标自动跳转到buffer
(setq gts-buffer-follow-p t)
;; 配置默认的 translator
;; 这些配置将被 gts-do-translate 命令使用
(setq gts-default-translator
      (gts-translator

       :picker ; 用于拾取初始文本、from、to，只能配置一个

       (gts-noprompt-picker) ;; 成功案例
       ;;(gts-noprompt-picker :texter (gts-whole-buffer-texter))
       ;;(gts-prompt-picker)
       ;;(gts-prompt-picker :single t)
       ;;(gts-prompt-picker :texter (gts-current-or-selection-texter) :single t)

       :engines ; 翻译引擎，可以配置多个。另外可以传入不同的 Parser 从而使用不同样式的输出

       (list
        ;; (gts-bing-cn-engine)
        ;;(gts-google-engine)
        (gts-google-rpc-engine) ;; 成功案例
        ;;(gts-deepl-engine :auth-key [YOUR_AUTH_KEY] :pro nil)
        ;;(gts-google-engine :parser (gts-google-summary-parser))
        ;;(gts-google-engine :parser (gts-google-parser))
        ;;(gts-google-rpc-engine :parser (gts-google-rpc-summary-parser))
        ;;(gts-google-rpc-engine :parser (gts-google-rpc-parser))
	;;(gts-google-rpc-engine :parser (gts-google-rpc-summary-parser))
        )

       :render ; 渲染器，只能一个，用于输出结果到指定目标。如果使用 childframe 版本的，需自行安装 posframe

       (gts-buffer-render) ;; 成功案例
       ;; (gts-posframe-pop-render)
       ;; (gts-posframe-pop-render :backcolor "#333333" :forecolor "#ffffff")
       ;; (gts-posframe-pin-render)
       ;;(gts-posframe-pin-render :position (cons 1200 20))
       ;; (gts-posframe-pin-render :width 80 :height 25 :position (cons 1000 20) :forecolor "#ffffff" :backcolor "#111111")
       ;;(gts-kill-ring-render)
       ;;(your-render)
       ))

(defun gts-do-translate-my ()
(interactive)
(if (display-graphic-p)
    (if (posframe-workable-p)
        (setq gts-default-translator
              (gts-translator
               :picker ; 用于拾取初始文本、from、to，只能配置一个
               (gts-noprompt-picker) ;; 成功案例
               :engines ; 翻译引擎，可以配置多个。另外可以传入不同的 Parser 从而使用不同样式的输出
               (list
                (gts-google-rpc-engine) ;; 成功案例
                 )
               :render ; 渲染器，只能一个，用于输出结果到指定目标。如果使用 childframe 版本的，需自行安装 posframe
               ;; (gts-buffer-render) ;; 成功案例
               (gts-posframe-pop-render)
               ;;(gts-kill-ring-render)
               ;;(your-render)
               )))
    (setq gts-default-translator
          (gts-translator
           :picker ; 用于拾取初始文本、from、to，只能配置一个
           (gts-noprompt-picker) ;; 成功案例
           :engines ; 翻译引擎，可以配置多个。另外可以传入不同的 Parser 从而使用不同样式的输出
           (list
            (gts-google-rpc-engine) ;; 成功案例
             )
           :render ; 渲染器，只能一个，用于输出结果到指定目标。如果使用 childframe 版本的，需自行安装 posframe
           (gts-buffer-render) ;; 成功案例
           ;; (gts-posframe-pop-render)
           ;;(gts-kill-ring-render)
           ;;(your-render)
	   ))
)
(gts-do-translate)
)
)


(provide 'init-translate)
