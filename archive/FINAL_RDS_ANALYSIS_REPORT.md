# Epic In-Basket Analysis: Final Dataset Exploration Report

## Executive Summary

This report presents a comprehensive analysis of the `final.rds` dataset, which contains processed Epic in-basket workload data for 64 healthcare providers. The analysis reveals significant disparities in workload distribution across provider types and identifies key patterns in message volume, response times, and system utilization.

## Dataset Overview

### Basic Structure
- **Total Providers**: 64 healthcare providers
- **Variables**: 27 columns including provider demographics, workload metrics, and performance indicators
- **Time Period**: Data aggregated over multiple months (average ~11 months per provider)
- **Data Quality**: Complete dataset with no missing values

### Provider Type Distribution
| Provider Type | Count | Percentage |
|---------------|-------|------------|
| **RF** (Resident/Fellow) | 34 | 53.1% |
| **MD** (Physician) | 26 | 40.6% |
| **NP** (Nurse Practitioner) | 4 | 6.2% |

## Key Findings

### 1. Workload Disparities by Provider Type

#### In-Basket Hours (Primary Workload Metric)
- **MDs**: Average 35.4 hours (highest workload)
- **NPs**: Average 54.0 hours (highest individual workload)
- **RFs**: Average 23.7 hours (lowest workload)

#### Message Volume
- **MDs**: Average 775 messages, 66.9 per month
- **NPs**: Average 440 messages, 64.4 per month  
- **RFs**: Average 289 messages, 24.8 per month

### 2. Message Type Analysis

#### Patient Call Messages (PC)
- Average: 105 messages per provider
- Range: 0-619 messages
- 25th percentile: 14.8, 75th percentile: 116

#### Medical Advice Requests (MAR)
- Average: 216 messages per provider
- Range: 0-850 messages
- 25th percentile: 46.5, 75th percentile: 280

#### Result Messages (RES)
- Average: 81.6 messages per provider
- Range: 0-994 messages
- 25th percentile: 2.75, 75th percentile: 70.5

#### Prescription Authorization (RXA)
- Average: 92.5 messages per provider
- Range: 0-733 messages
- 25th percentile: 4, 75th percentile: 71.2

### 3. Response Time Analysis

#### Overall Response Times
- **Average**: 3.24 days until message marked done
- **Median**: 1.53 days
- **Range**: 0-17 days

#### By Message Type
- **Patient Calls**: 3.24 days average
- **Medical Advice**: 2.72 days average
- **Results**: 4.39 days average
- **Prescriptions**: 0.448 days average (fastest)

### 4. System Utilization Patterns

#### Total System Hours
- **Average**: 245 hours per provider
- **Range**: 0.933-1690 hours
- **Median**: 191 hours

#### After-Hours Work
- **Average**: 61.9 hours per provider
- **Range**: 0-561 hours
- **Median**: 38.2 hours

### 5. Correlation Analysis

#### Strongest Correlations with In-Basket Hours
1. **System Hours**: 0.899 (very strong positive correlation)
2. **In-Basket Hours per Month**: 0.862
3. **Medical Advice Messages**: 0.787
4. **After-Hours Work**: 0.748
5. **Total Messages**: 0.736

This indicates that providers with high in-basket workloads also tend to have high system utilization and after-hours work.

## Outlier Analysis

### Identified Outliers
- **In-Basket Hours**: 1 provider with extreme workload
- **Response Time**: 2 providers with unusually long response times
- **Total Outliers**: 3 providers requiring attention

## Top Performers Analysis

### Highest Message Volume Providers (Top 10)
All top 10 providers by message volume are **MDs**, with message counts ranging from 1,163 to 1,998 messages.

**Notable Top Performer**: Provider ID 67558552
- 1,998 messages
- 65.8 in-basket hours
- 0.283 days average response time
- 549 system hours

## Workload Distribution Insights

### Quartile Analysis
- **25th Percentile**: 8.52 in-basket hours, 91.5 messages
- **Median**: 23.8 in-basket hours, 371 messages
- **75th Percentile**: 42.1 in-basket hours, 642 messages

### Efficiency Metrics
- **MDs**: 20.5 messages per in-basket hour (most efficient)
- **RFs**: 12.3 messages per in-basket hour
- **NPs**: 9.23 messages per in-basket hour

## Clinical Implications

### 1. Workload Inequity
- Significant disparities exist between provider types
- MDs bear the highest message volume burden
- Some individual providers have extremely high workloads

### 2. Response Time Concerns
- Wide variation in response times (0-17 days)
- Results messages have longest average response time (4.39 days)
- Prescription authorizations are handled most efficiently

### 3. After-Hours Burden
- High correlation between in-basket workload and after-hours work
- Some providers logging over 500 hours of after-hours work

## Recommendations

### 1. Workload Redistribution
- Implement workload balancing strategies
- Consider message redistribution from high-volume providers
- Develop tiered response systems for different message types

### 2. Response Time Optimization
- Investigate factors causing long response times for results
- Implement automated responses where appropriate
- Establish response time targets by message type

### 3. After-Hours Management
- Address root causes of excessive after-hours work
- Implement coverage strategies for high-volume providers
- Consider workload-based scheduling adjustments

### 4. Provider Support
- Provide additional support for identified outliers
- Implement efficiency training programs
- Consider technology solutions to streamline workflows

## Data Quality Notes

- Dataset is complete with no missing values
- Provider IDs are anonymized for privacy
- Data represents aggregated metrics over multiple months
- All calculations account for varying observation periods per provider

## Generated Visualizations

The analysis produced the following visualizations:
1. **Provider Type Distribution**: Bar chart showing provider type counts
2. **In-Basket Hours Distribution**: Histogram by provider type
3. **Messages vs In-Basket Hours**: Scatter plot with trend lines
4. **Response Time Distribution**: Histogram by provider type
5. **Key Metrics Boxplot**: Comparative boxplots across provider types
6. **Correlation Matrix**: Heatmap of variable correlations

---

*Analysis completed on: $(date)*
*Dataset: final.rds (64 providers, 27 variables)*
*Generated by: Epic In-Basket Analysis Pipeline*
