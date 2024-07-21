
import Foundation

class CreateQuestionViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var correctAnswer = ""
    @Published var desctructors = (first: "", second: "", third: "")
    @Published var difficulty: Difficulty = .easy
    
    init() { }
 
    func createQuestion() {
        guard !text.isEmpty && !correctAnswer.isEmpty && !desctructors.first.isEmpty && !desctructors.second.isEmpty && !desctructors.third.isEmpty else { return }
        let question = Question(text: self.text,
                                correctAnswer: self.correctAnswer,
                                destructors: [desctructors.first, desctructors.second, desctructors.third],
                                difficulty: self.difficulty)
        Task {
            try await FirestoreService.shared.createQuestion(question)
        }
    }
}
