import ComposableArchitecture
import SwiftUI

struct HomeView: View {
    private let store: Store<Home.State, Home.Action>
    @State private var selectedTabIndex = 0
    @State private var showModal: Bool = false
    private let tabs = HomeTab.allCases

    init(store: Store<Home.State, Home.Action>) {
        self.store = store
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        appearance.backgroundColor = UIColor(named: "background1")
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                VStack(alignment: .leading) {
                    SlidingTabView(selection: self.$selectedTabIndex, tabs: self.tabs.map { $0.title })
                    MySubscriptionListView(subscriptions: viewStore.subscriptions, tab: HomeTab(rawValue: self.selectedTabIndex)!)
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
                            }
                        )
                )
            }
            .onAppear {
                viewStore.send(.fetchMySubscriptions)
            }
        }
    }
}

#if DEBUG

    struct HomeView_Previews: PreviewProvider {
        private static let store = Store(
            initialState: Home.State(),
            reducer: Home.reducer,
            environment: Home.Environment(
                mySubscriptionRepository: AppEnvironment.shared.mySubscriptionRepository,
                mainQueue: AppEnvironment.shared.mainQueue
            )
        )

        static var previews: some View {
            HomeView(store: store)
        }
    }
#endif
