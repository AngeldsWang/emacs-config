(add-to-list 'exec-path (concat (getenv "JAVA_HOME") "/bin"))

(use-package lsp-java
  :ensure t
  :after lsp
  :config
  (add-hook 'java-mode-hook 'lsp)
  (add-hook 'lsp-mode-hook #'lsp-lens-mode)
  (add-hook 'java-mode-hook #'lsp-java-boot-lens-mode))

(use-package dap-mode
  :ensure t :after lsp-mode
  :config
  (dap-mode t)
  (dap-ui-mode t))

(use-package dap-java :after (lsp-java))
(add-hook 'java-mode-hook
          (lambda ()
            (flycheck-mode +1)
            ;; use code format
            (add-hook 'before-save-hook 'lsp-format-buffer)))

(setq lsp-java-vmargs '("-XX:+UseParallelGC" "-XX:GCTimeRatio=4" "-XX:AdaptiveSizePolicyWeight=90" "-Dsun.zip.disableMemoryMapping=true" "-Xmx8G" "-Xms100m"))
;; https://emacs-lsp.github.io/lsp-mode/page/faq/#how-do-i-force-lsp-mode-to-forget-the-workspace-folders-for-multi-root
(advice-add 'lsp :before (lambda (&rest _args) (eval '(setf (lsp-session-server-id->folders (lsp-session)) (ht)))))

(defun use-gradle-version (gradle-ver)
  (setq lsp-java-import-gradle-wrapper-enabled nil)
  (setq lsp-java-import-gradle-version gradle-ver))

(provide '18-java)
