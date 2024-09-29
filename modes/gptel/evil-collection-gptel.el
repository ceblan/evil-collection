;;; evil-collection-pdf.el --- Evil bindings for pdf-tools  -*- lexical-binding: t -*-

;; Copyright (C) 2017, 2024 Pierre Neidhardt

;; Author: Pierre Neidhardt <mail@ambrevar.xyz>
;; Maintainer: James Nguyen <james@jojojames.com>
;; Pierre Neidhardt <mail@ambrevar.xyz>
;; URL: https://github.com/emacs-evil/evil-collection
;; Version: 0.0.1
;; Package-Requires: ((emacs "26.3"))
;; Keywords: evil, pdf, tools

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published
;; by the Free Software Foundation; either version 3, or (at your
;; option) any later version.
;;
;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.

;;; Commentary:
;; Evil bindings for pdf-tools.

;;; Code:
(require 'evil-collection)
(require 'gptel nil t)
(require 'gptel-context nil t)

(defconst evil-collection-gptel-maps '(gptel-mode-map
                                     ;; pdf-history-minor-mode-map
                                     ;; pdf-outline-buffer-mode-map
																		 ;; pdf-annot-list-mode-map
                                     gptel-context-buffer-mode-map))

;; (declare-function pdf-view-last-page "pdf-view")
;; (declare-function pdf-view-first-page "pdf-view")
;; (declare-function pdf-view-goto-page "pdf-view")
;; (declare-function pdf-view-previous-line-or-previous-page "pdf-view")
;; (declare-function pdf-view-next-line-or-next-page "pdf-view")
;; (declare-function pdf-view-assert-active-region "pdf-view")
;; (declare-function pdf-view-active-region-text "pdf-view")
;; (declare-function pdf-view-deactivate-region "pdf-view")
;; (declare-function pdf-history-forward "pdf-history")
;; (declare-function pdf-history-backward "pdf-history")

;; (defvar gptel-mode-map)
(defvar gptel-context-buffer-mode-map)

;;;###autoload
(defun evil-collection-gptel-setup ()
	(interactive)
	"Set up `evil' bindings for `gptel'."
	;; (evil-collection-inhibit-insert-state 'gptel-context-buffer-mode-map)
	(evil-set-initial-state 'gptel-context 'normal)
	(evil-collection-define-key 'normal 'gptel-context-buffer-mode-map
		;; motion
		"d" 'gptel-context-flag-deletion
		"n" 'gptel-context-next
		"p" 'gptel-context-previous
		;; (kbd "SPC") 'pdf-view-scroll-up-or-next-page
		;; (kbd "S-SPC") 'pdf-view-scroll-down-or-previous-page
		;; (kbd "<delete>") 'pdf-view-scroll-down-or-previous-page
		;; (kbd "C-f") 'pdf-view-scroll-up-or-next-page
		;; (kbd "C-b") 'pdf-view-scroll-down-or-previous-page
		"q" 'quit-window
		"ZQ" 'quit-window
		"ZZ" 'pdf-outline-quit-and-kill)

	)



(provide 'evil-collection-gptel)
;;; evil-collection-pdf.el ends here
