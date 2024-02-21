//
//  UserService.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 2/21/24.
//

import Firebase
import FirebaseFirestoreSwift

final class UserService: ObservableObject {
    static let shared = UserService()
    
    @Published var currentUser: User?
    
    private init() {
        Task { try await fetchCurrentUser() }
    }
    
    /// `fetchCurrentUser`
    /// When called, this function will attempt to gain the snapshot of the current Firebase user, setting the published UserService user with the result.
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return } // TODO: Throw?
        
        let snapshot = try await Firestore.firestore().collection(User.collectionName).document(uid).getDocument()
        let user = try snapshot.data(as: User.self)
        self.currentUser = user
    }
    
    /// `createUser`
    /// Will attempt to create a new user in the Firestore database. Initial onboarding set to false as that should come after user creation.
    /// Intended to be execured from the AuthService when that shared instance is asked to create an new authentication user.
    @MainActor
    func createUser(uid: String, withEmail email: String, fullname: String) async throws {
        do {
            // Initial creation - hasn't been directed to onboarding yet.
            let user = User(id: uid, email: email, fullname: fullname, hasOnboarded: false)
            let userData = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection(User.collectionName).document(uid).setData(userData)
            currentUser = user
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    /// `completeOnboarding`
    /// Given onoarding input parameters, these values will be merged to the database for the `currentUser`.
    /// Does not validate the correctness of the parameters. That is view model responsibility prior to calling this funciton.
    @MainActor
    func completeOnboarding(startDate date: Date, eligibleDays days: Set<Weekday>, weeklyRequirementTotal count: Int) async throws {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return } // TODO: Throw?
            
            let updatedProperties: [MutableUserProperty] = [.hasOnboarded(true),
                                                            .startDate(date),
//                                                            .eligibleDays(days), // TODO: BUG! How do I send this to Firestore?!
                                                            .weeklyRequirementTotal(count)]
            
            let updatedData = updatedProperties.reduce(into: [String: Any]()) { result, mutableUserProperty in
                let (k, v) = mutableUserProperty.kvUpdate
                result[k] = v
            }
            
            try await Firestore.firestore().collection(User.collectionName).document(uid).setData(updatedData, merge: true)
            try await fetchCurrentUser()
        } catch {
            print("DEBUG: Issue completing onboarding with error \(error.localizedDescription)")
        }
    }
    
    func updateCurrentUser() async throws {
        // TODO: Implement
    }
    
    /// `signOut`
    /// Will trigger a nil set on the publised currentUser
    func signOut() {
        currentUser = nil
    }
}
