import SwiftUI
import Components

struct HomeView: View {
    @State private var selectedTabIndex = 0
    @State private var showModal: Bool = false
    private let tabs = HomeTab.allCases

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        appearance.backgroundColor = UIColor(named: "background1")
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    private var subscriptions = [
        UserSubscription(id: "1", name: "hoge1", serviceType: "1", price: 1, cycle: 1, isOriginal: false),
        UserSubscription(id: "2", name: "hoge2", serviceType: "2", price: 1, cycle: 1, isOriginal: false),
        UserSubscription(id: "3", name: "hoge3", serviceType: "3", price: 1, cycle: 1, isOriginal: false),
        UserSubscription(id: "4", name: "hoge4", serviceType: "4", price: 1, cycle: 1, isOriginal: false),
        UserSubscription(id: "5", name: "hoge5", serviceType: "5", price: 1, cycle: 1, isOriginal: false),
        UserSubscription(id: "6", name: "hoge6", serviceType: "6", price: 1, cycle: 1, isOriginal: false)
    ]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                SlidingTabView(selection: $selectedTabIndex, tabs: tabs.map { $0.title })
                MySubscriptionListView(subscriptions: subscriptions, tab: HomeTab(rawValue: selectedTabIndex)!)
            }
            .background(Color("background0"))
            .navigationBarTitle("Subs", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    self.showModal = true
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.black)
                })
                .sheet(
                    isPresented: self.$showModal,
                    content: {
                        MenuView()
                })
            )
        }
    }
}

#if DEBUG

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
#endif
