;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 包开始
;; Install straight.el
(package-initialize)
(require 'package)
(add-to-list 'package-archives
			 '("melpa" . "https://melpa.org/packages/")
			 '("melpa-stable" . "https://stable.melpa.org/packages/")
)
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package)
  )
 ;; This is only needed once, near the top of the file
(eval-when-compile
(require 'use-package))
(require 'use-package-ensure)
;; 自动下载，不需要 :straight t
(setq use-package-always-ensure t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 添加 straight 与 use-package 同时通用
;; (defvar bootstrap-version)
;; (let ((bootstrap-file
;;        (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
;;       (bootstrap-version 5))
;;   (unless (file-exists-p bootstrap-file)
;;     (with-current-buffer
;;         (url-retrieve-synchronously
;;          "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
;;          'silent 'inhibit-cookies)
;;       (goto-char (point-max))
;;       (eval-print-last-sexp)))
;;   (load bootstrap-file nil 'nomessage))
;; ;; ;; 禁止编译
;; (setq straight-disable-compile t)
;; (setq straight-disable-native-compile t)
;; (straight-use-package 'use-package)

(provide 'init-package)
