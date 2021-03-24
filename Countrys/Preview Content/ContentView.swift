

import SwiftUI
import Firebase
import GoogleSignIn

struct ContentView: View {
    
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
   
    
    var body: some View {
    
            VStack{
                
                if status{
                    
                    CountryListView()
                    
                }
                else{
                    
                    LoginView()
                }
                
            }.animation(.spring())
            .onAppear {
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { (_) in
                    
                    let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                    self.status = status

            }
        }
    }
}

struct GoogleLoginView: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<GoogleLoginView>) -> GIDSignInButton {
        
        let button = GIDSignInButton()
        button.style = .wide
        button.isHidden = true
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
        return button
        
    }
    
    func updateUIView(_ uiView: GIDSignInButton, context: UIViewRepresentableContext<GoogleLoginView>) {
        
    }
    
    func attemptLoginGoogle() {
        GIDSignIn.sharedInstance()?.signIn()
    }
}
