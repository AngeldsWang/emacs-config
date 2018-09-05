(require 'exec-path-from-shell)
(when (memq window-system '(mac ns))
  (setq exec-path-from-shell-arguments '("-l"))
  (setq exec-path-from-shell-check-startup-files nil)
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "PATH")
  (exec-path-from-shell-copy-env "GOPATH"))

(provide '05-exec-path-from-shell)
