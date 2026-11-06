# 🛠️ 개발자 작업실 구축 보고서 (Workstation Setup)

Docker와 Git을 활용하여 언제 어디서든 동일한 개발 환경을 재현할 수 있는 '나만의 작업실'을 구축한 과정을 기록합니다.

## 1. 프로젝트 개요
- **목표:** Docker 기반 웹 서버 구축 및 데이터 영속성(Persistence) 원리 이해
- **핵심 기술:** Docker Desktop, WSL2, Git/GitHub, Nginx

## 2. 개발 환경 (Environment)
| 항목 | 상세 내용 |
| :--- | :--- |
| **OS** | Windows 11 (WSL2 기반) |
| **Docker** | Version 29.9.2 |
| **Git** | Version 2.56.0.windows.4 |

## 3. 작업 디렉토리 구조
프로젝트의 기초가 되는 폴더와 설정 파일을 생성했습니다.

```powershell
# 프로젝트 루트 생성
mkdir my-workstation
cd my-workstation

# 폴더 구조 및 파일 생성 (PowerShell)
mkdir app
ni Dockerfile, .gitignore, readme.md -ItemType File
ni app/index.html -ItemType File
```
## 4.Docker 운영/검증 로그
# Docker 설치 및 서비스 상태 확인
-     docker --version
-     Docker version 29.9.2, build a82e528
-     **결과 요약**:
-     Client/Server Version: 29.9.2 (정상 연결)
-     OS Type: linux (WSL2 기반)
-     자원 할당: CPU 24, Memory 15.25GiB 확인
-     상태: Docker Daemon이 정상 작동 중이며,
-     CLI를  통해 서버 정보 수집 완료.
# Dockerfile 작성 및 커스텀 이미지 빌드
-     docker build -t my-web-server .
-     docker images      
## 5. Dockerfile 기반 웹 서버 컨테이너
### 1) 이미지 빌드 (Build)
- **명령어**: `docker build -t my-web-server .`
- **결과 로그**:
  ```bash
  [+] Building 4.9s (7/7) FINISHED docker:desktop-linux
  => [internal] load build definition from Dockerfile
  => [internal] load metadata for docker.io/library/nginx:alpine
  => [internal] load .dockerignore
 ### 2) docker images 실행결과
 REPOSITORY          TAG       IMAGE ID       CREATED         SIZE
my-web-server       latest    44c78843ee82   5 minutes ago   93.7MB
### 3) docker run 실행결과
# 실행 명령어
docker run -d -p 8080:80 --name my-web-container my-web-server
# 결과 (컨테이너 ID 출력)
63385be092eef8490cafec8ef54a8e30366d69829c1eaccb595567fae0529a9f

 ### 4) docker ps  실행 확인 
- **터미널 확인 (`docker ps`)**:
  컨테이너가 정상적으로 실행 중이며, 8080 포트가 매핑된 것을 확인했습니다.
  ```bash
  CONTAINER ID   IMAGE           COMMAND                  CREATED         STATUS         PORTS                                     NAMES
  63385be092ee   my-web-server   "/docker-entrypoint.…"   2 minutes ago   Up 2 minutes   0.0.0.0:8080->80/tcp, [::]:8080->80/tcp   my-web-container


## 6. 포트 매핑 접속 증거
# 컨테이너 실행 (포트 8080 매핑)
docker run -d -p 8080:80 --name my-web-container my-web-server

# 접속 확인
 브라우저에서 http://localhost:8080 접속
 - 성공적으로 접속 됨

## 7. 바인드 마운트 반영 + 볼륨 영속성 증거 
# 바인드 마운트 실행 로그
PS C:\Users\newparangse8503\my-workstation> docker run -d -p 8081:80 --name my-bind-test -v ${PWD}/app:/usr/share/nginx/html nginx:alpine
Unable to find image 'nginx:alpine' locally
...
Status: Downloaded newer image for nginx:alpine
58e88e4a431136648ca449588946151ba7a9acf6279453083e22cb1c127ae806

### 최종 실행 확인
현재 두 개의 웹 서버가 서로 다른 방식으로 정상 작동 중임을 확인했습니다.

```bash
PS C:\Users\newparangse8503\my-workstation> docker ps
CONTAINER ID   IMAGE           COMMAND                   CREATED          STATUS          PORTS                                     NAMES
58e88e4a4311   nginx:alpine    "/docker-entrypoint.…"   7 minutes ago    Up 7 minutes    0.0.0.0:8081->80/tcp, [::]:8081->80/tcp   my-bind-test
63385be092ee   my-web-server   "/docker-entrypoint.…"   29 minutes ago   Up 29 minutes   0.0.0.0:8080->80/tcp, [::]:8080->80/tcp   my-web-container
```

# 사용자 설정
git config --global user.name "student2026-11"
git config --global user.email "newparangse****.@gmail.com"

# 변경 사항 기록 및 푸시
git add .
git commit -m "Complete: Docker & Git Workstation Setup"
git push origin main



