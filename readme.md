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
- [x] 포트 매핑 및 웹 서버 접속 확인
-     docker run -d -p 8080:80 --name my-web-container   -     my-web-server
-     docker ps
-     브라우져 확인 주소 : http://localhost:8080    
- [x] 바인드 마운트 및 볼륨 영속성 검증
- [x] Git 사용자 정보 설정 및 GitHub 연
