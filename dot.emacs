;;;
;;; for emacs 19.x and 20.x
;;;
(setenv "LANG" "C")
(set-language-environment "Japanese")
(set-terminal-coding-system 'euc-japan)
(set-keyboard-coding-system 'euc-japan)
(prefer-coding-system 'euc-jp)
;(prefer-coding-system 'utf-8)
;;;(prefer-coding-system 'iso-2022-jp)
;;;(prefer-coding-system 'shift_jis)

(keyboard-translate ?\^h 'backspace)
;;;(setq normal-erase-is-backspace t)

(if window-system
    (menu-bar-mode t)
  (menu-bar-mode nil))

;;;(require 'anthy)
(setq default-input-method "japanese-egg-anthy")

;;;(require 'mozc)
;;;(setq default-input-method "japanese-mozc")

(setq menu-coding-system 'euc-jp)
;;; for input method
(global-set-key "\C-o" 'toggle-input-method)

;;; for Wnn
(setq wnn-jserver "localhost")
(setq enable-double-n-syntax t)
(setq use-kuten-for-comma t)
(setq use-touten-for-period t)

;;;
;;; for eldav
;;;
;;;(require 'eldav)
;;;(setq eldav-use-vc t)
;;;
;;; for tex-mode
;;;
(setq tex-default-mode 'latex-mode)
(setq tex-run-command "njtex")
(setq latex-run-command "njlatex")
(setq slitex-run-command "jslitex")
(setq bibtex-run-command "jbibtex")

;;; for key map

(global-set-key "\C-x\C-b" 'electric-buffer-list)
(global-set-key "\C-h" 'delete-backward-char)

(global-set-key "\M-g" 'goto-line)
(global-set-key "\M-c" 'compile)
(setq meta-flag t)

;;; for Gnus
(autoload 'gnus "gnus" "Read network news." t)
(autoload 'gnus-post-news "gnuspost" "Post a new news." t)

(setq mime-edit-split-message nil)

;;;(require 't-gnus-startup)
(global-set-key "\C-xn"  'gnus)

;;;(if (string-match "XEmacs" emacs-version)
;;;    (load "~/.xemacs/init.el")
;;;      (load-file "~/.emacs-20"))

(setq gnats:root "/usr/local/share/gnats/gnats-db")
(setq gnats:libdir "/usr/local/libexec")

;;;
;;; for pgg
;;;
(require 'pgg)
(setq pgg-scheme "gpg")
(setq pgg-gpg-use-agent nil)


;;;
;;; for Mule-UCS
;;;(require 'un-define)
;;;(require 'jisx0213)

;;;(load "mime-setup")
;;;(setq pgg-default-scheme "gpg")
;;;(setq pgg-scheme "gpg")

;;;
;;; for mailcrypt
;;;
;;;(load-library "mailcrypt")
;;;(mc-setversion "gpg")
;;;(setq mc-passwd-timeout 600)
;;;(autoload 'mc-install-write-mode "mailcrypt" nil t)
;;;(autoload 'mc-install-read-mode "mailcrypt" nil t)
;;;(add-hook 'mail-mode-hook 'mc-install-write-mode)
;;;(add-hook 'message-mode-hook 'mc-install-write-mode)
;;;(add-hook 'gnus-summary-mode-hook 'mc-install-read-mode)
;;;(add-hook 'news-reply-mode-hook 'mc-install-write-mode)
;;;(add-hook 'mh-folder-mode-hook 'mc-install-read-mode)
;;;(add-hook 'mh-letter-mode-hook 'mc-install-write-mode)


;;;
;;; for cc-mode
;;;

(require 'cc-mode)
(c-initialize-cc-mode)

;;;(c-add-style "freebsd"
;;;	     '("bsd"
;;;	       (c-offsets-alist . ((defun-block-intro . 8)
;;;				   (statement-block-intro . 8)
;;;				   (statement-case-intro . 8)
;;;				   (substatement-open . 4)
;;;				   (substatement . 8)
;;;				   (arglist-cont-nonempty . 4)
;;;				   (inclass . 8)
;;;				   (knr-argdecl-intro . 8)
;;;				   ))))
;;;(setq c-default-style "freebsd")
(setq-default c-auto-newline nil)

;;; for kerberos5
(add-hook 'before-save-hook 'copyright-update)

;;; -*- mode: emacs-lisp; indent-tabs-mode: nil -*-
(defconst krb5-c-style
  '("bsd"
    (c-basic-offset     . 4)
    (c-cleanup-list     . (brace-elseif-brace
                           brace-else-brace
                           defun-close-semi))
    (c-comment-continuation-stars       . "* ")
    (c-comment-only-line-offset . 0)
    (c-electric-pound-behavior  . (alignleft))
    (c-hanging-braces-alist     . ((block-close . c-snug-do-while)
                                   (brace-list-open)
                                   (class-open after)
                                   (extern-lang-open after)
                                   (substatement-open after)))
    (c-hanging-colons-alist     . ((case-label after)
                                   (label after)))
    (c-hanging-comment-starter-p        . nil)
    (c-hanging-comment-ender-p          . nil)
    (c-indent-comments-syntactically-p  . t)
    (c-label-minimum-indentation        . 0)
    (c-offsets-alist    . ((inextern-lang . 0)
                           (arglist-close . 0)))
    (c-special-indent-hook      . nil)
    (fill-column                . 79)))


;; Use eval-after-load rather than c-initialization-hook; this ensures
;; that the style gets defined even if a user loads this file after
;; initializing cc-mode.
(eval-after-load 'cc-mode (c-add-style "krb5" krb5-c-style))

(setq c-default-style "krb5")

;; We don't use a c-file-style file-local variable setting in our
;; source code, to avoid errors for emacs users who don't define the
;; "krb5" style.  Instead, use this heuristic.
;;
;; TODO: modify to also look for unique files in the source tree.
(defun krb5-c-mode-hook ()
  (if (and (eq major-mode 'c-mode)
           (eq c-basic-offset 4)
           (eq indent-tabs-mode nil))
      (c-set-style "krb5")))

(add-hook 'c-mode-common-hook 'krb5-c-mode-hook)

;; Use hack-local-variables-hook because the c-mode hooks run before
;; hack-local-variables runs.
(add-hook 'hack-local-variables-hook 'krb5-c-mode-hook)

;; emacs-23.x has a buggy cc-mode that incorrectly deals with case
;; labels with character constants.
;;;(if (and (string-match "^23\\." emacs-version)
;;;         (require 'cc-defs)
;;;         (string-match "5\\.31\\.[0-7]" c-version))
;;;    (let ((load-path (cons (file-name-directory load-file-name) load-path)))
;;;      (load "krb5-hack-cc-mode-caselabel")))

;(defun my-c-mode-common-hook ()
;  (c-set-style "cc-mode")
;  (setq c-basic-offset 8
;	c-conditional-key c-C++-conditional-key
;	indent-tabs-mode t
;	c-tab-always-indent nil)
;  (setq c-cleanup-list (append c-cleanup-list (list 'brace-else-brace)))
;  (c-set-offset 'arglist-close 0)
;  (c-set-offset 'arglist-cont-nonempty 4)
;  (c-set-offset 'inline-open 0)
;  (c-set-offset 'case-label 0)
;  (c-set-offset 'statement-cont 4)
;  (c-toggle-auto-state 1)
;  )
;;;(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;;;(c-add-style "eay"
;;;	     '((c-basic-offset . 8)
;;;	       (c-comment-only-line-offset . 0)
;;;	       (c-hanging-braces-alist)
;;;	       (c-offsets-alist	. ((defun-open . +)
;;;				   (defun-block-intro . 0)
;;;				   (class-open . +)
;;;				   (class-close . +)
;;;				   (block-open . 0)
;;;				   (block-close . 0)
;;;				   (substatement-open . +)
;;;				   (statement . 0)
;;;				   (statement-block-intro . 0)
;;;				   (statement-case-open . +)
;;;				   (statement-case-intro . +)
;;;				   (case-label . -)
;;;				   (label . -)
;;;				   (arglist-cont-nonempty . +)
;;;				   (topmost-intro . -)
;;;				   (brace-list-close . 0)
;;;				   (brace-list-intro . 0)
;;;				   (brace-list-open . +)
;;;				   ))))


;;;
;;; for Mew
;;;
(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)

(global-set-key "\C-xz" 'mew)

(setq mew-from "Tomoyuki Okazaki <okazaki@po.ntts.co.jp>")
(setq mew-smtp-server "helene.kick.gr.jp")
;;;(setq mew-smtp-ssh-server "helene.kick.gr.jp")
(setq mew-icon-directory "/usr/local/lib/xemacs/site-lisp/mew-icon/")

;;;(setq mew-smtp-ssh-server "helene")
(setq mew-prog-pgp "gpg")

;;; cache for password
(setq mew-use-cached-passwd t)
(setq mew-use-pgp-cached-passphrase t)

(autoload 'mew-user-agent-compose "mew" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'mew-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'mew-user-agent
      'mew-user-agent-compose
      'mew-draft-send-message
      'mew-draft-kill
      'mew-send-hook))

;;;(setq mew-use-folders-file-p t)
;;;(setq mew-demo-picture nil)

;;; for printer and Mew
(setq mew-print-command-format "a2ps | lpr")
(defun mew-print-region (begin end)
  (interactive "r")
  (shell-command-on-region begin end mew-print-command-format))
(defun mew-print-buffer ()
  (interactive)
  (mew-print-region (point-min) (point-max))
(setq mew-print-function (function mew-print-buffer)))

(setq url-proxy-services
      '(("http"     . "helene.kick.gr.jp:8080")
	("https"     . "helene.kick.gr.jp:8080")
	("ftp"     . "helene.kick.gr.jp:8080")))



;;;
;;; for abbreviation mode
;;;
(cond
 ((file-exists-p "~/.abbrev_defs")
  (read-abbrev-file "~/.abbrev_defs")
  (define-key esc-map  " " 'expand-abbrev) ; M-SPC
  ))

;;;
;;; for JDE
;;;
;;;(require 'jde)

;
; for emacsclient
;
;(server-start)
;(add-hook 'server-visit-hook 'make-frame)
;(add-hook 'server-done-hook 'delete-frame)

;(if window-system
;    (setq server-visit-hook
;	  '(lambda ()
;	     (setq server-window
;		   (make-frame '((name . "Server frame")
;				 (width . 80)
;				 (height . 26)))))))
;

;;; for emacs-w3m
;;;(autoload 'w3m "w3m" "Interface for w3m on Emacs." t)
;;; To use emacs-w3m on Wanderlust
;(setq mime-setup-enable-inline-html nil)                    
;(eval-after-load "mime-view"
;  '(progn                                                        
;     (autoload 'mime-w3m-preview-text/html "mime-w3m")
;     (ctree-set-calist-strictly
;      'mime-preview-condition
;      '((type . text) (subtype . html) (body . visible)
;        (body-presentation-method . mime-w3m-preview-text/html)))
;     (set-alist 'mime-view-type-subtype-score-alist
;		'(text . html) 3)))                               

;(eval-after-load "w3"
;  '(progn
;     (fset 'w3-fetch-orig (symbol-function 'w3-fetch))
;    (defun w3-fetch (&optional url target)
;       (interactive (list (w3-read-url-with-default)))
;       (if (eq major-mode 'gnus-article-mode)
;	   (browse-url url)
;	 (w3-fetch-orig url target)))))

;;; And to use emacs-w3m on Mew
;(require 'mew-w3m)
;(setq mew-prog-html '(mew-mime-text/html-w3m nil nil))

;;; for browse-url
(setq browse-url-browser-function 'browse-url-firefox)
;(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
;(global-set-key "\C-xm" 'browse-url-at-point)

;(require 'w3m)
;(require 'octet)
;(octet-mime-setup)

;;; for dired-mode
;(add-hook 'dired-mode-hook
;          (lambda ()
;              (define-key dired-mode-map "\C-xm" 'dired-w3m-find-file)))
;(defun dired-w3m-find-file ()
;  (interactive)
;  (require 'w3m)
;  (let ((file (dired-get-filename)))
;    (if (y-or-n-p (format "Open 'w3m' %s " (file-name-nondirectory file)))
;        (w3m-find-file file))))

;;;
;;; for lookup
;;;
;;; オートロードの設定
;;;(autoload 'lookup "lookup" nil t)
;;;(autoload 'lookup-region "lookup" nil t)
;;;(autoload 'lookup-pattern "lookup" nil t)

;;; キーバインドの設定
;;;(define-key ctl-x-map "l" 'lookup)              ; C-x l - lookup
;;;(define-key ctl-x-map "y" 'lookup-region)       ; C-x y - lookup-region
;;;(define-key ctl-x-map "\C-y" 'lookup-pattern)   ; C-x C-y - lookup-pattern

;;; agentの設定
;;;(setq lookup-search-agents
;;;      '((ndic "/usr/local/share/dict")
;;;	(ndtp "localhost")))

;;;
;;; for SDIC
;;;
;;;(autoload 'sdic-describe-word "sdic" "英単語の意味を調べる" t nil)
;;;(global-set-key "\C-cw" 'sdic-describe-word)
;;;(autoload 'sdic-describe-word-at-point
;;;  "sdic" "カーソルの位置の英単語の意味を調べる" t nil)

;;;(global-set-key "\C-cW" 'sdic-describe-word-at-point)


(custom-set-variables
 '(user-mail-address "okazaki@po.ntts.co.jp" t)
 '(query-user-mail-address nil))
(custom-set-faces)

(defvar my-mime-filename-coding-system-for-decode
  '(iso-2022-jp-2 japanese-shift-jis japanese-iso-8bit))
(defun my-mime-decode-filename (filename)
  (let ((rest (eword-decode-string filename)))
    (or (when (and my-mime-filename-coding-system-for-decode
		   (string= rest filename))
	  (let ((dcs (mapcar (function coding-system-base)
			     (detect-coding-string filename))))
	    (unless (memq 'emacs-mule dcs)
	      (let ((pcs my-mime-filename-coding-system-for-decode))
		(while pcs
		  (if (memq (coding-system-base (car pcs)) dcs)
		      (setq rest (decode-coding-string filename (car pcs))
			    pcs nil)
		    (setq pcs (cdr pcs))))))))
	rest)))
(eval-after-load "mime"
  '(defadvice mime-entity-filename (after eword-decode-for-broken-MUA activate)
     "Decode encoded file name for BROKEN MUA."
     (when (stringp ad-return-value)
       (setq ad-return-value (my-mime-decode-filename ad-return-value)))))

(put 'set-goal-column 'disabled nil)

(put 'narrow-to-region 'disabled nil)
