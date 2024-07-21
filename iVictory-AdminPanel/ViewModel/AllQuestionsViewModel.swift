import Foundation

class AllQuestionsViewModel: ObservableObject {
    @Published var allQuestions: [Question] = []
    @Published var searchText = ""
    var searchedQuestions: [Question] {
        guard !searchText.isEmpty else { return allQuestions }
        return allQuestions.filter { $0.text.lowercased().contains(searchText.lowercased())  }
    }
    
    init() {
        getData()
    }
    
    func getData() {
        Task {
            let questions = try await FirestoreService.shared.getAllQuestions()
            DispatchQueue.main.async {
                self.allQuestions = questions
            }
        }
    }
}

