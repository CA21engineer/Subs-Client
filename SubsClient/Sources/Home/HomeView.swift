import ComposableArchitecture
import Core
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
        appearance.backgroundColor = UIColor.systemBackground
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    private let onBoardingStore = Store(
        initialState: OnBoarding.State(),
        reducer: OnBoarding.reducer,
        environment: OnBoarding.Environment(
            subscriptionsRepository: AppEnvironment.shared.subscriptionsRepository,
            mainQueue: AppEnvironment.shared.mainQueue
        )
    )

    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                VStack(alignment: .leading) {
                    SlidingTabView(selection: self.$selectedTabIndex, tabs: self.tabs.map { $0.title })
                    if viewStore.subscriptions.isEmpty {
                        VStack(alignment: .center) {
                            Spacer()
                            HStack(alignment: .center) {
                                Spacer()
                                NoContentView {
                                    self.showMenu.toggle()
                                }
                                Spacer()
                            }
                            .padding(.bottom, 48)
                            Spacer()
                        }
                    } else {
                        MySubscriptionListView(
                            userSubscriptions: viewStore.subscriptions,
                            tab: HomeTab(rawValue: self.selectedTabIndex)!
                        )
                    }
                }
                .navigationBarTitle("Subs", displayMode: .inline)
                .navigationBarItems(
                    trailing: Button(action: {
                        self.showMenu.toggle()
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.primary)
                            .font(.system(size: 25))
                    })
                        .sheet(
                            isPresented: self.$showMenu,
                            content: {
                                MenuView()
                            }
                        )
                )
                .onAppear {
                    self.showOnboardingViewIfNeeded()
                }
            }
            .sheet(
                isPresented: self.$showOnBoarding,
                content: {
                    OnBoardingView(store: self.onBoardingStore)
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
            environment: Home.Environment(
                firebaseRepository: AppEnvironment.shared.firebaseRepository,
                mySubscriptionRepository: AppEnvironment.shared.mySubscriptionRepository,
                mainQueue: AppEnvironment.shared.mainQueue
            )
        )

        static var previews: some View {
            HomeView(store: store)
        }
    }
#endif
