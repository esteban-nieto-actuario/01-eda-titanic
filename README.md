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
