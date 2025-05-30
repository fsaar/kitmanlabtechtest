import SwiftUI

struct LoginView: View {
    @Binding var path: NavigationPath
    @State private var userName: String = ""
    @State private var password: String = ""
    @State var model : LogonViewModel
    @State var isLoggingIn = false
    var isLogonButtonEnabled: Bool {
        return [userName,password].allSatisfy { $0.count >= 3 }
    }
    var body: some View {
        ZStack {
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
            VStack {
                ProgressView("Logging In")
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .ignoresSafeArea()
            .background(.black.opacity(0.8))
            .isHidden(isHidden: !isLoggingIn)
        }
       
    }
       
}

#Preview {
    @Previewable @State var path = NavigationPath()
    LoginView(path: $path, model: LogonViewModel())
}
