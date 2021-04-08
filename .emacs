;; /Applications/Emacs.app/Contents/MacOS/Emacs --daemon   ## start emacs in daemon mode...then emacsclient loads faster
(setq inhibit-startup-screen t)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; Initialize package sources
(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(require 'package)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

  ;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)




(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar

;; Set up the visible bell
(setq visible-bell t)

(column-number-mode)
;;(global-display-line-numbers-mode t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))




(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))


(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         ("s-7" . swiper-mc)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :init
  (setq ivy--display-transformers-list nil)
  (ivy-rich-mode 1))

(use-package counsel
  :config
  (counsel-mode 1)
  :bind (
         ("M-x" . 'counsel-M-x)
         ("C-M-j" . 'counsel-switch-buffer)
         )
  :bind (
         :map minibuffer-local-map
              ("C-r" . 'counsel-minibuffer-history)
         )
  :custom
  (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
  )


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-ispell-fuzzy-limit 4)
 '(ac-ispell-requires 4)
 '(elfeed-feeds
   '("https://davedelong.com/feed.xml" "https://engineering.fb.com/feed/"
     ("https://jvns.ca/atom.xml" basics career)
     ("http://blog.acolyer.org/feed/" cs research)
     ("https://haskellweekly.news/newsletter.atom" haskell cs)
     ("https://opensource.com/feed" opensource cs)))
 '(package-selected-packages
   '(multiple-cursors spacemacs-theme real-auto-save counsel-projectile projectile company-jedi multi-term persp-mode perspective elfeed hide-mode-line sublime-themes pomidor eyebrowse neuron-mode haskell-snippets shm auto-correct ace-window hasklig-mode hc-zenburn-theme haskell-emacs haskell-mode company-irony irony gnu-elpa-keyring-update magit yaml-mode easy-jekyll scheme-complete swift-mode paced realgud json-mode flymd markdown-mode+ vlf helm)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:background "#444444" :foreground "#f6f3e8" :height 0.75)))))


(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))






;; lsp mode

(defun efs/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))


;; language server protocol
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . efs/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(use-package lsp-treemacs
  :after lsp)

(use-package lsp-ivy)



;; python config
(setq python-python-command "~/.pyenv/versions/3.8.0/bin/python")
(setq python-shell-interpreter "~/.pyenv/versions/3.8.0/bin/python")


(use-package python-mode
  :hook (python-mode . lsp-deferred)
  :custom
  ;; NOTE: Set these if Python 3 is called "python3" on your system!
   (python-shell-interpreter "~/.pyenv/versions/3.8.0/bin/python")
   )

(setq lsp-pyls-server-command "/Users/sudeepkumar/.local/bin/pyls")




