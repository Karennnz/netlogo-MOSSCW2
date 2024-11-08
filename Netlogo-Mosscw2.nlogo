;;;;;; Agent Based Model of Food Choice Behaviour in the Context of British Milk Consumption ;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;; Agent's and global variables ;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; attributes and model variables of each agent
turtles-own [
  ;mean values for the perceived characteristics, on a relative basis, of the milk choices

  incum-physical-mean
  incum-health-mean
  incum-env-mean
  alt-physical-mean
  alt-health-mean
  alt-env-mean

  ;milk choice characteristics perceived by agents, drawn from a normal distribution with mean values as above
  pphincum
  pinincum
  pexincum
  pphalt
  pinalt
  pexalt

  ;agent memory containing list of length determined by the memory-length parameter of the perceived charactersitics of each milk choice over time
  mem-incum-ph
  mem-alt-ph
  mem-incum-in
  mem-alt-in
  mem-incum-ex
  mem-alt-ex
  mem-ts

  ;values in the agent memory are averaged giving agent a single perception value for each milk choice and charactersitic
  mem-ph-incum-avg
  mem-ph-alt-avg
  mem-in-incum-avg
  mem-in-alt-avg
  mem-ex-incum-avg
  mem-ex-alt-avg

  ;the weighting applied to each of the three perception components - physcial charactersitics, health impact, environmental impact - in an agent's choice function
  ph-weight
  in-weight
  ex-weight
  ph-weight-raw
  in-weight-raw
  ex-weight-raw
  weights-raw

  ; choice functions for each milk option
  uf-incum
  uf-alt
  new-uf-incum
  new-uf-alt

  disposition-threshold             ;only for threshold-based model variant - float value between 0 and 1, above which an agent becomes disposed to consider its alternatives
  disposition                       ;float value between 0 and 1 of agent's disposition to consider its milk choice
  disposition-piqued?               ;binary TRUE or FALSE of whether agent disposition has been triggered or not
  f-red                             ;number of neighbours that consume mainly whole milk
  f-green                           ;number of neighbours that consume mainly skimmed/semi-skimmed milk
  f-all                             ;total number of neighbours
  h-entropy                         ;informational entropy of distribution of neighbours milk choice
  h-max                             ;maximum informational entropy of distribution of neighbours milk choice
  prob-disposition                  ;only or probability-based model variant - probability that an agent will become disposed to consider milk choices

  num-conseq-same-choice            ;number of consecutive same milk choices
  habit?                            ;variable to indicate whether habit function has been triggered
  habit-factor-incum                ;the factor applied to the whole milk choice function
  habit-factor-alt                  ;the factor applied to the skimmed and semi-skimmed milk choice function
  last-choice                       ;previous milk choice
  food-choice                       ;new milk choice
  habit-function                    ;choice function including the cognitve/perception score and habit factor

  conformity                        ;flat between 0 and 1 of degree to which agent conforms to the public concerns on health and environment
  incum-quantity                    ;amount in ml of weekly consumption of whole milk
  alt-quantity                      ;amount in ml of weekly consumption of skimmed and semi-skimmed milk
  prior-quantity-incum              ;amount in ml of weekly consumption of whole milk of previous time-step
  prior-quantity-alt                ;amount in ml of weekly consumption of skimmed and semi-skimmed milk of previous time-step
  choice-history                    ;agent record of previous choices
  incum-history                     ;agent record of previous whole milk choices
  alt-history                       ;agent record of previous skimmed/semi-skimmed choices

  sugar-imp                         ;weighted average amount of sugar from the combination of milk choice quantities
  satfat-imp                        ;weighted average amount of saturated fat from the combination of milk choice quantities
  protein-imp                       ;weighted average amount of protein from the combination of milk choice quantities
  co2-imp                           ;weighted average amount of CO2 from the combination of milk choice quantities
  land-imp                          ;weighted average amount of land requirement from the combination of milk choice quantities
  water-imp                         ;weighted average amount of water from the combination of milk choice quantities
  universalism                      ;integer between 0 and 6 for agent's score for basic human universalism value
  security                          ;integer between 0 and 6 for agent's score for basic human security value
  universalism-value                ;float between 0 and 1 for agent's score for basic human universalism value
  security-value                    ;float between 0 and 1 for agent's score for basic human security value
  openness                          ;integer between 0 and 6 for agent's score for basic human value associated with openness
  choice-value-health               ;float between 0 and 1 for the relative health impact of agent milk consumption choices
  choice-value-env                  ;float between 0 and 1 for the relative environmental impact of agent milk consumption choices
  choice-function-deviation         ;percentage difference between the maximum and minimum choice function scores
  value-health-deviation            ;the absolute difference between the held values of the agents, and the implied values by way of their choices
  value-env-deviation               ;the absolute difference between the held values of the agents, and the implied values by way of their choices
  cognitive-dissonance?             ;indicator for if agent is in a state of cognitive dissonance
  disposition-probability-gradient] ;only for probabilty-based disposition approach - the gradient, k, of the logisitic function governing the probability that an agent will become disposed to consider its milk consumption choices

