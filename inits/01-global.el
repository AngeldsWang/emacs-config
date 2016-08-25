(setq inhibit-startup-screen t)
(tool-bar-mode -1)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-hook 'window-setup-hook 'toggle-frame-fullscreen t)
(load-theme 'zenburn t)
(scroll-bar-mode -1)
(eval-when-compile (require 'cl))
;; font and size
(set-default-font "monaco-9")
;; code indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(global-hl-line-mode 1)
(setq indent-line-function 'insert-tab)

;; copy (M + w) and cut (C + w) without selection
(defun slick-cut (beg end)
  (interactive
   (if mark-active
       (list (region-beginning) (region-end))
     (list (line-beginning-position) (line-beginning-position 2)))))

(advice-add 'kill-region :before #'slick-cut)

(defun slick-copy (beg end)
  (interactive
   (if mark-active
       (list (region-beginning) (region-end))
     (message "Copied line")
     (list (line-beginning-position) (line-beginning-position 2)))))

(advice-add 'kill-ring-save :before #'slick-copy)

(setq ag-highlight-search t)

(require 'yasnippet)
(yas-global-mode 1)

(add-hook 'after-init-hook 'global-company-mode)
(add-to-list 'company-backends 'company-tern)

(require 'desktop)
(setq desktop-path (list "~/.emacs-server"))
(desktop-save-mode 1)

(require 'wgrep)

(provide '01-global)
