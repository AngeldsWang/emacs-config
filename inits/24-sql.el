(require 'sqlformat)
(require 'sql-indent)

(setq sqlformat-command 'pgformatter)
(setq sqlformat-args '("-s4" "-g"))
(add-hook 'sql-mode-hook 'sqlformat-on-save-mode)

(defvar my-sql-indentation-offsets-alist
  `((select-clause 0)
    (insert-clause 0)
    (delete-clause 0)
    (update-clause 0)
    ,@sqlind-default-indentation-offsets-alist))

(add-hook 'sqlind-minor-mode-hook
    (lambda ()
       (setq sqlind-indentation-offsets-alist
             my-sql-indentation-offsets-alist)
       (setq sqlind-basic-offset 4)))

(provide '24-sql)
