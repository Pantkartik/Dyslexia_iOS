
import SwiftUI

struct LearnView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                DyslexiaTheme.background.ignoresSafeArea()

                VStack(spacing: 24) {
                    Image(systemName: "book.closed.fill")
                        .font(.system(size: 64))
                        .foregroundStyle(DyslexiaTheme.green)

                    Text("Let's Learn!")
                        .font(.system(size: 32, weight: .bold,
                                      design: .rounded))
                        .foregroundStyle(DyslexiaTheme.text)

                    Text("Every new word is an adventure.")
                        .font(.system(size: 18, design: .rounded))
                        .foregroundStyle(DyslexiaTheme.muted)
                        .multilineTextAlignment(.center)

                    Text("More learning activities coming soon!")
                        .font(.system(size: 16, design: .rounded))
                        .foregroundStyle(DyslexiaTheme.green)
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(DyslexiaTheme.card)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .padding(28)
                .frame(maxWidth: 520)
            }
            .navigationTitle("Learn")
        }
    }
}

#Preview {
    LearnView()
}
