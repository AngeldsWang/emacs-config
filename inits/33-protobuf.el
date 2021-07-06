(require 'protobuf-mode)
(add-to-list 'auto-mode-alist '("\\.proto" . protobuf-mode))

(require 'flycheck)
(flycheck-define-checker protobuf-prototool
  "prototool syntax checker"
  :command ("prototool" "lint"
            (eval (expand-file-name (buffer-file-name))))
  :error-patterns
  ((error line-start (file-name) ":" line ":" column
          ":" (message) line-end))
  :modes protobuf-mode
  :predicate (lambda () (buffer-file-name)))

(add-hook 'protobuf-mode-hook
          (lambda ()
            (flycheck-mode t)
            (setq flycheck-checker 'protobuf-prototool)))

(provide '33-protobuf)
