# 1. 어떤 환경을 사용할지 정합니다. (nginx는 웹 서버 소프트웨어예요)
FROM nginx:alpine

# 2. 내 컴퓨터의 app 폴더 안에 있는 index.html을 웹 서버의 지정된 위치로 복사합니다.
COPY ./app/index.html /usr/share/nginx/html/index.html

# 3. 웹 서버가 사용할 포트 번호를 알려줍니다.
EXPOSE 80