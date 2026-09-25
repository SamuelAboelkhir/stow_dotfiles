(defun my-babel-functions (name)
  (interactive
   (list (completing-read "Function: " (mapcar #'car org-babel-library-of-babel))))
  (message "%s" (org-babel-ref-resolve name)))

(defun isql-minibuffer (connection query)
  (interactive
   (list
    (read-string "Connection: ")
    (read-string "SQL: ")))
  (message "%s" (shell-command-to-string (format "isql -v -b %s <<'sql'\n%s\nsql" connection query))))

(defun my-isql-run ()
  (interactive)
  (let ((output (get-buffer-create "*isql-output*")))
    (with-current-buffer output
      (erase-buffer))
    (call-process-region nil nil "isql" nil output nil "-v" "-b" my-isql-connection)
    (display-buffer-in-side-window
     output
     '((side . right)
       (slot . 1)
       (window-height . 0.33)))))
(defun isql-minibuffer-v2 (connection)
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
