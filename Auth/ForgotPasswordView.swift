
import SwiftUI

struct ForgotPasswordView: View {
    @State private var contact = ""
    @State private var showMessage = false

    var body: some View {
        ZStack {
            DyslexiaTheme.background.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    Image("DyslexiaMascot")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 240, maxHeight: 210)

                    Text("It's okay! 🌱")
                        .font(.system(size: 32, weight: .bold,
                                      design: .rounded))
                        .foregroundStyle(DyslexiaTheme.green)

                    Text("Let's get you back on track.")
                        .font(.system(size: 20, weight: .semibold,
                                      design: .rounded))
                        .foregroundStyle(DyslexiaTheme.text)

                    Text("Enter your parent's registered email or mobile number.")
                        .font(.system(size: 17, design: .rounded))
                        .foregroundStyle(DyslexiaTheme.muted)
                        .multilineTextAlignment(.center)

                    VStack(alignment: .leading, spacing: 14) {
                        Text("Parent email or mobile")
                            .fontWeight(.semibold)

                        TextField("Enter email or mobile",
                                  text: $contact)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .appTextFieldStyle()

                        Button {
                            showMessage = true
                        } label: {
                            Text("Help me get back in")
                                .font(.system(size: 18, weight: .bold,
                                              design: .rounded))
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .background(DyslexiaTheme.green)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                    }
                    .padding(24)
                    .frame(maxWidth: 500)
                    .background(DyslexiaTheme.card)
                    .clipShape(RoundedRectangle(cornerRadius: 26))

                    .alert("You're on the right track!",
                           isPresented: $showMessage) {
                        Button("Okay", role: .cancel) { }
                    } message: {
                        Text("Password recovery will be available once your account is connected.")
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(24)
            }
        }
        .navigationTitle("Forgot Password")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ForgotPasswordView()
    }
}
