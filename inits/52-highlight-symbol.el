(require 'highlight-symbol)

(global-set-key (kbd "<f3>") 'highlight-symbol-at-point)
(global-set-key (kbd "C-<f3>") 'highlight-symbol-next)
(global-set-key (kbd "S-<f3>") 'highlight-symbol-prev)
(global-set-key (kbd "M-<f3>") 'highlight-symbol-remove-all)

(provide '52-highlight-symbol)
