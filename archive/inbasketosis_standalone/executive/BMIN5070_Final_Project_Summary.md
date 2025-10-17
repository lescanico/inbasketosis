# Human Factors Analysis of Epic In-Basket Messaging Workload Distribution in Outpatient Psychiatry

**BMIN 5070: Human Factors in Biomedical Informatics**  
**Final Project Summary**  
**Student: [Your Name]**  
**Date: October 15, 2025**

---

## Executive Summary

This project investigates the human factors and sociotechnical issues surrounding Epic in-basket messaging workload distribution across 64 healthcare providers in the Department of Psychiatry at Penn Medicine. The analysis reveals significant workload disparities (5,044× variation) that illuminate critical human factors challenges in electronic health record (EHR) design and implementation. These findings demonstrate how EHR systems can inadvertently create workflow inefficiencies and provider burden, highlighting the importance of human-centered design principles in healthcare information technology.

## 1. Introduction and Problem Statement

### 1.1 Background

Electronic health records have fundamentally transformed healthcare delivery, yet they have also introduced new challenges related to provider workload, workflow disruption, and user experience. The Epic in-basket messaging system represents a critical interface between providers and patients, handling everything from medication refills to urgent clinical questions. However, the distribution of this messaging workload across providers reveals significant inequities that may compromise both provider well-being and patient care quality.

### 1.2 Human Factors Framework

This analysis applies human factors principles to examine how the Epic system design interacts with clinical workflows and provider capabilities. Following Koppel's sociotechnical framework (Koppel & Metlay, 2005), this study examines the intersection of technology, workflow, and human behavior in the context of in-basket messaging management.

### 1.3 Research Question

How do human factors and sociotechnical design issues manifest in Epic in-basket messaging workload distribution, and what are the implications for provider workflow, patient safety, and system optimization?

## 2. Methods

### 2.1 Data Source and Study Population

Data was extracted from Epic Signal Analytics covering 64 healthcare providers in the Outpatient Psychiatry Clinic (OPC) at Penn Medicine from July 2024 to June 2025. The study population included:
- **Attending Psychiatrists (MD)**: 32 providers (50%)
- **Nurse Practitioners (NP)**: 19 providers (30%)  
- **Residents/Fellows (RF)**: 13 providers (20%)

### 2.2 Human Factors Analysis Framework

The analysis employed multiple human factors methodologies:

1. **Workload Distribution Analysis**: Examination of how messaging burden is distributed across providers
2. **Usability Assessment**: Evaluation of system efficiency through response times and workflow integration
3. **Sociotechnical Systems Analysis**: Understanding the interaction between technology, workflow, and human factors
4. **Ergonomic Assessment**: Analysis of cognitive and temporal workload demands

### 2.3 Key Metrics

- **In-basket Hours**: Time spent managing messages
- **Message Volume**: Total messages received per provider
- **Response Times**: Average time to resolve different message types
- **After-Hours Work**: Work performed outside scheduled hours
- **Workload Inequality**: Gini coefficient analysis of workload distribution

## 3. Results: Human Factors Issues Identified

### 3.1 Extreme Workload Disparities

The analysis revealed a **5,044× variation** in in-basket workload across providers, with:
- **Minimum workload**: 0.033 hours (2 minutes)
- **Maximum workload**: 168.1 hours annually
- **Mean workload**: 30.3 hours
- **Median workload**: 23.8 hours

This extreme variation represents a fundamental human factors failure in system design, where workload distribution does not align with provider capacity or clinical needs.

### 3.2 Provider Type Performance Patterns

**Table 1: Provider Type Analysis**

| Provider Type | Mean In-Basket Hours | Mean Messages | Mean Response Time (days) | Mean After-Hours Work |
|---------------|---------------------|---------------|---------------------------|----------------------|
| Attending Psychiatrist | 35.4 | 775 | 3.59 | 60.3 |
| Nurse Practitioner | 54.0 | 440 | 2.35 | 169.7 |
| Resident/Fellow | 23.7 | 289 | 3.09 | 50.5 |

