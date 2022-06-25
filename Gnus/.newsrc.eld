;; -*- mode:emacs-lisp; coding: utf-8-emacs-dos; -*-
;; Gnus startup file.
;; Never delete this file -- if you want to force Gnus to read the
;; .newsrc file (if you have one), touch .newsrc instead.
(setq gnus-newsrc-file-version "Gnus v5.13")

(setq gnus-newsrc-last-checked-date '"Sat, 25 Jun 2022 19:29:07 +0800")

(setq gnus-newsrc-alist '(("INBOX" 3 ((1 . 1291) 1295) ((unexist (1 . 1291))) nil ((modseq . "197206") (uidvalidity . "1") (active 1292 . 1303) (permanent-flags %Answered %Flagged %Draft %Deleted %Seen $NotJunk $NotPhishing $Phishing NotJunk %*))) ("[Gmail]/All Mail" 3 ((1 . 1461) 1465) ((unexist (1 . 1460)) (tick 1461)) nil ((modseq . "197206") (uidvalidity . "12") (active 1461 . 1473) (permanent-flags %Answered %Flagged %Draft %Deleted %Seen $NotJunk $NotPhishing $Phishing NotJunk %*))) ("[Gmail]/Bin" 3 (1 . 1356) ((unexist (1 . 1355)) (seen (1357 . 1359))) nil ((modseq . "197264") (uidvalidity . "2") (active 1356 . 1360) (timestamp . 1656156569) (permanent-flags %Answered %Flagged %Draft %Deleted %Seen $NotJunk $NotPhishing $Phishing NotJunk %*))) ("[Gmail]/Drafts" 3 ((1 . 104)) ((unexist (1 . 104))) nil ((modseq . "197206") (uidvalidity . "6") (active 105 . 104) (permanent-flags %Answered %Flagged %Draft %Deleted %Seen $NotJunk $NotPhishing $Phishing NotJunk %*))) ("[Gmail]/Important" 3 ((1 . 493) 496) ((unexist (1 . 492)) (seen (493 . 499)) (tick 493)) nil ((timestamp . 1656156578) (modseq . "197206") (uidvalidity . "9") (active 493 . 499) (permanent-flags %Answered %Flagged %Draft %Deleted %Seen $NotJunk $NotPhishing $Phishing NotJunk %*))) ("[Gmail]/Sent Mail" 3 ((1 . 60)) ((unexist (1 . 60))) nil ((modseq . "197206") (uidvalidity . "5") (active 61 . 61) (permanent-flags %Answered %Flagged %Draft %Deleted %Seen $NotJunk $NotPhishing $Phishing NotJunk %*))) ("[Gmail]/Spam" 3 ((1 . 12)) ((unexist (1 . 12))) nil ((modseq . "197206") (uidvalidity . "3") (active 13 . 12) (permanent-flags %Answered %Flagged %Draft %Deleted %Seen $NotJunk $NotPhishing $Phishing NotJunk %*))) ("[Gmail]/Starred" 3 ((1 . 13)) ((unexist (1 . 12)) (tick 13)) nil ((modseq . "197206") (uidvalidity . "4") (active 13 . 13) (permanent-flags %Answered %Flagged %Draft %Deleted %Seen $NotJunk $NotPhishing $Phishing NotJunk %*))) ("nndraft:drafts" 1 nil nil (nndraft "") ((gnus-dummy (gnus-draft-mode))))))

(setq gnus-server-alist '(("archive" nnfolder "archive" (nnfolder-directory "~/.emacs.d/Gnus/Mail/archive") (nnfolder-active-file "~/.emacs.d/Gnus/Mail/archive/active") (nnfolder-get-new-mail nil) (nnfolder-inhibit-expiry t))))

(setq gnus-topic-topology '(("Gnus" visible) (("misc" visible))))

(setq gnus-topic-alist '(("misc" "nndraft:drafts" "[Gmail]/Starred" "[Gmail]/Spam" "[Gmail]/Sent Mail" "[Gmail]/Important" "[Gmail]/Drafts" "[Gmail]/Bin" "[Gmail]/All Mail" "INBOX") ("Gnus")))
