(require 'youdao-dictionary)

;; Enable Cache
(setq url-automatic-caching t)

;; Example Key binding
(global-set-key (kbd "C-c y") 'youdao-dictionary-search-at-point)

(provide '73-dict)
