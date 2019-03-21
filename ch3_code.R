#-------------------------------------------------------------------------------------
# 모든 챕터는 실습 코드 첨부할 것
# for, while 등 반복문
# if, if_else
# function()
# gather, spread
# Tidyverse : select, filter, mutate, arrange, group_by, summarise
#-------------------------------------------------------------------------------------

library(tidyverse)


#########################################
## 데이터 가져오기
#########################################

# Google Spreadsheet에서 가져오기
# https://docs.google.com/spreadsheets/d/e/2PACX-1vRgV6xzWwwgjKthRQuPmc-WPCOHOvZfRkAjzOHC38UhkpLsfS4rjCGVM9AH7FMEgsLk5FncY9PhugFT/pub?gid=1014557408&single=true&output=csv

# 방법1
patient_df <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vRgV6xzWwwgjKthRQuPmc-WPCOHOvZfRkAjzOHC38UhkpLsfS4rjCGVM9AH7FMEgsLk5FncY9PhugFT/pub?gid=1014557408&single=true&output=csv", stringsAsFactors = FALSE, fileEncoding = "utf-8")

# 방법2
patient_df <- read.csv("patient.csv", stringsAsFactors = F, fileEncoding = "utf-8")

# 구조 확인
str(patient_df)

# 요약해보기
summary(patient_df)

# 미리보기 
head(patient_df)
lapply(patient_df, is.numeric) #이건 지금 알 필요는 없음


#########################################
## 데이터 정제해보기
#########################################

# 칼럼이름 변경하기 (고혈압, 당뇨, 이상지질혈증, 폐결핵)
colnames(patient_df) <- c("year", "gu", "gender", "real_patient", "hypertension", "diabetes", "dyslipidemia", "tuberculosis")

# 다시 확인
head(patient_df)

# 문자형을 숫자형으로 변환해주기
as.numeric(patient_df$diabetes)

# 쉼표 없애주기 4열부터 8열까지 반복을 피하기 위해 for문을 배워보자
patient_df[,4] <- str_replace_all(patient_df[,4], ",", "")
patient_df[,4] <- as.numeric()

patient_df[,5] <- str_replace_all(patient_df[,5], ",", "")
patient_df[,5] <- as.numeric()

patient_df[,6] <- str_replace_all(patient_df[,6], ",", "")
patient_df[,6] <- as.numeric()

patient_df[,7] <- str_replace_all(patient_df[,7], ",", "")
patient_df[,7] <- as.numeric()

patient_df[,8] <- str_replace_all(patient_df[,8], ",", "")
patient_df[,8] <- as.numeric()

# for 반복문
for (i in 4:8) {
    patient_df[,i] <- str_replace_all(patient_df[,i], ",", "")
    patient_df[,i] <- as.numeric(patient_df[,i])
}

# row 중에 합계는 필터링 해주기 1
patient_df[which(patient_df$gender != "합계") , ]

# row 중에 합계는 필터링 해주기 2
subset(patient_df, gender != "합계")

# row 중에 합계는 필터링 해주기 3
patient_df %>% 
    filter(gender != "합계")

# 조금 더 알아보기 (복수의 조건)
a <- patient_df[which(patient_df$hypertension > 6000 |patient_df$real_patient > 6000) , ]
b <- patient_df[which(patient_df$gender != "합계" & patient_df$real_patient > 3000) , ]

a1 <- subset(patient_df, hypertension > 6000 | real_patient > 6000)
b1 <- subset(patient_df, gender != "합계" & real_patient > 3000)

a2 <- patient_df %>% 
    filter(hypertension > 6000 | real_patient > 6000)
b2 <- patient_df %>% 
    filter(gender != "합계" & real_patient > 3000)

# gather 함수로 모아보기
head(patient_df)
patient_df.tidy <- gather(patient_df, key = "category", value = "patient_count", 4:8)
patient_df.tidy2 <- gather(patient_df, key = "category", value = "patient_count", real_patient:tuberculosis)

# spread로 다시 wide형
spread(patient_df.tidy, category, patient_count)

#########################################
## 직접해보기
# 1. 데이터 가져오기
# 2. 컬럼이름 영문으로 변경하기
# 3. 숫자로 변환해보기
# 4. tidy 데이터로 변환해보기
# 5. 다시 wide로 변환해보기 (다른 변수에 저장)
# 6. tidy 데이터 중 month를 강남구의 11월, 12월만 추출
# 7. write.csv로 csv 파일로 저장하기
#########################################

# https://docs.google.com/spreadsheets/d/e/2PACX-1vQVSDG9-3h2u7_KAk4C_g4Vc50PxM1aXxqZ4w6G4f3dpdObmla4lCqDRLMZEE6bBtpTZL4lK57wkWHR/pub?gid=1581715057&single=true&output=csv

# 혹은 budongsan.csv로 활용

########### 아래에 코드를 작성해보세요 #############