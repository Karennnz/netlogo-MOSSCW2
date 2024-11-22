;;;;;; Agent Based Model of Food Choice Behaviour in the Context of British Milk Consumption ;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;; Agent's and global variables ;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; attributes and model variables of each agent
turtles-own [
  ;mean values for the perceived characteristics, on a relative basis, of the milk choices

  health-imp    ;;added
  env-imp

  ;dairy
  incum-physical-mean
  incum-health-mean
  incum-env-mean

  ;general plant based
  ;alt-physical-mean
  ;alt-health-mean
  ;alt-env-mean

  ; Mean values for the perceived characteristics
  oat-physical-mean
  oat-health-mean
  oat-env-mean

  soy-physical-mean
  soy-health-mean
  soy-env-mean

  almond-physical-mean
  almond-health-mean
  almond-env-mean


  ;milk choice characteristics perceived by agents, drawn from a normal distribution with mean values as above
  pphincum ;incumbant-dairy
  pinincum
  pexincum

  ;general plant based milk
  ;pphalt ;alternative
  ;pinalt
  ;pexalt

  ; Perceived characteristics for each milk type
  pph_oat
  pin_oat
  pex_oat

  pph_soy
  pin_soy
  pex_soy

  pph_almond
  pin_almond
  pex_almond


  ;agent memory containing list of length determined by the memory-length parameter of the perceived charactersitics of each milk choice over time
  mem-incum-ph ;physical price
  ;mem-alt-ph
  mem-oat-ph
  mem-soy-ph
  mem-almond-ph

  mem-incum-in ;health
  ;mem-alt-in
  mem-oat-in
  mem-soy-in
  mem-almond-in


  mem-incum-ex ;environment
  ;mem-alt-ex
  mem-oat-ex
  mem-soy-ex
  mem-almond-ex
  mem-ts

  ;values in the agent memory are averaged giving agent a single perception value for each milk choice and charactersitic
  mem-ph-incum-avg
  ;mem-ph-alt-avg
  mem-ph-oat-avg
  mem-ph-soy-avg
  mem-ph-almond-avg

  mem-in-incum-avg
  ;mem-in-alt-avg
  mem-in-oat-avg
  mem-in-soy-avg
  mem-in-almond-avg

  mem-ex-incum-avg
  ;mem-ex-alt-avg
  mem-ex-oat-avg
  mem-ex-soy-avg
  mem-ex-almond-avg


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
  ;uf-alt
  uf-oat
  uf-soy
  uf-almond

  new-uf-incum
  ;new-uf-alt
  new-uf-oat
  new-uf-soy
  new-uf-almond

  disposition-threshold             ;only for threshold-based model variant - float value between 0 and 1, above which an agent becomes disposed to consider its alternatives
  disposition                       ;float value between 0 and 1 of agent's disposition to consider its milk choice
  disposition-piqued?               ;binary TRUE or FALSE of whether agent disposition has been triggered or not
  f-red                             ;number of neighbours that consume mainly whole milk
  ;f-green                           ;number of neighbours that consume mainly alt milk
  f-green                           ;oat
  f-yellow                          ;soy
  f-white                           ;almond
  f-all                             ;total number of neighbours
  h-entropy                         ;informational entropy of distribution of neighbours milk choice
  h-max                             ;maximum informational entropy of distribution of neighbours milk choice
  prob-disposition                  ;only or probability-based model variant - probability that an agent will become disposed to consider milk choices

  num-conseq-same-choice            ;number of consecutive same milk choices
  habit?                            ;variable to indicate whether habit function has been triggered
  habit-factor-incum                ;the factor applied to the whole milk choice function
  ;habit-factor-alt                  ;the factor applied to the skimmed and semi-skimmed milk choice function
  habit-factor-oat
  habit-factor-soy
  habit-factor-almond

  last-choice                       ;previous milk choice
  food-choice                       ;new milk choice
  habit-function                    ;choice function including the cognitve/perception score and habit factor

  conformity                        ;flat between 0 and 1 of degree to which agent conforms to the public concerns on health and environment
  incum-quantity                    ;amount in ml of weekly consumption of whole milk
  ;alt-quantity                      ;amount in ml of weekly consumption of skimmed and semi-skimmed milk
  oat-quantity
  soy-quantity
  almond-quantity

  prior-quantity-incum              ;amount in ml of weekly consumption of whole milk of previous time-step
  ;prior-quantity-alt                ;amount in ml of weekly consumption of skimmed and semi-skimmed milk of previous time-step
  prior-quantity-oat
  prior-quantity-soy
  prior-quantity-almond

  choice-history                    ;agent record of previous choices

  incum-history                     ;agent record of previous whole milk choices
  ;alt-history                       ;agent record of previous skimmed/semi-skimmed choices
   oat-history
  soy-history
  almond-history

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
  disposition-probability-gradient  ;only for probabilty-based disposition approach - the gradient, k, of the logisitic function governing the probability that an agent will become disposed to consider its milk consumption choices
  ;campaign-intensity
]

;Global variables to run the model
globals [
  number-of-agents                  ;number of agents
  norm-data                         ;public concern data informed from Ipsos Mori and YouGov longitudinal survey data on concerns of the British public
  value-data                        ;data drawn from the UK results of three questions (assessing universalism, security, and openness) of the Human Values section of the European Social Survey 2018
  total-average-milk                ;
  min-unit                          ;the minimum allowable consumption of either milk choice, set at 1 pint (568ml)
  mean-incum                        ;main model output that measures the average whole milk consumption among agents
  ;mean-alt                          ;main model output that measures the average skimmed/semi-skimmed milk consumption among agents
  mean-oat
  mean-soy
  mean-almond

  incum-total-try                   ;total instances of whole milk chosen by agents
  ;alt-total-try                     ;total instances of skimmed/semi-skimmed milk chosen by agents
  oat-total-try
  soy-total-try
  almond-total-try
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

  mean-health-impact   ;;added
  mean-env-impact

  mean-plant-based ; Average of oat, soy, and almond consumption


  habit-on?                         ;habit function
  networks                          ;network function
  network-type                      ;type of network
  norms                             ;norms function
  counter                           ;choice counter
  campaign-active?
  target-milk
  initial-target-consumption
  campaign-start-tick
  campaign-duration
  co2-goal-reached?
  health-tick-count
  campaign-value  ;; added
  campaign-intensity

  total-milk       ; Variable to track the total milk
  gradient         ; The gradient (rate of increase per tick)
  initial
  
  almond-campaign?  ;; Switch for almond milk campaign
  oat-campaign?     ;; Switch for oat milk campaign
  soy-campaign?     ;; Switch for soy milk campaign
  
  ;initial-target-consumption ; Tracks the starting consumption of the targeted milk
  ;campaign-intensity ; Intensity of the campaign
 ; campaign-start-tick ; The tick when the campaign starts
  ;calc-milk-quantities


]

