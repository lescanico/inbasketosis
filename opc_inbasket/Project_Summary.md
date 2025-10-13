---
title: "Measuring the Invisible Work of Epic In-Basket Messaging in Outpatient Psychiatry"
author: "Nicolas Lescano, MD"
date: "October 2025"
subtitle: "BMIN 5070 – Human Factors in Biomedical Informatics"
---

# Executive Summary

This study quantifies the "invisible work" of Epic in-basket messaging in the Outpatient Psychiatry Clinic (OPC) at 3535 Market St, 2nd Floor, using comprehensive analysis of 64 clinicians (July 2024–June 2025). **Key findings demonstrate extreme workload variation and significant capacity expansion potential:**

**Workload Analysis:** 64 providers spent **1,941.2 hours over the 12-month period** (July 2024-June 2025) on in-basket messaging (equivalent to **1.04 FTE**, **$335,828 potential annual revenue loss** extrapolated). **Significant variation exists**: **160× variation** between highest and lowest burden providers (excluding outliers with <1 hour), with the top 10% handling **33% of total messaging burden**.

**Capacity Expansion Potential:** Analysis reveals significant opportunities for appointment capacity expansion through workload redistribution, with potential to create additional appointment slots based on **30-minute appointments (2 appointments per hour)**.

**After-Hours Work Reduction:** Current baseline of **3,962 total after-hours hours** could be significantly reduced through strategic provider offloading, demonstrating substantial efficiency improvement potential.

**Financial Impact:** **121.8% return on investment** calculated for workload redistribution scenarios, with **$78,950 net annual benefit** potential.

---

## 1. Problem Statement and Significance

### 1.1 The Invisible Work Problem

In the modern outpatient psychiatry setting, providers are tasked with managing a vast array of responsibilities through Epic in-basket messaging that extends far beyond traditional face-to-face patient care. This invisible work encompasses patient portal messages, call management, laboratory and imaging result review, prescription refills and authorizations, and inter-provider communication—each demanding clinical expertise, careful judgment, and considerable time investment.

Despite their complexity and importance, these tasks are almost entirely absent from traditional productivity metrics such as Relative Value Units (RVUs) and visit counts. This omission creates a profound disconnect between what is measured and the actual effort expended by providers, leading to a fundamental misalignment between institutional expectations and the realities of clinical practice.

Our analysis reveals that this invisible work represents a substantial burden: **1,941.2 hours over the 12-month period** (July 2024-June 2025) across 64 providers, equivalent to **1.04 full-time equivalents** and **$335,828 potential annual lost revenue** (extrapolated).

### 1.2 Extreme Workload Variation

The most striking finding of this analysis is the **160× variation** in in-basket workload across providers (excluding outliers with <1 hour). This substantial disparity reveals significant inequities in workload distribution that have important implications for provider well-being, patient care quality, and system efficiency.

**Workload Distribution Patterns:**
- **Top 10% of providers** handle **33% of total messaging burden**
- **160× variation** between highest and lowest burden providers (excluding outliers)
- **Gini Coefficient of 0.494** indicates substantial inequality in workload distribution

This variation suggests that current workload distribution mechanisms are not functioning optimally, leading to some providers being overwhelmed while others may have capacity for additional responsibilities.

### 1.3 Specialty-Specific Inequity: The Psychiatry Disadvantage

Psychiatry providers at Penn Medicine are expected to manage all patient communications independently, unlike other medical specialties where providers benefit from dedicated staff who handle substantial portions of patient communications. There is no mechanism for billing patient communication and consultation that occurs outside of scheduled visits, meaning that significant portions of provider work are uncompensated.

This inequity has measurable consequences: psychiatry providers are performing substantial amounts of uncompensated work that in other specialties would either be delegated to support staff or billed as appointments. This creates fundamental unfairness in both workload expectations and compensation models.

### 1.4 Human Factors Implications

The invisible work problem creates multiple human factors challenges:

**Cognitive overload:** Constant task-switching between patient care and messaging fragments attention and increases error risk. The **3,962 total after-hours hours** compounds decision fatigue and reduces clinical focus.

**Workload misalignment:** Traditional metrics ignore invisible work, creating unrealistic expectations and unsustainable practices that contribute to burnout.

**System design flaws:** EHR interfaces increase cognitive burden through cumbersome navigation, excessive notifications, and poor workflow integration.

**Organizational inequity:** The **5,044× workload variation** reveals inequitable distribution of invisible work, undermining trust and provider well-being.

---

## 2. Research Objectives and Methods

### 2.1 Primary Objectives

This research seeks to:
1. **Quantify the total volume and time burden** associated with Epic in-basket messaging for providers in the OPC at 3535 Market St, 2nd Floor
2. **Analyze patterns of variation** across different message types, individual providers, and scheduled hours
3. **Assess temporal distribution** of in-basket work during business hours versus after-hours
4. **Evaluate capacity expansion potential** through workload redistribution scenarios
5. **Calculate financial impact** of invisible work and potential optimization strategies

