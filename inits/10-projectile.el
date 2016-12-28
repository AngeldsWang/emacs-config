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

(provide '10-projectile)