; netlogo extension used in the model
extensions [
  csv ; reads csv files of data.
  nw  ; the network extension is used in this model.
  profiler]; assess model execution time

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;SETUP PROCEDURE;;;;;;;;;;;;;;;;;;;;                      for later? set total-average-milk mean-incum + mean-oat + mean-soy + mean-almond
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to setup
  clear-all
  set number-of-agents 1000
  ;set mean-incum 2654.81             ;initialise average liquid wholemilk consumption per person per week (ml)
  set mean-incum 250           ;initialise average liquid wholemilk consumption per person per week (ml)
  ;set mean-alt 5.29                  ;initialise average skimmed (semi and full) consumption per person per week (ml)
  set mean-oat 200
  set mean-soy 200
  set mean-almond 200
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
  ;file-open "/Users/matthewgibson/OneDrive - Imperial College London/PhD/netlogodata_downsampled.csv"             ;downsampled annual data on UK public concerns of economy, health, and environment - aggregated from Ipsos Mori Issues Index and YouGov.
  file-open "C:/Users/zheng/Downloads/an-abm-of-historic-british-milk-consumption_v1.0.0/data/netlogodata_downsampled.csv"
  if justification < cognitive-dissonance-threshold
    [ifelse (justification + cognitive-dissonance-threshold) >= 1 [set justification 1] [set justification justification + cognitive-dissonance-threshold]]    ;makes sure that justification parameter is larger than cognitive-dissonance-threshold parameter during the optimisation exercise
  set network-parameter round network-parameter
  if remainder network-parameter 2 != 0 [set network-parameter network-parameter + 1] ;constrain agent neighbours to an even number
  impact-metrics
  set campaign-value 1  ;; initialize campaign-value
  set campaign-active? false  ;; Initialize as a Boolean ;;added
  
  set almond-campaign? false  ;; Initialize almond campaign switch
  set oat-campaign? false     ;; Initialize oat campaign switch
  set soy-campaign? false 
  
  set total-milk (mean-incum + mean-oat + mean-soy + mean-almond) * number-of-agents
  set initial (mean-incum + mean-oat + mean-soy + mean-almond) * number-of-agents
  
  ;Ensuring that the environmental and health factors do not start at zero but the actaul value
  impact-metrics
  set mean-env-impact ((mean-incum * item 0 co2-list) + (mean-oat * item 1 co2-list) + (mean-soy * item 2 co2-list) + (mean-almond * item 3 co2-list)) / (1000)  ;* total-average-milk
  set mean-health-impact ((mean-incum * item 0 sugar-list) + (mean-oat * item 1 sugar-list) + (mean-soy * item 2 sugar-list) + (mean-almond * item 3 sugar-list)) / (1000)

  
  reset-ticks
end

;to trigger-campaign
;  ;; Only start checking for campaigns after tick 5
;  if ticks > 5 [
;    ;; Identify the least-consumed milk type
;    let least-consumed min (list mean-oat mean-soy mean-almond)
;    
;    ;; Activate the respective campaign based on the least-consumed milk
;    if least-consumed = mean-oat [
;      set oat-campaign? true
;      set soy-campaign? false
;      set almond-campaign? false
;      print "Oat milk campaign triggered!"
;    ]
;    if least-consumed = mean-soy [
;      set soy-campaign? true
;      set oat-campaign? false
;      set almond-campaign? false
;      print "Soy milk campaign triggered!"
;    ]
;    if least-consumed = mean-almond [
;      set almond-campaign? true
;      set oat-campaign? false
;      set soy-campaign? false
;      print "Almond milk campaign triggered!"
;    ]
;  ]
;end

to calc-milk-quantities
  ;; Loop through all turtles to calculate the total milk quantity
  ask turtles [
    let total-for-this-turtle (incum-quantity + oat-quantity + soy-quantity + almond-quantity)
    set total-milk total-milk + total-for-this-turtle
  ]
end


to trigger-campaign
  ;; Only start checking for campaigns after tick 5
  if ticks > 5 [
    ;; Identify the least-consumed milk type
    let least-consumed min (list mean-oat mean-soy mean-almond)

    ;; Activate the respective campaign based on the least-consumed milk
    if least-consumed = mean-oat [
      set oat-campaign? true
      set soy-campaign? false
      set almond-campaign? false
      set initial-target-consumption mean-oat
      print "Oat milk campaign triggered!"
    ]
    if least-consumed = mean-soy [
      set soy-campaign? true
      set oat-campaign? false
      set almond-campaign? false
      set initial-target-consumption mean-soy
      print "Soy milk campaign triggered!"
    ]
    if least-consumed = mean-almond [
      set almond-campaign? true
      set oat-campaign? false
      set soy-campaign? false
      set initial-target-consumption mean-almond
      print "Almond milk campaign triggered!"
    ]

    ;; Start campaign
    set campaign-active? true
    set campaign-start-tick ticks
    set campaign-intensity 0.1
  ]
end

to check-campaign-status
  if campaign-active? [
    ;; Calculate current consumption of the targeted milk
    let current-consumption 0
    if oat-campaign? [set current-consumption mean [oat-quantity] of turtles]
    if soy-campaign? [set current-consumption mean [soy-quantity] of turtles]
    if almond-campaign? [set current-consumption mean [almond-quantity] of turtles]

    ;; Calculate the percentage increase
    let percentage-increase ((current-consumption - initial-target-consumption) / initial-target-consumption) * 100

    ;; Check if the increase exceeds the threshold
    if percentage-increase >= 30 [  ;; Example: threshold is 30%
      print (word "Campaign success! Target milk consumption increased by " percentage-increase "%.")
      end-campaign
    ]
  ]
end

to end-campaign
  ;; Reset campaign variables
  set campaign-active? false
  set oat-campaign? false
  set soy-campaign? false
  set almond-campaign? false
  print "Campaign ended."
end


