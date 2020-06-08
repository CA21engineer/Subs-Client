import SwiftUI
import Components

struct HomeView: View {
    @State private var selectedTabIndex = 0
    @State private var showModal: Bool = false

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        appearance.backgroundColor = UIColor(named: "background0")
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                SlidingTabView(selection: $selectedTabIndex, tabs: ["1ヶ月", "3ヶ月", "半年", "一年"])
                if selectedTabIndex == 0 {
                    Text("1ヶ月")
                        .padding()
                } else if selectedTabIndex == 1 {
                    Text("3ヶ月")
                        .padding()
                } else if selectedTabIndex == 2 {
                    Text("半年")
                        .padding()
                } else if selectedTabIndex == 3 {
                    Text("一年")
                    .padding()
                }
                Spacer()
            }
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