;Global variables to run the model
globals [
  number-of-agents                  ;number of agents
  norm-data                         ;public concern data informed from Ipsos Mori and YouGov longitudinal survey data on concerns of the British public
  value-data                        ;data drawn from the UK results of three questions (assessing universalism, security, and openness) of the Human Values section of the European Social Survey 2018
  total-average-milk                ;
  min-unit                          ;the minimum allowable consumption of either milk choice, set at 1 pint (568ml)
  mean-incum                        ;main model output that measures the average whole milk consumption among agents
  mean-alt                          ;main model output that measures the average skimmed/semi-skimmed milk consumption among agents
  incum-total-try                   ;total instances of whole milk chosen by agents
  alt-total-try                     ;total instances of skimmed/semi-skimmed milk chosen by agents
  choice-total                      ;total choice made by agents

  ;variables governing the different health and environmental impacts associated with the milk choice
  sugar-list
  satfat-list
  protein-list
  co2-list
  land-list
  water-list
  sugar-realtive
  satfat-relative
  protein-relative
  co2-relative
  land-relative
  water-relative
  choice-health-sums
  choice-env-sums
  health-diff
  env-diff

  habit-on?                         ;habit function
  networks                          ;network function
  network-type                      ;type of network
  norms                             ;norms function
  counter]                          ;choice counter

; netlogo extension used in the model
extensions [
  csv ; reads csv files of data.
  nw  ; the network extension is used in this model.
  profiler]; assess model execution time

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;SETUP PROCEDURE;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to setup
  clear-all
  set number-of-agents 1000
  set mean-incum 2654.81             ;initialise average liquid wholemilk consumption per person per week (ml)
  set mean-alt 5.29                  ;initialise average skimmed (semi and full) consumption per person per week (ml)
  set habit-on? TRUE                 ;habit function
  set networks TRUE                  ;network function
  set network-type "watts-strogatz"  ;type of network
  set norms TRUE                     ;norm function
  ifelse networks = TRUE             ;creates a social network if networks is TRUE. Otherwise just creates a set of unconnected turtles.
    [create-network]
    [create-agents]
  setup-turtles
  setup-patches
  load-value-data                    ;loads 'Human value data' from UK response of ESS 2018
  assign-value-data                  ;agents are assigned values based on distribution from the ESS 2018 survey data
  file-close-all
  ;file-open "ewgibson/OneDrive - Imperial College London/PhD/netlogodata_downsampled.csv/Users/matth"             ;downsampled annual data on UK public concerns of economy, health, and environment - aggregated from Ipsos Mori Issues Index and YouGov.
  file-open "C:/Users/zheng/Downloads/an-abm-of-historic-british-milk-consumption_v1.0.0/data/netlogodata_downsampled.csv"
  if justification < cognitive-dissonance-threshold
    [ifelse (justification + cognitive-dissonance-threshold) >= 1 [set justification 1] [set justification justification + cognitive-dissonance-threshold]]    ;makes sure that justification parameter is larger than cognitive-dissonance-threshold parameter during the optimisation exercise
  set network-parameter round network-parameter
  if remainder network-parameter 2 != 0 [set network-parameter network-parameter + 1] ;constrain agent neighbours to an even number
  impact-metrics
  reset-ticks
end

