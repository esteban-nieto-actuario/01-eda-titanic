# EDA - Titanic Dataset

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
Abrir '01_eda_titanic.R' en RStudio y ejecutarlo completo.
La paquetería necesaria es tidyverse y ggplot2.

## Feature Engineering
- Variables `Survived`, `Pclass`, `Sex`, `Embarked` convertidas a factor
- `Fare` transformada con log1p para corregir sesgo positivo
- Nueva variable `familia_total` = SibSp + Parch + 1
- Nueva variable `viajasolo` (binaria)
- Nueva variable `titulo` extraída del nombre (Mr, Mrs, Miss, etc.)
- Eliminadas `SibSp` y `Parch` por multicolinealidad con `familia_total`
- Eliminadas `PassengerId`, `Name`, `Ticket` por no aportar valor predictivo

## Archivos
|            Archivo                 |             Descripción                |
|------------------------------------|----------------------------------------|
| `01_eda_titanic.R`                 | Análisis exploratorio inicial          |
| `02_feature_engineering_titanic.R` | Transformación y creación de variables |
