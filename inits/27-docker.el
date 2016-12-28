(require 'docker)
(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

(add-hook 'dockerfile-mode-hook (lambda ()
  (setq-default indent-tabs-mode nil
    tab-width 2)))

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))

;; If you are using docker-machine, add the following ENVs
;; Use "docker-machine env default" command to find out your environment variables
;;(setenv "DOCKER_TLS_VERIFY" "1")
;;(setenv "DOCKER_HOST" "tcp://192.168.99.100:2376")
;;(setenv "DOCKER_CERT_PATH" "/Users/wang-zhenjun/.docker/machine/machines/default")
;;(setenv "DOCKER_MACHINE_NAME" "default")

(provide '27-docker)
