(require 'ansible)
(require 'ansible-vault)
(require 'yaml-mode)

(add-to-list 'auto-mode-alist '("\\.yaml\\'"    . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml.j2\\'" . yaml-mode))

(add-hook 'yaml-mode-hook '(lambda () (ansible 1)))

(add-to-list 'auto-mode-alist '("/encrypted$" . yaml-mode))

(add-hook 'yaml-mode-hook
  (lambda ()
    (and (string= (file-name-base) "encrypted") (ansible-vault-mode 1))))

(provide '29-ansible)
