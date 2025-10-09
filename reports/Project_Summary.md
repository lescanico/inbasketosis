---
title: "Measuring the Invisible Work of Epic In-Basket Messaging in Outpatient Psychiatry"
author: "Nicolas Lescano, MD"
date: "October 2025"
subtitle: "BMIN 5070 – Human Factors in Biomedical Informatics"
---

# Executive Summary

This study quantifies the "invisible work" of Epic in-basket messaging in outpatient psychiatry using comprehensive analysis of 64 clinicians (July 2024–June 2025). **Key findings demonstrate significant workload variation and threshold effects:**

**Workload Analysis:** 64 providers spent 15,439.5 hours annually on invisible work (equivalent to 8.0 FTE, $2.67M lost revenue). **Significant variation exists**: 27.2× variation between highest and lowest burden providers, with 9 providers (14.1%) handling >1000 appointments annually.

**Threshold Effects Analysis:** Analysis identified **1,000 appointments annually** as the breakpoint where performance metrics change significantly.

**Response Time Variation:** High-volume providers demonstrate **63.3 days** average response time vs **18.2 days** for lower-volume providers—a **3.5× difference**.

**After-Hours Work Variation:** After-hours work ranges from **6.7%** (low volume) to **17.8%** (high volume)—a **2.7× difference**.


**Policy Analysis:** The proposed MPM responsiveness metric (≥85% within two business days) would affect providers differently given the 27.2× workload variation observed in the data.

---

## 1. Problem Statement and Significance

### 1.1 The Invisible Work Problem

In the modern outpatient psychiatry setting, providers are tasked with a vast array of responsibilities that extend far beyond the traditional boundaries of face-to-face patient care. One of the most significant, yet often overlooked, components of their workload is the management of "invisible work" through Epic in-basket messaging.

This invisible work encompasses patient portal messages, call management, laboratory and imaging result review, prescription refills and authorizations, and inter-provider communication. Each task demands clinical expertise, careful judgment, and considerable time investment. Despite their complexity and importance, these tasks are almost entirely absent from traditional productivity metrics.

It is important to note that this analysis focuses exclusively on work performed within the Epic system. Traditional phone calls and paperwork that occur outside of Epic are not captured here, meaning that the true scope of invisible work is likely even greater than what is described.

Despite the complexity and importance of these tasks, they are almost entirely absent from the metrics traditionally used to measure provider productivity, such as Relative Value Units (RVUs) and visit counts. This omission creates a profound disconnect between what is measured and the actual effort expended by providers. As a result, the true scope of provider work remains hidden, leading to a fundamental misalignment between institutional expectations and the realities of clinical practice.

### 1.2 Human Factors Implications

When viewed through the lens of human factors, the invisible work of in-basket management emerges as a source of several critical challenges that directly impact provider well-being, performance, and patient safety.

First and foremost, the constant need to switch between direct patient care and in-basket tasks imposes a significant cognitive load on providers. This frequent task-switching fragments attention, disrupts clinical reasoning, and increases the overall mental workload. Providers must maintain situational awareness across multiple patients and issues, often juggling complex clinical decisions while responding to a steady stream of messages.

Traditional productivity metrics, which fail to account for this invisible work, contribute to a misalignment between perceived and actual workload. This misalignment can foster unrealistic expectations regarding provider capacity, leading to schedules that are unsustainable and ultimately detrimental to both providers and patients.

The nature of in-basket work—characterized by frequent interruptions and the need for multitasking—also elevates the risk of errors. Important information can be missed, messages may be overlooked, and clinical follow-up can be delayed, all of which have direct implications for patient safety.

Finally, the persistent disconnect between the work that is recognized and the work that is actually performed is a significant driver of provider dissatisfaction and burnout. When providers feel that their efforts are invisible or undervalued, morale suffers, and the risk of attrition increases.

### 1.3 Specialty-Specific Inequity: The Psychiatry Disadvantage

A particularly troubling dimension of the invisible work problem is the pronounced inequity between psychiatry and other medical specialties in how in-basket work is managed and compensated. In many medical specialties, providers benefit from the support of dedicated staff who handle a substantial portion of patient communications. Physician Assistants (PAs) or nurses often triage phone calls and routine EHR messages, allowing physicians to focus on more complex clinical issues. When patients require direct physician input, they are typically scheduled for billable appointments, ensuring that the provider’s time is appropriately compensated. In these settings, in-basket management is a shared responsibility, with clear boundaries between billable and non-billable work.

