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

(provide '22-rust)
