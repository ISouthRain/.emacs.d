(defgroup freedom nil
  "Freedom Emacs customization."
  :group 'convenience
  :link '(url-link :tag "Homepage" "https://github.com/isouthrain/.emacs.d"))

(defcustom freedom-calendar-chinese nil
  "Chinese Calendar"
  :group 'freedom
  :type 'boolean)

(defcustom freedom-proxy-enable nil
  "Enable HTTP/HTTPS/Socks Proxy"
  :group 'freedom
  :type 'boolean)
(defcustom freedom-proxy "127.0.0.1:7890"
  "Set HTTP/HTTPS Proxy"
  :group 'freedom
  :type 'string)
(defcustom freedom-socks-proxy "127.0.0.1:7890"
  "Set Socks Proxy"
  :group 'freedom
  :type 'string)



(setq custom-file (locate-user-emacs-file "custom.el"))
(load-file custom-file)
(provide 'init-custom)