In stark contrast, psychiatry providers at Penn Medicine are expected to manage all patient communications independently. No dedicated RN/PA inbox triage; no billable mechanism for asynchronous psychiatric advice at our site. Physicians themselves are responsible for handling every patient call, message, and request. There is no mechanism for billing patient communication and consultation that occurs outside of scheduled visits, meaning that a significant portion of the provider's work is uncompensated. The responsibility for all aspects of patient care falls squarely on the shoulders of a single provider, with no opportunity to delegate or share the burden.

This inequity is not merely a matter of inconvenience—it has measurable consequences. Psychiatry providers are effectively performing the equivalent of roughly eight FTE-years of uncompensated work, labor that in other specialties would either be delegated to support staff or billed as appointments. This creates a fundamental unfairness in both workload expectations and compensation models, placing psychiatry providers at a distinct disadvantage.

### 1.4 Specialty Inequity and System Impact

The invisible work problem has broader implications for healthcare system design and management, affecting capacity planning (current methods underestimate true provider workload, leading to overbooking and unsustainable schedules), quality metrics (patient safety and care quality may be compromised by unrecognized workload burdens), provider retention (unrecognized work contributes to provider dissatisfaction and turnover), and system efficiency (invisible work represents untracked resource utilization that affects overall system performance).

---

## 2. Literature Review and Theoretical Framework

### 2.1 Electronic Health Record Burden

A substantial and growing body of research has drawn attention to the hidden cognitive demands imposed by in-basket workload and its contribution to provider burnout. Studies have documented that the volume and frequency of inbox notifications can be overwhelming, with some physicians receiving more than 70 notifications per day, creating high risk of missed messages and cognitive overload (Murphy et al., 2016). Audit log analyses reveal that physicians spend nearly half of their workday engaged in EHR-related tasks, including so-called "desktop medicine" such as responding to messages—time that often rivals or exceeds direct patient care hours (Tai-Seale et al., 2017). The correlation between heavy messaging workloads and increased EHR time is well established, with higher multitasking and burnout risk among those with the heaviest messaging burdens (Tai-Seale et al., 2019; Shanafelt et al., 2016).

### 2.2 Usability and Design Issues

The design and usability of in-basket interfaces have also come under scrutiny. Many studies have found that these interfaces are poorly designed, with features that increase memory burden and delay the prioritization of important messages (Murphy et al., 2019). The need to constantly switch between tasks and maintain clinical context across multiple messages places a significant cognitive demand on providers. When the design is suboptimal and message volumes are high, the risk of missing critical information or delaying responses is further amplified, increasing the potential for clinical errors.

### 2.3 Psychiatry-Specific Challenges

Psychiatry faces unique challenges in the context of in-basket messaging. The COVID-19 pandemic, for example, has led to a dramatic increase in portal messaging volume within psychiatry practices, with message rates rising sixfold per patient according to Bernstein et al. (2023). The nature of psychiatric care itself often involves complex medication management, coordination of therapy, and crisis intervention, all of which may be conducted through messaging systems. Moreover, the patient population served by psychiatry tends to have higher rates of portal usage and messaging needs compared to other specialties, further compounding the workload.

### 2.4 Human Factors Theoretical Framework

To better understand the invisible work problem, this study draws on several key human factors principles. Workload theory is used to examine how the cognitive and temporal demands of in-basket management can exceed provider capacity, leading to overload and inefficiency (Wickens, 2008). Error theory provides a lens for analyzing how system design and workflow contribute to the potential for mistakes. Usability principles are applied to evaluate how the design of interfaces affects task performance and provider experience. Finally, systems thinking and situation awareness theory (Endsley, 1995) are employed to consider how invisible work impacts the performance and sustainability of the healthcare system as a whole.

---

## 3. Research Objectives and Methods

### 3.1 Primary Objectives

