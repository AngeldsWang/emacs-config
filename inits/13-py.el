(use-package python
  :mode ("\\.py" . python-mode)
  :ensure t)

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp)
                          (setq lsp-pyright-python-executable-cmd "python3.8")))
  :config
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-tramp-connection (cons "pyright-langserver" lsp-pyright-langserver-command-args))
    :major-modes '(python-mode)
    :remote? t
    :server-id 'pyright-remote
    :multi-root t
    :priority 3
    :initialized-fn (lambda (workspace)
                      (with-lsp-workspace workspace
			;; we send empty settings initially, LSP server will ask for the
			;; configuration of each workspace folder later separately
			(lsp--set-configuration
			 (make-hash-table :test 'equal))))
    :download-server-fn (lambda (_client callback error-callback _update?)
                          (lsp-package-ensure 'pyright callback error-callback))
    :notification-handlers (lsp-ht ("pyright/beginProgress" 'lsp-pyright--begin-progress-callback)
                                   ("pyright/reportProgress" 'lsp-pyright--report-progress-callback)
                                   ("pyright/endProgress" 'lsp-pyright--end-progress-callback)))))


(use-package lsp-python-ms
  :ensure t
  :init (setq lsp-python-ms-auto-install-server t)
  :hook (python-mode . (lambda ()
                          (require 'lsp-python-ms)
                          (lsp))))

(use-package python-black
  :demand t
  :after python
  :hook (python-mode . python-black-on-save-mode))

;; quickrun
(quickrun-add-command "python"
  '((:command . "/usr/bin/env python3")
    (:exec . ("%c %s"))
    (:tempfile . nil)))


;; ein
(eval-when-compile
  (require 'ein)
  (require 'ein-notebook)
  (require 'ein-notebooklist)
  (require 'ein-markdown-mode))

(setq ein:worksheet-enable-undo t)
(setq ein:output-area-inlined-images t)

(require 'ein-markdown-mode)
(setq ein:markdown-command "pandoc --metadata pagetitle=\"markdown preview\" -f markdown -c ~/.pandoc/gh-pandoc.css -s --self-contained --mathjax=https://raw.githubusercontent.com/ustasb/dotfiles/b54b8f502eb94d6146c2a02bfc62ebda72b91035/pandoc/mathjax.js")

(defun ein:markdown-preview ()
  (interactive)
  (ein:markdown-standalone)
  (browse-url-of-buffer ein:markdown-output-buffer-name))


(provide '13-py)
