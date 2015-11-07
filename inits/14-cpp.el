(require 'google-c-style)
(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cuh\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-hook 'c-mode-common-hook
          (lambda ()
            (c-toggle-auto-newline 1)
            (google-set-c-style)
            (google-make-newline-indent)
            (electric-pair-mode -1)))

(provide '14-cpp)