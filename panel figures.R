##This script is for importing ANZNN spreadsheet, cleaning data and making figures for dashboard 
###########################################################################

# Load requires packages 

library(tidyverse)
library(viridis)
library(RColorBrewer)
library(wesanderson)
library(MetBrewer)
library(plotly)

##Import and clean data 

# Will need to update for cloud and update data set 

testdata <- read.csv(
  "~/Dropbox/Consultant/Joan Kirner/QI dashboard/Dec21 Jan22 Feb22  Small babies workbook.csv", na.strings="n/a")


#select variables 
data <- testdata %>% 
  
  select (
  
  Inborn..outborn, Birth.Month, Discharge.month, 
  Corrected.gestation, MoAge, Prevprem, PrevPnd,
  AssistConc, Ethnicity, 
  Indig, PTL, PET, APH, IUGR, F_distress, MomAntib, 
  Chorio.on.placental.histop,
  Steroids, Any.steroids.AN, MagSulphate24, Any.MGSO4,
  Plurality, BrthOrd, DOB, DOBTime, SEX,
  Wght, BW.Zscore, Gest, Gestdays
  
) %>% 

#rename variables 
  
  rename(
    
  inborn_outborn=Inborn..outborn, birth_month=Birth.Month,
  discharge_month=Discharge.month, 
  corrected_gestation=Corrected.gestation, mat_age=MoAge,
  pre_prem=Prevprem, prev_pnd=PrevPnd, assist_conc=AssistConc, 
  ethnicity=Ethnicity, indigenous=Indig, preterm_labour=PTL,
  pet=PET, aph=APH, iugr=IUGR, fetal_distress=F_distress,  
  maternal_ab=MomAntib, chorio=Chorio.on.placental.histop, 
  steroids=Steroids, 
  an_steroids_any=Any.steroids.AN,
  mgso4=MagSulphate24, mgso4_any=Any.MGSO4,
  plurality=Plurality, birth_order=BrthOrd, 
  dob=DOB, dob_time=DOBTime, 
  sex=SEX, weight=Wght, bw_zscore=BW.Zscore, gest_weeks=Gest, 
  gestation_days=Gestdays
  
) 
  
view(data)

#set correct variable type 
  
  data$inborn_outborn <-as.factor(data$inborn_outborn)

view(data)

## Western health colors green=C0D282  blue=5091BE, purpl=533C73
## Panel1 -------------------------------------------------



field1 <- ggplot (data, aes(gest_weeks, steroids, fill=factor(an_steroids_any)))

field1a <- field1 + geom_col()

field1a

field1b <- field1a  + 
  labs(x="Gestational age (weeks)",y = "Antenatal steroid exposure") + 
    theme_classic() +
      theme(text=element_text(size=10)) + 
          guides(size="none", alpha="none", fill=guide_legend("Antenatal steroids")) + 
           scale_fill_manual(values = c("#8CC4DA", "#E8CD85"), labels=c("No", "Yes"))

field1b

ggplotly(field1b) %>% 
  layout(legend = list(orientation = "h", x = 0.4, y = -0.2))

#wes_palette("", n = 5)

#Generate image for panel 1 and save it to directory 
png("www/field1.png")
print(field1b)
dev.off() 

## Panel2 -------------------------------------------

field2 <- ggplot (data, aes(gest_weeks, weight, color=factor(sex)))

field2a <- field2 + geom_point(aes(alpha=0.5))

field2a

field2b <- field2a  + labs(x="Gestation", y = "Birth weight") + 
  theme_classic() +
    theme(text=element_text(size=5),
          guides(size="none", alpha="none", fill="none"), 
                 color=guide_legend("sex"), alpha="none") + 
  scale_color_manual(values = c("#8CC4DA", "#824d83"), labels=c("No", "Yes"))

field2b

ggplotly(field2b)%>% 
  layout(legend = list(orientation = "h", x = 0.4, y = -0.2))

#Generate image for field 2 and save it to directory 
png("www/field2.png")
print(field2b)
dev.off() 

## Panel3 ---------------------------------------

field3 <- ggplot (data, aes(gest_weeks, weight, color=factor(ethnicity)))

field3a <- field3 + geom_jitter(aes (size=steroids, alpha=0.5), width=0.3)

field3a

field3b <- field3a + 
  labs(x="Gestation",y = "Birth weight") + 
    theme_classic() +
     theme(text=element_text(size=25), 
      plot.title = element_text(hjust = 0.5),
       plot.subtitle = element_text(hjust = 0.5)) + 
        guides(size="none", alpha="none", fill="none", color="none") + 
          scale_radius(range = c(1, 10)) +
           scale_color_manual(values = wes_palette("Darjeeling1", n = 5))

field3b

ggplotly(field3b)

#Generate image for field 3 and save it to directory 
png("www/field3.png")
print(field3b)
dev.off() 


## Panel4 ---------------------------------------

field4 <- ggplot (data2, aes(birth_month, weight, color=factor(ethnicity)))

field4a <- field4 + geom_point(aes (size=weight, alpha=0.5))

field4a

field4b <- field4a + 
  labs(x="Gestation", y = "Birth weight") + 
    theme_classic() +
    theme(text=element_text(size=20), 
      plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5)) + 
          guides(size=guide_legend("Weight"), alpha="none", fill="none", 
            color=guide_legend("Ethnicity")) + 
              scale_radius(range = c(1, 10)) +
                scale_color_manual(values=met.brewer("Greek", 5))

field4b

#Generate image for field 4 and save it to directory 
png("www/field4.png")
print(field4b)
dev.off() 

## Panel5 ---------------------------------------

field5 <- ggplot (data2, aes(birth_month, weight, color=factor(ethnicity)))

field5a <- field5 + geom_point(aes (size=weight, alpha=0.5))

field5a

field5b <- field5a + 
  labs(x="Gestation", y = "Birth weight") + 
    theme_classic() +
      theme(text=element_text(size=20), 
        plot.title = element_text(hjust = 0.5),
          plot.subtitle = element_text(hjust = 0.5)) + 
           guides(size=guide_legend("Weight"), alpha="none", fill="none", 
            color=guide_legend("Ethnicity")) + 
              scale_radius(range = c(1, 10)) +
                scale_color_manual(values=met.brewer("Greek", 5))

field5b

#Generate image for field 4 and save it to directory 
png("www/field5.png")
print(field5b)
dev.off() 
