//
//  SubscriptionFormView.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/08.
//

import ComposableArchitecture
import SwiftUI

struct SubscriptionFormView: View {
    private let store: Store<SubscriptionForm.State, SubscriptionForm.Action>

    init(store: Store<SubscriptionForm.State, SubscriptionForm.Action>) {
        self.store = store
    }

    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                VStack {
                    VStack {
                        Button(action: {}) {
                            if viewStore.imageURL != nil {
                                ImageView(image: .init(url: viewStore.imageURL!))
                                    .frame(width: 72, height: 72, alignment: .center)
                                    .clipShape(Circle())
                                    .clipped()
                            } else {
                                ZStack {
                                    Color(UIColor.systemGray2)
                                    Text("Add icon")
                                }
                                .frame(width: 72, height: 72, alignment: .center)
                                .clipShape(Circle())
                                .clipped()
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
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
                            label: "周期(ヶ月)",
                            placeholder: "1ヶ月",
                            binding: viewStore.binding(
                                get: { $0.cycle },
                                send: SubscriptionForm.Action.changeCycle
                            )
                        )
                        Divider()
                        DatePickerTextField(
                            label: "支払い開始日",
                            placeholder: "2020/06/01",
                            binding: viewStore.binding(
                                get: { $0.startedAt },
                                send: SubscriptionForm.Action.changeStartedAt
                            )
                        )

                    }
                    .padding()
                    .border(Color(UIColor.systemGray2), width: 1)
                    .padding()
                    Spacer()
                }
                .navigationBarTitle("登録フォーム", displayMode: .inline)
                .navigationBarItems(
                    trailing: Button(action: {}) {
                        Text("登録")
                })
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
                    environment: .shared
                )
            ).previewLayout(.sizeThatFits)
        }
    }
}
