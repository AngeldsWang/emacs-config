(require 'w3m)
;検索エンジンにGoogleを登録
(eval-after-load "w3m-search"
                 '(add-to-list 'w3m-search-engine-alist
                               '("google" "https://encrypted.google.com/search?num=100&ie=utf-8&oe=utf-8&hl=ja&safe=off&filter=0&pws=0&complete=0&gbv=1&q=%s" utf-8)))
;デフォルトの検索エンジンをGoogleに設定
(setq w3m-search-default-engine "google")
;初期ページをGoogleトップに
(setq w3m-home-page "http://www.google.com")
;cookieを使用
(setq w3m-use-cookies t)

;;change default browser for 'browse-url'  to w3m
(setq browse-url-browser-function 'w3m-goto-url-new-session)

;;change w3m user-agent to android
(setq w3m-user-agent "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36")

;;quick access hacker news
(defun hn ()
  (interactive)
  (browse-url "http://news.ycombinator.com"))

;;quick access reddit
(defun reddit (reddit)
  "Opens the REDDIT in w3m-new-session"
  (interactive (list
                (read-string "Enter the reddit (default: psycology): " nil nil "psychology" nil)))
  (browse-url (format "http://m.reddit.com/r/%s" reddit))
  )

;;i need this often
(defun wikipedia-search (search-term)
  "Search for SEARCH-TERM on wikipedia"
  (interactive
   (let ((term (if mark-active
                   (buffer-substring (region-beginning) (region-end))
                 (word-at-point))))
     (list
      (read-string
       (format "Wikipedia (%s):" term) nil nil term)))
   )
  (browse-url
   (concat
    "http://en.m.wikipedia.org/w/index.php?search="
    search-term
    ))
  )

;;when I want to enter the web address all by hand
(defun w3m-open-site (site)
  "Opens site in new w3m session with 'http://' appended"
  (interactive
   (list (read-string "Enter website address(default: w3m-home):" nil nil w3m-home-page nil )))
  (w3m-goto-url-new-session
   (concat "http://" site)))

;; default browser for external usage
(setq browse-url-browser-function 'browse-url-default-macosx-browser)


(provide '71-w3m)
