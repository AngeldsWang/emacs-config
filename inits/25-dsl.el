;; jsonnet
(use-package jsonnet-mode
  :mode "\\.jsonnet\\'" "\\.libsonnet\\'"

  :hook
  (jsonnet-mode . my-jsonnet-mode-setup)

  :custom
  (jsonnet-library-search-directories '("vendor"))

  :preface
  (defun my-jsonnet-mode-setup ()
    (jsonnet-format-buffer-on-save-mode t))

  :config
  (with-eval-after-load 'flycheck
    (setq flycheck-jsonnet-executable "jsonnet -jpath vendor"))

  (define-minor-mode jsonnet-format-buffer-on-save-mode
    "Run jsonnet-format-buffer as a before-save-hook."
    :lighter " fmt"
    (if jsonnet-format-buffer-on-save-mode
        (add-hook 'before-save-hook 'jsonnet-reformat-buffer t t)
      (remove-hook 'before-save-hook 'jsonnet-reformat-buffer t))))

;; take from https://github.com/grafana/jsonnet-language-server/blob/main/editor/emacs/jsonnet-language-server.el
(require 'jsonnet-mode)
(require 'lsp-mode)

(defcustom lsp-jsonnet-executable "jsonnet-language-server"
  "Command to start the Jsonnet language server."
  :group 'lsp-jsonnet
  :risky t
  :type 'file)

;; Configure lsp-mode language identifiers.
(add-to-list 'lsp-language-id-configuration '(jsonnet-mode . "jsonnet"))

;; Register jsonnet-language-server with the LSP client.
(lsp-register-client
 (make-lsp-client
  :new-connection (lsp-stdio-connection (lambda () lsp-jsonnet-executable))
  :activation-fn (lsp-activate-on "jsonnet")
  :server-id 'jsonnet))

;; Start the language server whenever jsonnet-mode is used.
(add-hook 'jsonnet-mode-hook #'lsp-deferred)

;; ------------------------------------------------------------------------------------

;; groovy
(require 'groovy-mode)
(add-to-list 'auto-mode-alist '("\\Jenkinsfile$", groovy-mode))
(add-to-list 'auto-mode-alist '("\\*.gradle$", groovy-mode))

;; ------------------------------------------------------------------------------------

;; kotlin
(require 'kotlin-mode)
(add-to-list 'auto-mode-alist '("\\.kt$" . kotlin-mode))
(add-to-list 'auto-mode-alist '("\\.kts$" . kotlin-mode))

(provide '25-dsl)
