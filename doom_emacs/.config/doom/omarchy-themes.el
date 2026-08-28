;;; omarchy-themes.el --- Doom integration for Omarchy -*- lexical-binding: t -*-

(require 'filenotify)

(defconst omarchy-themes-current-directory
  (expand-file-name "~/.local/state/omarchy/current/"))

(defconst omarchy-themes-directory
  (expand-file-name "theme/"
                    omarchy-themes-current-directory))

(defconst omarchy-themes-package-directory
  "/usr/share/omarchy-emacs/config/themes/")

(defconst omarchy-themes-name-file
  (expand-file-name "theme.name"
                    omarchy-themes-current-directory))

;; Make the generated Omarchy color definitions available.
(add-to-list 'load-path omarchy-themes-directory)

;; Make the actual Omarchy theme available.
(add-to-list 'custom-theme-load-path
             omarchy-themes-package-directory)

;; Load the current Omarchy palette.
(load (expand-file-name "omarchy-colors.el"
                        omarchy-themes-directory))

;; Load the theme.
(load-theme 'omarchy t)

(provide 'doom-omarchy-themes)

;; Watcher for automatic theme reloading

(defvar omarchy-themes--watch nil)

(defun omarchy-themes--reload ()
  (let ((colors-file
         (expand-file-name "omarchy-colors.el"
                           omarchy-themes-directory)))
    (when (file-exists-p colors-file)
      (load colors-file nil nil t)
      (load-theme 'omarchy t))))

(defun omarchy-themes--watch (event)
  (pcase event
    (`((,_ . ,_) changed ,file)
     (when (string= file omarchy-themes-name-file)
       (omarchy-themes--reload)))))

(when omarchy-themes--watch
  (file-notify-rm-watch omarchy-themes--watch))

(setq omarchy-themes--watch
      (file-notify-add-watch
       omarchy-themes-current-directory
       '(change)
       #'omarchy-themes--watch))

;;; omarchy-themes.el ends here
