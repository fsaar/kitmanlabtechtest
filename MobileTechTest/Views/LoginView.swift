import SwiftUI


struct LoginView: View {
    @State private var userName: String = ""
    @State private var password: String = ""
    @State var model : LogonViewModel
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
                    await model.logon(username: userName, password: password)
                }
            }
            .padding(.top,16)
            .disabled(isLogonButtonEnabled)
        }
        .font(.title)
        .padding(16)
        .navigationDestination(isPresented:$model.loggedIn) {
            SquadListView(model: SquadViewModel())
            
        }
    }
       
}

#Preview {
    LoginView(model: LogonViewModel())
}
