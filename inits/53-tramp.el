(require 'tramp)
(setq tramp-default-method "ssh")

(defadvice projectile-project-root (around ignore-remote first activate)
  (unless (file-remote-p default-directory) ad-do-it))
;; (add-hook 'helm-tramp-pre-command-hook '(lambda ()
;;                                           (projectile-mode 0)))
;; (add-hook 'helm-tramp-quit-hook '(lambda ()
;;                                    (projectile-mode 1)))

;; ;; speed up tramp
(setq remote-file-name-inhibit-cache nil)
(setq vc-ignore-dir-regexp
      (format "%s\\|%s"
                    vc-ignore-dir-regexp
                    tramp-file-name-regexp))
(setq tramp-verbose 1)

(setq make-backup-files nil)
(setq create-lockfiles nil)
(add-to-list 'tramp-remote-path 'tramp-own-remote-path)

(provide '53-tramp)