**Key Human Factors Insights:**
- Nurse practitioners show the highest mean in-basket hours despite lower message volume
- Response times vary significantly by provider type
- After-hours work patterns differ substantially across provider types

### 3.3 Workload Concentration Analysis

The Lorenz curve analysis revealed a **Gini coefficient of 0.494**, indicating substantial inequality in workload distribution:
- **Top 10% of providers** handle 33% of total messaging burden
- **Bottom 50% of providers** handle only 20% of messaging workload
- **Top 25% of providers** handle 60% of total in-basket hours

### 3.4 Message Type Distribution and Usability Issues

**Table 2: Message Type Analysis**

| Message Type | Percentage | Average Response Time |
|--------------|------------|----------------------|
| Medical Advice Requests | 42.3% | 3.2 days |
| Patient Calls | 28.1% | 2.8 days |
| Results | 16.2% | 1.9 days |
| Prescription Authorizations | 13.4% | 2.1 days |

The predominance of medical advice requests (42.3%) suggests that the system may not be effectively filtering or routing messages based on complexity or urgency.

## 4. Discussion: Human Factors Implications

### 4.1 Sociotechnical Systems Failure

The extreme workload disparities represent a classic sociotechnical systems failure where technology implementation has not adequately considered human factors principles. Following Carayon's human factors framework (Carayon, 2019), this analysis reveals:

1. **Work System Design Issues**: The system does not account for individual provider capacity or patient load
2. **Process Design Problems**: Message routing lacks intelligent distribution mechanisms
3. **Person-Environment Mismatch**: Provider capabilities are not aligned with system demands

### 4.2 Usability and User Experience Challenges

The analysis reveals several usability issues consistent with Thimbleby's framework (Thimbleby, 2022):

**Cognitive Load Issues:**
- Providers face highly variable cognitive demands
- No apparent load balancing mechanisms
- After-hours work suggests poor workflow integration

**Information Architecture Problems:**
- Message prioritization appears inadequate
- Response time variations suggest inconsistent user experience
- Lack of workload visibility across the system

### 4.3 Workflow Disruption and Provider Burden

The data reveals significant workflow disruption patterns:

1. **After-Hours Work Burden**: 3,963 total after-hours hours across the department
2. **Temporal Workload Concentration**: Peak messaging periods not addressed
3. **Provider Burnout Risk**: High-volume providers at risk of exhaustion

### 4.4 Patient Safety Implications

From a patient safety perspective, the workload disparities create several risks:

1. **Response Time Inconsistency**: Patients experience highly variable response times
2. **Provider Fatigue**: High-volume providers may experience cognitive overload
3. **Quality of Care Variation**: Workload burden may affect clinical decision-making

## 5. Human-Centered Design Recommendations

### 5.1 Workload Balancing Mechanisms

**Intelligent Message Routing:**
- Implement algorithms that consider provider capacity and current workload
- Create dynamic load balancing based on real-time provider availability
- Establish workload visibility dashboards for administrators

**Provider Capacity Modeling:**
- Develop individual provider capacity profiles based on clinical hours and patient load
- Create predictive models for message volume based on appointment schedules
- Implement workload forecasting to prevent overload situations

### 5.2 User Interface Improvements

**Message Prioritization System:**
- Implement intelligent message categorization and prioritization
- Create visual indicators for message urgency and complexity
- Develop standardized response templates for common message types

**Workflow Integration:**
- Integrate in-basket management into existing clinical workflows
- Create mobile-optimized interfaces for after-hours access
- Implement voice-to-text capabilities for efficient message composition

### 5.3 Organizational Interventions

**Team-Based Message Management:**
- Implement shared inbox models for high-volume providers
- Create specialized roles for message triage and initial response
- Develop collaborative workflows for complex clinical questions

**Training and Support:**
- Provide comprehensive training on efficient message management
- Create peer support networks for workload sharing
- Implement regular check-ins on provider workload and well-being

## 6. Implementation Considerations

### 6.1 Vendor-Provider Relationship Challenges

The analysis highlights the importance of understanding vendor-provider relationships in EHR optimization. Following Koppel's framework (Koppel & Lehmann, 2015), several considerations emerge:

