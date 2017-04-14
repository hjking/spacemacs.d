;;; packages.el --- hjking-misc layer packages file for Spacemacs.
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
;; added to `hjking-misc-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `hjking-misc/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `hjking-misc/pre-init-PACKAGE' and/or
;;   `hjking-misc/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst hjking-misc-packages
  '(
    ;; projectile
    visual-regexp
    ace-window
    avy
    ;; hydra
    ;; ranger
    wttrin
    multiple-cursors
    buffer-move
    uniquify
    expand-region
    miniedit
    )
  "The list of Lisp packages required by the hjking-misc layer.

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

(defun hjking-misc/post-init-avy ()
  (use-package avy
    :commands (avy-goto-word-or-subword-1
               avy-goto-word-0
               avy-goto-word-1
               avy-goto-char
               avy-goto-char-2
               avy-goto-line)
    :bind (("M-s"   . avy-goto-word-1)
           ("M-g f" . avy-goto-line))
    :init (progn
           (setq avy-background t)
           (setq avy-style 'at-full)
           (setq avy-all-windows nil))))


;; weather
(defun hjking-misc/init-wttrin ()
  (use-package wttrin
    :commands (wttrin)
    :init
    (setq wttrin-default-cities '("Wuhan"
                                  "Beijing"
                                  "Shanghai"
                                 ))))


(defun hjking-misc/post-init-multiple-cursors ()
  (use-package multiple-cursors
    :bind (("C->"         . mc/mark-next-like-this)
           ("C-<"         . mc/mark-previous-like-this)
           ("C-c C-<"     . mc/mark-all-like-this)
           ("C-S-c C-S-c" . mc/edit-lines))))


(defun hjking-misc/post-init-ace-window ()
  (use-package ace-window
    :init
    (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
    ;; Autoload
    :commands (ace-window)
    :bind (("C-x o" . ace-window))
    :config
    (ace-window-display-mode 1)))


(defun hjking-misc/init-visual-regexp ()
  (use-package visual-regexp
    :commands (vr/replace
               vr/query-replace)
    :init
    (progn
     ; (bind-key  "r"  'vr/replace hjking-mode-map) ;; C-x m r
     ; (bind-key  "q"  'vr/query-replace hjking-mode-map) ;; C-x m q
     (setq vr/default-feedback-limit 300)
     )))


;; buffer-move.el
;; Swap buffers without typing C-x b on each window
(defun hjking-misc/init-buffer-move ()
  (use-package buffer-move
    :defer t
    :bind
    (("C-c C-b C-k" .  buf-move-up)
     ("C-c C-b C-j" .  buf-move-down)
     ("C-c C-b C-h" .  buf-move-left)
     ("C-c C-b C-l" .  buf-move-right))
    ))


; (defun hjking-misc/post-init-projectile ()
;   (use-package projectile
;     :diminish projectile-mode
;     :bind (("C-c p f" . projectile-find-file)
;            ("C-c p d" . projectile-find-dir)
;            ("C-c p g" . projectile-grep)
;            ("C-c p p" . projectile-find-file))
;     :commands (projectile-global-mode
;                projectile-ack
;                projectile-ag
;                projectile-compile-project
;                projectile-dired
;                projectile-grep
;                projectile-find-dir
;                projectile-find-file
;                projectile-find-tag
;                projectile-find-test-file
;                projectile-invalidate-cache
;                projectile-kill-buffers
;                projectile-multi-occur
;                projectile-project-root
;                projectile-recentf
;                projectile-regenerate-tags
;                projectile-replace
;                projectile-run-async-shell-command-in-root
;                projectile-run-shell-command-in-root
;                projectile-switch-project
;                projectile-switch-to-buffer
;                projectile-vc)
;     :init
;     (progn
;       ; (projectile-global-mode 1)
;       (setq projectile-keymap-prefix (kbd "C-c p"))
;       ; (setq projectile-completion-system 'default) ; ido/grizzl/ido-flx
;       ;; with helm
;       ; (setq projectile-completion-system 'helm)
;       (with-eval-after-load 'ivy
;           (setq projectile-completion-system 'ivy))
;       (setq projectile-enable-caching t)
;       ; (when win32p
;       ;     ;; enable external indexing
;       ;     (setq projectile-indexing-method 'alien))
;       ;; (setq projectile-cache-file (concat my-cache-dir "projectile.cache"))
;       ;; (setq projectile-known-projects-file (concat my-cache-dir "projectile-bookmarks.eld"))
;       ;; restore the recent window configuration of the target project
;       (setq projectile-remember-window-configs t)
;       ;; Action after running projectile-switch-project (C-c p s)
;       ;; default: projectile-find-file
;       ;; once selected the project, the top-level directory of the project is opened in a dired buffer
;       (setq projectile-switch-project-action 'projectile-dired)
;       ;; same as projectile-find-file but with more features
;       ; (setq projectile-switch-project-action 'helm-projectile-find-file)
;       (setq projectile-switch-project-action 'helm-projectile)
;       ;; projectile-find-dir : remain in Projectile's completion system to select a sub-directory of your project,
;       ;; and then that sub-directory is opened for you in a dired buffer
;       ;; probably also want to set
;       ;; (setq projectile-find-dir-includes-top-level t)
;       ; (defconst projectile-mode-line-lighter " P")
;       (setq projectile-enable-idle-timer t)
;       )
;     :config
;     (progn
;       ;; Don't consider my home dir as a project
;       (add-to-list 'projectile-ignored-projects `,(concat (getenv "HOME") "/"))
;       (dolist (item '(".SOS" "nobackup"))
;         (add-to-list 'projectile-globally-ignored-directories item))
;       (dolist (item '("GTAGS" "GRTAGS" "GPATH"))
;         (add-to-list 'projectile-globally-ignored-files item))
;       (projectile-global-mode)
;       ;; integrate perspective with projectile
;       ; (use-package perspective
;       ;   :config
;       ;    (persp-mode))

;       ; (use-package persp-projectile
;       ;   :config
;       ;    (define-key projectile-mode-map (kbd "s-s") 'projectile-persp-switch-project))

;       ; (with-eval-after-load 'helm
;       ;   (use-package helm-projectile
;       ;     :disabled t
;       ;     :commands (helm-projectile-switch-to-buffer
;       ;                helm-projectile-find-dir
;       ;                helm-projectile-dired-find-dir
;       ;                helm-projectile-recentf
;       ;                helm-projectile-find-file
;       ;                helm-projectile-grep
;       ;                helm-projectile
;       ;                helm-projectile-switch-project)
;       ;     :init (progn
;       ;       (setq projectile-switch-project-action 'helm-projectile))
;       ;     :config (progn
;       ;       (helm-projectile-on))))
;   )))


(defun hjking-misc/post-init-uniquify ()
  (use-package uniquify
    :init
      ;; if open a same name buffer, then forward to same name buffer
      (setq uniquify-buffer-name-style 'post-forward)
      (setq uniquify-separator ":")
      (setq uniquify-after-kill-buffer-p t)    ; rename after killing uniquified
      (setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers
      (setq uniquify-non-file-buffer-names t))
  )


(defun hjking-misc/post-init-expand-region ()
  (use-package expand-region
    :bind ("C-=" . er/expand-region)
    :commands (er/expand-region)
    :config
    (progn
      (setq expand-region-contract-fast-key "|")
      (setq expand-region-reset-fast-key "<ESC><ESC>"))
    ))


(defun hjking-misc/init-miniedit ()
  (use-package miniedit
    :commands minibuffer-edit
    :init
     (miniedit-install))
  )

;;; packages.el ends here
