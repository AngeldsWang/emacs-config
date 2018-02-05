(require 'eww)

(setq eww-search-prefix "http://www.google.com/search?q=")

(defun eww-mode-hook--rename-buffer ()
  "Rename eww browser's buffer so sites open in new page."
  (rename-buffer "eww" t))
(add-hook 'eww-mode-hook 'eww-mode-hook--rename-buffer)

(defvar eww-disable-colorize t)

(defun shr-colorize-region--disable (orig start end fg &optional bg &rest _)
  (unless eww-disable-colorize
    (funcall orig start end fg)))
(advice-add 'shr-colorize-region :around 'shr-colorize-region--disable)
(advice-add 'eww-colorize-region :around 'shr-colorize-region--disable)

(defun eww-disable-color ()
  (interactive)
  (setq-local eww-disable-colorize t)
  (eww-reload))

(defun eww-enable-color ()
  (interactive)
  (setq-local eww-disable-colorize nil)
  (eww-reload))

(defun eww-disable-images ()
  (interactive)
  (setq-local shr-put-image-function 'shr-put-image-alt)
  (eww-reload))

(defun eww-enable-images ()
  (interactive)
  (setq-local shr-put-image-function 'shr-put-image)
  (eww-reload))

(defun shr-put-image-alt (spec alt &optional flags)
  (insert alt))

;; (defun eww-mode-hook-disable-image ()
;;   (setq-local shr-put-image-function 'shr-put-image-alt))
;; (add-hook 'eww-mode-hook 'eww-mode-hook-disable-image)

;; copy from https://github.com/emacs-mirror/emacs/blob/master/lisp/net/shr.el
;; (defun my-shr-put-image (spec alt &optional flags)
;;   "Insert image SPEC with a string ALT.  Return image.
;; SPEC is either an image data blob, or a list where the first
;; element is the data blob and the second element is the content-type."
;;   (if (display-graphic-p)
;;       (let* ((size (cdr (assq 'size flags)))
;; 	     (data (if (consp spec)
;; 		       (car spec)
;; 		     spec))
;; 	     (content-type (and (consp spec)
;; 				(cadr spec)))
;; 	     (start (point))
;; 	     (image (cond
;; 		     ((eq size 'original)
;; 		      (create-image data nil t :ascent 100
;; 				    :format content-type))
;; 		     ((eq content-type 'image/svg+xml)
;;               (message "XXXXXXXXXXXXX")
;; 		      (create-image data 'svg t :ascent 100))
;; 		     ((eq size 'full)
;; 		      (ignore-errors
;; 			(shr-rescale-image data content-type
;;                                            (plist-get flags :width)
;;                                            (plist-get flags :height))))
;; 		     (t
;; 		      (ignore-errors
;; 			(shr-rescale-image data content-type
;;                                            (plist-get flags :width)
;;                                            (plist-get flags :height)))))))
;;         (when image
;; 	  ;; When inserting big-ish pictures, put them at the
;; 	  ;; beginning of the line.
;; 	  (when (and (> (current-column) 0)
;; 		     (> (car (image-size image t)) 400))
;; 	    (insert "\n"))
;; 	  (if (eq size 'original)
;; 	      (insert-sliced-image image (or alt "*") nil 20 1)
;; 	    (insert-image image (or alt "*")))
;; 	  (put-text-property start (point) 'image-size size)
;; 	  (when (and shr-image-animate
;;                      (cond ((fboundp 'image-multi-frame-p)
;; 		       ;; Only animate multi-frame things that specify a
;; 		       ;; delay; eg animated gifs as opposed to
;; 		       ;; multi-page tiffs.  FIXME?
;;                             (cdr (image-multi-frame-p image)))
;;                            ((fboundp 'image-animated-p)
;;                             (image-animated-p image))))
;;             (image-animate image nil 60)))
;; 	image)
;;     (insert (or alt ""))))

;; (add-hook 'eww-mode-hook (lambda () (setq shr-put-image-function 'my-shr-put-image)))

(define-key eww-mode-map "r" 'eww-reload)
(define-key eww-mode-map "c 0" 'eww-copy-page-url)
(define-key eww-mode-map "p" 'scroll-down)
(define-key eww-mode-map "n" 'scroll-up)


(provide '72-eww)
