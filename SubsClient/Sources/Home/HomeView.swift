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
        UserSubscription(id: "1", name: "Netflix", serviceType: "1", price: 800, cycle: 1, isOriginal: false),
        UserSubscription(id: "2", name: "Netflix", serviceType: "2", price: 800, cycle: 1, isOriginal: false),
        UserSubscription(id: "3", name: "Netflix", serviceType: "3", price: 800, cycle: 1, isOriginal: false),
        UserSubscription(id: "4", name: "Netflix", serviceType: "4", price: 800, cycle: 1, isOriginal: false),
        UserSubscription(id: "5", name: "Netflix", serviceType: "5", price: 800, cycle: 1, isOriginal: false),
        UserSubscription(id: "6", name: "Netflix", serviceType: "6", price: 800, cycle: 1, isOriginal: false)
    ]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                SlidingTabView(selection: $selectedTabIndex, tabs: tabs.map { $0.title })
                MySubscriptionListView(subscriptions: subscriptions, tab: HomeTab(rawValue: selectedTabIndex)!)
            }
            .navigationBarTitle("Subs", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    self.showModal = true
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.black)
                        .font(.system(size: 25))
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