### 2.2 Data Collection Methods

The study utilizes aggregated, de-identified Epic Signal Analytics data spanning July 2024 to June 2025. The provider population includes 64 individuals with roles including Attending Psychiatrists, Psychiatric Nurse Practitioners, and Psychiatry Residents.

**Data Elements Collected:**
- Monthly counts of in-basket messages by type for each provider
- Aggregated time spent on in-basket messages
- Scheduled hours per provider per month
- Timing of message handling (business hours vs after-hours)
- Turnaround time for message closure

**Methodological Specifications:**
- **Data Period:** July 2024 – June 2025 (12 months of actual observation)
- **Constants:** 1 FTE = 1,872 hours/year; Opportunity cost = $173/hour
- **Time Periods:** All reported hours are from the actual 12-month observation period unless specifically noted as "extrapolated" or "annual"
- **Normalization:** hours_normalized = (hours_observed / days_observed) × 365
- **Inclusion:** Clinicians with ≥30 observed days
- **Message types:** Patient calls, medical advice requests, results, prescription authorizations
- **Business hours:** 7 AM to 7 PM, Monday through Friday

**Important Note on Time Periods:**
- **Raw Data:** All in-basket hours, messages, and metrics represent actual values from the 12-month observation period (July 2024 – June 2025)
- **Financial Projections:** Revenue loss and benefit calculations are extrapolated to annual values using the 12-month data
- **FTE Calculations:** Based on actual hours from 12-month period converted to FTE equivalents

---

## 3. Key Findings and Results

### 3.1 Quantitative Summary

**Total Invisible Work Burden (12-month period):**
- **1,941.2 hours over 12 months** across 64 providers
- **1.04 FTE equivalent** of provider time
- **$335,828 potential annual revenue loss** from in-basket work (extrapolated)

**Significant Workload Variation:**
- **160× variation** in in-basket workload across providers (excluding outliers)
- **Top 10% of providers** handle **33% of total messaging burden**
- **Gini Coefficient of 0.494** indicates substantial inequality

### 3.2 Provider Type Analysis

**Provider Type Performance Comparison:**

| Provider Type | Average In-Basket Hours | Average Messages | Average Response Time |
|---------------|------------------------|------------------|---------------------|
| **Nurse Practitioners** | 54.0 hours | 440 messages | 2.4 days |
| **Attending Psychiatrists** | 35.4 hours | 775 messages | 3.6 days |
| **Residents/Fellows** | 23.7 hours | 289 messages | 3.1 days |

**Key Insights:**
- Nurse Practitioners show highest in-basket hour burden but best response times
- Attending Psychiatrists handle the most messages but with longer response times
- Residents/Fellows have lowest overall burden across all metrics

### 3.3 Capacity Expansion Analysis

**Appointment Capacity Potential:**
- Based on **30-minute appointments (2 appointments per hour)**
- Workload redistribution could create substantial new appointment slots
- Current throughput analysis shows significant optimization potential

**After-Hours Work Reduction:**
- **3,962 total after-hours hours** baseline
- Strategic provider offloading could significantly reduce after-hours burden
- Potential for improved work-life balance and reduced provider burnout

### 3.4 Financial Impact Analysis

**Revenue Recovery Potential:**
- **$335,828 potential annual revenue loss** from in-basket work (extrapolated from 12-month data)
- **121.8% return on investment** for workload redistribution scenarios
- **$78,950 potential net annual benefit** calculation (extrapolated)

**Cost-Benefit Analysis:**
- Current invisible work represents substantial opportunity cost
- Redistribution strategies show positive ROI
- Investment in optimization could yield significant returns

---

## 4. Human Factors Analysis

### 4.1 Cognitive Load and Workflow Disruption

The **160× variation** in workload creates significant cognitive challenges:
- **Task-switching burden** between patient care and messaging
- **Information overload** from high message volumes
- **Context switching** across multiple patient interactions
- **Decision fatigue** from after-hours work demands

### 4.2 Error Risk and Patient Safety

Several factors increase error risk:
- **Poor interface design** lacks intelligent prioritization
- **Inadequate workflow integration** results in additional steps
- **Absence of decision support** forces manual information processing
- **High workload variation** creates inconsistent care quality

### 4.3 Provider Well-Being Impact

The invisible work burden affects provider satisfaction:
- **Unrecognized workload** contributes to burnout risk
- **Inequitable distribution** undermines team cohesion
- **After-hours demands** impact work-life balance
- **Lack of recognition** reduces job satisfaction

---

## 5. Implications for Healthcare Informatics

### 5.1 EHR Design Improvements

**Interface Enhancements Needed:**
- Advanced prioritization and categorization tools
- Better integration with clinical workflows
- Robust clinical decision support within messaging environment
- Intelligent triage and automated response capabilities

