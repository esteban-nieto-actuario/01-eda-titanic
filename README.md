# EDA - Titanic Dataset

| Archivo | Descripción |
|---------|-------------|
| `01_eda_titanic.R` | Análisis exploratorio inicial |
| `02_feature_engineering_titanic.R` | Transformación y creación de variables |
| `03_modelo_regresion_titanic.ipynb` | Regresión logística en Python |
| `04_RF_XGB_titanic.ipynb`| Random Forest y XG Boost en python |

## Objetivo
Análisis exploratorio del dataset del Titanic para identificar patrones en los datos, variables con valores faltantes y distribución de variables clave antes de modelar.

## Dataset
**Fuente:** Kaggle / datasciencedojo

**Dimensiones:** 891 pasajeros, 12 variables

**Variables clave:** Survived, Pclass, Age, Fare, Sex

## Hallazgos principales
- Age tiene 19.9% de valores faltantes - imputados con mediana
- Cabin tiene 77.1% de valores faltantes - variable eliminada
- Fare presenta distribución asimétrica positiva con 116 outliers (13%)
- Solo el 38% de los pasajeros sobrevivió - clases desbalanceadas
- Los outliers de Fare se concentran en la clase 1, como estaba previsto

## Metodología
1. Exploración inicial - dimensiones, tipos de variables, estadísticos
2. Detección y tratamiento de NAs
3. Detección de outliers con método IQR
4. Visualización - histograma, barplot y boxplot por grupos

## Herramientas
R, Tidyverse, ggplot2

## Recomendaciones para la siguiente etapa
- Convertir 'Survived' y 'Pclass' a factor antes de modelar
- Aplicar transformación 'log1p(Fare)' en Feature Engineering
- Evaluar la imputación múltiple para 'Age' como alternativa a la mediana

## Cómo ejecutar
1. Abrir `01_eda_titanic.R` en RStudio — requiere tidyverse y ggplot2
2. Abrir `02_fe_titanic.R` en RStudio — requiere tidyverse y corrplot
3. Abrir `04_RF_XGB.ipynb`en Google Colab o Jupyter
   — requiere pandas, numpy, sklearn, xgboost, matplotlib, seaborn

## Feature Engineering
- Variables `Survived`, `Pclass`, `Sex`, `Embarked` convertidas a factor
- `Fare` transformada con log1p para corregir sesgo positivo
- Nueva variable `familia_total` = SibSp + Parch + 1
- Nueva variable `viajasolo` (binaria)
- Nueva variable `titulo` extraída del nombre (Mr, Mrs, Miss, etc.)
- Eliminadas `SibSp` y `Parch` por multicolinealidad con `familia_total`
- Eliminadas `PassengerId`, `Name`, `Ticket` por no aportar valor predictivo

## Hallazgos del modelo de Regresión Logística
- El modelo identifica Sex, Pclass y Fare como variables 
  clave para predecir supervivencia
- Sex_male: odds ratio 0.08 — los hombres tenían 92% menos 
  probabilidad de sobrevivir que las mujeres
- Pclass_3: odds ratio 0.30 — tercera clase tenía 70% menos 
  probabilidad de sobrevivir que primera clase
- Fare: odds ratio 1.48 — tarifas más altas asociadas 
  a mayor probabilidad de supervivencia

## Comparación de modelos

| Modelo | Accuracy | AUC-ROC | F1 clase 1 |
|--------|----------|---------|------------|
| Regresión Logística | 0.80 | 0.8865 | 0.74 |
| Random Forest | 0.83 | 0.8979 | 0.79 |
| XGBoost | 0.82 | 0.8901 | 0.77 |

**Modelo ganador:** Random Forest con AUC 0.8979

**Conclusión:** Random Forest superó a los otros modelos en este dataset. XGBoost no logró superar a Random Forest porque el dataset 
es pequeño (891 registros) — el boosting secuencial necesita más datos para explotar su ventaja competitiva.

## Importancia de variables — Random Forest
- `Fare` (0.28), `Sex_male` (0.27) y `Age` (0.26) son las más influyentes
- Random Forest descubre que `Age` tiene más peso que en la regresión 
  logística porque captura relaciones no lineales (ser niño vs adulto)

## Herramientas
R · tidyverse · ggplot2 · Python · scikit-learn · XGBoost
