
import SwiftUI

struct TabsView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            LearnView()
                .tabItem {
                    Label("Learn", systemImage: "book.fill")
                }

            WriteView()
                .tabItem {
                    Label("Write", systemImage: "pencil")
                }

            SettingView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
        .tint(DyslexiaTheme.green)
    }
}

#Preview {
    TabsView()
}
