(add-to-list 'exec-path (concat (getenv "GOPATH") "/bin"))
(defun lsp-go-install-save-hooks()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))

(use-package go-mode
  :ensure t
  :mode (("\\.go\\'" . go-mode))
  :init
  (setq gofmt-command "goimports")
  (add-hook 'go-mode-hook #'lsp-go-install-save-hooks))

(require 'go-guru)
(defun asm-mode-setup ()
  (set (make-local-variable 'gofmt-command) "asmfmt")
  (add-hook 'before-save-hook 'gofmt nil t)
)
(add-hook 'asm-mode-hook 'asm-mode-setup)

;; ensure `Go' to be upper case to make gopls happy
(require 'go-playground)
(setq go-playground-basedir (expand-file-name "~/Go/src/playground"))

(provide '11-golang)
