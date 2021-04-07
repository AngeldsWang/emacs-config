(add-to-list 'exec-path (concat (getenv "JAVA_HOME") "/bin"))

(require 'meghanada)
(require 'lsp-java)
(add-hook 'java-mode-hook #'lsp)
(setq lsp-ui-doc-enable nil)

(add-hook 'java-mode-hook
          (lambda ()
            ;; meghanada-mode on
            (meghanada-mode t)
            (flycheck-mode +1)
            ;; use code format
            (add-hook 'before-save-hook 'meghanada-code-beautify-before-save)))

(setq meghanada-java-path "java")
(setq meghanada-maven-path "mvn")

(provide '18-java)
