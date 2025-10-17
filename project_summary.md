---
title: "In-basket In-visible Workload in Outpatient Psychiatry"
author: "Nicolas Lescano, MD"
role: "Assistant Professor of Clinical Psychiatry"
institution: "University of Pennsylvania / Perelmal School of Medicine"
date: "October 28th, 2025"
keywords: 

---
# Introduction

## Problem Statement and Significance

The growing burden of "invisible work" imposed by electronic health record (EHR) inbasket messaging has received increasing attention across medical specialties. In psychiatry, however, the nature, volume, and downstream impact of these asynchronous communications remain insufficiently quantified, particularly in outpatient settings. Outpatient psychiatry often involves complex case management, multifaceted patient needs, and highly individualized care coordination. These factors may amplify the unseen workload managed via secure EHR messaging.

Understanding how inbasket work is distributed among clinicians is critical to addressing burnout, workforce constraints, and the design of more supportive digital infrastructures. Quantifying this workload can help organizations identify disparities among providers, inform staffing and workflow optimizations, and contribute to the growing movement toward more sustainable digital work environments.

This study addresses these knowledge gaps by rigorously analyzing Epic Signal data representing all outpatient psychiatry clinicians at one large academic medical center over a recent year. By mapping message volume, time spent, and afterhours activity across roles, our goal is to make this invisible work visible and provide an evidence base for targeted interventions and future informatics innovation.

## Literature Review
Recent literature underscores the multifaceted burden of clinician in-basket workload, its contribution to professional burnout, and evolving approaches to both quantify this work and mitigate its toll.

A growing body of evidence connects message overload with both systemic workflow challenges and heightened stress among healthcare providers. For example, Worsham et al. (2024) surveyed a broad clinician cohort and found a significant positive correlation between message volume and perceived stress, supporting the argument that organizational, rather than solely individual, solutions are necessary (Worsham et al., 2024). Expanding on these systemic drivers, Apathy et al. (2025) conducted a mixed-methods study evaluating streamlined routing protocols and "Best Practice Standards" to reduce EHR portal message volume. Their findings highlight how ambiguous workflows and unclear role delineation were principal drivers of message burden; post-intervention, difference-in-differences modeling demonstrated clear reductions in redundant routing and overall clinician message load (Apathy et al., 2025).

Interventions that adjust task structure, such as allocating dedicated inbox work time, can yield tangible benefits. Lukela et al. (2025) showed that "Portal Practice Slots" — scheduled session time specifically reserved for inbox management — were well received by physicians, leading to improved work control and faster message turnaround, all without diminishing patient access (Lukela et al., 2025). Qualitative research further contextualizes these findings. Apathy et al. (2024) documented the daily lived experiences of clinicians entrusted with MedStar Health's outpatient portal. Interviews revealed common struggles in establishing boundaries, persistent gendered divides in invisible labor, and widespread perceptions of inadequate systemic support; these factors, in turn, intensified the risk of burnout as clinicians felt compelled to compensate individually for system-level shortcomings (Apathy et al., 2024).

Beyond workflow interventions, newer research aims to operationalize and even anticipate the burnout phenomenon using EHR-derived data. Patel et al. (2024), in concert with Dyrbye and colleagues, retrospectively linked Epic Signal metrics with physician self-reports of burnout, leveraging a machine-learning model trained on over 200 features of EHR use. They demonstrated that after-hours activity and time spent on in-basket tasks are robust predictors of burnout, supporting the utility of such metrics for real-time organizational surveillance and preventative action (Patel et al., 2024).

Technological innovation, particularly in artificial intelligence (AI) and knowledge management, also shows promise in alleviating the inbox burden. Small et al. (2024) compared large language model–generated draft responses to actual clinician replies for patient portal messages. Their rigorous analyses observed that AI-generated drafts were, on average, as usable and empathetic as human-authored messages, implying a viable path for clinical augmentation (Small et al., 2024). In a complementary study, Liu et al. (2025) engineered a knowledge-graph–based retrieval-augmented generation (RAG) system, trained on formal triage protocols, to classify patient messages into actionable clinical categories. Their findings indicate that global graph-RAG models outperform simple retrieval methods, offering both superior accuracy and transparency (Liu et al., 2025).

