/*
 * Authored by Bennett Liu on October 30th, 2018
 * Defines the functions necessary to build the rule to move all potential animals 
 * to the next round.
 */
 
/*
 * Defines the buildTransString function, which given a round, ?charNum and ?ans, generates 
 * the rule to move all current possible animals that match the ?ans at the characteristic 
 * index ?charNum to the next round. If the ?ans is a ?, all animals are advanced.
 * 
 * Below is an example when buildTransString is given round: 2 charNum: 1 ans: Y. Created 
 * using the unmodified Animals.csv file.
 * Note that it only advances round 1 animals with Y or ? in their land slot to round 2.
 *
 * (defrule round1to2
 *   (animal (name ?n) (round ?r &:(= ?r 1)) (Land ?c1 &:(or (= ?c1 Y) (= ?c1 "?"))) (Water ?c2) 
 *   (Legs ?c3) (2Legs ?c4) (4Legs ?c5) (6Limbs ?c6) (8MoreLimbs ?c7) (Herbivore ?c8)  
 *   (Carnivore ?c9) (Fly ?c10) (Mammal ?c11) (Exoskeleton ?c12) (Nocturnal ?c13) (Eggs ?c14)  
 *   (Domesticated ?c15) (Rodent ?c16) (Hairy ?c17) (Work ?c18) (Equine ?c19) (Hooves ?c20)  
 *   (Vertebrate ?c21) (Shear ?c22) (Europe ?c23) (Asia ?c24) (Africa ?c25) (Australia ?c26)  
 *   (Americas ?c27) (NorthAmerica ?c28) (SouthAmerica ?c29) (Baleen ?c30) (2wings ?c31)  
 *   (Grazer ?c32) (Tusks ?c33) (Brain ?c34) (Pet ?c35) (Primate ?c36) (Bovine ?c37) (Tree ?c38)  
 *   (Blowhole ?c39) (Hump ?c40) (EatInsect ?c41) (Feline ?c42) (Eusocial ?c43) (Spotted ?c44)  
 *   (Striped ?c45) (Arctic ?c46) (Pacific ?c47) (Atlantic ?c48) (Freshwater ?c49) (Social ?c50)  
 *   (Horns ?c51) (Canine ?c52) (Tunneling ?c53) (Smell ?c54) (Spiny ?c55) (Bird ?c56) (Elytra ?c57)  
 *   (FastestLand ?c58) (Jump ?c59) (Proboscis ?c60))
 *   =>
 *   (++ ?*POSSIBILITIES*)(assert (animal (name ?n) (round 2) (Land ?c1) (Water ?c2) (Legs ?c3)  
 *   (2Legs ?c4) (4Legs ?c5) (6Limbs ?c6) (8MoreLimbs ?c7) (Herbivore ?c8) (Carnivore ?c9)  
 *   (Fly ?c10) (Mammal ?c11) (Exoskeleton ?c12) (Nocturnal ?c13) (Eggs ?c14) (Domesticated ?c15)  
 *   (Rodent ?c16) (Hairy ?c17) (Work ?c18) (Equine ?c19) (Hooves ?c20) (Vertebrate ?c21)  
 *   (Shear ?c22) (Europe ?c23) (Asia ?c24) (Africa ?c25) (Australia ?c26) (Americas ?c27)  
 *   (NorthAmerica ?c28) (SouthAmerica ?c29) (Baleen ?c30) (2wings ?c31) (Grazer ?c32) (Tusks ?c33)  
 *   (Brain ?c34) (Pet ?c35) (Primate ?c36) (Bovine ?c37) (Tree ?c38) (Blowhole ?c39) (Hump ?c40)  
 *   (EatInsect ?c41) (Feline ?c42) (Eusocial ?c43) (Spotted ?c44) (Striped ?c45) (Arctic ?c46)  
 *   (Pacific ?c47) (Atlantic ?c48) (Freshwater ?c49) (Social ?c50) (Horns ?c51) (Canine ?c52)  
 *   (Tunneling ?c53) (Smell ?c54) (Spiny ?c55) (Bird ?c56) (Elytra ?c57) (FastestLand ?c58)  
 *   (Jump ?c59) (Proboscis ?c60)))
 *)
 *
 * Below is another example when buildTransString is given round: 2 charNum: 1 ans: ?. Created 
 * using the unmodified Animals.csv file.
 * Note that it advances all round 1 animals to round 2.
 *
 * (defrule round1to2
 *   (animal (name ?n) (round ?r &:(= ?r 1)) (Land ?c1) (Water ?c2) (Legs ?c3) (2Legs ?c4)  
 *   (4Legs ?c5) (6Limbs ?c6) (8MoreLimbs ?c7) (Herbivore ?c8) (Carnivore ?c9) (Fly ?c10)  
 *   (Mammal ?c11) (Exoskeleton ?c12) (Nocturnal ?c13) (Eggs ?c14) (Domesticated ?c15) (Rodent ?c16)  
 *   (Hairy ?c17) (Work ?c18) (Equine ?c19) (Hooves ?c20) (Vertebrate ?c21) (Shear ?c22)  
 *   (Europe ?c23) (Asia ?c24) (Africa ?c25) (Australia ?c26) (Americas ?c27) (NorthAmerica ?c28)  
 *   (SouthAmerica ?c29) (Baleen ?c30) (2wings ?c31) (Grazer ?c32) (Tusks ?c33) (Brain ?c34)  
 *   (Pet ?c35) (Primate ?c36) (Bovine ?c37) (Tree ?c38) (Blowhole ?c39) (Hump ?c40) (EatInsect ?c41)  
 *   (Feline ?c42) (Eusocial ?c43) (Spotted ?c44) (Striped ?c45) (Arctic ?c46) (Pacific ?c47)  
 *   (Atlantic ?c48) (Freshwater ?c49) (Social ?c50) (Horns ?c51) (Canine ?c52) (Tunneling ?c53)  
 *   (Smell ?c54) (Spiny ?c55) (Bird ?c56) (Elytra ?c57) (FastestLand ?c58) (Jump ?c59) (Proboscis ?c60))
 *   =>
 *   (++ ?*POSSIBILITIES*)(assert (animal (name ?n) (round 2) (Land ?c1) (Water ?c2) (Legs ?c3)  
 *   (2Legs ?c4) (4Legs ?c5) (6Limbs ?c6) (8MoreLimbs ?c7) (Herbivore ?c8) (Carnivore ?c9)  
 *   (Fly ?c10) (Mammal ?c11) (Exoskeleton ?c12) (Nocturnal ?c13) (Eggs ?c14) (Domesticated ?c15)  
 *   (Rodent ?c16) (Hairy ?c17) (Work ?c18) (Equine ?c19) (Hooves ?c20) (Vertebrate ?c21)  
 *   (Shear ?c22) (Europe ?c23) (Asia ?c24) (Africa ?c25) (Australia ?c26) (Americas ?c27)  
 *   (NorthAmerica ?c28) (SouthAmerica ?c29) (Baleen ?c30) (2wings ?c31) (Grazer ?c32) (Tusks ?c33)  
 *   (Brain ?c34) (Pet ?c35) (Primate ?c36) (Bovine ?c37) (Tree ?c38) (Blowhole ?c39) (Hump ?c40)  
 *   (EatInsect ?c41) (Feline ?c42) (Eusocial ?c43) (Spotted ?c44) (Striped ?c45) (Arctic ?c46)  
 *   (Pacific ?c47) (Atlantic ?c48) (Freshwater ?c49) (Social ?c50) (Horns ?c51) (Canine ?c52)  
 *   (Tunneling ?c53) (Smell ?c54) (Spiny ?c55) (Bird ?c56) (Elytra ?c57) (FastestLand ?c58)  
 *   (Jump ?c59) (Proboscis ?c60)))
 *)
 */
