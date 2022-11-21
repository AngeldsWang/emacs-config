(use-package python
  :mode ("\\.py" . python-mode)
  :ensure t)

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))

(use-package python-black
  :demand t
  :after python
  :hook (python-mode . python-black-on-save-mode))

;; (elpy-enable)

;; (setq elpy-rpc-backend "jedi")
;; (setq elpy-rpc-python-command "python3")

;; (add-hook 'elpy-mode-hook (lambda ()
;;                             (add-hook 'before-save-hook
;;                                       'elpy-black-fix-code nil t)))

;; (when (load "flycheck" t t)
;;   (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
;;   (add-hook 'elpy-mode-hook 'flycheck-mode))

;; (defun my/python-mode-hook ()
;;   (add-to-list 'company-backends 'company-jedi))

;; (add-hook 'python-mode-hook 'my/python-mode-hook)

;; (setq python-shell-interpreter "ipython"
;;       python-shell-interpreter-args "-i --simple-prompt")


(provide '13-py)
