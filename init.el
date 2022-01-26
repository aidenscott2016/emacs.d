;;; init.el --- Initialization file for Emacs
;;; Commentary:

;;; Code:
(require 'package)

;; u to your packages repositories
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

;; Install use-package if not already installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-defer t
      use-package-always-ensure t)

(use-package emacs
  :preface
  (defvar aiden/indent-width 2)
  (defun aiden/init-el ()
    (interactive)
    (find-file "~/.emacs.d/init.el")
    )

  :bind ("C-c i" . 'aiden/init-el )
  :config
  (setq ring-bell-function 'ignore
        default-directory "~/"
	help-window-select t
	backup-directory-alist `((".*" . ,temporary-file-directory))
	auto-save-file-name-transforms `((".*" ,temporary-file-directory t))
	)
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (show-paren-mode 1)
  (scroll-bar-mode -1)
  (load-theme 'wombat)
  )

(use-package ido
  :config
  (ido-mode 1)
  (ido-everywhere)
  (fido-mode)
  (setq ido-enable-flex-matching t)
  )
  

(use-package evil
  :init
  (setq evil-want-C-u-scroll t
	evil-want-keybinding nil
	evil-want-integration t
	evil-shift-width aiden/indent-width
	)
  :preface
  (defun aiden/save-and-kill-this-buffer ()
    (interactive)
    (save-buffer)
    (kill-this-buffer-and-window))
  :hook (after-init . evil-mode)
  :config
  (evil-set-leader 'normal (kbd "<SPC>"))
  (add-to-list 'evil-emacs-state-modes 'dired-mode)
  (evil-define-key 'normal 'global (kbd "C-/") 'comment-dwim)
  (evil-define-key 'normal 'global (kbd "<leader> c") 'compile)
  (with-eval-after-load 'evil-maps ; avoid conflict with company tooltip selection
    (define-key evil-insert-state-map (kbd "C-n") nil)
    (define-key evil-insert-state-map (kbd "C-p") nil))
  ;; (evil-ex-define-cmd "q" #'kill-this-buffer-and-window)
  ;;(evil-ex-define-cmd "wq" #'aiden/save-and-kill-this-buffer)
  )

(use-package which-key
  :ensure t
  :bind ("C-h m" . which-key-show-major-mode)
  :hook (after-init . which-key-mode)
  :config
  (setq which-key-allow-evil-operators "true")
  (which-key-setup-side-window-right-bottom)
  )



(use-package undo-tree
  :ensure t
  :after evil
  :diminish
  :config
  (evil-set-undo-system 'undo-tree)
  (global-undo-tree-mode 1))

(use-package display-line-numbers
  :config
  (global-display-line-numbers-mode))


(use-package terraform-mode
  :mode "\\.tf\\'")

(use-package projectile
  :ensure t
  :after evil
  :init
  (projectile-mode +1)
  :config
  (setq projectile-project-search-path '("~/src/"))
  (evil-define-key 'normal 'global (kbd "<leader><SPC>") 'projectile-find-file)
  (evil-define-key 'normal 'global (kbd "<leader>sp") 'projectile-ag)
  :bind ( :map projectile-mode-map
              ("C-c p" . projectile-command-map)))

;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(package-selected-packages
;;    '(evil-collection company yasnippet lsp-ui lsp-metals lsp-mode flycheck sbt-mode scala-mode elisp-slime-nav elist-slime-nav magit rainbow-delimiters treemacs-magit treemacs-icons-dired treemacs-projectile treemacs-evil treemacs ace-window which-key use-package undo-tree terraform-mode projectile evil doom-themes))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )



(use-package ace-window
  :ensure t
  :init (setq
	      aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)
              aw-char-position 'left
              aw-ignore-current nil
              aw-leading-char-style 'char
	      aw-dispatch-always 't)
  :bind (("M-o" . ace-window)
         ("M-O" . ace-swap-window)))

(use-package treemacs
  :defer t
  :ensure t
  :config
    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)

    ;; (pcase (cons (not (null (executable-find "git")))
    ;;              (not (null treemacs-python-executable)))
    ;;   (`(t . t)
    ;;   (treemacs-git-mode 'deferred))
    ;;   (`(t . _)
    ;;    (treemacs-git-mode 'simple)))

    ;; (treemacs-hide-gitignored-files-mode nil))
  :bind
  ( :map global-map
        ("<leader> p p"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :ensure t
  :after (treemacs evil)
  )

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(use-package rainbow-delimiters
  :ensure t
  :hook
  ((emacs-lisp-mode . rainbow-delimiters-mode)
   (ielm-mode . rainbow-delimiters-mode)
   (lisp-interaction-mode . rainbow-delimiters-mode)
   (lisp-mode . rainbow-delimiters-mode))
  :config
  (set-face-foreground 'rainbow-delimiters-depth-1-face "#c66")  ; red
  (set-face-foreground 'rainbow-delimiters-depth-2-face "#6c6")  ; green
  (set-face-foreground 'rainbow-delimiters-depth-3-face "#69f")  ; blue
  (set-face-foreground 'rainbow-delimiters-depth-4-face "#cc6")  ; yellow
  (set-face-foreground 'rainbow-delimiters-depth-5-face "#6cc")  ; cyan
  (set-face-foreground 'rainbow-delimiters-depth-6-face "#c6c")  ; magenta
  (set-face-foreground 'rainbow-delimiters-depth-7-face "#ccc")  ; light gray
  (set-face-foreground 'rainbow-delimiters-depth-8-face "#999")  ; medium gray
  (set-face-foreground 'rainbow-delimiters-depth-9-face "#666")  ; dark gray
  )


(use-package magit
  :config (setq  magit-clone-default-directory "~/src/")
  :bind ("<leader> g" . magit))


(use-package elisp-slime-nav
  :hook ielm-mode)


;; Enable scala-mode for highlighting, indentation and motion commands
(use-package scala-mode
  :interpreter
    ("scala" . scala-mode))

;; Enable sbt mode for executing sbt commands
(use-package sbt-mode
  :commands sbt-start sbt-command
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map)
   ;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
   (setq sbt:program-options '("-Dsbt.supershell=false"))
)

;; Enable nice rendering of diagnostics like compile errors.
(use-package flycheck
  :init (global-flycheck-mode))

(use-package lsp-mode
  ;; Optional - enable lsp-mode automatically in scala files
  :hook  (scala-mode . lsp)
         (lsp-mode . lsp-lens-mode)
  :config
  ;; Uncomment following section if you would like to tune lsp-mode performance according to
  ;; https://emacs-lsp.github.io/lsp-mode/page/performance/
  ;;       (setq gc-cons-threshold 100000000) ;; 100mb
  ;;       (setq read-process-output-max (* 1024 1024)) ;; 1mb
  ;;       (setq lsp-idle-delay 0.500)
  ;;       (setq lsp-log-io nil)
  ;;       (setq lsp-completion-provider :capf)
  (setq lsp-prefer-flymake nil))

;; Add metals backend for lsp-mode
(use-package lsp-metals)

;; Enable nice rendering of documentation on hover
;;   Warning: on some systems this package can reduce your emacs responsiveness significally.
;;   (See: https://emacs-lsp.github.io/lsp-mode/page/performance/)
;;   In that case you have to not only disable this but also remove from the packages since
;;   lsp-mode can activate it automatically.
(use-package lsp-ui)

;; lsp-mode supports snippets, but in order for them to work you need to use yasnippet
;; If you don't want to use snippets set lsp-enable-snippet to nil in your lsp-mode settings
;;   to avoid odd behavior with snippets and indentation
(use-package yasnippet)

;; Use company-capf as a completion provider.
;;
;; To Company-lsp users:
;;   Company-lsp is no longer maintained and has been removed from MELPA.
;;   Please migrate to company-capf.
(use-package company
  :hook (scala-mode . company-mode)
  :config
  (setq lsp-completion-provider :capf))

;; Use the Debug Adapter Protocol for running tests and debugging
(use-package posframe
  ;; Posframe is a pop-up tool that must be manually installed for dap-mode
  )
(use-package dap-mode
  :hook
  (lsp-mode . dap-mode)
  (lsp-mode . dap-ui-mode)
  )





(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package ag
  :config (setq ag-highlight-search t)
  :hook (ag-mode . next-error-follow-minor-mode)
  )

(provide 'init)



;;; init.el ends here

(custom-set-variables
 ;; custom-set-variables was added by Custom. sp
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(evil-treemacs yasnippet which-key use-package undo-tree treemacs-projectile treemacs-icons-dired treemacs-evil terraform-mode sbt-mode rainbow-delimiters magit lsp-ui lsp-metals flycheck evil-collection elisp-slime-nav company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
