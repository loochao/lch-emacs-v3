;; -*- mode: emacs-lisp -*-

;;; Frame parameters
(setq default-frame-alist
      (append
       '((default-fringes-outside-margins . 1)
         (default-left-fringe-width . 12)
         (default-left-margin-width . 14)
         (cursor-color . "sienna1")
         (background-color . "Black")
         (foreground-color . "MistyRose3")
         ;; (top . 42)
         ;; (left . 42)
         ;; (height . 47)
         ;; (width . 128)
         ) default-frame-alist))


;; (setq default-indicate-empty-lines t)
(setq indicate-buffer-boundaries 'left)


;;; Menu
;; get rid of the Games in the Tools menu
;; (define-key menu-bar-tools-menu [games] nil)


(if lch-mac-p
    (setq default-frame-alist
          (append
           '((font . "-apple-Monaco-medium-normal-normal-*-21-*-*-*-m-0-fontset-startup"))
           default-frame-alist)))
(if lch-mac-p
    (set-face-font 'modeline "-apple-Monaco-medium-normal-normal-*-18-*-*-*-m-0-fontset-startup")
  (set-face-font 'modeline "-outline-Lucida Console-normal-normal-normal-mono-18-*-*-*-c-*-iso8859-1"))

;;; Cursor
;; Don't blink
(and (fboundp 'blink-cursor-mode) (blink-cursor-mode (- (*) (*) (*))))

;; bar-cursor-mode
(require 'bar-cursor)
(bar-cursor-mode 1)

;; Change cursor color and type according to some minor modes.
(defvar lch-read-only-color       "gray")
;; valid values are t, nil, box, hollow, bar, (bar . WIDTH), hbar,
;; (hbar . HEIGHT); see the docs for set-cursor-type
(defvar lch-read-only-cursor-type 'hbar)
(defvar lch-overwrite-color       "red")
(defvar lch-overwrite-cursor-type 'bar)
(defvar lch-normal-color          "sienna1")
(defvar lch-normal-cursor-type    'box)

(defun lch-set-cursor-according-to-mode ()
  "change cursor color and type according to some minor modes."
  (cond
   (buffer-read-only
    (set-cursor-color lch-read-only-color)
    (setq cursor-type lch-read-only-cursor-type))
   (overwrite-mode
    (set-cursor-color lch-overwrite-color)
    (setq cursor-type lch-overwrite-cursor-type))
   (t
    (set-cursor-color lch-normal-color)
    (setq cursor-type lch-normal-cursor-type))))

(defun aquamacs-cursor ()
  (set-cursor-color lch-normal-color)
  (setq cursor-type lch-normal-cursor-type))

;; FIXME Does not work with Aquamacs
(if (not lch-aquamacs-p) (add-hook 'post-command-hook 'lch-set-cursor-according-to-mode)
  (add-hook 'after-init-hook 'aquamacs-cursor))

;;; Titlebar
;; %f: Full path of current file.
;; %b: Buffer name.
(setq frame-title-format "LooChao@%b")
;; (setq frame-title-format "FIRST THING FIRST / DO IT NOW!!")
(setq icon-title-format "Emacs - %b")

;;; Menu-bar+
;; (eval-after-load "menu-bar" '(require 'menu-bar+))

;;; Pretty Control L
(require 'pp-c-l)
(setq pp^L-^L-string "----------------")
(set-face-attribute 'pp^L-highlight t :foreground "Black" :background "Orange")
(pretty-control-l-mode 1)


;;; Parentheses
;; Comment this paragraph, so the highlight-parentheses will work.
;; Paren color set in color-theme-lch.el
(if (fboundp 'show-paren-mode)
    (progn
      (show-paren-mode 1)
      ;; (setq show-paren-delay 0)
      ;; (setq show-paren-style 'parentheses)
      ;; (setq show-paren-style 'expression)
      ))

;; Highlight paren when inside (red)
;; FIXME: This cause page down does not work correctly.
;; (require 'highlight-parentheses)

;; ;; Have to define global-highlight-parentheses-mode to enable it all the time
;; (defun turn-on-highlight-parentheses-mode ()
;;   (highlight-parentheses-mode t))
;; (define-global-minor-mode global-highlight-parentheses-mode
;;   highlight-parentheses-mode
;;   turn-on-highlight-parentheses-mode)
;; (global-highlight-parentheses-mode)

;;; Line-num
;; vi style set num
(require 'setnu)

;;; Cycle color
(defun lch-cycle-fg-color (num)
  ""
  (interactive "p")
  (let (colorList colorToUse currentState nextState)
    (setq colorList (list
                     "MistyRose3"  "Wheat3" "Wheat2" "OliveDrab" "YellowGreen"))
    (setq currentState (if (get 'lch-cycle-fg-color 'state) (get 'lch-cycle-fg-color 'state) 0))
    (setq nextState (% (+ currentState (length colorList) num) (length colorList)))
    (setq colorToUse (nth nextState colorList))
    (set-frame-parameter nil 'foreground-color colorToUse)
    (redraw-frame (selected-frame))
    (message "Current foreColor is %s" colorToUse)

    (put 'lch-cycle-fg-color 'state nextState)))

(defun lch-cycle-fg-color-foward ()
  "Switch to the next color, in the current frame.
See `cycle-color'."
  (interactive)
  (lch-cycle-fg-color 1))
(define-key global-map (kbd "<f11> 1") 'lch-cycle-fg-color-foward)

(defun lch-cycle-fg-color-backward ()
  "Switch to the next color, in the current frame.
See `cycle-color'."
  (interactive)
  (lch-cycle-fg-color -1))
(define-key global-map (kbd "<f11> 2") 'lch-cycle-fg-color-backward)

(defun lch-cycle-bg-color (num)
  ""
  (interactive "p")
  (let (colorList colorToUse currentState nextState)
    (setq colorList (list
                     "Black" "DarkSlateGray"))
    (setq currentState (if (get 'lch-cycle-bg-color 'state) (get 'lch-cycle-bg-color 'state) 0))
    (setq nextState (% (+ currentState (length colorList) num) (length colorList)))
    (setq colorToUse (nth nextState colorList))
    (set-frame-parameter nil 'background-color colorToUse)
    (redraw-frame (selected-frame))
    (message "Current backColor is %s" colorToUse)

    (put 'lch-cycle-bg-color 'state nextState)))

(defun lch-cycle-bg-color-foward ()
  "Switch to the next color, in the current frame.
See `cycle-color'."
  (interactive)
  (lch-cycle-bg-color 1))
(define-key global-map (kbd "<f11> 3") 'lch-cycle-bg-color-foward)

(defun lch-cycle-bg-color-backward ()
  "Switch to the next color, in the current frame.
See `cycle-color'."
  (interactive)
  (lch-cycle-bg-color -1))
(define-key global-map (kbd "<f11> 4") 'lch-cycle-bg-color-backward)

;;; Cycle fonts
(defun cycle-font (num)
  "Change font in current frame.
Each time this is called, font cycles thru a predefined set of fonts.
If NUM is 1, cycle forward.
If NUM is -1, cycle backward.
Warning: tested on Windows Vista only."
  (interactive "p")

  ;; this function sets a property ¡°state¡±. It is a integer. Possible values are any index to the fontList.
  (let (fontList fontToUse currentState nextState )
    (setq fontList (list
                    "-outline-Lucida Console-normal-normal-normal-mono-18-*-*-*-c-*-iso8859-1"
                    "-outline-Lucida Console-normal-normal-normal-mono-21-*-*-*-c-*-iso8859-1"
                    "-outline-Lucida Console-normal-normal-normal-mono-24-*-*-*-c-*-iso8859-1"
                    "-outline-Monaco-normal-normal-normal-mono-18-*-*-*-c-*-iso8859-1"
                    "-outline-Monaco-normal-normal-normal-mono-21-*-*-*-c-*-iso8859-1"
                    "-outline-Monaco-normal-normal-normal-mono-24-*-*-*-c-*-iso8859-1"
                    ;; "-*-Courier New-normal-r-*-*-24-112-96-96-c-*-iso8859-1"
                    ;; "-outline-Lucida Sans Unicode-normal-normal-normal-sans-24-*-*-*-p-*-iso8859-1"
                    ))
    ;; fixed-width "Courier New" "Unifont"  "FixedsysTTF" "Miriam Fixed" "Lucida Console" "Lucida Sans Typewriter"
    ;; variable-width "Code2000"
    (setq currentState (if (get 'cycle-font 'state) (get 'cycle-font 'state) 0))
    (setq nextState (% (+ currentState (length fontList) num) (length fontList)))

    (setq fontToUse (nth nextState fontList))
    (set-frame-parameter nil 'font fontToUse)
    (redraw-frame (selected-frame))
    (message "Current font is: %s" fontToUse )
    (put 'cycle-font 'state nextState)))

(defun cycle-font-forward ()
  "Switch to the next font, in the current frame.
See `cycle-font'."
  (interactive)
  (cycle-font 1))
(define-key global-map (kbd "<f11> 5") 'cycle-font-forward)

(defun cycle-font-backward ()
  "Switch to the previous font, in the current frame.
See `cycle-font'."
  (interactive)
  (cycle-font -1))
(define-key global-map (kbd "<f11> 6") 'cycle-font-backward)

;;; Toggle line space
(defun toggle-line-spacing ()
"Toggle line spacing between no extra space to extra half line height."
(interactive)
(if (eq line-spacing nil)
    (setq-default line-spacing 0.5) ; add 0.5 height between lines
  (setq-default line-spacing nil)   ; no extra heigh between lines
  ))

(define-key global-map (kbd "<f11> L") 'toggle-line-spacing)

;;; Provide
(provide 'lch-ui)
;;; Local Vars
;; Local Variables:
;; mode: emacs-lisp
;; mode: outline-minor
;; outline-regexp: ";;;;* "
;; End:
