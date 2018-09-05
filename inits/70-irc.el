(require 'circe)
(require 'circe-notifications)
(require 'jabber)
(require 'circe-color-nicks)
(enable-circe-color-nicks)

;;(setq auth-source-debug t)

(setq
 lui-time-stamp-position 'right-margin
 lui-fill-type nil)

(add-hook 'lui-mode-hook 'my-lui-setup)
(defun my-lui-setup ()
  (setq
   fringes-outside-margins t
   right-margin-width 10
   word-wrap t
   wrap-prefix ""))

(setf (cdr (assoc 'continuation fringe-indicator-alist)) nil)

;; ;; test for google talk
;; (setq jabber-account-list
;;       '(("angeldsphinx@gmail.com"
;;          (:network-server . "talk.google.com")
;;          (:port . 443)
;;          (:connection-type . ssl))))


(setq auth-sources
      '((:source "~/.emacs.d/secrets/.authinfo.gpg")))

(defun my-fetch-password (&rest params)
  (let ((match (car (apply 'auth-source-search params))))
    (if match
        (let ((secret (plist-get match :secret)))
          (if (functionp secret)
              (funcall secret)
            secret))
      (error "Password not found for %S" params))))

(defun my-nickserv-password (server)
  ;; for emacs < 25, need to specify :port when do auth-source-search
  ;; https://emacs.stackexchange.com/questions/26108/auth-source-search-returns-nil-for-valid-queries
  ;; https://github.com/jwiegley/emacs/commit/938495317a02b06a6c512832d0c6d9530fcd7f2b
  (my-fetch-password :user "angelds" :host server :port 6697))

(setq circe-network-options
      '(("Freenode"
         :nick "angelds"
         :channels (:after-auth "#emacs" "#emacs-circe" "#perl" "#perl6" "#clojure" "#go-nuts" "#docker" "#nginx" "#scheme" "##security" "#ansible" "#redis")
         :nickserv-password my-nickserv-password)
        ("Mozilla"
         :host "irc.mozilla.org"
         :port 6697
         :nickserv-mask "^NickServ!NickServ@services\\.$"
         :tls t
         :nick "angelds"
         :channels ("#rust" "#rust-beginners")
         :nickserv-password my-nickserv-password)
        ("Perl"
         :host "ssl.irc.perl.org"
         :port 7062
         :tls t
         :nick "angelds"
         :channels ("#dbix-class" "#moose" "#dancer" "#plack")
         :nickserv-password my-nickserv-password)))

;; ;; sending notification when nickname be mentioned
;; (autoload 'enable-circe-notifications "circe-notifications" nil t)

;; (eval-after-load "circe-notifications"
;;   '(setq circe-notifications-watch-strings
;;          '("people" "you" "like" "to" "hear" "from")
;;          circe-notifications-alert-style 'osx-notifier)) ;; see alert-styles for more!

;; (add-hook 'circe-server-connected-hook 'enable-circe-notifications)

(add-hook 'circe-channel-mode-hook (lambda () (setq line-spacing 0.5)))

(provide '70-irc)
