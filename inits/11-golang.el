(add-to-list 'exec-path (concat (getenv "GOPATH") "/bin"))

(use-package go-mode
  :ensure t
  :mode (("\\.go\\'" . go-mode))
  :init
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save))

;; go-tags
(with-eval-after-load 'go-mode
  (define-key go-mode-map (kbd "C-c t") #'go-add-tags))

(require 'go-guru)
(defun asm-mode-setup ()
  (set (make-local-variable 'gofmt-command) "asmfmt")
  (add-hook 'before-save-hook 'gofmt nil t)
)
(add-hook 'asm-mode-hook 'asm-mode-setup)


(require 'go-playground)
;; ensure `Go' to be upper case to make gopls happy
it's weird  to make code happy. Does it really exist? 
(setq go-playground-basedir (expand-file-name "~/Go/src/playground"))
;; disable modules
(setq go-playground-init-command "")

(provide '11-golang)
