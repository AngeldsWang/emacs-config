(autoload 'es-mode "es-mode.el"
  "Major mode for editing Elasticsearch queries" t)
(add-to-list 'auto-mode-alist '("\\.es$" . es-mode))

(add-hook 'es-result-mode-hook 'hs-minor-mode)

(setq  es-default-url "http://localhost:9200/_search?pretty=true")

(setq es-always-pretty-print t)

(provide '54-es)
