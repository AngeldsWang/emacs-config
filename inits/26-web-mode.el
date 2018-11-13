(require 'web-mode)
(require 'css-mode)

(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)

(setq web-mode-enable-auto-closing t)
(setq web-mode-enable-auto-opening t)
(setq web-mode-enable-auto-indentation t)

(add-to-list 'auto-mode-alist '("\\.tt$"   . web-mode))
(add-to-list 'auto-mode-alist '("\\.gtpl$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tx$"   . web-mode))
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb$"  . web-mode))
(add-to-list 'auto-mode-alist '("\\.twig$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mt$"   . web-mode))

;; bind engines
(setq web-mode-engines-alist
      '(("django" . "\\.html\\'")
        ("go"     . "\\.tmpl\\'")))

;; Use multiple-cursors to rename tags
(define-key web-mode-map (kbd "C-c C-r") 'mc/mark-sgml-tag-pair)

;; no Disable over zealous pairing
(setq web-mode-enable-auto-pairing t)

(require 'scss-mode)
(setq scss-compile-at-save nil)

(require 'sgml-mode)

(require 'emmet-mode)

(defun setup-emmet (map hook)
  "Setup emmet key bindings for MAP and HOOK."
  (add-hook hook 'emmet-mode)
  (define-key map (kbd "C-c .") 'emmet-next-edit-point)
  (define-key map (kbd "C-c ,") 'emmet-prev-edit-point)
  (define-key map (kbd "C-c j") 'emmet-expand-line))

(setup-emmet html-mode-map 'html-mode-hook)
(setup-emmet web-mode-map 'web-mode-hook)
(setup-emmet css-mode-map 'css-mode-hook)

(define-key emmet-mode-keymap (kbd "C-j") nil)
(setq emmet-move-cursor-between-quotes t)
(setq emmet-move-cursor-after-expanding t)

(defun my/web-mode-hook ()
    (turn-off-smartparens-mode))
(add-hook 'web-mode-hook 'my/web-mode-hook)

(provide '26-web-mode)
