#-------------------------------------------------------------------------------------
# 모든 챕터는 실습 코드 첨부
# for, while 등 반복문
# if, if_else
# function()
#-------------------------------------------------------------------------------------

#-------------------------------------------------------------------------------------
# for 반복문
#-------------------------------------------------------------------------------------

# 일단 콘솔에 찍어보기
for (i in 1:10) {
    print(i)
    Sys.sleep(1.0)
}

# 반복문을 돌려 연산한 값을 새로운 변수에 넣어보자
for (k in 1:10) {
    result <- k + 5
    print(result)
    Sys.sleep(1.0)
}

# 결과에 넣어주려면 placeholder 역할 벡터가 필요
result.final <- c()
for (q in 1:10) {
    result <- q + 5
    
    # 벡터의 결합 방식 떠올려보기
    result.final <- c(result.final, result)
}
print(result.final)

# 퀴즈1 : 아래의 결과는 무엇?
x <- c(2,5,3,9,8,11,6)
count <- 0

for (val in x) {
    if(val %% 2 == 0) {
        count <- count+1
    }}

# answer is 000??

#-------------------------------------------------------------------------------------
# while 반복문 : 조건이 참이면 반복문을 실행
# for는 반복 횟수를 정확하게 알아야 하고 while은 모를때 활용하면 좋다
#-------------------------------------------------------------------------------------
i <- 1
while (i < 6) {
    print(i)
    i <- i+1
}

while (i) {
    test <- i * 5
    print(test)
    if(test >= 20) break
    i <- i + 1
}

i <- 0
while (i >= 9){
    i <- i + 1
    if (i %% 2 == 0){
        next
    }
    print (i)
    
}

#-------------------------------------------------------------------------------------
# if 조건문
#-------------------------------------------------------------------------------------
check <- 0
if(check == 1){
    print ("check의 값은 TRUE입니다. ")
}else{
    print ("check의 값은 TRUE가 아닙니다.")
}

y <- c(100, -50, 5, 3, 21, -2)
for (t in seq_along(y)) {
    if(y[t] < 0){
        y[t] <- as.numeric(str_remove(y[t], "-"))
    }
    print(y[t])
}

#-------------------------------------------------------------------------------------
# if_else 조건문
#-------------------------------------------------------------------------------------
ifelse(1 == TRUE, "Yes", "No")

x <- 1:10
ifelse(x %% 2 == 0, "짝수", "홀수")

price <- runif(100, 1, 100)
ifelse(price > 50, "비싸군", "괜찮네")
#-------------------------------------------------------------------------------------
# function의 이해
#-------------------------------------------------------------------------------------

f <- function(x, y){
    z <- x + y
    return (z)
}

f1 <- function(x, y){
    z <- x + y
    z
}

# 날짜를 넣으면 요일을 반환해주는 함수 만들어보기
dday <- function(d){
    diffs <- lubridate::today() - as.Date(d)
    return(diffs)
}
dday("2019-02-23")
mydates <- c("2018-04-25", "2017-05-24", "2002-06-12", "1999-12-31", "2018-09-12", "2005-04-15", "2011-12-25", "2007-11-23")


# for 반복문
for(i in mydates){
    diffs <- lubridate::today() - as.Date(i)
    print(diffs)
}

# lapply 함수
lapply(c("2018-04-25", "2017-05-24", "2002-06-12"), dday)


#-------------------------------------------------------------------------------------
# Tidy data : count, gather, spread
# Tidyverse : select, filter, mutate, arrange, group_by, summarise
#-------------------------------------------------------------------------------------

# count 함수는 해당 변수의 value 갯수를 세어준다
iris %>% 
    count(Species)

names(mpg)
mpg %>% 
    count(cyl, sort = T)

#-------------------------------------------------------------------------------------
# Tame data vs Tidy data
# 생각해 볼 것!
# 아래 데이터 시각화 어떻게? x축에 출석과 결석 y축에 횟수를 막대 그래프로!
#-------------------------------------------------------------------------------------
df_tm <- tibble(
    name = c("금진섭", "김해수", "임채민", "박혜준", "장해중", "배여운", "김중앙"),
    day1 = c("출석", "결석", "출석", "결석", "출석", "결석", "출석"),
    day2 = c("결석", "출석", "출석", "결석", "출석", "출석", "출석"),
    day3 = c("결석", "결석", "결석", "결석", "출석", "출석", "결석"),
    day4 = c("출석", "출석", "출석", "출석", "출석", "결석", "출석"),
    day5 = c("결석", "결석", "출석", "출석", "결석", "출석", "출석"),
    day6 = c("결석", "결석", "출석", "출석", "결석", "출석", "출석"),
    day7 = c("결석", "결석", "결석", "출석", "출석", "결석", "결석"),
    day8 = c("결석", "결석", "출석", "출석", "결석", "출석", "출석"),
    day9 = c("결석", "출석", "출석", "출석", "결석", "결석", "출석")
)

# tame data -> tidy data
df_tm2 <- gather(df_tm, "category", "value", contains("day"))

# 수치 변수 추가
df_tm3 <- df_tm2 %>%
    count(name, value)

# 시각화 x, y, fill 부분에 어떤 변수가 들어가있는지 확인해보자
ggplot(df_tm3, aes(x = name, y = n, fill = fct_relevel(value, "출석", "결석"))) +
    geom_col(position = "dodge")

#-------------------------------------------------------------------------------------
## 실습 데이터 가져오기
#-------------------------------------------------------------------------------------

patient_df <- read_csv("data/patient.csv")

# 구조 확인
str(patient_df)

# 요약해보기
summary(patient_df)

# 미리보기 
head(patient_df)
map_chr(patient_df, is.numeric)

#-------------------------------------------------------------------------------------
## 데이터 정제해보기
#-------------------------------------------------------------------------------------

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

