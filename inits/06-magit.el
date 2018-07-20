(require 'magit)

(defun magit-quit-session ()
  "Restore the previous window configuration and kill the magit buffer."
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen))

(define-key magit-status-mode-map (kbd "q") 'magit-quit-session)

(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)

(defun magit-push-to-gerrit ()
  (interactive)
  (magit-git-command-topdir "git push origin HEAD:refs/for/master"))

(magit-define-popup-action 'magit-push-popup
  ?m
  "Push to gerrit"
  'magit-push-to-gerrit)

(provide '06-magit)
