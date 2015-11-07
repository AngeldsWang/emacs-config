# My Private Emacs configuration

## Using [cask](https://github.com/cask/cask) to manage the packages

### [init.el](/init.el) file turns to:
```lisp
(require 'cask "~/.cask/cask.el")
(cask-initialize)

;; use-package
(require 'use-package)

(use-package pallet)

;; init-loader
(use-package init-loader
  :config
  (setq init-loader-show-log-after-init nil)
  (init-loader-load "~/.emacs.d/inits"))
```

### Inside inits are lisp files for all the packages

prefix numbers are used to ensure the loading dependence.
