;;-*- coding:utf-8; mode:emacs-lisp; -*-

;;; W32.EL
;;
;; Copyright (c) 2006 2007 2008 2009 2010 2011 Chao LU
;;
;; Author: Chao LU <loochao@gmail.com>
;; URL: http://www.princeton.edu/~chaol

;; This file is not part of GNU Emacs.

;;; Commentary:

;; commentary

;;; License:

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code

(defvar cygwin-root "e:/VAR/VPgm/EMUnixNT/Unix/Cygwin")
(defvar cygwin-bin (concat cygwin-root "/bin"))

(when lch-win32-p
  (progn
    (setenv "PATH"
            (concat
;FIXME        "C:\\cygwin\\usr\\local\\bin" ";"
;             "C:\\cygwin\\usr\\bin" ";"
;             "C:\\cygwin\\bin" ";"
;             "/usr/bin" ";"
             (getenv "PATH")))

    (setq exec-path
          `(
;            "C:/Program Files/ErgoEmacs 1.8.1/msys/bin/"
            ,cygwin-root
            ,cygwin-bin
            (concat cygwin-root "usr/bin/")
;            "C:/Program Files/Java/jdk1.6.0_14/bin/"
;            "C:/Program Files (x86)/Emacs/EmacsW32/gnuwin32/bin/"
            "C:/Windows/system32/"
            "C:/Windows/"
            "C:/Windows/System32/Wbem/"
            ))))



;>---- Cygwin-mount ----<;
;; (require 'cygwin-mount)
;; (cygwin-mount-activate)


;; (when (and (eq 'windows-nt system-type)
;;            (file-readable-p cygwin-root))
;;   (setq exec-path (cons cygwin-bin exec-path))
;;   (setenv "PATH" (concat cygwin-bin ";" (getenv "PATH")))

;;   (setq Info-default-directory-list (append Info-default-directory-list (concat cygwin-root "/usr/info")))

;;   ;; By default use the Windows HOME.
;;   ;; Otherwise, uncomment below to set a HOME
;;   ;;      (setenv "HOME" (concat cygwin-root "/home/loochao"))

;;   ;; NT-emacs assumes a Windows shell. Change to baash.
;;   (setq shell-file-name "bash")
;;   (setenv "SHELL" shell-file-name)
;;   (setq explicit-shell-file-name shell-file-name)
;;   (setq ediff-shell shell-file-name)
;;   (setq explicit-shell-args '("--login" "-i"))
;;   (setq w32-quote-process-args ?\")

;;   ;; This removes unsightly ^M characters that would otherwise
;;   ;; appear in the output of java applications.
;;   (add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m))

;;; Print for w32
(if lch-win32-p
    (progn
      (require 'w32-winprint)
      (define-key global-map (kbd "<f2> p") 'w32-winprint-print-buffer-htmlize)
      (define-key global-map (kbd "<f2> P") 'w32-winprint-print-buffer-notepad)))

;;;###autoload
(defun bash ()
  "Start `bash' shell."
  (interactive)
  (let ((binary-process-input t)
        (binary-process-output nil))
    (shell)))

;;; W32 max/restore frame
;; (if lch-win32-p
;;     (when (fboundp 'w32-send-sys-command)
;;       (progn
;;         (defun w32-restore-frame ()
;;           "Restore a minimized frame"
;;           (interactive)
;;           (w32-send-sys-command 61728))
;;         (defun w32-maximize-frame ()
;;           "Maximize the current frame"
;;           (interactive)
;;           (w32-send-sys-command 61488))
;;         (define-key global-map (kbd "<f11> m") 'w32-maximize-frame))))

(setq process-coding-system-alist
      (cons '("bash" . (raw-text-dos . raw-text-unix)) process-coding-system-alist))

(provide 'lch-w32)

;;; Local Vars.
;; Local Variables:
;; mode: emacs-lisp
;; mode: outline-minor
;; outline-regexp: ";;;;* "
;; End:
