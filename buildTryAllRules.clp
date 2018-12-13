/*
 * Authored by Bennett Liu on October 30th, 2018
 * Defines the functions necessary to build the rule to check all remaining possible animals
 */
 
/*
 * Defines the buildTryAllString function, which given a round, generates the rule string 
 * to ask the user if their animal is any of the animals in that round.
 * 
 * Below is an example when buildTryAllString is given round: 5. 
 * 
 * (defrule tryAll
 *   (animal (name ?n) (round ?r &:(= ?r 5)))
 *   (not (finished))
 *   =>
 *   (if (and (<= ?*QUESTION* ?*QUESTIONCAP*) (= (askAnimal (str-cat \"Question #\" (toString ?*QUESTION*) \": Is it a/n \" ?n \"?\")) Y)) then
 *      (assert (finished))
 *   )
 *   (bind ?*QUESTION* (+ ?*QUESTION* 1))
 *)
 */
(deffunction buildTryAllString (?round)
   (bind ?ruleString (str-cat "(defrule tryAll
   (animal (name ?n) (round ?r &:(= ?r " ?round ")))
   (not (finished))
   =>
   (if (and (<= ?*QUESTION* ?*QUESTIONCAP*) (= (askAnimal (str-cat \"Question #\" (toString ?*QUESTION*) \": Is it a/n \" ?n \"?\")) Y)) then
      (assert (finished))
   )
   (bind ?*QUESTION* (+ ?*QUESTION* 1))
)"))
   (return ?ruleString)
)

/*
 * Defines the buildTryAllRule function, which given a round, builds the rule 
 * to ask the user if their animal is any of the remaining possible animals.
 */
(deffunction buildTryAllRule (?round)
   (build (buildTryAllString ?round))
   (return)
)