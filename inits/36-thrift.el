(require 'thrift)

(add-hook 'thrift-mode-hook
      (lambda () (setq thrift-indent-level 4)))

(provide '36-thrift)
