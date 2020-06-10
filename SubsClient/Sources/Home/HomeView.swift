import ComposableArchitecture
import SwiftUI

struct HomeView: View {
    private let store: Store<Home.State, Home.Action>
    @State private var selectedTabIndex = 0
    @State private var showMenu = false
    @State private var showOnBoarding = false
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
                        .onAppear {
                            self.showOnboardingViewIfNeeded()
                        }
                }
                .navigationBarTitle("Subs", displayMode: .inline)
                .navigationBarItems(
                    trailing: Button(action: {
                        self.showMenu.toggle()
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.black)
                            .font(.system(size: 25))
                    })
                        .sheet(
                            isPresented: self.$showMenu,
                            content: {
                                MenuView()
                            }
                        )
                )
            }
            .sheet(
                isPresented: self.$showOnBoarding,
                content: {
                    OnBoardingView()
                }
            )
            .onAppear {
                viewStore.send(.fetchMySubscriptions)
            }
        }
    }

    private func showOnboardingViewIfNeeded() {
        let hasAlreadyLaunchedBefore = UserDefaults.standard.bool(forKey: "hasAlreadyLaunchedBefore")
        if !hasAlreadyLaunchedBefore {
            // show onboarding view
            UserDefaults.standard.set(true, forKey: "hasAlreadyLaunchedBefore")
            // TODO: onboardingを出すタイミングでもインストールされてるアプリが0のときは表示しない
            showOnBoarding.toggle()
        }
    }
}

#if DEBUG

    struct HomeView_Previews: PreviewProvider {
        private static let store = Store(
            initialState: Home.State(),
            reducer: Home.reducer,
            environment: AppEnvironment.shared
        )

        static var previews: some View {
            HomeView(store: store)
        }
    }
#endif
