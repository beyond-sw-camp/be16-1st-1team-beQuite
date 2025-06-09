# ⚾ produceKBO ⚾

### select your players

팬 참여형 가상선수단 플랫폼
<img src="https://github.com/user-attachments/assets/0f19ed38-176c-4348-9e9c-3ca97d4a5cea" width="750">

---

## 🤫 팀
<img src="https://github.com/user-attachments/assets/dd0aeb0b-0eaf-4c5f-b951-9df18b859a39" width="500">

---

## 🤫 팀원

| https://github.com/pure-wa | https://github.com/YoungKwanK | https://github.com/ifunhy | https://github.com/mozzibeam |
| --- | --- | --- | --- |
| 김상환 | 김영관 | 김현지 | 위동길 |

---

## 🛠️ 기술 스택
<div>  <img src="https://img.shields.io/badge/MariaDB-003545?style=for-the-badge&logo=mariadb&logoColor=white"/> <img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white"/>
<img src="https://img.shields.io/badge/ERD%20cloud-0000FF?style=for-the-badge&logo=data:image/svg+xml;base64,&logoColor=white"/>
<img src="https://img.shields.io/badge/Discord-%235865F2.svg?style=for-the-badge&logo=discord&logoColor=white"/>
  <img src= "https://img.shields.io/badge/mysql-4479A1.svg?style=for-the-badge&logo=mysql&logoColor=white"/>
</div>
---

## 📌 프로젝트 개요

스포츠 팬들이 좋아하는 선수들로 **자신만의 가상 선수단을 구성**하고,

실시간 투표 및 이벤트에 참여하며 **팬덤 문화를 즐길 수 있는 플랫폼**입니다.

이 플랫폼은 단순한 경기 응원을 넘어 팬들의 적극적인 참여를 이끌어내며,

**브랜드 마케팅, 인기 선수 투표, 팬덤 분석** 등 다양한 활용 가능성을 제공합니다.

---

## 🎯 프로젝트 배경

국내 야구는 팬덤이 빠르게 확장되고 있습니다.

하지만 기존 팬 활동은 SNS 댓글, 앱 응모 등 **비정형적인 방식**에 의존하고 있어

**팬들의 응원 데이터 수집 및 분석에 어려움**이 존재합니다.

이에 우리는 팬들이 다음과 같은 활동을 할 수 있는 **데이터 중심 플랫폼**을 기획했습니다:

- 좋아하는 선수들로 나만의 **가상 선수단 구성**
- 올스타전 등 다양한 **이벤트 참여 및 투표**
- **실시간 인기 선수 통계** 확인

<img src="https://github.com/user-attachments/assets/715a2794-15f8-4037-85d2-b98b6744794f" width="300"> 
<img src="https://github.com/user-attachments/assets/5d689863-578e-4e94-8e6a-d2c55e92a70e" width="600">



💡 팬들의 모든 활동 데이터는 **정규화된 RDBMS 설계**를 기반으로 관리되며, 향후에는 다음과 같은 확장도 가능합니다:

- 인기 선수 트렌드 분석
- 브랜드 맞춤형 이벤트 추천
- 팬 유형 기반 클러스터링
    
    ---
    

## 🎯 프로젝트 목표

이 프로젝트는 팬들의 참여 데이터를 중심으로 **팬덤 활동을 구조화**하고,

이 데이터를 기반으로 한 **스포츠 마케팅 및 인사이트 도출**을 가능하게 하는 것이 핵심 목표입니다.

구체적인 목표는 다음과 같습니다:

1. **팬 중심 가상구단 시스템 구현**
    - 팬이 선호하는 선수들을 직접 선택하여 가상 선수단을 구성
    - 포지션별 제약 조건을 적용하여 전략적 선택 유도
      
2. **이벤트 및 투표 기반 팬 참여 활성화**
    - 실시간 인기 선수 투표, 올스타 이벤트 개최 등 다양한 참여 콘텐츠 제공
    - 팬 참여 이력을 기반으로 한 공정한 투표 시스템 구축
      
3. **정규화된 데이터베이스를 통한 참여 데이터 관리**
    - 선수단 구성, 투표, 즐겨찾기 등 활동 기록을 구조화된 테이블로 저장
    - 팬별 활동 로그 및 선수별 통계 정보 제공
      
