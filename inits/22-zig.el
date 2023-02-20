(use-package zig-mode
  :hook ((zig-mode . lsp-deferred))
  :ensure t :after lsp-mode
  :custom (zig-format-on-save nil)
  :config
  (add-to-list 'lsp-language-id-configuration '(zig-mode . "zig"))
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection "/usr/local/bin/zls")
    :major-modes '(zig-mode)
    :server-id 'zls)))

(provide '22-zig)
