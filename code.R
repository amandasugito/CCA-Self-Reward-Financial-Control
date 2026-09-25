# ============================================================
# LOAD LIBRARY YANG DIBUTUHKAN
# ============================================================
library(lavaan)
library(semPlot)
library(semTools)
library(readxl)
library(MVN)

# ============================================================
# 1. DATA CLEANING
# ============================================================
data <- read_excel("Self-Reward Culture and Impulsive Buying (Responses) (5).xlsx")
head(data)
length(data)

data <- data[, -1]

# ============================================================
# 2. CFA SECOND ORDER (VALIDITAS KONSTRUK GLOBAL)
# ============================================================
dimensi_list <- list(
  "SelfReward_D1" = c("x1", "x2", "x3","x4","x5"),
  "SelfReward_D2"   = c("x6","x7","x8","x9","x10"),
  "SelfReward_D3"    = c("x11", "x12", "x13", "x14", "x15"),
  "FinancialControl_D1"=c("y1", "y2", "y3","y4","y5"),
  "FinancialControl_D2"=c("y6","y7","y8","y9","y10"),
  "FinancialControl_D3"=c("y11", "y12", "y13", "y14", "y15")
)

model_2ndOrder <- "
# --- Konstruk Self Reward ---
SelfReward_D1 =~ x1 + x2 + x3 + x4 + x5
SelfReward_D2 =~ x6 + x7 + x8 + x9 + x10
SelfReward_D3 =~ x11 + x12 + x13 + x14 + x15

self_reward =~ SelfReward_D1 + SelfReward_D2 + SelfReward_D3

# --- Konstruk Financial Control ---
FinancialControl_D1 =~ y1 + y2 + y3 + y4 + y5
FinancialControl_D2 =~ y6 + y7 + y8 + y9 + y10
FinancialControl_D3 =~ y11 + y12 + y13 + y14 + y15

financial_control =~ FinancialControl_D1 + FinancialControl_D2 + FinancialControl_D3
"

fit_2ndOrder <- cfa(model_2ndOrder, data = data, estimator = "MLR", std.lv = TRUE)

cat("\n\n--- HASIL MODEL CFA (SECOND ORDER) ---\n")
summary(fit_2ndOrder, fit.measures = TRUE, standardized = TRUE)

semPaths(fit_2ndOrder, "std", layout = "tree", whatLabels = "std", edge.label.cex = 0.8)

cat("\n\n--- RELIABILITAS DARI SEMTOOLS ---\n")
reliability(fit_2ndOrder)

# ============================================================
# 3. UJI VALIDITAS
# ============================================================
uji_validitas_dimensi <- function(data, dimensi_nama, item_cols) {
  skor_total <- rowSums(data[, item_cols])
  
  cat(sprintf("\n--- Validitas Dimensi: %s ---\n", dimensi_nama))
  cat(sprintf("%-10s %-15s %-15s %-15s\n", "Item", "R Hitung", "P-Value", "Status"))
  cat("------------------------------------------------------------\n")
  
  for (item in item_cols) {
    uji <- cor.test(data[[item]], skor_total, method = "pearson")
    r_hitung <- round(uji$estimate, 3)
    p_value <- round(uji$p.value, 4)
    
    status <- ifelse(p_value < 0.05, "Valid", "TIDAK Valid")
    cat(sprintf("%-10s %-15.3f %-15.4f %-15s\n", item, r_hitung, p_value, status))
  }
}

for (nama in names(dimensi_list)) {
  uji_validitas_dimensi(data, nama, dimensi_list[[nama]])
}

colnames(data)

uji_validitas <- function(data, item_cols) {
  
  cat(sprintf("%-10s %-15s %-15s %-15s\n", "Item", "R Hitung", "P-Value", "Status"))
  cat("------------------------------------------------------------\n")
  
  for (item in item_cols) {
    skor_total <- rowSums(data[, item_cols]) - data[[item]]
    
    uji <- cor.test(data[[item]], skor_total, method = "pearson")
    r_hitung <- round(uji$estimate, 3)
    p_value <- round(uji$p.value, 4)
    
    status <- ifelse(p_value < 0.1, "Valid", "TIDAK Valid")
    cat(sprintf("%-10s %-15.3f %-15.4f %-15s\n", item, r_hitung, p_value, status))
  }
}

