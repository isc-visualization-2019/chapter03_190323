#-------------------------------------------------------------------------------------
# practice1
# for 반복문을 활용해서 df_sample1 각 열의 평균을 구해보세요. 평균함수는 mean
#-------------------------------------------------------------------------------------
df_sample1 <- data.frame(
    a = rnorm(10),
    b = rnorm(10),
    c = rnorm(10),
    d = rnorm(10)
)

for(i in 1:4){
    print(mean(df_sample1[, i]))
}


#-------------------------------------------------------------------------------------
# practice2
# 구구단 결과를 출력해보세요
#-------------------------------------------------------------------------------------
final <- NULL
for(i in 2:9){
    for (k in 1:9) {
    local <- i * k
    final <- c(final, local)
    }
}

# 메트릭스로 변환
final.mat <- matrix(final, nrow = 9, ncol = 8,
                    byrow = FALSE)

#-------------------------------------------------------------------------------------
# practice3
# 문자열 숫자가 섞여있는 벡터를 숫자형 벡터로 바꾸기
#-------------------------------------------------------------------------------------
x <- c(1, 5, 7, "10")


#-------------------------------------------------------------------------------------
# practice4
# 어떤 벡터의 summary 함수(my.sum)를 만들어보세요 (평균, 중간값, 최소값, 최대값, 합계)
# 결과는 데이터프레임으로 만들어주세요 (1행 5열)
#-------------------------------------------------------------------------------------
test <- rnorm(1000)



#-------------------------------------------------------------------------------------
## practice5
# 1. 데이터 가져오기 (데이터 설명은 아래)
# 2. 컬럼이름 영문으로 변경하기
# 3. 숫자로 변환해보기
# 4. tidy 데이터로 변환해보기
# 5. 다시 wide로 변환해보기 (다른 변수에 저장) => 5번 빼고
# 6. write.csv로 csv 파일로 저장하기
# https://docs.google.com/spreadsheets/d/e/2PACX-1vQVSDG9-3h2u7_KAk4C_g4Vc50PxM1aXxqZ4w6G4f3dpdObmla4lCqDRLMZEE6bBtpTZL4lK57wkWHR/pub?gid=1581715057&single=true&output=csv
# 혹은 budongsan.csv로 활용
#-------------------------------------------------------------------------------------

# 데이터 불러오기
df <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vQVSDG9-3h2u7_KAk4C_g4Vc50PxM1aXxqZ4w6G4f3dpdObmla4lCqDRLMZEE6bBtpTZL4lK57wkWHR/pub?gid=1581715057&single=true&output=csv")

df <- read_csv("data/budongsan.csv")

# 영문으로 컬럼 이름 변경
colnames(df) <- c("gu", "Aug", "Sep", "Oct", "Nov", "Dec")

# 수치형으로 변환
for(i in 2:6){
    df[, i] <- as.numeric(str_remove(df[, i] %>% pull, "pt"))
}

# tame data to tidy data로 변환
df <- df %>% 
    gather(key = "month", value = "value", Aug : Dec)

# 시각화를 위해 month 칼럼 factor에서 relevel
month.level <- unique(df %>% pull(month))

# 시각화
ggplot(df, aes(x = fct_relevel(month, month.level), y = value, group = gu, color = gu)) +
    geom_line() +
    theme_woons() + # 개인테마
    labs(x = NULL, y = NULL) +
    geom_point(size = 1)
