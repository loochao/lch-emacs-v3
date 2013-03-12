;;-*- coding:utf-8; mode:emacs-lisp; -*-

;;; SHELL.EL
;;
;; Copyright (c) 2006 2007 2008 2009 2010 2011 Chao LU
;;
;; Author: Chao LU <loochao@gmail.com>
;; URL: http://www.princeton.edu/~chaol

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Setting for the terminals.

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
(message "=> lch-shell: loading...")

;; Convert color sequence in shell to face
(require 'ansi-color)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(setq comint-prompt-read-only t)

(defcustom eshell-directory-name
  (let* ((dir (concat emacs-var-dir "/eshell")))
    (make-directory dir t)
    dir)
  "The directory where Eshell control files should be kept."
  :type 'directory
  :group 'eshell)

;;; Multi-shell
(require 'multi-shell)
(setq multi-shell-command "/bin/bash")

;;; Multi-term
(require 'multi-term)
(setq multi-term-program "/bin/bash")

;;; Shell-pop
(require 'shell-pop)
(shell-pop-set-internal-mode "ansi-term")
(shell-pop-set-internal-mode-shell "/bin/bash")
;; the number for the percentage of the selected window.
;; if 100, shell-pop use the whole of selected window, not spliting.
(shell-pop-set-window-height 60)
;; shell-pop-up position. You can choose "top" or "bottom".
(shell-pop-set-window-position "bottom")
(define-key global-map (kbd "<f1> <f2>") 'shell-pop)


;;; Provide
(message "~~ lch-shell: done.")
(provide 'lch-shell)
;;; Local Vars.
;; Local Variables:
;; mode: emacs-lisp
;; mode: outline-minor
;; outline-regexp: ";;;;* "
;; End:
