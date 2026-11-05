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

# 1. 이미지 빌드
docker build -t my-web-server .

# 2. 컨테이너 실행 (포트 8080 매핑)
docker run -d -p 8080:80 --name my-web-container my-web-server

# 3. 접속 확인
# 브라우저에서 http://localhost:8080 접속

# 사용자 설정
git config --global user.name "student2026-11"
git config --global user.email "your-email@example.com"

# 변경 사항 기록 및 푸시
git add .
git commit -m "Complete: Docker & Git Workstation Setup"
git push origin main

