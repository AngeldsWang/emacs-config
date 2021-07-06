(require 'ocamlformat)

(let ((opam-share (ignore-errors (car (process-lines "opam" "config" "var" "share")))))
 (when (and opam-share (file-directory-p opam-share))
   (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
   (require 'dune)
   (add-to-list 'auto-mode-alist '("/dune\\'" . dune-mode))))

(when (maybe-require-package 'tuareg)
  (when (maybe-require-package 'merlin)
    (autoload 'merlin-mode "merlin" "Merlin mode" t)
    (add-hook 'tuareg-mode-hook 'merlin-mode)

    (with-eval-after-load 'merlin
      (with-eval-after-load 'company
        (push 'merlin-company-backend company-backends)))

    (when (maybe-require-package 'merlin-eldoc)
      (with-eval-after-load 'merlin
        (autoload 'merlin-eldoc--gather-info "merlin-eldoc")
        (add-hook 'merlin-mode-hook
                  (lambda ()
                    (setq-local eldoc-documentation-function
                                #'merlin-eldoc--gather-info)))))
    )
  )

(require 'merlin)
(define-key merlin-mode-map "\M-." 'merlin-locate)
(define-key merlin-mode-map "\M-," 'merlin-pop-stack)

(add-hook 'tuareg-mode-hook (lambda ()
                              (add-hook 'before-save-hook #'ocamlformat-before-save)))

(when (maybe-require-package 'reformatter)
  (defcustom ocp-indent-args nil
    "Arguments for \"ocp-indent\" invocation.")

  (reformatter-define ocp-indent
    :program "ocp-indent"
    :args ocp-indent-args
    :lighter " OCP"))

(provide '15-ml)
