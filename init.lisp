(in-package :lem-user)

(setf (variable-value 'Add-Newline-at-EOF-on-Writing-File :global) t)
(setf (variable-value 'lem::Delete-Trailing-Whitespace-on-Writing-File :global) t)

(define-command other-window-or-split-window (&optional (n 1)) ("p")
  "Bring back this command"
  (when (one-window-p)
    (split-window-sensibly (current-window)))
  (other-window n))

(define-key *global-keymap* "C-M-o" 'other-window-or-split-window)

(define-command backward-kill-line () ()
  "Kill line from point to beginning of line."
  (kill-line -0))

(define-key *global-keymap* "C-u" 'backward-kill-line)
(define-key *global-keymap* "M-'" 'lem/universal-argument:universal-argument)

(define-command open-line-below (n) ("p")
  "vi-like open command, but without vi-mode."
  (move-to-end-of-line)
  (lem/language-mode:newline-and-indent n))

(define-command open-line-above (&optional (n 1)) ("p")
  "vi-like open command, but without vi-mode."
  (move-to-beginning-of-line)
  (open-line n))

(define-key *global-keymap* "C-o" 'open-line-below)
(define-key *global-keymap* "M-o" 'open-line-above)

(define-command kill-bword-or-region (&optional (n 1)) ("p")
  "Kill region if active, otherwise back n words."
  (if (buffer-mark-p (current-buffer))
         (kill-region (region-beginning) (region-end))
        (backward-delete-word n)))

(define-key *global-keymap* "C-w" 'kill-bword-or-region)

(define-key *global-keymap* "C-h B" 'lem:describe-bindings)
(define-key *global-keymap* "C-h k" 'lem:describe-key)
(define-key *global-keymap* "C-h a" 'lem-lisp-mode:lisp-apropos-all)
(define-key *global-keymap* "C-h s" 'lem-lisp-mode:lisp-describe-symbol)

(define-key *global-keymap* "Return" 'lem/language-mode:newline-and-indent)
(define-key *global-keymap* "C-_" 'undo)
(define-key *global-keymap* "C-\\" 'redo)
(define-key *global-keymap* "Home" 'move-to-beginning-of-buffer)
(define-key *global-keymap* "End" 'move-to-end-of-buffer)


(let ((user-init-folder (merge-pathnames ".lem/"
                                         (user-homedir-pathname))))
  (load (merge-pathnames "simple-theme.lisp" user-init-folder)))

(load-theme "simple-theme")