### 5.2 Capacity Management Optimization

**Workload Redistribution Strategies:**
- Real-time monitoring of provider burden
- Automated load balancing algorithms
- Collaborative message management approaches
- Team-based inbox management models

### 5.3 Quality and Safety Improvements

**System-Level Interventions:**
- Comprehensive quality metrics that capture invisible work
- Real-time monitoring of provider well-being
- Continuous improvement processes
- Enhanced provider retention strategies

---

## 6. Strategic Recommendations

### 6.1 Immediate Actions

1. **Implement workload monitoring systems** to track invisible work patterns
2. **Develop redistribution algorithms** to balance provider burden
3. **Create collaborative care models** for message management
4. **Establish provider well-being metrics** including after-hours work tracking

### 6.2 Medium-Term Initiatives

1. **EHR interface redesign** with human-centered design principles
2. **Team-based inbox management** pilot programs
3. **Automated triage systems** for routine messages
4. **Capacity planning tools** that account for invisible work

### 6.3 Long-Term Strategic Goals

1. **Standardized measurement** of invisible work across specialties
2. **Policy changes** to include messaging work in productivity metrics
3. **Technology innovation** with AI-powered message management
4. **Organizational culture** shift toward collaborative care models

---

## 7. Limitations and Future Research

### 7.1 Study Limitations

- **Scope limited** to Epic in-basket messaging within single health system
- **12-month observation period** may not capture seasonal variations
- **Saturday timestamps unavailable** may underestimate after-hours work
- **Qualitative aspects** such as cognitive load not directly measured

### 7.2 Future Research Directions

1. **Longitudinal studies** to assess trends and intervention effectiveness
2. **Multi-site validation** across different health systems and specialties
3. **Intervention research** evaluating specific solutions
4. **Patient outcome studies** examining impact on care quality

---

## 8. Conclusion

This comprehensive analysis reveals that invisible work in outpatient psychiatry represents a substantial burden with **1,941.2 hours over the 12-month period** and **$335,828 potential annual lost revenue** (extrapolated). The **160× variation** in workload across providers indicates significant inequities that require systematic intervention.

**Key Takeaways:**

1. **Significant workload variation** (160×) reveals distribution problems
2. **Significant capacity expansion potential** through workload redistribution
3. **Substantial financial impact** with positive ROI for optimization strategies
4. **Human factors challenges** affecting provider well-being and patient safety

**Strategic Imperatives:**

- **Make invisible work visible** through comprehensive measurement
- **Redistribute workload** to reduce variation and improve equity
- **Invest in optimization** with demonstrated positive returns
- **Address human factors** to improve provider experience and patient care

The path forward requires moving beyond traditional metrics to embrace a holistic view of provider effort, ensuring that invisible work becomes a recognized and valued component of healthcare delivery. Recognizing invisible work is not merely an administrative correction—it is an ethical imperative for the sustainability of modern mental healthcare.

---

## References

**Bernstein SA, Huckenpahler AL, Nicol GE, Gold JA. (2023).**  
*Comparison of Electronic Health Record Messages to Mental Health Care Professionals Before vs After COVID-19 Pandemic.*  
JAMA Network Open, 6(7):e2325202.  
*Examines increased digital workload in mental health care post-COVID-19.*

**Dyrbye LN, Shanafelt TD, Johnson PO, et al. (2023).**  
*Audit logs and inbox volume: quantifying the relationship between EHR burden and physician well-being.*  
Mayo Clinic Proceedings, 98(8):1187-1198.  
*Quantitative evidence linking inbox volume to physician burnout.*

**Murphy DR, Meyer AN, Russo E, et al. (2016).**  
*The burden of inbox notifications in commercial EHRs.*  
JAMA Internal Medicine, 176(4):559–560.  
*Quantifies inbox notifications and potential for information overload.*

**Shanafelt TD, Dyrbye LN, Sinsky C, et al. (2016).**  
*Clerical burden, electronic environment, and burnout.*  
Mayo Clinic Proceedings, 91(7):836–848.  
*Explores relationship between EHR-related tasks and physician burnout.*

**Tai-Seale M, Olson CW, Li J, et al. (2017).**  
*Physicians split time between patients and desktop medicine.*  
Health Affairs, 36(4):655–662.  
*Quantifies time spent on direct patient care versus EHR-related tasks.*

**Wickens CD. (2008).**  
*Multiple resources and mental workload.*  
Human Factors, 50(3):449-455.  
*Theoretical framework for understanding cognitive load in complex tasks.*

---

*Data Source: Epic Signal Analytics, Penn Medicine Health System*  
*Analysis Period: July 2024 – June 2025*  
*Location: Outpatient Psychiatry Clinic (OPC), 3535 Market St, 2nd Floor, Penn Medicine*