require(tidyverse)
require(ggplot2)
df <- read_csv("https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv")

######ANálisis principal de los datos
nrow(df) #891
ncol(df) #12
str(df) #Cambiar survived y pclass a factor, cabin y age con NA
head(df, 5)
summary(df) #survived 38%, age 177 Na, Fare puede tener outliers


##### Detección de Na
colSums(is.na(df))
(colSums(is.na(df))/nrow(df))*100 # Age 19.86%, Cabin 77%, Embarked 0.22%
df %>%
  select(where(anyNA))

#####Imputación de Na con mediana, moda y eliminar una columna
table(df$Embarked)
moda_e<- names(which.max(table(df$Embarked)))
data1 <- df %>% 
  mutate(Age = coalesce(Age, median(Age, na.rm=T))) %>% 
  replace_na(list(Embarked=moda_e)) %>% 
  select(-Cabin)
colSums(is.na(data1))

##### Outliers
Q1 <- quantile(data1$Fare, 0.25, type = 7)
Q3 <- quantile(data1$Fare, 0.75, type=7)
IQR <- Q3 - Q1
Q1 #7.9104
Q3 #31
IQR #23.0896
LI <- Q1- 1.5*IQR
LS <- Q3 + 1.5*IQR
LI #LI negativo -> no hay límite inferior
LS #LS 65.6344
sum(data1$Fare > LS) #Existen 116 outliers en Fare
sum(data1$Fare>LS)/nrow(data1) # Estos equivalen al 13% de los datos
#Se priocede a revisar visaulmente los datos

### Gráficas
data1 %>% 
ggplot(aes(x=Fare))+
  geom_boxplot(
    position = "dodge2",
    outliers = TRUE,
    outlier.color = "green",
    median.color = "blue",
    box.color = "lightblue"
  )+
  labs(
    title = "Boxplot de Tarifa",
    subtitle = "Titanic dataset - 891 pasajeros",
    x= "Tarifa",
    caption = "Fuente: Kaggle Titanic Dataset"
  )+
  theme_minimal()
#La distribución de Fare es asimétrica positiva (sesgado a la derecha)
#Recomendación: Aplicar tranformación log1p(Fare)

data1 %>% 
  ggplot(aes(x=Age))+
  geom_histogram(
    binwidth = 5,
    fill = "blue",
    color = "white")+
  labs (
    title = "Distribución de edad de pasajeros",
    subtitle = "Titanic dataset - 891 pasajeros",
    x = "Edad",
    y =  "Frecuencia",
    caption = "Fuente: Kaggle Titanic Dataset")+
  theme_minimal()
#La distribución por edad tiene un pico alto en 30-35 por la imputación de la mediana

data1 %>% 
  ggplot(aes(x= Pclass))+
  geom_bar(
    fill = "lightblue",
    color = "grey")+
  labs(
    title = "Número de pasajeros por clase",
    subtitle = "Titanic dataset - 891 pasajeros",
    x = "Número de clase",
    y = "Frecuencia",
    caption =  "Fuente: Kaggle Titanic Dataset")+
  theme_minimal()
#Es notable que la clase mas baja (#3) se encuentran más pasajeros

data1 %>% 
  ggplot(aes(x=factor(Pclass), y = Fare, fill = factor(Pclass)))+
  geom_boxplot(
    color = "black")+
  labs(
    title = "Box plot de Tarifa por clase",
    subtitle = "Titanic datset - 891 pasajeros",
    x = "Clases",
    y = "Tarifa",
    fill = "Clase",
    caption = "Fuente: Kaggle Titanic Dataset")+
  theme_minimal()
# Con este gráfico se puede notar que los outliers estan situados en la clase #1
# Es lo esperado por ser la clase más cara y variable, por otro lado la distribución
# De los precios de la clase media y baja son mas uniformes, pues los precios son mas constantes