4. **향후 확장을 고려한 유연한 시스템 아키텍처**
    - 스포츠 종목 추가, 팬 유형 분석, 브랜드 협업 마케팅 기능으로 확장 가능
      
5. **데이터 기반 팬 인사이트 제공**
    - 가장 인기 있는 선수군, 팬의 활동 패턴, 즐겨찾기 트렌드 등 분석 가능
    - 브랜드와 연계한 이벤트 기획 및 대상 팬 그룹 타겟팅 가능
    
    ---
    

## 🧩 핵심 기능

1. **회원 가입 / 정보 수정 / 조회**
    - 계정 생성과 로그인, 로그아웃, 아이디 비밀번호 찾기
    
2. **가상선수단 생성 / 수정**
    - 포지션별 제약, 중복 방지
    
3. **이벤트 / 투표 기능**
    - 단기 이벤트 올스타 생성, 후보 등록, 투표, 집계
    
4. **즐겨찾기 시스템**
    - 팬이 좋아하는 선수 즐겨찾기 및 수정, 조회
    
5. **통계 및 랭킹 기능**
    - 인기 선수 TOP N, 투표 수 집계 등
    
6. **데이터 관리**
    - 모든 활동 기록을 RDBMS에 정규화 저장 → SQL로 조회 가능
---

## 📄 WBS

