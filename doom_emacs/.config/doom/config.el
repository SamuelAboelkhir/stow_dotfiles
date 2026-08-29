;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; Integrate omarchy themes
(load! "omarchy-themes")

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-1337)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(setq doom-font (font-spec :family "JetBrains Mono" :size 10))

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
                 (:enableMoveToFileCodeAction t
                  :autoUseWorkspaceTsdk t
                  :experimental
                  (:maxInlayHintLength 30
                   :completion
                   (:enableServerSideFuzzyMatch t)))
                 :typescript
                 (:updateImportsOnFileMove
                  (:enabled "always"))
                 :suggest
                 (:completeFunctionCalls t)
                 :inlayHints
                 (:enumMemberValues (:enabled t)
                  :functionLikeReturnTypes (:enabled t)
                  :parameterNames (:enabled "literals")
                  :parameterTypes (:enabled t)
                  :propertyDeclarationTypes (:enabled t)
                  :variableTypes (:enabled nil))
                 :javascript
                 (:suggest
                  (:completeFunctionCalls t)))))

;; Set SSH agent via keychain
(let ((auth-sock
       (string-trim
        (shell-command-to-string
         "keychain --eval --quiet | sed -n 's/^SSH_AUTH_SOCK=\\([^;]*\\).*/\\1/p'"))))
  (unless (string-empty-p auth-sock)
    (setenv "SSH_AUTH_SOCK" auth-sock)))

;; Clutch config for DB2 for i
(setq clutch-jdbc-agent-java-executable
      "/home/blackdovah/.local/share/mise/installs/java/liberica-26.0.0+37/bin/java")
(setq clutch-connection-alist
      '(("va-ibmi" .(:backend jdbc
                     :url "jdbc:as400://10.30.1.134;libraries=VAQACDTA;"
                     :driver-class "com.ibm.as400.access.AS400JDBCDriver"
                     :user "esky001"
                     :password "2Sk6J1m2s$"))
        ;; Config for redis
        ("va-redis" . (:backend redis
                       :host "localhost"
                       :port 6379
                       :password "yXrX77QPD0jrsVctSiMfvcWxGR2ZpJXe6OYM2LfloIsPbCzR"))
        ("PUB400" .(:backend jdbc
                    :url "jdbc:as400://PUB400.COM;libraries=MYLIB;keep alive=true;metadata source=1;"
                    :driver-class "com.ibm.as400.access.AS400JDBCDriver"
                    :schema "MYLIB"
                    :user "BLACKDOVA"
                    :password "BLACK01288137949!1"))
        ))

;; tmux-pane config
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

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