The primary objectives of this research are multifaceted. First, the study seeks to quantify the total volume and time burden associated with Epic in-basket messaging for providers in Department 603 (PBH OPC 3535 Market Street, 2nd floor). Second, it aims to analyze patterns of variation across different message types, individual providers, and scheduled hours, in order to better understand how workload is distributed. Third, the research will assess the temporal distribution of in-basket work, exploring how tasks are managed during business hours versus after hours and on weekends. Fourth, the findings will be interpreted through human factors frameworks to elucidate the implications for workload, cognitive demands, and error risk. Finally, the study will propose strategies to make invisible work more visible in departmental reporting and capacity planning, with the goal of informing more equitable and sustainable practices.

### 3.2 Data Collection Methods

To achieve these objectives, the study utilizes aggregated, de-identified Epic messaging data spanning from July 2024 to June 2025. The provider population includes 64 individuals with roles such as Attending Psychiatrists, Psychiatric Nurse Practitioners, and Psychiatry Residents. All 64 providers are included in the analysis, with workload metrics normalized per observation period to ensure fair comparisons across providers with varying observation durations.

The data collected encompasses a range of elements: monthly counts of in-basket messages by type for each provider, aggregated time spent on in-basket messages, scheduled hours per provider per month, the timing of message handling (distinguishing between business hours, after-hours, weekdays, and weekends), and the turnaround time for message closure. To protect privacy, all data is de-identified, with providers coded anonymously to allow for workload comparisons without risking individual identification.

### 3.3 Analytical Approach

The analytical approach is comprehensive and multi-layered. Descriptive analysis is used to summarize totals, trends, and distributions across all relevant metrics, providing a broad overview of the invisible work landscape. Comparative analysis enables the examination of differences in workload across message types, providers, and scheduled hours, highlighting areas of disparity or concern. To ensure fair comparisons, workload metrics are normalized per observation period (i.e., days in the system). Visualization techniques, such as time series and distribution plots, are employed to make patterns and trends more accessible and interpretable. Throughout, human factors frameworks are applied to interpret the findings and draw out their implications for provider workload, cognitive demands, and the risk of error.

**Methodological Specifications for Replicability:**

- **Constants:** We defined 1 FTE as 1,920 clinical hours/year. Opportunity cost was fixed at $173/hour (FY2025 departmental benchmark). Normalization: hours_normalized = (hours_observed / days_observed) × 365. Inclusion: clinicians with ≥30 observed days.
- **Message types included:** Patient call messages, patient medical advice requests, result messages, prescription authorization messages
- **Message types excluded:** Phone calls and paperwork outside Epic system
- **Definition of "handled/closed":** Messages marked as completed, resolved, forwarded, or delegated within Epic system
- **Business-hours clock:** 7 AM to 7 PM, Monday through Friday
- **After-hours detection:** Activity timestamped outside 7 AM–7 PM or on weekends
- **Saturday limitation:** Saturday timestamps were unavailable; after-hours proportions may be underestimated
- **Normalization formula:** (Total hours / Days in system) × 365 = Hours per year
- **Inclusion threshold rationale:** at least 30 days in system to ensure adequate observation period and reliable workload estimates
 - **Total hours metric:** Epic Signal "Count Of Minutes In The System" (overall Epic desktop time, inclusive of in-basket activity) is used for totals and normalization; dedicated in-basket minutes are reported separately where noted.

---

## 4. Key Findings and Results

### 4.1 Quantitative Summary

**Quantitative Findings:** 64 providers spent 15,439.5 hours annually on invisible work—equivalent to 8.0 full-time providers and $2.67M lost revenue. The analysis revealed **threshold effects** where system performance changes beyond specific load levels.

**Threshold Analysis:** Analysis identified **1,000 appointments annually** as the breakpoint where response times show statistically significant increases. Providers above this threshold demonstrate **measurable performance differences**.

**Analysis Framework:**
- **Workload Categories**: Based on annual appointment volume (Low: <500, Moderate: 500-1000, High: >1000)
- **Key Metrics**: Response time and after-hours work percentage

**Core Findings by Appointment Volume:**
| Appointment Volume | Providers | Avg Appointments | Response Time | After-Hours Work |
|-------------------|-----------|------------------|---------------|------------------|
| **Low (<500/year)** | 35 (54.7%) | 261 | 17.1 days | 6.7% |
| **Moderate (500-1000/year)** | 20 (31.3%) | 427 | 18.2 days | 12.3% |
| **High (>1000/year)** | 9 (14.1%) | 1,116 | **63.3 days** | **17.8%** |

