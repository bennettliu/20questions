/*
 * Authored by Bennett Liu on October 12th, 2018
 * Imports the functions and rules necessary to run the 20 questions game. Defines the 
 * rules for 20 questions game start-up and end-game.
 * 
 * Uses rules in buildRules.clp, which use data defined in config.clp to count yes's and no's 
 * (defined in buildCountRules.clp), then runs the current question rule (defined in buildQuestionRules.clp), 
 * which determines the optimal questions to ask, then uses a transition rule (defined in buildTransRules.clp)
 * to advance all animals that match the question's answer to the next round, where the process 
 * is repeated on the reduced set of animals. When a single animal remains or no further 
 * data can be used to narrow down the set of animals, ask all remaining animals.
 */
 
(clear)(reset)
(batch "20questions/toolbox.clp")
(batch "20questions/config.clp")
(batch "20questions/buildRules.clp")

/*
 * Defines the startup rule, the first rule to fire, which prints an introductory message 
 * explaining the game.
 */
(defrule startup "Prints intro message"
   (declare (salience 100))
   =>
   (log (str-cat "You are playing " (toString ?*QUESTIONCAP*) " questions."))
   (log (str-cat "Think of an animal and I will try to guess it using " (toString ?*QUESTIONCAP*) " or fewer questions.")) 
   (log "")
)

/*
 * Defines the guessed rule, which fires if the game is finished, in which case it prints 
 * a celebratory message.
 */
(defrule guessed "Prints celebratory message"
   (declare (salience -1000))
   (finished)
   =>
   (log "Yay, I guessed your animal!")
)

/*
 * Defines the unable rule, which fires if the game is finished, in which case it 
 * determines whether it ran out of questions or is unable to determine the animal and 
 * prints a message accordingly.
 */
(defrule unable "Prints defeat message"
   (declare (salience -1000))
   (not (finished))
   =>
   (if (> ?*QUESTION* ?*QUESTIONCAP*) then
      (log "I ran out of questions!")
   else
      (log "I give up!")
   )
)

(run)