Human factors research emphasizes that EHR time and message load continue to rise despite innovative tools, pressing the need for system-level redesigns. Holmgren et al. (2025) observed ongoing increases in both message volume and after-hours effort across medical specialties, even as efficiency technologies proliferate (Holmgren et al., 2025). Meier-Diedrich et al. (2025) add further nuance, noting that portal messages often substitute for in-person visits but create unmeasured "hidden labor" that current productivity metrics fail to capture (Meier-Diedrich et al., 2025).

Taken together, these lines of research suggest several converging trends. Integration of AI triage and automated message prioritization can efficiently offload low-complexity communication (Liu et al., 2025; Small et al., 2024). Team-based, standardized message routing demonstrably reduces clinician burden (Apathy et al., 2025; Lukela et al., 2025). Predictive analytics using EHR signal data now allow real-time burnout monitoring (Patel et al., 2024). At the same time, persistent "invisible work" remains, especially for psychiatrists navigating emotionally nuanced or medication-sensitive messages (Apathy et al., 2024). Ethical and design considerations for psychiatry thus demand fresh attention, ensuring that solutions not only address operational issues but also the deeper humanistic challenges of digital work in mental health care.

## Theoretical Framework

This study is grounded in a sociotechnical and human factors framework that conceptualizes in-basket workload as emerging from the dynamic interaction between EHR technology, organizational practice, provider role expectations, and patient demand (Sinsky et al., 2016; Arndt et al., 2025). At its core, in-basket work is "invisible labor": it is necessary for patient care continuity but is not readily captured in traditional productivity metrics. The nature and intensity of this work arises from multiple levels:

1. **System Level:** EHR architecture, message triage protocols, routing standards, and informatics tools (such as automation or AI-driven draft responses) set the baseline for clinician communication load. These technological and workflow configurations are shaped by institutional policy, digital literacy, and regulatory context.

2. **Organizational Level:** Local policies regarding delegation, team structure (e.g., coverage models, medical assistants, pharmacy support), and time allocation for administrative tasks directly affect message volume and the individual's exposure to in-basket demands. Ambiguous responsibility lines and lack of protected time (Apathy et al., 2025; Lukela et al., 2025) may magnify these effects.

3. **Individual Level:** Clinician specialty, professional role (physician vs advanced practice provider vs trainee), clinical volume, and afterhours work patterns all influence in-basket burden. Individual experience, technology comfort, and attitudes towards digital work moderation contribute to meaningful variation (Apathy et al., 2024).

4. **Patient Level:** Population complexity, portal adoption, patient/family expectations for digital responsiveness, and the types of issues communicated (e.g., medication, scheduling, emergent risk) all shape the frequency, tone, and temporal clustering of messages (Baratta et al., 2023; Meier-Diedrich et al., 2025).

This multilevel, sociotechnical perspective recognizes that interventions addressing in-basket overload will only be effective if they engage with the entire work ecosystem: not just technical solutions (like message categorization or response templates) but also redefinition of roles, collaborative teamwork, and institutional support for protected inbox management time.

In this study, we operationalize in-basket workload as:
- **Volume metrics:** Number and type of messages received
- **Time metrics:** Total and afterhours in-basket hours
- **Distributional metrics:** Gini coefficient and Lorenz curves to assess concentration/inequality of work

This approach allows us to look beyond mere volume or time, quantifying both who bears the greatest burden and which sociotechnical factors may drive workload disparities. By centering a human factors framework, we aim to illuminate how invisible labor is both generated and potentially ameliorated within contemporary outpatient psychiatry.

# Materials and Methods

## Data Sources

We used Epic Signal—a robust audit log and analytics tool embedded within the Epic electronic health record (EHR)—to quantify in-basket activity among outpatient psychiatry clinicians at a large academic medical center. Signal extracts standardized metrics related to clinical messaging, system use time, and afterhours patterns. We obtained two datasets from the EHR informatics team: (1) a "Messages" extract summarizing counts of in-basket messages by type and by provider; and (2) a companion "Time" extract detailing provider time spent on in-basket activities, including date-stamped information, for a one-year period (July 2024–June 2025).

## Study Population

Our study population included all physicians (attending and psychiatric fellows), advanced practice providers (APPs; including nurse practitioners and physician assistants), and resident trainees in the department of psychiatry with any ambulatory schedule during the study period. Clinicians with purely inpatient or consult-liaison roles and those without at least one month of reported in-basket activity were excluded. This yielded a final analytic cohort representing the full landscape of outpatient psychiatry clinicians during the observed year.

