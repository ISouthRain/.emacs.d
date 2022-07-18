;; -*- mode:emacs-lisp; coding: utf-8-emacs; -*-
;; Gnus startup file.
;; Never delete this file -- if you want to force Gnus to read the
;; .newsrc file (if you have one), touch .newsrc instead.
(setq gnus-newsrc-file-version "Gnus v5.13")

(setq gnus-newsrc-last-checked-date '"Sun, 17 Jul 2022 23:07:28 +0800")

(setq gnus-newsrc-alist '(("\345\205\266\344\273\226\346\226\207\344\273\266\345\244\271" 3 ((1 . 284)) ((unexist) (seen (204 . 219) (266 . 281) (283 . 284))) nil ((timestamp . 1658040926) (modseq) (uidvalidity) (active 204 . 284) (permanent-flags))) ("Archives" 3 nil ((unexist)) nil ((modseq) (uidvalidity . "1657612250") (active 1 . 0) (permanent-flags %* %Answered %Flagged %Deleted %Draft %Seen))) ("Deleted Messages" 3 (1 . 232) ((unexist (1 . 203)) (seen (204 . 219))) nil ((modseq) (uidvalidity . "1616920563") (active 1 . 232) (timestamp . 1657444543) (permanent-flags %* %Answered %Flagged %Deleted %Draft %Seen))) ("Drafts" 3 (1) ((unexist 1)) nil ((modseq) (uidvalidity . "1616920563") (active 1 . 1) (permanent-flags %* %Answered %Flagged %Deleted %Draft %Seen))) ("INBOX" 3 (1 . 284) ((unexist (1 . 255)) (seen 259 284)) nil ((modseq) (uidvalidity . "1616920563") (active 1 . 284) (timestamp . 1657987973) (permanent-flags %* %Answered %Flagged %Deleted %Draft %Seen))) ("Junk" 3 ((1 . 26)) ((unexist (1 . 26))) nil ((modseq) (uidvalidity . "1616920563") (active 1 . 26) (permanent-flags %* %Answered %Flagged %Deleted %Draft %Seen))) ("Sent Messages" 3 ((1 . 22)) ((unexist (1 . 22))) nil ((modseq) (uidvalidity . "1616920563") (active 1 . 22) (permanent-flags %* %Answered %Flagged %Deleted %Draft %Seen))) ("\345\205\266\344\273\226\346\226\207\344\273\266\345\244\271/Gmail" 3 ((1 . 28)) ((unexist (1 . 28))) nil ((modseq) (uidvalidity . "1654005874") (active 1 . 28) (permanent-flags %* %Answered %Flagged %Deleted %Draft %Seen))) ("nndraft:drafts" 1 nil nil (nndraft "") ((gnus-dummy (gnus-draft-mode))))))

(setq gnus-server-alist '(("archive" nnfolder "archive" (nnfolder-directory "~/.emacs.d/Gnus/Mail/archive") (nnfolder-active-file "~/.emacs.d/Gnus/Mail/archive/active") (nnfolder-get-new-mail nil) (nnfolder-inhibit-expiry t))))

(setq gnus-topic-topology '(("Gnus" visible) (("misc" visible nil nil))))

(setq gnus-topic-alist '(("misc" "nndraft:drafts" "\345\205\266\344\273\226\346\226\207\344\273\266\345\244\271/Gmail" "Junk" "Deleted Messages" "Drafts" "Sent Messages" "INBOX" "\345\205\266\344\273\226\346\226\207\344\273\266\345\244\271") ("Gnus" "dummy.group" "Archives")))