to setup-turtles
  foreach (list turtles) [[x] -> ask x [

  ;mean values as inputs to normal distribution to drawn values of milk charactersitics perceived by agents
  set incum-physical-mean 1
  set incum-health-mean 1
  set incum-env-mean 1
  set alt-physical-mean 1             ;for this part of the model, in comparing the development of skimmed versus whole milk, the physcial characterisitics of the alternative (skimmed/semi-skimmed) were fixed at 1 to explore the range of possible values taken by health and environmental perception.
  set alt-health-mean alt-health-mean-initial
  set alt-env-mean alt-env-mean-initial

  ;operating memory of agent's perception of milk choice characteristics
  set mem-incum-ph (list)
  set mem-alt-ph (list)
  set mem-incum-in (list)
  set mem-alt-in (list)
  set mem-incum-ex (list)
  set mem-alt-ex (list)
  set mem-ts (list)

  set last-choice color
  set food-choice color
  set disposition-piqued? FALSE
  set cognitive-dissonance? FALSE
  set habit? FALSE
  set habit-factor-incum 1
  set habit-factor-alt 1
  set num-conseq-same-choice incumbent-initial-habit    ;sets agent's consecutive prior choice equal to the incumbent-initial-habit parameter

  ;initital weighting of the three milk charactersitics perception components
  set ph-weight-raw random-float 1
  set in-weight-raw random-float 1
  set ex-weight-raw random-float 1

  ;initialise average liquid milk consumption per person per week (ml)
  set incum-quantity 2654.81
  set alt-quantity 5.29
  ]]

  ask turtles [set color red]
  agent-conformity                     ;runs the agent conformity function
end

to setup-patches
  ask patches [set pcolor blue]
  reset-ticks
end

to load-value-data
  ;this creates a distribution of values among the agents according to the ESS 2018 survey for the UK.
  ifelse (file-exists? "C:/Users/zheng/Downloads/an-abm-of-historic-british-milk-consumption_v1.0.0/data/netlogovaluedata.csv")
    [set value-data []
      ;"C:\Users\zheng\Downloads\an-abm-of-historic-british-milk-consumption_v1.0.0\data\netlogovaluedata.csv"
    set value-data (csv:from-file "C:/Users/zheng/Downloads/an-abm-of-historic-british-milk-consumption_v1.0.0/data/netlogovaluedata.csv")
    user-message "File loading complete!"
    file-close]
    [user-message "There is no netlogovaluedata.csv file in current directory!"]
end

to assign-value-data
  ;UK responses from three survey question from the European Social Survey (ESS) 2018 were selected that refer to one of three basic human values employed here: universalism, security, and openess.
  ;Universalism linked to pro-environmental and social attitudes and behaviours and used in the context of choice evaluation of environmental impacts
  ;Health falls within the Security basic human value. Used in context of choice evaluation of health impacts.
  ;Openness value used to set the disposition threshold of agents, above which they decide to consider alternatives.
  ifelse (is-list? value-data)
    [foreach value-data [four-tuple -> ask turtle item 1 four-tuple [set universalism item 2 four-tuple set security item 3 four-tuple set openness item 4 four-tuple]]]
    [user-message "You need to load in value data first!"]

  ;ESS value data given as 6-point Likert scale responses from "very much..." to "not at all...".
  ;These are operationalised for modelling purposes as a linear band with each point on the
  ;Likert-scale corresponding to 1/6 of the possible range of outputs from 0 to 1.
  ask turtles [
    if universalism = 0 [set universalism-value random-float 1]
    if universalism = 1 [set universalism-value ((5 / 6) + random-float (1 / 6))]
    if universalism = 2 [set universalism-value ((4 / 6) + random-float (1 / 6))]
    if universalism = 3 [set universalism-value ((3 / 6) + random-float (1 / 6))]
    if universalism = 4 [set universalism-value ((2 / 6) + random-float (1 / 6))]
    if universalism = 5 [set universalism-value ((1 / 6) + random-float (1 / 6))]
    if universalism = 6 [set universalism-value (0 + random-float (1 / 6))]

    if security = 0 [set security-value random-float 1]
    if security = 1 [set security-value ((5 / 6) + random-float (1 / 6))]
    if security = 2 [set security-value ((4 / 6) + random-float (1 / 6))]
    if security = 3 [set security-value ((3 / 6) + random-float (1 / 6))]
    if security = 4 [set security-value ((2 / 6) + random-float (1 / 6))]
    if security = 5 [set security-value ((1 / 6) + random-float (1 / 6))]
    if security = 6 [set security-value (0 + random-float (1 / 6))]

    if openness = 0 [set openness random-float 1]
    if openness = 6 [set disposition-threshold ((5 / 6) + random-float (1 / 6))]
    if openness = 5 [set disposition-threshold ((4 / 6) + random-float (1 / 6))]
    if openness = 4 [set disposition-threshold ((3 / 6) + random-float (1 / 6))]
    if openness = 3 [set disposition-threshold ((2 / 6) + random-float (1 / 6))]
    if openness = 2 [set disposition-threshold ((1 / 6) + random-float (1 / 6))]
    if openness = 1 [set disposition-threshold (0 + random-float (1 / 6))]]