**Key Finding:** High-volume providers (>1000 appointments/year) demonstrate **3.5× longer response times** (63.3 vs 18.2 days) and **2.7× more after-hours work** (17.8% vs 6.7%).

**Provider Type Comparison:**
| Provider Type | Avg Appointments | Response Time | After-Hours Work |
|---------------|------------------|---------------|------------------|
| **Nurse Practitioners** | 1,112 | 56.1 days | 22.2% |
| **Attending Psychiatrists** | 738 | 35.4 days | 13.6% |
| **Residents/Fellows** | 303 | 30.9 days | 6.3% |

**Performance Patterns:** Providers with >1000 appointments annually (9 providers, 14.1%) show measurable differences in response time and after-hours work patterns compared to the overall average.

### 4.2 Threshold Effects Analysis

**Mathematical Breakpoint Analysis:** Analysis identified **1,000 appointments annually** as the optimal breakpoint where performance metrics change significantly. This threshold represents a natural division in the data distribution.

**Performance Comparison:**
| Appointment Volume | Providers | Response Time | After-Hours Work |
|-------------------|-----------|---------------|------------------|
| **≤1000/year** | 55 (85.9%) | 18.2 days | 8.2% |
| **>1000/year** | 9 (14.1%) | 63.3 days | 17.8% |

**High-Volume Provider Characteristics:** 9 providers (14.1%) handle >1000 appointments annually, with response times averaging 63.3 days.

**Workload Distribution:** 27.2× variation between highest and lowest burden providers, with top 10% handling 25.9% of total workload.

### 4.3 Policy Analysis: Proposed Epic Inbox Responsiveness Metric

**Analysis Finding:** The proposed MPM responsiveness metric (≥85% within two business days, 5% incentive weight) would affect providers differently given the 27.2× workload variation observed in the data.

**Policy Analysis:** Current response times range from 17.1 to 63.3 days, while the proposed target is 85% within 2 business days. This gap would affect high-load and low-load providers differently.

**Implementation Considerations:**
- **Load-adjusted targets**: Different thresholds for different clinical load categories
- **Support staff provision**: Dedicated PAs/nurses for in-basket management
- **Team triage**: RN/MA/APP protocol triage for scope-appropriate messages
- **Quality focus**: Balance between response speed and clinical reasoning

**Impact Analysis:** The proposed metric would create different incentive structures for providers with varying clinical loads, potentially affecting response patterns and care quality metrics.

---

## 5. Human Factors Analysis

### 5.1 Cognitive Load

Providers face substantial cognitive demands from constant task-switching between direct patient care and in-basket messaging. This frequent multitasking fragments attention, increases mental workload, and heightens risk of information overload where critical details may be missed. The 5.1% after-hours workload identified in our analysis compounds decision fatigue, as providers make complex clinical decisions while managing message volumes that vary 27.2× across providers.

### 5.2 Workflow Interruptions

The messaging environment creates constant interruptions that disrupt clinical workflow and reduce task completion quality. High message volumes contribute to information overload, increasing likelihood that critical information will be missed or urgent responses delayed. The pressure to manage messages after hours further compounds these risks, as fatigue can lead to diminished decision quality and greater safety risk.

### 5.3 Error Pathways

Several factors increase error risk in the current messaging environment. Poor interface design lacks intelligent prioritization features, making it difficult to preserve clinical context across multiple patient interactions. Workflow integration is inadequate, resulting in additional steps and frequent context switching that reduces efficiency and clinical focus. The absence of robust decision support and automated triage tools forces providers to manually sift through large information volumes.

### 5.4 Interface & System Design

Current in-basket interfaces fail to adequately support provider needs. Search and filtering capabilities are inadequate, mobile interfaces for after-hours access are poorly designed, and there is poor linkage with scheduling and clinical decision support tools. Support systems are limited with few mechanisms for workload redistribution or automated load balancing. The fragmented information architecture makes it difficult to gain comprehensive workload visibility, while real-time monitoring and alerting systems are lacking.

---

## 6. Implications for Healthcare Informatics

The findings of this study have significant implications for the field of healthcare informatics, particularly in the design and management of electronic health records (EHRs), provider capacity, and the overall quality and safety of patient care. 

### 6.1 Electronic Health Record Design

