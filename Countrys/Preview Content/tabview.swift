

import SwiftUI
import Firebase
import SDWebImageSwiftUI
import GoogleSignIn

struct tabview: View {
    
    var body: some View {
        
        ZStack{
            Color.pink
                .opacity(0.15)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            TabView {
                Home()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                objectsListView()
                    .tabItem {
                        Image(systemName: "mappin.circle.fill")
                        Text("Explore")
                    }
                Profile()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                Settings()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }
        }
    }
    
    func logOut() {
        GIDSignIn.sharedInstance()?.signOut()
        try! Auth.auth().signOut()
    }
    
}


struct Home: View {
    
    @State private var isLoading = false
    @State var user = Auth.auth().currentUser
    
    var body: some View {
        
        ZStack{
            Color.pink
                .opacity(0.15)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Text("HELLO")
                Text("\n\(user!.displayName!)")
                
                
            } .redacted(when: isLoading)
            
            if isLoading {
                ZStack {
                    Color(.white)
                        .opacity(0.3)
                        .ignoresSafeArea()
                    ProgressView("Loading")
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(.systemBackground))
                        )
                        .shadow(radius: 20 )
                }
            }
        } .onAppear{ loading() }
    }
    
    func loading () {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) {
            isLoading = false
        }
    }
}

struct Profile: View {
    
    weak var profilePic: UIImageView!
    @State private var isLoading = false
    @State var user = Auth.auth().currentUser
    
    var body: some View {
        
        ZStack{
            
            Color.pink
                .opacity(0.15)
                .edgesIgnoringSafeArea(.all)
            
            Rectangle()
                .fill(Color.purple)
                .opacity(0.50)
                .frame(width: 500, height: 500)
                .padding(EdgeInsets(top: -700, leading: 0, bottom: 0, trailing: 0))
            
            VStack (alignment: .center){
                //                Text("HELLO")
                Text("\n\(user!.displayName!)")
                    .font(.system(size: 30, weight: .heavy))
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: -170, leading: 0, bottom: 0, trailing: 0))
                
                WebImage(url: user?.photoURL)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 110, height: 110, alignment: .center)
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .padding(EdgeInsets(top: -90, leading: 0, bottom: 100, trailing: 0))
                    .shadow(radius: 2)
                
                VStack (alignment: .leading) {
                    
                    HStack {
                        Image ("person")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30, alignment: .leading)
                            .alignmentGuide(VerticalAlignment.center) { _ in 5 }
                        
                        Text("\n\(user!.displayName!)")
                            .multilineTextAlignment(.leading)
                    }
                    Divider().frame(maxWidth: 350)
                    
                    HStack {
                        Image("email")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30, alignment: .leading)
                            .alignmentGuide(VerticalAlignment.center) { _ in 5 }
                        
                        Text("\n\(user!.email!)")
                            .multilineTextAlignment(.leading)
                        
                    }
                    Divider().frame(maxWidth: 350)
                }                     .padding(EdgeInsets(top: -50, leading: 0, bottom: 100, trailing: 0))
                
            } .redacted(when: isLoading)
            if isLoading {
                ZStack {
                    Color(.white)
                        .opacity(0.3)
                        .ignoresSafeArea()
                    ProgressView("Loading")
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(.systemBackground))
                        )
                        .shadow(radius: 20 )
                }
            }
        } .onAppear{ loading() }
        
    }
    
    func loading () {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) {
            isLoading = false
        }
    }
}

struct Settings: View {
    
    @State private var showalert = false
    
    var body: some View {
        ZStack{
            
            Color.pink
                .opacity(0.15)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Button(action: {
                        
                    showalert = true
                    
                }) {
                    Text("Logout")
                }
                .padding()
                .frame(minWidth: 50, maxWidth: 200)
                .background(Color.pink)
                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color.white)
                .cornerRadius(5.0)
                
            }   .alert(isPresented: $showalert) { Alert(title: Text("Logout"), message: Text("areYouSure"), primaryButton: .destructive(Text("Yes"), action: self.signout) , secondaryButton: .cancel(Text("No")))
            }
        }
    }
    
    func signout() {
        do {
        try! Auth.auth().signOut()
        GIDSignIn.sharedInstance()?.signOut()
        UserDefaults.standard.set(false, forKey: "status")
        NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
        
    }
}
