//
//  LoginView.swift
//  TimetonicChallenge
//
//  Created by Tatiana Carvajal on 28/06/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel(service: AuthServiceFacade())
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
            await viewModel.login()
        }
    }
}

#Preview {
    LoginView()
}