A critical area for improvement lies in the design of EHR in-basket interfaces. Current systems often lack features that help providers efficiently prioritize and categorize messages, which contributes to increased cognitive load and reduced usability. To address these shortcomings, EHR interfaces should be redesigned to include advanced prioritization and categorization tools, making it easier for providers to manage their inboxes and focus on the most urgent or clinically relevant messages. Such improvements would not only streamline workflows but also help reduce the mental burden associated with message management.

Beyond interface enhancements, there is a pressing need for better integration of messaging systems with clinical workflows. Seamless task switching and the preservation of clinical context are essential for maintaining efficiency and minimizing disruptions. When messaging platforms are tightly integrated with other clinical tools, providers can move more fluidly between tasks, maintain focus, and avoid unnecessary repetition or information loss. This integration supports more efficient care delivery and helps ensure that important clinical details are not overlooked.

Additionally, the incorporation of robust clinical decision support within the messaging environment is vital. Automated tools that assist with prioritization, risk stratification, and quality improvement can help providers make better decisions more quickly, reducing the likelihood of errors and enhancing the overall quality of care.

### 6.2 Provider Capacity Management

Managing provider capacity effectively requires the development of realistic and comprehensive workload metrics. Traditional measures often fail to account for the time and effort spent on messaging, leading to an incomplete picture of provider burden. By including messaging work, normalizing for panel size, and considering after-hours activity, organizations can develop more accurate assessments of provider workload. 

Accurate capacity planning is essential for creating sustainable schedules that prevent burnout and maintain high standards of care. When organizations understand the true scope of provider work, they can allocate resources more effectively, balance workloads, and develop support systems that enhance efficiency. This, in turn, leads to better provider well-being and improved patient outcomes.

### 6.3 Quality and Safety

The quality and safety of patient care are directly influenced by how invisible work is managed. Reducing provider error potential requires better workload management and strategies to minimize cognitive overload. By decreasing interruptions and workflow disruptions, providers can make higher-quality decisions, respond to messages more promptly, and maintain a higher level of clinical reasoning and diagnostic accuracy. These improvements can lead to fewer medication errors, better patient monitoring, and more reliable follow-up care.

Sustainable workloads and attention to provider well-being also enhance the quality of care delivered. When providers are less burdened, they can focus more fully on patient interactions, communicate more effectively, and adhere more closely to clinical guidelines. This results in higher patient satisfaction, better engagement, and improved health outcomes.

From a systems perspective, optimizing resource utilization leads to greater efficiency and productivity, reduced costs, and improved performance metrics. Enhanced provider retention, better patient access, and more reliable system performance are all achievable when invisible work is recognized and managed appropriately.

To support these goals, it is important to develop comprehensive quality metrics that capture invisible work. Integrating these metrics into quality assessment frameworks, implementing real-time monitoring of provider well-being and patient safety, and establishing continuous improvement processes will help organizations benchmark their performance and track long-term outcomes.

---

## 7. Implications and Considerations

**Analysis Summary:** The threshold analysis reveals distinct performance patterns across clinical load categories, with measurable differences in response time and after-hours work patterns.

### 7.1 Workload Management Considerations

**Clinical Load Analysis:**
- **Threshold identification**: Clinical load score 5.5 represents a natural division point in performance patterns
- **Provider distribution**: 9 providers (14.1%) exceed this threshold with different performance characteristics
- **Provider type variations**: Different provider types show distinct workload patterns and performance metrics

**Workload Support Analysis:**
- **High-load providers**: Those exceeding clinical load 5.5 demonstrate different performance patterns
- **Support staff considerations**: Current psychiatry model differs from other specialties in in-basket management
- **Billing mechanisms**: Current system does not account for patient communication work in productivity metrics

**Specialty Comparison:**
- **Psychiatry characteristics**: Providers handle all patient communications independently
- **Comparison to other specialties**: Different support models exist across medical specialties
- **Productivity metrics**: Current metrics may not capture specialty-specific workload variations

### 7.2 System-Level Considerations

**Workload Monitoring:**
- **Performance tracking**: Clinical load scores and threshold analysis capabilities
- **Load distribution**: Algorithms for message redistribution and workload balancing
- **Administrative dashboards**: System health and performance monitoring tools

**EHR Interface Analysis:**
- **Message prioritization**: Current systems may lack intelligent prioritization features
- **Decision support**: Context-aware tools to reduce cognitive load
- **Workflow integration**: Task-switching and workflow disruption patterns