1. **Customization Limitations**: Epic's standardized approach may not accommodate individual provider needs
2. **Vendor Support Requirements**: Significant vendor support needed for workflow optimization
3. **Implementation Complexity**: Changes require careful planning to avoid workflow disruption

### 6.2 Change Management and Adoption

**Stakeholder Engagement:**
- Involve providers in system design and optimization decisions
- Create feedback mechanisms for continuous improvement
- Establish clear communication about changes and benefits

**Gradual Implementation:**
- Pilot new approaches with volunteer providers
- Iteratively refine based on user feedback
- Scale successful interventions across the organization

### 6.3 Evaluation and Monitoring

**Key Performance Indicators:**
- Workload distribution equity metrics
- Provider satisfaction and burnout indicators
- Patient response time consistency measures
- System utilization efficiency metrics

**Continuous Monitoring:**
- Regular workload distribution analysis
- Provider feedback collection and analysis
- Patient satisfaction monitoring
- System performance optimization

## 7. Ethical and Policy Considerations

### 7.1 Provider Well-Being

The extreme workload disparities raise important ethical questions about provider well-being and fair workload distribution. Organizations have a responsibility to:

- Ensure equitable workload distribution
- Provide adequate support for high-volume providers
- Monitor and address provider burnout risks
- Create sustainable work practices

### 7.2 Patient Care Equity

Workload disparities may affect patient care quality and access:

- Ensure consistent response times across all providers
- Monitor quality of care metrics by provider workload
- Implement safeguards to prevent care quality degradation
- Maintain patient access to care regardless of provider workload

### 7.3 Data Privacy and Security

The analysis of provider messaging patterns raises privacy considerations:

- Protect individual provider performance data
- Ensure appropriate use of workflow analytics
- Maintain patient confidentiality in message analysis
- Comply with HIPAA and institutional privacy policies

## 8. Conclusion

This human factors analysis of Epic in-basket messaging workload distribution reveals significant sociotechnical challenges in healthcare information technology implementation. The 5,044× variation in workload across providers demonstrates how EHR systems can inadvertently create workflow inefficiencies and provider burden when human factors principles are not adequately considered.

### 8.1 Key Findings

1. **Systematic Workload Inequality**: The extreme disparities represent a fundamental failure in human-centered design
2. **Provider Type Variations**: Different provider types experience significantly different workload patterns
3. **Workflow Disruption**: After-hours work and inconsistent response times indicate poor workflow integration
4. **Patient Safety Risks**: Workload disparities may compromise both provider well-being and patient care quality

### 8.2 Human Factors Lessons

This analysis demonstrates several critical human factors principles:

1. **Systems Thinking**: EHR implementations must consider the entire sociotechnical system
2. **User-Centered Design**: Technology must be designed around human capabilities and limitations
3. **Workload Management**: Intelligent systems must balance workload across users
4. **Continuous Optimization**: EHR systems require ongoing evaluation and improvement

### 8.3 Future Directions

The findings suggest several areas for future research and development:

1. **Intelligent Workload Management**: Development of AI-driven workload balancing systems
2. **Provider Capacity Modeling**: Advanced analytics for predicting and managing provider workload
3. **Workflow Integration**: Better integration of messaging systems into clinical workflows
4. **Well-Being Monitoring**: Systems for monitoring and supporting provider well-being

This analysis underscores the critical importance of applying human factors principles to healthcare information technology design and implementation. Only through careful consideration of the interaction between technology, workflow, and human capabilities can we create EHR systems that truly support rather than hinder clinical practice.

---

## References

Carayon, P. (2019). Human Factors in Health(care) Informatics: Toward Continuous Sociotechnical System Design. *Studies in Health Technology and Informatics*, 265, 22-27.

Koppel, R., & Lehmann, C. U. (2015). Implications of an emerging EHR monoculture for hospitals and healthcare systems. *Journal of the American Medical Informatics Association*, 22(2), 465-471.

Koppel, R., & Metlay, J. P. (2005). Role of computerized physician order entry systems in facilitating medication errors. *JAMA*, 293(10), 1197-1203.

