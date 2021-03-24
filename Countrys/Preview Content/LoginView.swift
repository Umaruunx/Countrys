
import SwiftUI

struct LoginView: View {
    
    let googlesignin = GoogleLoginView()
    
    var body: some View {
        
        NavigationView{
            
            ZStack{
                Color.pink
                    .opacity(0.15)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                VStack{
                    Image("login2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 150)
                        .padding(EdgeInsets(top: 150, leading: 20, bottom: 0, trailing: 20))
                    
                    Button(action: {
                        self.googlesignin.attemptLoginGoogle()
                    }) {
                        HStack{
                            Image("google2")
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24, alignment: .leading)
                        
                            Text("signInGoolge")
                                .foregroundColor(.pink
                                )
                                .multilineTextAlignment(.center)
                        }
                    }
                    .frame(width: 300, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color.white)
                    .cornerRadius(20)
                    
                    googlesignin
                        .hidden()
                }
            }
        }
    }
}
