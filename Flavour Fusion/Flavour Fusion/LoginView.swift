
import SwiftUI

struct LoginView: View {

  @EnvironmentObject var viewModel: AuthenticationViewModel

    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.pink, .purple]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack{
                Text("Welcome to Flavour Fusion!")
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.white))
                    .font(.system(size: 39, weight: .bold))
                    .multilineTextAlignment(.center)
                    .padding(.top,90)
                Image(systemName: "fork.knife")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 87, height: 87)
                    .foregroundColor(.white)
                Text("A recipe has no soul. You as the cook must bring soul to the recipe.")
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                ZStack{
                    Color(.white)
                        .opacity(0.4)
                        .ignoresSafeArea()
                    Text("Don't have an account? Register now with Google!")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.all)
                        .multilineTextAlignment(.center)
                    GoogleSignInButton()
                        .padding(.all, 30)
                        .padding(.top,10)
                        .onTapGesture {
                            viewModel.signIn()
                        }
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}