end

to create-network
  if network-type = "watts-strogatz" [;ceates a Watts-Strogatz small-world network
    nw:generate-watts-strogatz turtles links number-of-agents network-parameter 0.1 [ fd 10 ]
    ask turtles [layout-spring turtles links 0.2 4.0 500]
  ]
end

to create-agents ;creates number-of-agents turtles if networks is FALSE (i.e., in case the model has no social networks).
  create-turtles number-of-agents
  [setxy random-xcor random-ycor]
end



to agent-conformity
  ; function to assign agent conformity, selected from a normal distribution with the mean equal to the social-conformity parameter
  if norms = TRUE [
    ask turtles [
      let mmin -1
      let mmax 1
      set conformity random-normal social-conformity 0.4
      if conformity < mmin or conformity > mmax
        [set conformity random-normal social-conformity 0.4]]
  ]
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;; GO PROCEDURE ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


to go
  ;profiler:start
  if ticks >= 32 [stop]
  if file-at-end? [stop]
  set norm-data (csv:from-row file-read-line ",")
  set total-average-milk item 5 norm-data
  vary-info
  memory-fill
  memory-delete
  disposition-function
  cognitive-function
  social-influence
  habit-activation
  make-choice
  habit-formation
  prior-choice
  social-norms
  average-consumption
  ever-tried
  impact-tracker
  choice-evaluation
  prior-milk-amount
  ;if ticks >= 32 [profiler:stop]
  tick
end

to vary-info
  ;this function varies the information on milk characteristics perceived by agents
  ask turtles [
    if random-float 1 >= social-blindness and random-float 1 > 0.1 and ticks > 1 [
      if alt-quantity = 0 [
        ifelse (incum-health-mean / alt-health-mean) > 1000000
          [set alt-health-mean (alt-health-mean + (alt-health-mean * 0.05))] ;increases alt-health-mean by 5%
          [set alt-health-mean (alt-health-mean - (alt-health-mean * 0.05))] ;decreases alt-health-mean by 5%

        ifelse (incum-env-mean / alt-env-mean) > 1000000
          [set alt-env-mean (alt-env-mean + (alt-env-mean * 0.05))] ;increases alt-env-mean by 5%
          [set alt-env-mean (alt-env-mean - (alt-env-mean * 0.05))]] ;decreases alt-env-mean by 5%

      if incum-quantity = 0 [
        ifelse (incum-health-mean / alt-health-mean) > 0
          [set alt-health-mean (alt-health-mean + (alt-health-mean * 0.05))] ;increases alt-health-mean by 5%
          [set alt-health-mean (alt-health-mean - (alt-health-mean * 0.05))] ;decreases alt-health-mean by 5%

        ifelse (incum-env-mean / alt-env-mean) > 0
          [set alt-env-mean (alt-env-mean + (alt-env-mean * 0.05))] ;increases alt-env-mean by 5%
          [set alt-env-mean (alt-env-mean - (alt-env-mean * 0.05))] ;decreases alt-env-mean by 5%

      if incum-quantity != 0 and alt-quantity != 0 [
        ifelse (incum-health-mean / alt-health-mean) > ((incum-quantity * item 0 choice-health-sums) / (alt-quantity * item 1 choice-health-sums))
          [set alt-health-mean (alt-health-mean + (alt-health-mean * 0.05))] ;increases alt-health-mean by 5%
          [set alt-health-mean (alt-health-mean - (alt-health-mean * 0.05))] ;decreases alt-health-mean by 5%

        ifelse (incum-env-mean / alt-env-mean) > ((incum-quantity * item 0 choice-env-sums) / (alt-quantity * item 1 choice-env-sums))
          [set alt-env-mean (alt-env-mean + (alt-env-mean * 0.05))] ;increases alt-env-mean by 5%
          [set alt-env-mean (alt-env-mean - (alt-env-mean * 0.05))] ;decreases alt-env-mean by 5%
  ]]]

      let mmin 0.1

      set pphincum random-normal incum-physical-mean 0.1
      set pinincum random-normal incum-health-mean 0.1
      set pexincum random-normal incum-env-mean 0.1

      set pphalt random-normal alt-physical-mean 0.1
      set pinalt random-normal alt-health-mean 0.1
      set pexalt random-normal alt-env-mean 0.1

      while [pphincum <= mmin] [set pphincum random-normal incum-physical-mean 0.1]
      while [pinincum <= mmin] [set pinincum random-normal incum-health-mean 0.1]
      while [pexincum <= mmin] [set pexincum random-normal incum-env-mean 0.1]

      while [pphalt <= mmin] [set pphalt random-normal alt-physical-mean 0.1]
      while [pinalt <= mmin] [set pinalt random-normal alt-health-mean 0.1]
      while [pexalt <= mmin] [set pexalt random-normal alt-env-mean 0.1]
  ]
end

to memory-fill
  ;this function replicates agent memory, creating a list of information perceived by agents at each time step
  ask turtles [
    set mem-incum-ph lput pphincum mem-incum-ph
    set mem-alt-ph lput pphalt mem-alt-ph
    set mem-incum-in lput pinincum mem-incum-in
    set mem-alt-in lput pinalt mem-alt-in
    set mem-incum-ex lput pexincum mem-incum-ex
    set mem-alt-ex lput pexalt mem-alt-ex
    set mem-ts lput ticks mem-ts
  ]
end

to memory-delete
  ;this function replicates the finite nature of memory, capping the size of list containing perceived milk characteristics to equal the memory-lifetime parameter
  ask turtles [
    (foreach mem-incum-ph mem-alt-ph mem-incum-in mem-alt-in mem-incum-ex mem-alt-ex mem-ts
      [if (ticks - (first mem-ts)) >= memory-lifetime [
          let remove-position position first mem-ts mem-ts
          set mem-incum-ph remove-item remove-position mem-incum-ph
          set mem-alt-ph remove-item remove-position mem-alt-ph
          set mem-incum-in remove-item remove-position mem-incum-in
          set mem-alt-in remove-item remove-position mem-alt-in
          set mem-incum-ex remove-item remove-position mem-incum-ex
          set mem-alt-ex remove-item remove-position mem-alt-ex
          set mem-ts remove-item remove-position mem-ts]])
  ]
end

to disposition-function
  ;this function calculates and manages the process of agent disposition in the threshold-based model variant
  ask turtles [
    ifelse (count link-neighbors with [color != red]) = 0
      [set disposition 0]
      [ifelse (count link-neighbors with [color != green]) = 0
        [set disposition 0]
        [set disposition ((count link-neighbors with [color != red]) / (count link-neighbors with [color = red]))]]
    ifelse disposition >= disposition-threshold
      [set disposition-piqued? TRUE]
      [set disposition-piqued? FALSE]

    ;agents can also become disposed to consider alternatives given a state of cognitive dissonance
    if cognitive-dissonance? = TRUE [
    if choice-function-deviation = min(list choice-function-deviation value-health-deviation value-env-deviation)
      [set disposition-piqued? TRUE]]

    ;a small random of agents become spontaneously disposed
    if (disposition-piqued? = FALSE) and (random-float 1 >= .97) [set disposition-piqued? TRUE]
  ]
end

to disposition-function-probability
  ;this function calculates and manages the process of agent disposition in the probability-based model variant
  ask turtles [
    set f-red count link-neighbors with [color = red]
    set f-green count link-neighbors with [color = green]
    set f-all count link-neighbors
    set h-max (2 * (-(1 / 2) * log (1 / 2) 2))

    ifelse ((count link-neighbors with [color != red]) = 0) or ((count link-neighbors with [color != green]) = 0)
      [set h-entropy 0]
      [set h-entropy ((-(f-red / f-all) * log (f-red / f-all) 2) + (-(f-green / f-all) * log (f-green / f-all) 2))]

    set prob-disposition (1 / (1 + exp(- (disposition-probability-gradient) * ((h-entropy / h-max) - 0.5))))

    ifelse random-float 1 <= prob-disposition
      [set disposition-piqued? TRUE]
      [set disposition-piqued? FALSE]

    ;agents can also become disposed to consider alternatives given a state of cognitive dissonance
    if cognitive-dissonance? = TRUE [
    if choice-function-deviation = min(list choice-function-deviation value-health-deviation value-env-deviation)
      [set disposition-piqued? TRUE]]
  ]
