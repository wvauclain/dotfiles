;;; package --- My emacs config
;;; Commentary:
;;; "Emacs is a great operating system, lacking only a decent editor"

;;; Code:


;; Configuration
(setq delete-old-versions -1 )          ; delete excess backup versions silently
(setq version-control t )               ; use version control
(setq vc-make-backup-files t )          ; make backups file even when in version controlled dir
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")) ) ; which directory to put backups file
(setq vc-follow-symlinks t )                                   ; don't ask for confirmation when opening symlinked file
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)) ) ;transform backups file name
(setq inhibit-startup-screen t )        ; inhibit useless and old-school startup screen
(setq ring-bell-function 'ignore )      ; silent bell when you make a mistake
(setq coding-system-for-read 'utf-8 )   ; use utf-8 by default
(setq coding-system-for-write 'utf-8 )
(setq sentence-end-double-space nil)    ; sentence SHOULD end with only a point.
(setq initial-scratch-message "Welcome in Emacs") ; print a default message in the empty scratch buffer opened at startup

;; Enable relative line numbers
(global-display-line-numbers-mode)
(customize-set-variable 'display-line-numbers-type 'relative)

(require 'package)

(setq package-enable-at-startup nil) ; tells emacs not to load any packages before starting up
;; the following lines tell emacs where on the internet to look up
;; for new packages.
(setq package-archives '(("org"       . "http://orgmode.org/elpa/")
                         ("gnu"       . "http://elpa.gnu.org/packages/")
                         ("melpa"     . "https://melpa.org/packages/")))
(package-initialize) ; guess what this one does ?

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package) ; unless it is already installed
  (package-refresh-contents) ; updage packages archive
  (package-install 'use-package)) ; and install the most recent version of use-package
(require 'use-package) ; guess what this one does too ?

;; General packages
(use-package diminish :ensure t)
(diminish 'eldoc-mode)

(use-package evil :ensure t
  :config (evil-mode)
  (diminish 'undo-tree-mode))
(use-package evil-numbers :ensure t :defer t
  :config
  (define-key evil-normal-state-map (kbd "C-c +") 'evil-numbers/inc-at-pt)
  (define-key evil-normal-state-map (kbd "C-c -") 'evil-numbers/dec-at-pt))
(use-package evil-nerd-commenter :ensure t :defer t
  :commands (evilnc-comment-operator))

(use-package ivy :ensure t :defer t
  :bind (:map ivy-minibuffer-map        ; bind in the ivy buffer
              ("RET" . ivy-alt-done)
              ("C-0"   . ivy-beginning-of-buffer)
              ("C-e"   . ivy-end-of-buffer)
              ("C-k"   . ivy-previous-line)
              ("C-j"   . ivy-next-line)))
(use-package counsel :ensure t :defer t)
(use-package swiper :ensure t :defer t)

(use-package company :ensure t
  :diminish company-mode
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-idle-delay 0
        company-minimum-prefix-length 1
        company-require-match nil))

(use-package projectile :ensure t :defer t)
(use-package counsel-projectile :ensure t
  :config
  (counsel-projectile-mode))

(use-package smartparens :ensure t :defer t
  :diminish smartparens-mode
  :config
  (require 'smartparens-config))
(add-hook 'prog-mode-hook 'smartparens-mode)
(use-package rainbow-delimiters :ensure t :defer t)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(use-package which-key :ensure t
  :diminish which-key-mode
  :config
  (which-key-mode)
  (which-key-setup-side-window-bottom)
  (setq which-key-sort-order 'which-key-prefix-then-key-order ;; simple then alphabetic order.
        which-key-popup-type 'side-window
        which-key-side-window-max-height 0.3
        which-key-side-window-max-width 0.5
        which-key-idle-delay 0.3
        which-key-min-display-lines 7))

(use-package general :ensure t)

(use-package flycheck :ensure t :defer t
  :init
  (add-hook 'prog-mode-hook 'flycheck-mode))
(use-package flycheck-inline :ensure t :defer t
  :init
  (with-eval-after-load 'flycheck
    (add-hook 'flycheck-mode-hook #'flycheck-inline-mode)))

(use-package magit :ensure t :defer t)
(use-package evil-magit :ensure t)
(use-package move-text :ensure t :defer t)

;; Utility functions
(defun switch-to-other-buffer ()
  "Switch to the other buffer relative to the current buffer."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) t)))

(defun toggle-relative-line-numbers ()
  "Toggle between relative and absolute line numbers."
  (interactive)
  (if (eq display-line-numbers 'relative)
      (progn (setq display-line-numbers t)
             (message "Absolute line numbers."))
    (progn (setq display-line-numbers 'relative)
           (message "Relative line numbers."))))

(defun open-init-el ()
  "Open init.el."
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun iwb ()
  "Indent whole buffer."
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max))
  (message "Indented whole buffer."))

(defun reload-init-el ()
  "Reload init.el."
  (interactive)
  (load-file "~/.emacs.d/init.el")
  (message "Reloaded init.el."))

(defun evil-insert-space-above (count)
  "Insert COUNT spaces above current line."
  (interactive "p")
  (save-excursion (end-of-line 0) (newline count)))

(defun evil-insert-space-below (count)
  "Insert COUNT spaces below current line."
  (interactive "p")
  (save-excursion (end-of-line) (newline count)))

;; Keymaps
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(general-define-key
 :states '(normal visual insert emacs)
 :prefix "SPC"
 :non-normal-prefix "M-SPC"
 :keymaps 'override

 ;; Simple Commands
 "/"   'counsel-ag
 "TAB" '(switch-to-other-buffer :which-key "prev buffer")
 "SPC" '(counsel-M-x :which-key "execute command")
 "e" 'eval-last-sexp
 "=" '(iwb :which-key "indent buffer")
 ";" '(evilnc-comment-operator :which-key "comment operator")

 ;; Applications
 "a" '(:ignore t :which-key "Applications")
 "ar" 'ranger
 "ad" 'dired

 ;; Buffers
 "b" '(:ignore t :which-key "Buffers")
 "bd" 'evil-delete-buffer
 "bb" 'ivy-switch-buffer

 ;; Files
 "f" '(:ignore t :which-key "Files")
 "ff" 'counsel-find-file
 "fc" 'open-init-el
 "fr" 'reload-init-el

 ;; Git
 "g" '(:ignore t :which-key "Git")
 "gs" '(magit-status :which-key "status")

 ;; Help
 "h" '(:ignore t :which-key "Help")
 "hk" 'describe-key
 "hf" 'describe-function
 "hv" 'describe-variable

 ;; Projectile
 "p" '(:ignore t :which-key "Project")
 "pf" '(counsel-projectile-find-file :which-key "find file")
 "p/" '(counsel-projectile-ag :which-key "ag")
 "pp" '(counsel-projectile-switch-project :which-key "switch project")

 ;; Toggles
 "t" '(:ignore t :which-key "Toggles")
 "tn" '(toggle-relative-line-numbers :which-key "line number format")

 ;; Windows
 "w" '(:ignore t :which-key "Windows")
 "w/" 'evil-window-vsplit
 "w-" 'evil-window-split
 "wd" 'evil-window-delete
 "wj" 'evil-window-down
 "wk" 'evil-window-up
 "wh" 'evil-window-left
 "wl" 'evil-window-right
 "wD" 'delete-other-windows

 ;; Quit
 "q" '(:ignore t :which-key "Quit")
 "qq" 'save-buffers-kill-terminal
 "qQ" 'save-buffers-kill-emacs
 )

(general-define-key
 :states '(normal)
 "[ SPC" 'evil-insert-space-above
 "] SPC" 'evil-insert-space-below
 "[e" 'move-text-up
 "]e" 'move-text-down)

(general-create-definer local-leader-def
  :prefix ","
  :non-normal-prefix "C-,")

(local-leader-def
  :states '(normal visual insert emacs)
  :keymaps 'override

  ;; Flycheck
  "f" '(:ignore t :which-key "Flycheck")
  "fn" '(flycheck-next-error :which-key "next error")
  "fp" '(flycheck-previous-error :which-key "previous error")
  "fl" '(flycheck-list-errors :which-key "list errors")
  )

;; Appearance
(use-package dracula-theme :ensure t)
(set-frame-font "Iosevka-12" nil t)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;; Language-specific packages
;; LaTeX
;; (use-package tex
;;   :ensure auctex
;;   :mode ("\\.tex\\'" . LaTeX-mode)
;;   :config
;;   (setq TeX-auto-save t)
;;   (setq TeX-parse-self t)
;;   (setq-default TeX-master nil)
;;   (setq LaTeX-indent-level 4)
;;   (add-hook 'LaTeX-mode-hook 'visual-line-mode)
;;   (add-hook 'LaTeX-mode-hook 'flyspell-mode)
;;   (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
;;   (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;;   )

;; (use-package preview :ensure auctex
;;   :init
;;   (use-package font-latex :ensure auctex)
;;   :config
;;   (set-default 'preview-scale-function 1.7)
;;   (set-default 'preview-default-option-list
;;                '("displaymath" "floats" "textmath")))

;; (use-package company-math
;;   :ensure t
;;   :config
;;   (add-hook 'LaTeX-mode-hook (lambda ()
;;                                (add-to-list 'company-backends 'company-math-symbols-latex)
;;                                (add-to-list 'company-backends 'company-latex-commands))))

;; Rust
(use-package rust-mode
  :defer t
  :ensure t
  :init
  (local-leader-def
    :states '(normal visual insert emacs)
    :keymaps 'rust-mode-map
    "=" 'rust-format-buffer))

(use-package toml-mode
  :ensure t
  :defer t
  :mode "/\\(Cargo.lock\\|\\.cargo/config\\)\\'")

(use-package racer
  :defer t
  :ensure t
  :init
  (add-hook 'rust-mode-hook 'racer-mode)
  (local-leader-def
    :states '(normal visual insert emacs)
    :keymaps 'rust-mode-map
    "h" 'racer-describe))

(use-package cargo
  :defer t
  :ensure t
  :init
  (add-hook 'rust-mode-hook 'cargo-minor-mode)
  (local-leader-def
    :states '(normal visual insert emacs)
    :keymaps 'rust-mode-map
    "c" '(:ignore t :which-key "Cargo")
    "cb" '(cargo-process-build :which-key "build")
    "cr" '(cargo-process-run :which-key "run")
    "ct" '(cargo-process-test :which-key "test")
    "cC" '(cargo-process-clean :which-key "clean")
    "cc" '(cargo-process-clippy :which-key "clippy")))

(use-package flycheck-rust
  :defer t
  :ensure t
  :init
  (with-eval-after-load 'rust-mode
    (add-hook 'rust-mode-hook #'flycheck-rust-setup)))

;; Org
(use-package org
  :defer t
  :ensure t)

(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode))

(use-package org-bullets
  :defer t
  :ensure t
  :init
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; Emacs lisp
(use-package auto-compile
  :defer t
  :ensure t
  :init
  (add-hook 'emacs-lisp-mode-hook 'auto-compile-on-save-mode))

;; Custom (DO NOT TOUCH BELOW HERE)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (auto-compile evil-org org-bullets org-evil toml-mode move-text evil-magit magit counsel-projectile flycheck-rust flycheck-inline flycheck cargo racer preview-latex font-latex latex-unicode-math-mode tex auctex projectile evil-nerd-commenter evil-numbers dracula-theme rainbow-delimiters rainbow-delimeters diminish smartparens smartparents helm company company-mode evil linum-relative counsel ivy which-key avy general use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((((min-colors 16777216)) (:background "#282a36" :foreground "#f8f8f2")) (t (:background "#000000" :foreground "#f8f8f2")))))

(provide 'init)
;;; init.el ends here
