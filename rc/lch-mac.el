;;-*- coding:utf-8; mode:emacs-lisp; -*-

;;; MAC.EL
;;
;; Copyright (c) 2006 2007 2008 2009 2010 2011 Chao LU
;;
;; Author: Chao LU <loochao@gmail.com>
;; URL: http://www.princeton.edu/~chaol

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Setting for MAC.

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
(message "=> lch-mac: loading...")

;;; Super and Meta
;; Emacs users obviously have little need for Command and Option keys,
;; but they do need Meta and Super.
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'super)
  (setq mac-option-modifier 'meta))

;;; Use Spotlight as locate in OSX
(setq locate-command "mdfind")

;;; Fix path
;; Emacs does not always properly catch the system and user paths at
;; launch on OS X. I rely on code lifted from Aquamacs to fix this.
;; Cost: 1 second at launch time.
(require 'fixpath)

;;; Define a function to setup additional path
(defun my-add-path (path-element)
"Add the specified path element to the Emacs PATH"
   (interactive "DEnter directory to be added to path: ")
       (if (file-directory-p path-element)
          (setenv "PATH"
            (concat (expand-file-name path-element)
              path-separator (getenv "PATH")))))

;;; Set localized PATH for OS X
(if (fboundp 'my-add-path)
    (let ((my-paths (list
                     "/opt/local/bin"
                     "/usr/local/bin"
                     "/usr/local/sbin"
                     "~/bin")))
      (dolist (path-to-add my-paths (getenv "PATH"))
        (my-add-path path-to-add))))

;; Work around a bug on OS X where system-name is a fully qualified
;; domain name
(setq system-name (car (split-string system-name "\\.")))

;; Ensure the exec-path honours the shell PATH
(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

;; Provide
(provide 'lch-mac)
(message "~~ lch-mac: done.")

;;; Local Vars.
;; Local Variables:
;; mode: emacs-lisp
;; mode: outline-minor
;; outline-regexp: ";;;;* "
;; End:
