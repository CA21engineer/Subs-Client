//
//  SlidingTabView.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/07.
//

import SwiftUI

struct SlidingTabView: View {
    @State private var selectionState: Int = 0 {
        didSet {
            selection = selectionState
        }
    }

    @Binding var selection: Int

    let tabs: [String]
    let animation: Animation
    let activeAccentColor: Color
    let inactiveAccentColor: Color
    let selectionBarColor: Color
    let inactiveTabColor: Color
    let activeTabColor: Color
    let selectionBarHeight: CGFloat
    let selectionBarBackgroundColor: Color
    let selectionBarBackgroundHeight: CGFloat

    init(selection: Binding<Int>,
         tabs: [String],
         animation: Animation = .spring(),
         activeAccentColor: Color = .black,
         inactiveAccentColor: Color = Color.black.opacity(0.4),
         selectionBarColor: Color = .black,
         inactiveTabColor: Color = Color("background1"),
         activeTabColor: Color = Color("background1"),
         selectionBarHeight: CGFloat = 2,
         selectionBarBackgroundColor: Color = Color.gray.opacity(0.2),
         selectionBarBackgroundHeight: CGFloat = 2) {
        _selection = selection
        self.tabs = tabs
        self.animation = animation
        self.activeAccentColor = activeAccentColor
        self.inactiveAccentColor = inactiveAccentColor
        self.selectionBarColor = selectionBarColor
        self.inactiveTabColor = inactiveTabColor
        self.activeTabColor = activeTabColor
        self.selectionBarHeight = selectionBarHeight
        self.selectionBarBackgroundColor = selectionBarBackgroundColor
        self.selectionBarBackgroundHeight = selectionBarBackgroundHeight
    }

    var body: some View {
        assert(tabs.count > 1, "Must have at least 2 tabs")

        return VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                ForEach(self.tabs, id: \.self) { tab in
                    Button(action: {
                        let selection = self.tabs.firstIndex(of: tab) ?? 0
                        self.selectionState = selection
                    }) {
                        HStack {
                            Spacer()
                            Text(tab)
                                .fontWeight(.bold)
                            Spacer()
                        }
                    }
                    .padding(.vertical, 8)
                    .accentColor(
                        self.isSelected(tabIdentifier: tab)
                            ? self.activeAccentColor
                            : self.inactiveAccentColor)
                    .background(
                        self.isSelected(tabIdentifier: tab)
                            ? self.activeTabColor
                            : self.inactiveTabColor)
                }
            }
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(self.selectionBarColor)
                        .frame(
                            width: self.tabWidth(from: geometry.size.width),
                            height: self.selectionBarHeight,
                            alignment: .leading
                        )
                        .offset(
                            x: self.selectionBarXOffset(from: geometry.size.width),
                            y: 0
                        )
                        .animation(self.animation)
                    Rectangle()
                        .fill(self.selectionBarBackgroundColor)
                        .frame(
                            width: geometry.size.width,
                            height: self.selectionBarBackgroundHeight,
                            alignment: .leading
                        )
                }
                .fixedSize(horizontal: false, vertical: true)
            }
            .fixedSize(horizontal: false, vertical: true)
            .frame(height: self.selectionBarHeight)
        }
    }

    private func isSelected(tabIdentifier: String) -> Bool {
        tabs[selectionState] == tabIdentifier
    }

    private func selectionBarXOffset(from totalWidth: CGFloat) -> CGFloat {
        tabWidth(from: totalWidth) * CGFloat(selectionState)
    }

    private func tabWidth(from totalWidth: CGFloat) -> CGFloat {
        totalWidth / CGFloat(tabs.count)
    }
}

#if DEBUG

    struct SlidingTabConsumerView: View {
        @State private var selectedTabIndex = 0

        var body: some View {
            VStack(alignment: .leading) {
                SlidingTabView(
                    selection: self.$selectedTabIndex,
                    tabs: ["First", "Second"],
                    activeAccentColor: Color.blue,
                    selectionBarColor: Color.blue
                )
                (selectedTabIndex == 0 ? Text("First View") : Text("Second View")).padding()
                Spacer()
            }
            .padding(.top, 50)
            .animation(.none)
        }
    }

    struct SlidingTabView_Previews: PreviewProvider {
        static var previews: some View {
            SlidingTabConsumerView()
        }
    }
#endif
