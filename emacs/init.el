;; setting custom-file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; melpa packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; overall view
(menu-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode 0)
(setq display-time-24hr-format t)
(setq display-time-default-load-average nil)
(display-time-mode 1)
(setq inhibit-startup-screen t)
(scroll-bar-mode -1)
;; (load-theme 'solarized-light t)

;; backup directory
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq auto-save-file-name-transforms
      `((".*" ,"~/.emacs.d/backups" t)))

;; ctrl+backspace issue
(defun backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument ARG, do this that many times."
 (interactive "p")
  (delete-region (point) (progn (backward-word arg) (point))))
(global-set-key (kbd "C-<backspace>") 'backward-delete-word)

;; cyrillic shortcuts
(defun cfg:reverse-input-method (input-method)
  "Build the reverse mapping of single letters from INPUT-METHOD."
  (interactive
   (list (read-input-method-name "Use input method (default current): ")))
  (if (and input-method (symbolp input-method))
      (setq input-method (symbol-name input-method)))
  (let ((current current-input-method)
        (modifiers '(nil (control) (meta) (control meta))))
    (when input-method
      (activate-input-method input-method))
    (when (and current-input-method quail-keyboard-layout)
      (dolist (map (cdr (quail-map)))
        (let* ((to (car map))
               (from (quail-get-translation
                      (cadr map) (char-to-string to) 1)))
          (when (and (characterp from) (characterp to))
            (dolist (mod modifiers)
              (define-key local-function-key-map
                (vector (append mod (list from)))
                (vector (append mod (list to)))))))))
    (when input-method
      (activate-input-method current))))
(cfg:reverse-input-method 'russian-computer)

;; writing commodity
(global-visual-line-mode 1)
(global-set-key (kbd "C-z") 'undo)
(set-fringe-mode 0)

;; olivetti and wc
(add-hook 'text-mode-hook 'olivetti-mode)
(add-hook 'text-mode-hook 'wc-mode)
(add-hook 'org-mode-hook 'flyspell-mode)
(add-hook 'org-mode-hook 'org-indent-mode)
(add-hook 'org-mode-hook 'turn-on-typopunct-mode)
(setq olivetti-body-width 100)
(setq org-indent-indentation-per-level 1)
(setq org-adapt-indentation nil)
(setq org-hide-emphasis-markers t)

;; spellchecker
(with-eval-after-load "ispell"
  (setq ispell-program-name "hunspell")
  (setq ispell-dictionary "en_US,ru_RU")
  ;; ispell-set-spellchecker-params has to be called
  ;; before ispell-hunspell-add-multi-dic will work
  (ispell-set-spellchecker-params)
  (ispell-hunspell-add-multi-dic "en_US,ru_RU"))

;; some org stuff
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(setq org-latex-inputenc-alist '(("utf8" . "utf8x")))

;; typography (quotation marks and dashes)
(add-to-list 'load-path "~/.emacs.d/lisp/")
(load "typopunct.el")

;; russian typography
(require 'typopunct)
(setq-default typopunct-buffer-language 'russian)
(defun turn-on-typopunct-mode ()
  (typopunct-mode t))

(global-set-key (kbd "C-(") 
            (lambda () 
              (interactive) 
              (typopunct-change-language "english" nil)))

(global-set-key (kbd "C-)") 
            (lambda () 
              (interactive) 
              (typopunct-change-language "russian" nil)))

;; recent files
;; (recentf-mode 1)
;; (setq recentf-max-menu-items 25)
;; (global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; open pdfs in zathura and others
(require 'openwith)
(openwith-mode t)

;; roam
(use-package org-roam
      :hook
      (after-init . org-roam-mode)
      :custom
      (org-roam-directory "~/Dropbox/roam/")
      (org-roam-dailies-directory "daily")
      :bind (:map org-roam-mode-map
              (("C-c n l" . org-roam)
               ("C-c n f" . org-roam-find-file)
               ("C-c n b" . org-roam-buffer-toggle-display)
               ;; ("C-c n g" . org-roam-graph)
	       ("C-c n t" . org-roam-dailies-find-today))
              :map org-mode-map
              (("C-c n i" . org-roam-insert))))

(setq org-roam-graph-viewer "/usr/bin/gwenview")
(setq org-roam-db-update-method 'immediate)

(use-package org-randomnote
  :ensure t
  :bind ("C-c r" . org-randomnote))

(load-library "find-lisp")
(setq org-randomnote-candidates
      (find-lisp-find-files "~/Dropbox/roam/" "\.org$"))

;; deft
(setq deft-auto-save-interval nil)
(use-package deft
  :after org
  :bind
  ("C-c n d" . deft)
  :custom
  (deft-recursive t)
  (deft-use-filter-string-for-filename t)
  (deft-default-extension "org")
  (deft-directory "~/Dropbox/roam"))

(with-eval-after-load 'ox
  (require 'ox-hugo))

;; resolve the problem with xdg-open not opening files
(setq process-connection-type nil)
