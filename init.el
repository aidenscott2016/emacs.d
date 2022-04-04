(require 'package)
(defvar package-list (list 'flycheck 'evil 'ledger-mode 'treemacs
		       'evil-leader 'treemacs 'treemacs-evil
		       'projectile 'undo-tree 'terraform-mode
		       'ido 'rainbow-delimiters 'evil-collection
		       'magit 'treemacs-projectile 'which-key
		       'format-all 'geiser-mit 'hydra 'paredit
		       'org-autolist 'ox-jira 'restclient 'tide
		       'ace-window 'yaml-mode ) )


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
  '(ansi-color-faces-vector
     [default default default italic underline success warning error])
  '(ansi-color-names-vector
     ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
  '(custom-enabled-themes '(adwaita))
  '(evil-goto-definition-functions
     '(evil-goto-definition-imenu evil-goto-definition-semantic evil-goto-definition-xref evil-goto-definition-search tide-jump-to-definition))
  '(evil-undo-system 'undo-tree)
  '(format-all-debug nil)
  '(format-all-default-formatters
     '(("Assembly" asmfmt)
	("ATS" atsfmt)
	("Bazel" buildifier)
	("BibTeX" emacs-bibtex)
	("C" clang-format)
	("C#" clang-format)
	("C++" clang-format)
	("Cabal Config" cabal-fmt)
	("Clojure" cljfmt)
	("CMake" cmake-format)
	("Crystal" crystal)
	("CSS" prettier)
	("Cuda" clang-format)
	("D" dfmt)
	("Dart" dart-format)
	("Dhall" dhall)
	("Dockerfile" dockfmt)
	("Elixir" mix-format)
	("Elm" elm-format)
	("Emacs Lisp" emacs-lisp)
	("F#" fantomas)
	("Fish" fish-indent)
	("Fortran Free Form" fprettify)
	("GLSL" clang-format)
	("Go" gofmt)
	("GraphQL" prettier)
	("Haskell" brittany)
	("HTML" html-tidy)
	("Java" clang-format)
	("JavaScript" prettier)
	("JSON" prettier)
	("Jsonnet" jsonnetfmt)
	("JSX" prettier)
	("Kotlin" ktlint)
	("LaTeX" latexindent)
	("Less" prettier)
	("Literate Haskell" brittany)
	("Lua" lua-fmt)
	("Markdown" prettier)
	("Nix" nixpkgs-fmt)
	("Objective-C" clang-format)
	("OCaml" ocp-indent)
	("Perl" perltidy)
	("PHP" prettier)
	("Protocol Buffer" clang-format)
	("PureScript" purty)
	("Python" black)
	("R" styler)
	("Reason" bsrefmt)
	("ReScript" rescript)
	("Ruby" rufo)
	("Rust" rustfmt)
	("Scala" scalafmt)
	("SCSS" prettier)
	("Shell" shfmt)
	("Solidity" prettier)
	("SQL" sqlformat)
	("Svelte" prettier)
	("Swift" swiftformat)
	("Terraform" terraform-fmt)
	("TOML" prettier)
	("TSX" prettier)
	("TypeScript" prettier)
	("V" v-fmt)
	("Verilog" istyle-verilog)
	("Vue" prettier)
	("XML" html-tidy)
	("YAML" prettier)
	("_Angular" prettier)
	("_Flow" prettier)
	("_Gleam" gleam)
	("_Ledger" ledger-mode)
	("_Nginx" nginxfmt)
	("_Snakemake" snakefmt)
	("Scheme" emacs-lisp)))
  '(format-all-show-errors 'never)
  '(ledger-reports
     '(("bal" "%(binary) -f %(ledger-file) -c bal Assets Liabilities")
	("reg" "%(binary) -f %(ledger-file) reg")
	("payee" "%(binary) -f %(ledger-file) reg @%(payee)")
	("account" "%(binary) -f %(ledger-file) reg %(account)")))
  '(package-selected-packages
     '(yaml-mode htmlize restclient ox-jira flycheck ledger-mode evil))
  '(projectile-globally-ignored-directories
     '(".bloop" ".idea" ".vscode" ".ensime_cache" ".eunit" ".git" ".hg" ".fslckout" "_FOSSIL_" ".bzr" "_darcs" ".tox" ".svn" ".stack-work" ".ccls-cache" ".cache" ".clangd"))
  '(projectile-project-search-path '("~/src" "~/crap" "~/ledger")))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  '(ledger-font-xact-highlight-face ((t (:weight ultra-bold))))
  '(terraform--resource-name-face ((t (:foreground "dark orange" :weight semi-bold)))))


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
  display-line-numbers 'relative
  display-line-numbers-type 'relative
  geiser-active-implementations '(mit)
  )


