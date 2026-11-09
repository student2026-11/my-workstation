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

### 영속성 검증 터미널 로그
컨테이너를 삭제하고 새로운 컨테이너(`my-final-test`)를 생성하여 데이터가 유지되는지 확인한 실제 로그입니다.

```powershell
# 1. 기존 바인드 마운트 컨테이너 중지 및 삭제
PS C:\Users\newparangse8503\my-workstation> docker stop my-bind-test
my-bind-test
PS C:\Users\newparangse8503\my-workstation> docker rm my-bind-test
my-bind-test

# 2. 컨테이너 삭제 확인 (my-bind-test가 목록에서 사라짐)
PS C:\Users\newparangse8503\my-workstation> docker ps -a
CONTAINER ID   IMAGE             COMMAND                   CREATED          STATUS                     PORTS                                     NAMES
63385be092ee   my-web-server     "/docker-entrypoint.…"   34 minutes ago   Up 34 minutes              0.0.0.0:8080->80/tcp, [::]:8080->80/tcp   my-web-container
79be2e0bacb8   my-custom-nginx   "/docker-entrypoint.…"   20 hours ago     Exited (255) 2 hours ago   0.0.0.0:8888->80/tcp                      my-web-server
6d591b1da7d3   alpine            "/bin/sh"                 22 hours ago     Exited (0) 22 hours ago                                              vol-test-3

# 3. 새로운 컨테이너(my-final-test)에 동일한 볼륨 연결하여 실행
PS C:\Users\newparangse8503\my-workstation> docker run -d -p 8082:80 --name my-final-test -v ${PWD}/app:/usr/share/nginx/html nginx:alpine
b1c818f179ba5d0a76b251a2c5d3a56a25178a4b42443c9db7891a50fbca7bb9
```

## 최종 검증 결과 (데이터 영속성)

새로운 컨테이너를 생성하여 기존 데이터를 연결했을 때, 데이터가 유실되지 않고 그대로 유지됨을 확인했습니다.

- **접속 주소**: http://localhost:8082
- **검증 내용**: 
  1. 기존 컨테이너(`my-bind-test`) 삭제 후에도 로컬 파일 보존 확인.
  2. 새 컨테이너(`my-final-test`) 실행 시 동일한 로컬 폴더 마운트.
  3. 브라우저 접속 시 수정했던 내용("수정 성공!")이 그대로 출력됨.

**결론: 도커 바인드 마운트를 통해 컨테이너의 생명주기와 별개로 데이터를 안전하게 관리할 수 있음을 증명함.**

## 8. Git 설정 및 GitHub/VSCode 연동 증거

# 사용자 설정
git config --global user.name "student2026-**"
git config --global user.email "newparangse****.@gmail.com"

### 10.4 Git 설정 상세 확인 (`git config --list`)
로컬 환경의 Git 설정과 GitHub 원격 저장소 연결 상태를 확인한 로그입니다. (개인정보 보호를 위해 일부 마스킹 처리)

```text
# 주요 설정 내용
init.defaultbranch=master
user.name=student2026-**
user.email=newparangse****@gmail.com

# 원격 저장소 연결 정보
remote.origin.url=https://github.com/student2026-**/my-workstation.git
remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*

# 브랜치 추적 정보
branch.main.remote=origin
branch.main.merge=refs/heads/main
```
# 변경 사항 기록 및 푸시

git add .
git commit -m "미션 최종 완료"
git push origin main

모든 미션을 완료하고 GitHub 원격 저장소에 최종 버전을 업로드하였습니다.

```powershell
# 최종 커밋 및 푸시 로그
PS C:\Users\newparangse8503\my-workstation> git commit -m "미션 최종 완료"
[main dd89334] 미션 최종 완료
 2 files changed, 65 insertions(+), 7 deletions(-)

PS C:\Users\newparangse8503\my-workstation> git push origin main
Enumerating objects: 9, done.
Counting objects: 100% (9/9), done.
Delta compression using up to 24 threads
Compressing objects: 100% (5/5), done.
Writing objects: 100% (5/5), 2.48 KiB | 2.48 MiB/s, done.
Total 5 (delta 2), reused 0 (delta 0), pack-reused 0 (from 0)
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To https://github.com/student2026-11/my-workstation.git
   a5d03ea..dd89334  main -> main

## 트러블 슈팅
- 1.처음 디렉토리와 파일 생성시 파일 만들때 touch명령어를 썻으나 오류가 떠서 생성이 안됐음  -> 파워셀 환경에서 touch 인식이 되지 않아서 생긴 오류로 확인 되어 파워셀이 인식 가능한 ni명령어로 바꿔서 실행 했습니다

- 2.Docker 설치 오류 "WSL 2 installation is incomplete."
도커는 리눅스 기반으로 작동하는데, 윈도우에서 리눅스를 실행시켜주는 WSL2엔진이 최신버전이 아니거나  설치 되지 않아서 발생한 오류 
-> WSL2 커널 업데이트 wsl --update 사용, 윈도우 기능 켜기/끄기 '가상 머신 플랫폼' 항목이 체크되어 있는지 확인했습니다
Docker 설정변경: Docker Desktop 설정에서 "Use the WSL2 based engine"옵션을 활성화하여 원도우와 리눅스가 잘 연결되도록 설정했습니다.
