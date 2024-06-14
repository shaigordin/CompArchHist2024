# תרגיל להגשה 1

## מטעין את החבילה של ארכדאטא וקורא למידע 
install.packages("archdata")
library(archdata)
data(package="archdata")

## טוען חבילת מעגל שמחשבת מעלות ב-360
install.packages("circular")
library(circular)
options(digits=3) ## פונקציה שמגבילה ספרות אחרי הנקודה העשרונית

## קורא לנתוני קבורה באתר ארנסט וויטה
data("EWBurials")
View(EWBurials)
EWBurials$Direction

EWBurials$Direction <- circular(EWBurials$Direction, units = "degrees", template = "geographics")
  
mean(EWBurials$Direction) # מחשב ממוצע מנח קבורה במעגל
mean.default(EWBurials$Direction) # מחשב ממוצע פשוט

mean(EWBurials$Looking)
as.vector(mean(EWBurials$Looking)) + 360 # מחשב ממוצע כיוון למעלות חיוביות
mean.default(EWBurials$Looking)

# ניסויים בפונקציה מעגלית
Example1 <- circular(c(0, 90, 180, 270), units = "degrees", template = "geographics")
as.vector(mean(Example1)) # ממיר את הנתונים לווקטור

Example2 <- circular(c(0, 90, 179, 270), units = "degrees", template = "geographics")
as.vector(mean(Example2))

