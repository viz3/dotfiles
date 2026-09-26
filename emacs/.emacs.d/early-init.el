;;; early-init.el --- Early initialization -*- lexical-binding: t; -*-

;; Native compilation on macOS with Homebrew GCC.
(when (eq system-type 'darwin)
  (with-eval-after-load 'comp
    (when-let* ((gcc
                 (seq-find
                  (lambda (file)
                    (string-match-p "/gcc-[0-9]+\\'" file))
                  (file-expand-wildcards
                   "/opt/homebrew/opt/gcc/bin/gcc-*")))
                (libemutls
                 (string-trim
                  (shell-command-to-string
                   (concat (shell-quote-argument gcc)
                           " -print-file-name=libemutls_w.a"))))
                ((file-exists-p libemutls)))
      (add-to-list
       'native-comp-driver-options
       (concat "-L" (file-name-directory libemutls))))))

;; Suppress warnings for legacy Emacs Lisp files without
;; an explicit lexical-binding cookie.
(add-to-list 'warning-suppress-types
             '(files missing-lexbind-cookie))

;;; early-init.el ends here

