
import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                DyslexiaTheme.background.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        HStack {
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Hello, Explorer! 🌱")
                                    .font(.system(size: 28, weight: .bold,
                                                  design: .rounded))
                                    .foregroundStyle(DyslexiaTheme.green)

                                Text("Ready for a little learning?")
                                    .font(.system(size: 17, design: .rounded))
                                    .foregroundStyle(DyslexiaTheme.muted)
                            }

                            Spacer()

                            Image("DyslexiaMascot")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 110)
                        }

                        VStack(alignment: .leading, spacing: 12) {
                            Text("Your learning journey")
                                .font(.system(size: 23, weight: .bold,
                                              design: .rounded))
                                .foregroundStyle(DyslexiaTheme.text)

                            Text("Every little step counts. Learn at your own pace.")
                                .font(.system(size: 17, design: .rounded))
                                .foregroundStyle(DyslexiaTheme.muted)

                            Image(systemName: "leaf.fill")
                                .font(.system(size: 32))
                                .foregroundStyle(DyslexiaTheme.green)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        .padding(22)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(DyslexiaTheme.card)
                        .clipShape(RoundedRectangle(cornerRadius: 24))

                        Text("What would you like to do?")
                            .font(.system(size: 23, weight: .bold,
                                          design: .rounded))
                            .foregroundStyle(DyslexiaTheme.text)

                        NavigationLink {
                            LearnView()
                        } label: {
                            activityCard(
                                title: "Let's Learn",
                                subtitle: "Explore letters and words",
                                icon: "book.fill"
                            )
                        }
                        .buttonStyle(.plain)

                        NavigationLink {
                            WriteView()
                        } label: {
                            activityCard(
                                title: "Let's Write",
                                subtitle: "Practise at your own pace",
                                icon: "pencil"
                            )
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(24)
                }
            }
            .navigationTitle("Home")
        }
    }

    private func activityCard(
        title: String,
        subtitle: String,
        icon: String
    ) -> some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(DyslexiaTheme.green)
                .frame(width: 60, height: 60)
                .background(DyslexiaTheme.lightGreen)
                .clipShape(RoundedRectangle(cornerRadius: 18))

            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.system(size: 20, weight: .bold,
                                  design: .rounded))
                    .foregroundStyle(DyslexiaTheme.text)

                Text(subtitle)
                    .font(.system(size: 15, design: .rounded))
                    .foregroundStyle(DyslexiaTheme.muted)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundStyle(DyslexiaTheme.green)
        }
        .padding(18)
        .background(DyslexiaTheme.card)
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }
}

#Preview {
    HomeView()
}
