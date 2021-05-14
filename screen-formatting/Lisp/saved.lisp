#!/usr/bin/sbcl --script	

;;;Want to avoid compiler warnings, so add defvar for these variables
(defvar fl)
(defvar cla)

(defvar line)
(defvar longLine "")
(defvar savedWord "")
(defvar charLimit 0)
(defvar isNum 0)
(defvar prevSpace 0)
;;(defvar longLine)
;;(defvar shortLine)
;;(defvar longLineSize 0)
;;(defvar shortLineSize 0)



(setq fl (open (car(cdr *posix-argv*) )) )

	(loop for line = (read-char fl nil :eof) ; stream, no error, :eof value
	      until (eq line :eof)

	     	do (setq charLimit (length savedWord))


		  (if(< charLimit 60) (prog1

			(if(= line #\Space)
			
			  (setq savedWord (Concatenate 'String savedWord(list #\Space)))
			)
			
			(if(/= line #\Space)(prog1

				(setq savedWord (Concatenate 'String savedWord(list line)))
		  		(setq savedWord (string-trim " " savedWord))
				)
			)
			)
		  )

		  (if(= charLimit 60) (prog1
	
		  	(setq longLine (Concatenate 'String longLine (String savedWord)))
			(setq longLine (Concatenate 'String longLine (list #\Space)))
			(setq longLine(string-trim "0123456789" longLine))
			(setq charLimit (length savedWord))
			(setq savedWord "")
			)
		  )	

		 
	)

(princ longLine)
(princ "The number of lines in this text file is")
(terpri)
(close fl)
