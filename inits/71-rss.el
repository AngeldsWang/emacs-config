(require 'elfeed-org)
(elfeed-org)
(setq rmh-elfeed-org-files (list "~/.emacs.d/inits/others/rss_feed.org"))

(use-package elfeed
  :ensure t
  :commands
  (elfeed)
  :hook ((elfeed-search-mode . my/elfeed-set-style))
  :custom
  (elfeed-curl-timeout 120)
  (elfeed-search-filter "@10-week-ago +unread ")
  (elfeed-search-title-max-width 120)
  :bind
  (:map elfeed-search-mode-map
        ("a" . elfeed-update))
  :config
  (elfeed-update)
  (run-with-timer 0 (* 60 15) 'elfeed-update)
  (setq elfeed-show-entry-switch #'my/elfeed-show-entry
        elfeed-show-entry-delete #'my/elfeed-kill-buffer)

  :init
  (defun my/elfeed-set-style ()
    ;; Separate elfeed lines for readability.
    (setq line-spacing 5))
  (defun my/elfeed-show-entry (buff)
    (popwin:popup-buffer buff
                         :position 'right
                         :width 0.5
                         :dedicated t
                         :stick t))

  (defun my/elfeed-kill-buffer ()
    (interactive)
    (let ((window (get-buffer-window (get-buffer "*elfeed-entry*"))))
      (kill-buffer (get-buffer "*elfeed-entry*"))
      (delete-window window)))
)

(use-package elfeed-summary
  :ensure t
  :after elfeed
  :commands (elfeed-summary)
  :custom
  (elfeed-summary-filter-by-title t)
)

(use-package elfeed-tube
  :ensure t
  :after elfeed
  :demand t
  :config
  (elfeed-tube-setup)
)

(use-package elfeed-tube-mpv
  :ensure t
  :after elfeed-tube
  :bind (:map elfeed-show-mode-map
              ("C-c C-f" . elfeed-tube-mpv-follow-mode)
              ("C-c C-w" . elfeed-tube-mpv-where))
)

(provide '71-rss)