# ============================================================
# 4. UJI RELIABILITAS
# ============================================================
cat("============================================================\n")
cat("--- UJI RELIABILITAS (CRONBACH'S ALPHA) ---\n")
cat("============================================================\n")
cat(sprintf("%-25s %-15s %-15s\n", "Dimensi", "Nilai Alpha", "Status"))
cat("------------------------------------------------------------\n")

for (nama in names(dimensi_list)) {
  item_cols <- dimensi_list[[nama]]
  k <- length(item_cols)
  
  varians_item <- sapply(data[, item_cols], var, na.rm = TRUE)
  jumlah_varians_item <- sum(varians_item)
  
  skor_total <- rowSums(data[, item_cols], na.rm = TRUE)
  varians_total <- var(skor_total, na.rm = TRUE)
  
  alpha <- (k / (k - 1)) * (1 - (jumlah_varians_item / varians_total))
  status <- ifelse(alpha >= 0.6, "Reliabel", "Tidak Reliabel")
  
  cat(sprintf("%-25s %-15.3f %-15s\n", nama, alpha, status))
}

# ============================================================
# 5. UJI NORMALITAS MULTIVARIAT (MVN)
# ============================================================
cat("\n\n============================================================\n")
cat("--- UJI NORMALITAS MULTIVARIAT (SELF REWARD & FINANCIAL CONTROL) ---\n")
cat("============================================================\n")

cat("\n--- 1. MVN: SELF REWARD (VARIABEL X) ---\n")
item_selfreward <- c(
  dimensi_list[["SelfReward_D1"]],
  dimensi_list[["SelfReward_D2"]],
  dimensi_list[["SelfReward_D3"]]
)
data_selfreward <- data[, item_selfreward]

data_selfreward <- as.data.frame(lapply(data_selfreward, as.numeric))
data_selfreward <- na.omit(data_selfreward)

uji_mvn_selfreward <- mvn(data = data_selfreward, mvn_test = "mardia")
summary(uji_mvn_selfreward, select = "mvn")

cat("\n\n--- 2. MVN: FINANCIAL CONTROL (VARIABEL Y) ---\n")
item_financial <- c(
  dimensi_list[["FinancialControl_D1"]],
  dimensi_list[["FinancialControl_D2"]],
  dimensi_list[["FinancialControl_D3"]]
)
data_financial <- data[, item_financial]

data_financial <- as.data.frame(lapply(data_financial, as.numeric))
data_financial <- na.omit(data_financial)

uji_mvn_finacial <- mvn(data = data_financial, mvn_test = "mardia")
summary(uji_mvn_finacial, select = "mvn")

# ============================================================
# 6. PENANGANAN PELANGGARAN NORMALITAS
# 6.1 Dengan Buang Outlier
# ============================================================
item_selfreward <- c(
  dimensi_list[["SelfReward_D1"]],
  dimensi_list[["SelfReward_D2"]],
  dimensi_list[["SelfReward_D3"]]
)

data_selfreward <- data[, item_selfreward]

mahal_sr <- mahalanobis(
  data_selfreward,
  colMeans(data_selfreward),
  cov(data_selfreward)
)

cutoff_sr <- qchisq(
  0.999,
  df = ncol(data_selfreward)
)

which(mahal_sr > cutoff_sr)

outlier_sr <- which(mahal_sr > cutoff_sr)

data_clean <- data[-outlier_sr, ]

nrow(data)
nrow(data_clean)

# ============================================================
# 6.2 Rank-Based Inverse Normal Transformation (INT)
# ============================================================
# Self Reward
hasil <- mvn(
  data_clean[, item_selfreward],
  mvn_test = "mardia"
)