to setup-turtles
  foreach (list turtles) [[x] -> ask x [

  ;mean values as inputs to normal distribution to drawn values of milk charactersitics perceived by agents
  set incum-physical-mean 1
  set incum-health-mean 1
  set incum-env-mean 1
  ;set alt-physical-mean 1             ;for this part of the model, in comparing the development of skimmed versus whole milk, the physcial characterisitics of the alternative (skimmed/semi-skimmed) were fixed at 1 to explore the range of possible values taken by health and environmental perception.
  ;set alt-health-mean alt-health-mean-initial
  ;set alt-env-mean alt-env-mean-initial


  set oat-physical-mean 1
  set oat-health-mean oat-health-mean-initial
  set oat-env-mean oat-env-mean-initial

  set soy-physical-mean 1
  set soy-health-mean soy-health-mean-initial
  set soy-env-mean soy-env-mean-initial

  set almond-physical-mean 1
  set almond-health-mean almond-health-mean-initial
  set almond-env-mean almond-env-mean-initial

  ;operating memory of agent's perception of milk choice characteristics
  set mem-incum-ph (list)
  ;set mem-alt-ph (list)
  set mem-oat-ph (list)
  set mem-soy-ph (list)
  set mem-almond-ph (list)

  set mem-incum-in (list)
  ;set mem-alt-in (list)
  set mem-oat-in (list)
  set mem-soy-in (list)
  set mem-almond-in (list)

  set mem-incum-ex (list)
  ;set mem-alt-ex (list)
  set mem-oat-ex (list)
  set mem-soy-ex (list)
  set mem-almond-ex (list)

  set mem-ts (list)


  ; this has been changed
; Initialize perceived characteristics
  let mmin 0.1

  set pphincum random-normal incum-physical-mean 0.1
  set pinincum random-normal incum-health-mean 0.1
  set pexincum random-normal incum-env-mean 0.1

  set pph_oat random-normal oat-physical-mean 0.1
  set pin_oat random-normal oat-health-mean 0.1
  set pex_oat random-normal oat-env-mean 0.1

  set pph_soy random-normal soy-physical-mean 0.1
  set pin_soy random-normal soy-health-mean 0.1
  set pex_soy random-normal soy-env-mean 0.1

  set pph_almond random-normal almond-physical-mean 0.1
  set pin_almond random-normal almond-health-mean 0.1
  set pex_almond random-normal almond-env-mean 0.1

  ; Ensure values are above minimum threshold
  while [pphincum <= mmin] [set pphincum random-normal incum-physical-mean 0.1]
  while [pinincum <= mmin] [set pinincum random-normal incum-health-mean 0.1]
  while [pexincum <= mmin] [set pexincum random-normal incum-env-mean 0.1]

  while [pph_oat <= mmin] [set pph_oat random-normal oat-physical-mean 0.1]
  while [pin_oat <= mmin] [set pin_oat random-normal oat-health-mean 0.1]
  while [pex_oat <= mmin] [set pex_oat random-normal oat-env-mean 0.1]

  while [pph_soy <= mmin] [set pph_soy random-normal soy-physical-mean 0.1]
  while [pin_soy <= mmin] [set pin_soy random-normal soy-health-mean 0.1]
  while [pex_soy <= mmin] [set pex_soy random-normal soy-env-mean 0.1]

  while [pph_almond <= mmin] [set pph_almond random-normal almond-physical-mean 0.1]
  while [pin_almond <= mmin] [set pin_almond random-normal almond-health-mean 0.1]
  while [pex_almond <= mmin] [set pex_almond random-normal almond-env-mean 0.1]

 ;this has been changed


  set last-choice color
  set food-choice color
  set disposition-piqued? FALSE
  set cognitive-dissonance? FALSE
  set habit? FALSE
  set habit-factor-incum 1
  ;set habit-factor-alt 1
  set habit-factor-oat 1
  set habit-factor-soy 1
  set habit-factor-almond 1
  set num-conseq-same-choice incumbent-initial-habit    ;sets agent's consecutive prior choice equal to the incumbent-initial-habit parameter

  ;initital weighting of the three milk charactersitics perception components
  set ph-weight-raw random-float 1
  set in-weight-raw random-float 1
  set ex-weight-raw random-float 1

;  ;initialise average liquid milk consumption per person per week (ml)
;  set incum-quantity 2654.81
;  ;set alt-quantity 5.29
;  set mean-oat 3
;  set mean-soy 2
;  set mean-almond 1

    ;initialise average liquid milk consumption per person per week (ml)
  set incum-quantity 250
  ;set alt-quantity 5.29
  set oat-quantity 200
  set soy-quantity 200
  set almond-quantity 200

;  set mean-oat 200
;  set mean-soy 200
;  set mean-almond 200
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
  ;ifelse (file-exists? "/Users/matthewgibson/OneDrive - Imperial College London/PhD/netlogovaluedata.csv")
  ifelse (file-exists? "C:/Users/zheng/Downloads/an-abm-of-historic-british-milk-consumption_v1.0.0/data/netlogovaluedata.csv")
    [set value-data []
    ;set value-data (csv:from-file "/Users/matthewgibson/OneDrive - Imperial College London/PhD/netlogovaluedata.csv")
    set value-data (csv:from-file "C:/Users/zheng/Downloads/an-abm-of-historic-british-milk-consumption_v1.0.0/data/netlogovaluedata.csv")
    ;user-message "File loading complete!"
    file-close]
    [user-message "Idiot. There is no netlogovaluedata.csv file in current directory dummy!"]
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
    nw:generate-watts-strogatz turtles links number-of-agents network-parameter 0.1 [ fd 10 ] ;network arameter is theinital average numebr of links before rewiring
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
  if ticks >= 45 [stop]
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
  trigger-campaign
  
  calc-milk-quantities

;  start-campaign1
 ; manage-campaign

;  campaign-submodel1     ; Add the campaign-submodel here
;  track-and-adjust-campaign
;
;  ;if ticks >= 32 [profiler:stop]
;;  if campaign-active? [
;;    campaign-submodel
;;    track-and-adjust-campaign
;;  ]
  ;end-campaign
  tick
end

;to manage-campaign
;  ;campaign-submodel
;  track-and-adjust-campaign
;  if not campaign-active? [end-campaign]
;end

to vary-info
  ;this function varies the information on milk characteristics perceived by agents
  ask turtles [
    if random-float 1 >= social-blindness and random-float 1 > 0.1 and ticks > 1 [

      if oat-quantity = 0 [
        ifelse (incum-health-mean / oat-health-mean) > 1000000
          [set oat-health-mean (oat-health-mean + (oat-health-mean * 0.05))] ; increases oat-health-mean by 5%
          [set oat-health-mean (oat-health-mean - (oat-health-mean * 0.05))] ; decreases oat-health-mean by 5%

        ifelse (incum-env-mean / oat-env-mean) > 1000000
          [set oat-env-mean (oat-env-mean + (oat-env-mean * 0.05))] ; increases oat-env-mean by 5%
          [set oat-env-mean (oat-env-mean - (oat-env-mean * 0.05))] ; decreases oat-env-mean by 5%
      ]

       if incum-quantity = 0 [
        ifelse (incum-health-mean / oat-health-mean) > 0
          [set oat-health-mean (oat-health-mean + (oat-health-mean * 0.05))] ; increases oat-health-mean by 5%
          [set oat-health-mean (oat-health-mean - (oat-health-mean * 0.05))] ; decreases oat-health-mean by 5%

        ifelse (incum-env-mean / oat-env-mean) > 0
          [set oat-env-mean (oat-env-mean + (oat-env-mean * 0.05))] ; increases oat-env-mean by 5%
          [set oat-env-mean (oat-env-mean - (oat-env-mean * 0.05))] ; decreases oat-env-mean by 5%
      ]

      if incum-quantity != 0 and oat-quantity != 0 [
        ifelse (incum-health-mean / oat-health-mean) > ((incum-quantity * item 0 choice-health-sums) / (oat-quantity * item 1 choice-health-sums))
          [set oat-health-mean (oat-health-mean + (oat-health-mean * 0.05))] ; increases oat-health-mean by 5%
          [set oat-health-mean (oat-health-mean - (oat-health-mean * 0.05))] ; decreases oat-health-mean by 5%

        ifelse (incum-env-mean / oat-env-mean) > ((incum-quantity * item 0 choice-env-sums) / (oat-quantity * item 1 choice-env-sums))
          [set oat-env-mean (oat-env-mean + (oat-env-mean * 0.05))] ; increases oat-env-mean by 5%
          [set oat-env-mean (oat-env-mean - (oat-env-mean * 0.05))] ; decreases oat-env-mean by 5%
      ]

      ;soy varied quantities
      if soy-quantity = 0 [
        ifelse (incum-health-mean / soy-health-mean) > 1000000
          [set soy-health-mean (soy-health-mean + (soy-health-mean * 0.05))] ; increases soy-health-mean by 5%
          [set soy-health-mean (soy-health-mean - (soy-health-mean * 0.05))] ; decreases soy-health-mean by 5%

        ifelse (incum-env-mean / soy-env-mean) > 1000000
          [set soy-env-mean (soy-env-mean + (soy-env-mean * 0.05))] ; increases soy-env-mean by 5%
          [set soy-env-mean (soy-env-mean - (soy-env-mean * 0.05))] ; decreases soy-env-mean by 5%
      ]

      if incum-quantity = 0 [
        ifelse (incum-health-mean / soy-health-mean) > 0
          [set soy-health-mean (soy-health-mean + (soy-health-mean * 0.05))] ; increases soy-health-mean by 5%
          [set soy-health-mean (soy-health-mean - (soy-health-mean * 0.05))] ; decreases soy-health-mean by 5%

        ifelse (incum-env-mean / soy-env-mean) > 0
          [set soy-env-mean (soy-env-mean + (soy-env-mean * 0.05))] ; increases soy-env-mean by 5%
          [set soy-env-mean (soy-env-mean - (soy-env-mean * 0.05))] ; decreases soy-env-mean by 5%
      ]

      if incum-quantity != 0 and soy-quantity != 0 [
        ifelse (incum-health-mean / soy-health-mean) > ((incum-quantity * item 0 choice-health-sums) / (soy-quantity * item 2 choice-health-sums))
          [set soy-health-mean (soy-health-mean + (soy-health-mean * 0.05))] ; increases soy-health-mean by 5%
          [set soy-health-mean (soy-health-mean - (soy-health-mean * 0.05))] ; decreases soy-health-mean by 5%

        ifelse (incum-env-mean / soy-env-mean) > ((incum-quantity * item 0 choice-env-sums) / (soy-quantity * item 2 choice-env-sums))
          [set soy-env-mean (soy-env-mean + (soy-env-mean * 0.05))] ; increases soy-env-mean by 5%
          [set soy-env-mean (soy-env-mean - (soy-env-mean * 0.05))] ; decreases soy-env-mean by 5%
      ]

      ;to vary almonds
      if almond-quantity = 0 [
        ifelse (incum-health-mean / almond-health-mean) > 1000000
          [set almond-health-mean (almond-health-mean + (almond-health-mean * 0.05))] ; increases almond-health-mean by 5%
          [set almond-health-mean (almond-health-mean - (almond-health-mean * 0.05))] ; decreases almond-health-mean by 5%

        ifelse (incum-env-mean / almond-env-mean) > 1000000
          [set almond-env-mean (almond-env-mean + (almond-env-mean * 0.05))] ; increases almond-env-mean by 5%
          [set almond-env-mean (almond-env-mean - (almond-env-mean * 0.05))] ; decreases almond-env-mean by 5%
      ]

      if incum-quantity = 0 [
        ifelse (incum-health-mean / almond-health-mean) > 0
          [set almond-health-mean (almond-health-mean + (almond-health-mean * 0.05))] ; increases almond-health-mean by 5%
          [set almond-health-mean (almond-health-mean - (almond-health-mean * 0.05))] ; decreases almond-health-mean by 5%

        ifelse (incum-env-mean / almond-env-mean) > 0
          [set almond-env-mean (almond-env-mean + (almond-env-mean * 0.05))] ; increases almond-env-mean by 5%
          [set almond-env-mean (almond-env-mean - (almond-env-mean * 0.05))] ; decreases almond-env-mean by 5%
      ]

      if incum-quantity != 0 and almond-quantity != 0 [
        ifelse (incum-health-mean / almond-health-mean) > ((incum-quantity * item 0 choice-health-sums) / (almond-quantity * item 3 choice-health-sums))
          [set almond-health-mean (almond-health-mean + (almond-health-mean * 0.05))] ; increases almond-health-mean by 5%
          [set almond-health-mean (almond-health-mean - (almond-health-mean * 0.05))] ; decreases almond-health-mean by 5%

        ifelse (incum-env-mean / almond-env-mean) > ((incum-quantity * item 0 choice-env-sums) / (almond-quantity * item 3 choice-env-sums))
          [set almond-env-mean (almond-env-mean + (almond-env-mean * 0.05))] ; increases almond-env-mean by 5%
          [set almond-env-mean (almond-env-mean - (almond-env-mean * 0.05))] ; decreases almond-env-mean by 5%
      ]


      let mmin 0.1

      set pphincum random-normal incum-physical-mean 0.1
      set pinincum random-normal incum-health-mean 0.1
      set pexincum random-normal incum-env-mean 0.1

      set pph_oat random-normal oat-physical-mean 0.1
      set pin_oat random-normal oat-health-mean 0.1
      set pex_oat random-normal oat-env-mean 0.1

      set pph_soy random-normal soy-physical-mean 0.1
      set pin_soy random-normal soy-health-mean 0.1
      set pex_soy random-normal soy-env-mean 0.1

      set pph_almond random-normal almond-physical-mean 0.1
      set pin_almond random-normal almond-health-mean 0.1
      set pex_almond random-normal almond-env-mean 0.1

      while [pphincum <= mmin] [set pphincum random-normal incum-physical-mean 0.1]
      while [pinincum <= mmin] [set pinincum random-normal incum-health-mean 0.1]
      while [pexincum <= mmin] [set pexincum random-normal incum-env-mean 0.1]
      while [pph_oat <= mmin] [set pph_oat random-normal oat-physical-mean 0.1]
      while [pin_oat <= mmin] [set pin_oat random-normal oat-health-mean 0.1]
      while [pex_oat <= mmin] [set pex_oat random-normal oat-env-mean 0.1]


      while [pph_soy <= mmin] [set pph_soy random-normal soy-physical-mean 0.1]
      while [pin_soy <= mmin] [set pin_soy random-normal soy-health-mean 0.1]
      while [pex_soy <= mmin] [set pex_soy random-normal soy-env-mean 0.1]

      while [pph_almond <= mmin] [set pph_almond random-normal almond-physical-mean 0.1]
      while [pin_almond <= mmin] [set pin_almond random-normal almond-health-mean 0.1]
      while [pex_almond <= mmin] [set pex_almond random-normal almond-env-mean 0.1]
  ]
  ]
end

to memory-fill
  ;this function replicates agent memory, creating a list of information perceived by agents at each time step
  ask turtles [
    set mem-incum-ph lput pphincum mem-incum-ph
    ;set mem-alt-ph lput pphalt mem-alt-ph
    set mem-oat-ph lput pph_oat mem-oat-ph
    set mem-soy-ph lput pph_soy mem-soy-ph
    set mem-almond-ph lput pph_almond mem-almond-ph

    set mem-incum-in lput pinincum mem-incum-in
    ;set mem-alt-in lput pinalt mem-alt-in
    set mem-oat-in lput pin_oat mem-oat-in
    set mem-soy-in lput pin_soy mem-soy-in
    set mem-almond-in lput pin_almond mem-almond-in

    set mem-incum-ex lput pexincum mem-incum-ex
    ;set mem-alt-ex lput pexalt mem-alt-ex
    set mem-oat-ex lput pex_oat mem-oat-ex
    set mem-soy-ex lput pex_soy mem-soy-ex
    set mem-almond-ex lput pex_almond mem-almond-ex

    set mem-ts lput ticks mem-ts
  ]
end

to memory-delete
  ;this function replicates the finite nature of memory, capping the size of list containing perceived milk characteristics to equal the memory-lifetime parameter
  ask turtles [
    ;(foreach mem-incum-ph mem-alt-ph mem-incum-in mem-alt-in mem-incum-ex mem-alt-ex mem-ts
    (foreach mem-incum-ph mem-oat-ph mem-soy-ph mem-almond-ph
             mem-incum-in mem-oat-in mem-soy-in mem-almond-in
             mem-incum-ex mem-oat-ex mem-soy-ex mem-almond-ex mem-ts
      [if (ticks - (first mem-ts)) >= memory-lifetime [
          let remove-position position first mem-ts mem-ts
          set mem-incum-ph remove-item remove-position mem-incum-ph
          ;set mem-alt-ph remove-item remove-position mem-alt-ph
          set mem-oat-ph remove-item remove-position mem-oat-ph
          set mem-soy-ph remove-item remove-position mem-soy-ph
          set mem-almond-ph remove-item remove-position mem-almond-ph

          set mem-incum-in remove-item remove-position mem-incum-in
          ;set mem-alt-in remove-item remove-position mem-alt-in
          set mem-oat-in remove-item remove-position mem-oat-in
          set mem-soy-in remove-item remove-position mem-soy-in
          set mem-almond-in remove-item remove-position mem-almond-in

          set mem-incum-ex remove-item remove-position mem-incum-ex
          ;set mem-alt-ex remove-item remove-position mem-alt-ex
          set mem-oat-ex remove-item remove-position mem-oat-ex
          set mem-soy-ex remove-item remove-position mem-soy-ex
          set mem-almond-ex remove-item remove-position mem-almond-ex

          set mem-ts remove-item remove-position mem-ts]])
  ]
end


to disposition-function
  ask turtles [
    ; Calculate the proportion of neighbors consuming different milk types
    let total-neighbors count link-neighbors
    if total-neighbors > 0 [
      let different-choice-neighbors count link-neighbors with [color != [color] of myself]
      set disposition different-choice-neighbors / total-neighbors

      ; Compare with the agent's threshold
      ifelse disposition >= disposition-threshold [
        set disposition-piqued? TRUE
      ]
      [
        set disposition-piqued? FALSE
      ]
    ]
    ;agents can also become disposed to consider alternatives given a state of cognitive dissonance
    if cognitive-dissonance? = TRUE [
    if choice-function-deviation = min(list choice-function-deviation value-health-deviation value-env-deviation)
      [set disposition-piqued? TRUE]]

    ;a small random of agents become spontaneously disposed
    if (disposition-piqued? = FALSE) and (random-float 1 >= .97) [set disposition-piqued? TRUE]


  ]
end

to disposition-function-probability
  ; This function calculates and manages the process of agent disposition in the probability-based model variant
  ask turtles [
    ; Count neighbors of each type
    set f-red count link-neighbors with [color = red]         ; dairy
    set f-green count link-neighbors with [color = green]     ; oat
    set f-yellow count link-neighbors with [color = yellow]   ; soy
    set f-white count link-neighbors with [color = white]     ; almond
    set f-all count link-neighbors                            ; total number of neighbors
    ; Maximum entropy for four options
    set h-max 2
    ; Check if any of the choices has zero neighbors, if so, set entropy to 0
    ifelse ((count link-neighbors with [color != red]) = 0) or
            ((count link-neighbors with [color != green]) = 0) or
            ((count link-neighbors with [color != yellow]) = 0) or
            ((count link-neighbors with [color != white]) = 0)
      [set h-entropy 0]
      [
        ; Calculate entropy with four categories
        let p-red (f-red / f-all)
        let p-green (f-green / f-all)
        let p-yellow (f-yellow / f-all)
        let p-white (f-white / f-all)
        set h-entropy (-(ifelse-value (p-red = 0) [0] [p-red * log (p-red) 2])
                      -(ifelse-value (p-green = 0) [0] [p-green * log (p-green) 2])
                      -(ifelse-value (p-yellow = 0) [0] [p-yellow * log (p-yellow) 2])
                      -(ifelse-value (p-white = 0) [0] [p-white * log (p-white) 2]))
      ]
    ; Calculate probability of disposition using logistic function with normalized entropy
    ;set prob-disposition (1 / (1 + exp(- (disposition-probability-gradient) * ((h-entropy / h-max) - 0.5))))
    set prob-disposition (1 / (1 + exp(-0.5)))
    ; Set disposition status based on probability
    ifelse random-float 1 <= prob-disposition
      [set disposition-piqued? TRUE]
      [set disposition-piqued? FALSE]
    ; Additional disposition consideration for cognitive dissonance
    if cognitive-dissonance? = TRUE [
      if choice-function-deviation = min(list choice-function-deviation value-health-deviation value-env-deviation)
        [set disposition-piqued? TRUE]
    ]
  ]
end


to cognitive-function
  ; This function generates an agent's base score of the cognitive perception of the milk characteristics
  ; based on information it is exposed to, and the weights they ascribe to each of these characteristics.
  ask turtles [
    ; Calculate the mean perceived values for each characteristic type
    set mem-ph-incum-avg mean mem-incum-ph
    set mem-ph-oat-avg mean mem-oat-ph
    set mem-ph-soy-avg mean mem-soy-ph
    set mem-ph-almond-avg mean mem-almond-ph

    set mem-in-incum-avg mean mem-incum-in
    set mem-in-oat-avg mean mem-oat-in
    set mem-in-soy-avg mean mem-soy-in
    set mem-in-almond-avg mean mem-almond-in
    ;set mem-in-almond-avg mean mem-in-almond-in

    set mem-ex-incum-avg mean mem-incum-ex
    set mem-ex-oat-avg mean mem-oat-ex
    set mem-ex-soy-avg mean mem-soy-ex
    set mem-ex-almond-avg mean mem-almond-ex

    ; Normalise weights
    set weights-raw (list ph-weight-raw in-weight-raw ex-weight-raw)
    set ph-weight ph-weight-raw / sum weights-raw
    set in-weight in-weight-raw / sum weights-raw
    set ex-weight ex-weight-raw / sum weights-raw

    ; Calculate utility functions for each milk option
    set uf-incum (ph-weight * mem-ph-incum-avg + in-weight * mem-in-incum-avg + ex-weight * mem-ex-incum-avg)
    set uf-oat (ph-weight * mem-ph-oat-avg + in-weight * mem-in-oat-avg + ex-weight * mem-ex-oat-avg)
    set uf-soy (ph-weight * mem-ph-soy-avg + in-weight * mem-in-soy-avg + ex-weight * mem-ex-soy-avg)
    set uf-almond (ph-weight * mem-ph-almond-avg + in-weight * mem-in-almond-avg + ex-weight * mem-ex-almond-avg)

    ; Apply campaign boost if campaign is active
;    if campaign-active? [
;      ;print
;      print (word "Campaign is active and increasing utility for: " target-milk)
;      if target-milk = "oat" [set uf-oat uf-oat + campaign-intensity]
;      if target-milk = "soy" [set uf-soy uf-soy + campaign-intensity]
;      if target-milk = "almond" [set uf-almond uf-almond + campaign-intensity]
;    ]
    
    ; Apply boost if respective campaign switch is on
    ;if almond-campaign? [set uf-almond uf-almond + 0.25]
    if almond-campaign? [set uf-almond uf-almond * 1.25]
    if oat-campaign? [set uf-oat uf-oat * 1.25]
    if soy-campaign? [set uf-soy uf-soy * 1.25]
  ]
end

to social-influence
  ;this function represents peer influence, modeled by modifying an agent's cognitive milk choice function by the mean value among
  ;its neighbors with the effect size based on the social susceptibility parameter.
  if networks = TRUE [
    ask turtles [
      if random-float 1 <= p-interact [
        ifelse count my-links >= 1 [
          let ME self

          ; Calculate new utility functions for each milk type based on social influence
          set new-uf-incum (([uf-incum] of ME) * (1 - social-susceptibility)) + ((sum [uf-incum] of link-neighbors) / (count my-links)) * social-susceptibility
          set new-uf-oat (([uf-oat] of ME) * (1 - social-susceptibility)) + ((sum [uf-oat] of link-neighbors) / (count my-links)) * social-susceptibility
          set new-uf-soy (([uf-soy] of ME) * (1 - social-susceptibility)) + ((sum [uf-soy] of link-neighbors) / (count my-links)) * social-susceptibility
          set new-uf-almond (([uf-almond] of ME) * (1 - social-susceptibility)) + ((sum [uf-almond] of link-neighbors) / (count my-links)) * social-susceptibility

        ] [
          ; If no neighbors, retain current utility functions
          set new-uf-incum uf-incum
          set new-uf-oat uf-oat
          set new-uf-soy uf-soy
          set new-uf-almond uf-almond
        ]

        ; Update the utility functions to the new socially influenced values
        set uf-incum new-uf-incum
        set uf-oat new-uf-oat
        set uf-soy new-uf-soy
        set uf-almond new-uf-almond
      ]
    ]
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

    ; Adjust habit factor based on the chosen milk type
    if (habit-function = TRUE) [
      if food-choice = red [
        set habit-factor-incum (peak-habit - exp (-0.042 * (num-conseq-same-choice - habit-threshold)))
        set habit-factor-oat 1
        set habit-factor-soy 1
        set habit-factor-almond 1
      ]
      if food-choice = green [
        set habit-factor-oat (peak-habit - exp (-0.042 * (num-conseq-same-choice - habit-threshold)))
        set habit-factor-incum 1
        set habit-factor-soy 1
        set habit-factor-almond 1
      ]
      if food-choice = yellow [
        set habit-factor-soy (peak-habit - exp (-0.042 * (num-conseq-same-choice - habit-threshold)))
        set habit-factor-incum 1
        set habit-factor-oat 1
        set habit-factor-almond 1
      ]
      if food-choice = white [
        set habit-factor-almond (peak-habit - exp (-0.042 * (num-conseq-same-choice - habit-threshold)))
        set habit-factor-incum 1
        set habit-factor-oat 1
        set habit-factor-soy 1
      ]
    ]

    ; Reset habit factors if the habit function is inactive
    if habit-function = FALSE [
      set habit-factor-incum 1
      set habit-factor-oat 1
      set habit-factor-soy 1
      set habit-factor-almond 1
    ]
  ]
end
to make-choice
  ; this function represents the main decision-making function where the cognitive functions of milk choices,
  ; modified by social effects and habit, are compared, and milk consumption is assigned proportionately to
  ; the respective size of these scored functions.
  ask turtles [
   ; print (word "Turtle: " self " Disposition piqued? " disposition-piqued?)
    ifelse (disposition-piqued? = TRUE) [
      ; Calculate utilities modified by habit factors for each milk type
      let incum-utility (uf-incum * habit-factor-incum)
      let oat-utility (uf-oat * habit-factor-oat)
      let soy-utility (uf-soy * habit-factor-soy)
      let almond-utility (uf-almond * habit-factor-almond)

      ;print (word "incum-utility: " incum-utility " oat-utility: " oat-utility " soy-utility: " soy-utility " almond-utility: " almond-utility)

      ; Compare the utilities in pairs
      let max-incum-oat max (list incum-utility oat-utility)
      let max-soy-almond max (list soy-utility almond-utility)

      ; Final comparison between the two maximums from the pairs
      let max-uf max (list max-incum-oat max-soy-almond)

      ;print (word "max-uf: " max-uf)

      ; Assign food choice and color based on the maximum utility found
      if max-uf = incum-utility [set color 55 set food-choice 55]
      if max-uf = oat-utility [set color green set food-choice green]
      if max-uf = soy-utility [set color yellow set food-choice yellow]
      if max-uf = almond-utility [set color white set food-choice white]

      ;print (word "Food choice: " food-choice " Color: " color)

      set choice-history choice-history + 1
      if food-choice = red [set incum-history incum-history + 1]
      if food-choice = green [set oat-history oat-history + 1]
      if food-choice = yellow [set soy-history soy-history + 1]
      if food-choice = white [set almond-history almond-history + 1]
    ]
    [ ; Default choice if disposition is not piqued
      set color color
      set food-choice last-choice
      set choice-history choice-history + 1
      if food-choice = red [set incum-history incum-history + 1]
      if food-choice = green [set oat-history oat-history + 1]
      if food-choice = yellow [set soy-history soy-history + 1]
      if food-choice = white [set almond-history almond-history + 1]
    ]

    ;set min-unit 568 ; ml of 1 British pint
    set min-unit 568 ; ml of 1 British pint

    ; Calculate quantities based on utility functions and habit factors for each type
    if (disposition-piqued? = TRUE) and ((uf-incum * habit-factor-incum + uf-oat * habit-factor-oat + uf-soy * habit-factor-soy + uf-almond * habit-factor-almond) != 0) [
      let total-uf (uf-incum * habit-factor-incum + uf-oat * habit-factor-oat + uf-soy * habit-factor-soy + uf-almond * habit-factor-almond)

     ; print (word "total-uf: " total-uf)

      set incum-quantity ((uf-incum * habit-factor-incum) / total-uf) * total-average-milk
      set oat-quantity ((uf-oat * habit-factor-oat) / total-uf) * total-average-milk
      set soy-quantity ((uf-soy * habit-factor-soy) / total-uf) * total-average-milk
      set almond-quantity ((uf-almond * habit-factor-almond) / total-uf) * total-average-milk

     ; print (word "incum-quantity: " incum-quantity " oat-quantity: " oat-quantity " soy-quantity: " soy-quantity " almond-quantity: " almond-quantity)
    ]
    ifelse (disposition-piqued? = FALSE) and ticks > 1 [
      set incum-quantity prior-quantity-incum
      set oat-quantity prior-quantity-oat
      set soy-quantity prior-quantity-soy
      set almond-quantity prior-quantity-almond
    ] [
      set incum-quantity incum-quantity
      set oat-quantity oat-quantity
      set soy-quantity soy-quantity
      set almond-quantity almond-quantity
    ]
  ]
end

;to make-choice
;  ; this function represents the main decision-making function where the cognitive functions of milk choices,
;  ; modified by social effects and habit, are compared, and milk consumption is assigned proportionately to
;  ; the respective size of these scored functions.
;  ask turtles [
;    ifelse (disposition-piqued? = TRUE) [
;      ; Calculate utilities modified by habit factors for each milk type
;      let incum-utility (uf-incum * habit-factor-incum)
;      let oat-utility (uf-oat * habit-factor-oat)
;      let soy-utility (uf-soy * habit-factor-soy)
;      let almond-utility (uf-almond * habit-factor-almond)
;
;      ; Compare the utilities in pairs
;      let max-incum-oat max (list incum-utility oat-utility)
;      let max-soy-almond max (list soy-utility almond-utility)
;
;      ; Final comparison between the two maximums from the pairs
;      let max-uf max (list max-incum-oat max-soy-almond)
;
;      ; Assign food choice and color based on the maximum utility found
;      if max-uf = incum-utility [set color red set food-choice red]
;      if max-uf = oat-utility [set color green set food-choice green]
;      if max-uf = soy-utility [set color yellow set food-choice yellow]
;      if max-uf = almond-utility [set color white set food-choice white]
;
;      set choice-history choice-history + 1
;      if food-choice = red [set incum-history incum-history + 1]
;      if food-choice = green [set oat-history oat-history + 1]
;      if food-choice = yellow [set soy-history soy-history + 1]
;      if food-choice = white [set almond-history almond-history + 1]
;    ]
;    [ ; Default choice if disposition is not piqued
;      set color color
;      set food-choice last-choice
;      set choice-history choice-history + 1
;      if food-choice = red [set incum-history incum-history + 1]
;      if food-choice = green [set oat-history oat-history + 1]
;      if food-choice = yellow [set soy-history soy-history + 1]
;      if food-choice = white [set almond-history almond-history + 1]
;    ]
;
;    ;set min-unit 568 ; ml of 1 British pint
;    set min-unit 568 ; ml of 1 British pint
;
;    ; Calculate quantities based on utility functions and habit factors for each type
;    if (disposition-piqued? = TRUE) and ((uf-incum * habit-factor-incum + uf-oat * habit-factor-oat + uf-soy * habit-factor-soy + uf-almond * habit-factor-almond) != 0) [
;      let total-uf (uf-incum * habit-factor-incum + uf-oat * habit-factor-oat + uf-soy * habit-factor-soy + uf-almond * habit-factor-almond)
;
;      set incum-quantity ((uf-incum * habit-factor-incum) / total-uf) * total-average-milk
;      set oat-quantity ((uf-oat * habit-factor-oat) / total-uf) * total-average-milk
;      set soy-quantity ((uf-soy * habit-factor-soy) / total-uf) * total-average-milk
;      set almond-quantity ((uf-almond * habit-factor-almond) / total-uf) * total-average-milk
;    ]
;    ifelse (disposition-piqued? = FALSE) and ticks > 1 [
;      set incum-quantity prior-quantity-incum
;      set oat-quantity prior-quantity-oat
;      set soy-quantity prior-quantity-soy
;      set almond-quantity prior-quantity-almond
;    ] [
;      set incum-quantity incum-quantity
;      set oat-quantity oat-quantity
;      set soy-quantity soy-quantity
;      set almond-quantity almond-quantity
;    ]
;  ]
;end

to ever-tried
  ;this function tracks the total number of choices for each milk type
  set incum-total-try sum [incum-history] of turtles
  set oat-total-try sum [oat-history] of turtles
  set soy-total-try sum [soy-history] of turtles
  set almond-total-try sum [almond-history] of turtles
  set choice-total sum [choice-history] of turtles
end

to average-consumption
  if ticks < 1 [
;    set mean-incum 2654.81
;    set mean-oat 3
;    set mean-soy 2
;    set mean-almond 1
    set mean-incum 250
    set mean-oat 200
    set mean-soy 200
    set mean-almond 200
    set mean-plant-based ((mean-oat + mean-soy + mean-almond) / 3)
    set mean-health-impact 0 ;;rep the avg health impact across all agents
    set mean-env-impact 0
  ]
  if ticks >= 1 [
    set mean-incum mean [incum-quantity] of turtles
    set mean-oat mean [oat-quantity] of turtles
    set mean-soy mean [soy-quantity] of turtles
    set mean-almond mean [almond-quantity] of turtles
    set mean-plant-based ((mean-oat + mean-soy + mean-almond) / 3)
    set mean-health-impact mean [health-imp] of turtles
    set mean-env-impact mean [env-imp] of turtles
  ]
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
    set prior-quantity-incum incum-quantity
    set prior-quantity-oat oat-quantity
    set prior-quantity-soy soy-quantity
    set prior-quantity-almond almond-quantity
  ]
end


to impact-metrics
 ; Nutritional impact metrics (grams per liter)
 set sugar-list [50.005 34 2 2.7]  ; Dairy, Oat, Soy, Almond (grams of sugar per liter)
 set satfat-list [13.185 3 3 2]    ; Dairy, Oat, Soy, Almond (grams of saturated fat per liter)
 set protein-list [36.575 11 33 9] ; Dairy, Oat, Soy, Almond (grams of protein per liter)

 ; Environmental impact metrics
 set co2-list [1.185 2.5 1 0.7]     ; Dairy, Oat, Soy, Almond (kg CO₂e per liter)
 set land-list [9 7.6 10.5 0.5]     ; Dairy, Oat, Soy, Almond (m² per liter)
 set water-list [628 482 27 371]    ; Dairy, Oat, Soy, Almond (liters of water per liter)

 ; Relative values for choice scoring (normalized to dairy milk as baseline of 1.0)
 ; For each product, the relative value is its value divided by the value of dairy
 set sugar-realtive[1 0.68 0.04 0.05]   ; Oat, Soy, Almond relative to Dairy
 set satfat-relative [1 0.228 0.228 0.151] ; Oat, Soy, Almond relative to Dairy
 set protein-relative [1 0.301 0.902 0.246] ; Oat, Soy, Almond relative to Dairy

 ;set co2-relative [1 2.11 0.846 0.591]     ; Oat, Soy, Almond relative to Dairy
 set co2-relative [1 0.911 0.846 0.591]     ; Oat, Soy, Almond relative to Dairy
 set land-relative [1 0.844 1.167 0.056]   ; Oat, Soy, Almond relative to Dairy
 set water-relative [1 0.768 0.043 0.591]  ; Oat, Soy, Almond relative to Dairy

; set choice-health-sums [1 0.61  -0.63  -0.04];saturated fat
; set choice-env-sums [3.00  2.781 0.690 1.238];sum of relative enveronmental factors

 set choice-health-sums [1.01 1 1 1];saturated fat
 set choice-env-sums [1.01 1.4 1.8 1.2] ;sum of relative enveronmental factors

 ; Calculate health and environmental differences for decision-making
 set health-diff (max choice-health-sums - min choice-health-sums)
 set env-diff (max choice-env-sums - min choice-env-sums)
end


to impact-tracker
  ask turtles [
    set sugar-imp ((incum-quantity * item 0 sugar-list) + (oat-quantity * item 1 sugar-list) + (soy-quantity * item 2 sugar-list) + (almond-quantity * item 3 sugar-list)) / 1000
    set satfat-imp ((incum-quantity * item 0 satfat-list) + (oat-quantity * item 1 satfat-list) + (soy-quantity * item 2 satfat-list) + (almond-quantity * item 3 satfat-list)) / 1000
    set protein-imp ((incum-quantity * item 0 protein-list) + (oat-quantity * item 1 protein-list) + (soy-quantity * item 2 protein-list) + (almond-quantity * item 3 protein-list)) / 1000

    ; calc health impact: logic here -> lower sugar, saturated fat, and higher protein are better.
    set health-imp (- satfat-imp - sugar-imp + protein-imp)

    ; Calculate environmental impact: consider CO2, land, and water usage
    set env-imp (
      (incum-quantity * item 0 co2-list) + (oat-quantity * item 1 co2-list) +
      (soy-quantity * item 2 co2-list) + (almond-quantity * item 3 co2-list)
    ) / 1000
  ]
  ; update the mean health impact
  set mean-health-impact mean [health-imp] of turtles
  set mean-env-impact mean [env-imp] of turtles
end



to choice-evaluation
  ; This function models the evaluation of an agent's choice against its human values, and determines if an agent will enter a state of cognitive dissonance.
  ask turtles [
    if random-float 1 >= social-blindness [
      let incumbent-choice-function (uf-incum * habit-factor-incum)
      let oat-choice-function (uf-oat * habit-factor-oat)
      let soy-choice-function (uf-soy * habit-factor-soy)
      let almond-choice-function (uf-almond * habit-factor-almond)
      ; Calculate weighted average impacts across all milk types
      let weighted-average-health-impact (
        (incum-quantity * item 0 choice-health-sums) +
        (oat-quantity * item 1 choice-health-sums) +
        (soy-quantity * item 2 choice-health-sums) +
        (almond-quantity * item 3 choice-health-sums)
      ) / total-average-milk
      let weighted-average-env-impact (
        (incum-quantity * item 0 choice-env-sums) +
        (oat-quantity * item 1 choice-env-sums) +
        (soy-quantity * item 2 choice-env-sums) +
        (almond-quantity * item 3 choice-env-sums)
      ) / total-average-milk
      ; Check to avoid division by zero
      let max-choice-function max (list incumbent-choice-function oat-choice-function soy-choice-function almond-choice-function)
      if max-choice-function != 0 [
        set choice-function-deviation (
          max-choice-function -
          (sum (list incumbent-choice-function oat-choice-function soy-choice-function almond-choice-function) - max-choice-function) / 3
        ) / max-choice-function
      ]
      set choice-value-health (weighted-average-health-impact - min(choice-health-sums)) * (1 / health-diff)
      set choice-value-env (weighted-average-env-impact - min(choice-env-sums)) * (1 / env-diff)
      set value-health-deviation abs (choice-value-health - security-value)
      set value-env-deviation abs (choice-value-env - universalism-value)
      ifelse ((value-health-deviation >= cognitive-dissonance-threshold) and (value-health-deviation <= justification)) or ((value-env-deviation >= cognitive-dissonance-threshold) and (value-env-deviation <= justification)) [
        set cognitive-dissonance? TRUE
      ] [
        set cognitive-dissonance? FALSE
      ]
      if cognitive-dissonance? [
        if (value-health-deviation = min (list choice-function-deviation value-health-deviation value-env-deviation)) and (count my-links >= 1) [
          let ME self
          set security-value (([security-value] of ME) * (1 - social-susceptibility)) + ((sum [security-value] of link-neighbors) / count my-links) * social-susceptibility
        ]
        if (value-env-deviation = min (list choice-function-deviation value-health-deviation value-env-deviation)) and (count my-links >= 1) [
          let ME self
          set universalism-value (([universalism-value] of ME) * (1 - social-susceptibility)) + ((sum [universalism-value] of link-neighbors) / count my-links) * social-susceptibility
        ]
      ]
    ]
  ]
end


