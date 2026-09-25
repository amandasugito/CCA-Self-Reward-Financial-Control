# Self-Reward Culture and Financial Control: Canonical Correlation Analysis

This project investigates the relationship between **Self-Reward Culture** and **Financial Control** among university students using **Canonical Correlation Analysis (CCA)**.

The analysis was conducted as part of a multivariate statistics study using questionnaire data collected from Bina Nusantara University students.

---

## 📌 Research Overview

Self-reward culture has become increasingly common among university students, particularly as a way of appreciating oneself after achieving goals or completing responsibilities. However, reward-oriented spending may also be associated with students' financial behavior.

This study examines the multivariate relationship between:

- **Self-Reward Culture**
- **Financial Control**

The relationship between these two constructs was analyzed using **Canonical Correlation Analysis (CCA)**.

---

## 🎯 Objectives

The main objective of this study is to examine the relationship between Self-Reward Culture and Financial Control among university students.

Specifically, the study analyzes:

- The validity and reliability of the measurement instrument
- The measurement model using Second-Order Confirmatory Factor Analysis (CFA)
- Multivariate normality
- Multivariate outliers
- Multicollinearity
- The canonical relationship between the two variable sets
- Canonical loadings
- Cross-loadings
- Redundancy indices

---

## 📊 Dataset

The dataset was collected through an online questionnaire distributed to undergraduate students at **Bina Nusantara University**.

### Sample

- **Initial responses:** 105 respondents
- **Multivariate outliers removed:** 4 observations
- **Final sample:** 101 respondents
- **Sampling method:** Convenience sampling
- **Measurement scale:** Six-point Likert scale (1–6)

### Research Variables

#### Self-Reward Culture

The construct consists of three dimensions:

1. Frequency of Self-Reward
2. Emotional Motivation
3. Spending Tendency in Self-Reward

#### Financial Control

The construct consists of three dimensions:

1. Consumptive Behavior
2. Financial Management
3. Financial Awareness

Each dimension consists of five questionnaire items, resulting in **30 indicators** in total.

---

## 🔬 Methodology

The analysis was conducted through several statistical procedures.

### 1. Data Cleaning

Initial data preparation was performed before statistical analysis, including the removal of unnecessary variables.

### 2. Second-Order Confirmatory Factor Analysis

A **Second-Order Confirmatory Factor Analysis (CFA)** was conducted to evaluate the measurement model of the two latent constructs.

The CFA model consists of:

```text
Self-Reward Culture
├── Frequency of Self-Reward
├── Emotional Motivation
└── Spending Tendency in Self-Reward

Financial Control
├── Consumptive Behavior
├── Financial Management
└── Financial Awareness
```

The CFA was estimated using the **Maximum Likelihood Robust (MLR)** estimator.

### 3. Validity Testing

**Pearson item-total correlation** was used to evaluate the validity of the questionnaire indicators.

An indicator was considered valid when it showed a positive and statistically significant correlation with its corresponding construct score.

### 4. Reliability Testing

Internal consistency was evaluated using **Cronbach's Alpha**.

All six dimensions obtained Cronbach's Alpha values above **0.70**, indicating satisfactory internal consistency.

| Dimension | Cronbach's Alpha |
|---|---:|
| SelfReward_D1 | 0.892 |
| SelfReward_D2 | 0.919 |
| SelfReward_D3 | 0.867 |
| FinancialControl_D1 | 0.843 |
| FinancialControl_D2 | 0.783 |
| FinancialControl_D3 | 0.836 |

### 5. Multivariate Normality

**Mardia's test** was used to evaluate multivariate normality.

The initial analysis indicated that both constructs did not satisfy the multivariate normality assumption.

Therefore, several procedures were applied:

1. Multivariate outlier detection using **Mahalanobis Distance**
2. Removal of identified multivariate outliers
3. **Item parceling** by aggregating indicators into dimensional scores
4. **Rank-Based Inverse Normal Transformation (INT)**

After parceling and transformation, both constructs satisfied the multivariate normality assumption.

| Construct | Skewness p-value | Kurtosis p-value | Result |
|---|---:|---:|---|
| Self-Reward Culture | 0.059 | 0.352 | Normal |
| Financial Control | 0.554 | 0.597 | Normal |

### 6. Multivariate Outlier Detection

Multivariate outliers were identified using **Mahalanobis Distance**.

| Description | Number of Observations |
|---|---:|
| Initial Sample Size | 105 |
| Outliers Removed | 4 |
| Final Sample Size | 101 |

### 7. Multicollinearity

Multicollinearity was evaluated using the **Variance Inflation Factor (VIF)**.

VIF was examined at both the indicator level and dimension level.

