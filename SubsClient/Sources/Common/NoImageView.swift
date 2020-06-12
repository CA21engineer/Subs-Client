//
//  NoImageView.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/12.
//

import SwiftUI

struct NoImageView: View {
    var body: some View {
        ZStack {
            Rectangle().fill(Color.primary.opacity(0.1))
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 20, height: 20)
        }
    }
}

struct NoImageView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NoImageView()
                .frame(width: 48, height: 48)
                .cornerRadius(4)
        }
    }
}
