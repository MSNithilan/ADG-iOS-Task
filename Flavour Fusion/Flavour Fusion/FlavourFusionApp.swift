
import SwiftUI
import Firebase
import GoogleSignIn

@main
struct FlavourFusionApp: App {
    @StateObject var viewModel = AuthenticationViewModel()
    
    init() {
        setupAuthentication()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

extension FlavourFusionApp {
    private func setupAuthentication() {
        FirebaseApp.configure()
    }
}
