
import SwiftUI

struct SplashScreenView: View {
    
    @State var isActive : Bool = false
        
        var body: some View {
            
            ZStack{
                Color.pink
                    .opacity(0.15)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                VStack {
                
                    if self.isActive {
                    
                        ContentView()
                        
                    } else {
                    
                        Image ("umaru")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 400, height: 400,  alignment: .center)
                        }
                }
            
                .onAppear {
                
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    
                        withAnimation {
                            self.isActive = true
                    }
                }
            }
        }
        }
        
    }

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
