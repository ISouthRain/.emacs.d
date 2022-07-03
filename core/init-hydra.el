(use-package general
  :ensure t
  :defer 2
  :config
  (require 'general)
  )

(use-package hydra
;; :defer 2
:ensure t
:config
(general-define-key
 ;; :keymaps 'meow-normal-state-keymap
 :states 'visual
 "SPC" 'hydra-my-keymaps/body
)
(general-define-key
  ;; :keymaps 'dashboard-mode-map
 :states 'normal
  "SPC" 'hydra-my-keymaps/body
)

(general-define-key
 :states 'motion
 "SPC" 'hydra-my-keymaps/body
)



(defhydra hydra-my-keymaps (:color pink
                            :hint nil
                            :foreign-keys warn ;; 不要使用hydra以外的键
			    )
"
_nc_: commenter         _fy_: translate       _nn_: neotree
_SPC_: word-motion      _ib_: Ibuffer         _xf_: counsel-find
_oc_: Org-capture       _od_: Org-download    _b_: to-buffer
_oa_: Org-Agenda        _mdf_: Markdown File
_pya_: add-pyim         _pyd_: remove-pyim    
_xk_: kill buffer       _eww_: eww            _mm_: bm-mark
_mb_: m-buffer-window   _or_: org roam
_ol_: 居中模式          _wg_: workgroups2     _we_: LSP
"
  ;; ("bb" hydra-centaur-tabs/body :exit t) ;; centaur-tabs
  ;; ("bb" hydra-to-buffer/body :exit t) ;; centaur-tabs
  ("b" hydra-awesome-tab/body :exit t) ;; awesome-tab
  ("mm" hydra-bm/body :exit t)
  ("fy" gts-do-translate-my :exit t)
  ("ib" hydra-ibuffer/body :exit t)
  ("nc" hydra-evil-nerd-commenter/body :exit t)
  ("nn" hydra-neotree/body :exit t)
  ("SPC" avy-goto-char :exit t) ;; 单词跳跃
  ("xf" find-file :exit t) ;; Helm find file
  ("oc" org-capture :exit t)  ;; org capture 捕获
  ("od" hydra-org-download/body :exit t) ;; Org-download
  ("oa" org-agenda :exit t)
  ("or" hydra-org-roam/body :exit t)
  ("pya" pyim-create-word-from-selection :exit t)
  ("pyd" pyim-delete-word :exit t) 
  ("mb" hydra-buffer-move/body :exit t)
  ("mdf" markdown-file-start-myself :exit t) ;; Markdown 启动文件
  ("ol" hydra-olivetti-mode/body :exit t)
  ;; ("mw" hydra-evil-window/body :exit t)
  ("xk" (kill-buffer (buffer-name)) :exit t) ;; 杀死当前buffer
  ("eww" hydra-eww/body :exit t)
  ("wg" hydra-workgroups2/body :exit t)
  ("we" hydra-lsp-mode/body :exit t)
  ;; (""  :exit t)
  ;; (""  :exit t)
  ;; (""  :exit t)
  ;; (""  :exit t)
  ;; (""  :exit t)
  ;; (""  :exit t)
  ;; (""  :exit t)
  ("q" nil "cancel") 
  ("<escape>" nil "cancel")
)

;; ;; =============================================
;; ;; hydra 模板
;; (defhydra hydra- (:color pink
;;                   :hint nil
;;                   :foreign-keys warn ;; 不要使用hydra以外的键
;; 				     )
;; "
;; "
;;   (""  "" :exit nil)
;;   ("q" nil "cancel")
;;   ("<escape>" nil "cancel")
;; )
;; ;; =============================================



;; eww 浏览器
(defhydra hydra-eww (:color pink
                     :hint nil
                              ;; :foreign-keys warn ;; 不要使用hydra以外的键
				     )
"
_l_: 后退          _r_: 前进             _g_: 重载
_w_: Copy url      _d_: Download         _H_: 历史
_b_: 添加书签      _B_: 显示书签列表     _q_: 退出浏览器
_G_: 重新输入链接  _&_: 用外部浏览器打开
_v_: 源码模式      _C_: 显示 Cookie
_o_: eww           _n_: 向下滑动         _p_: 向上滑动
_j_: 下5行         _k_: 上5行
"
  ("l" eww-back-url :exit nil)
  ("r" eww-forward-url :exit nil)
  ("g" eww-reload :exit nil)
  ("w" eww-copy-page-url :exit nil)
  ("d" eww-download :exit nil)
  ("H" eww-list-histories :exit nil)
  ("b" eww-add-bookmark :exit nil)
  ("B" eww-list-bookmarks :exit nil)
  ("&" eww-browse-with-external-browser :exit nil)
  ("v" eww-view-source :exit nil)
  ("C" url-cookie-list :exit nil)
  ("G" eww-open-url :exit nil)
  ("o" eww :exit nil)
  ("n" (evil-scroll-page-down 1) :exit nil)
  ("p" (evil-scroll-page-up 1) :exit nil)
  ("q" quit-window :exit nil)
  ("k" (evil-previous-line 5) :exit nil)
  ("j" (evil-next-line 5) :exit nil)
  ;; (""  :exit nil)
  ("q" nil "cancel")
  ("<escape>" nil "cancel")
)
;; ;;=============================================
;; ;; Ibuffer
;; (defhydra hydra-ibuffer (:color pink
;;                          :hint nil
;;                          :foreign-keys warn ;; 不要使用hydra以外的键
;; 			 )
;; "
;; _b_: Ibuffer       _t_: Jump buffer      _T_: toggle-marks
;; _j_: 下一行        _k_: 上一行           _u_: unmark
;; _RET_: 打开buffer  _g_: 更新buffer状态
;; _d_: 删除标记      _m_: 标记             _SPC_: 跳转
;; _D_: 删除buffer    _S_: do-save
;; "
;;   ("b" ibuffer :exit nil)
;;   ("t" ibuffer-jump-to-buffer :exit t)
;;   ("j" ibuffer-forward-line :exit nil)
;;   ("k" ibuffer-backward-line :exit nil)
;;   ("d" ibuffer-mark-for-delete :exit nil)
;;   ("RET" ibuffer-visit-buffer :exit t)
;;   ("o" ibuffer-visit-buffer :exit t)
;;   ("g" ibuffer-update :exit nil)
;;   ("m" ibuffer-mark-forward :exit nil)
;;   ("D" ibuffer-do-delete :exit nil)
;;   ("S" ibuffer-do-delete :exit nil)
;;   ("T" ibuffer-toggle-marks :exit nil)
;;   ("u" ibuffer-unmark-forward :exit nil)
;;   ("SPC" avy-goto-char :exit nil)
;;   ;; (""  :exit t)
;;   ;; (""  :exit t)
;;   ;; (""  :exit t)
;;   ("q" nil "cancel")
;;   ("<escape>" nil "cancel")
;; )

;; ;;=============================================



);; hydra 包结尾




(use-package pretty-hydra
  :defer 2
  :ensure t
  :bind ("<f6>" . toggles-hydra/body)
  :init
  (pretty-hydra-define toggles-hydra (:title "Toggles" :color amaranth :foreign-keys warn)
    ("基础"
     (("es" evil-escape-mode "evil-escape" :toggle t)
      ("ln" global-linum-mode "行号" :toggle t)
      ("lr" linum-relative-mode "相对行号" :toggle t)
      ("em" emojify-mode "表情符号" :toggle t)
      ("oj" org-download-image-myself-jpg "Termux-jpg" :toggle t :exit t)
      ("op" org-download-image-myself-png "Termuex-png" :toggle t :exit t)
      ("cnp" pangu-spacing-mode "中英文混版, 美化" :toggle t :exit t)
      ("<escape>" nil "cancel")
      ("q" nil "cancel")
      )
      )
      )
);; End




(provide 'init-hydra)
