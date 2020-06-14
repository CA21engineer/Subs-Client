# Subs

## サービス概要

自分の登録しているサブスクリプションを管理するアプリ

## 開発背景

これは6/7日~6/14日にかけて行われたCyberAgentの21卒の内定者内で行った第一回ハッカソンの成果物です  
このレポジトリはチーム #Hack01-Subs のクライアントサイド(iOS)のものです  
開発者: [@ry-itto](https://github.com/ry-itto), [@takumaosada](https://github.com/takumaosada)

サーバーサイドのレポジトリ: https://github.com/CA21engineer/Subs-server  
開発者: [@BambooTuna](https://github.com/BambooTuna), [@takehanKosuke](https://github.com/takehanKosuke), [@Fumi107](https://github.com/Fumi107)

## 使用技術

- SwiftUI(UIKitは利用していません)

### 設計

- [ComposableArchitecture](https://github.com/pointfreeco/swift-composable-architecture)

### 使用ライブラリ

- [Grid](https://github.com/spacenation/swiftui-grid)

- [FetchImage](https://github.com/kean/FetchImage)(SwiftUI用に[Nuke](https://github.com/kean/FetchImage)をWrapしたライブラリ)
 
- [grpc-swift](https://github.com/grpc/grpc-swift)

- [swift-case-paths](https://github.com/pointfreeco/swift-case-paths)

### スクリーンショット

|ホーム画面(コンテンツあり)|ホーム画面(コンテンツなし)|メニュー画面(For You)|メニュー画面(人気)|サブスクリプション詳細|オンボーディング|
|:--:|:--:|:--:|:--:|:--:|:--:|
|<img src="https://user-images.githubusercontent.com/27538852/84586689-9942d000-ae54-11ea-87a6-7fe11c289725.png" width="300">|<img src="https://user-images.githubusercontent.com/27538852/84586685-93e58580-ae54-11ea-9cff-81bfb3130359.png" width="300">|<img src="https://user-images.githubusercontent.com/27538852/84586686-97790c80-ae54-11ea-868f-1a36ffdc506b.png" width="300">|<img src="https://user-images.githubusercontent.com/27538852/84586719-e2931f80-ae54-11ea-95de-3ef41808aa58.png" width="300">|<img src="https://user-images.githubusercontent.com/27538852/84586820-71a03780-ae55-11ea-9d82-aff99cb54aa4.png" width="300">|<img src="https://user-images.githubusercontent.com/27538852/84586690-99db6680-ae54-11ea-9a40-f886e780432b.png" width="300">|
