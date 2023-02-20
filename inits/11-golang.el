(add-to-list 'exec-path (concat (getenv "GOPATH") "/bin"))

(use-package go-mode
  :ensure t
  :mode (("\\.go\\'" . go-mode))
  :init
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save))

;; go-tag
(require 'go-tag)
(with-eval-after-load 'go-mode
  (define-key go-mode-map (kbd "C-c t") #'go-tag-add)
  (define-key go-mode-map (kbd "C-c T") #'go-tag-remove))

(require 'go-guru)
(defun asm-mode-setup ()
  (set (make-local-variable 'gofmt-command) "asmfmt")
  (add-hook 'before-save-hook 'gofmt nil t)
)
(add-hook 'asm-mode-hook 'asm-mode-setup)


(require 'go-playground)
;; ensure `Go' to be upper case to make gopls happy
(setq go-playground-basedir (expand-file-name "~/Go/src/playground"))
;; disable modules
(setq go-playground-init-command "")

;; gojson
(defun j2go (struct-name)
  (interactive
   (list (read-string "Struct name: ")))
  (let* ((beg (or (and (use-region-p) (region-beginning)) (point-min)))
         (end (or (and (use-region-p) (region-end)) (point-max)))
         (json (buffer-substring-no-properties beg end)))
    (let ((go-struct (shell-command-to-string (format "echo '%s' | gojson -name=%s" json struct-name))))
      (with-current-buffer (get-buffer-create "*json2go*")
        (read-only-mode -1)
        (erase-buffer)
        (insert go-struct)
        (read-only-mode +1)
        (goto-char (point-min))
        (pop-to-buffer (current-buffer))))))

(provide '11-golang)
