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
(defcustom freedom-user-email-address "isouthrain@qq.com"
  "User Email address"
  :group 'freedom
  :type 'string)
(defcustom freedom-reply-email-address "isouthrain@qq.com"
  "Reply Email address"
  :group 'freedom
  :type 'string)
(defcustom freedom-agenda-dir "~/MyFile/Org/GTD"
  "Org GTD dir"
  :group 'freedom
  :type 'string)



(provide 'init-custom)
