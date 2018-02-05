(require 'clojure-mode)

(require 'cider)
;; clojure-mode で cider を有効に
(add-hook 'clojure-mode-hook 'cider-mode)
;; eldoc を有効にする
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

(require '4clojure)

(require 'ac-cider)
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
  (eval-after-load "auto-complete"
    '(progn
       (add-to-list 'ac-modes 'cider-mode)
       (add-to-list 'ac-modes 'cider-repl-mode)))

;; (require 'clojure-cheatsheet)
;; (define-key clojure-mode-map (kbd "C-c C-h") #'clojure-cheatsheet)

(require 'clj-refactor)

(defun my-clojure-mode-hook ()
    (clj-refactor-mode 1)
    (yas-minor-mode 1) ; for adding require/use/import statements
    ;; This choice of keybinding leaves cider-macroexpand-1 unbound
    (cljr-add-keybindings-with-prefix "C-c C-m"))

(add-hook 'clojure-mode-hook #'my-clojure-mode-hook)

(provide '18-clj)
