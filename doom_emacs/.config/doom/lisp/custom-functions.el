(defun my-babel-functions (name)
  (interactive
   (list (completing-read "Function: " (mapcar #'car org-babel-library-of-babel))))
  (message "%s" (org-babel-ref-resolve name)))

(defun my-isql-run ()
  (interactive)
  (let ((output (get-buffer-create "*isql-output*")))
    (with-current-buffer output
      (org-mode)
      (erase-buffer))
    (call-process-region nil nil "isql" nil output nil "-v" "-b" my-isql-connection)
    (display-buffer-in-side-window
     output
     '((side . right)
       (slot . 1)
       (window-height . 0.33)))))
(defun isql-minibuffer (connection)
  (interactive
   (list (read-string "Connection: ")))
  (let* ((buffer (get-buffer-create "*isql-query*"))
         (window
          (display-buffer-in-side-window
           buffer
           '((side . right)
             (window-width . 0.5)
             (slot . 0)))))
    (select-window window)
    (with-current-buffer buffer
      (sql-mode)
      (setq-local my-isql-connection connection)
      (keymap-local-set "C-c C-c" #'my-isql-run))))

(defun ssh-add-identity (identity)
  (interactive
   (list (completing-read "Identity: " '("work" "personal"))))
  (let ((key (pcase identity
               ("work" "~/.ssh/work/work_id_ed25519")
               ("personal" "~/.ssh/GH_id_rsa"))))
    (message "%s"
             (with-output-to-string
               (call-process
                "ssh-add"
                nil
                standard-output
                nil
                (expand-file-name key))))))

(defun currency-conversion (amount from to)
  (interactive
   (list (read-string "Amount: ")
         (read-string "From: ")
         (read-string "To: ")))
  (let ((expression (format "%s %s to %s" amount from to)))
    (message "Expression: %s" expression)
    (message "%s %s" (string-trim (with-output-to-string
                                    (call-process
                                     "gnome-calculator"
                                     nil
                                     standard-output
                                     nil
                                     "-s" expression)))
             to)))
