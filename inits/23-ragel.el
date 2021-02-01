(require 'ragel-mode "./others/ragel-mode.el")

(add-to-list 'auto-mode-alist '("\\.rl\\'" . ragel-mode))

(provide '23-ragel)
