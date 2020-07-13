
import Foundation

final class AuthController {
  
  static let serviceName = "FriendvatarsService"
  
  static var isSignedIn: Bool {
    guard let currentUser = Settings.currentUser else {
      return false
    }
    
    do {
      let password = try KeychainPasswordItem(service: serviceName, account: currentUser.email).readPassword()
      return password.count > 0
    } catch {
      return false
    }
  }
  
  
  class func signIn(_ user: User, password: String) throws {
    try KeychainPasswordItem(service: serviceName, account: user.email).savePassword(password)
    
    Settings.currentUser = user
    NotificationCenter.default.post(name: .loginStatusChanged, object: nil)
    
  }
  
  class func signOut() throws {
    guard let currentUser = Settings.currentUser else {
      return
    }
    
    try KeychainPasswordItem(service: serviceName, account: currentUser.email).deleteItem()
    
    Settings.currentUser = nil
    NotificationCenter.default.post(name: .loginStatusChanged, object: nil)
  }
  
}

extension Notification.Name {
  
  static let loginStatusChanged = Notification.Name("com.razeware.auth.changed")
  
}
