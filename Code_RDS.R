library(foreign)
library(Matrix)
library(lme4)


###Descriptive####
dataRDS <- read.dta("RDS_data_wide.dta")
i <- c(2002,3077,3310,3488,4015,4079,4117,4144,4171,4335,4375,4469,4484,4540)
dataRDS_new <- subset(dataRDS, !(dataRDS$id %in% i))
summary(dataRDS_new$id)

summary(dataRDS_new$agecat)
summary(dataRDS_new$cob)
summary(dataRDS_new$educat)
summary(dataRDS_new$ams)
summary(dataRDS_new$income)


summary(dataRDS$idealtime)
summary(dataRDS$incentive)
summary(dataRDS$amountBon)


dataRDS$amount <- dataRDS$amountBon
summary(dataRDS$amount)
print(dataRDS$amount)
dataRDS$amount <- ifelse(is.na(dataRDS$amount), dataRDS$amount <- dataRDS$amountDon, dataRDS$amount <- dataRDS$amountBon)
dataRDS$amount <- as.factor(dataRDS$amount)
summary(dataRDS$amount)

summary(as.numeric(dataRDS$invitefactors_1))
sd(as.numeric(dataRDS$invitefactors_1), na.rm=T)

summary(as.numeric(dataRDS$invitefactors_2))
sd(as.numeric(dataRDS$invitefactors_2), na.rm=T)

summary(as.numeric(dataRDS$invitefactors_3))
sd(as.numeric(dataRDS$invitefactors_3), na.rm=T)

summary(as.numeric(dataRDS$invitefactors_4))
sd(as.numeric(dataRDS$invitefactors_4), na.rm=T)

summary(as.numeric(dataRDS$invitefactors_5))
sd(as.numeric(dataRDS$invitefactors_5), na.rm=T)

summary(as.numeric(dataRDS$invitefactors_6))
sd(as.numeric(dataRDS$invitefactors_6), na.rm=T)

summary(as.numeric(dataRDS$invitefactors_7))
sd(as.numeric(dataRDS$invitefactors_7), na.rm=T)

####DCE Analysis####

dataRDS <- read.dta("RDS_data_long.dta", convert.factors=F)


dataRDS$money_diff <- dataRDS$money1 - dataRDS$money0
dataRDS$time_diff = dataRDS$time1 - dataRDS$time0
dataRDS$reward_diff = dataRDS$reward1 - dataRDS$reward0
dataRDS$moneyreward_diff = dataRDS$money1*dataRDS$reward1-dataRDS$money0*dataRDS$reward0
dataRDS$timereward_diff = dataRDS$time1*dataRDS$reward1-dataRDS$time0*dataRDS$reward0
dataRDS$vig = dataRDS$vignette - 1

####Exclude Missings####

i <- c(2002,3077,3310,3488,4015,4079,4117,4144,4171,4335,4375,4469,4484,4540)
dataRDS_new <- subset(dataRDS, !(dataRDS$id %in% i))
summary(dataRDS_new$id)


####Multi level logistic regression####

mod1 <- glmer(vig ~ 0 + money_diff + time_diff + moneyreward_diff + timereward_diff + (1 | id1), family=binomial, data=dataRDS_new)
summary(mod1)
confint(mod1)

####Interaction Effects#####

#Age

dataRDS_new$agecat <- as.factor(dataRDS_new$agecat)
dataRDS_new$age <- relevel(dataRDS_new$agecat, ref = 2)

dataRDS$age_n <- relevel(dataRDS$agecat, ref = 3)
dataRDS_new$age_n <- relevel(dataRDS_new$agecat, ref = 3)

mod_age <- glmer(vig ~ 0 + money_diff + time_diff + money_diff:age + time_diff:age_n +(1 | id1), family=binomial, data=dataRDS)
summary(mod_age)


#Income
dataRDS_new$income <- as.factor(dataRDS_new$income)
summary(dataRDS_new$income)
dataRDS_new$income_new <- ifelse(is.na(dataRDS_new$income), print("unknown"),print(dataRDS_new$income))
dataRDS_new$income_new <- as.factor(dataRDS_new$income_new)
summary(dataRDS_new$income_new)

dataRDS_new$income_new <- factor(dataRDS_new$income_new, levels=rev(levels(dataRDS_new$income_new)))
summary(dataRDS_new$income_new)
mod_income <- glmer(vig ~ 0 + money_diff + time_diff + time_diff:income_new + (1 | id1), family=binomial, data=dataRDS_new)
summary(mod_income)
