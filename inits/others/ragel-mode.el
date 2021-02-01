(setq ragel-mode-font-lock-keywords
      (let* (
             ;;define several keywords
             (x-keywords '("machine" "action" "access" "context" "include" "import" "export" "prepush" "postpop" "when" "inwhen" "outwhen" "err" "lerr" "eof" "from" "to" "alphtype" "getkey" "write"))
             (x-constants '("any" "ascii" "extend" "alpha" "digit" "alnum" "lower" "upper" "xdigit" "cntrl" "graph" "print" "punct" "space" "zlen" "empty"))
             (x-events '("fpc" "fc" "fcurs" "fbuf" "fblen" "ftargs" "fstack" "fhold" "fgoto" "fcall" "fret" "fentry" "fnext" "fexec" "fbreak"))

             ;; generate regex string for each category of keywords
             (x-keywords-regex (regexp-opt x-keywords 'words))
             (x-constants-regex (regexp-opt x-constants 'words))
             (x-events-regex (regexp-opt x-events 'words)))
        `(
          (,x-keywords-regex . font-lock-keyword-face)
          (,x-constants-regex . font-lock-constant-face)
          (,x-events-regex . font-lock-builtin-face)
          ("action\\([^{]+?\\)[ ]+{" . (1 font-lock-function-name-face))
          ("[%@$][ ]?\\([^@$%{\n )]+\\)" . (1 font-lock-function-name-face))
          ("[ ^]\\[\\|\\][ ?]" . font-lock-negation-char-face)
          ("[ ^]\\[\\([^\n]+\\)\\][ ?]" . (1 font-lock-constant-face))

          )))

;;;###autoload
(define-derived-mode ragel-mode c-mode "ragel-mode"
  "Major mode for editing ragel files"

  ;; code for syntax highlighting
  (setq font-lock-defaults '((ragel-mode-font-lock-keywords)))
  )

;;(autoload 'ragel-mode "ragel" "Ragel-mode" t)
(add-to-list 'auto-mode-alist '("\\.rl\\'" . ragel-mode))

(provide 'ragel-mode)

;;; ragel-mode.el ends here
