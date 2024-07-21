
import SwiftUI

struct AllQuestionsView: View {
    @StateObject var viewModel = AllQuestionsViewModel()
    @State private var isPresented = false
    
    var body: some View {
        List(viewModel.searchedQuestions) { question in
            NavigationLink(question.text) {
                QuestionView(viewModel: .init(question: question))
            }
        }
        .refreshable {
            viewModel.getData()
        }
        .toolbar {
            ToolbarItem {
                NavigationLink {
                    CreateQuestionView()
                } label: {
                    Image(systemName: "plus")
                }

            }
        }
        .searchable(text: $viewModel.searchText)
    }
}

#Preview {
    AllQuestionsView()
}

