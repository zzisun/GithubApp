# GithubApp

마켓컬리 사전과제 

> 사용자가 입력한 검색어를 이용하여 GitHub 에서 리포지토리를 검색하고, 결과를 목록으로 표시합니다.

- `개발 기간` : 2021년 10월 21일 ~ 10월 25일

- `주요 개발 키워드` : CleanArchitecture,  MVVM, Concurrency,  Autolayout

- `사용한 라이브러리` : Alamofire, RxSwift, RxCocoa, SnapKit, SwiftLint

  

### 작업 방식

* GitHub 의 Issues 를 이용하여 이슈 기반으로 작업을 진행하였습니다.

* 다음의 [Commit Rule](https://github.com/zzisun/GithubApp.wiki.git) 을 적용하여 커밋을 관리하였습니다.



## 기본동작

* 검색창에 검색어를 입력한 뒤 키보드의 search버튼을 눌러 리포지토리를 검색하고, 결과를 tableView를 사용하여 목록으로 표시합니다.

**iPhone12 구동화면**

<img src="https://user-images.githubusercontent.com/60323625/138777728-172229be-8a2f-4d6b-be26-3a0add8db225.gif" alt="앱의 전반적인 흐름" width=280>





## 상세 구현 내용

### 1. Clean Architecture

* Data 레이어

  networkManager 싱글톤 패턴 적용

* Domain 레이어



* Presentation 레이어

  

### 2. MVVM

- ViewModel을 통한 데이터 바인딩을 통해 ViewController의 역할을 축소하고, 데이터 흐름을 가시화했습니다.

  

### 3. Concurrency

* RxSwift를 사용하여 비동기 코드를 간결하게 구현하였습니다.

  

### 4. Autolayout, 화면 구성 방법

* 코드를 기반으로 UI를 구현하였습니다.

* SnapKit을 사용하여 tableView

* TableViewCell 커스텀

  xib를 사용하였습니다.

  stackView를 사용하여 

| iPod touch (7th gen)                                         | iPhone 8                                                     | iPhone 12                                                    |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| <img width="404" alt="스크린샷 2021-10-26 오전 7 17 30" src="https://user-images.githubusercontent.com/60323625/138778986-f2cfa5e6-e2fe-4a6c-85b1-2835f3465226.png"> | <img width="453" alt="스크린샷 2021-10-26 오전 7 20 02" src="https://user-images.githubusercontent.com/60323625/138778984-5cd598b4-0879-4883-b335-84ad6cf79865.png"> | <img width="457" alt="스크린샷 2021-10-26 오전 7 20 38" src="https://user-images.githubusercontent.com/60323625/138778969-2db3fd76-6ea5-4623-8867-9027c779bf04.png"> |



