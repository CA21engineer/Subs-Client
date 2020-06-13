//
//  OnBoardingView.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/10.
//

import ComposableArchitecture
import SwiftUI

struct OnBoardingView: View {
    @Environment(\.presentationMode) private var presentationMode

    let store: Store<OnBoarding.State, OnBoarding.Action>

    init(store: Store<OnBoarding.State, OnBoarding.Action>) {
        self.store = store
    }

    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 8) {
                Text("以下のアプリをインストールしているようです。")
                    .fontWeight(.bold)
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                Text("サブスクリプション登録しているサービスを追加しましょう。")
                    .fontWeight(.regular)
                    .font(.system(size: 14))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
            }
            .padding(.vertical, 16)

            OnBoardingSubscriptionListView(store: store)

            Spacer()

            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("ホームに戻る")
                    .fontWeight(.bold)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 9)
                    .background(Color.primary)
                    .foregroundColor(Color(UIColor.systemBackground))
                    .cornerRadius(24)
            }
            .padding(.bottom, 32)
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    private static let store = Store<OnBoarding.State, OnBoarding.Action>(
        initialState: .init(),
        reducer: OnBoarding.reducer,
        environment: OnBoarding.Environment(
            subscriptionsRepository: AppEnvironment.shared.subscriptionsRepository, mainQueue: AppEnvironment.shared.mainQueue
        )
    )

    static var previews: some View {
        OnBoardingView(store: store)
    }
}
