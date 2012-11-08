(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
(keyboard-translate ?\C-h ?\C-?)
(global-font-lock-mode t)
(show-paren-mode 1)
(menu-bar-mode -1)
(line-number-mode 1)
(column-number-mode 1)
(auto-fill-mode -1)

;; linum-mode
;; default is 'dynamic, for example, specify "%5d|"
(setq linum-format 'dynamic)

;; set comment out style.
;; see comment-styles in lisp/newcomment.el
(setq comment-style 'extra-line)

;; load-path setting
;; see https://bitbucket.org/sakito/dot.emacs.d/wiki/Home

;; Emacs 設定ディレクトリを設定。Emacs 22以下用
;; Emacs 23.1 以上では user-emacs-directory 変数が用意されているのでそれを利用
(unless (boundp 'user-emacs-directory)
  (defvar user-emacs-directory (expand-file-name "~/.emacs.d/")))

;; 引数を load-path へ追加
;; normal-top-level-add-subdirs-to-load-path はディレクトリ中の中で
;; [A-Za-z] で開始する物だけ追加するので、追加したくない物は . や _ を先頭に付与しておけばロードしない
;; dolist は Emacs 21 から標準関数なので積極的に利用して良い
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))
(add-to-load-path "lisp" "site-lisp")

;; skk
(require 'skk-setup)

;; elscreen
(load "elscreen" "ElScreen" t)

;;; w3m
;(require 'w3m-load)
;(setq browse-url-browser-function 'w3m-browse-url)

;; twittering-mode
(autoload 'twit "twittering-mode" "twittering-mode" t)
(setq twittering-auth-method 'xauth)

;; whitespace
(require 'whitespace)
(setq whitespace-style '(face empty space-before-tab lines-tail trailing))
(add-hook 'c-mode-hook '(lambda () (whitespace-mode t)))
(add-hook 'c++-mode-hook '(lambda () (whitespace-mode t)))
;(global-whitespace-mode t)

;; whitespace behavior
;(setq-default show-trailing-whitespace t)
(setq-default indicate-empty-lines t)

;; emacs-lisp-mode
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (whitespace-mode t)
             (set (make-local-variable 'indent-tabs-mode) nil)))

;; php-mode
;; http://php-mode.sourceforge.net/
(require 'php-mode)
;(setq php-mode-force-pear t)
(add-hook 'php-mode-hook
          '(lambda ()
             (set (make-local-variable 'tab-width) 8)
             (set (make-local-variable 'c-basic-offset) 4)
             (set (make-local-variable 'indent-tabs-mode) nil)
             (c-set-offset 'block-open' -)
             (c-set-offset 'block-close' 0)))

;; c-mode
(add-hook 'c-mode-hook
          '(lambda ()
             (set (make-local-variable 'tab-width) 8)
             (set (make-local-variable 'c-basic-offset) 4)
             (set (make-local-variable 'indent-tabs-mode) nil)
             (c-set-offset 'block-open' -)
             (c-set-offset 'block-close' 0)))

;; gtags
(autoload 'gtags-mode "gtags" "" t)
(setq gtags-suggested-key-mapping t)
;(setq gtags-prefix-key "\C-x")
(add-hook 'c-mode-hook '(lambda () (gtags-mode 1)))
(add-hook 'c++-mode-hook '(lambda () (gtags-mode 1)))
(add-hook 'php-mode-hook '(lambda () (gtags-mode 1)))
(add-hook 'gtags-mode-hook
          '(lambda ()
             (cond ((eq window-system 'ns)
                    (setq gtags-global-command "~/local/bin/global")))))

;; scheme-mode
(modify-coding-system-alist 'process "gosh" '(utf-8 . utf-8))
(setq scheme-program-name
      (cond ((eq window-system 'ns) "~/local/bin/gosh -i")
            (t "gosh -i")))
(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)
(defun scheme-other-window ()
  "Run scheme on other window"
  (interactive)
  (switch-to-buffer-other-window
   (get-buffer-create "*scheme*"))
  (run-scheme scheme-program-name))
(define-key global-map "\C-cs" 'scheme-other-window)
(add-hook 'scheme-mode-hook
          '(lambda ()
             (set (make-local-variable 'indent-tabs-mode) nil)))

;; use ruby-mode for Rakefile
(add-to-list 'auto-mode-alist '("[Rr]akefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))

;; Shell-script mode
(add-hook 'sh-mode-hook
          '(lambda ()
             (whitespace-mode t)
             (toggle-truncate-lines t)
             (set (make-local-variable 'indent-tabs-mode) nil)))

;; markdown-mode
;; http://jblevins.org/projects/markdown-mode/
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))

;; disable vc-git
;; http://stackoverflow.com/questions/5748814/how-does-one-disable-vc-git-in-emacs
(remove-hook 'find-file-hooks 'vc-find-file-hook)

;; environment specific preferences
(cond
 ;; cocoa-emacs
 ((eq window-system 'ns)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  ;; font
  (create-fontset-from-ascii-font "Menlo-14:weight=normal:slant=normal" nil "menlokakugo")
  (set-fontset-font "fontset-menlokakugo"
                    'unicode
                    (font-spec :family "Hiragino Kaku Gothic ProN" :size 16)
                    nil
                    'append)
  (add-to-list 'default-frame-alist '(font . "fontset-menlokakugo"))))
