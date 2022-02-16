(defvar package-list
  (list 'flycheck 'evil 'ledger-mode 'treemacs 'evil-leader 'treemacs 'treemacs-evil 'projectile 'undo-tree 'terraform-mode 'ido
    'rainbow-delimiters 'evil-collection 'magit)
  )


;; (use-package ace-window
;;   :ensure t
;;   :init (setq
;; 	      aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)
;;               aw-char-position 'left
;;               aw-ignore-current nil
;;               aw-leading-char-style 'char
;; 	      aw-dispatch-always 't)
;;   :bind (("M-o" . ace-window)
;;          ("M-O" . ace-swap-window)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-undo-system 'undo-tree)
  '(ledger-reports
     '(("bal" "%(binary) -f %(ledger-file) bal Assets Liabilities")
	("reg" "%(binary) -f %(ledger-file) reg")
	("payee" "%(binary) -f %(ledger-file) reg @%(payee)")
	("account" "%(binary) -f %(ledger-file) reg %(account)")))
 '(package-selected-packages '(flycheck ledger-mode evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ledger-font-xact-highlight-face ((t (:weight ultra-bold)))))
(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
;;(package-refresh-contents)

(global-set-key (kbd "C-c i")
  (lambda ()
    (interactive)
    (find-file "~/.emacs.d/init.el")))


(defun as/install-package (package)
  (unless (package-installed-p package)
    (package-install package))
  )

(defun as/install-packages (package-list)
  (dolist (p package-list)
    (as/install-package p)))

(as/install-packages package-list)


(defvar as/indent-width 2)
(setq ring-bell-function 'ignore
  default-directory "~/"
  help-window-select t
  backup-directory-alist `((".*" . ,temporary-file-directory))
  auto-save-file-name-transforms `((".*" ,temporary-file-directory t))
  evil-want-C-u-scroll t
  evil-shift-width as/indent-width
  evil-collection-setup-minibuffer t
  evil-want-keybinding nil
  lisp-indent-offset 2
  help-window-select t
  projectile-project-search-path '("~/src")
  display-line-numbers 'relative
  )


(require 'evil)
(when (require 'evil-collection nil t)
  (evil-collection-init))
(require 'treemacs)
(require 'treemacs-evil)
(require 'undo-tree)
(require 'terraform-mode)
(global-undo-tree-mode)
(global-evil-leader-mode)
(evil-mode 1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(show-paren-mode 1)
(scroll-bar-mode -1)
(projectile-mode +1)
(display-line-numbers-mode +1)
(load-theme 'wombat)
(ido-mode +1)
(add-to-list 'auto-mode-alist '("\\.tf\\'" . terraform-mode))
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(evil-set-leader 'normal (kbd "SPC"))
(evil-define-key 'normal 'global (kbd "<leader>SPC") 'projectile-find-file)
(evil-define-key 'normal 'global (kbd "<leader>sp") 'projectile-ag)
(evil-define-key 'normal 'global (kbd "<leader>ir") 'indent-region)
(evil-define-key 'nil 'global (kbd "C-SPC") 'completion-at-point)
;;(evil-define-key 'normal 'global (kbd "q") 'delete-window)
(evil-define-key 'normal 'global (kbd "<leader>b") 'projectile-ibuffer)
(evil-define-key 'normal 'global (kbd "<leader>b") 'ibuffer)
(evil-define-key 'normal 'global (kbd "<leader>p") 'treemacs) 
(evil-define-key 'normal 'global (kbd "<leader>gg") 'magit) 


;; undo tree
;; linum
;; terraform
;; projectile
;; ace-windowq
;; kill window hotkey
;; which-key
;; treemacs-evil
;; treemacs-icons-dired
;; treemascs-projectile
;; rainbow-delimiters
