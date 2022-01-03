(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(setq use-package-always-ensure t)

(eval-when-compile
  (require 'use-package))

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
	)
  (tool-bar-mode -1)
  (menu-bar-mode -1)
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
	evil-shift-width aiden/indent-width
	)
  :hook (after-init . evil-mode)
  :preface
  (defun ian/save-and-kill-this-buffer ()
    (interactive)
    (save-buffer)
    (kill-this-buffer))
  :config

  (add-to-list 'evil-emacs-state-modes 'dired-mode)
  (with-eval-after-load 'evil-maps ; avoid conflict with company tooltip selection
    (define-key evil-insert-state-map (kbd "C-n") nil)
    (define-key evil-insert-state-map (kbd "C-p") nil))
  (evil-ex-define-cmd "q" #'kill-this-buffer)
  (evil-ex-define-cmd "wq" #'ian/save-and-kill-this-buffer))

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
  :init
  (projectile-mode +1)
  :config
  (setq projectile-project-search-path '("~/src"))
  :bind ( :map projectile-mode-map
              ("C-c p" . projectile-command-map)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(magit rainbow-delimiters treemacs-magit treemacs-icons-dired treemacs-projectile treemacs-evil treemacs ace-window which-key use-package undo-tree terraform-mode projectile evil doom-themes)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



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
  :ensure t
  :defer t
  :config
  (progn
    
    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  ( :map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

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
  :bind ("C-c m" . magit))
