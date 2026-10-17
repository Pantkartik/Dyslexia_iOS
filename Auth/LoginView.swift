
import SwiftUI

struct LoginView: View {
    @State private var role = "Student"
    @State private var studentID = ""
    @State private var password = ""
    @State private var parentContact = ""
    @State private var showPassword = false
    @State private var showMainApp = false

    var body: some View {
        NavigationStack {
            ZStack {
                DyslexiaTheme.background.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 24) {
                        Image("DyslexiaMascot")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 230, maxHeight: 190)

                        VStack(spacing: 8) {
                            Text("BrightSteps")
                                .font(.system(size: 36, weight: .bold,
                                              design: .rounded))
                                .foregroundStyle(DyslexiaTheme.green)

                            Text("A happy place to learn your way")
                                .font(.system(size: 17, design: .rounded))
                                .foregroundStyle(DyslexiaTheme.muted)
                        }

                        VStack(spacing: 20) {
                            Text("Welcome back!")
                                .font(.system(size: 29, weight: .bold,
                                              design: .rounded))
                                .foregroundStyle(DyslexiaTheme.text)

                            Text("How would you like to sign in?")
                                .font(.system(size: 17, design: .rounded))
                                .foregroundStyle(DyslexiaTheme.muted)

                            HStack(spacing: 12) {
                                roleButton("Student", icon: "face.smiling")
                                roleButton("Parent", icon: "person.2.fill")
                            }

                            if role == "Student" {
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("Student ID")
                                        .fontWeight(.semibold)

                                    TextField("Enter your Student ID",
                                              text: $studentID)
                                        .textInputAutocapitalization(.never)
                                        .autocorrectionDisabled()
                                        .appTextFieldStyle()

                                    Text("Password")
                                        .fontWeight(.semibold)

                                    HStack {
                                        Group {
                                            if showPassword {
                                                TextField("Enter password",
                                                          text: $password)
                                            } else {
                                                SecureField("Enter password",
                                                            text: $password)
                                            }
                                        }

                                        Button {
                                            showPassword.toggle()
                                        } label: {
                                            Image(systemName: showPassword
                                                  ? "eye.slash" : "eye")
                                                .foregroundStyle(
                                                    DyslexiaTheme.muted
                                                )
                                        }
                                    }
                                    .appTextFieldStyle()
                                }
                                .foregroundStyle(DyslexiaTheme.text)
                            } else {
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("Parent email or mobile number")
                                        .fontWeight(.semibold)

                                    TextField("Enter email or mobile",
                                              text: $parentContact)
                                        .keyboardType(.emailAddress)
                                        .textInputAutocapitalization(.never)
                                        .autocorrectionDisabled()
                                        .appTextFieldStyle()
                                }
                                .foregroundStyle(DyslexiaTheme.text)
                            }

                            Button {
                                // Demo navigation only.
                                showMainApp = true
                            } label: {
                                Text("Continue")
                                    .font(.system(size: 19, weight: .bold,
                                                  design: .rounded))
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 58)
                                    .background(DyslexiaTheme.green)
                                    .clipShape(RoundedRectangle(
                                        cornerRadius: 17
                                    ))
                            }

                            NavigationLink("Forgot password?") {
                                ForgotPasswordView()
                            }
                            .fontWeight(.semibold)
                            .tint(DyslexiaTheme.green)

                            Divider()

                            HStack {
                                Text("New to BrightSteps?")
                                    .foregroundStyle(DyslexiaTheme.muted)

                                NavigationLink("Create account") {
                                    SignupView()
                                }
                                .fontWeight(.bold)
                                .tint(DyslexiaTheme.green)
                            }
                            .font(.system(size: 15, design: .rounded))
                        }
                        .padding(26)
                        .frame(maxWidth: 520)
                        .background(DyslexiaTheme.card)
                        .clipShape(RoundedRectangle(cornerRadius: 28))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(24)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(isPresented: $showMainApp) {
                TabsView()
            }
        }
        .tint(DyslexiaTheme.green)
    }

    private func roleButton(_ title: String, icon: String) -> some View {
        Button {
            role = title
        } label: {
            HStack {
                Image(systemName: icon)
                Text(title)
            }
            .font(.system(size: 17, weight: .semibold, design: .rounded))
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .foregroundStyle(role == title ? .white : DyslexiaTheme.green)
            .background(
                role == title
                ? DyslexiaTheme.green
                : DyslexiaTheme.lightGreen
            )
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    LoginView()
}
