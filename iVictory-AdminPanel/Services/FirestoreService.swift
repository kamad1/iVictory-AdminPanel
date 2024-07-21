
import FirebaseFirestore

final class FirestoreService {
    static let shared = FirestoreService(); private init() { }
    private let db = Firestore.firestore()
    private var players: CollectionReference { db.collection("players") }
    private var questions: CollectionReference { db.collection("questions") }
    
    //MARK: - Player CRUD
    func createPlayer(id: String, email: String, name: String = "") async throws {
        let player = Player(id: id, nickname: name, email: email)
        try await players.document(id).setData(player.representation)
    }
    
    func getPlayer(byId id: String) async throws -> Player {
        let snapshot = try await players.document(id).getDocument()
        guard let data = snapshot.data() else { throw FirestoreErrorCode(.dataLoss) }
        guard let player = Player(data: data) else { throw FirestoreErrorCode(.invalidArgument) }
        return player
    }
    
    func setPlayerName(id: String, name: String) {
        players.document(id).setData(["nickname": name], merge: true)
    }
    
    //MARK: - Game CRUD
    func createGame(_ game: Game, userId: String) async throws {
        try await players
            .document(userId)
            .collection("games")
            .document(game.id)
            .setData(game.representation)
    }
    
    func getGamesByPlayerID(_ id: String) async throws -> [Game] {
        let documents = try await players
            .document(id)
            .collection("games")
            .getDocuments()
            .documents
            
        let games = documents.compactMap { snap in
            return Game(data: snap.data())
        }
        
        return games
    }
    
    
    //MARK: - Question CRUD
    func createQuestion(_ question: Question) async throws {
        try await questions
            .document(question.id)
            .setData(question.representation)
    }
//    // данные метод использовался один раз только для первой загрузки вопросов в базу и более его не используем уже и приватим его-------- ТУТ ОН НЕ НУЖЕН!!!!!!!!
//    private func questionsParser() async throws {
//        for question in Question.questions {
//            try await createQuestion(question)
//        }
//    }
//    
    func getAllQuestions() async throws -> [Question] {
        let qSnap = try await questions.getDocuments()
        let docs = qSnap.documents
        return docs.compactMap { Question(data: $0.data())}
    }
}
