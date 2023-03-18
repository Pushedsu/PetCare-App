# Pet-Care App Service Client

반려동물 일정 기록 & SNS 서비스!

## 추가될 기능
- 회원 정보 수정
- 게시글 찾기
- 게시글 옵션 버튼
- 이미지 입력
- ...

## 구현된 기능
- 게시판
- 회원 가입
- 로그인 & 로그아웃
- 캘린더 ( 일정 추가, 마커 표시, 로컬 스토리지 저장 )
- 회원 탈퇴
- ...

### pubspec.yaml
```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.6.5
  http: ^0.13.5
  flutter_secure_storage: ^7.0.1
  jwt_decoder: ^2.0.1
  provider: ^6.0.5
  flutter_screenutil: ^5.6.1
  table_calendar: ^3.0.9
  intl: ^0.18.0
  shared_preferences: ^2.0.18
```

## 화면 구성

| <img width="200" height="400" alt="로그인화면" src="https://user-images.githubusercontent.com/109027302/225267403-6b8939de-8ce6-4f56-b467-925410c3f08c.png"> | <img src="https://user-images.githubusercontent.com/109027302/225267960-f2c7cee8-b0e0-4eda-9d23-2fc7ba313886.png" width="200" height="400"/> | <img src="https://user-images.githubusercontent.com/109027302/225270129-e85da0b3-d301-46ed-9e24-f95f62175c68.png" width="200" height="400"/> | <img src="https://user-images.githubusercontent.com/109027302/225270531-3db86dee-c1b8-44a9-8d4c-a6e1d4a57ffe.png" width="200" height="400"/> | <img src="https://user-images.githubusercontent.com/109027302/226098703-383db4c3-2e0e-4100-9943-eca5f30919e2.png" width="200" height="400"/> | 
|:---------------------------------------------------------------------------------------------:|:---------------------------------------------------------------------------------------------:|:---------------------------------------------------------------------------------------------:|:---------------------------------------------------------------------------------------------:|:--:|
|                                          `'로그인 화면'`                                           |                                          `'회원가입 화면'`                                          |                                          `'게시판 화면'`                                           |                                          `'프로필 화면'`                                           | `'캘린더'` |


