(require 'magit)
(require 's)

(define-key magit-status-mode-map (kbd "q") 'magit-mode-bury-buffer)

(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)

;; https://emacs.stackexchange.com/questions/52001/magit-popup-doesnt-open-in-status-buffer
(setq transient-display-buffer-action '(display-buffer-below-selected))

(defun magit-push-to-gerrit ()
  (interactive)
  (magit-git-command-topdir "git push origin HEAD:refs/for/master"))

(transient-append-suffix 'magit-push "m"
  '("g" "Push to gerrit" magit-push-to-gerrit))


(global-set-key (kbd "M-o") 'magit-browse-merge-pull)
(defvar private-gitlab-host "gitlab.com")

(defun parse-merge-commit-from (commit)
  (s-trim (shell-command-to-string
           (format "git log --merges --oneline --reverse --ancestry-path %s...master | head -n 1 | cut -f1 -d' '"
                   commit))))

(defun parse-merge-pull-num (commit is-github)
  (let ((cmsg (shell-command-to-string (format "git --no-pager log -1 --format=%%B %s" commit))))
    (if is-github
        (replace-regexp-in-string "Merge pull request #\\([0-9]+\\) from.*\\(\n.*\\)*" "\\1" cmsg)
      (replace-regexp-in-string ".*!\\([0-9]+\\)$" "\\1" (car (s-match "^See merge request.*" cmsg))))))

(defun magit-browse-merge-pull ()
  (interactive)
  (if (magit-current-blame-chunk)
      (let ((commit-hash (oref (magit-current-blame-chunk) orig-rev)))
        (let ((merge-commit (parse-merge-commit-from commit-hash)))
          (let ((remote-url (magit-get "remote" (magit-get-remote) "url")))
            (if (string-match "github" remote-url)
                (let ((repo-name (replace-regexp-in-string
                                  "\\`.+github\\.com:\\(.+\\)\\.git\\'" "\\1" remote-url)))
                  (let ((pr-num (parse-merge-pull-num merge-commit t)))
                    (browse-url (format "https://github.com/%s/pull/%s" repo-name pr-num))))
              (let ((repo-name (replace-regexp-in-string
                                (format ".*%s[:|/]\\(.+\\)\\.git" (s-replace "." "\\." private-gitlab-host))
                                "\\1"
                                remote-url)))
                (let ((mr-num (parse-merge-pull-num merge-commit nil)))
                  (browse-url (format "https://%s/%s/merge_requests/%s" private-gitlab-host repo-name mr-num)))))
            )))))



(provide '06-magit)
