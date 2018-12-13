/*
 * Authored by Bennett Liu on October 30th, 2018
 * Defines the functions necessary to build the rule to ask the question that optimally 
 * divides all remaining possible animals.
 */
 
/*
 * Defines the buildQuestionString function, which given a round, generates the rule string 
 * to ask the question that optimally divides all remaining possible animals. This is done 
 * by finding the characteristic that minimizes the value max((Y+?) (N+?)). If this 
 * characteristic is able to eliminate any current possibility and it is not at the last 
 * question, it asks about that characteristic. Otherwise, it builds the TryAllRule to 
 * try all remaining animals until the question cap has been reached. Has negative salience 
 * to allow all countRules to run in time.
 * 
 * Below is an example when 1 is entered as the round
 *
 *(defrule question1(declare (salience -100))
 *   =>
 *   (bind ?least ?*POSSIBILITIES*)
 *   (bind ?leastDex -1)
 *   (for (bind ?i 1) (<= ?i (length$ ?*CHARACTERISTICS*)) (++ ?i)
 *      (if (and (= (nth$ ?i ?*ASKED*) FALSE) (< (nth$ ?i ?*NO*) ?least) (< (nth$ ?i ?*YES*) ?least)) then 
 *         (if (< (nth$ ?i ?*NO*) (nth$ ?i ?*YES*)) then
 *            (bind ?least (nth$ ?i ?*YES*))
 *         else
 *            (bind ?least (nth$ ?i ?*NO*))
 *         )
 *         (bind ?leastDex ?i)
 *      )
 *      (bind ?*NO* (replace$ ?*NO* ?i ?i (create$ 0)))
 *      (bind ?*YES* (replace$ ?*YES* ?i ?i (create$ 0)))
 *   )
 *   (if (and (<> ?leastDex -1) (< ?*QUESTION* ?*QUESTIONCAP*)) then
 *      (bind ?response (askCharacteristic (str-cat \"Question #\" (toString ?*QUESTION*) \": \" (nth$ ?leastDex ?*QUESTIONS*))))
 *      (bind ?*QUESTION* (+ ?*QUESTION* 1))
 *      (bind ?*ASKED* (replace$ ?*ASKED* ?leastDex ?leastDex (create$ TRUE)))
 *      (buildTransRule 2 ?leastDex ?response)
 *      (buildQuestionRule 2)
 *      (bind ?*POSSIBILITIES* 0)
 *   else 
 *      (buildTryAllRule 1)
 *   )
 *)
 */
(deffunction buildQuestionString (?round)
   (bind ?ruleString (str-cat "(defrule question" (toString ?round) "(declare (salience -100))
   =>
   (bind ?least ?*POSSIBILITIES*)
   (bind ?leastDex -1)
   (for (bind ?i 1) (<= ?i (length$ ?*CHARACTERISTICS*)) (++ ?i)
      (if (and (= (nth$ ?i ?*ASKED*) FALSE) (< (nth$ ?i ?*NO*) ?least) (< (nth$ ?i ?*YES*) ?least)) then 
         (if (< (nth$ ?i ?*NO*) (nth$ ?i ?*YES*)) then
            (bind ?least (nth$ ?i ?*YES*))
         else
            (bind ?least (nth$ ?i ?*NO*))
         )
         (bind ?leastDex ?i)
      )
      (bind ?*NO* (replace$ ?*NO* ?i ?i (create$ 0)))
      (bind ?*YES* (replace$ ?*YES* ?i ?i (create$ 0)))
   )
   (if (and (<> ?leastDex -1) (< ?*QUESTION* ?*QUESTIONCAP*)) then
      (bind ?response (askCharacteristic (str-cat \"Question #\" (toString ?*QUESTION*) \": \" (nth$ ?leastDex ?*QUESTIONS*))))
      (bind ?*QUESTION* (+ ?*QUESTION* 1))
      (bind ?*ASKED* (replace$ ?*ASKED* ?leastDex ?leastDex (create$ TRUE)))
      (buildTransRule " (toString (+ ?round 1)) " ?leastDex ?response)
      (buildQuestionRule " (+ ?round 1) ")
      (bind ?*POSSIBILITIES* 0)
   else 
      (buildTryAllRule " ?round ")
   )
)"))
   (return ?ruleString)
)

/*
 * Defines the buildQuestionRule function, which given a round, builds the rule string 
 * to ask the question that optimally divides all remaining possible animals.
 */
(deffunction buildQuestionRule (?round)
   (build (buildQuestionString ?round))
   (return)
)