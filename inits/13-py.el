(elpy-enable)

(setq elpy-rpc-backend "jedi")

(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))

(add-hook 'python-mode-hook 'my/python-mode-hook)

(provide '13-py)
