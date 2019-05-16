(package-initialize)

; ### additional repos
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

; ### <<< packages
(require 'cl-lib)

(defvar my-packages
  '(ack-and-a-half neotree)
  "A list of packages to ensure are installed at launch.")

(defun my-packages-installed-p ()
  (cl-loop for p in my-packages
	   when (not (package-installed-p p)) do (cl-return nil)
	   finally (cl-return t)))

(unless (my-packages-installed-p)
  ;; check for new packages (package versions)
  (package-refresh-contents)
  ;; install the missing packages
  (dolist (p my-packages)
    (when (not (package-installed-p p))
      (package-install p))))
; ### >>> packages

; ### <<< orgmode
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

(setq org-agenda-files (list "/mnt/d/vm/debian/gl-ce.int/transcoder/ctl/docs/roadmap.org"))
(setq org-log-done t)

(setq org-tags-column 120)
; ### >>> orgmode

; ### neotree
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
