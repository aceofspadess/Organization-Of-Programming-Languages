#!/usr/bin/sbcl --script 	

(defvar k 1)
(defvar middle 0)
(defvar steps 0)
(defvar a 0)
(defvar big 5000000000)
(defvar numArray (make-array '(10)))
(defvar stepArray (make-array '(10)))

(defvar comp 0)
(defvar b 0)
(defvar i 0)
(defvar j 0)
(defvar n 0)
(defvar temp 0)
(defvar temp2 0)




(defun collatz (middle steps)

  (setq steps 0)

  (loop while (/= middle 1) 	

	    do(if (= (mod middle 2) 0) (setq middle (floor middle 2)) 
	   
	    (setq middle (+(* middle 3)1)))

            (setq steps (+ steps 1))
  )

  (return-from collatz steps)
)






(defun BubbleSort (x y)

  (setq n (array-total-size x))

  (do ((i 0 (+ i 1))) ((= i (- n 1)))

    (do ((j 0 (+ j 1))) ((= j (- (- n i) 1)))

      (if (> (aref numArray  j) (aref numArray (+ j 1) ) )

	(swap j (+ j 1))
	)
      )
    )
  )


;Swap values for bubblesort function, in both arrays
(defun swap (x y)
  (setf temp (aref numArray x))
  (setf temp2 (aref stepArray x))

  (setf (aref numArray x) (aref numArray y))
  (setf (aref stepArray x) (aref stepArray y))

  (setf (aref numArray y) temp)
  (setf (aref stepArray y) temp2)
)



;MAIN

(setq a 0)

;Fill both arrays with initial -1 values
(loop repeat 10
  	
	do(setf (aref numArray a) -1)
	(setf (aref stepArray a) -1)

	(setq a (+ a 1))
)

;Loop till 5 billion
(loop while (<= k big)

      do(setq steps 0)

      (setq steps (collatz k steps))

      (Bubblesort numArray stepArray)

;If the step value in position 0 is less than the current collatz step calculated then replace it with the current k value and its steps
      (if (< (aref stepArray 0) steps)(prog1
	
	(setf (aref numArray 0) k)
	(setf (aref stepArray 0) steps)))

      (setq k (+ k 1))
)

;Sort again before printing results of both arrays
(Bubblesort numArray stepArray)

(princ "Shortest Collatz numbers with the longest steps")
(terpri)

(setq a 0)

(loop while (< a 10)

	do(fresh-line)
	(princ "Number: ")
	(princ (aref numArray a))
	(princ "       ")
	(princ "Number of Steps: ")
	(princ (aref stepArray a))
	(terpri)
	(setq a (+ a 1))
)
