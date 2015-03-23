(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'package) ;; You might already have this line

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize) ;; You might already have this line
(defvar my-packages '(better-defaults
		      projectile
		      clojure-mode
                      web-mode
                      git-commit-mode
                      flycheck
			auto-complete
			go-mode
			go-autocomplete
			flymake-cursor
		            cider))
(dolist (p my-packages)
  (unless (package-installed-p p)
    (package-install p)))

(when (load "flymake" t)
  (global-set-key (kbd "M-]") 'flymake-goto-next-error)
  (defun flymake-go-init ()
    (list "gobuild"  (list buffer-file-name)))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.go\\'" flymake-go-init))
  )

(add-hook 'go-mode-hook (lambda () (interactive) (flymake-mode)))
(add-hook 'before-save-hook 'gofmt-before-save)
(require 'auto-complete)
(require 'go-autocomplete)
(require 'auto-complete-config)
(require 'flymake-cursor)
(ac-config-default)
(when (load "flymake" t)
  (global-set-key (kbd "M-]") 'flymake-goto-next-error)
  (defun flymake-go-init ()
    (list "gobuild"  (list buffer-file-name)))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.go\\'" flymake-go-init))
  )
(add-hook 'go-mode-hook (lambda () (interactive) (flymake-mode)))
