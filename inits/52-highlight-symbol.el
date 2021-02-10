(require 'highlight-symbol)

(global-set-key (kbd "<f3>") 'highlight-symbol-at-point)
(global-set-key (kbd "C-<f3>") 'highlight-symbol-next)
(global-set-key (kbd "S-<f3>") 'highlight-symbol-prev)
(global-set-key (kbd "M-<f3>") 'highlight-symbol-remove-all)

(setq highlight-symbol-colors
      '("#DF8C8C" ;; red
        "#F2C38F" ;; orange
        "#DADA93" ;; yellow
        "#A8CE93" ;; green
        "#83AFE5" ;; blue
        "#C97A7E" ;; old-rose
        "#7FC1CA" ;; cyan
        "#C1C4BE" ;; grey-nickel
        "#9A93E1" ;; violet
        ))

(provide '52-highlight-symbol)
