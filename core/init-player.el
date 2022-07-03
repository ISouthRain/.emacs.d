
(use-package bongo
  :ensure t
  :bind ("C-<f9>" . bongo)
  :config
  (with-eval-after-load 'dired
    (with-no-warnings
      (defun bongo-add-dired-files ()
        "Add marked files to the Bongo library."
        (interactive)
        (bongo-buffer)
        (let (file (files nil))
          (dired-map-over-marks
           (setq file (dired-get-filename)
                 files (append files (list file)))
           nil t)
          (with-bongo-library-buffer
           (mapc 'bongo-insert-file files)))
        (bongo-switch-buffers))
      (bind-key "b" #'bongo-add-dired-files dired-mode-map)))
      (when sr/is-windows
        (setq bongo-default-directory "F:\\MyFile\\Music"))
      (when sr/is-linux
        (setq bongo-default-directory "~/MyFile/Music/"))
        (setq bongo-enabled-backends '(mplayer))
	)

  ;; Music Player Daemon
  ;; Built-in client for mpd

  (when (executable-find "mpc")
  (use-package mpc
    :ensure nil
    :bind ("s-<f9>" . mpc)
    :config
    (defun restart-mpd ()
      (interactive)
      (call-process "pkill" nil nil nil "mpd")
      (call-process "mpd"))

    (with-no-warnings
      (defun add-mpc-status-to-mode-line ()
        "Display current song in mode line."
        (add-to-list 'global-mode-string '("" mpc-current-song)))
      (advice-add #'mpc :after #'add-mpc-status-to-mode-line))))

  ;; Simple client for mpd
  (when (executable-find "mpc")
    (use-package simple-mpc
      :ensure t
      :bind ("M-<f9>" . simple-mpc)))

(use-package emms
  :ensure t
  :commands emms
  :config
  (require 'emms-setup)
  (emms-standard)
  (emms-default-players)
  (emms-mode-line-disable)
  (setq emms-source-file-default-directory "F:\\MyFile\\Music"))

(provide 'init-player)
