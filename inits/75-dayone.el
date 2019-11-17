;; https://help.dayoneapp.com/en/articles/435871-command-line-interface-cli
(defvar path-to-dayone "/usr/local/bin/dayone2"
  "Executable path to DayOne CLI")

(defun dayone-save-new-entry ()
  "Save buffer as a new DayOne entry"
  (interactive)
  (if (executable-find path-to-dayone)
      (call-process-region
       1 (point-max) path-to-dayone nil nil nil "new")))

(defvar dayone-buffer "*dayone*"
  "The name of the dayone buffer.")

(defvar dayone-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map "\C-c\C-c" 'dayone-save-and-kill-buffer)
    (define-key map "\C-c\C-k" 'dayone-destroy-buffer)
    map)
  "Keymap used in DayOne mode.")

(defun dayone-create-new-entry ()
  "Create *DayOne* buffer in new window."
  (interactive)
  (switch-to-buffer (get-buffer-create dayone-buffer))
  (use-local-map dayone-mode-map)
  (use-local-map dayone-mode-map)
  (setq major-mode 'dayone-mode mode-name "DayOne"))

(defun dayone-save-and-kill-buffer ()
  (interactive)
  (dayone-save-new-entry)
  (dayone-destroy-buffer))

(defun dayone-destroy-buffer ()
  "Destroy the current *DayOne* buffer."
  (interactive)
  (if (equal dayone-buffer (buffer-name))
      (kill-buffer (current-buffer))))

(provide '75-dayone)
