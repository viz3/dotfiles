;;; init.el  -*- lexical-binding: t; -*-

;; ----------------------------------------------------------------------
;; Language / encoding
;; ----------------------------------------------------------------------

(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

;; C-h -> Backspace
(keyboard-translate ?\C-h ?\C-?)

;; ----------------------------------------------------------------------
;; Basic settings
;; ----------------------------------------------------------------------

(show-paren-mode 1)
(menu-bar-mode -1)
(line-number-mode 1)
(column-number-mode 1)

(setq-default indicate-empty-lines t)

;; Comment style
(setq comment-style 'extra-line)

;; ----------------------------------------------------------------------
;; Window movement
;; C-q h/j/k/l
;; ----------------------------------------------------------------------

(define-prefix-command 'windmove-map)
(global-set-key (kbd "C-q") 'windmove-map)
(define-key windmove-map (kbd "h") #'windmove-left)
(define-key windmove-map (kbd "j") #'windmove-down)
(define-key windmove-map (kbd "k") #'windmove-up)
(define-key windmove-map (kbd "l") #'windmove-right)

;; ----------------------------------------------------------------------
;; load-path
;; ----------------------------------------------------------------------

(defun add-to-load-path (&rest paths)
  (dolist (path paths)
    (let ((default-directory
           (expand-file-name path user-emacs-directory)))
      (add-to-list 'load-path default-directory)
      (when (fboundp 'normal-top-level-add-subdirs-to-load-path)
        (normal-top-level-add-subdirs-to-load-path)))))

(add-to-load-path "lisp" "site-lisp")

;; ----------------------------------------------------------------------
;; Packages
;; ----------------------------------------------------------------------

(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

;; ----------------------------------------------------------------------
;; SKK
;; ----------------------------------------------------------------------

(global-set-key (kbd "C-x C-j") #'skk-mode)

;; ----------------------------------------------------------------------
;; ElScreen
;; ----------------------------------------------------------------------

(require 'elscreen)
(elscreen-start)

;; ----------------------------------------------------------------------
;; Whitespace
;; ----------------------------------------------------------------------

(require 'whitespace)

(setq whitespace-style
      '(face empty space-before-tab lines-tail trailing))

;; ----------------------------------------------------------------------
;; Emacs Lisp
;; ----------------------------------------------------------------------

(defun my-emacs-lisp-mode-setup ()
  (setq-local indent-tabs-mode nil)
  (whitespace-mode 1))

(add-hook 'emacs-lisp-mode-hook #'my-emacs-lisp-mode-setup)

;; ----------------------------------------------------------------------
;; C / C++
;; ----------------------------------------------------------------------

(defun my-c-mode-setup ()
  (setq-local tab-width 8
              c-basic-offset 4
              indent-tabs-mode nil)
  (c-set-offset 'block-open '-)
  (c-set-offset 'block-close 0)
  (whitespace-mode 1))

(add-hook 'c-mode-hook #'my-c-mode-setup)
(add-hook 'c++-mode-hook #'my-c-mode-setup)

;; ----------------------------------------------------------------------
;; Shell script
;; ----------------------------------------------------------------------

(defun my-sh-mode-setup ()
  (setq-local indent-tabs-mode nil)
  (whitespace-mode 1)
  (toggle-truncate-lines 1))

(add-hook 'sh-mode-hook #'my-sh-mode-setup)

;; ----------------------------------------------------------------------
;; Markdown
;; ----------------------------------------------------------------------

(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; ----------------------------------------------------------------------
;; GUI
;; ----------------------------------------------------------------------

(when (display-graphic-p)
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

;; Font
(when (and (display-graphic-p)
           (find-font (font-spec :family "PlemolJP")))
  (set-face-attribute 'default nil
                      :family "PlemolJP"
                      :height 120)
  (set-face-attribute 'fixed-pitch nil
                      :family "PlemolJP"
                      :height 120))

;; ----------------------------------------------------------------------
;; Custom
;; ----------------------------------------------------------------------

(custom-set-variables
 '(package-selected-packages '(elscreen markdown-mode)))

(custom-set-faces)
