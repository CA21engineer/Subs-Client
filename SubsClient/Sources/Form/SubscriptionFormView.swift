//
//  SubscriptionFormView.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/08.
//

import ComposableArchitecture
import Core
import SwiftUI

struct SubscriptionFormView: View {
    let store: Store<SubscriptionForm.State, SubscriptionForm.Action>
    @State private var showsIconsModal: Bool = false

    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                VStack {
                    Button(action: {
                        self.showsIconsModal = true
                    }) {
                        if viewStore.imageURL != nil {
                            ImageView(image: .init(url: viewStore.imageURL!))
                                .frame(width: 72, height: 72, alignment: .center)
                                .clipShape(Circle())
                                .clipped()
                        } else {
                            ZStack {
                                Color(UIColor.systemGray2)
                                Image(systemName: "photo")
                                    .foregroundColor(Color(UIColor.systemBackground))
                                    .font(.system(size: 24, weight: .semibold))
                            }
                            .frame(width: 72, height: 72, alignment: .center)
                            .clipShape(Circle())
                            .clipped()
                        }
                    }
                    .disabled(viewStore.isOriginal)
                    .buttonStyle(PlainButtonStyle())
                    .sheet(isPresented: self.$showsIconsModal) {
                        IconsView(
                            store: .init(
                                initialState: .init(),
                                reducer: Icons.reducer,
                                environment: Icons.Environment(
                                    iconImageRepository: AppEnvironment.shared.iconImageRepository,
                                    mainQueue: AppEnvironment.shared.mainQueue
                                )
                            ),
                            onTap: { icon in
                                viewStore.send(.changeIcon(icon.iconID, icon.url!))
                            }
                        )
                    }
                    HStack {
                        Text("¥")
                        TextField(
                            "0",
                            value: viewStore.binding(
                                get: { $0.price },
                                send: SubscriptionForm.Action.changePrice
                            ),
                            formatter: NumberFormatter()
                        )
                        .frame(width: 100)
                        .textContentType(.creditCardNumber)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    }.padding()
                    Divider()
                    LabeledTextField(
                        label: "サービス名",
                        placeholder: "Enter name",
                        binding: viewStore.binding(
                            get: { $0.serviceName },
                            send: SubscriptionForm.Action.changeServiceName
                        )
                    )
                    Divider()
                    LabeledTextField(
                        label: "周期(月)",
                        placeholder: "1ヶ月",
                        binding: viewStore.binding(
                            get: { $0.cycle },
                            send: SubscriptionForm.Action.changeCycle
                        )
                    )
                    Divider()
                    DatePickerTextField(
                        label: "支払い開始日",
                        binding: viewStore.binding(
                            get: { $0.startedAt },
                            send: SubscriptionForm.Action.changeStartedAt
                        )
                    )
                }
                .padding()
                .border(Color(UIColor.systemGray2), width: 1)
                .padding()
            }
        }
    }
}

struct SubscriptionFormView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SubscriptionFormView(
                store: .init(
                    initialState: .init(),
                    reducer: SubscriptionForm.reducer,
                    environment: SubscriptionForm.Environment()
                )
            )
            .previewLayout(.sizeThatFits)
            .environment(\.colorScheme, .dark)
        }
    }
}
