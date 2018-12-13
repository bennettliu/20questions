/*
 * Authored by Bennett Liu on August 31th, 2018
 * Provides a library of functions for other programs to use
 */

/*
 * Defines the log function, which given a prompt, prints the prompt.
 */
(deffunction log (?prompt)
   (printout t ?prompt crlf)
   (return)
)

/*
 * Defines the ask function, which given a prompt, prints the prompt and returns the user's input
 */
(deffunction ask (?prompt)
   (printout t ?prompt)
   (bind ?response (read))
   (return ?response)
)
 
/*
 * Defines the askCharacteristic function, which given a prompt, prints the prompt as a 
 * question requiring an answer beginning with a 'y', 'n', or '?' (any case) and returns the 
 * user's input.
 */
(deffunction askCharacteristic (?prompt)
   (bind ?response (upcase (ask (str-cat ?prompt " (Y/N/?) "))))
   (while (and (<> (sub-string 1 1 ?response) Y) (<> (sub-string 1 1 ?response) N) (<> (sub-string 1 1 ?response) "?"))
      (bind ?response (upcase (ask "Please enter a valid input. (Y/N) ")))
   )
   (return (sub-string 1 1 ?response))
)

/*
 * Defines the askAnimal function, which given a prompt, prints the prompt as a 
 * question requiring an answer beginning with a 'y' or 'n' (any case) and returns the 
 * user's input.
 */
(deffunction askAnimal (?prompt)
   (bind ?response (upcase (ask (str-cat ?prompt " (Y/N) "))))
   (while (and (<> (sub-string 1 1 ?response) y) (<> (sub-string 1 1 ?response) Y) (<> (sub-string 1 1 ?response) n) (<> (sub-string 1 1 ?response) N))
      (bind ?response (upcase (ask "Please enter a valid input. (Y/N) ")))
   )
   (return (sub-string 1 1 ?response))
)

/*
 * Defines the toString function, which given a number, returns the number in string form.
 */
(deffunction toString (?num)
   (bind ?chars (create$ 0 1 2 3 4 5 6 7 8 9))
   (bind ?res "")
   (bind ?neg FALSE)
   (if (< ?num 0) then                                                                    ;  If negative, make positive for processing and mark as negative.
      (bind ?neg TRUE)
      (bind ?num (- 0 ?num))
   )
   (if (= ?num 0) then                                                                    ;  Special case for 0
      (bind ?res "0")
   )
   (while (> ?num 0)                                                                      ;  Add digits right to left
      (bind ?res (str-cat (nth$ (+ (mod ?num 10) 1) ?chars) ?res))
      (bind ?num (- ?num (mod ?num 10)))
      (bind ?num (/ ?num 10))
   )
   (if (= ?neg TRUE) then                                                                 ;  Add a negative sign if needed
      (bind ?res (str-cat "-" ?res))
   )
   (return ?res)
)