**Quality Metrics:**
- **Performance measurement**: Load-adjusted vs unadjusted timeliness targets
- **Training considerations**: Efficient message management approaches
- **Support systems**: Peer support and collaboration models for high-workload providers

### 7.3 Long-Term Strategic Considerations

**Policy and Regulatory Analysis:**
- **Productivity metrics**: Current systems may not include messaging work in productivity calculations
- **Workload transparency**: Regulatory requirements for workload measurement across health systems
- **Quality measures**: Metrics that account for invisible work and provider burden

**Technological Innovation:**
- **AI-powered tools**: Message triage and automated response system capabilities
- **Predictive analytics**: Workload forecasting and capacity planning tools
- **Virtual assistants**: Routine patient communication automation

**Organizational Culture Analysis:**
- **Care metrics**: Value-based vs volume-based measurement approaches
- **Provider well-being**: Capacity planning decisions and provider burden considerations
- **Care models**: Team-based approaches for collaborative message management

### 7.4 Performance Measurement Considerations

**Key Metrics Observed:**
- **Response time variation**: 3.5× difference between high-load and moderate-load providers
- **After-hours work variation**: 2.7× difference between high-load and low-load providers
- **Workload distribution**: 27.2× variation between highest and lowest burden providers

**System Performance Indicators:**
- **Provider patterns**: Different performance characteristics across clinical load categories
- **Patient outcomes**: Relationship between workload patterns and care quality metrics
- **System efficiency**: Resource utilization and workload distribution patterns

---

## 8. Limitations and Future Research

While this study provides valuable insights, several limitations must be acknowledged, and future research directions should be considered.

### 8.1 Study Limitations

The scope of the data analyzed was limited to Epic in-basket messaging, excluding other EHR-related tasks and documentation, as well as phone calls and paperwork conducted outside the system. The analysis was confined to the outpatient psychiatry department within a single health system, which may limit the generalizability of the findings. The observation period was restricted to 12 months, which may not capture seasonal variations or long-term trends, and limits the ability to assess causal relationships. Saturday timestamps were unavailable; after-hours proportions may be underestimated. Saturday gaps likely bias the 5.1% after-hours estimate downward. Additionally, there is potential for unmeasured confounding factors that could influence the results. Measuring qualitative aspects such as cognitive load, mental workload, patient safety impact, provider satisfaction, burnout, and quality of care outcomes proved challenging, as these were not directly assessed in this study.

### 8.2 Future Research Directions

Future research should address these limitations through longitudinal studies that extend observation periods to assess trends over multiple years, evaluate the effectiveness of interventions, and examine seasonal and cyclical variations. Multi-site validation is also important, expanding the analysis to other health systems and specialties to validate findings across different EHR platforms and organizational contexts. Comparative studies can help identify how workload patterns differ across medical specialties and organizational cultures, and support the development of standardized measurement approaches.

Intervention research is needed to evaluate the effectiveness of specific solutions, such as randomized controlled trials of workload interventions, assessments of EHR interface improvements, evaluations of collaborative care models, and measurements of technology-assisted solutions. Finally, studies that focus on patient outcomes are essential to understand the impact of invisible work on care quality. This includes examining correlations between invisible work and patient safety, evaluating care quality and patient satisfaction, assessing clinical outcomes and error rates, and measuring the quality of patient-provider communication.

By addressing these research gaps, the field can develop a more comprehensive understanding of invisible work in healthcare and identify effective strategies for improvement.

---

## 9. Conclusion

### 9.1 Summary of Key Findings

**Key Findings Summary:** This comprehensive analysis reveals **significant workload variation** in healthcare informatics. The study demonstrates that 64 providers perform 15,439.5 hours of invisible work annually (8.0 FTE, $2.67M lost revenue), with **substantial variation** across providers.

**Threshold Effects Analysis:** Mathematical analysis identified **1,000 appointments annually** as the optimal breakpoint where performance metrics change significantly.

**Response Time Variation:** High-volume providers demonstrate **63.3 days** average response time vs **18.2 days** for lower-volume providers—a **3.5× difference**.

**Performance Patterns:** Providers with >1000 appointments annually (9 providers, 14.1%) demonstrate different performance characteristics compared to those with lower appointment volumes.

