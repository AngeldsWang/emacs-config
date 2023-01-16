(require 'company)

(use-package lsp-mode
  :ensure t
  :config
  ;; (setq lsp-log-io t)
  (add-hook 'go-mode-hook #'lsp-deferred)
  (add-hook 'python-mode-hook #'lsp-deferred)
  (add-hook 'c++-mode-hook #'lsp-deferred)
  (add-hook 'c-mode-hook #'+c/lsp-deferred)
  (add-hook 'rust-mode-hook #'lsp-deferred)
  (add-hook 'cperl-mode-hook #'lsp-deferred)
  (lsp-register-custom-settings
   '(("gopls.completeUnimported" t t)
     ("gopls.staticcheck" t t)
     ("gopls.memoryMode" "DegradeClosed" nil)))

  :bind
  ("C-c h" . lsp-describe-thing-at-point)
  ("M-0" . lsp-treemacs-symbols)
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

(defun my/lsp-set-priority (server priority)
  (setf (lsp--client-priority (gethash server lsp-clients)) priority))

(defun my/lsp-get-priority (server)
  (lsp--client-priority (gethash server lsp-clients)))

(provide '10-lsp)
