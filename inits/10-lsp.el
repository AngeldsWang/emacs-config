(require 'company)

(use-package lsp-mode
  :ensure t
  :config  
  (add-hook 'go-mode-hook #'lsp)
  (add-hook 'python-mode-hook #'lsp)
  (add-hook 'c++-mode-hook #'lsp)
  (add-hook 'c-mode-hook #'+c/lsp)
  (add-hook 'rust-mode-hook #'lsp)
  (add-hook 'cperl-mode-hook #'lsp)
  (lsp-register-custom-settings
   '(("gopls.completeUnimported" t t)
     ("gopls.staticcheck" t t)
     ("gopls.memoryMode" "DegradeClosed" nil)))

  :bind ("C-c h" . lsp-describe-thing-at-point)
  :custom
  (lsp-rust-server 'rust-analyzer)
  (lsp-enable-file-watchers nil)
  (lsp-diagnostics-attributes
        `((unnecessary :foreground "light slate grey")
          (deprecated  :strike-through t)))

  (setq company-minimum-prefix-length 1
        company-idle-delay 0.500)
  
  (require 'lsp-clients) 
  :commands lsp)

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(setq lsp-headerline-breadcrumb-enable nil)
(setq lsp-ui-doc-enable nil)

(defun +c/lsp ()
  (unless (member major-mode '(ragel-mode flex-mode bison-mode))
    (lsp)))

(advice-add 'lsp :before (lambda (&rest _args) (eval '(setf (lsp-session-server-id->folders (lsp-session)) (ht)))))

(provide '10-lsp)
