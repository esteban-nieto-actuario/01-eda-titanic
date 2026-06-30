require(corrplot)
require(tidyverse)

# Cargar dataset ya limpio del Día 1 (NAs tratados, outliers identificados)
# data1 viene del script 01_eda_titanic.R

### Corrección de tipos de variables y transformaciones
data1 <- data1 %>% 
  mutate(Survived = as.factor(Survived),
         Pclass = as.factor(Pclass),
         Sex = as.factor(Sex),
         Fare = log1p(Fare),
         Embarked = as.factor(Embarked))
str(data1)
summary(data1)

data1 <- data1 %>% 
  mutate(familia_total = SibSp + Parch + 1) %>% 
  mutate(viajasolo = ifelse(familia_total == 1,1,0)) %>% 
  mutate(titulo = str_extract(Name, '[A-Za-z]+\\.'))
str(data1)

### Mátriz de correlaciones
matriz <- data1 %>% 
  select_if(is.numeric) %>% 
  cor()

corrplot(matriz,
         method = "color",
         addCoef.col = "black",
         tl.col = "black",
         number.cex = 0.7)
## Hallazgos
#Correlaciones positivas fuertes familia_total con SibSp (0.89) y Parch (0.78)
#Correlaciones negativas fuertes y medias, Viaja solo con SibSP, Parch y Familia Total
#Decisión - Eliminar SibSp y Parch por multicolinealidad

# Eliminación de SibSp y Parch por valores redundantes y variables sin valor predictivo
data1 <- data1 %>% 
  select(-Parch, -SibSp, -Ticket, -Name, -PassengerId)
colnames(data1)

# Matriz de correlaciones limpia
Matriz2 <- data1 %>% 
  select(where(is.numeric)) %>% 
  cor()

corrplot(Matriz2, 
         method = "color",
         addCoef.col = "black",
         tl.col = "darkblue",
         number.cex = 0.7)

## Hallazgos finales
# Age-viajasolo con correlación baja (0.17):
# Entre más edad tienes mas probabilidad de viajar solo
# Fare-Familia_total con correlación débil (0.38):
# Las familias más numerosas tienden a pagar más (Por mayor número de boletos)