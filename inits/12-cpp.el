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

(require 'irony)
(defun my-irony-mode-on ()
  ;; avoid enabling irony-mode in modes that inherits c-mode, e.g: php-mode
  (when (member major-mode irony-supported-major-modes)
    (irony-mode 1)))

(add-hook 'c-mode-hook 'my-irony-mode-on)
(add-hook 'c++-mode-hook 'my-irony-mode-on)
(add-hook 'objc-mode-hook 'my-irony-mode-on)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook 'flycheck-irony-setup))

(add-to-list 'company-backends 'company-c-headers)

(global-set-key (kbd "C-x C-o") 'ff-find-other-file)

(define-key c-mode-map (kbd "<f4>") #'compile)
(define-key c++-mode-map (kbd "<f4>") #'compile)

(add-hook 'c-mode-hook
          (lambda ()
            (setq compile-command 
                  (concat "clang -Wall -Werror -std=c11 -ggdb -O0 " buffer-file-name " -o " (file-name-base buffer-file-name) ))))
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

(require 'clang-format)
(custom-set-variables
 '(clang-format-style "{BasedOnStyle: Google, IndentWidth: 4, ColumnLimit: 120}"))

(global-set-key (kbd "C-c C-r") 'clang-format-region)
(global-set-key (kbd "C-c C-f") 'clang-format-buffer)

(add-hook 'c-mode-hook (lambda() (add-hook 'before-save-hook 'clang-format-buffer nil t)))
(add-hook 'c++-mode-hook (lambda() (add-hook 'before-save-hook 'clang-format-buffer nil t)))

(require 'flycheck)
(add-hook 'c-mode-hook (lambda () (setq flycheck-clang-language-standard "c11")))
(add-hook 'c++-mode-hook (lambda () (setq flycheck-clang-language-standard "c++11")))

(provide '12-cpp)
