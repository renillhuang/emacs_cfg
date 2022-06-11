;; ======================================================================= ;;;
;;; Author: Eric Huang
;;; Reversion: 1.0
;;; Update: 2021/09/22
;;; ======================================================================= ;;;

;;; split the previous version to several parts; do NOT use byte
;;; compile anymore; all extra libraries except those with distro
;;; binaries will be put into ${HOME}/.emacs.d/site-lisp/
;;; Use this file on Ubuntu 14.04 with following package installed
;;; emacs cscope w3m

;;; ======================================================================= ;;;
;;; EXECUTABLE PATH
;;; ======================================================================= ;;;
;;; have a private script directory for emacs only; all utilities will
;;; be put into ~/.emacs.d/scripts
(setenv "PATH" (concat (getenv "PATH") ":~/.emacs.d/scripts"))
(setq exec-path (append exec-path '("~/.emacs.d/scripts")))

;;; ======================================================================= ;;;
;;; LOADPATH
;;; ======================================================================= ;;;
(let ((default-directory "~/.emacs.d/site-lisp/"))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))

;;; ======================================================================= ;;;
;;; USER INFO
;;; ======================================================================= ;;;
(setq user-full-name "Le Pan")
(setq user-mail-address "panle41@qq.com")

;;; ======================================================================= ;;;
;;; INITIALIZE PEMACS
;;; ======================================================================= ;;;
(require 'pemacs-init)
(put 'upcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (leuven)))
 '(custom-safe-themes
   (quote
    ("c3542d6868bbdac1667fd1a7d751fd41520ca63f155b043ffbc4f9b9effb1783" default)))
 '(package-selected-packages
   (quote
    (auto-complete-clang elpy tango-plus-theme package-build flx-ido ido-at-point projectile docker-compose-mode dockerfile-mode ## flycheck))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; PROJECTILE
(projectile-mode +1)
;;(define-key projectile-mode-map (kbd "M-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "M-s") 'projectile-grep)
(define-key projectile-mode-map (kbd "M-p") 'projectile-find-file)
(require 'subr-x)

;; specifying search project
;;(setq projectile-project-search-path '("~/project"))
;;(put 'dired-find-alternate-file 'disabled nil)


;; Python auto-complete and format
(require 'package)
(add-to-list 'package-archives
             '("elpy" . "https://jorgenschaefer.github.io/packages/"))

;; (package-initialize)
;; (elpy-enable)

;; For python auto complete
;;(setq python-shell-interpreter "/usr/bin/python3")
;;(add-hook 'python-mode-hook 'jedi:setup) ;; load auto-complete and pop up
;;(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)

;; Auto-complete
(add-to-list 'load-path "~/.emacs.d/site-list")
(require 'auto-complete)
(global-auto-complete-mode t)

(require 'auto-complete-config)
(ac-ropemacs-initialize)
(global-auto-complete-mode t)
(define-key ac-complete-mode-map "\t" 'ac-expand)
(define-key ac-complete-mode-map "\r" 'ac-complete)
(define-key ac-complete-mode-map "\M-n" 'ac-next)
(define-key ac-complete-mode-map "\M-p" 'ac-previous)
(setq ac-auto-start 3)
(setq ac-dwim t)
(set-default 'ac-sources '(ac-source-abbrev ac-source-words-in-buffer))
(setq ac-modes
         (append ac-modes
                 '(eshell-mode
                         )))

;; Python autocomplete drop down list color theme
;;(set-face-background 'ac-menu-face "lightgray")
;;(set-face-underline 'ac-menu-face "darkgray")
;;(set-face-background 'ac-selection-face "steelblue")


(add-to-list 'load-path "~/.emacs.d/site-lisp/")
(require 'cpputils-cmake)

(add-hook 'c-mode-common-hook
          (lambda ()
            (if (derived-mode-p 'c-mode 'c++-mode)
                (cppcm-reload-all)
              )))
;; OPTIONAL, somebody reported that they can use this package with Fortran
(add-hook 'c90-mode-hook (lambda () (cppcm-reload-all)))
;; OPTIONAL, avoid typing full path when starting gdb
(global-set-key (kbd "C-c C-g")
 '(lambda ()(interactive) (gud-gdb (concat "gdb --fullname " (cppcm-get-exe-path-current-buffer)))))
;; OPTIONAL, some users need specify extra flags forwarded to compiler
(setq cppcm-extra-preprocss-flags-from-user '("-I/usr/src/linux/include" "-DNDEBUG"))

(setq large-file-warning-threshold nil)
