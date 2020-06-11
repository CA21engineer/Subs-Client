//
//  IconsView.swift
//  SubsClient
//
//  Created by 伊藤凌也 on 2020/06/12.
//

import Grid
import SwiftUI

struct IconsView: View {
    let icons: [Subscription_IconImage]
    let onTap: (Subscription_IconImage) -> Void
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            Grid(icons.filter { $0.url != nil }) { icon in
                Group {
                    ImageView(
                        image: .init(url: icon.url!)
                    )
                }
                .aspectRatio(1.0, contentMode: .fit)
                .padding()
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(lineWidth: 0.5)
                        .foregroundColor(Color(UIColor.systemGray2))
                )
                .frame(maxWidth: 70, maxHeight: 70)
                .onTapGesture {
                    self.onTap(icon)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
            .padding()
            .gridStyle(
                ModularGridStyle(
                    columns: .count(5),
                    rows: .fixed(70)
                )
            )
        }
    }
}

struct IconsView_Previews: PreviewProvider {
    static let icons = [
        Subscription_IconImage.with {
            $0.iconID = "1"
            $0.iconUri = "https://github.com/ry-itto.png"
        },
        Subscription_IconImage.with {
            $0.iconID = "2"
            $0.iconUri = "https://github.com/takumaosada.png"
        },
        Subscription_IconImage.with {
            $0.iconID = "3"
            $0.iconUri = ""
        },
    ]
    static var previews: some View {
        IconsView(
            icons: icons,
            onTap:{ _ in }
        )
    }
}

extension Int: Identifiable {
    public var id: Int {
        self
    }
}
