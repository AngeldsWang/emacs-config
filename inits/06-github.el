(require '06-git)
(require 'github-browse-file)
(require 'bug-reference-github)
(require 'browse-at-remote)

(global-set-key (kbd "C-c g g") 'browse-at-remote)

(maybe-require-package 'yagist)

(add-hook 'prog-mode-hook 'bug-reference-prog-mode)

(maybe-require-package 'github-clone)
(maybe-require-package 'magit-gh-pulls)


(provide '06-github)
