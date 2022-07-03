(defun my-config-pyim()
(interactive)
(setq pyim-dcache-directory (expand-file-name "emacs/pyim/dcache" user-emacs-directory))
(use-package pyim
;;:defer 2
:ensure t
:config
(use-package pyim-basedict
;;:defer 2
:ensure t
)
(require 'pyim)
(require 'pyim-basedict) ; 拼音词库设置，五笔用户 *不需要* 此行设置
(pyim-basedict-enable)   ; 拼音词库，五笔用户 *不需要* 此行设置

(setq default-input-method "pyim")

;; 我使用全拼
(pyim-default-scheme 'quanpin)

;; 开启代码搜索中文功能（比如拼音，五笔码等）
;; (pyim-isearch-mode 1)

;; 显示5个候选词。
(setq pyim-page-length 5)
(setq pyim-page-tooltip 'popup)

;; 模糊音
;; (setq pyim-pinyin-fuzzy-alist t)
;; 光标颜色
(setq pyim-indicator-list (list #'my-pyim-indicator-with-cursor-color #'pyim-indicator-with-modeline))

(defun my-pyim-indicator-with-cursor-color (input-method chinese-input-p)
  (if (not (equal input-method "pyim"))
      (progn
        ;; 用户在这里定义 pyim 未激活时的光标颜色设置语句
        (set-cursor-color "red"))
    (if chinese-input-p
        (progn
          ;; 用户在这里定义 pyim 输入中文时的光标颜色设置语句
          (set-cursor-color "green"))
      ;; 用户在这里定义 pyim 输入英文时的光标颜色设置语句
      (set-cursor-color "blue"))))

;; 使用英文符号
(setq-default pyim-punctuation-translate-p '(no yes auto))   ;使用半角标点。
;; 使用 jk 将能进入 evil-normal-mode
(defun my-pyim-self-insert-command (orig-func)
(interactive "*")
(if (and (local-variable-p 'last-event-time)
        (floatp last-event-time)
        (< (- (float-time) last-event-time) 0.2))
    (set (make-local-variable 'temp-evil-escape-mode) t)
    (set (make-local-variable 'temp-evil-escape-mode) nil)
    )
(if (and temp-evil-escape-mode
        (equal (pyim-entered-get) "j")
        (equal last-command-event ?k))
    (progn
        (push last-command-event unread-command-events)
        (pyim-process-outcome-handle 'pyim-entered)
        (pyim-process-terminate))
    (progn
    (call-interactively orig-func)
    (set (make-local-variable 'last-event-time) (float-time))
    ))
    )

(advice-add 'pyim-self-insert-command :around #'my-pyim-self-insert-command)

(defun my-pyim-clear-and-off ()
    (interactive)
    (pyim-quit-clear)
    (toggle-input-method))
  ;; (define-key pyim-mode-map (kbd "/") 'my-pyim-clear-and-off)


(require 'key-chord)

(defun rime--enable-key-chord-fun (orig key)
  (if (key-chord-lookup-key (vector 'key-chord key))
      (let ((result (key-chord-input-method key)))
        (if (eq (car result) 'key-chord)
            result
          (funcall orig key)))
    (funcall orig key)))

(advice-add 'pyim-input-method :around #'rime--enable-key-chord-fun)

;; 百度云拼音
(setq pyim-cloudim 'baidu)
;; 设置PYIM图标
(setq pyim-title "拼音")
)

(toggle-input-method)
)

(provide 'init-pyim)
