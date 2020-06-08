//
//  MenuView.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/08.
//

import SwiftUI
import Components

struct MenuView: View {
    @State private var selectedTabIndex = 0
    @State private var showModal: Bool = false

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        appearance.backgroundColor = UIColor(named: "background1")
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                SlidingTabView(selection: $selectedTabIndex, tabs: ["For You", "Popular"])
                if selectedTabIndex == 0 {
                    Text("For You")
                        .padding()
                } else if selectedTabIndex == 1 {
                    Text("Popular")
                        .padding()
                }
                Spacer()
            }
            .navigationBarTitle("選択する", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    self.showModal = true
                }, label: {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.black)
                })
                .sheet(
                    isPresented: self.$showModal,
                    content: {
                        SubscriptionFormView()
                })
            )
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
