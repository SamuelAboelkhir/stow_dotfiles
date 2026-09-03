(require 'auth-source)
(setq auth-sources '("~/.authinfo.gpg"))

(load! "omarchy-themes")

(setq display-line-numbers-type 'relative)

(after! centaur-tabs
  (evil-global-set-key 'normal "H" #'centaur-tabs-backward-tab)
  (evil-global-set-key 'normal "L" #'centaur-tabs-forward-tab)
  )

(setq org-directory "~/org/")
(setq org-roam-directory "~/org")

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(setq doom-font (font-spec :family "Liberation Mono" :size 10))

(after! eglot
  (add-to-list
   'eglot-server-programs
   `(((js-mode :language-id "javascript")
      (js-ts-mode :language-id "javascript")
      (tsx-ts-mode :language-id "typescriptreact")
      (typescript-ts-mode :language-id "typescript")
      (typescript-mode :language-id "typescript"))
     . (,(expand-file-name "~/.local/share/nvim/mason/bin/vtsls")
        "--stdio"))))

(setq-default eglot-workspace-configuration
              '((:vtsls
                 . (:enableMoveToFileCodeAction t
                    :autoUseWorkspaceTsdk t
                    :experimental
                    (:maxInlayHintLength 30
                     :completion
                     (:enableServerSideFuzzyMatch t))))
                (:typescript
                 . (:updateImportsOnFileMove
                    (:enabled "always")
                    :suggest
                    (:completeFunctionCalls t)
                    :inlayHints
                    (:enumMemberValues (:enabled t)
                     :functionLikeReturnTypes (:enabled t)
                     :parameterNames (:enabled "literals")
                     :parameterTypes (:enabled t)
                     :propertyDeclarationTypes (:enabled t)
                     :variableTypes (:enabled nil))))
                (:javascript
                 . (:suggest
                    (:completeFunctionCalls t)))))

(let ((auth-sock
       (string-trim
        (shell-command-to-string
         "keychain --eval --quiet | sed -n 's/^SSH_AUTH_SOCK=\\([^;]*\\).*/\\1/p'"))))
  (unless (string-empty-p auth-sock)
    (setenv "SSH_AUTH_SOCK" auth-sock)))

(setq clutch-jdbc-agent-java-executable
      "/home/blackdovah/.local/share/mise/installs/java/liberica-26.0.0+37/bin/java")
(setq clutch-connection-alist
      `(("va-ibmi" .(:backend jdbc
                     :url "jdbc:as400://10.30.1.134;keep alive=true;metadata source=0;"
                     :driver-class "com.ibm.as400.access.AS400JDBCDriver"
                     :user "esky001"
                     :password ,(auth-source-pick-first-password
                                 :host "va-ibmi"
                                 :user "esky001")))
        ;; Config for redis
        ("va-redis" . (:backend redis
                       :host "localhost"
                       :port 6379
                       :password ,(auth-source-pick-first-password
                                 :host "va-redis")))
        ("PUB400" .(:backend jdbc
                    :url "jdbc:as400://PUB400.COM;keep alive=true;metadata source=0;"
                    :driver-class "com.ibm.as400.access.AS400JDBCDriver"
                    :user "BLACKDOVA"
                    :password ,(auth-source-pick-first-password
                                 :host "PUB400"
                                 :user "BLACKDOVA")))
        ))

(use-package! tmux-pane
  :config
  (tmux-pane-mode)
  (map! :leader
        (:prefix ("v" . "tmux pane")
         :desc "Open vpane" :nv "o" #'tmux-pane-open-vertical
         :desc "Open hpane" :nv "h" #'tmux-pane-open-horizontal
         :desc "Open hpane" :nv "s" #'tmux-pane-open-horizontal
         :desc "Open vpane" :nv "v" #'tmux-pane-open-vertical
         :desc "Close pane" :nv "c" #'tmux-pane-close
         :desc "Rerun last command" :nv "r" #'tmux-pane-rerun))
  (map! :leader
        (:prefix "t"
         :desc "vpane" :nv "v" #'tmux-pane-toggle-vertical
         :desc "hpane" :nv "h" #'tmux-pane-toggle-horizontal)))

(defun +dashboard-draw-ascii-banner-fn ()
  (propertize
   (with-temp-buffer
     (insert-file-contents
      (expand-file-name "banner.txt" doom-user-dir))
     (buffer-string))
   'face '+dashboard-banner))

(add-hook 'org-mode-hook 'org-indent-mode)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(after! projectile
  (global-unset-key [remap evil-jump-to-tag])
  (global-unset-key [remap find-tag]))

(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t))

;;; R / ESS

(after! ess-r-mode

  ;; RStudio-compatible indentation
  (setq ess-style 'RStudio)

  ;; Don't ask where to start R
  (setq ess-ask-for-ess-directory nil)

  ;; Don't restore .RData
  (setq inferior-R-args "--no-save")

  ;; Normal comment indentation
  (setq ess-indent-with-fancy-comments nil)

  ;; Don't block Emacs during evaluation
  (setq ess-eval-visibly 'nowait)

  (defun my/rstudio-layout ()
    "Build an RStudio-like layout."
    (interactive)

    (let ((source (current-buffer)))

      ;; Start R
      (ess-switch-to-ESS t)

      ;; Open the environment
      (ess-rdired)

      ;; Get the actual ESS buffers
      (let ((console (ess-get-current-process-buffer))
            (environment (get-buffer ess-rdired-buffer)))

        ;; Go back to our R source file
        (pop-to-buffer source)
        (delete-other-windows)

        ;; Console -> right of source
        (display-buffer-in-atom-window
         console
         `((window . ,(get-buffer-window source))
           (side . right)
           (window-width . 0.33)
           (dedicated . t)))

        ;; Environment -> below console
        (display-buffer-in-atom-window
         environment
         `((window . ,(get-buffer-window console))
           (side . below)
           (window-height . 0.35)
           (dedicated . t))))



      ;; (display-buffer-in-atom-window
      ;;  plots
      ;;  `((window . ,(get-buffer-window source))
      ;;   (side . below) (window-height . 0.35)
      ;;   (dedicated . t))))
      ))
  (add-hook 'ess-r-mode-hook #'my/rstudio-layout)
  )
