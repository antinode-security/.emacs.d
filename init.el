(setq debug-on-error t)

;;; Menu Bars
(menu-bar-mode 1)
(tool-bar-mode -99)

;;; Package Management
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(ace-jump-mode coffee-mode
                                    feature-mode geiser
                                    inf-ruby magit
                                    yasnippet)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;;; Yasnippet
(require 'yasnippet)
(yas--initialize)
(setq yas/root-directory "~/.emacs.d/snippets")
(yas/load-directory "~/.emacs.d/elpa/feature-mode-0.4/snippets")
(yas/load-directory yas/root-directory)

;;; Theme
(load-theme 'solarized-dark t)

;;; AceJumpMode
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;;; CoffeeScript
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

(defun coffee-custom ()
  "coffee-mode-hook"

  ;; Emacs key binding
  (define-key coffee-mode-map [(meta r)] 'coffee-compile-buffer))

(add-hook 'coffee-mode-hook '(lambda () (coffee-custom)))
(setq coffee-tab-width 4)

;;; Ruby
(require 'inf-ruby)

;;; ido
(require 'ido)
(ido-mode t)

;;; Helper functions
(defun iwb ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))
