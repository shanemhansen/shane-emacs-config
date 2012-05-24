;;shane's .emacs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized/")
(load-theme 'solarized-dark t)
;;(require 'go-mode-load)

(setq js2-bounce-indent-p t)
(setq auto-mode-alist
      (append '(("\\.tac?$" . python-mode)) auto-mode-alist))

(column-number-mode 1)
(require 'less-css-mode)
;;flymake mode
(require 'flymake)
(require 'flymake-cursor)
(add-hook 'go-mode-hook 
          #'(lambda () (setq indent-tabs-mode nil)))
(when (load "flymake" t)
  (defun flymake-go-init ()
     (list "go" (list "build"))
     )
   (add-to-list 'flymake-allowed-file-name-masks '("\\.go\\'" flymake-go-init))
 
)
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
               'flymake-create-temp-inplace))
       (local-file (file-relative-name
            temp-file
            (file-name-directory buffer-file-name))))
      (list "flud-epylint"  (list local-file))))
   (add-to-list 'flymake-allowed-file-name-masks
             '("\\.py\\'" flymake-pyflakes-init))
   )
(require 'package)
(add-to-list 'package-archives
         '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)
(defun select-next-window ()
  "Switch to the next window" 
  (interactive)
  (select-window (next-window)))

(defun select-previous-window ()
  "Switch to the previous window" 
  (interactive)
  (select-window (previous-window)))

(global-set-key (kbd "M-<right>") 'select-next-window)
(global-set-key (kbd "M-<left>")  'select-previous-window)
(add-hook 'python-mode-hook (lambda () (interactive) (flymake-mode)))
(defun python-test () 
  (interactive)
  (let ((file (buffer-file-name (current-buffer))))
    (compile (concat "~/bin/test " file) )
    )
)
(global-set-key "\C-x\C-e"  'python-test)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(require 'auto-complete)
(global-auto-complete-mode t)