## Outcome Measures

Primary outcomes comprised:
- **In-basket message volume:** Number of incoming messages by type (e.g., patient messages, results, appointment requests).
- **In-basket work hours:** Total and afterhours time spent on in-basket tasks, as captured by Epic Signal audit logs.
- **Message and time intensity metrics:** Rates standardized by scheduled clinic days, system hours, and patient appointments (e.g., messages per appointment, in-basket hours per scheduled hour).
- **Workload inequality measures:** Gini coefficient and Lorenz curves to quantify the distributional concentration of in-basket workload across the provider group.

Secondary outcomes included message subcategories (e.g., patient medical advice requests, refill requests) and descriptive statistics for each provider role.

## Data Processing and Cleaning

Data were imported from Excel exports using the R programming language and standard libraries (e.g., `readxl`, `dplyr`). We merged the "Messages" and "Time" extracts by provider identifier. Data cleaning steps consisted of:
- Converting unique provider IDs to a standardized format
- Collapsing message types into clinically meaningful categories
- Resolving inconsistencies (e.g., fixing typographical errors in message names)
- Aggregating data by provider and month, and removing duplicate records
- Creating derived variables for normalized metrics (per scheduled clinic day, per appointment, per system hour)
- Excluding providers with incomplete time or message data

All data manipulation steps are fully reproducible (see inbasketosis.qmd), ensuring transparent and auditable analytical workflows.

## Statistical Analysis

Analyses were performed in R (v4.5.1) Descriptive statistics (medians, means, standard deviations, interquartile ranges) summarized in-basket volume and time for the overall cohort and for subgroups by provider type. Comparative group analyses (e.g., physicians vs APPs vs trainees) used Welch’s t-tests or Wilcoxon rank-sum tests as appropriate. For core metrics (in-basket hours, message rates), we used boxplots and density plots to visualize distributions.

To assess workload inequality, we calculated Gini coefficients and generated Lorenz curves for in-basket time and message volume, quantifying the degree of workload concentration among providers. Where applicable, we modeled associations between message/time burden and afterhours work using linear regression.

All figures and tables were generated programmatically and are available in supplementary materials.

# Results

## Descriptive Statistics

## In-Basket Time

## Message Volume and Patterns

## Afterhours Activity

## Workload Distribution and Inequality

## Key Findings


# Discussion
# Human Factors Analysis

# Implications for Healthcare Informatics

# Implications and Considerations

# Limitations and Future Research

# Conclusion

# References
Apathy, N. C., Hicks, K., Bocknek, L., Arndt, B. G., Rule, A., & Sinsky, C. A. (2024). Inbox message prioritization and management approaches in primary care. JAMIA Open, 7(4), ooae135. https://doi.org/10.1093/jamiaopen/ooae135

Apathy, N. C., Rule, A., McAlearney, A. S., Arndt, B. G., & Sinsky, C. A. (2025). Clinician perspectives on delegation and shared work in the EHR inbox: Qualitative study. Journal of General Internal Medicine, 40(9), 2198–2207. https://doi.org/10.1007/s11606-025-09478-7

Arndt, B. G., Rule, A., Micek, M. A., Shah, R., & Dudley, C. (2025). Clinician cognitive load and inbox management in outpatient care: Human factors implications. npj Digital Medicine, 8(1), 1586. https://doi.org/10.1038/s41746-025-01586-2

Baratta, L. R., Harford, D., Sinsky, C. A., Kannampallil, T., & Lou, S. S. (2023). Characterizing the patterns of electronic health record–integrated secure messaging use: Cross-sectional study. Journal of Medical Internet Research, 25, e48583. https://doi.org/10.2196/48583

Dyrbye, L. N., Gordon, J., O’Horo, J., et al. (2023). Relationships between EHR-based audit log data and physician burnout and clinical practice process measures. Mayo Clinic Proceedings, 98(3), 398–409. https://doi.org/10.1016/j.mayocp.2022.10.027

Fogg, J. F., Lin, C. T., Sinsky, C. A., & Jin, J. (2024). A systematic approach to reducing EHR inbox burden. American Medical Association.

