(require 'projectile)

(projectile-global-mode)
(setq projectile-enable-caching t)
(setq projectile-file-exists-remote-cache-expire nil)
(setq projectile-require-project-root nil)
(setq projectile-completion-system 'helm)
(require 'helm-projectile)
(helm-projectile-on)

;;(require 'projectile-speedbar)
(add-hook 'projectile-mode-hook 'projectile-rails-on)
(require 'go-projectile)

(defadvice projectile-on (around exlude-tramp activate)
    "This should disable projectile when visiting a remote file"
    (unless  (--any? (and it (file-remote-p it))
                     (list
                      (buffer-file-name)
                      list-buffers-directory
                      default-directory
                      dired-directory))
      ad-do-it))

;; don't try to find project name. Should speed up tramp sessions
(setq projectile-mode-line "Projectile")

(provide '10-projectile)
