

import Alamofire
import SwiftUI
import Network
import SystemConfiguration

struct DetailView: View {
    
    @State var country: Response
    @State var isLoading  = false
    
    var body: some View {
        
        ZStack{
            
            Color.pink
                .opacity(0.15)
                .edgesIgnoringSafeArea(.all)
            
            RoundedRectangle(cornerRadius: 50, style: .circular)
                .fill(Color.purple)
                .opacity(0.50)
                .frame(width: 380, height: 350)
                .padding(EdgeInsets(top: -600, leading: 0, bottom: 0, trailing: 0))
            
            VStack (alignment: .center){
                Text(country.name)
                    .font(.system(size: 40, weight: .heavy))
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: -60, leading: 0, bottom: 0, trailing: 0))
                    .unredacted()
                
                UrlImageView(urlString: country.flagPNG)
                    .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
                    .redacted(when: isLoading)
                
                VStack (alignment: .leading) {
                    
                    HStack {
                        
                        Text("area =")
                            .font(.system(size: 17, weight: .heavy))
                        Text(String(country.area ?? 0))
                    } .padding(0.1)
                    
                    VStack (alignment: .leading) {
                        
                        HStack {
                            Text("a2c =")
                                .font(.system(size: 17, weight:  .heavy))
                            Text(country.alpha2Code)
                        } .padding(0.1)
                        
                        HStack{
                            Text("a3c =")
                                .font(.system(size: 17, weight: .heavy))
                            Text(country.alpha3Code)
                        } .padding(0.1)
                        
                        HStack{
                            Text("curCode =")
                                .font(.system(size: 17, weight: .heavy))
                            Text(country.currencyCode)
                        } .padding(0.1)
                        
                        HStack{
                            Text("curSym =")
                                .font(.system(size: 17, weight: .heavy))
                            Text(country.currencySymbol)
                        } .padding(0.1)
                        
                        HStack{
                            Text("lat =")
                                .font(.system(size: 17, weight: .heavy))
                            Text(country.latitude)
                        } .padding(0.1)
                        
                        HStack{
                            Text("long =")
                                .font(.system(size: 17, weight: .heavy))
                            Text(country.longitude)
                        } .padding(0.1)
                        
                        HStack{
                            Text("nName =")
                                .font(.system(size: 17, weight: .heavy))
                            Text(country.nativeName)
                        } .padding(0.1)
                        
                        HStack{
                            Text("nLang =")
                                .font(.system(size: 17, weight: .heavy))
                            Text(country.nativeLanguage)
                        } .padding(0.1)
                        
                        HStack{
                            Text("reg =")
                                .font(.system(size: 17, weight: .heavy))
                            Text(country.region.rawValue)
                        } .padding(0.1)
                        
                        HStack{
                            Text("subReg =")
                                .font(.system(size: 17, weight: .heavy))
                            Text(country.subRegion)
                        } .padding(0.1)
                    }
                }
                .frame(alignment: .leading)
                .alignmentGuide(.leading, computeValue: { dimension in
                    dimension[.leading]
                })
                .padding(EdgeInsets(top: -10, leading: -40, bottom: 0, trailing: 0))
                .redacted(when: isLoading)
                
            }; if isLoading {
                ZStack {
                    Color(.white)
                        .opacity(0.3)
                        .ignoresSafeArea()
                    ProgressView("fetch")
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 3 ) {
            isLoading = false
        }
    }
}

extension View {
    @ViewBuilder
    func redacted(when condition: Bool) -> some View {
        if !condition {
            unredacted()
        } else {
            redacted(reason: .placeholder)
        }
    }
}

struct tabview_Previews: PreviewProvider {
    static var previews: some View {
        tabview()
    }
}
