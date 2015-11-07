(setq inhibit-startup-screen t)
(tool-bar-mode -1)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(load-theme 'zenburn t)
(scroll-bar-mode -1)
(global-linum-mode t)
(eval-when-compile (require 'cl))
;; font and size
(set-default-font "monaco-10")
;; code indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

(provide '01-global)