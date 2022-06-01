;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Davinder Jolly"
      user-mail-address "davinderrocks0786@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Fira Mono" :size 14 :weight 'medium)
      doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; Setting project folder for projectile
(setq projectile-project-search-path '(("~/Projects/" . 2) ("~/github.com/" . 2)))

;; Hooks to change line number based on mode
(add-hook! evil-insert-state-entry (setq display-line-numbers 'absolute))
(add-hook! evil-insert-state-exit (setq display-line-numbers 'relative))

;; Setting line number color to be a bit more visible
(custom-set-faces! '(line-number :foreground "#666666"))

;; Rust LSP settings
(setq lsp-rust-server 'rust-analyzer
      rustic-lsp-server 'rust-analyzer
      rustic-analyzer-command '("rust-analyzer")
      rustic-format-on-save t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; v mode settings
(require 'v-mode)

;; Add jsx support
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)
(add-to-list 'emmet-jsx-major-modes 'rjsx-mode)


;; Key bindings
(with-eval-after-load 'emmet-mode
  (define-key emmet-mode-keymap (kbd "C-c j") 'emmet-expand-line))


;; Python settings
(setq py-isort-options  '("--profile=black"
                          "--line-length=88"
                          "--multi-line=3"
                          "--force-single-line-imports"
                          "--trailing-comma"))


;; Elcord settings
(require 'elcord)
(elcord-mode)
(setq elcord-display-buffer-details nil
      elcord-editor-icon "emacs_icon")

(map! :leader
      "r" #'+hydra/window-nav/body)

;; Org mode settings
(defun custom/org-mode-setup ()
  (setq org-superstar-headline-bullets-list '("◉" "○" "✸" "✿")
        org-hide-emphasis-markers t)
  (set-face-attribute 'org-level-1 nil :height 1.3)
  (set-face-attribute 'org-level-2 nil :height 1.2)
  (set-face-attribute 'org-level-3 nil :height 1.1))

(add-hook 'org-mode-hook #'custom/org-mode-setup)

;; Smooth scrolling
(setq pixel-scroll-precision-use-momentum 't)
(pixel-scroll-mode 1)
(pixel-scroll-precision-mode 1)
