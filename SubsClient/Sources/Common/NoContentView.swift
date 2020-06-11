//
//  NoContentView.swift
//
//
//  Created by 長田卓馬 on 2020/06/11.
//

import SwiftUI

struct NoContentView: View {
    let tapButton: () -> Void

    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Image(uiImage: Asset.Assets.surfingIsometric.image)
                .resizable()
                .frame(width: 180, height: 130)

            Text("登録しているサービスがまだありません")
                .fontWeight(.semibold)
                .font(.system(size: 14))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)

            Button(action: tapButton) {
                Text("追加する")
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 9)
                    .background(Color.primary)
                    .foregroundColor(.white)
                    .cornerRadius(24)
            }
        }
    }
}

struct NoContentView_Previews: PreviewProvider {
    static var previews: some View {
        NoContentView(tapButton: {})
    }
}
