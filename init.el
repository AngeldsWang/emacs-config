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
(put 'erase-buffer 'disabled nil)
