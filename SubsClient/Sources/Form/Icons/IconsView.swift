//
//  IconsView.swift
//  SubsClient
//
//  Created by 伊藤凌也 on 2020/06/12.
//

import ComposableArchitecture
import Core
import Grid
import SwiftUI

struct IconsView: View {
    let store: Store<Icons.State, Icons.Action>
    let onTap: (Subscription_IconImage) -> Void
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                ScrollView {
                    Grid(viewStore.icons.filter { $0.url != nil }) { icon in
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
                .navigationBarTitle("アイコンを選択する", displayMode: .inline)
                .onAppear {
                    viewStore.send(.load)
                }
            }
        }
    }
}

struct IconsView_Previews: PreviewProvider {
    static var previews: some View {
        IconsView(
            store: .init(
                initialState: .init(),
                reducer: Icons.reducer,
                environment: Icons.Environment(
                    iconImageRepository: AppEnvironment.shared.iconImageRepository,
                    mainQueue: AppEnvironment.shared.mainQueue
                )
            ),
            onTap: { _ in }
        )
    }
}

extension Int: Identifiable {
    public var id: Int {
        self
    }
}
