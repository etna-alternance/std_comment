;;
;; ETNA PROJECT, 21/08/2018 by cescut_c
;; Header Etna
;; File description:
;;      Fichier de configuration of the ETNA's standard header
;;

;;; Code:

(global-set-key   (kbd "C-c C-h") 'std-file-header)
(eval-when-compile
  (defvar header-etna)
  (defvar header-description)
  )

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default c-basic-offset 4)

(setq header-etna    "ETNA PROJECT, "
      header-description  "File description:")

;;; you can set the variable header-etna-login, for login with setq

(defvar std-c-alist           '( (cs . "/*") (cc . "** ") (ce . "*/") ))
(defvar std-css-alist         '( (cs . "/*") (cc . "** ") (ce . "*/") ))
(defvar std-cpp-alist         '( (cs . "/*") (cc . "** ") (ce . "*/") ))
(defvar std-pov-alist         '( (cs . "//") (cc . "// ") (ce . "//") ))
(defvar std-java-alist        '( (cs . "//") (cc . "// ") (ce . "//") ))
(defvar std-latex-alist       '( (cs . "%%") (cc . "%% ") (ce . "%%") ))
(defvar std-lisp-alist        '( (cs . ";;") (cc . ";; ") (ce . ";;") ))
(defvar std-xdefault-alist    '( (cs . "!!") (cc . "!! ") (ce . "!!") ))
(defvar std-pascal-alist      '( (cs . "{ ") (cc . "   ") (ce . "}" ) ))
(defvar std-makefile-alist    '( (cs . "##") (cc . "## ") (ce . "##") ))
(defvar std-text-alist        '( (cs . "##") (cc . "## ") (ce . "##") ))
(defvar std-fundamental-alist '( (cs . "  ") (cc . "   ") (ce . "  ") ))
(defvar std-html-alist        '( (cs . "<!--") (cc . "  -- ") (ce . "-->")))
(defvar std-php-alist         '( (cs . "//") (cc . "// ")(ce . "//")))
(defvar std-nroff-alist       '( (cs . "\\\"") (cc . "\\\" ") (ce . "\\\"")))
(defvar std-sscript-alist     '( (cs . "#!/usr/bin/env bash")  (cc . "## ") (ce . "##")))
(defvar std-perl-alist        '( (cs . "#!/usr/local/bin/perl -w")  (cc . "## ")(ce . "##")))
(defvar std-cperl-alist       '( (cs . "#!/usr/local/bin/perl -w")  (cc . "## ")(ce . "##")))


(defvar std-modes-alist '(
        ("C"                    . std-c-alist)
        ("CSS"                  . std-c-alist)
        ("PoV"                  . std-pov-alist)
        ("C++"                  . std-cpp-alist)
        ("Lisp"                 . std-lisp-alist)
        ("Lisp Interaction"     . std-lisp-alist)
        ("Emacs-Lisp"           . std-lisp-alist)
        ("Fundamental"          . std-fundamental-alist)
        ("Shell-script"         . std-sscript-alist)
        ("Makefile"             . std-makefile-alist)
        ("BSDmakefile"          . std-makefile-alist)
        ("GNUmakefile"          . std-makefile-alist)
        ("Perl"                 . std-cperl-alist)
        ("CPerl"                . std-cperl-alist)
        ("xdefault"             . std-xdefault-alist)
        ("Java"                 . std-java-alist)
        ("latex"                . std-latex-alist)
        ("Pascal"               . stdp-ascal-alist)
        ("Text"                 . std-text-alist)
        ("HTML"                 . std-html-alist)
        ("PHP"                  . std-php-alist)
        ("Nroff"                . std-nroff-alist)
        ("TeX"                  . std-latex-alist)
        ("LaTeX"                . std-latex-alist))
  )

(defun std-get (type)
  "Get the right comment characters for the right mode, TYPE the type of comment.\nComment start (cs), comment middle (cc), comment end (ce)."
  (interactive)
  (cdr (assoc type (eval (cdr (assoc (car (split-string mode-name "/")) std-modes-alist)))))
  )

(defun std-file-header ()
  "Puts an ETNA standard header at the beginning of the file.\n(According to mode)."
  (interactive)
  (goto-char (point-min))
  (let ((projlogin "[...]")(projname "[...]")(projdescription "[...]"))
    (if (boundp 'header-etna-login)
      (setq projlogin header-etna-login)
      (setq projlogin (read-from-minibuffer
          (format "Type your ETNA login (RETURN to quit) : "))))
    (setq projname (read-from-minibuffer
        (format "Type project name (RETURN to quit) : ")))
    (setq projdescription (read-from-minibuffer
         (format "Type short file description (RETURN to quit) : ")))
    (if (string= "" projlogin)
  (setq projlogin "[...]"))
    (if (string= "" projname)
  (setq projname "[...]"))
    (if (string= "" projdescription)
  (setq projdescription "[...]"))
    (insert (std-get 'cs))
    (newline)
    (insert (concat (std-get 'cc) header-etna (format-time-string "%d/%m/%Y") " by " projlogin))
    (newline)
    (insert (concat (std-get 'cc) projname))
    (newline)
    (insert (concat (std-get 'cc) header-description))
    (newline)
    (insert (concat (std-get 'cc) "     " projdescription))
    (newline)
    (insert (std-get 'ce))
    (newline)))
