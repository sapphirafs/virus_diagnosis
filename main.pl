% -----------
% Virus_Diagnosis by Sapphira Frankl-Slater
%
% Description: This expert System asseses the pressence
% of a virus in a patient based on their symptoms, bio data 
% & recent history of events.
% ---------------

% ----------
%  current symptoms that patients themselves have reported.
% ----------------
self_reported_symptom(fever).
self_reported_symptom(persistent_dry_cough).
self_reported_symptom(tiredness).
% self_reported_symptom(sore_throat).
% self_reported_symptom(anosmia).
% self_reported_symptom(chest_pressure).
% self_reported_symptom(difficulty_breathing).
% self_reported_symptom(loss_of_speech_or_movement).

% ------------------
% patient stats & bio data
% These statements define the patient age, gender, & medical conditions.
% ------------------
patient_age(30).
patient_gender(male).
% existing_medical_condition().

% ------------
% Recent contact data
% were they around anyone infected, and how recentl was this?
% ------------
contact_with_infected.
days_since_contact_with_infected(5).

% ------------------
% rule: how vulnerarble is the user based on age or bio data
% patients above 70 or with pre-existing health issues are more likely to develop more severe symptoms.
% :- means if & _ means that there could be any medical condition (anonymous value placeholder). 
% so, the fact that someone has one at all means they are at risk
% ------------

more_at_risk_to_develop_severe_symptoms :-
    patient_age(Age), Age > 70.

% more_at_risk_to_develop_severe_symptoms :-
    % existing_medical_condition(_).

% -----------------------
% rule: assess the likelyhood of infection
% Based on common symptoms & how many days since contact with the infected in the past 14 days
% ------------------
likely_infected :-
    self_reported_symptom(fever),
    self_reported_symptom(persistent_dry_cough),
    contact_with_infected,
    days_since_contact_with_infected(Days), Days >= 1, Days =< 14.

% -----------------------
% rule: check for severe symptoms that may need hospitalisation
% the rules show that immediate medical attention is necessary.
% ---------------------
needs_emergency_attention :-
    self_reported_symptom(difficulty_breathing);
    self_reported_symptom(loss_of_speech_or_movement);
    self_reported_symptom(chest_pressure).


% ---------------------
% rule: final logic for diagnosis
% uses conditions to decide on the advice the expert system gives.
% ----------------------

% result a- user is likely infected & high vulnerability
diagnosis_result :-
    likely_infected,
    more_at_risk_to_develop_severe_symptoms,
    write('Diagnosis: Very likely the patient is infected. Also, the patient is highly vulnerable, please see a doctor asap.').

% result b- Likely infected but not vulnerable to develop severe symptoms
%--- \+ means not
diagnosis_result :-
    likely_infected,
    \+ more_at_risk_to_develop_severe_symptoms,
    write('Diagnosis: the patient has a possible infection so they should stay at home and track symptoms.').

% result c- no solid case for infection
diagnosis_result :-
    \+ likely_infected,
    write('Diagnosis: not enough evidence of infection based on current data.').

% -------------------
% You can run this by writing:
% ?- [main].
% then,
% ?- diagnosis_result.
% in the terminal which will run this file and then summarise the patients state

% -----------------------