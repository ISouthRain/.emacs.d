(let (
      ;; 加载的时候临时增大`gc-cons-threshold'以加速启动速度。
      (gc-cons-threshold most-positive-fixnum)
      ;; 清空避免加载远程文件的时候分析文件。
      (file-name-handler-alist nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 包开始
(add-to-list 'load-path (expand-file-name "core" user-emacs-directory))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'init-custom)
(require 'init-system)
;; Proxy for init-sysytem
(setq url-proxy-services '(
("http" . "127.0.0.1:7890")
("https" . "127.0.0.1:7890")))
(when freedom/is-linux
  (when (not freedom/is-termux)
    (setq url-proxy-services '(
    ("http" . "172.19.32.1:7890")
    ("https" . "172.19.32.1:7890")))
  )
)
(require 'init-package)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Your configuration
(require 'init-basic)
(require 'init-calendar)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; hl-line paren symbol-overlay highlight-indent-guides rainbow-mode diff-hl hl-todo volatile-highlights pulse
(require 'init-highlight)
;; 存在一定键绑定, 还没有去修改
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 回到上次编辑状态
;; (require 'init-benchmarking)
;; (require 'init-sessions)
;; theme doom-mode-line emojify posframe popper popup cnfonts
(require 'init-ui)
;; hydr pretty-hydra general
(require 'init-hydra)
;; dashboard all-icon restart-emacs
(require 'init-dashboard)
;; evil evil-escape evil-nerd-commenter key-chord evil-collection
(require 'init-evil)
;; company prescient company-prescient
(require 'init-company)
;; ivy smex orderless
(require 'init-search)
;; websocket org-roam simple-httpd org-roam-ui org-download org-appear org-cliplink htmlize org-protocol-capture-html deft org-modern org-superstarp org-fancy-priorities
(require 'init-org)
;; markdown-mode markdown-toc
(require 'init-markdown)
;; indent-guide undo-fu workgroups2 init-sessions init-benchmarking linum-relative bm elec-pair yasnippet projectile
(require 'init-edit)
;; pyim
(require 'init-pyim)
;; avy ace-window zoom buffer-move which-key awesome-tab neotree
(require 'init-navigation)
;; go-translate sdcv company-english-helper insert-translated-name
(require 'init-translate)
;; elfeed elfeed-org gnus mu4e writeroom-mode olivetti
(require 'init-reader)
;; lsp origami
;; (require 'init-lsp)
;; lsp-pyright
;;(require 'init-python)
;; bongo emms
;; (require 'init-player)
;; EAF
;; (require 'init-eaf)
;; Gpg 加密相关
(require 'init-epg)
;; vim 语法高亮 vimrc-mode
(require 'init-vim)
(load-file custom-file)
);; Cache Max End, Also the end of the package.
