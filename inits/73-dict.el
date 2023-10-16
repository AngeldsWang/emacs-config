(use-package dictionary
  :commands (dictionary-search)
  :init
  (global-set-key (kbd "C-c s") #'dictionary-search)
  :config (setq dictionary-server "dict.org"))

(provide '73-dict)
