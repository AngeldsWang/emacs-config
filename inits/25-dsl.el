(require 'jsonnet-mode)
(require 'groovy-mode)
(require 'kotlin-mode)

;; jsonnet
(add-to-list 'auto-mode-alist '("\\.libsonnet$" . jsonnet-mode))

;; groovy
(add-to-list 'auto-mode-alist '("\\Jenkinsfile$", groovy-mode))
(add-to-list 'auto-mode-alist '("\\*.gradle$", groovy-mode))

;; kotlin
(add-to-list 'auto-mode-alist '("\\.kt$" . kotlin-mode))
(add-to-list 'auto-mode-alist '("\\.kts$" . kotlin-mode))

(provide '25-dsl)
