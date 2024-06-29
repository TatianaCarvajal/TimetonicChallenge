//
//  LoginView.swift
//  TimetonicChallenge
//
//  Created by Tatiana Carvajal on 28/06/24.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.state {
                case .idle: initialView
                case .loading: ProgressView()
                case .success:
                    initialView
                case .error(let error):
                    switch error {
                    case .urlDoesNotExist, .noDataFound:
                        ContentUnavailableView(
                            label: {
                                Label("Login failed try again later", systemImage: "lock.slash.fill")
                            },
                            description: {
                                Text("Please check your username or password")
                            },
                            actions: {
                                Button("Try again") {
                                    Task {
                                        viewModel.state = .idle
                                    }
                                }
                            }
                        )
                        .offset(y: -50)
                    case .serviceFailed(let errorResponse):
                        ContentUnavailableView(
                            label: {
                                Label("Login failed try again later, code: \(errorResponse.errorCode)", systemImage: "lock.slash.fill")
                            },
                            description: {
                                Text(errorResponse.errorMessage)
                            },
                            actions: {
                                Button("Try again") {
                                    Task {
                                        viewModel.state = .idle
                                    }
                                }
                            }
                        )
                        .offset(y: -50)
                    }
                }
            }
            .onChange(of: viewModel.state) { oldValue, newValue in
                if let sessionKey = viewModel.state.sessionKey {
                    viewModel.shouldGoToBookList = true
                }
            }
            .navigationDestination(isPresented: $viewModel.shouldGoToBookList) {
                if let user = viewModel.authUser {
                    BookListView(viewModel: BookListViewModel(service: BookServiceFacade(), user: user))
                }
            }
        }
    }
    
    var initialView: some View {
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
    LoginView(viewModel: LoginViewModel(service: AuthServiceFacade()))
}