[👉 WBS 문서 바로가기](https://docs.google.com/spreadsheets/d/1OEgj-mFE1KM8ZTvEe6eQ-Z5zDuUv6DMABl3xjqem61k/edit?gid=0#gid=0)

<img width="522" alt="Image" src="https://github.com/user-attachments/assets/28b77d9b-6275-495d-a590-750b89359fb8" />

---

## 📄 요구사항 명세서

[👉 요구사항 문서 바로가기](https://docs.google.com/spreadsheets/d/1OEgj-mFE1KM8ZTvEe6eQ-Z5zDuUv6DMABl3xjqem61k/edit?gid=1692108676#gid=1692108676)

<img width="694" alt="Image" src="https://github.com/user-attachments/assets/25405ba4-6429-4a3d-acbc-adde9d32c3ee" />

---

## 📄 ERD

[👉 ERD 바로가기](https://www.erdcloud.com/d/5tNiz3Qt4ZAQzGLLr)

![Image](https://github.com/user-attachments/assets/361c86fb-597b-4995-8d8e-b2a0527c2b70)

<details>
<summary>✅ ERD 관계 요약 및 관계성 분석 (produceKBO DB 기준)</summary>

| 관계                                                            | 관계 유형                  | 관계성 설명                                                                                                                         |
| --------------------------------------------------------------- | -------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| **leagueteam – players**                                        | **1:N (Mandatory)**        | 한 팀은 여러 선수를 가질 수 있음. 선수는 반드시 팀에 소속됨. (FK: players.leagueTeam_id)                                              |
| **players – positioned**                                        | **1:1 (Mandatory)**        | 선수는 반드시 하나의 포지션(batter/pitcher)을 가짐. (FK: positioned.players_id)                                                       |
| **positioned – batterposition / pitcherposition**               | **1:1 (Optional)**         | positioned는 batter 또는 pitcher 중 하나의 포지션만 가짐. (FK: batterposition.positioned_id, pitcherposition.positioned_id)          |
| **batterposition – batter**                                     | **1:1 (Mandatory)**        | 각 batter는 batterposition을 반드시 가짐. (FK: batter.batterPosition_id)                                                             |
| **pitcherposition – pitcher**                                   | **1:1 (Mandatory)**        | 각 pitcher는 pitcherposition을 반드시 가짐. (FK: pitcher.pitcherPosition_id)                                                          |
| **batter – batterstats**                                        | **1:1 (Mandatory)**        | 타자는 스탯을 반드시 가짐. (FK: batter.batterStats_id)                                                                               |
| **pitcher – pitcherstats**                                      | **1:1 (Mandatory)**        | 투수도 스탯을 반드시 가짐. (FK: pitcher.pitcherStats_id)                                                                             |
| **players – batterstats / pitcherstats**                        | **1:N (Mandatory)**        | 스탯은 players_id를 FK로 가지고 있음. (ON UPDATE CASCADE 설정)                                                                        |
| **user – favoritelist**                                         | **1:N (Mandatory)**        | 유저는 하나 이상의 즐겨찾기 목록을 가질 수 있음. (FK: favoritelist.user_id)                                                         |
| **favoritelist – favoriteplayers**                              | **1:N (Mandatory)**        | 목록은 여러 즐겨찾기 선수들을 가질 수 있음. (FK: favoriteplayers.favoriteList_id)                                                    |
| **players – favoriteplayers**                                   | **1:N (Optional)**         | 선수는 즐겨찾기 목록에 포함되지 않을 수 있음. (FK: favoriteplayers.players_id)                                                      |
| **user – fanteam**                                              | **1:N (Optional)**         | 유저는 0개 이상의 팬팀을 가질 수 있음. (FK: fanteam.user_id)                                                                         |
| **fanteam – fanteammember**                                     | **1:N (Mandatory)**        | 팬팀은 여러 명의 선수를 가질 수 있음. (FK: fanteammember.fanteam_id)                                                                |
| **players – fanteammember**                                     | **1:N (Optional)**         | 선수는 팬팀에 포함되지 않을 수 있음. (FK: fanteammember.players_id)                                                                  |
| **user – batterstatsfilter / pitcherstatsfilter**               | **1:N (Optional)**         | 유저는 통계 필터를 만들 수 있음. (FK: batterstatsfilter.user_id, pitcherstatsfilter.user_id)                                        |
| **batterstatsfilter – batterstatsfiltercondition**              | **1:N (Mandatory)**        | 필터는 조건을 하나 이상 포함해야 함. (FK: batterstatsfiltercondition.batterStatsFilter_id)                                          |
| **pitcherstatsfilter – pitcherstatsfiltercondition**            | **1:N (Mandatory)**        | 마찬가지로 조건 필수. (FK: pitcherStatsFilterCondition.pitcherStatsFilter_id)                                                       |
| **batterstatsfilter – batter**                                  | **1:N (Mandatory)**        | 필터는 특정 batter 엔트리를 가리킴. (FK: batterstatsfilter.batter_id)                                                               |
| **pitcherstatsfilter – pitcher**                                | **1:N (Mandatory)**        | 필터는 특정 pitcher 엔트리를 가리킴. (FK: pitcherstatsfilter.pitcher_id)                                                            |
| **user – allstar**                                              | **1:N (Mandatory)**        | 유저는 여러 allstar 이벤트를 만들 수 있음. (FK: allstar.user_id)                                                                     |
| **allstar – allstarcandidate**                                  | **1:N (Mandatory)**        | 각 allstar 이벤트는 후보들을 가짐. (FK: allstarcandidate.allstar_id)                                                                 |
| **allstarcandidate – players**                                  | **1:N (Mandatory)**        | 후보는 특정 선수로 구성됨. (FK: allstarcandidate.player_id)                                                                         |
| **allstar – allstarvote**                                       | **1:N (Mandatory)**        | 이벤트는 여러 투표를 가짐. (FK: allstarvote.allstar_id)                                                                              |
| **allstarvote – user**                                          | **1:1 (Mandatory)**        | 한 유저는 한 이벤트에 한 번만 투표할 수 있음. (UNIQUE KEY: user_id)                                                                  |
| **allstarvote – allstarcandidate**                              | **1:N (Mandatory)**        | 투표는 후보자 테이블의 엔트리를 참조함. (FK: allstarvote.allstarCandidate_id)                                                       |

</details>

---

## 📂 디렉토리 구조

📦 프로젝트 루트

├── 📁 PROCEDURE

│   ├── 📁 ALLSTAR

│   ├── 📁 FANTEAM

│   ├── 📁 FAVORITE

│   ├── 📁 PLAYER

│   ├── 📁 STATFILTER

│   └── 📁 USER

├── 📁 SQL

│   ├── 📁 DDL

│   ├── 📁 INSERT문

│   └── 📄 CREATE_TABLE_dump.sql

├── 📁 data

├── 📄 README.md

└── 📄 YOUNG_database.sql

---

## 📌 향후 개발 방향

- 사용자 인터페이스 연동을 통한 풀스택 MVP 개발
- 투표/즐겨찾기 기반 리코멘드 알고리즘 도입
- 마케팅 데이터 분석 기능 추가 (ex. 인기 선수 변화 추이)

> 본 프로젝트는 데이터 기반 팬 경험을 중심으로 한 스포츠 팬덤 플랫폼으로,
> 
> 
> 야구 외 다른 종목이나 브랜드 팬덤 시스템으로도 확장 가능한 구조를 지향합니다.
> 

---

## 🧑‍💻 회고

🤫 김상환
🤫 김영관
    
    > 이번 프로젝트를 통해 데이터베이스 설계의 흐름과 실무적인 접근 방식에 대해 많은 인사이트를 얻을 수 있었다.
    처음에는 요구사항과 ERD를 별개로 생각하며, 감에 의존해 테이블을 나누고 데이터를 매핑했다. 초반에는 문제 없었지만, 테이블이 많아지고 매핑이 복잡해지면서 머릿속으로 관계를 정리하는 데 한계를 느꼈다.
    이 경험을 통해 ERD를 작성할 때는 주제 중심으로 큰 틀의 테이블을 먼저 구성하고, 중복이나 비효율을 발견하면서 정규화를 적용해가는 방식이 더 현실적인 접근이라는 점을 깨달았다.
    또한, 기능 요구사항에 따라 어떤 데이터를 어떤 테이블에서 보여줄지를 요구사항 중심으로 미리 고려해 설계하는 것의 중요성도 느꼈다. 처음부터 세세하게 나누기보다는, 필요한 데이터 흐름을 기준으로 관계를 정리하고 유연하게 보완하는 것이 효율적인 전략임을 체감했다.
    완벽한 설계를 목표로 하기보다, 전체적인 구조를 먼저 잡고 점진적으로 개선해 나가는 실용적인 설계 방식의 중요성을 다시 한번 확인할 수 있었다.
    > 
🤫 김현지
 
     > 이번 프로젝트를 통해 단순히 데이터를 저장하는 수준을 넘어, 팬 참여 데이터를 어떻게 구조화하고 활용할 수 있을지 고민해볼 수 있었다. 
테이블 간의 관계를 설계하면서 정규화의 중요성을 체감했고, 프로시저와 쿼리를 직접 구현해보며 실제 서비스에 적용 가능한 수준의 데이터 흐름을 설계할 수 있었던 점이 가장 큰 수확이었다. 
다만 UI와의 연결까지는 진행되지 않아 시각적인 효과를 경험하지 못한 점이 아쉬웠고, 다양한 사용자 시나리오에 맞춘 테스트 케이스 설계가 부족했던 것도 개선이 필요한 부분이라 느꼈다. 
이후 백엔드 보안, 연동 및 예외 처리를 강화하여 더 완성도 높은 시스템으로 발전시키고 싶다.
    > 
🤫 위동길

    >이번 프로젝트에서 저는 주로 스탯 필터 기능과 선수 즐겨찾기 시스템을 담당했습니다.
필터 기능은 단순한 검색 조건 저장을 넘어서, 조건 기반 자동 즐겨찾기 생성이나 기존 즐겨찾기와의 연동처럼 실사용자 중심의 흐름을 구현하는 데 중점을 두었습니다. 이 과정에서 동적 SQL과 트랜잭션 처리, 예외 발생 시 ROLLBACK 구조, 조건문 조합 로직 구성 등 실무적인 SQL 스킬을 체득할 수 있었습니다.
또한 즐겨찾기 기능을 구현하면서 사용자 경험 관점에서 데이터 흐름을 설계하는 것이 얼마나 중요한지 배웠고, 단순 CRUD 이상의 기능이 되도록 필터 조건과 연동한 자동화 기능까지 확장해보려 노력했습니다.
개인적으로는 기능 단위로 명확히 역할을 나누고, 스스로 책임지고 끝까지 구현해보는 경험이 인상 깊었습니다. 이후에는 이런 데이터 기능들을 프론트와 연동하여 직관적인 사용자 경험으로 연결하는 것도 직접 해보고 싶습니다.
    >

