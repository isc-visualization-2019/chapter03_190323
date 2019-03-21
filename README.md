3주차 강의 내용
---

Content
---

  - 비주얼라이제이션을 위한 가로형 데이터와 세로형 데이터 개념
  - FOR, IF 반복문
  - Data Wrangling in Tidyverse
  - 과제전 팀미팅
  - (과제 3-1) : [Importing Data in R(Part1)](https://www.datacamp.com/courses/importing-data-in-r-part-1)
  - (과제 3-2) : [Intermediate R](https://www.datacamp.com/courses/intermediate-r)


How to
---

실습은 작업환경을 통일하기 위해서 RStudio에서 실습파일을 바탕화면에 다운로드 가능하도록 준비했습니다.  
별도 `project`폴더를 만들 필요 없이 각 chapter마다 url을 아래 방법처럼 `console`에 입력하면 자동 설치됩니다.

콘솔창에 질문이 나오면 대답은 번호만 입력해주면 됩니다
- Is it OK to write this file here? (answer : For sure)  
- Shall we delete the ZIP file '/Users/Benjamin/Desktop/chapter3-intro-master.zip'? (answer : Yup)

```
# 최초 한번만 설치
install.packages("usethis")  

# 방법1
library(usethis) 
use_course("https://github.com/isc-visualization-2019/chapter03_190323/archive/master.zip")

# 방법2
usethis::use_course("https://github.com/isc-visualization-2019/chapter03_190323/archive/master.zip")
```