The maximum VIF values were:

| Construct | Maximum VIF |
|---|---:|
| Self-Reward Culture | 4.327 |
| Financial Control | 2.469 |

The VIF values were below the threshold of **5.0** used in this study.

### 8. Canonical Correlation Analysis

**Canonical Correlation Analysis (CCA)** was performed to investigate the multivariate relationship between Self-Reward Culture and Financial Control.

The two variable sets were defined as follows.

#### Variable Set X — Self-Reward Culture

- Frequency of Self-Reward
- Emotional Motivation
- Spending Tendency in Self-Reward

#### Variable Set Y — Financial Control

- Consumptive Behavior
- Financial Management
- Financial Awareness

The CCA analysis included:

- Canonical correlation coefficients
- Wilks' Lambda significance tests
- Canonical loadings
- Cross-loadings
- Redundancy analysis

---

## 📈 Results

### Canonical Correlation Coefficients

The canonical correlation coefficients were:

| Canonical Function | Correlation |
|---|---:|
| Function 1 | 0.663 |
| Function 2 | 0.345 |
| Function 3 | 0.029 |

The first canonical function had a canonical correlation coefficient of **0.663**.

### Significance Test

The significance of the canonical functions was evaluated using **Wilks' Lambda**.

| Tested Functions | p-value | Result |
|---|---:|---|
| Functions 1–3 | < 0.001 | Significant |
| Functions 2–3 | 0.015 | Significant |
| Function 3 | 0.779 | Not Significant |

### Canonical Loadings — Self-Reward Culture

| Dimension | Loading |
|---|---:|
| Frequency of Self-Reward | -0.740 |
| Emotional Motivation | -0.895 |
| Spending Tendency in Self-Reward | -0.940 |

### Canonical Loadings — Financial Control

| Dimension | Loading |
|---|---:|
| Consumptive Behavior | -0.975 |
| Financial Management | -0.271 |
| Financial Awareness | -0.210 |

### Cross-Loadings

| Dimension | Cross Loading |
|---|---:|
| Frequency of Self-Reward | -0.490 |
| Emotional Motivation | -0.593 |
| Spending Tendency in Self-Reward | -0.623 |
| Consumptive Behavior | -0.646 |
| Financial Management | -0.180 |
| Financial Awareness | -0.139 |

The highest cross-loadings were observed for **Spending Tendency in Self-Reward** and **Consumptive Behavior**.

### Redundancy Analysis

| Function | Self-Reward Culture | Financial Control |
|---|---:|---:|
| Function 1 | 0.326 | 0.156 |
| Function 2 | 0.013 | 0.016 |
| Function 3 | 0.000 | 0.000 |

For the first canonical function, the redundancy values were:

- **32.6%** for Self-Reward Culture
- **15.6%** for Financial Control

---

## 💡 Key Findings

The analysis identified a statistically significant multivariate relationship between **Self-Reward Culture** and **Financial Control**.

The first canonical function produced a canonical correlation coefficient of **0.663 (p < 0.001)**.

Within Self-Reward Culture, **Spending Tendency in Self-Reward** had the largest canonical loading.

Within Financial Control, **Consumptive Behavior** had the largest canonical loading.

The cross-loading results also showed that these two dimensions had the strongest associations with the opposite canonical variates.

---

## 🛠️ Tools & Packages

The analysis was conducted using **R**.

### Main R Packages

- `lavaan`
- `semPlot`
- `semTools`
- `readxl`
- `MVN`
- `bestNormalize`
- `CCA`
- `CCP`

---

## 📁 Repository Structure

```text
self-reward-financial-control-cca/
│
├── Code_AOL_Group7.R
├── A Canonical Correlation of Self-Reward Culture and Financial Control among University Students.pdf
└── README.md
```

---

## 📄 Research Paper

The complete research paper is included in this repository:

**A Canonical Correlation of Self-Reward Culture and Financial Control among University Students**

The paper contains the complete methodology, statistical results, discussion, conclusion, and references.

---

## 👩🏻‍💻 Authors

- **Amanda Sugito**
- **Asyifa Izzatil Isma**
- **Vanessa Santoso**

---

## 📚 Research Context

This project was developed as part of a **Multivariate Statistics / AOL project** and demonstrates the application of multivariate statistical techniques to behavioral and financial survey data.

The project combines measurement model evaluation and multivariate analysis to examine the relationship between self-reward behavior and financial control among university students.

---

## 📌 References

The complete list of references is available in the research paper included in this repository.

---

**Keywords:** `Canonical Correlation Analysis` · `Self-Reward Culture` · `Financial Control` · `Multivariate Statistics` · `CFA` · `CCA` · `University Students` · `R`