end

to cognitive-function
  ;this function generates an agent's base score of the cognitive perception of the milk characterisitcs based on information
  ;it is exposed to, and the weights they ascribe to each of these characteristics
  ask turtles [
    set mem-ph-incum-avg mean mem-incum-ph
    set mem-ph-alt-avg mean mem-alt-ph
    set mem-in-incum-avg mean mem-incum-in
    set mem-in-alt-avg mean mem-alt-in
    set mem-ex-incum-avg mean mem-incum-ex
    set mem-ex-alt-avg mean mem-alt-ex
    set weights-raw (list ph-weight-raw in-weight-raw ex-weight-raw)
    set ph-weight ph-weight-raw / sum weights-raw
    set in-weight in-weight-raw / sum weights-raw
    set ex-weight ex-weight-raw / sum weights-raw
    set uf-incum (ph-weight * mem-ph-incum-avg + in-weight * mem-in-incum-avg + ex-weight * mem-ex-incum-avg)
    set uf-alt (ph-weight * mem-ph-alt-avg + in-weight * mem-in-alt-avg + ex-weight * mem-ex-alt-avg)
  ]
end

to social-influence
  ;this function represents peer influence, modelled by modifying an agent's cognitive milk choice function by the mean value among
  ;its neighbours with the effect size based on the social susceptibility parameter
  if networks = TRUE [
  ask turtles [
    if random-float 1 <= p-interact [
    ifelse count my-links >= 1
      [let ME self
      set new-uf-incum (([uf-incum] of ME) * (1 - social-susceptibility)) + ((sum [uf-incum] of link-neighbors) / (count my-links)) * (social-susceptibility)
      set new-uf-alt (([uf-alt] of ME) * (1 - social-susceptibility)) + ((sum [uf-alt] of link-neighbors) / (count my-links)) * (social-susceptibility)]
      [set new-uf-incum uf-incum
      set new-uf-alt uf-alt]
    set uf-incum new-uf-incum
    set uf-alt new-uf-alt]]
  ]
end

to social-norms
 ;this function represents the effect on how agents weight their cognitive perception by globally perceived public concerns on health and environemtnal issues.
 ;If norms are turned on then agents seek to conform (or not) to the prevailing social norms,
 ;modelled here as exogenous survey data (of issues/puvlic concerns index from Ipsos Mori and YouGov), operationlised as weightings between choice factors
 if norms = TRUE [
 ask turtles [
   let signs [-1 1]
   if ph-weight < item 1 norm-data [set ph-weight ph-weight + conformity / 100]
   if ph-weight > item 1 norm-data [set ph-weight ph-weight - conformity / 100]
   if conformity >= 0 and ph-weight = item 1 norm-data [set ph-weight ph-weight]
   if conformity < 0 and ph-weight = item 1 norm-data [set ph-weight (ph-weight + conformity / 100) * one-of signs]

   if in-weight < item 2 norm-data [set in-weight in-weight + conformity / 100]
   if in-weight > item 2 norm-data [set in-weight in-weight - conformity / 100]
   if conformity >= 0 and in-weight = item 2 norm-data [set in-weight in-weight]
   if conformity < 0 and in-weight = item 2 norm-data [set in-weight (in-weight + conformity / 100) * one-of signs]

   if ex-weight < item 3 norm-data [set ex-weight ex-weight + conformity / 100]
   if ex-weight > item 3 norm-data [set ex-weight ex-weight - conformity / 100]
   if conformity >= 0 and ex-weight = item 3 norm-data [set ex-weight ex-weight]
   if conformity < 0 and ex-weight = item 3 norm-data [set ex-weight (ex-weight + conformity / 100) * one-of signs]

   let weights (list ph-weight in-weight ex-weight)
   set ph-weight ph-weight / sum weights
   set in-weight in-weight / sum weights
   set ex-weight ex-weight / sum weights]
  ]