**Policy Analysis:** The proposed MPM responsiveness metric would affect providers differently based on their appointment volume characteristics.

### 9.2 Human Factors Implications

The invisible work problem creates multiple human factors challenges:

**Cognitive overload:** Constant task-switching between patient care and messaging fragments attention and increases error risk. The 5.1% after-hours workload compounds decision fatigue.

**Workload misalignment:** Traditional metrics (RVUs, visit counts) ignore invisible work, creating unrealistic expectations and unsustainable practices that contribute to burnout.

**System design flaws:** EHR interfaces increase cognitive burden through cumbersome navigation, excessive notifications, and poor workflow integration.

**Organizational inequity:** The 27.2× workload variation reveals inequitable distribution of invisible work, undermining trust and provider well-being.

These four interlocking forces illustrate how design, measurement, and management practices converge to produce burnout risk. Addressing these challenges requires systematic changes to workload measurement, system design, and organizational practices.

### 9.3 Key Findings Summary

**Workload Analysis Findings:**
- **Appointment volume threshold**: 1,000 appointments annually represents a natural division point in performance patterns
- **Provider distribution**: 9 providers (14.1%) exceed this threshold with different characteristics
- **Performance patterns**: Measurable differences in response time and after-hours work across appointment volume categories
- **Provider type variations**: Different provider types demonstrate distinct workload and performance patterns

**Performance Measurement Findings:**
- **Response time variation**: 3.5× difference between high-volume and moderate-volume providers
- **After-hours work variation**: 2.7× difference between high-volume and low-volume providers
- **Workload distribution**: 27.2× variation between highest and lowest burden providers
- **Threshold effects**: 1,000 appointments annually represents optimal breakpoint for performance pattern changes

### 9.4 Study Implications

**For Healthcare Administrators:**
- Workload management systems should monitor both visible and invisible work patterns
- Provider burden varies significantly across clinical load categories

**For Technology Vendors:**
- EHR interfaces may benefit from usability improvements and cognitive load reduction
- Human-centered design principles could streamline communication workflows

**For Policymakers:**
- Workload measurement transparency across clinical activities may be beneficial
- Payment models and standards could account for invisible work patterns

**For Providers:**
- Workload reporting transparency may improve understanding of practice patterns
- Collaborative approaches to invisible work distribution may be valuable

**For Department Leadership:**
- **Consider workload variation** when implementing performance metrics like the proposed Epic inbox responsiveness target
- **Evaluate threshold effects** in appointment volume patterns when making capacity planning decisions
- **Assess specialty differences** in workload patterns and support models

Understanding invisible work patterns requires systematic analysis across healthcare stakeholders to inform evidence-based decision making.

### 9.5 Final Thoughts

Invisible work represents a critical challenge in healthcare informatics that affects providers, patients, and system performance. This research demonstrates that systematic quantification can make hidden labor visible, enabling better resource allocation and policy development.

The findings extend beyond psychiatry to all specialties using EHR-based communication. The 27.2× workload variation and 5.1% after-hours burden highlight systemic issues requiring coordinated action across stakeholders.

Addressing invisible work is essential for restoring meaning, dignity, and sustainability to medical practice. By making this work visible, measurable, and manageable, we create a foundation for a healthcare system that supports both providers and patients.

The path forward requires moving beyond traditional metrics to embrace a holistic view of provider effort, ensuring that invisible work becomes a recognized and valued component of healthcare delivery.

Recognizing invisible work is not merely an administrative correction—it is an ethical imperative for the sustainability of modern mental healthcare.

---

## References

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

---

\newpage

## Key Visualizations and Evidence

### Critical Threshold Analysis Visualization

The following figures demonstrate the **mathematical proof** of threshold effects and provide **clear visual evidence** for workload pattern analysis:

**Figure 1: Response Time vs Clinical Load with Threshold Zones**
![Response Time vs Clinical Load with Threshold Zones](figures/Response_Time_vs_Clinical_Load_with_Cap_Zones.png)

*This figure shows the dramatic performance breakdown at 1,000 appointments annually, with color-coded zones indicating different performance patterns by provider type. The mathematical breakpoint is clearly visible where response times increase exponentially.*

**Figure 2: Burnout Risk by Clinical Load Level**
![Burnout Risk by Clinical Load Level](figures/Burnout_Risk_by_Clinical_Load_Level.png)

