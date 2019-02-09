(require 'xs-mode "./others/xs-mode.el")
(add-to-list 'auto-mode-alist '("\\.xs$" . xs-mode))
(add-hook 'xs-mode-hook
          (lambda ()
            (c-toggle-electric-state -1)
            (setq c-auto-newline nil)
            (remove-hook 'before-save-hook 'clang-format-buffer 'local)))

(defun xs-perldoc ()
  (interactive)
  (let* ((docs-alist '(("perlapi") ("perlxs") ("perlguts")
                 ("perlcall") ("perlclib") ("perlxstut")))
         (manual-program "perldoc")
         (input (completing-read "perldoc entry: " docs-alist)))
    (if input
        (manual-entry input)
      (error "no input"))))


(provide '23-xs)
