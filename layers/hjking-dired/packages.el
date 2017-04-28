;;; packages.el --- hjking-dired layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
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
;; added to `hjking-dired-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `hjking-dired/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `hjking-dired/pre-init-PACKAGE' and/or
;;   `hjking-dired/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst hjking-dired-packages
  '(
    (dired :location built-in)
    (dired-x :location built-in)
    dired-details
    )
  "The list of Lisp packages required by the hjking-dired layer.

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

(defun hjking-dired/post-init-dired ()
  (use-package dired
    :config
    (progn
      (put 'dired-find-alternate-file 'disabled nil)
      ;; Dired copy folders recursively without confirmation
      (setq dired-recursive-copies 'always)
      ;; Dired delete folders recursively after confirmation
      (setq dired-recursive-deletes 'top)
      ;; setting for view CVS
      (setq cvs-dired-use-hook 'always)
      ;; try to guess a default target directory
      (setq dired-dwim-target t)
      ;; do what i mean when copy file with two windows
      (setq dired-isearch-filenames t)

      ;; Sort Directories First
      ;; if it is not Windows, use the following listing switches
      (when (not (eq system-type 'windows-nt))
        (setq dired-listing-switches "-lha --group-directories-first"))

      (defun hjking-dired-mode-hook ()
        "to be run as hook for `dired-mode'."
        (dired-hide-details-mode 1)   ;; hide the file's unix owner and permission info
        (visual-line-mode 0) ;; unwrap lines.
        )
      (add-hook 'dired-mode-hook 'hjking-dired-mode-hook)

      (add-hook 'dired-mode-hook
                '(lambda()
                   ;; use the same buffer for viewing directory
                   (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
                   ;; open dir/file in other window
                                        ; (define-key dired-mode-map [return] 'dired-find-file-other-window)
                   (define-key dired-mode-map [delete] 'dired-flag-file-deletion)
                   (define-key dired-mode-map [C-down-mouse-1] 'dired-mouse-find-file-other-window)
                   (define-key dired-mode-map [mouse-2] 'dired-find-file)
                   (define-key dired-mode-map [mouse-3] 'dired-maybe-insert-subdir)
                   (define-key dired-mode-map (kbd "C-{") 'dired-narrow-window))))))


;; Load Dired X when Dired is loaded.
;; call `dired-jump [Ctrl+x Ctrl+j] to jump to the directory of current buffer
(defun hjking-dired/post-init-dired-x ()
  (use-package dired-x
    :config
    ;; Omit mode. hide uninteresting files, such as backup files
    (setq dired-omit-mode t) ; Turn on Omit mode.
    (setq-default dired-omit-files-p t) ; this is buffer-local variable
    (setq dired-omit-extensions
          '(".svn/" "CVS/" ".o" "~" ".bin" ".bak" ".obj" ".map" ".ico"
            ".pif" ".lnk" ".a" ".ln" ".blg" ".bbl" ".dll" ".drv" ".vxd"
            ".386" ".elc" ".lof" ".glo" ".idx" ".lot" ".fmt" ".tfm"
            ".class" ".lib" ".mem" ".x86f" ".sparcf" ".fasl"
            ".ufsl" ".fsl" ".dxl" ".pfsl" ".dfsl" ".lo" ".la" ".gmo"
            ".mo" ".toc" ".aux" ".cp" ".fn" ".ky" ".pg" ".tp" ".vr"
            ".cps" ".fns" ".kys" ".pgs" ".tps" ".vrs" ".pyc" ".pyo"
            ".DS_STORE" ".pdb" ".ilk"
            ))
    ;; hide my dot-files when hit M-o
    (setq dired-omit-files (concat dired-omit-files "\\|^\\..+$"))
    (setq dired-omit-size-limit 1000000)
    ))


;;; dired-details
;;   ) - dired-details-show
;;   ( - dired-details-hide
(defun hjking-dired/init-dired-details ()
  (use-package dired-details
    :init
    ;; show sym link targets
    (setq dired-details-hide-link-targets nil)
    :config
    (progn
      (dired-details-install)
      ;; both `)' and `(' to `dired-details-toggle'
      (use-package dired-details+))))


;;; packages.el ends here
