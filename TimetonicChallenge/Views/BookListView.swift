//
//  BookListView.swift
//  TimetonicChallengeTests
//
//  Created by Tatiana Carvajal on 28/06/24.
//

import SwiftUI

struct BookListView: View {
    @ObservedObject var viewModel: BookListViewModel
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .idle: EmptyView()
            case .loading: ProgressView()
            case .success(let response):
                List(response.allBooks.books) { book in
                    HStack {
                        Text(book.ownerPrefs.title)
                        Spacer()
                        AsyncImage(
                            url: book.ownerPrefs.url) { image in
                                image
                                    .resizable()
                                    .frame(width: 80, height: 80)
                            } placeholder: {
                                ProgressView()
                            }
                    }
                }
            case .error(let error):
                switch error {
                case .urlDoesNotExist, .noDataFound:
                    ContentUnavailableView(
                        label: {
                            Label("We couldn't fetch the book list", systemImage: "lock.slash.fill")
                        },
                        description: {
                            Text("Please try again later")
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
                            Label("We couldn't fetch the book list, code: \(errorResponse.errorCode)", systemImage: "lock.slash.fill")
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
        .task {
            await viewModel.fetchAllBooks()
        }
    }
}

#Preview {
    BookListView(viewModel: BookListViewModel(service: BookServiceFacade(), user: "demo"))
}
