# Agent-Based Model of Food Choice Behavior in British Milk Consumption

## Overview

This project simulates **food choice behavior** within the context of British milk consumption using an **Agent-Based Model (ABM)** implemented in NetLogo. The model examines consumer preferences for dairy milk and plant-based alternatives (oat, soy, almond) by exploring:
- **Environmental and Health impacts**
- **Social influences**
- **Advertising campaigns**

The goal is to analyse how individual agents (representing consumers) make choices based on cognitive, social, and habitual factors, and the role of marketing campaigns in influencing these behaviours.

---

## Features

- **Dynamic Agent Behavior**: Simulates agents' decisions based on health, environmental impacts, and social influence.
- **Advertising Campaigns**: Models the effects of marketing campaigns targeting specific milk types.
- **Polarized vs. Non-Polarized Environments**: Tests agent behavior under varied societal norms and perceptions.
- **Impact Metrics**: Tracks consumption patterns and calculates environmental (CO₂ emissions, land use, water usage) and health-related metrics (sugar, protein, fat).

---

## Structure

### Key Model Components
1. **Agents (Turtles)**:
   - Represent individual consumers with attributes such as preferences for physical, health, and environmental characteristics of milk types.
   - Track past consumption patterns, conformity to social norms, and cognitive dissonance.

2. **Global Variables**:
   - Store aggregate data, such as total consumption, advertising campaign status, and environmental/health metrics.

3. **Core Functions**:
   - **Cognitive Function**: Models agents’ evaluation of milk types based on weighted preferences.
   - **Social Influence**: Incorporates peer pressure and societal norms into decision-making.
   - **Advertising Campaigns**: Dynamically adjusts agents' preferences during active campaigns.

---

## Dataset Details

### Included Datasets
1. **Market Campaign Dataset**:
   - Contains data for advertised and non-advertised scenarios for oat, soy, and almond milk.
   - Determines the impact of promotional efforts on agent decisions.

2. **Polarized vs. Non-Polarized Data**:
   - Simulates environments with varying levels of public perception:
     - **Polarized**: Distinct preferences for specific milk types (e.g., strong environmental concerns).
     - **Non-Polarized**: Uniform preferences with no significant bias toward any type.
---

## File Descriptions
- **`an-abm-of-historic-british-milk-consumption_v1.0.0Final.zip`**:
  This is the full netlogo code with interfaces and relevant dataset used. 

- **`Last_version.nlogo`**:
  The latest version with optimized features, including campaign dynamics.

- **`New_model_price_tracker.nlogo`**:
  Effort made on implementing price model and evaluating the effect by observing the metrics.

  - **`Basic_Pricing_Milk_Model.nlogo`**:
  Implements basic price-based decision-making for milk choices.

- **`RegressionForPolarisedAndUnpolarised.ipynb`**:
  Python notebook analyzing polarized vs. non-polarized scenarios using regression models.
  (may need to add the latest notebook version)

---

## How to Run

### Requirements
- **NetLogo (Version 6.0+)**: Install from [NetLogo's official website](https://ccl.northwestern.edu/netlogo/).

### Running the Model
1. Load any `.nlogo` file in NetLogo. (Last_version.nlogo)
2. Click `Setup` to initialise the environment and agents.
3. Click `Go` to start the simulation.

Note: In order to activate the marketing campaign, manually uncommenting of the to-go procedure are required (i.e., uncomment out **trigger-campaign**, **check-campaign-status**)

Optional:
- Adjust parameters like **social-conformity**, **incum-habit-threshold** etc in the interfaces.

---

## Key Insights

1. **Behavioral Shifts**:
   - Advertising campaigns can shift preferences for specific milk types.
   - Social networks play a critical role in influencing agent choices.

2. **Environmental and Health Trade-offs**:
   - Plant-based milks show significant reductions in CO₂ emissions compared to dairy.
   - Health impacts vary by milk type (e.g., lower sugar in almond but higher protein in soy).

3. **Policy Implications**:
   - Insights can inform policymakers on strategies for promoting sustainable consumption.

---

## Future Directions

- **Multimodal Data Integration**: Incorporate visual data (e.g., marketing images).
- **Cross-Cultural Analysis**: Expand the dataset to non-UK markets.
- **Machine Learning**: Use advanced models for predictive analysis.

---

## Author Information
Developed as part of an academic project on **Agent-Based Modelling of Milk Consumption Trends in the UK: Environmental and Health Impacts of Dairy and Plant-Based Alternatives**. For inquiries, contact the repository owners.

---
