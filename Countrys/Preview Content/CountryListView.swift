
import Alamofire
import SwiftUI
import SystemConfiguration
import Firebase
import GoogleSignIn

struct CountryListView: View {
    
    @State private var showList : Bool = false
    let connectivty = SCNetworkReachabilityCreateWithName(nil, "www.apple.com")
    @StateObject var internetConnection = InternetConnection()
    @State private var isLoading = false
    @State var countries: [Response] = []
    
    var body: some View {
        
        VStack {
            if self.showList {
                emptylist()
                
            } else {
                tabview() }
            
        } .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                var flgs = SCNetworkReachabilityFlags()
                SCNetworkReachabilityGetFlags(self.connectivty!, &flgs)
                
                if self.internetConnection.NetworkReachable(to: flgs) {
                    self.showList = false}
                else {
                    self.showList = true
                }
            }
        }
    }
}

struct objectsListView : View {
    @State private var isLoading = false
    @State var countries: [Response] = []
    @State var searchText: String = ""
    
    var body: some View {
        
        ZStack{
            
            NavigationView{
                List {
                    SearchBar(text: $searchText, placeholder: "Search Country")

                    ForEach(getSearchByCountry(), id: \.self) { country in
                        NavigationLink ( destination: DetailView(country: country) ){
                        Text(country.name)
                            .font (.headline)
                        }
                }
                }   .onAppear { self.feed() }
                .navigationBarTitle(Text("Countries"))
            }   .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            
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
    
    private func getSearchByCountry() -> [Response] {
           guard !searchText.isEmpty else { return countries }
           return countries.filter { $0.name.containsCaseInsensitive(searchText) }
       }
    
    func loading () {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            isLoading = false
        }
    }
    
    func feed() {
        isLoading = true
        AF.request ("https://countryapi.gear.host/v1/Country/getCountries", method: .get).responseJSON { (response) in switch response.result{
        case .success:
            do{
                let country = try JSONDecoder().decode(Country.self, from: response.data!)
                countries = country.response
                self.isLoading = false
                print(response)
            } catch (let err){
                self.isLoading = false
                print (err)
            }
            
        case let .failure(err):
            self.isLoading = false
            print(err)
        }
        }
    }
}

struct emptylist : View {
    
    let reachability = SCNetworkReachabilityCreateWithName(nil, "www.apple.com")
    @State private var showlists = false
    @State private var showalert = false
    @StateObject var internetConnection = InternetConnection()
    @State private var isLoading = false
    
    var body: some View {
        ZStack{
            Color.pink
                .opacity(0.15)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack{
                
                Image ("no_internet")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(EdgeInsets(top: -100, leading: 0, bottom: 0, trailing: 0))
                
                Text ("noInternet")
                    .foregroundColor(Color.gray)
                    .padding()
                Button(action: {
                    var flags = SCNetworkReachabilityFlags()
                    SCNetworkReachabilityGetFlags(self.reachability!, &flags)
                    
                    if internetConnection.NetworkReachable(to: flags){
                        self.showlists = true
                        self.isLoading = false
                    }
                    else {
                        self.showalert = true
                        self.isLoading = false
                    }
                    
                }) {Text("tryAgain")}
                .padding()
                .frame(minWidth: 50, maxWidth: 200)
                .background(Color.pink)
                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color.white)
                .cornerRadius(5.0)
            } .fullScreenCover(isPresented: $showlists) { tabview() }
            .alert(isPresented: $showalert) { Alert(title: Text("err"), message: Text("cyi"), dismissButton: .default(Text("OK")))
                    }
            
            if isLoading {
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
        
        }  .onAppear{ loading() }
    }
    
    func loading () {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoading = false
        }
    }
}

class InternetConnection : ObservableObject {
    func NetworkReachable(to flags: SCNetworkReachabilityFlags) -> Bool {
        let reachable = flags.contains(.reachable)
        let nConnection = flags.contains(.connectionRequired)
        let cConnectionAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let cConnectionWithInteraction = cConnectionAutomatically && !flags.contains(.interventionRequired)
        
        return reachable && (!nConnection || cConnectionWithInteraction)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
        }
    }
}