(deffunction buildTransString (?round ?charNum ?ans)
   (bind ?ruleString (str-cat "(defrule round" (toString (- ?round 1)) "to" (toString ?round 1) "
   "))                                                                                    ;  Name rule
   
   (bind ?ruleString (str-cat ?ruleString "(animal (name ?n) (round ?r &:(= ?r " (toString (- ?round 1)) "))"))
   
   (for (bind ?i 1) (<= ?i (length$ ?*CHARACTERISTICS*)) (++ ?i)
      (bind ?ruleString (str-cat ?ruleString " (" (nth$ ?i ?*CHARACTERISTICS*) " ?c" (toString ?i)))
      (if (and (<> ?ans "?") (= ?i ?charNum)) then
         (bind ?ruleString (str-cat ?ruleString " &:(or (= ?c" (toString ?i) " " ?ans ") (= ?c" (toString ?i) " \"?\"))"))
      )
      (bind ?ruleString (str-cat ?ruleString ")"))
   )
   (bind ?ruleString (str-cat ?ruleString ")
   "))
   
   (bind ?ruleString (str-cat ?ruleString "=>
   (++ ?*POSSIBILITIES*)"))
   
   (bind ?ruleString (str-cat ?ruleString "(assert (animal (name ?n) (round " (toString ?round) ")"))
   (for (bind ?i 1) (<= ?i (length$ ?*CHARACTERISTICS*)) (++ ?i)
      (bind ?ruleString (str-cat ?ruleString " (" (nth$ ?i ?*CHARACTERISTICS*) " ?c" (toString ?i) ")"))
   )
   (bind ?ruleString (str-cat ?ruleString "))
)"))
   (return ?ruleString)
)

/*
 * Defines the buildTransString function, which given a round, ?charNum and ?ans, builds 
 * the rule to move all current possible animals that match the ?ans at the characteristic 
 * index ?charNum to the next round.
 */
(deffunction buildTransRule (?round ?charNum ?ans)
   (build (buildTransString ?round ?charNum ?ans))
   (return)
)