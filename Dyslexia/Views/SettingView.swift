
import SwiftUI

struct SettingView: View {
    @State private var largeText = true
    @State private var readAloud = false

    var body: some View {
        NavigationStack {
            ZStack {
                DyslexiaTheme.background.ignoresSafeArea()

                VStack(spacing: 20) {
                    Image(systemName: "gearshape.2.fill")
                        .font(.system(size: 55))
                        .foregroundStyle(DyslexiaTheme.green)

                    Text("Your Settings")
                        .font(.system(size: 30, weight: .bold,
                                      design: .rounded))
                        .foregroundStyle(DyslexiaTheme.text)

                    VStack(spacing: 0) {
                        Toggle("Larger text", isOn: $largeText)
                            .padding(18)

                        Divider()

                        Toggle("Read aloud", isOn: $readAloud)
                            .padding(18)
                    }
                    .tint(DyslexiaTheme.green)
                    .background(DyslexiaTheme.card)
                    .clipShape(RoundedRectangle(cornerRadius: 20))

                    Text("Make your learning space feel right for you.")
                        .font(.system(size: 16, design: .rounded))
                        .foregroundStyle(DyslexiaTheme.muted)
                        .multilineTextAlignment(.center)

                    Spacer()
                }
                .padding(24)
                .frame(maxWidth: 550, maxHeight: .infinity)
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingView()
}
