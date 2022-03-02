(defvar package-list (list 'flycheck 'evil 'ledger-mode 'treemacs
		       'evil-leader 'treemacs 'treemacs-evil 'projectile 'undo-tree
		       'terraform-mode 'ido
		       'rainbow-delimiters 'evil-collection 'magit 'treemacs-projectile 'which-key 'format-all 'geiser-mit)
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
  '(ledger-reports
     '(("bal" "%(binary) -f %(ledger-file) -c bal Assets Liabilities")
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
  projectile-project-search-path '("~/src" "~/ledger")
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
(which-key-mode)
(global-undo-tree-mode)
(global-evil-leader-mode)
(evil-mode 1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(show-paren-mode 1)
(scroll-bar-mode -1)
(projectile-mode +1)
(load-theme 'wombat)
(ido-mode +1)
(add-to-list 'auto-mode-alist '("\\.tf\\'" . terraform-mode))
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook 'format-all-mode)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'format-all-mode-hook 'format-all-ensure-formatter)

(evil-set-leader 'normal (kbd "SPC"))
(evil-define-key 'normal 'global (kbd "<leader>SPC") 'projectile-find-file-dwim)
(evil-define-key 'normal 'global (kbd "<leader>sp") 'projectile-ag)
(evil-define-key 'normal 'global (kbd "<leader>ir") 'indent-region)
(evil-define-key 'nil 'global (kbd "C-SPC") 'completion-at-point)
;;(evil-define-key 'normal 'global (kbd "q") 'delete-window)
(evil-define-key 'normal 'global (kbd "<leader>b") 'projectile-ibuffer)
(evil-define-key 'normal 'global (kbd "<leader>ib") 'ibuffer)
(evil-define-key 'normal 'global (kbd "<leader>p") 'treemacs)
(evil-define-key 'normal 'global (kbd "<leader>gg") 'magit)
(evil-define-key 'normal 'global (kbd "<leader>f") 'format-all-buffer)
(evil-define-key 'normal 'global (kbd "<leader>xb") 'eval-buffer)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)


;; linum
;; ace-windowq
;; kill window hotkey
;; treemacs-icons-dired

(add-hook 'ledger-mode-hook
  (lambda ()
    (defun bal-report ()
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