end

to habit-activation
  ;this function models whether an agent's choice is influenced by habit, and the size of this influence.
  ask turtles [
    let peak-habit 2
    if num-conseq-same-choice >= habit-threshold [set habit? TRUE]
    if habit-on? and habit? [set habit-function TRUE]
    if (habit-function = TRUE) and (food-choice = green)
      [set habit-factor-alt (peak-habit - exp (-0.042 * (num-conseq-same-choice - habit-threshold)))
      set habit-factor-incum 1]
    if (habit-function = TRUE) and (food-choice = red)
      [set habit-factor-incum (peak-habit - exp (-0.042 * (num-conseq-same-choice - habit-threshold)))
      set habit-factor-alt 1]
    if habit-function = FALSE [set habit-factor-incum 1 set habit-factor-alt 1]
  ]
end

to make-choice
  ;this function represents the main decision making function where the cognitive functions of milk choices, modifed by social effects and habit,
  ;are compared and milk consumption is assigned proportionately to the respective size of these scored functions.
  ask turtles [
    ifelse (disposition-piqued? = TRUE) [
      if ((uf-incum * habit-factor-incum) > (uf-alt * habit-factor-alt)) [set color red set food-choice red]
      if ((uf-alt * habit-factor-alt) > (uf-incum * habit-factor-incum)) [set color green set food-choice green]
      set choice-history choice-history + 1
      if food-choice = red [set incum-history incum-history + 1]
      if food-choice = green [set alt-history alt-history + 1]]

      [set color color set food-choice last-choice
      set choice-history choice-history + 1
      if food-choice = red [set incum-history incum-history + 1]
      if food-choice = green [set alt-history alt-history + 1]]

    set min-unit 568 ;ml of 1 British pint

    if (disposition-piqued? = TRUE) and ((uf-incum * habit-factor-incum + uf-alt * habit-factor-alt) != 0) [
      set incum-quantity ((uf-incum * habit-factor-incum) / (uf-incum * habit-factor-incum + uf-alt * habit-factor-alt)) * total-average-milk
      set alt-quantity ((uf-alt * habit-factor-alt) / (uf-incum * habit-factor-incum + uf-alt * habit-factor-alt)) * total-average-milk
    if incum-quantity < min-unit [
      set alt-quantity alt-quantity + incum-quantity
      set incum-quantity 0]
    if alt-quantity < min-unit [
      set incum-quantity incum-quantity + alt-quantity
      set alt-quantity 0]]

    ifelse (disposition-piqued? = FALSE) and ticks > 1[
      set incum-quantity prior-quantity-incum set alt-quantity prior-quantity-alt]
      [set incum-quantity incum-quantity set alt-quantity alt-quantity]
 ]
end

to ever-tried
  ;this function tracks the total number of choices for each milk type
  set incum-total-try sum [incum-history] of turtles
  set alt-total-try sum [alt-history] of turtles
  set choice-total sum [choice-history] of turtles
end

to average-consumption
  ;this function tracks the mean consumption (ml/week) of each milk type across agents
  if ticks < 1 [set mean-incum 2654.81 set mean-alt 5.29]
  if ticks >= 1 [set mean-incum mean [incum-quantity] of turtles set mean-alt mean [alt-quantity] of turtles]
end

to habit-formation
  ;this function tracks the number of consecutive same choices by agents, and informs the habit function
  ask turtles [
  ifelse food-choice = last-choice
    [set num-conseq-same-choice num-conseq-same-choice + 1]
    [set num-conseq-same-choice 0]
  ]
end

to prior-choice
  ;this function manages agent's prior and current choices
  ask turtles [
    if last-choice != food-choice [set counter counter + 1]
    set last-choice food-choice
  ]
end

to prior-milk-amount
  ;this function manages agent's prior and current milk choice quantities
  ask turtles [
    set prior-quantity-incum incum-quantity set prior-quantity-alt alt-quantity
  ]
end

