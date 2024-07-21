
import SwiftUI

struct CreateQuestionView: View {
    @StateObject var viewModel = CreateQuestionViewModel()
    @Environment (\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 8) {
            TextField("Текст вопроса",
                      text: $viewModel.text)
                .modifier(RoundedTF())
            
            Picker("", selection: $viewModel.difficulty) {
                ForEach(Difficulty.allCases,
                        id: \.rawValue) {
                    Text($0.rawValue).tag($0)
                }
            }

            TextField("Правильный ответ",
                      text: $viewModel.correctAnswer)
                .modifier(RoundedTF())
            TextField("Неправильный ответ",
                      text: $viewModel.desctructors.first)
                .modifier(RoundedTF())
            TextField("Неправильный ответ",
                      text: $viewModel.desctructors.second)
            .modifier(RoundedTF())
            TextField("Неправильный ответ",
                      text: $viewModel.desctructors.third)
            .modifier(RoundedTF())
            
            Button("Сохранить") {
                viewModel.createQuestion()
                dismiss()
            }
        }
    }
}

#Preview {
    CreateQuestionView()
}

struct RoundedTF: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.white)
            }
            .shadow(radius: 1)
            .padding(.horizontal, 10)
    }
}