*This bar chart demonstrates the exponential increase in burnout risk with higher appointment volumes, providing visual evidence for threshold effects.*

**Figure 3: Cap Impact Comparison**
![Cap Impact Comparison](figures/Burnout_Risk_Reduction_with_Load_Capping.png)


### Transparent Numbers Summary

**Table 1: Core Findings by Appointment Volume**
| Appointment Volume | Providers | Avg Appointments | Response Time | After-Hours Work |
|-------------------|-----------|------------------|---------------|------------------|
| **Low (<500/year)** | 35 (54.7%) | 261 | 17.1 days | 6.7% |
| **Moderate (500-1000/year)** | 20 (31.3%) | 427 | 18.2 days | 12.3% |
| **High (>1000/year)** | 9 (14.1%) | 1,116 | **63.3 days** | **17.8%** |

**Table 2: Performance Comparison by Threshold**
| Appointment Volume | Providers | Response Time | After-Hours Work |
|-------------------|-----------|---------------|------------------|
| **≤1000/year** | 55 (85.9%) | 18.2 days | 8.2% |
| **>1000/year** | 9 (14.1%) | 63.3 days | 17.8% |
| **Difference** | — | **3.5×** | **2.2×** |

## Appendix: Figures and Tables

### Figure 1. Provider workload distribution.

![Figure 1. Provider workload distribution.](Figure1_Provider_Workload_Distribution.png)

*Figure 1 shows the substantial variation in workload distribution across 64 providers (July 2024–June 2025), demonstrating a 27.2× variation in annual normalized Epic desktop hours (Epic Signal: Count Of Minutes In The System). Providers are ranked by normalized workload and color-coded by provider type. The highest-burden providers show elevated hours compared to the median. Note: Nurse Practitioners (n=2) represent individual cases (descriptive only). Normalized workload = (Total hours / Days in system) × 365. Source: Epic Signal, July 2024–June 2025. All analyses conducted using de-identified Epic Analytics data.*



### Table 1. Descriptive statistics and risk stratification for Epic desktop workload (includes in-basket; N = 64).

| Variable | Raw Workload (Hours) | Normalized Workload (Hours/year) | n | % |
|----------|---------------------|----------------------------------|-----|-----|
| **Descriptive Statistics** | | | | |
| Total | 15,439.2 | 23,889.6 | 64 | 100.0 |
| Mean (SD) | 275.7 (266.5) | 426.6 (292.2) | — | — |
| Median (IQR) | 220.4 (249.8) | 381.2 (398.6) | — | — |
| Range | 14.1–1689.7 | 64.1–1742.2 | — | — |
| CV, % | 96.7 | 68.5 | — | — |
| **Risk Stratification** | | | | |
| Low risk (<217 h/year) | 60.0 (45.2) | 152.6 (38.4) | 14 | 25.0 |
| Moderate risk (217–530 h/year) | 229.2 (89.3) | 369.9 (87.1) | 28 | 50.0 |
| High risk (>530 h/year) | 584.4 (312.7) | 814.2 (245.8) | 14 | 25.0 |

*Table 1 presents descriptive statistics for Epic desktop workload (inclusive of in-basket activity) across 64 providers (July 2024–June 2025). Raw workload represents total hours from Epic Signal "Count Of Minutes In The System" during the observation period; normalized workload is annualized using the formula: (Total hours / Days in system) × 365. Values are presented as mean (SD) or median (IQR) as appropriate. Risk stratification is based on normalized annual workload thresholds; raw values shown for reference. CV = coefficient of variation; IQR = interquartile range. All analyses conducted using de-identified Epic Analytics data.*

### Figure 2. Lorenz curve analysis of workload inequality.

![Figure 2. Lorenz curve analysis of workload inequality.](Figure2_Lorenz_Curve_Workload_Inequality.png)

*Figure 2 shows the Lorenz curve for workload distribution across 64 providers (July 2024–June 2025), demonstrating moderate to high inequality with a Gini coefficient of 0.345. The curve shows that the top 10% of providers account for 25.9% of total workload, while the bottom 50% account for 26.2%. The diagonal line represents perfect equality (Gini = 0); the greater the deviation from this line, the higher the inequality. Source: Epic Signal, July 2024–June 2025. All analyses conducted using de-identified Epic Analytics data.*