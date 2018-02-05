(require 'rust-mode)
(add-to-list 'exec-path (expand-file-name "~/.cargo/bin/"))
(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)

(eval-after-load "rust-mode"
  '(setq-default rust-format-on-save t))

;; Formatting using rustfmt
(defun rust--format-call (buf)
  "Format BUF using rustfmt."
  (with-current-buffer (get-buffer-create "*rustfmt*")
    (erase-buffer)
    (insert-buffer-substring buf)
    (let* ((tmpf (make-temp-file "rustfmt"))
           (ret (call-process-region (point-min) (point-max) rust-rustfmt-bin
                                     t `(t ,tmpf) nil)))
      (unwind-protect
          (cond
           ((zerop ret)
            (if (not (string= (buffer-string)
                              (with-current-buffer buf (buffer-string))))
                (copy-to-buffer buf (point-min) (point-max)))
            (kill-buffer))
           ((= ret 3)
            (let ((buffer-read-only nil))
              (if (not (string= (buffer-string)
                                (with-current-buffer buf (buffer-string))))
                  (copy-to-buffer buf (point-min) (point-max)))
              (erase-buffer)
              (insert-file-contents tmpf)
              (error "Rustfmt could not format some lines, see *rustfmt* buffer for details")))
           (t
            (erase-buffer)
            (insert-file-contents tmpf)
            (error "Rustfmt failed, see *rustfmt* buffer for details"))))
      (delete-file tmpf))))


(add-hook 'racer-mode-hook (lambda ()
                             (company-mode-on)
                             (set (make-variable-buffer-local 'company-idle-delay) 1.5)
                             (set (make-variable-buffer-local 'company-minimum-prefix-length) 2)))

(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(define-key rust-mode-map (kbd "C-c C-d") 'racer-describe)

(setq company-tooltip-align-annotations t)


(provide '22-rust)
