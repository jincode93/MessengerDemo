# MessengerDemo

## 📱 프로젝트 소개

- 해당 프로젝트는 실시간 채팅을 주제로 만든 데모앱입니다.
- Enum 열거 타입의 `Action`과 `Send` 메서드를 활용해 Binding을 하는 형태의 `MVVM` 아키텍처를 사용했습니다.
- `Combine`, `Swift Concurrency`를 활용해 네트워크 환경에서의 비동기처리를 진행하였습니다.
- `XCTest`를 이용해 `Unit Test`를 진행하였습니다.

### Apple 로그인
![2024-01-142 38 01-ezgif com-video-to-gif-converter](https://github.com/jincode93/MessengerDemo/assets/111134273/3aa9c42b-0b39-4467-8207-b36dcecdf3c0)


### 다크 / 라이트 모드 전환
![2024-01-142 40 09-ezgif com-video-to-gif-converter](https://github.com/jincode93/MessengerDemo/assets/111134273/d7978e35-0c80-40b4-99d4-07ec39cd8b4a)


### Firebase를 활용한 실시간 채팅
![2024-01-142 50 56-ezgif com-video-to-gif-converter](https://github.com/jincode93/MessengerDemo/assets/111134273/ab7d7e62-60e8-43fc-bf1e-3f871ba6eb9e)


### 프로필 사진 변경
![2024-01-142 51 39-ezgif com-video-to-gif-converter](https://github.com/jincode93/MessengerDemo/assets/111134273/7d2b9584-880c-4822-ab11-e55ece6ab870)


## Firebase Auth를 통한 Google, Apple Login

- 채팅 앱에서는 사용자 식별을 위해 로그인이 필수로 필요합니다. 그래서 가장 접근하기 쉬운 `Firebase Auth`를 사용하여 `Google`, `Apple Login`을 구현하였습니다.
- 앱을 동작하게 되면 우선 AuthenticationViewModel의 Action 중 .checkAuthenticationState를 동작시켜 로그인 여부를 확인해서 로그인 뷰와 메인탭 뷰로 분기처리를 함으로써 `자동로그인을 구현`하였습니다.
- Google 로그인은 GIDSign을 통해 토큰을 받고 해당 토큰을 Firebase에 넘겨서 로그인 하는 방식으로 구현하였습니다.
- Apple 로그인은 32자의 랜덤 Nonce가 필요해서 랜덤 Nonce 메서드를 활용해 Nonce를 만들어 전달한 후 로그인을 진행해 토큰을 받고 Firebase에 넘겨서 로그

---

## Dependency Injection Container

- ViewModel에 비즈니스 로직을 담은 Service 객체도 넘겨야하고 navigation 신호를 발생시키는 navigationRouter 등 다양한 객체를 전달해야하는데 하나하나 전달하게 되면 각 코드마다 의존성이 발생하게되고 그로 인해 테스트 코드를 작성하기도 어려워지고 유지 보수도 힘들어지기 때문에 이러한 `객체들을 담아서 주입할 수 있는 DIContainer를 만들어서 의존성 주입을 진행`하였습니다.
- Service 또한 다양한 Service들이 존재하기 때문에 ServiceType으로 묶어서 전달하여 소스코드 의존성을 끊어주었습니다.

---

## Contacts Framework

- Device에 저장된 연락처를 받아와서 친구 목록을 만들어주기 위해 `Contacts Framework`를 사용하였습니다.
- 유저가 연락처 접근을 허용한 후에는 `메인 탭 화면에서 fetchContacts 메서드가 동작하면서 연락처를 동기화`합니다.
- 연락처를 Contacts를 통해 받아온 후에는 User 타입으로 변환해서 Firebase Realtime Database에 Users 아래에 저장하도록 하였습니다.
