(require 'company)

(use-package lsp-mode
  :ensure t
  :config
  (add-hook 'go-mode-hook #'lsp)
  (add-hook 'python-mode-hook #'lsp)
  (add-hook 'c++-mode-hook #'lsp)
  (add-hook 'c-mode-hook #'lsp)
  (add-hook 'rust-mode-hook #'lsp)

  :bind ("C-c h" . lsp-describe-thing-at-point)
  :custom (lsp-rust-server 'rust-analyzer)

  (setq company-minimum-prefix-length 1
        company-idle-delay 0.500)
  (require 'lsp-clients)
  :commands lsp)

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(use-package company-lsp
  :ensure t
  :commands company-lsp)

(setq lsp-headerline-breadcrumb-enable nil)

(provide '10-lsp)
