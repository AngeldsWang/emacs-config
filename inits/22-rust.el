(add-to-list 'exec-path (expand-file-name "~/.cargo/bin/"))
(use-package rust-mode
  :ensure t
  :custom rust-format-on-save t)

(use-package cargo
  :ensure t
  :hook (rust-mode . cargo-minor-mode))

;; playground
(require 'rust-playground)
(setq rust-playground-basedir (expand-file-name "~/work/my/rs/playground"))
(add-hook 'rust-playground-mode-hook (lambda ()
                                       (local-set-key (kbd "<C-return>") 'rust-playground-exec)))

(provide '22-rust)
