(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "1297a022df4228b81bc0436230f211bad168a117282c20ddcba2db8c6a200743" "d5de5ffdc352e765d4cdf02716941d932b9587dc2f768912e123cde24221b77e" "e80932ca56b0f109f8545576531d3fc79487ca35a9a9693b62bf30d6d08c9aaf" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "8d6fb24169d94df45422617a1dfabf15ca42a97d594d28b3584dc6db711e0e0b" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "08efabe5a8f3827508634a3ceed33fa06b9daeef9c70a24218b70494acdf7855" "764e3a6472a3a4821d929cdbd786e759fab6ef6c2081884fca45f1e1e3077d1d" "bede70e4b2654751936d634040347bb4704fa956ecf7dceab03661a75e46a8ca" "3fd36152f5be7e701856c3d817356f78a4b1f4aefbbe8bbdd1ecbfa557b50006" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "be50a45342f47158a8d34f54ffecc63f55dbdf66ad672c171c48e9dac56fff52" "0ba649556dc51762e6794b92017f6f7406754ae3136eafef686d81c6da176cc5" "990920bac6d35106d59ded4c9fafe979fb91dc78c86e77d742237bc7da90d758" "2e11112c059abb3609d56ba4bd8d755a90888ab5bcbc679cd7082cc02e30ad3c" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default)))
 '(elpy-modules
   (quote
    (elpy-module-company elpy-module-eldoc elpy-module-flymake elpy-module-pyvenv elpy-module-yasnippet elpy-module-sane-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

(require 'saveplace)
(setq-default save-place t)

(fset 'yes-or-no-p 'y-or-n-p)

(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(unless (display-graphic-p) (menu-bar-mode -1))

(display-time-mode 1)

(require 'undo-tree)
(global-undo-tree-mode)
(setq undo-tree-auto-save-history t)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq undo-tree-history-directory-alist
      `((".*" . ,temporary-file-directory)))

;; compile
(setq compilation-always-kill t)
(setq compilation-ask-about-save nil)

;; clean up old buffers periodically
(require 'midnight)
(midnight-delay-set 'midnight-delay 0)
(setq delete-by-moving-to-trash t)

(setq-default indent-tabs-mode nil
              default-tab-width 2)

(blink-cursor-mode -1)
(electric-indent-mode t)
(electric-pair-mode t)

;; tramp, for sudo access
(require 'tramp)
;;(setenv "TMPDIR" "/tmp")
;; keep in mind known issues with zsh - see emacs wiki
;;(setq tramp-default-method "ssh")

(blink-cursor-mode -1)
(setq inhibit-startup-screen t)
(setq ring-bell-function 'ignore)

(global-hl-line-mode)

;; (setq-default truncate-lines t)

;; Show absolute line number for current line
(defvar linum-relative-current-symbol "")
(require 'linum-relative)
(setq linum-relative-format "%3s ")

(global-linum-mode 1)

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
;; (linum-on)


;; (defadvice linum-update-window (around linum-dynamic activate)
;;   (let* ((w (length (number-to-string
;;                      (count-lines (point-min) (point-max)))))
;;          (linum-format (concat " %" (number-to-string w) "d ")))
;;     ad-do-it))

(fringe-mode -1)
(require 'linum-off)

(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-hook 'markdown-mode-hook 'pandoc-mode)
(add-hook 'pandoc-mode-hook 'pandoc-load-default-settings)

(require 'evil)

(evil-mode 1)
(define-key evil-inner-text-objects-map "a" 'evil-inner-arg)
(define-key evil-outer-text-objects-map "a" 'evil-outer-arg)
(global-evil-surround-mode t)
(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")
(setq evilnc-hotkey-comment-operator "gc")
(require 'evil-nerd-commenter)

(add-hook 'c-mode-common-hook
  (lambda ()
    ;; Preferred comment style
    (setq comment-start "// "
          comment-end "")))
(global-evil-snipe-mode 1)

(projectile-global-mode)
(helm-projectile-on)

(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/dotfiles/emacs.d/.cask/24.4.91.1/elpa/yasnippet-20150318.348/snippets"
        ))

(yas-global-mode 1)

(add-hook 'term-mode-hook (lambda()
        (setq yas-dont-activate t)))

(require 'smartparens-config)
(setq sp-autoskip-closing-pair 'always)
(show-smartparens-global-mode t)
(smartparens-global-mode t)

(require 'magit)
(evil-add-hjkl-bindings magit-log-mode-map 'emacs)
(evil-add-hjkl-bindings magit-commit-mode-map 'emacs)
(evil-add-hjkl-bindings magit-branch-manager-mode-map 'emacs
  "K" 'magit-discard-item
  "L" 'magit-key-mode-popup-logging)
(evil-add-hjkl-bindings magit-status-mode-map 'emacs
  "K" 'magit-discard-item
  "l" 'magit-key-mode-popup-logging
  "h" 'magit-toggle-diff-refine-hunk)

(setq magit-last-seen-setup-instructions "1.4.0")

;; auto-indent on RET
(define-key global-map (kbd "RET") 'newline-and-indent)

(evil-leader/set-key
 "<SPC>" 'helm-mini
 "x" 'helm-M-x
 "b" 'helm-buffers-list
 "y" 'helm-show-kill-ring
 "i" 'helm-semantic-or-imenu
 "o" 'helm-occur
 "a" 'helm-projectil-ag
 "y" 'helm-show-kill-ring
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
              (define-key evil-insert-state-map (kbd "C-r")  'helm-eshell-history)))

(setq helm-split-window-in-side-p       t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp    t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)
(setq helm-display-header-line nil) ;; t by default
(set-face-attribute 'helm-source-header nil :height 0.1)
(helm-autoresize-mode t)

(require 'helm)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(setq helm-semantic-fuzzy-match t
      helm-imenu-fuzzy-match    t)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)
(helm-mode 1)

(require 'company)

;; (add-hook 'python-mode-hook 'anaconda-mode)
;; (add-to-list 'company-backends 'company-anaconda)
;; (add-hook 'python-mode-hook 'eldoc-mode)

(add-hook 'after-init-hook 'global-company-mode)

(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "<tab>") 'company-select-next)
(define-key company-active-map (kbd "<backtab>") 'company-select-previous)
;; 0.1 second delay before the pop-up appears
(setq company-idle-delay 0.0)
;; you only need to enter one character in a buffer before auto-completion starts
(setq company-minimum-prefix-length 1)

(setq company-global-modes
    '(not
	eshell-mode comint-mode org-mode erc-mode))

(add-hook 'after-init-hook #'global-flycheck-mode)
(elpy-enable)

(add-to-list 'auto-mode-alist '("\\.upc\\'" . c-mode))

(with-eval-after-load 'flycheck
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

(require 'diminish)
(diminish 'helm-mode)
(diminish 'smartparens-mode)
(diminish 'evil-snipe-mode)
(diminish 'undo-tree-mode)
(diminish 'projectile-mode)
(diminish 'magit-auto-revert-mode)

(load-theme 'solarized t)

;; (require 'powerline)
;; (powerline-default-theme)

(sml/setup)

;; (add-to-list 'default-frame-alist
;; 	     '(font . "Droid Sans Mono-12"))

(add-to-list 'default-frame-alist
	     '(font . "Inconsolata-dz-12"))

;; (set-frame-parameter (selected-frame) 'alpha '(95 95))

;; (add-to-list 'default-frame-alist '(alpha 95 95))
