(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (solarized-light)))
 '(custom-safe-themes
   (quote
    ("00445e6f15d31e9afaa23ed0d765850e9cd5e929be5e8e63b114a3346236c44c" "c433c87bd4b64b8ba9890e8ed64597ea0f8eb0396f4c9a9e01bd20a04d15d358" default)))
 '(helm-display-header-line nil)
 '(openwith-associations
   (quote
    (("\\.djvu\\'" "zathura"
      (file))
     ("\\.pdf\\'" "zathura"
      (file))
     ("\\.\\(?:jp?g\\|png\\)\\'" "gwenview"
      (file))
     ("\\.doc\\'" "lowriter"
      (file))
     ("\\.docx\\'" "lowriter"
      (file)))))
 '(org-roam-completion-system (quote ivy))
 '(org-roam-directory "~/Dropbox/roam/")
 '(package-selected-packages
   (quote
    (helm ivy deft use-package org-roam solarized-theme org-bullets flyspell-correct olivetti wc-mode openwith))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#ffffff" :foreground "#444444" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 115 :width normal :foundry "PfEd" :family "DejaVu Sans Mono"))))
 '(org-roam-link ((t (:foreground "#37C8AE")))))
