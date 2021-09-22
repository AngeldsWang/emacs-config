(require 'cue-mode "./others/cue-mode/cue-mode.el")

(add-to-list 'auto-mode-alist (cons "\\.cue\\'" 'cue-mode))

(provide '37-cue)
