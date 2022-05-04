


library(tidyverse)
library(MCOE)
library(here)
library(googlesheets4)


con <- MCOE::mcoe_sql_con()



### School Enrollment -------
#  From https://www.cde.ca.gov/ds/ad/filesenr.asp

ENROLL <- tbl(con, "ENROLLMENT") %>%
    filter(#YEAR == "19", # To match the last TK data file year 19-20
        COUNTY == "Monterey") %>%
    collect() 


enrollment.od <- ENROLL %>%
    filter(YEAR == max(YEAR)) %>%
    select(DISTRICT, SCHOOL, GR_5,GR_6, GR_8, GR_9) %>%
    group_by(DISTRICT, SCHOOL) %>%
    summarise(gr5 = sum(GR_5),
              gr6 = sum(GR_6),
              gr8 = sum(GR_8),
              gr9 = sum(GR_9),)


write.csv(enrollment.od, "Enrollment in 2021-22 by select grade.csv")


sum(enrollment.od$gr5)