to impact-metrics
  ;this function contains data on health and environmental impact metrics. The first values in each list refer to whole milk, the latter refer to skimmed/semi-skimmed.
  ;Values are per litre. CO2 impact is British Isles (BI) specific and differentiated by whole or semi/skimmed. Land and water are not BI specific or differentiated.
  set sugar-list [49.39 50.62] ;grams
  set satfat-list [19.76 6.61] ;grams
  set protein-list [36.12 37.03] ;grams
  set co2-list [1.30 1.07] ;kgCO2e
  set land-list [9 9] ;m2
  set water-list [628 628] ;litres
  set sugar-realtive [0.98 1.00] ;
  set satfat-relative [1.00 0.33] ;
  set protein-relative [0.98 1.00] ;
  set co2-relative [1.00 0.82] ;
  set land-relative [1.00 1.00] ;
  set water-relative [1.00 1.00] ;
  set choice-health-sums [1.00 0.33] ;note the protein score is subtracted from the health sum as more protein per serving is deemed beneficial
  set choice-env-sums [3.00 2.82] ;
  set health-diff (max(choice-health-sums) - min(choice-health-sums))
  set env-diff (max(choice-env-sums) - min(choice-env-sums))
end

to impact-tracker
  ;this function tracks the overall size of the health and environmental impact based on the quantities of each type of milk consumed by agents.
  ask turtles [
    set sugar-imp ((incum-quantity * item 0 sugar-list) + (alt-quantity * item 1 sugar-list)) / 1000
    set satfat-imp ((incum-quantity * item 0 satfat-list) + (alt-quantity * item 1 satfat-list)) / 1000
    set protein-imp ((incum-quantity * item 0 protein-list) + (alt-quantity * item 1 protein-list)) / 1000
    set co2-imp ((incum-quantity * item 0 co2-list) + (alt-quantity * item 1 co2-list)) / 1000
    set land-imp ((incum-quantity * item 0 land-list) + (alt-quantity * item 1 land-list)) / 1000
    set water-imp ((incum-quantity * item 0 water-list) + (alt-quantity * item 1 water-list)) / 1000
  ]
end

to choice-evaluation
  ;this function models the evaluation of an agent's choice against its human values, and determines if an agent will enter a state of cognitive dissonace.
  ask turtles [
    if random-float 1 >= social-blindness [
      let incumbent-choice-function (uf-incum * habit-factor-incum)
      let alterative-choice-function (uf-alt * habit-factor-alt)
      let weighted-average-health-impact (incum-quantity * item 0 choice-health-sums + alt-quantity * item 1 choice-health-sums) / total-average-milk
      let weighted-average-env-impact (incum-quantity * item 0 choice-env-sums + alt-quantity * item 1 choice-env-sums) / total-average-milk

      set choice-value-health weighted-average-health-impact - min(choice-health-sums) * (1 / (health-diff))
      set choice-value-env weighted-average-env-impact - min(choice-env-sums) * (1 / (env-diff))

      set value-health-deviation abs (choice-value-health - security-value)
      set value-env-deviation abs (choice-value-env - universalism-value)

      ; choice-function-deviation calculates the size of the difference, in percentage terms, between the highest scored choice and he mean of the other scores.
      set choice-function-deviation (max( list incumbent-choice-function alterative-choice-function) - (sum (list incumbent-choice-function alterative-choice-function) - (max( list incumbent-choice-function alterative-choice-function))) / 2) / (max( list incumbent-choice-function alterative-choice-function))
      ifelse ((value-health-deviation >= cognitive-dissonance-threshold) and (value-health-deviation <= justification)) or ((value-env-deviation >= cognitive-dissonance-threshold) and (value-env-deviation <= justification))
        [set cognitive-dissonance? TRUE]
        [set cognitive-dissonance? FALSE]

      if cognitive-dissonance? = TRUE [
        if (value-health-deviation = min(list choice-function-deviation value-health-deviation value-env-deviation)) and (count my-links >= 1)
          [let ME self
          set security-value (([security-value] of ME) * ( 1 - social-susceptibility )) + ((sum [security-value] of link-neighbors) / ( count my-links )) * (social-susceptibility)]
        if (value-env-deviation = min(list choice-function-deviation value-health-deviation value-env-deviation)) and (count my-links >= 1)
          [let ME self
          set universalism-value (([universalism-value] of ME) * ( 1 - social-susceptibility )) + ((sum [universalism-value] of link-neighbors) / ( count my-links )) * (social-susceptibility)]]]
  ]
end