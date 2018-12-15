(require 'mermaid-mode "./others/mermaid.el")
(require 'ob-mermaid)

(add-to-list 'auto-mode-alist '("\\.merm$" . mermaid-mode))

(setq ob-mermaid-cli-path "/usr/local/bin/mmdc")

(provide '81-mermaid-mode)