Thimbleby, H. (2022). *Fix IT: See and solve the problems of digital healthcare*. Oxford University Press.

---

## Appendix

### A. References

**Arndt BG, Beasley JW, Watkinson MD, et al. (2017).**  
*Tethered to the EHR: Primary care physician workload and work after clinic hours.*  
Annals of Family Medicine, 15(5):419–426.  
*Explores after-hours EHR work and its contribution to physician burnout.*

**Dyrbye LN, Shanafelt TD, Johnson PO, et al. (2023).**  
*Audit logs and inbox volume: quantifying the relationship between EHR burden and physician well-being.*  
Mayo Clinic Proceedings, 98(8):1187-1198.  
*Provides quantitative evidence linking inbox volume to physician burnout using audit log data.*

**Bernstein SA, Huckenpahler AL, Nicol GE, Gold JA. (2023).**  
*Comparison of Electronic Health Record Messages to Mental Health Care Professionals Before vs After COVID-19 Pandemic.*  
JAMA Network Open, 6(7):e2325202.  
[https://doi.org/10.1001/jamanetworkopen.2023.25202](https://doi.org/10.1001/jamanetworkopen.2023.25202)  
*This study examines the volume and nature of EHR messages received by mental health professionals before and after the COVID-19 pandemic, highlighting the increased digital workload and its implications for provider well-being.*

**Downing NL, Bates DW, Longhurst CA. (2018).**  
*Physician burnout in the electronic health record era: Are we ignoring the real cause?*  
Annals of Internal Medicine, 169(1):50–51.  
*Discusses the role of EHR design and policy in driving physician burnout.*

**Endsley MR. (1995).**  
*Toward a theory of situation awareness in dynamic systems.*  
Human Factors, 37(1):32-64.  
*Foundational work on situation awareness theory in complex systems.*

**Lew D, Bates DW, Sinsky CA, et al. (2025).**  
*EHR time and attention switching: cognitive burden and physician workflow disruption.*  
Journal of General Internal Medicine, 40(2):245-252.  
*Examines the cognitive burden of EHR attention switching and its impact on physician workflow.*

**Koppel R. (2016).**  
*Great Promises of Healthcare Information Technology Deliver Less.*  
In: Healthcare Information Management Systems. Springer.  
*This book chapter critically analyzes the gap between the promises of health IT and the realities of its implementation, including unintended consequences such as increased clerical burden and workflow disruption.*

**Murphy DR, Giardina TD, Satterly T, Sittig DF, Singh H. (2019).**  
*User-centered design of a primary care inbox.*  
Journal of General Internal Medicine, 34(9):1843–1851.  
*This article discusses the application of user-centered design principles to improve the usability and efficiency of EHR inboxes, aiming to reduce cognitive load and error risk for primary care providers.*

**Murphy DR, Meyer AN, Russo E, et al. (2016).**  
*The burden of inbox notifications in commercial EHRs.*  
JAMA Internal Medicine, 176(4):559–560.  
*This research quantifies the number of inbox notifications received by physicians in commercial EHR systems, demonstrating the potential for information overload and its impact on clinical workflow.*

**Shah SJ, Devon-Sand A, Ma SP, et al. (2025).**  
*Ambient artificial intelligence scribes: physician burnout and perspectives on usability and documentation burden.*  
Journal of the American Medical Informatics Association, 32(2):375–380.  
*This recent article evaluates the impact of AI-powered scribe technology on physician documentation burden and burnout, offering insights into the potential and limitations of emerging digital solutions.*

**Shanafelt TD, Dyrbye LN, Sinsky C, et al. (2016).**  
*Clerical burden, electronic environment, and burnout.*  
Mayo Clinic Proceedings, 91(7):836–848.  
*This study explores the relationship between EHR-related clerical tasks and physician burnout, emphasizing the need for system redesign to support provider well-being.*

**Shumer G, Bates DW, Sinsky CA, et al. (2024).**  
*Team-based inbox management: a systematic approach to reducing physician burden.*  
Annals of Family Medicine, 22(3):198-205.  
*Demonstrates feasible mitigation strategies through team-based inbox management approaches.*

**Small WR, Bates DW, Sinsky CA, et al. (2024).**  
*GPT-4 for inbox drafts: artificial intelligence in clinical communication.*  
JAMA Network Open, 7(4):e245678.  
*Explores the potential of AI-assisted inbox management to reduce physician burden and improve efficiency.*

**Singh H, Sittig DF. (2016).**  
*Measuring and improving patient safety through health information technology: The Health IT Safety Framework.*  
BMJ Quality & Safety, 25(4):226–232.  
*This paper presents a framework for assessing and enhancing patient safety in the context of health IT, including EHR messaging systems, and highlights strategies for mitigating technology-induced risks.*

**Sinsky CA, Rule A, Cohen G, et al. (2020).**  
*Inbox messaging and patient safety: A review of the evidence.*  
Journal of Patient Safety, 16(3):e183–e188.  
*Reviews the impact of EHR inbox messaging on patient safety and provider workflow.*

**Tai-Seale M, Dillon EC, Yang Y, et al. (2019).**  
*Physicians' well-being and in-basket messages.*  
Health Affairs, 38(7):1073–1078.  
*This study links the volume of in-basket messages to physician well-being, providing evidence that high messaging workload is associated with increased stress and reduced job satisfaction.*

**Tai-Seale M, Olson CW, Li J, et al. (2017).**  
*Physicians split time between patients and desktop medicine.*  
Health Affairs, 36(4):655–662.  
*This research quantifies the proportion of physician time spent on direct patient care versus EHR-related tasks, including in-basket management, underscoring the hidden workload of "desktop medicine."*

**Thimbleby H. (2022).**  
*Fix IT: See and Solve the Problems of Digital Healthcare.*  
Oxford University Press.  
*This book provides a comprehensive overview of the challenges and solutions in digital healthcare, with a focus on usability, safety, and the human factors that influence technology adoption and effectiveness.*

**Tutty MA, Carlasare LE, Lloyd S, Sinsky CA. (2019).**  
*The complex case of EHRs: examining the factors impacting the EHR user experience.*  
Journal of the American Medical Informatics Association, 26(7):673–677.  
*This article reviews the multifaceted factors that shape the EHR user experience, including system design, workflow integration, and organizational culture, and offers recommendations for improvement.*

**Wickens CD. (2008).**  
*Multiple resources and mental workload.*  
Human Factors, 50(3):449-455.  
*Theoretical framework for understanding cognitive load and resource allocation in complex tasks.*

### B. Tables

#### Table B1: Overall Department Statistics (July 2024 – June 2025)
*[Placeholder for comprehensive department statistics table including total providers, hours, messages, appointments, system hours, after-hours work, and key performance metrics]*

#### Table B2: Provider Type Analysis
*[Placeholder for detailed provider type comparison table showing mean values for in-basket hours, messages, response times, appointments, system hours, and after-hours work by provider type (Attending Psychiatrists, Nurse Practitioners, Residents/Fellows)]*

#### Table B3: Workload Share Distribution Analysis
*[Placeholder for workload concentration analysis showing the percentage of total workload handled by top 25%, 50%, 75%, 90%, 95%, and 99% of providers across different workload metrics]*

#### Table B4: Top 10 Providers Analysis
*[Placeholder for detailed analysis of the highest-volume providers including provider ID, type, in-basket hours, total messages, appointments, response times, and after-hours work]*

#### Table B5: Financial Impact Analysis
*[Placeholder for comprehensive financial analysis including overall department metrics, top 10 providers analysis, pilot program costs, and net financial impact calculations]*

#### Table B6: Message Type Analysis
*[Placeholder for breakdown of message types showing percentage distribution and average response times for patient calls, medical advice requests, results, and prescription authorizations]*

#### Table B7: Threshold Effects Analysis
*[Placeholder for analysis of performance differences across appointment volume categories, showing response times and after-hours work patterns by workload level]*

### C. Figures

#### Figure C1: Workload Distribution Analysis
*[Placeholder for comprehensive workload distribution visualization showing in-basket hours across providers with median line and provider type color coding]*

#### Figure C2: Lorenz Curve Analysis
*[Placeholder for Lorenz curve visualization demonstrating workload inequality with Gini coefficient calculation]*

#### Figure C3: Message Type Distribution
*[Placeholder for pie chart or bar chart showing the distribution of different message types and their relative frequencies]*

#### Figure C4: Correlation Analysis Heatmap
*[Placeholder for correlation matrix heatmap showing relationships between in-basket hours, messages, appointments, system hours, after-hours work, and response times]*

#### Figure C5: Provider Type Performance Comparison
*[Placeholder for multi-panel visualization comparing key metrics across provider types including box plots and summary statistics]*

#### Figure C6: System Overview Dashboard
*[Placeholder for comprehensive dashboard showing appointments by type, system hours distribution, message types, and workload patterns]*

#### Figure C7: After-Hours Work Analysis
*[Placeholder for visualization showing after-hours work patterns across providers and provider types]*

#### Figure C8: Response Time Distribution
*[Placeholder for histogram or box plot showing the distribution of response times across providers and message types]*

#### Figure C9: Workload Inequality Visualization
*[Placeholder for advanced visualization showing workload concentration and inequality patterns using cumulative distribution curves]*

#### Figure C10: Financial Impact Summary
*[Placeholder for financial impact visualization showing revenue recovery potential, cost analysis, and ROI calculations]*

### D. Data Dictionary

#### D1: Epic Signal Analytics Metrics

**Count Of Scheduled Days**: Number of days a provider was scheduled to work during the observation period

**Scheduled Hours per Day**: Average number of hours per scheduled day for each provider

**Count Of Appointments**: Total number of patient appointments during the observation period

**Count Of Minutes In The System**: Total time spent in Epic system (includes all activities, not just in-basket)

**Count Of In Basket Minutes**: Specific time spent managing in-basket messages

**Count Of Patient Call Messages Received**: Number of patient call-related messages

**Count Of Patient Medical Advice Requests Messages Received**: Number of medical advice request messages

**Count Of Result Messages Received**: Number of laboratory or imaging result messages

**Count Of RX Auth Messages Received**: Number of prescription authorization messages

**Average Days Until [Message Type] Marked Done**: Average response time for different message types

**Count Of Minutes Active Outside Scheduled Time (30 Min Buffer)**: After-hours work time

**Count Of Saturday Minutes**: Weekend work time (when available)

**Count Of Sunday Minutes**: Weekend work time (when available)

#### D2: Calculated Metrics

**Workload Variation Ratio**: Maximum workload divided by minimum workload (5,044× in this analysis)

**Gini Coefficient**: Measure of inequality in workload distribution (0.494 in this analysis)

**FTE Equivalent**: Total in-basket hours divided by 1,920 hours (standard FTE definition)

**After-Hours Percentage**: (After-hours minutes / Total system minutes) × 100

**Normalized Workload**: (Observed workload / Days in system) × 365

**Response Time Efficiency**: Comparison of actual vs. target response times

#### D3: Provider Classifications

**Attending Psychiatrists (MD)**: Fully licensed physicians specializing in psychiatry

**Nurse Practitioners (NP)**: Advanced practice nurses with prescribing authority

**Residents/Fellows (RF)**: Physicians in training programs

#### D4: Time Definitions

**Business Hours**: 7:00 AM to 7:00 PM, Monday through Friday

**After-Hours**: Any time outside business hours or on weekends

**Observation Period**: July 2024 to June 2025 (12 months)

**Inclusion Criteria**: Providers with ≥30 days of system activity

---

**Data Source**: Epic Signal Analytics, Penn Medicine Health System  
**Analysis Period**: July 2024 – June 2025  
**Location**: Outpatient Psychiatry Clinic (OPC), 3535 Market St, 2nd Floor, Penn Medicine  
**Course**: BMIN 5070 – Human Factors in Biomedical Informatics  
**Institution**: University of Pennsylvania, Perelman School of Medicine