(require 'evil)
(when (require 'evil-collection nil t)
  (evil-collection-init))

(require 'treemacs)
(require 'treemacs-evil)
(require 'undo-tree)
(require 'terraform-mode)
(require 'display-line-numbers)
(require 'treemacs-projectile)
(require 'ox-jira)
(require 'typescript-mode)
(require 'tide)
(which-key-mode)
(global-undo-tree-mode)
(global-evil-leader-mode)
(global-display-line-numbers-mode)
(evil-mode 1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(show-paren-mode 1)
(scroll-bar-mode -1)
(projectile-mode +1)
(global-company-mode +1)

					;(load-theme 'wombat)
(ido-mode +1)
(add-to-list 'auto-mode-alist '("\\.tf\\'" . terraform-mode))
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook 'format-all-mode)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'format-all-mode-hook 'format-all-ensure-formatter)

(evil-set-leader 'normal (kbd "SPC"))
(evil-define-key 'normal 'global (kbd "<leader>SPC") 'projectile-find-file-dwim)
(evil-define-key 'normal 'global (kbd "<leader>sp") 'projectile-ag)
(evil-define-key 'normal 'global (kbd "<leader>ir") 'indent-region)
(evil-define-key 'nil 'global (kbd "C-SPC") 'company-complete)
;;(evil-define-key 'normal 'global (kbd "q") 'delete-window)
(evil-define-key 'normal 'global (kbd "<leader>b") 'projectile-ibuffer)
(evil-define-key 'normal 'global (kbd "<leader>ib") 'ibuffer)
(evil-define-key 'normal 'global (kbd "<leader>p") 'treemacs)
(evil-define-key 'normal 'global (kbd "<leader>gg") 'magit)
(evil-define-key 'normal 'global (kbd "<leader>f") 'format-all-buffer)
(evil-define-key 'normal 'global (kbd "<leader>xb") 'eval-buffer)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(evil-define-key 'normal 'global (kbd "<leader>w") 'ace-window)
(evil-define-key 'normal 'global (kbd "<leader>q") 'ace-delete-window)
(evil-define-key 'normal 'global (kbd "gd") 'evil-jump-to-tag)
(define-key projectile-mode-map (kbd "C-x d") 'dired-at-point)


;; linum
;; ace-windowq
;; kill window hotkey
;; treemacs-icons-dired
(add-hook 'lsp-mode-hook
  (evil-define-key 'normal 'global (kbd "<leader>f") 'lsp-format-buffer)
  )


(add-hook 'ledger-mode-hook
  (lambda ()
    (defun bal-report ()q
      (interactive)
      (ledger-report "bal" nil))

    (evil-define-key 'normal 'global (kbd "<leader>rb") 'bal-report)))
(evil-define-key 'normal 'global (kbd "<leader>cc") 'projectile-compile-project)


(ignore-errors
  (require 'ansi-color)
  (defun my-colorize-compilation-buffer ()
    (when (eq major-mode 'compilation-mode)
      (ansi-color-apply-on-region compilation-filter-start (point-max))))
  (add-hook 'compilation-filter-hook 'my-colorize-compilation-buffer))


(load "/home/aiden/.emacs.d/metals.el")

(add-hook 'org-mode-hook (lambda () (org-autolist-mode)))


(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(provide 'init)
