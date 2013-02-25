;;-*- coding:utf-8; mode:emacs-lisp; -*-

;;; THEME.EL
;;
;; Copyright (c) 2006-2013 Chao LU
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
(message "=> lch-ui-theme: loading...")

(defvar emacs-theme-dir (concat emacs-lib-dir "/themes"))
(add-to-list 'load-path emacs-theme-dir)
(require 'color-theme)
;; (color-theme-initialize)

;;; Arjen
;; (require 'color-theme-arjen)
;; (define-key global-map (kbd "<f11> <f11>") (lambda() (interactive) (color-theme-arjen) (lch-modeline-font) (message "color theme arjen selected")))

;;; Cyberpunk
;; (require 'color-theme-cyberpunk)
;; (define-key global-map (kbd "<f11> <f1>") (lambda() (interactive) (color-theme-cyberpunk) (lch-modeline) (message "color theme cyberpunk selected")))

;;; Modeline
(defun lch-modeline-font ()
  (interactive)
  (if lch-mac-p
      (set-face-font 'modeline "-apple-Monaco-medium-normal-normal-*-18-*-*-*-m-0-fontset-startup")
    (set-face-font 'modeline "-outline-Lucida Console-normal-normal-normal-mono-18-*-*-*-c-*-iso8859-1")))

(defun lch-modeline-color ()
  (interactive)
  (set-face-background 'modeline "DarkRed")
  (set-face-foreground 'modeline "White"))

(defun lch-modeline ()
  (interactive)
  (lch-modeline-color)
  (lch-modeline-font))
(define-key global-map (kbd "<f11> =") 'lch-modeline)

;;; Theme load
;; (require 'color-theme-arjen)

(require 'color-theme-loochao)
;; FIXME: cyberpunk does not work well with modeline fontsize
;; (color-theme-arjen)
;; (color-theme-cyberpunk)
(color-theme-loochao)
(lch-modeline)

(provide 'lch-ui-theme)
(message "~~ lch-ui-theme: done.")

;;; Local Vars.
;; Local Variables:
;; mode: emacs-lisp
;; mode: outline-minor
;; outline-regexp: ";;;;* "
;; End:
