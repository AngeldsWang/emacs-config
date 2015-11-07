(require 'auto-dictionary)
(add-hook 'flyspell-mode-hook (lambda () (auto-dictionary-mode 1)))
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)

(provide '03-auto-dictionary)