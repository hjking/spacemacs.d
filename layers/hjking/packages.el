;;; packages.el --- hjking layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author:  <hongjin@HONGJIN>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `hjking-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `hjking/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `hjking/pre-init-PACKAGE' and/or
;;   `hjking/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst hjking-packages
  '(
    (ibuffer :location built-in)
    )
  "The list of Lisp packages required by the hjking layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

; (defun finance/init-ledger-mode ()
;   (use-package ledger-mode
;     ; Use :mode to set language modes to automatically activate on certain extensions
;     :mode ("\\.\\(ledger\\|ldg\\)\\'" . ledger-mode)
;     ; :defer t activates lazy loading which makes startup faster
;     :defer t
;     ; The code in :init is always run, use it to set up config vars and key bindings
;     :init
;     (progn ; :init only takes one expression so use "progn" to combine multiple things
;       ; You can configure package variables here
;       (setq ledger-post-amount-alignment-column 62)
;       ; Using evil-leader/set-key-for-mode adds bindings under SPC for a certain mode
;       ; Use evil-leader/set-key to create global SPC bindings
;       (evil-leader/set-key-for-mode 'ledger-mode
;         "mhd"   'ledger-delete-current-transaction
;         "m RET" 'ledger-set-month))
;     :config ; :config is called after the package is actually loaded with defer
;       ; You can put stuff that relies on the package like function calls here
;       (message "Ledger mode was actually loaded!")))

(defun hjking/post-init-ibuffer ()
  (use-package ibuffer
    :init (progn
      (setq ibuffer-formats
              '((mark modified read-only
                      " "
                      (name 18 18 :left :elide)
                      " "
                      (size-h 9 -1 :right)
                      " "
                      (mode 16 16 :left :elide)
                      " "
                      ; (vc-status 16 16 :left)
                      ; " "
                      filename-and-process)
                (mark modified read-only
                      (name 45 -1 :left)
                      " "
                      filename-and-process)
                (mark modified read-only
                      filename-and-process)))
      ;; grouping
      (setq ibuffer-saved-filter-groups
            '(("default"
                ("emacs"      (name . "\\*.*\\*"))
                ("Dirs"       (mode . dired-mode))
                ("Shell"      (or (mode . term-mode)
                                  (mode . eshell-mode)
                                  (mode . shell-mode)))
                ("HDL"        (or (mode . verilog-mode)
                                  (mode . vhdl-mode)
                                  (mode . vlog-mode)))
                ("C"          (or
                               (mode . c-mode)
                               (mode . cc-mode)
                               (mode . c++-mode)))
                ("Elisp"      (or
                               (mode . emacs-lisp-mode)
                               (mode . lisp-interaction-mode)))
                ("Perl"       (mode . cperl-mode))
                ("Python"     (mode . python-mode))
                ("Org"        (or
                               (name . "^\\*Calendar\\*$")
                               (name . "^diary$")
                               (mode . org-mode)
                               (mode . org-agenda-mode)))
                ("Music"      (name . "^EMMS Music Playlist$"))
                ("Tags"       (name . "^TAGS\\(<[0-9]+>\\)?$"))
                ("IRC"        (mode . erc-mode))
                ("Markdown"
                             (or
                              (mode . markdown-mode)))
                ("Web"          (or
                               (mode . css-mode)
                               (mode . web-mode)))
                )))
    ))
  )

;;; packages.el ends here
