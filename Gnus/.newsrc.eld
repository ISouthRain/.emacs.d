;; -*- mode:emacs-lisp; coding: utf-8-emacs-dos; -*-
;; Gnus startup file.
;; Never delete this file -- if you want to force Gnus to read the
;; .newsrc file (if you have one), touch .newsrc instead.
(setq gnus-newsrc-file-version "Gnus v5.13")

(setq gnus-newsrc-last-checked-date '"Sun, 03 Jul 2022 17:11:13 +0800")

(setq gnus-newsrc-alist '(("\345\205\266\344\273\226\346\226\207\344\273\266\345\244\271" 3 ((1 . 37)) ((unexist) (seen (38 . 41))) nil ((timestamp . 1656839477) (modseq) (uidvalidity) (active 38 . 41) (permanent-flags))) ("Deleted Messages" 3 ((1 . 41)) ((unexist (1 . 37))) nil ((modseq) (uidvalidity . "1599180563") (active 1 . 41) (permanent-flags %* %Answered %Flagged %Deleted %Draft %Seen))) ("Drafts" 3 nil ((unexist)) nil ((modseq) (uidvalidity . "1599180563") (active 1 . 0) (permanent-flags %* %Answered %Flagged %Deleted %Draft %Seen))) ("INBOX" 3 ((1 . 31)) ((unexist (1 . 31)) (seen (25 . 28))) nil ((modseq) (uidvalidity . "1599180563") (active 1 . 31) (timestamp . 1656777267) (permanent-flags %* %Answered %Flagged %Deleted %Draft %Seen))) ("Junk" 3 (1) ((unexist 1)) nil ((modseq) (uidvalidity . "1599180563") (active 1 . 1) (permanent-flags %* %Answered %Flagged %Deleted %Draft %Seen))) ("Sent Messages" 3 ((1 . 14)) ((unexist (1 . 13))) nil ((modseq) (uidvalidity . "1599180563") (active 1 . 14) (permanent-flags %* %Answered %Flagged %Deleted %Draft %Seen))) ("nndraft:drafts" 1 nil nil (nndraft "") ((gnus-dummy (gnus-draft-mode))))))

(setq gnus-server-alist '(("archive" nnfolder "archive" (nnfolder-directory "~/.emacs.d/Gnus/Mail/archive") (nnfolder-active-file "~/.emacs.d/Gnus/Mail/archive/active") (nnfolder-get-new-mail nil) (nnfolder-inhibit-expiry t))))

(setq gnus-topic-topology '(("Gnus" visible) (("misc" visible))))

(setq gnus-topic-alist '(("misc" "nndraft:drafts" "Junk" "Deleted Messages" "Drafts" "Sent Messages" "INBOX" "\345\205\266\344\273\226\346\226\207\344\273\266\345\244\271") ("Gnus" "dummy.group")))
