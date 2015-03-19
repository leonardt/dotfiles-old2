(require 'cask "~/.cask/cask.el")
(cask-initialize)

(fset 'yes-or-no-p 'y-or-n-p)

(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(unless (display-graphic-p) (menu-bar-mode -1))

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; tramp, for sudo access
(require 'tramp)
;; keep in mind known issues with zsh - see emacs wiki
(setq tramp-default-method "ssh")

(blink-cursor-mode -1)
(setq inhibit-startup-screen t)
(setq ring-bell-function 'ignore)

(global-hl-line-mode)

(evil-mode 1)
(define-key evil-inner-text-objects-map "a" 'evil-inner-arg)
(define-key evil-outer-text-objects-map "a" 'evil-outer-arg)
(global-evil-surround-mode t)
(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")
(setq evilnc-hotkey-comment-operator "gc")
(add-hook 'c-mode-common-hook
  (lambda ()
    ;; Preferred comment style
    (setq comment-start "// "
          comment-end "")))
(global-evil-snipe-mode 1)

(projectile-global-mode)

(yas-global-mode 1)

(add-hook 'term-mode-hook (lambda()
        (setq yas-dont-activate t)))

(evil-add-hjkl-bindings magit-log-mode-map 'emacs)
(evil-add-hjkl-bindings magit-commit-mode-map 'emacs)
(evil-add-hjkl-bindings magit-branch-manager-mode-map 'emacs
  "K" 'magit-discard-item
  "L" 'magit-key-mode-popup-logging)
(evil-add-hjkl-bindings magit-status-mode-map 'emacs
  "K" 'magit-discard-item
  "l" 'magit-key-mode-popup-logging
  "h" 'magit-toggle-diff-refine-hunk)

(evil-leader/set-key
 "<SPC>" 'helm-mini
 "x" 'helm-M-x
 "y" 'helm-show-kill-ring
 "i" 'helm-semantic-or-imenu
 "o" 'helm-occur
 "c" 'compile
 "r" 'recompile
 "e s" 'eshell
 "g s" 'magit-status
 "g p s" 'magit-push
 "g p l" 'magit-pull
 "g c" 'magic-commit
 "f" 'helm-find-files)

(define-key evil-normal-state-map (kbd "C-p") 'helm-projectile)

(require 'helm-eshell)
(add-hook 'eshell-mode-hook
          #'(lambda ()
              (define-key eshell-mode-map (kbd "C-r")  'helm-eshell-history)))

(setq helm-split-window-in-side-p       t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp    t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
(helm-autoresize-mode t)

(setq helm-semantic-fuzzy-match t
      helm-imenu-fuzzy-match    t)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)
(helm-mode 1)

; (load-theme 'gotham t)
(load-theme 'flatui t)

(add-to-list 'default-frame-alist
	     '(font . "Droid Sans Mono-12"))
