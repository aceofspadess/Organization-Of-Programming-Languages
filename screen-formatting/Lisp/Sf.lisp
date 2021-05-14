#!/usr/bin/sbcl --script	

(defvar fl)
(defvar cla)
(defvar end)
(defvar line)

;Strings that hold chars to form words and 60 char lines
(defvar longLine "")
(defvar savedWord "")
(defvar test "")

;ints that help keep track of the number of characters, words, and the current line number
(defvar charLimit 0)
(defvar wordCount 0)
(defvar currentLineNum 0)

;Variables that will store the longest and shortest line of the text file and keeps them saved for the end of the file
(defvar longestLine "")
(defvar smallestLine "")
(defvar longestSize 0 )
(defvar smallestSize 1000)
(defvar longestLineNum 0)
(defvar smallestLineNum 0)


(setq fl (open (car(cdr *posix-argv*) )) )

	(loop for line = (read-char fl nil :eof) ; stream, no error, :eof value
	      until (eq line :eof)

	        ;increment the character count
	     	do (setq charLimit(+ charLimit 1))

		;test to see if the current character is a number or newline
		(setq test "")
		(setq test (Concatenate 'String test(list line)))
		(setq test(string-trim "0123456789" test))
		(setq test(string-trim '(#\newline) test))		


		;if the current char is not a number or newline
		(if(= (length test) 1)(prog1
			

			(if( < charLimit 60) (prog1

				;test to see if current char is a space character
				(setq test(string-trim " " test))
		
				;if it is not then just concatenate the current character to the savedWord string
				(if(= (length test) 1)
					(setq savedWord (Concatenate 'String savedWord(list line)))	
				)

				;if it is then concatenate savedWord to the main longString variable along with a space character
				;also increment the word count
				(if(/= (length test) 1)(prog1

					(setq longLine (Concatenate 'String longLine(String " ")))
					(setq longLine (Concatenate 'String longLine(String savedWord)))
					(setq savedWord "")
					(setq wordCount(+ wordCount 1))
				)
				)
			)
			)

			;if the 60 char limit has been reached then print longLine and check to see if it is the current longest or shortest line
			;then empty longLine
			(if( = charLimit 60) (prog1

				(princ currentLineNum)
				(princ "   ")
				(princ longLine)
				(setq currentLineNum(+ currentLineNum 1))

				(if(> wordCount longestSize)(prog1

				  	(setq longestSize wordCount)
				  	(setq longestLine  longLine)
			          	(setq longestLineNum  currentLineNum)
				 )
				 )

				(if(< wordCount smallestSize)(prog1

				  	(setq smallestSize wordCount)
				  	(setq smallestLine  longLine)
			          	(setq smallestLineNum  currentLineNum)
				 )
				 )

				(FRESH-LINE)
				(setq longLine "")
				(setq charLimit(Length savedWord))

			)
			)

		)
		)
		;if the current char is a number or newline then decrement the char count and ignore it
		(if(/= (length test) 1)
		
			(setq charLimit(- charLimit 1))
		 )
		 
	)

;This last section if the same as the version in the loop except its made specifically for the last line of the text file
(setq wordCount 0)

(loop for end across savedWord

	do (setq test "")
	(setq test (Concatenate 'String test(list end)))
	(setq test(string-trim '(#\Space) test))	
	(setq test(string-trim '(#\NewLine) test))
	(setq test(string-trim ". ? !" test))

	(if(/= (Length test) 1)
		(setq wordCount (+ wordCount 1))
	)
)


(if(> wordCount longestSize)(prog1

	(setq longestSize wordCount)
	(setq longestLine  savedWord)
	(setq longestLineNum  currentLineNum)
)
)

(if(< wordCount smallestSize)(prog1

	(setq smallestSize wordCount)
	(setq smallestLine  savedWord)
	(setq smallestLineNum  currentLineNum)
)
)

(FRESH-LINE)
;Print last line, and the longest and shortest lines from the textfile

(princ currentLineNum)
(princ "   ")
(princ longLine)
(terpri)
(setq currentLineNum (+ currentLineNum 1))
(princ currentLineNum)
(princ "   ")
(princ savedWord)
(terpri)


(FRESH-LINE)
(princ "The longest line was line number ") 
(princ longestLineNum)
(princ "  ")
(princ longestLine)
(terpri)

(setq smallestLineNum(+ smallestLineNum 1))

(FRESH-LINE)
(princ "The shortest line was line number ")
(princ smallestLineNum)
(princ "   ")
(princ smallestLine)
(terpri)


(close fl)
