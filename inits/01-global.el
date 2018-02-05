(setq inhibit-startup-screen t)
(tool-bar-mode -1)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-hook 'window-setup-hook 'toggle-frame-fullscreen t)

;;(load-theme 'zenburn t)
(require 'doom-themes)
(add-to-list 'custom-theme-load-path "~/.emacs.d/inits/themes/")
(load-theme 'doom-sora t)
(doom-themes-visual-bell-config)
(doom-themes-neotree-config)
(doom-themes-org-config)

(scroll-bar-mode -1)
(eval-when-compile (require 'cl))
;; font and size
(set-default-font "hack-9")
;; code indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
;; Debug on init
;; (setq debug-on-error t)
(global-hl-line-mode 1)
(setq indent-line-function 'insert-tab)

(defun hack9 ()
  (interactive (set-default-font "hack-9")))

(defun hack10 ()
  (interactive (set-default-font "hack-10")))

;; copy (M + w) and cut (C + w) without selection
(defun slick-cut (beg end)
  (interactive
   (if mark-active
       (list (region-beginning) (region-end))
     (list (line-beginning-position) (line-beginning-position 2)))))

(advice-add 'kill-region :before #'slick-cut)

(defun slick-copy (beg end)
  (interactive
   (if mark-active
       (list (region-beginning) (region-end))
     (message "Copied line")
     (list (line-beginning-position) (line-beginning-position 2)))))

(advice-add 'kill-ring-save :before #'slick-copy)

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

(require 'desktop)
(setq desktop-path (list "~/.emacs-server"))
(desktop-save-mode 1)

(require 'wgrep)

;; set gpg program
(require 'epa-file)
(custom-set-variables '(epg-gpg-program "/usr/local/opt/gnupg/libexec/gpgbin/gpg"))
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

(provide '01-global)
