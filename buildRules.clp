/*
 * Authored by Bennett Liu on October 12th, 2018
 * Imports the functions necessary to build the rules for the 20 questions game and calls 
 * the functions needed to set up the game.
 */
 
(batch "20questions/buildCountRules.clp")
(batch "20questions/buildQuestionRules.clp")
(batch "20questions/buildTransRules.clp")
(batch "20questions/buildTryAllRules.clp")

(buildAllCountRules)                                                                      ;  Builds all counting rules
(buildQuestionRule 1)                                                                     ;  Builds initial question rule