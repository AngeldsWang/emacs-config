(require 'exec-path-from-shell)
(when (memq window-system '(mac ns))
  (setq exec-path-from-shell-arguments '("-l"))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOPATH"))

(provide '05-exec-path-from-shell)
