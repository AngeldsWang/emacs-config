(require 'cc-mode)
(require 'google-c-style)
(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cuh\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-hook 'c-mode-common-hook
          (lambda ()
            (google-set-c-style)
            (google-make-newline-indent)
            (setq c-basic-offset 4)
            (electric-pair-mode -1)))

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook 'flycheck-irony-setup))

(add-to-list 'company-backends 'company-c-headers)

(define-key c++-mode-map (kbd "<f4>") #'compile)

(add-hook 'c++-mode-hook
          (lambda ()
            (setq compile-command 
                  (concat "clang++ -Wall -Werror -std=c++11 -ggdb -O0 " buffer-file-name " -o " (file-name-base buffer-file-name) ))))

;; set gdb
(setq
 ;; use gdb-many-windows by default
 gdb-many-windows t

 ;; Non-nil means display source file containing the main routine at startup
 gdb-show-main t)

(provide '14-cpp)
