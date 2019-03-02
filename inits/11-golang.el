(require 'go-mode)
(add-to-list 'auto-mode-alist '("\\.go$" . go-mode))

(setenv "GOPATH" "/Users/wangzhenjun/Go")

(setenv "PATH" (format "%s/bin:%s" (getenv "GOPATH") (getenv "PATH")))

(add-to-list 'exec-path "/Users/wangzhenjun/Go/bin")

(require 'go-autocomplete)
(require 'auto-complete-config)
(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
(ac-config-default)
;; speedbar
;;(speedbar 1)
;;(speedbar-add-supported-extension ".go")

(add-hook
'go-mode-hook
'(lambda ()
    ;; gocode
    (auto-complete-mode 1)
    (setq ac-sources '(ac-source-go))
    ;; Imenu & Speedbar
    (setq imenu-generic-expression
        '(("type" "^type *\\([^ \t\n\r\f]*\\)" 1)
        ("func" "^func *\\(.*\\) {" 1)))
    (imenu-add-to-menubar "Index")
    ;; Outline mode
    (make-local-variable 'outline-regexp)
    (setq outline-regexp "//\\.\\|//[^\r\n\f][^\r\n\f]\\|pack\\|func\\|impo\\|cons\\|var.\\|type\\|\t\t*....")
    (outline-minor-mode 1)
    (local-set-key "\M-a" 'outline-previous-visible-heading)
    (local-set-key "\M-e" 'outline-next-visible-heading)
    ;; Menu bar
    (require 'easymenu)
    (defconst go-hooked-menu
        '("Go tools"
        ["Go run buffer" go t]
        ["Go reformat buffer" go-fmt-buffer t]
        ["Go check buffer" go-fix-buffer t]))
    (easy-menu-define
        go-added-menu
        (current-local-map)
        "Go tools"
        go-hooked-menu)

    ;; Other
    (setq show-trailing-whitespace t)
    ))
;; helper function
(defun go ()
    "run current buffer"
    (interactive)
    (compile (concat "go run " (buffer-file-name))))

;; helper function
(defun go-fmt-buffer ()
    "run gofmt on current buffer"
    (interactive)
    (if buffer-read-only
    (progn
        (ding)
        (message "Buffer is read only"))
    (let ((p (line-number-at-pos))
    (filename (buffer-file-name))
    (old-max-mini-window-height max-mini-window-height))
        (show-all)
        (if (get-buffer "*Go Reformat Errors*")
    (progn
        (delete-windows-on "*Go Reformat Errors*")
        (kill-buffer "*Go Reformat Errors*")))
        (setq max-mini-window-height 1)
        (if (= 0 (shell-command-on-region (point-min) (point-max) "gofmt" "*Go Reformat Output*" nil "*Go Reformat Errors*" t))
    (progn
        (erase-buffer)
        (insert-buffer-substring "*Go Reformat Output*")
        (goto-char (point-min))
        (forward-line (1- p)))
    (with-current-buffer "*Go Reformat Errors*"
    (progn
        (goto-char (point-min))
        (while (re-search-forward "<standard input>" nil t)
        (replace-match filename))
        (goto-char (point-min))
        (compilation-mode))))
        (setq max-mini-window-height old-max-mini-window-height)
        (delete-windows-on "*Go Reformat Output*")
        (kill-buffer "*Go Reformat Output*"))))
;; helper function
(defun go-fix-buffer ()
    "run gofix on current buffer"
    (interactive)
    (show-all)
    (shell-command-on-region (point-min) (point-max) "go tool fix -diff"))


(defun my-go-mode-hook ()
  ; set tab-width
  (add-hook 'before-save-hook 'gofmt-before-save)
  (setq tab-width 4)
  (setq indent-tabs-mode 1)

  ; Use goimports instead of go-fmt
  (setq gofmt-command "goimports")
  ; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet"))
  ; Godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-*") 'pop-tag-mark))

(add-hook 'go-mode-hook 'my-go-mode-hook)

(with-eval-after-load 'go-mode
  (define-key go-mode-map (kbd "C-c t") #'go-add-tags))

(require 'go-guru)

(provide '11-golang)