hasil$multivariate_normality

# Financial Control
hasil <- mvn(
  data_clean[, item_financial],
  mvn_test = "mardia"
)

hasil$multivariate_normality

# ============================================================
# 6.3 Parceling (Agregasi Item menjadi Skor Dimensi)
# ============================================================
library(bestNormalize)

data_norm <- as.data.frame(
  lapply(data_clean, function(x){
    orderNorm(x)$x.t
  })
)

hasil <- mvn(
  data_norm[, item_selfreward],
  mvn_test = "mardia"
)

hasil$multivariate_normality

hasil <- mvn(
  data_norm[, item_financial],
  mvn_test = "mardia"
)

hasil$multivariate_normality

# ============================================================
# 6.4 Rank-Based Inverse Normal Transformation pada Skor Dimensi
# ============================================================
skor_dimensi <- data.frame(
  SRD1 = rowSums(data_clean[, dimensi_list[["SelfReward_D1"]]], na.rm = TRUE),
  SRD2 = rowSums(data_clean[, dimensi_list[["SelfReward_D2"]]], na.rm = TRUE),
  SRD3 = rowSums(data_clean[, dimensi_list[["SelfReward_D3"]]], na.rm = TRUE),
  FCD1 = rowSums(data_clean[, dimensi_list[["FinancialControl_D1"]]], na.rm = TRUE),
  FCD2 = rowSums(data_clean[, dimensi_list[["FinancialControl_D2"]]], na.rm = TRUE),
  FCD3 = rowSums(data_clean[, dimensi_list[["FinancialControl_D3"]]], na.rm = TRUE)
)

# Self Reward
mvn(
  skor_dimensi[, c("SRD1","SRD2","SRD3")],
  mvn_test = "mardia"
)$multivariate_normality

# Financial Control
mvn(
  skor_dimensi[, c("FCD1","FCD2","FCD3")],
  mvn_test = "mardia"
)$multivariate_normality

# ============================================================
# 7. UJI MULTIKOLINEARITAS (VIF) PER ITEM
# ============================================================
library(bestNormalize)

# Self Reward
SRD1_norm <- orderNorm(skor_dimensi$SRD1)$x.t
SRD2_norm <- orderNorm(skor_dimensi$SRD2)$x.t
SRD3_norm <- orderNorm(skor_dimensi$SRD3)$x.t
sr_norm <- data.frame(
  SRD1 = SRD1_norm,
  SRD2 = SRD2_norm,
  SRD3 = SRD3_norm
)

mvn(
  sr_norm,
  mvn_test = "mardia"
)$multivariate_normality

# Financial Control
FCD1_norm <- orderNorm(skor_dimensi$FCD1)$x.t
FCD2_norm <- orderNorm(skor_dimensi$FCD2)$x.t
FCD3_norm <- orderNorm(skor_dimensi$FCD3)$x.t
fc_norm <- data.frame(
  FCD1 = FCD1_norm,
  FCD2 = FCD2_norm,
  FCD3 = FCD3_norm
)

mvn(
  fc_norm,
  mvn_test = "mardia"
)$multivariate_normality

# ============================================================
# 8. UJI MULTIKOLINEARITAS (VIF LEVEL PARENT / SECOND ORDER)
# ============================================================
cat("============================================================\n")
cat("--- UJI MULTIKOLINEARITAS ITEM (MANUAL VIF: 1 / 1-R^2) ---\n")
cat("============================================================\n")

