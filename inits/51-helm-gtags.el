(require 'helm-gtags)          
(add-hook 'go-mode-hook (lambda () (helm-gtags-mode)))
(add-hook 'python-mode-hook (lambda () (helm-gtags-mode)))  
(add-hook 'ruby-mode-hook (lambda () (helm-gtags-mode)))    
(add-hook 'cperl-mode-hook (lambda () (helm-gtags-mode)))                     
(setq helm-gtags-path-style 'root)                       
(setq helm-gtags-auto-update t)
(add-hook 'helm-gtags-mode-hook
          '(lambda ()                                                                   
             (local-set-key (kbd "M-g") 'helm-gtags-dwim)
             (local-set-key (kbd "M-,") 'helm-gtags-pop-stack)
             (local-set-key (kbd "M-s") 'helm-gtags-show-stack)
             (local-set-key (kbd "M-n") 'helm-gtags-next-history)))     


(provide '51-helm-gtags)