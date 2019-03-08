(setq inhibit-startup-screen t)
(tool-bar-mode -1)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-hook 'window-setup-hook 'toggle-frame-fullscreen t)

;; (load-theme 'zenburn t)
(require 'doom-themes)
(add-to-list 'custom-theme-load-path "~/.emacs.d/inits/themes/")
(load-theme 'doom-sora t)
(doom-themes-visual-bell-config)
(doom-themes-neotree-config)
(doom-themes-org-config)

(scroll-bar-mode -1)
(eval-when-compile (require 'cl))
;; font and size
(set-frame-font "hack-10")
;; code indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
;; Debug on init
;; (setq debug-on-error t)
(global-hl-line-mode 1)
(setq indent-line-function 'insert-tab)

(defun hack9 ()
  (interactive (set-frame-font "hack-9")))

(defun hack10 ()
  (interactive (set-frame-font "hack-10")))

(defun toggle-line-spacing ()
  "Toggle line spacing between no extra space to extra half line height.
URL `http://ergoemacs.org/emacs/emacs_toggle_line_spacing.html'
Version 2017-06-02"
  (interactive)
  (if line-spacing
      (setq line-spacing nil)
    (setq line-spacing 0.5))
  (redraw-frame (selected-frame)))

(defun rename-file-and-buffer ()
  "Rename the current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))
(global-set-key (kbd "C-c r")  'rename-file-and-buffer)

(setq ag-highlight-search t)

(require 'yasnippet)
(yas-global-mode 1)


;;(add-hook 'after-init-hook 'global-company-mode)
;;(add-to-list 'company-backends 'company-tern)

(require 'company)
(global-company-mode)
(global-set-key (kbd "TAB") #'company-indent-or-complete-common)
(add-to-list 'company-backends 'company-tern)

(require 'flycheck)
(global-flycheck-mode)
(with-eval-after-load 'flycheck
  (setq-default flycheck-disabled-checkers '(
                                             emacs-lisp-checkdoc
                                             go-golint
                                             )))

(let ((govet (flycheck-checker-get 'go-vet 'command)))
  (when (equal (cadr govet) "tool")
    (setf (cdr govet) (cddr govet))))

(require 'desktop)
(setq desktop-path (list "~/.emacs-server"))
(desktop-save-mode 1)

(require 'wgrep)

;; set gpg program
(require 'epa-file)
(custom-set-variables '(epg-gpg-program "/usr/local/bin/gpg"))
(epa-file-enable)


;; ediff
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-horizontally)

;; rebind set-mark-command
(global-set-key (kbd "C-;") 'set-mark-command)

(global-set-key (kbd "C-M-n") 'new-frame)
(global-set-key (kbd "M-`") 'other-frame)

;; insert into rectangle
(global-set-key (kbd "C-x r i") 'string-insert-rectangle)


(setq redisplay-dont-pause nil)

(defvar my-ratio-dict
  '((1 . 1.61803398875)
    (2 . 2)
    (3 . 3)
    (4 . 4)
    (5 . 0.61803398875))
  "The ratio dictionary.")

(defun my-split-window-horizontally (&optional ratio)
  "Split window horizontally and resize the new window.
'C-u number M-x my-split-window-horizontally' uses pre-defined
ratio from `my-ratio-dict'.
Always focus on bigger window."
  (interactive "P")
  (let* (ratio-val)
    (cond
     (ratio
      (setq ratio-val (cdr (assoc ratio my-ratio-dict)))
      (split-window-horizontally (floor (/ (window-body-width)
                                           (1+ ratio-val)))))
     (t
      (split-window-horizontally)))
    (set-window-buffer (next-window) (current-buffer))
    (if (or (not ratio-val)
            (>= ratio-val 1))
        (windmove-right))))

(defun my-split-window-vertically (&optional ratio)
  "Split window vertically and resize the new window.
'C-u number M-x my-split-window-vertically' uses pre-defined
ratio from `my-ratio-dict'.
Always focus on bigger window."
  (interactive "P")
  (let* (ratio-val)
    (cond
     (ratio
      (setq ratio-val (cdr (assoc ratio my-ratio-dict)))
      (split-window-vertically (floor (/ (window-body-height)
                                         (1+ ratio-val)))))
     (t
      (split-window-vertically)))
    ;; open another window with current-buffer
    (set-window-buffer (next-window) (current-buffer))
    ;; move focus if new window bigger than current one
    (if (or (not ratio-val)
            (>= ratio-val 1))
        (windmove-down))))

(global-set-key (kbd "C-x 2") 'my-split-window-vertically)
(global-set-key (kbd "C-x 3") 'my-split-window-horizontally)

(put 'erase-buffer 'disabled nil)
(put 'downcase-region 'disabled nil)

;; On-demand installation of packages
;; copy from https://github.com/purcell/emacs.d/blob/master/lisp/init-elpa.el

(require 'cl-lib)

(defconst *is-a-mac* (eq system-type 'darwin))

(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (or (package-installed-p package min-version)
      (let* ((known (cdr (assoc package package-archive-contents)))
             (versions (mapcar #'package-desc-version known)))
        (if (cl-find-if (lambda (v) (version-list-<= min-version v)) versions)
            (package-install package)
          (if no-refresh
              (error "No version of %s >= %S is available" package min-version)
            (package-refresh-contents)
            (require-package package min-version t))))))

(defun maybe-require-package (package &optional min-version no-refresh)
  "Try to install PACKAGE, and return non-nil if successful.
In the event of failure, return nil and print a warning message.
Optionally require MIN-VERSION.  If NO-REFRESH is non-nil, the
available package lists will not be re-downloaded in order to
locate PACKAGE."
  (condition-case err
      (require-package package min-version no-refresh)
    (error
     (message "Couldn't install optional package `%s': %S" package err)
     nil)))

;;utils copy from https://github.com/purcell/emacs.d/blob/master/lisp/init-utils.el
(if (fboundp 'with-eval-after-load)
    (defalias 'after-load 'with-eval-after-load)
  (defmacro after-load (feature &rest body)
    "After FEATURE is loaded, evaluate BODY."
    (declare (indent defun))
    `(eval-after-load ,feature
       '(progn ,@body))))

(defun add-auto-mode (mode &rest patterns)
  "Add entries to `auto-mode-alist' to use `MODE' for all given file `PATTERNS'."
  (dolist (pattern patterns)
    (add-to-list 'auto-mode-alist (cons pattern mode))))

;; print full value
(setq eval-expression-print-level nil)
(setq eval-expression-print-length nil)

;; json-unpretty-print
;; require jq preinstalled
(defun json-unpretty-print (beg end)
  (interactive "r")
  (shell-command-on-region beg end "jq -c ." nil t))

(defun byte-offset-at-point ()
  "Report the byte offset (0-indexed) in the file
corresponding to the position of point."
  (interactive)
  (message "byte offset: %d" (1- (position-bytes (point)))))

(provide '01-global)