for (nama in names(dimensi_list)) {
  item_cols <- dimensi_list[[nama]]
  
  cat(sprintf("\n--- Dimensi: %s ---\n", nama))
  cat(sprintf("%-10s %-15s %-15s %-30s\n", "Item", "R-Squared", "Nilai VIF", "Status"))
  cat("--------------------------------------------------------------------------\n")
  
  if (length(item_cols) < 2) {
    cat(sprintf("%-10s %-15s %-15s %-30s\n", item_cols[1], "N/A", "N/A", "Item Tunggal"))
  } else {
    for (item in item_cols) {
      other_items <- item_cols[item_cols != item]
      formula_vif <- as.formula(paste(item, "~", paste(other_items, collapse = "+")))
      model_fit <- lm(formula_vif, data = data)
      
      r_sq <- summary(model_fit)$r.squared
      
      nilai_vif <- 1 / (1 - r_sq)
      
      if (r_sq == 1) {
        status <- "Perfect Multicollinearity!"
      } else if (nilai_vif < 5) {
        status <- "Tidak Ada Multikolinearitas"
      } else if (nilai_vif < 10) {
        status <- "Kolinearitas Sedang"
      } else {
        status <- "Multikolinearitas Ekstrem"
      }
      
      cat(sprintf("%-10s %-15.3f %-15.3f %-30s\n", item, r_sq, nilai_vif, status))
    }
  }
}

# ============================================================
# 9. CANONICAL CORRELATION ANALYSIS
# ============================================================
# 9.1 Canonical Correlation Coefficients
cat("============================================================\n")
cat("--- UJI MULTIKOLINEARITAS DIMENSI (LEVEL PARENT) ---\n")
cat("============================================================\n")

# 1. Mendefinisikan kelompok Parent
parent_list <- list(
  "Self_Reward" = c("SRD1", "SRD2", "SRD3"),
  "Financial_Control" = c("FCD1", "FCD2", "FCD3")
)

# 2. Menghitung VIF antar-dimensi dalam setiap Parent
for (parent in names(parent_list)) {
  dimensi_cols <- parent_list[[parent]]
  
  cat(sprintf("\n--- Parent Konstruk: %s ---\n", parent))
  
  # Matriks korelasi antar dimensi
  matriks_kor_parent <- cor(skor_dimensi[, dimensi_cols], use = "complete.obs")
  
  # Hitung VIF (Diagonal dari Invers Matriks Korelasi)
  vif_parent <- tryCatch(
    {
      diag(solve(matriks_kor_parent))
    },
    error = function(e) {
      return(rep(NA, length(dimensi_cols)))
    }
  )
  
  # Header Tabel
  cat(sprintf("%-20s %-15s %-30s\n", "Dimensi", "Nilai VIF", "Status"))
  cat("----------------------------------------------------------------------\n")
  
  for (i in 1:length(dimensi_cols)) {
    nilai_vif <- vif_parent[i]
    
    # Evaluasi ambang batas VIF
    if (is.na(nilai_vif)) {
      status <- "Perfect Multicollinearity (Singular Matrix)"
    } else if (nilai_vif < 5) {
      status <- "Tidak Ada Multikolinearitas"
    } else if (nilai_vif < 10) {
      status <- "Kolinearitas Sedang"
    } else {
      status <- "Multikolinearitas Ekstrem"
    }
    
    cat(sprintf("%-20s %-15.3f %-30s\n", dimensi_cols[i], nilai_vif, status))
  }
}

# 9.2 Significance Test of Canonical Functions
library(CCA)
X_scaled <- scale(skor_dimensi[, parent_list[["Self_Reward"]]])

Y_scaled <- scale(skor_dimensi[, parent_list[["Financial_Control"]]])

cca <- cc(X_scaled, Y_scaled)
cca$cor

# 9.3 Canonical Loadings
library(CCP)

n <- nrow(X_scaled)
p <- ncol(X_scaled)
q <- ncol(Y_scaled)

p.asym(
  cca$cor,
  n,
  p,
  q,
  tstat = "Wilks"
)

# 9.4 Cross Loadings
loadings_X <- cor(X_scaled, cca$scores$xscores)
loadings_Y <- cor(Y_scaled, cca$scores$yscores)

round(loadings_X,3)
round(loadings_Y,3)

# 9.5 Redundancy Analysis
cross_X <- loadings_X * cca$cor
cross_Y <- loadings_Y * cca$cor

round(cross_X,3)
round(cross_Y,3)
