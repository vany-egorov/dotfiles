(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(load-theme 'twilight t)
(require 'helm-config)
(helm-mode 1)

(setq-default cursor-type 'bar)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(set-default-font "Consolas Bold 12")

(add-to-list 'load-path (concat (getenv "GOPATH")  "/src/github.com/golang/lint/misc/emacs"))
(require 'golint)

(setq default-directory "D:/vm/debian")
(cd "D:/vm/debian")
(drag-stuff-global-mode t)
(global-vim-empty-lines-mode)
(require 'powerline)
(powerline-default-theme)
(neotree)

(require 'linum)
;;(line-number-mode t)
;;(linum-mode t)
(setq linum-format " %d ")

(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(global-set-key [f8] 'neotree-toggle)
(setq neo-vc-integration nil)

(yas-global-mode 1)

(require 'projectile)
(projectile-global-mode)
(setq projectile-indexing-method 'alien)
(setq projectile-enable-caching t)
(setq projectile-switch-project-action 'neotree-projectile-action)

(defun my-go-mode-hook ()
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (local-set-key (kbd "M-.") 'godef-jump))
(add-hook 'go-mode-hook 'my-go-mode-hook)
(add-hook 'go-mode-hook 'linum-on)
;;(add-hook 'go-mode-hook 'company-mode)
;;(add-hook 'go-mode-hook (lambda ()
;;  (set (make-local-variable 'company-backends) '(company-go))
;;  (company-mode)))
(add-hook 'after-init-hook #'global-flycheck-mode)

(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("51e228ffd6c4fff9b5168b31d5927c27734e82ec61f414970fc6bcce23bc140d" default)))
 '(package-selected-packages
   (quote
    (yaml-mode multiple-cursors undo-tree go-autocomplete go-complete auto-complete helm-flycheck flycheck yasnippet powerline powershell vim-empty-lines-mode helm drag-stuff company-go editorconfig projectile twilight-theme neotree go-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
