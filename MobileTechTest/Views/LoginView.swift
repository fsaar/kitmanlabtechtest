import SwiftUI

struct LoginView: View {
    enum Input {
        case userName
        case password
    }
    @Binding var path: NavigationPath
    @State private var userName: String = ""
    @State private var password: String = ""
    @State var model : LogonViewModel
    @State var isLoggingIn = false
    @FocusState private var focus: Input?
    
    var isLogonButtonEnabled: Bool {
        return [userName,password].allSatisfy { $0.count >= 3 }
    }
    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .leading) {
                    Text("username".uppercased())
                    TextField("Username",text: $userName)
                        .focused($focus, equals: .userName)
                        .submitLabel(.next)
                }
                VStack(alignment: .leading) {
                    Text("password".uppercased())
                    TextField("Password",text: $password)
                        .focused($focus, equals: .password)
                        .submitLabel(.done)
                    
                }
                .padding(.top,16)
                Text("at least 3 characters").font(.body)
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
            .onSubmit {
                switch focus {
                case .userName:
                    focus = .password
                    
                default:
                    focus = nil
                }
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
                    .progressViewStyle(.circular)
                    .controlSize(.large)
                    .tint(.white)
                
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
