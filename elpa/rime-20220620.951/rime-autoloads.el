;;; rime-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "rime" "rime.el" (0 0 0 0))
;;; Generated autoloads from rime.el

(defvar rime-title (char-to-string 12563) "\
The title of input method.")

(autoload 'rime-lighter "rime" "\
Return a lighter which can be used in mode-line.

The content is `rime-title'.

You can customize the color with `rime-indicator-face' and `rime-indicator-dim-face'." nil nil)

(autoload 'rime-activate "rime" "\
Activate rime.
Argument NAME ignored.

\(fn NAME)" nil nil)

(register-input-method "rime" "euc-cn" 'rime-activate rime-title)

(register-definition-prefixes "rime" '("rime-"))

;;;***

;;;### (autoloads nil "rime-predicates" "rime-predicates.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from rime-predicates.el

(register-definition-prefixes "rime-predicates" '("rime-predicate-"))

;;;***

;;;### (autoloads nil nil ("rime-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; rime-autoloads.el ends here
