;; This is the Aquamacs Preferences file.
;; Add Emacs-Lisp code here that should be executed whenever
;; you start Aquamacs Emacs. If errors occur, Aquamacs will stop
;; evaluating this file and print errors in the *Messags* buffer.
;; Use this file in place of ~/.emacs (which is loaded as well.)

;; display filename in the window title
(setq frame-title-format "%b - %f")

;; set them colors!
;;(set-foreground-color "pale goldenrod")
;;(set-background-color "dark slate gray")
;;(setq default-frame-alist '((background-color . "dark slate gray") (foreground-color . "pale goldenrod")  ))
(setq initial-frame-alist '((background-color . "gray18") ))
(setq default-frame-alist '((background-color . "gray18") ))

;; brace highlighting
;(show-paren-mode t)

(setq debug-on-error t)

;; faster goto-line functionality
;(global-set-key "\M-g" 'goto-line)

;; death to tabs!!!
(setq-default indent-tabs-mode nil)

;; pull in special modes
(add-to-list 'load-path "~/.emacs.d/elisp/")

(require 'ottmode)

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

;; this is usually only loaded when you open a .py file, but we want python-mode
;; for looking at various other python-syntax configuration files
;;(load-file "/usr/share/emacs/site-lisp/python-mode.el")

;; OCaml editing sugar
;; (setq auto-mode-alist
;;       (cons '("\\.ml[iylp]?$" . caml-mode) auto-mode-alist))
;; (autoload 'caml-mode "caml" "Major mode for editing Caml code." t)
;; (autoload 'run-caml "inf-caml" "Run an inferior Caml process." t)
;; (if window-system (require 'caml-font))

(defun insert-current-time-string ()
  "Insert the current time at point"
  (interactive)
  (insert (current-time-string)))

;;; http://www.emacswiki.org/emacs/UnfillParagraph
;;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph
(defun unfill-paragraph ()
      "Takes a multi-line paragraph and makes it into a single line of text."
      (interactive)
      (let ((fill-column (point-max)))
        (fill-paragraph nil)))

;; get auto-save files into a centralized directory
(setq make-backup-files t)
(setq
   backup-by-copying t               ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.emacs_backups"))    ; don't litter my fs tree
   auto-save-file-name-transforms
    '((".*" "~/.emacs_backups" t))
   delete-old-versions t
   kept-new-versions 3
   kept-old-versions 3
   version-control t)                ; use versioned backups

(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(column-number-mode t)
 '(delete-selection-mode nil nil (delsel))
 '(fill-column 80)
 '(menu-bar-mode t)
 '(scroll-bar-mode (quote right))
 '(tool-bar-mode nil nil (tool-bar)))
