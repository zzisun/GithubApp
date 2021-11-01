# GithubApp

> 사용자가 입력한 검색어를 이용하여 GitHub 에서 리포지토리를 검색하고, 결과를 목록으로 표시합니다.

- `개발 기간` : 2021년 10월 21일 ~ 10월 25일

- `주요 개발 키워드` : CleanArchitecture,  MVVM, Concurrency,  Autolayout

- `사용한 라이브러리` : Alamofire, RxSwift, RxCocoa, SnapKit, SwiftLint

  

### 작업 방식

* GitHub 의 Issues 를 이용하여 이슈 기반으로 작업을 진행하였습니다.

* 다음의 [Commit Rule](https://github.com/zzisun/GithubApp/wiki/Commit-Rule) 을 적용하여 커밋을 관리하였습니다.



## 기본동작

**iPhone12 구동화면**

* 검색창에 검색어를 입력한 뒤 키보드의 search버튼을 눌러 리포지토리를 검색하고, 

  결과를 tableView를 사용하여 목록으로 표시합니다.



​<img src="https://user-images.githubusercontent.com/60323625/138777728-172229be-8a2f-4d6b-be26-3a0add8db225.gif" alt="앱의 전반적인 흐름" width=280>

* 검색창에 검색어를 입력하지 않고 리포지토리를 검색하는 경우와 같이 오류가 발생하면 alert창을 띄워 사용자에게 알린 뒤 이전화면으로 돌아가게 됩니다.

<img src="https://user-images.githubusercontent.com/60323625/138783994-8a5f162c-766d-4cd4-a1d2-a3d667418e90.gif" alt="앱의 전반적인 흐름" width=280>





## 상세 구현 내용

### 1. Clean Architecture

* Data 레이어

  networkManager에 싱글톤 패턴을 적용하여 `networkManager`가 하나의 인스턴스만 존재하도록 구현했습니다.

  `Alamofire` 라이브러리 사용하여 response decoding 부분을 간결하게 구현하였습니다.

* Domain 레이어

  * Entity

    Decodable한 모델을 선언하였습니다. 

  * Usecase

* Presentation 레이어

  * ViewModel
  * View
  * ViewController

### 2. MVVM

- ViewModel을 통한 데이터 바인딩을 통해 ViewController의 역할을 축소하고, 데이터 흐름을 가시화했습니다.

  

### 3. Concurrency

* RxSwift를 사용하여 비동기 코드를 간결하게 구현하였습니다.

  

### 4. Autolayout, 화면 구성 방법

* 코드를 기반으로 UI를 구현하였습니다. 

* SnapKit을 사용하여 직관적이고 간결하게 autolayout을 구현하였습니다.

* xib를 사용하여 TableViewCell 커스텀하여 RepositoryCell을 구현하였습니다.

  stackView로 최대한 item들을 묶어 사용하여 constraint의 개수를 줄였습니다.

  hugging priority 를 사용하여 Repository의 description길이에 따라 UI layout이 변할 수 있도록 구현하였습니다.

| iPod touch (7th gen)                                         | iPhone 8                                                     | iPhone 12                                                    |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| <img width="404" alt="스크린샷 2021-10-26 오전 7 17 30" src="https://user-images.githubusercontent.com/60323625/138778986-f2cfa5e6-e2fe-4a6c-85b1-2835f3465226.png"> | <img width="453" alt="스크린샷 2021-10-26 오전 7 20 02" src="https://user-images.githubusercontent.com/60323625/138778984-5cd598b4-0879-4883-b335-84ad6cf79865.png"> | <img width="457" alt="스크린샷 2021-10-26 오전 7 20 38" src="https://user-images.githubusercontent.com/60323625/138778969-2db3fd76-6ea5-4623-8867-9027c779bf04.png"> |



