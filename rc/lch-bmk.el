;;-*- coding:utf-8; mode:emacs-lisp; -*-

;;; BOOKMARK
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
(message "=> lch-bmk: loading...")

(require 'bookmark)
(defun switch-to-bookmark (bname)
  "Interactively switch to bookmark as `iswitchb' does."
  (interactive (list (flet ((ido-make-buffer-list
                             (default)
                             (bookmark-all-names)))
                       (ido-read-buffer "Jump to bookmark: " nil t))))
  (bookmark-jump bname))
(define-key global-map (kbd "C-c C-b") 'list-bookmarks)

(define-key global-map (kbd "<f5> b") 'list-bookmarks)
(define-key global-map (kbd "<f5> a") 'bookmark-set)
(define-key global-map (kbd "<f5> j") 'switch-to-bookmark)
(setq bookmark-save-flag 1)

(message "~~ lch-bmk: done.")
(provide 'lch-bmk)