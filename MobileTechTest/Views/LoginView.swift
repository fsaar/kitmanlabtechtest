import SwiftUI


struct LoginView: View {
    @Binding var path: NavigationPath
    @State private var userName: String = ""
    @State private var password: String = ""
    @State var model : LogonViewModel
    @State var isLoggingIn = false
    var isLogonButtonEnabled: Bool {
        return !userName.isEmpty && !password.isEmpty
    }
    var body: some View {
        VStack {
            HStack {
                Text("username")
                TextField("Username",text: $userName)
            }
            HStack {
                Text("password")
                TextField("Password",text: $password)
            }
           
            Button("Logon") {
                
                Task {
                    self.isLoggingIn = true
                    await model.logon(username: userName, password: password)
                    self.isLoggingIn = false
                }
            }
            .padding(.top,16)
            .disabled(!isLogonButtonEnabled || isLoggingIn)
        }
        .font(.title)
        .padding(16)
        .onReceive(model.$loggedIn) { loggedIn in
            if loggedIn {
                path.append(Route.squadListView)
            }
        }
    }
       
}
//
//#Preview {
//    LoginView(model: LogonViewModel())
//}
