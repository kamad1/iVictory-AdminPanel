
import Foundation

class QuestionViewModel: ObservableObject {
    @Published var question: Question
    
    init(question: Question) {
        self.question = question
    }
}
