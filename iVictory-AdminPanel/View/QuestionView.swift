

import SwiftUI

struct QuestionView: View {
    @StateObject var viewModel: QuestionViewModel
    
    var body: some View {
        Text(viewModel.question.text)
    }
}

#Preview {
    QuestionView(viewModel: .init(question: Question.questions[0]))
}

