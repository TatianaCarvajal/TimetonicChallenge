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
            TextField("", text: $viewModel.email, prompt: Text("Insert your Email").foregroundColor(.black.opacity(0.7)))
                .padding()
                .background(Color.black.opacity(0.2))
                .foregroundStyle(.black)
                .cornerRadius(12)
            
            TextField("", text: $viewModel.password, prompt: Text("Insert your password").foregroundColor(.black.opacity(0.7)))
                .padding()
                .background(Color.black.opacity(0.2))
                .foregroundStyle(.black)
                .cornerRadius(12)
            
            Button(action: {
                Task {
                    await viewModel.login()
                }
            }, label: {
                Text("Login")
                    .foregroundStyle(Color.white)
                    .padding()
                    .background(Color.blue.cornerRadius(12))
            })
            .padding()
        }
        .padding(.horizontal, 30)
    }
}

#Preview {
    LoginView()
}
