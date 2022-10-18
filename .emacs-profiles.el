(
 ;; simple editor for TTYs
 ("default" . ((user-emacs-directory . "/home/kept/emacs/conf-tty")))

 ("doom" . ((user-emacs-directory . "~/doom-emacs/")
	    ;; NOTE: doom's envvars already set in my .profile
            ))
  
 ("spacemacs" . ((user-emacs-directory . "~/spacemacs")
                 (env . (("SPACEMACSDIR" . "/home/kept/emacs/conf-spacemacs")))))

 ("spacemacs-develop" . ((user-emacs-directory . "~/spacemacs/develop")
                         (env . (("SPACEMACSDIR" . "/home/kept/emacs/conf-spacemacs")))))

 ("vanilla" . ((user-emacs-directory . "/home/kept/emacs/conf-vanilla/")))
 )
