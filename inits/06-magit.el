(require 'magit)

(define-key magit-status-mode-map (kbd "q") 'magit-mode-bury-buffer)

(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)

;; https://emacs.stackexchange.com/questions/52001/magit-popup-doesnt-open-in-status-buffer
(setq transient-display-buffer-action '(display-buffer-below-selected))

(defun magit-push-to-gerrit ()
  (interactive)
  (magit-git-command-topdir "git push origin HEAD:refs/for/master"))

(transient-append-suffix 'magit-push "m"
  '("g" "Push to gerrit" magit-push-to-gerrit))

(provide '06-magit)
