;; Adapted from http://www.holgerschurig.de/en/emacs-efficiently-untangling-elisp/
;; and https://github.com/abrochard/emacs-config

(setq config-files '("config.org"))
(setq disable-section-keyword "DISABLED")
(setq config-dir "~/.emacs.d/")

;; Startup metrics
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs started up in %s."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time))))))

(defun init-tangle-section-canceled ()
  "Return t if the current section header was CANCELED, else nil."
  (save-excursion
    (if (re-search-backward "^\\*+\\s-+\\(.*?\\)?\\s-*$" nil t)
        (string-prefix-p disable-section-keyword (match-string 1))
      nil)))

(defun init-tangle-config-org (orgfile elfile)
  "This function will write all source blocks from an org file into a el file that are
  - not marked as :tangle no
  - have a source-code of =emacs-lisp="
  (let* ((body-list ())
         (gc-cons-threshold most-positive-fixnum)
         (org-babel-src-block-regexp   (concat
                                        ;; (1) indentation                 (2) lang
                                        "^\\([ \t]*\\)#\\+begin_src[ \t]+\\([^ \f\t\n\r\v]+\\)[ \t]*"
                                        ;; (3) switches
                                        "\\([^\":\n]*\"[^\"\n*]*\"[^\":\n]*\\|[^\":\n]*\\)"
                                        ;; (4) header arguments
                                        "\\([^\n]*\\)\n"
                                        ;; (5) body
                                        "\\([^\000]*?\n\\)??[ \t]*#\\+end_src")))
    (with-temp-buffer
      (insert-file-contents orgfile)
      (goto-char (point-min))
      (while (re-search-forward org-babel-src-block-regexp nil t)
        (let ((lang (match-string 2))
              (args (match-string 4))
              (body (match-string 5))
	      (canc (init-tangle-section-canceled)))
          (when (and (string= lang "emacs-lisp")
                     (not (string-match-p ":tangle\\s-+no" args))
		     (not canc))
            (add-to-list 'body-list body)))))
    (with-temp-file elfile
      (insert (format ";; Don't edit this file, edit %s instead ...\n\n" orgfile))
      (apply 'insert (reverse body-list)))
    (message "Wrote %s ..." elfile)))

(dolist (file config-files)
  (let ((orgfile (concat config-dir file))
        (elfile (concat config-dir (replace-regexp-in-string ".org" ".el" file))))
    (when (or (not (file-exists-p elfile)) (file-newer-than-file-p orgfile elfile))
      (init-tangle-config-org orgfile elfile))
    (load-file elfile)))



;; Do not touch below here!
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d83e34e28680f2ed99fe50fea79f441ca3fddd90167a72b796455e791c90dc49" "4feee83c4fbbe8b827650d0f9af4ba7da903a5d117d849a3ccee88262805f40d" "100eeb65d336e3d8f419c0f09170f9fd30f688849c5e60a801a1e6addd8216cb" default)))
 '(display-line-numbers-type (quote relative))
 '(flycheck-disabled-checkers (quote (emacs-lisp-checkdoc emacs-lisp)))
 '(package-selected-packages
   (quote
    (bazel-mode elpy diff-hl company-jedi yasnippet hydra which-key use-package toml-mode smartparens rainbow-delimiters racer org-bullets move-text general flycheck-rust flycheck-inline evil-org evil-numbers evil-nerd-commenter evil-magit dracula-theme diminish counsel-projectile company cargo auctex)))
 '(safe-local-variable-values
   (quote
    ((company-clang-arguments "-I/home/will/git/telegraph/bazel-telegraph/external/json/include/" "-I/home/will/git/telegraph/bazel-telegraph/external/hocon/include/" "-I/home/will/git/telegraph/bazel-telegraph/external/com_google_grpc_grpc/include/")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
