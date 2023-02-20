(require 'org-tempo)
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(setq org-ellipsis "⤵")

(require 'ox-md)
(require 'ox-beamer)
(require 'ox-jira)
(require 'ox-reveal)
(require 'ox-hugo)
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
   (ein           . t)
   (ruby          . t)
   (dot           . t)
   (emacs-lisp    . t)
   (scheme        . t)
   (elasticsearch . t)
   (plantuml      . t)
   (mermaid       . t)))

(setq org-src-window-setup 'split-window-below)

(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)

;; Don’t ask before evaluating code blocks
(setq org-confirm-babel-evaluate nil)

(add-to-list
  'org-src-lang-modes '("plantuml" . plantuml))
(setq org-plantuml-jar-path "/usr/local/opt/plantuml/libexec/plantuml.jar")

(add-hook 'org-mode-hook
	      (lambda () (local-set-key (kbd "C-c C-p") 'org-toggle-inline-images)))

;; roam
(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/work/my/note/orgs"))
  :bind (("C-c m l" . org-roam-buffer-toggle)
         ("C-c m f" . org-roam-node-find)
         ("C-c m g" . org-roam-graph)
         ("C-c m i" . org-roam-node-insert)
         ("C-c m c" . org-roam-capture)
         ;; Dailies
         ("C-c m j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (setq org-roam-completion-everywhere t)
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol)
  (require 'org-roam-export))


(provide '20-org)

