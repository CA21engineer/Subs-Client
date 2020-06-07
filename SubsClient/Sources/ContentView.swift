import SwiftUI

struct ContentView: View {
    @State private var selectedTabIndex = 0

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text("Subs")
                    .fontWeight(.bold)
                Spacer()
            }
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
        .padding(.top)
    }
}

#if DEBUG

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