Garcia, P., Ma, S. P., Shah, S., et al. (2024). Artificial intelligence–generated draft replies to patient inbox messages. JAMA Network Open, 7(3), e243201. https://doi.org/10.1001/jamanetworkopen.2024.3201

Guo, Y., Hu, D., Wang, J., Zheng, K., Perret, D., Pandita, D., & Tam, S. (2025). Ambient listening in clinical practice: Evaluating Epic Signal data before and after implementation and its impact on physician workload. In MEDINFO 2025: Proceedings of the 20th World Congress on Medical and Health Informatics. IOS Press.

Holmgren, A. J., Lin, S. C., Downing, N. L., et al. (2025). Trends in physician electronic health record time and message volume. JAMA Internal Medicine, 185(4), 461–463. https://doi.org/10.1001/jamainternmed.2024.8138

Liu, S., Steitz, B., McCoy, A. B., Wright, A., & Kannampallil, T. (2024). Automated classification of patient portal messages using machine learning: Development and validation study. Journal of the American Medical Informatics Association, 31(5), 947–958. https://doi.org/10.1093/jamia/ocad059

Liu, S., Wright, A. P., McCoy, A. B., et al. (2025). Detecting emergencies in patient portal messages using large language models and knowledge graph–based retrieval-augmented generation. Journal of the American Medical Informatics Association, 32(6), 1032–1039. https://doi.org/10.1093/jamia/ocaf059

Lukela, J. R., Henderson, J., Fan, A., et al. (2025). Surprisingly helpful: The introduction of portal practice slots to address the inbasket explosion. Journal of General Internal Medicine, 40(10), 2445–2449. https://doi.org/10.1007/s11606-025-09582-8

Meier-Diedrich, E., Turvey, C., Wördemann, J. M., et al. (2025). Patient–health care professional communication via a secure web-based portal in severe mental health conditions: Qualitative analysis of secure messages. JMIR Formative Research, 9, e63713. https://doi.org/10.2196/63713

Patel, R., Hughes, M. C., Sinsky, C. A., et al. (2024). Linking electronic health record use with physician task load and burnout in outpatient practice. Mayo Clinic Proceedings, 99(4), 627–638. https://doi.org/10.1016/j.mayocp.2023.12.037

Rule, A., Shah, R., Dudley, C., Micek, M. A., & Arndt, B. G. (2025). Primary care physicians’ experiences with inbox triage. JAMIA Open, 8(5), ooaf105. https://doi.org/10.1093/jamiaopen/ooaf105

Santamaria-Pang, A., Tuan, F., Campbell, R., et al. (2025). OPTIC: Optimizing patient-provider triaging & improving communications in clinical operations using GPT-4 data labeling and model distillation. arXiv preprint arXiv:2503.05701.

Small, W. R., Wiesenfeld, B., Brandfield-Harvey, B., et al. (2024). Large language model–based responses to patients’ in-basket messages. JAMA Network Open, 7(7), e2422399. https://doi.org/10.1001/jamanetworkopen.2024.22399

Steitz, B. D., Turer, R. W., Salmi, L., et al. (2025). Repeated access to patient portal while awaiting test results and patient-initiated messaging. JAMA Network Open, 8(4), e254019. https://doi.org/10.1001/jamanetworkopen.2025.4019

Tai-Seale, M., Dillon, E. C., Yang, Y., et al. (2021). Physicians’ workload and cognitive load during the use of electronic health records: Insights from eye-tracking and audit log analysis. Journal of the American Medical Informatics Association, 28(3), 472–480. https://doi.org/10.1093/jamia/ocaa301

Tawfik, D., Bayati, M., Liu, J., et al. (2024). Predicting primary care physician burnout from electronic health record use measures. Mayo Clinic Proceedings: Digital Health, 2(9), 100203. https://doi.org/10.1016/j.mcpiq.2024.01.005

Worsham, C. M., Barron, H. T., Ratwani, R. M., et al. (2024). Clinician message workload and burnout in outpatient care: A multi-site mixed methods study. BMC Health Services Research, 24(1), 11686. https://doi.org/10.1186/s12913-024-11686-6

Xia, L., Lew, D., Baratta, L., et al. (2025). Association between conversational multitasking and clinician work behaviors at a large US health care system: Cohort study. Journal of Medical Internet Research, 27, e72768. https://doi.org/10.2196/72768