(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(setq org-ellipsis "⤵")

(setq org-export-backends '(ascii html latex md icalendar)
      org-export-with-toc t
      org-export-with-author t)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell . t)
   (perl . t)
   (C . t)
   (python . t)
   (ruby . t)
   (dot . t)
   (elasticsearch . t)))

(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)

;; Don’t ask before evaluating code blocks
(setq org-confirm-babel-evaluate nil)

(require 'ox-md)
(require 'ox-beamer)

(provide '20-org)
