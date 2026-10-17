
import SwiftUI

struct SignupView: View {
    @State private var parentName = ""
    @State private var contact = ""
    @State private var childName = ""
    @State private var studentID = ""
    @State private var studentPassword = ""
    @State private var showMainApp = false

    var body: some View {
        ZStack {
            DyslexiaTheme.background.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 22) {
                    Image("DyslexiaMascot")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)

                    Text("Let's grow together!")
                        .font(.system(size: 30, weight: .bold,
                                      design: .rounded))
                        .foregroundStyle(DyslexiaTheme.green)

                    Text("First, let's set up your family.")
                        .font(.system(size: 17, design: .rounded))
                        .foregroundStyle(DyslexiaTheme.muted)

                    VStack(alignment: .leading, spacing: 16) {
                        Text("Parent details")
                            .font(.system(size: 21, weight: .bold,
                                          design: .rounded))

                        field("Parent's name", placeholder: "Full name",
                              text: $parentName)

                        field("Email or mobile number",
                              placeholder: "Your contact details",
                              text: $contact)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)

                        Divider()

                        Text("Student account")
                            .font(.system(size: 21, weight: .bold,
                                          design: .rounded))

                        Text("Create the login details your child will use.")
                            .font(.system(size: 15, design: .rounded))
                            .foregroundStyle(DyslexiaTheme.muted)

                        field("Child's name", placeholder: "Child's name",
                              text: $childName)

                        field("Student ID", placeholder: "Create Student ID",
                              text: $studentID)
                            .textInputAutocapitalization(.never)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Student password")
                                .fontWeight(.semibold)

                            SecureField("Create a password",
                                        text: $studentPassword)
                                .appTextFieldStyle()
                        }

                        Button {
                            // Demo navigation only.
                            showMainApp = true
                        } label: {
                            Text("Create account")
                                .font(.system(size: 19, weight: .bold,
                                              design: .rounded))
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 58)
                                .background(DyslexiaTheme.green)
                                .clipShape(RoundedRectangle(cornerRadius: 17))
                        }
                        .padding(.top, 8)
                    }
                    .font(.system(size: 16, design: .rounded))
                    .foregroundStyle(DyslexiaTheme.text)
                    .padding(24)
                    .frame(maxWidth: 540)
                    .background(DyslexiaTheme.card)
                    .clipShape(RoundedRectangle(cornerRadius: 26))
                }
                .frame(maxWidth: .infinity)
                .padding(24)
            }
        }
        .navigationTitle("Sign Up")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $showMainApp) {
            TabsView()
        }
    }

    private func field(
        _ title: String,
        placeholder: String,
        text: Binding<String>
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .fontWeight(.semibold)

            TextField(placeholder, text: text)
                .appTextFieldStyle()
        }
    }
}

#Preview {
    NavigationStack {
        SignupView()
    }
}
