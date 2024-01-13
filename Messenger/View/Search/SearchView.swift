//
//  SearchView.swift
//  Messenger
//
//  Created by Zerom on 2024/01/04.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.managedObjectContext) var objectContext
    @StateObject var viewModel: SearchViewModel
    
    var body: some View {
        VStack {
            topView
            
            if viewModel.searchResults.isEmpty {
                RecentSearchView()
            } else {
                List {
                    ForEach(viewModel.searchResults) { result in
                        HStack(spacing: 8) {
                            URLImageView(urlString: result.profileURL)
                                .frame(width: 26, height: 26)
                                .clipShape(Circle())
                            
                            Text(result.name)
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.bkText)
                        }
                    }
                    .listRowInsets(.init())
                    .listRowSeparator(.hidden)
                    .padding(.horizontal, 30)
                }
                .listStyle(.plain)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
    }
    
    var topView: some View {
        HStack(spacing: 0) {
            Button {
                viewModel.container.navigationRouter.pop()
            } label: {
                Image("back_search")
            }
            
            SearchBar(text: $viewModel.searchText,
                      shouldBecomeFirstResponder: $viewModel.shouldBecomeFirstResponder) {
                setSearchResultWithContext()
            }
            
            Button {
                viewModel.send(action: .clearSearchText)
            } label: {
                Image("close_search")
            }
        }
        .padding(.horizontal, 20)
    }
    
    func setSearchResultWithContext() {
        let result = SearchResult(context: objectContext)
        result.id = UUID().uuidString
        result.name = viewModel.searchText
        result.date = Date()
        
        try? objectContext.save()
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: .init(container: DIContainer(services: StubService()), userId: "user1_id"))
    }
}
