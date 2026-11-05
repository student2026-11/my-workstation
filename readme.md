# 내 컴퓨터에 개발자용 '작업실' 꾸미기

## 1. 프로젝트 개요
- 본 프로젝트는 Docker 기반의 웹 서버 환경을 구축하고, Git/GitHub 연동을 통해 개발 워크스테이션의 기초를 다지는 것을 목표로 합니다

## 2. 실행 환경
- **OS:** Windows 10/11
- **가상화 엔진:** WSL2(Windows Subsystem for Linux2) 
- **Docker 배포판:** docker-desktop (Version 2)
- **Git 버전:** git version 2.56.0.windows.4

## 3. 수행 항목 체크리스트
- [o] 터미널 환경 설정 및 권한 부여
-     mkdir my-workstaion
-     cd my-workstaion
-     mkdir app
-     ni dokerfile -ItemType File
-     ni .gitignore -ItemType File
-     ni readme.md
 -    ni app/index.html
- [o] Docker 설치 및 서비스 상태 확인
-     docker --version
-     Docker version 29.9.2, build a82e528
-     **결과 요약**:
-     Client/Server Version: 29.9.2 (정상 연결)
-     OS Type: linux (WSL2 기반)
-     자원 할당: CPU 24, Memory 15.25GiB 확인
-     상태: Docker Daemon이 정상 작동 중이며,
-     CLI를  통해 서버 정보 수집 완료.

- [o] Dockerfile 작성 및 커스텀 이미지 빌드
-     docker build -t my-web-server .
-     docker images                      
- [o] 포트 매핑 및 웹 서버 접속 확인
-     docker run -d -p 8080:80 --name my-web-container   -     my-web-server
-     docker ps
-     브라우져 확인 주소 : http://localhost:8080    
- [o] 바인드 마운트 및 볼륨 영속성 검증
-     바인드 마운트
-     mkdir test-folder
-     cd test-folder
-     docker run -it --name bind-test -v ${PWD}:/app alpine sh
-     cd /app
-     echo "Docker Bind Mount Success!" > hello-docker.txt ls
-     exit
-     docker rm bind-test
-     볼륨
-     ocker volume create my-data
-     docker run -it --name vol-test-2 -v my-data:/data alpine
-     cd /data
-     echo "volume is working" > real-test.txt
-     ls
-     exit
-    오늘 실습으로 증명한 사실
-    컨테이너는 소모품이다: vol-test-2를 삭제(rm)했음에도 불구하고 데이터는 사라지지 않았습니다.
-    데이터는 영구적이다: 도커가 관리하는 볼륨(my-data)에 저장했기 때문에, 새로운 컨테이너(vol-test-3)를 -    가져와서 연결만 하면 언제든 데이터를 다시 불러올 수 있습니다.
-    바인드 마운트 vs 볼륨, 이제 차이가 느껴지시나요?
-    바인드 마운트 (Bind Mount):
-    내 컴퓨터의 특정 폴더를 통째로 연결.
-    VS Code 탐색기에서 바로 보임.
-    설정 파일이나 소스 코드를 실시간으로 수정할 때 주로 사용.
-    볼륨 (Volume):
-    도커가 관리하는 특별한 저장소를 연결.
-    내 컴퓨터 탐색기에서는 안 보이지만, 도커가 훨씬 안전하게 관리함.
-    데이터베이스(DB)의 데이터처럼 사용자가 직접 파일을 건드릴 필요는 없지만, 절대 사라지면 안 되는
-    데이터를 저장할 때 주로 사용.


- [o] Git 사용자 정보 설정 및 GitHub 연동
-    git config --global user.name "student2026-11"
-    git config --globla user.email "이메일주소"
-    git config --list