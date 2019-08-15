;; base16-mars-theme.el -- A base16 colorscheme

;;; Commentary:
;; Base16: (https://github.com/chriskempson/base16)

;;; Authors:
;; Scheme: Will Vauclain (https://github.com/wvauclain/)
;; Template: Kaleb Elwert <belak@coded.io>

;;; Code:

(require 'base16-theme)

(defvar base16-mars-colors
  '(:base00 "#330004"
    :base01 "#471A1D"
    :base02 "#5C3336"
    :base03 "#998082"
    :base04 "#AD999B"
    :base05 "#C2B3B4"
    :base06 "#D6CCCD"
    :base07 "#EBE6E6"
    :base08 "#53BD98"
    :base09 "#A9CC76"
    :base0A "#E4F038"
    :base0B "#E59C00"
    :base0C "#BFB472"
    :base0D "#D38EFF"
    :base0E "#FF894F"
    :base0F "#FF849C")
  "All colors for Base16 Mars are defined here.")

;; Define the theme
(deftheme base16-mars)

;; Add all the faces to the theme
(base16-theme-define 'base16-mars base16-mars-colors)

;; Mark the theme as provided
(provide-theme 'base16-mars)

(provide 'base16-mars-theme)

;;; base16-mars-theme.el ends here
