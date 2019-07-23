(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(setq org-ellipsis "⤵")

(require 'ox-md)
(require 'ox-beamer)
(require 'ox-jira)
(require 'ox-reveal)
(require 'ox-confluence-en "./others/ox-confluence-en.el")

(setq org-export-backends '(ascii icalendar html latex md confluence-en jira)
      org-export-with-toc t
      org-export-with-author t)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell         . t)
   (perl          . t)
   (C             . t)
   (python        . t)
   (ruby          . t)
   (dot           . t)
   (emacs-lisp    . t)
   (scheme        . t)
   (elasticsearch . t)
   (mermaid       . t)))

(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)

;; Don’t ask before evaluating code blocks
(setq org-confirm-babel-evaluate nil)

(add-hook 'org-mode-hook
	      (lambda () (local-set-key (kbd "C-c C-p") 'org-toggle-inline-images)))

(provide '20-org)

