(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

(add-hook 'markdown-mode 'longlines-mode)

(setq markdown-command "/usr/local/bin/multimarkdown")
;;(setq markdown-css-paths `(,(expand-file-name "markdown.css" ~/.emacs.d/plugins)))

(custom-set-variables '(markdown-preview-style "http://thomasf.github.io/solarized-css/solarized-light.min.css"))
(global-set-key (kbd "C-c C-v") 'markdown-preview-mode)

(provide '20-markdown)
