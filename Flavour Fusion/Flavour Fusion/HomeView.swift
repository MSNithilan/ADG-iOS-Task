
import SwiftUI
import GoogleSignIn

struct HomeView: View {
  @EnvironmentObject var viewModel: AuthenticationViewModel
  
  private let user = GIDSignIn.sharedInstance.currentUser
  
    var body: some View {
            NavigationView {
                ZStack{
                    LinearGradient(gradient: Gradient(colors: [.pink, .purple]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                    VStack {
                        HStack {
                            NetworkImage(url: user?.profile?.imageURL(withDimension: 200))
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100, alignment: .center)
                                .cornerRadius(8)
                            
                            VStack(alignment: .leading) {
                                Text(user?.profile?.name ?? "")
                                    .font(.headline)
                                
                                Text(user?.profile?.email ?? "")
                                    .font(.subheadline)
                            }
                            
                            Spacer()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(12)
                         
                        Spacer()
                        
                        Button(action: viewModel.signOut) {
                            Text("Sign out")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(.white))
                                .foregroundColor(.black)
                                .cornerRadius(12)
                                .padding()
                        }
                    }
                }
                .navigationTitle("Flavour Fusion")
                .foregroundColor(.white)
            }
            .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct NetworkImage: View {
  let url: URL?
  
  var body: some View {
    if let url = url,
       let data = try? Data(contentsOf: url),
       let uiImage = UIImage(data: data) {
      Image(uiImage: uiImage)
        .resizable()
        .aspectRatio(contentMode: .fit)
    } else {
      Image(systemName: "person.circle.fill")
        .resizable()
        .aspectRatio(contentMode: .fit)
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