(setq exec-path (append exec-path '("/usr/local/bin")))
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin:/Users/sudeepkumar/.ghcup/bin/"))
(setq exec-path (append exec-path '("/Users/sudeepkumar/.ghcup/bin/")))


;; cask load everything.
(let ((default-directory  "~/.emacs.d/.cask/"))
  (normal-top-level-add-subdirs-to-load-path))
(setq-default word-wrap t)

;;perspective


(load-file "~/.emacs.d/perspective.el")
(use-package persp-mode
  :bind
  (("C-x b" . persp-counsel-switch-buffer))
  (("C-x x C-s" . persp-state-save-custom))
  :config
  (persp-mode))

(setq persp-state-default-file "~/.emacs.d/perspective-data")
(add-hook 'emacs-startup-hook
          (lambda ()
            "loading state file"
            (persp-state-load persp-state-default-file)))
(add-hook 'kill-emacs-hook #'persp-state-save) ;; this usually causes problem when you're testing emacs (closing or opening frequently)
(add-hook 'emacs-startup-hook #'server-start)


;; looks
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;;(load-theme 'granger t)
;;(load-theme 'deeper-blue)
(load-theme 'wombat)
(add-to-list 'default-frame-alist '(height . 50))
(add-to-list 'default-frame-alist '(width . 160))
;;(add-to-list 'load-path "~/.emacs.d/emacs-vim-modeline")
(load "~/.emacs.d/smooth-scroll")
(require 'smooth-scroll)
(smooth-scroll-mode t)
(scroll-bar-mode -1)
(set-fringe-mode '(1 . 1))

(load "~/.emacs.d/ssh.el")
(setq package-check-signature nil)

(add-to-list 'load-path "~/.emacs.d/elpa/realgud-1.4.5/")
(load-library "realgud")
;;TODO: control-option-command-v scroll-other-window -> no shortcut for scrolling down
(global-set-key (kbd "C-S-v") 'smooth-scroll/scroll-other-window)


;; haskell setup
(add-to-list 'load-path "~/.emacs.d/haskell-mode/")
(require 'haskell-mode-autoloads)
(add-to-list 'Info-default-directory-list "~/.emacs.d/haskell-mode/")
(require 'haskell)
(defun my-haskell-mode-hook ()
   (haskell-indentation-mode -1) ;; turn off, just to be sure
   (haskell-indent-mode 1)       ;; turn on indent-mode

   ;; further customisations go here.  For example:
   (setq locale-coding-system 'utf-8 )
   (flyspell-prog-mode)  ;; spell-checking in comments and strings
   ;; etc.      
   )
(add-hook 'haskell-mode-hook 'my-haskell-mode-hook)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

;;(define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)

;; yasnipper
(add-to-list 'load-path
              "~/.emacs.d/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)
(add-to-list 'load-path "~/.emacs.d/snippets/haskell-snippets/")
(require 'haskell-snippets)

;; avy
(global-set-key (kbd "C-;") 'avy-goto-char)
(global-set-key (kbd "C-:") 'avy-goto-line)
(global-set-key (kbd "C-'") 'avy-goto-word-0)






;; turn off linum mode if huge file

(defun buffer-too-big-p ()
  (or (> (buffer-size) (* 5000 80))
      (> (line-number-at-pos (point-max)) 5000)))
(add-hook 'prog-mode-hook
          (lambda ()
            ;; turn off `linum-mode' when there are more than 5000 lines
            (if (buffer-too-big-p) (linum-mode -1))))
(global-linum-mode -1)

(setq visible-bell 1)



 
;indentation customization(replacing tabs by 4 spaces)
(setq-default c-basic-offset 4
                  tab-width 4
                  indent-tabs-mode t)

;Indentating the curly braces(the braces don't indent with the inner code)
 (setq c-default-style "linux"
       c-basic-offset 4)



(show-paren-mode 1) ;highlighting matching parenthses
(blink-cursor-mode 1)
(tool-bar-mode -1)
(which-function-mode)

(global-font-lock-mode 1)
(transient-mark-mode t)


(global-set-key (kbd "C-/") 'undo)


;a couple of productivity incrementers
(defalias 'rs 'replace-string)
(defalias 'qr 'query-replace)
(defalias 'rr 'replace-regexp)
(defalias 'yes-or-no-p 'y-or-n-p) ; y or n is enough
(defalias 'qrr 'query-replace-regexp)
(defalias 'g 'goto-line)
(defalias 'cr 'comment-region)
(defalias 'urr 'uncomment-region)

;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(default ((t (:inherit nil :extend nil :stipple nil :background "#242424" :foreground "#f6f3e8" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 150 :width ultra-expanded :foundry "nil" :family "Avenir Next"))))
;;  '(bold ((t (:weight extra-bold)))))

;;copy and paste -fix
(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)


;; helm config

(require 'helm-config)
(helm-mode 1)
(global-set-key (kbd "C-c C-c") 'helm-show-kill-ring)

(global-set-key (kbd "C-x C-b") 'buffer-menu-other-window)


(defun my-command-error-function (data context caller)
  "Ignore the buffer-read-only, beginning-of-buffer,
end-of-buffer signals; pass the rest to the default handler."
  (when (not (memq (car data) '(buffer-read-only
                                beginning-of-buffer
                                end-of-buffer)))
    (command-error-default-function data context caller)))

(setq command-error-function #'my-command-error-function)


(defun shell-execute ()
  "Shell execute this buffer"
  (interactive)
;;  (mark-whole-buffer)
  (shell-command-on-region (point-min) (point-max) "bash"))

(defun load-ei ()
  (interactive)
  (load-file "~/.emacs"))


(save-place-mode)

(setq create-lockfiles nil)
(setq make-backup-files nil)
(setq backup-directory-alist `(("." . "~/.saves")))
(setq auto-save-default nil) ; stop creating #autosave# files


(setq scheme-program-name
"/usr/local/bin/mit-scheme")
(require 'xscheme)

;; ITERM2 MOUSE SUPPORT
    (unless window-system
      (require 'mouse)
      (xterm-mouse-mode t)
      (defun track-mouse (e)) 
      ;(setq mouse-sel-mode t)
    )

(menu-bar-mode -1)

(setq-default indent-tabs-mode nil)
(setq tab-width 4)


(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))


(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

(add-hook 'git-commit-mode-hook 'ac-ispell-ac-setup)
(add-hook 'mail-mode-hook 'ac-ispell-ac-setup)


(setq bookmark-save-flag 1)

(defun autocompile nil
  "compile itself if ~/.emacs"
  (interactive)
  (require 'bytecomp)
  (let ((dotemacs (file-truename user-init-file)))
    (if (string= (buffer-file-name) (file-chase-links dotemacs))
      (byte-compile-file dotemacs))))

(add-hook 'after-save-hook 'autocompile)



(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)



(setq markdown-hide-urls 't)
;; darkroom
(load-file "~/.emacs.d/darkroom.el")
(defalias 'dtm 'darkroom-tentative-mode)
;;(setq darkroom-margins 0.15)
(setq darkroom-fringes-outside-margins nil)
(setq darkroom-text-scale-increase 0)

;; neuron-mode aka zettelkasten
(load "~/.emacs.d/neuron-mode.el")
(setq neuron-default-zettelkasten-directory "~/open_source/zettelkasten")
(set-face-attribute 'default nil :height 152)

(load-file "~/.emacs.d/xah-math-input.el")
(setq neuron-exclude-from-darkroom '("timelog"))
(defun neuron-hooks ()
  (setq neuron-title-format "# %s")
  (local-set-key "\C-co" 'neuron-open-daily-notes)
  (let ((filename-wextension (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))))
    (if (member filename-wextension neuron-exclude-from-darkroom) nil
      (progn
        ;;(darkroom-tentative-mode)  ;; possibly crappy emacsclient loads
        (set-fringe-mode 0)
        )))
   (flyspell-mode)
   (flyspell-buffer)
   (display-line-numbers-mode 0)
  )
 
(add-hook 'neuron-mode-hook #'neuron-hooks)
(require 'hide-mode-line)
(add-hook 'neuron-mode-hook  #'hide-mode-line-mode)
(add-hook 'emacs-startup-hook #'neuron-rib-serve)


(defun elfeed-show-hooks ()
  (darkroom-mode)
  (set-fringe-mode 0)
  (text-scale-decrease 1)
  )
(add-hook 'elfeed-show-mode-hook #'elfeed-show-hooks)

(defun my-russian-input-method ()
  (interactive)
  (set-input-method "russian-computer"))
(defun my-ucs-input-method ()
  (interactive)
  (set-input-method "ucs"))
(defalias 'rim 'my-russian-input-method)
(defalias 'uim 'my-ucs-input-method)



(autoload 'multi-term "multi-term" nil t)
(autoload 'multi-term-next "multi-term" nil t)

(setq multi-term-program "/bin/zsh") ;; or use zsh...

(global-set-key (kbd "C-c t") 'multi-term-next)
(global-set-key (kbd "C-c T") 'multi-term) ;; create a new one

(require 'rx)


(add-hook 'emacs-lisp-mode-hook '(lambda () (local-set-key (kbd "<s-mouse-1>") 'find-function-at-point)))


;; persp setup

(use-package projectile)
package-archives

(use-package counsel-projectile
  :bind (("s-o" . counsel-projectile-find-file))
  :config (counsel-projectile-mode))


;;  using it with swiper: C-s to search and then press <s-7> to enable mc
(use-package multiple-cursors)
