;;; packages.el --- hjking-hdl layer packages file for Spacemacs.
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
;; added to `hjking-hdl-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `hjking-hdl/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `hjking-hdl/pre-init-PACKAGE' and/or
;;   `hjking-hdl/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst hjking-hdl-packages
  '(
    verilog-mode
    )
  "The list of Lisp packages required by the hjking-hdl layer.

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


(defun hjking-hdl/init-verilog-mode ()
  (use-package verilog-mode
    :mode (("\\.[st]*v[hp]*\\'" . verilog-mode) ; .v, .sv, .svh, .tv, .vp
           ("\\.psl\\'"         . verilog-mode)
           ("\\.vinc\\'"        . verilog-mode))
    :init
     (progn
      (setq verilog-indent-level             4)   ; 3
      (setq verilog-indent-level-module      4)   ; 3
      (setq verilog-indent-level-declaration 4)   ; 3
      (setq verilog-indent-level-behavioral  4)   ; 3
      (setq verilog-indent-level-directive   2)   ; 1
      (setq verilog-case-indent              4)   ; 2
      (setq verilog-auto-newline             nil) ; t
      (setq verilog-auto-indent-on-newline   t)   ; t
      (setq verilog-tab-always-indent        t)   ; t
      (setq verilog-auto-endcomments         t)   ; t
      (setq verilog-minimum-comment-distance 40)  ; 10
      (setq verilog-highlight-p1800-keywords nil)
      (setq verilog-indent-begin-after-if    t)   ; t
      ; (setq verilog-auto-lineup              nil) ; 'declarations
      (setq verilog-align-ifelse             t) ; nil
      (setq verilog-tab-to-comment           nil) ; t
      (setq verilog-date-scientific-format   t)   ; t
      ;; Personal
      (setq verilog-company     "Fiberhome Tech (Wuhan) Co.,Ltd")
      (setq verilog-linter      "vcs +v2k -R -PP -Mupdate -P /cadtools/novas/Novas-201001/share/PLI/vcsd_latest/LINUX/vcsd.tab /cadtools/novas/Novas-201001/share/PLI/vcsd_latest/LINUX/pli.a +vcsd +vcsd +incdir+.")
      (setq verilog-compiler    "vcs +v2k -R -PP -Mupdate -P /cadtools/novas/Novas-201001/share/PLI/vcsd_latest/LINUX/vcsd.tab /cadtools/novas/Novas-201001/share/PLI/vcsd_latest/LINUX/pli.a +vcsd +vcsd +incdir+.")
      (setq verilog-simulator   "vcs +v2k  -R -PP -Mupdate -P /cadtools/novas/Novas-201001/share/PLI/vcsd_latest/LINUX/vcsd.tab /cadtools/novas/Novas-201001/share/PLI/vcsd_latest/LINUX/pli.a +vcsd +vcsd +incdir+.")
      (setq verilog-tool        "vcs +v2k  -R -PP -Mupdate -P /cadtools/novas/Novas-201001/share/PLI/vcsd_latest/LINUX/vcsd.tab /cadtools/novas/Novas-201001/share/PLI/vcsd_latest/LINUX/pli.a +vcsd +vcsd +incdir+.")
      )
     :config
     (progn
      (add-hook 'verilog-mode-hook '(lambda () (font-lock-mode 1)))
      ;; Convert all tabs in region to multiple spaces
      (add-hook 'verilog-mode-hook
                '(lambda ()
                    (add-hook 'local-write-file-hooks 'hjking/cleanup-buffer-safe)))
      )))


;;; packages.el ends here
