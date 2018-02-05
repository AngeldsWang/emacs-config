(require 'vue-mode)
(add-to-list 'auto-mode-alist '("\\.vue$" . vue-mode))

(defun my-vue-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-indent-style 2)
  (setq js-indent-level 2)
  (setq css-indent-offset 2))

(add-hook 'vue-mode-hook 'my-vue-mode-hook)
(add-hook 'vue-mode-hook 'emmet-mode)

(add-to-list 'vue-mode-hook #'tern-mode)
(setq mmm-js-mode-exit-hook (lambda () (setq tern-mode nil)))
(setq mmm-js-mode-enter-hook (lambda () (setq tern-mode t)))

(provide '35-vue)
