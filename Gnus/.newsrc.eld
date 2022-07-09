;; -*- mode:emacs-lisp; coding: utf-8-emacs; -*-
;; Gnus startup file.
;; Never delete this file -- if you want to force Gnus to read the
;; .newsrc file (if you have one), touch .newsrc instead.
(setq gnus-newsrc-file-version "Gnus v5.13")

(setq gnus-newsrc-last-checked-date '"Sat, 09 Jul 2022 20:49:05 +0800")

(setq gnus-newsrc-alist '(("\345\205\266\344\273\226\346\226\207\344\273\266\345\244\271" 3 nil nil nil nil) ("Deleted Messages" 3 ((1 . 219)) ((unexist (1 . 203))) nil ((modseq) (uidvalidity . "1616920563") (active 1 . 219) (permanent-flags %* %Answered %Flagged %Deleted %Draft %Seen))) ("Drafts" 3 (1) ((unexist 1)) nil ((modseq) (uidvalidity . "1616920563") (active 1 . 1) (permanent-flags %* %Answered %Flagged %Deleted %Draft %Seen))) ("INBOX" 3 ((1 . 258)) ((unexist (1 . 255))) nil ((modseq) (uidvalidity . "1616920563") (active 1 . 258) (permanent-flags %* %Answered %Flagged %Deleted %Draft %Seen))) ("Junk" 3 ((1 . 24)) ((unexist (1 . 24))) nil ((modseq) (uidvalidity . "1616920563") (active 1 . 24) (permanent-flags %* %Answered %Flagged %Deleted %Draft %Seen))) ("Sent Messages" 3 ((1 . 18)) ((unexist (1 . 18))) nil ((modseq) (uidvalidity . "1616920563") (active 1 . 18) (permanent-flags %* %Answered %Flagged %Deleted %Draft %Seen))) ("\345\205\266\344\273\226\346\226\207\344\273\266\345\244\271/Gmail" 3 ((1 . 27)) ((unexist (1 . 27))) nil ((modseq) (uidvalidity . "1654005874") (active 1 . 27) (permanent-flags %* %Answered %Flagged %Deleted %Draft %Seen))) ("nndraft:drafts" 1 nil nil (nndraft "") ((gnus-dummy (gnus-draft-mode))))))

(setq gnus-server-alist '(("archive" nnfolder "archive" (nnfolder-directory "~/.emacs.d/Gnus/Mail/archive") (nnfolder-active-file "~/.emacs.d/Gnus/Mail/archive/active") (nnfolder-get-new-mail nil) (nnfolder-inhibit-expiry t))))

(setq gnus-topic-topology '(("Gnus" visible) (("misc" visible))))

(setq gnus-topic-alist '(("misc" "nndraft:drafts" "\345\205\266\344\273\226\346\226\207\344\273\266\345\244\271/Gmail" "Junk" "Deleted Messages" "Drafts" "Sent Messages" "INBOX" "\345\205\266\344\273\226\346\226\207\344\273\266\345\244\271") ("Gnus" "dummy.group")))
