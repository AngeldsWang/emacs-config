(require 'cperl-mode)
(defalias 'perl-mode 'cperl-mode)
(add-to-list 'auto-mode-alist '("\\.psgi$" . perl-mode))
(add-to-list 'auto-mode-alist '("\\.t$" . perl-mode))

(add-to-list 'exec-path (concat (getenv "HOME") "/.plenv/shims"))

(setq cperl-indent-level 4)
(setq cperl-continued-statement-offset 4)
(setq cperl-brace-offset -4)
(setq cperl-label-offset -4)
(setq cperl-indent-parens-as-block t)
(setq cperl-close-paren-offset -4)
(setq cperl-tab-always-indent t)
(setq cperl-highlight-variables-indiscriminately t)

;; cperl-mode
(eval-after-load 'cperl-mode
  '(progn
     (set-face-attribute 'cperl-array-face nil
                         :foreground  "#ffff88"              ;; "yellow3"  "#ffff88"
                         :background  'unspecified
                         :weight      'normal
                         :slant       'normal
                         )
     (set-face-attribute 'cperl-hash-face nil
                         :foreground  "#adcef5"
                         :background  'unspecified
                         :weight      'normal
                         :slant       'normal
                         )
     ))



(eval-after-load "cperl-mode"
  '(progn
    (helm-perldoc:setup)))

;; auto carton setup
(add-hook 'cperl-mode-hook 'helm-perldoc:carton-setup)


;; リージョン内のperlソースを整形する。
(defun perltidy-region ()
  "Run perltidy on the current region."
      (interactive)
          (save-excursion
                (shell-command-on-region (point) (mark) "perltidy -q" nil t)))
                (global-set-key "\C-ct" 'perltidy-region)

;; ソースすべてを整形する。
(defun perltidy-defun ()
  "Run perltidy on the current defun."
    (interactive)
    (save-excursion (mark-defun) (perltidy-region)))

(global-set-key (kbd "C-c C-t") 'perltidy-defun)

(defun perltidy-buffer () "Run perltidy on current buffer."
       (interactive)
       (if (executable-find "perltidy")
           (let ((where_i_was (point)))
             (shell-command-on-region (point-min) (point-max) "perltidy -q" nil t)
             (goto-char where_i_was))
         (message "Unable to find perltidy")))

(add-hook 'cperl-mode-hook
          (lambda () (add-hook 'before-save-hook 'perltidy-buffer nil t)))

;; resolve conflict with smartparens
(add-hook 'cperl-mode-hook (lambda () (local-unset-key (kbd "{"))))


(require 'flycheck)
;; add current directory to include path manually
(add-hook 'cperl-mode-hook (lambda () (setq flycheck-perl-include-path `(,(magit-toplevel)))))
(flycheck-define-checker perl-project-libs
  "A perl syntax checker."
  :command ("perl"
            (option-list "-I" flycheck-perl-include-path)
            "-MProject::Libs lib_dirs => [qw(local/lib/perl5)]"
            "-wc"
            source-inplace)
  :error-patterns ((error line-start
                          (minimal-match (message))
                          " at " (file-name) " line " line
                          (or "." (and ", " (zero-or-more not-newline)))
                          line-end))
  :modes (cperl-mode))

(add-hook 'cperl-mode-hook
          (lambda ()
            (flycheck-mode t)
            (setq flycheck-checker 'perl-project-libs)))


(require 'quickrun)
(setq quickrun-timeout-seconds nil)
(quickrun-add-command "perl5"
  '((:command . "/usr/bin/env perl")
    (:exec . ("%c %s"))
    (:tempfile . nil)))

(quickrun-add-command "perl/test"
  '((:command . "prove")
    (:exec    . "%c -v %s")
    (:description . "Run Perl Test script")))

(add-to-list 'quickrun-file-alist '("\\.t$" . "perl/test"))
(add-to-list 'quickrun-file-alist '("\\.pl$" . "perl5"))

(provide '14-cperl)
