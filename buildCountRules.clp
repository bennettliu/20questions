/*
 * Authored by Bennett Liu on October 30th, 2018
 * Defines the functions necessary to build rules for counting yes's and no's for each characteristic
 */
 
/*
 * Defines the buildYCountString function, which given an index, generates the rule string 
 * to count the Y and ? for the characteristic indicated at that index in the global 
 * ?*CHARACTERISTICS* array.
 * 
 * Below is an example when 1 is entered with the index 1 characteristic as Land
 *
 * (defrule countLandY
 *   (animal (Land ?c &:(or (= ?c Y) (= ?c "?"))))
 *   =>
 *   (bind ?*YES* (replace$ ?*YES* 1 1 (create$ (+ (nth$ 1 ?*YES*) 1))))
 *) 
 */
(deffunction buildYCountString (?index)
   (bind ?ruleString (str-cat "(defrule count" (nth$ ?index ?*CHARACTERISTICS*) "Y
   (animal (" (nth$ ?index ?*CHARACTERISTICS*) " ?c &:(or (= ?c Y) (= ?c \"?\"))))
   =>
   (bind ?*YES* (replace$ ?*YES* " ?index " " ?index " (create$ (+ (nth$ " ?index " ?*YES*) 1))))
)"))
   (return ?ruleString)
)

/*
 * Defines the buildYCountRule function, which given an index, builds the rule to count the 
 * Y and ? for the characteristic indicated at that index in the global ?*CHARACTERISTICS* array.
 */
(deffunction buildYCountRule (?index)
   (build (buildYCountString ?index))
   (return)
)

/*
 * Defines the buildNCountString function, which given an index, generates the rule string 
 * to count the N and ? for the characteristic indicated at that index in the global 
 * ?*CHARACTERISTICS* array.
 * 
 * Below is an example when 1 is entered with the index 1 characteristic as Land
 * (defrule countLandN
 *   (animal (Land ?c &:(or (= ?c N) (= ?c \"?\"))))
 *   =>
 *   (bind ?*NO* (replace$ ?*NO* 1 1 (create$ (+ (nth$ 1 ?*NO*) 1))))
 *)
 */
(deffunction buildNCountString (?index)
   (bind ?ruleString (str-cat "(defrule count" (nth$ ?index ?*CHARACTERISTICS*) "N
   (animal (" (nth$ ?index ?*CHARACTERISTICS*) " ?c &:(or (= ?c N) (= ?c \"?\"))))
   =>
   (bind ?*NO* (replace$ ?*NO* " ?index " " ?index " (create$ (+ (nth$ " ?index " ?*NO*) 1))))
)"))
   (return ?ruleString)
)

/*
 * Defines the buildNCountRule function, which given an index, builds the rule to count the 
 * N and ? for the characteristic indicated at that index in the global ?*CHARACTERISTICS* array.
 */
(deffunction buildNCountRule (?index)
   (build (buildNCountString ?index))
   (return)
)

/*
 * Defines the buildCountRules function, which given an index, builds the two rules built by 
 * the functions buildYCountRule and buildNCountRule.
 */
(deffunction buildCountRules (?index)
   (buildYCountRule ?index)
   (buildNCountRule ?index)
   (return)
)

/*
 * Defines the buildAllCountRules function, which builds the two rules built by 
 * the functions buildYCountRule and buildNCountRule for all characteristics.
 */
(deffunction buildAllCountRules ()
   (for (bind ?i 1) (<= ?i (length$ ?*CHARACTERISTICS*)) (++ ?i)
      (buildCountRules ?i)
   )
   (return)
)