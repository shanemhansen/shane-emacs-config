;;shane's .emacs
(xterm-mouse-mode)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "/usr/local/emacs-config")

(setq js2-bounce-indent-p t)
(setq auto-mode-alist
      (append '(("\\.tac?$" . python-mode)) auto-mode-alist))

(column-number-mode 1)
;;(require 'less-css-mode)
;;flymake mode
(require 'package)
(add-to-list 'package-archives
         '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)
(require 'flymake)
(require 'flymake-cursor)
(add-hook 'go-mode-hook 
          (add-hook 'before-save-hook #'gofmt-before-save)
          (require 'go-autocomplete)
          #'(lambda () 
              (setq indent-tabs-mode nil)))
(when (load "flymake" t)
  (defun flymake-go-init ()
      (list "gobuild"  (list buffer-file-name)))
   (add-to-list 'flymake-allowed-file-name-masks
             '("\\.go\\'" flymake-go-init))   
)
(when (load "flymake" t)
  (defun flymake-protobuf-init ()
    (list "gobuild" (list buffer-file-name)))
    (add-to-list 'flymake-allowed-file-name-masks
                 '("\\.proto\\'" flymake-protobuf-init)
   ))
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
               'flymake-create-temp-inplace))
       (local-file (file-relative-name
            temp-file
            (file-name-directory buffer-file-name))))
      (list "epylint"  (list local-file))))
   (add-to-list 'flymake-allowed-file-name-masks
             '("\\.py\\'" flymake-pyflakes-init))
   (global-set-key (kbd "M-]") 'flymake-goto-next-error)
   )
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
(add-hook 'python-mode-hook (lambda () 
                              (add-to-list 'flymake-allowed-file-name-masks
                                           '(".*" flymake-pyflakes-init))
                              (setq indent-tabs-mode t)
                              (interactive)
                              (flymake-mode)
                              ))
(add-hook 'go-mode-hook (lambda () (interactive) (flymake-mode)))
(require 'auto-complete-config)
(require 'auto-complete)
(global-auto-complete-mode t)
