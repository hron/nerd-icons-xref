;;; nerd-icons-xref-tests.el --- Tests for nerd-icons-xref -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2025 Aleksei Gusev
;;
;; Author: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Maintainer: Aleksei Gusev <aleksei.gusev@gmail.com>
;; Created: May 12, 2025
;; Modified: May 12, 2025
;; Version: 0.0.1
;; Keywords: abbrev, icons, tests
;; Homepage: https://github.com/hron/nerd-icons-xref
;; Package-Requires: ((emacs "30.1"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Tests for nerd-icons-xref
;;
;;; Code:

(require 'xref)

(ert-deftest nerd-icons-display-tests--verify-icons ()
  (let ((xref-buffer-name "*nerd-icons-xref-test*")
        (xref-show-xrefs-function 'xref--show-xref-buffer)
        (fetcher (lambda ()
                   (list (xref-make-match
                          "Some content"
                          (xref-make-file-location "./README.md" 1 0) 2)
                         (xref-make-match
                          ";;; nerd-icons-xref-tests.el"
                          (xref-make-file-location "./nerd-icons-xref-tests.el" 1 0) 2)))))
    (with-current-buffer-window  xref-buffer-name nil nil
      (xref--show-xrefs fetcher nil)
      ;; Checks
      (save-excursion
        (goto-char (point-min))
        (should (eq (search-forward " example-file.el" nil t) 25))
        (should (eq (search-forward " another-file.c" nil t) 50))))))

(provide 'nerd-icons-display-tests)
;;; nerd-icons-display-tests.el ends here
