(use-package graphql-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.graphqls\\'" . graphql-mode))
  (add-to-list 'auto-mode-alist '("\\.graphql\\'" . graphql-mode))
  (add-to-list 'auto-mode-alist '("\\.gqls\\'" . graphql-mode))
  (add-to-list 'auto-mode-alist '("\\.gql\\'" . graphql-mode)))

(provide '25-gql)
