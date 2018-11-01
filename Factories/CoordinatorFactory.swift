import UIKit
import Foundation

protocol CoordinatorFactory {
  
    func makeTabbarCoordinator() -> (configurator: Coordinator & TabbarCoordinatorOutput, toPresent: Presentable?)
    
//    func makeAuthCoordinatorBox() -> (configurator: Coordinator & AuthCoordinatorOutput, toPresent: Presentable?)
//    func makeAuthCoordinatorBox(navController: UINavigationController?) -> (configurator: Coordinator & AuthCoordinatorOutput, toPresent: Presentable?)
    
    
    func makePhotosCoordinator(navController: UINavigationController?) -> Coordinator
    func makePhotosCoordinator() -> Coordinator
    
    //func makeUserProfileCoordinator(navController: UINavigationController?) -> Coordinator & UserProfileCoordinatorOutput
    
//  func makeAuthCoordinatorBox(router: Router) -> Coordinator & AuthCoordinatorOutput
//  
//  func makeOnboardingCoordinator(router: Router) -> Coordinator & OnboardingCoordinatorOutput
//  
//  func makeItemCoordinator(navController: UINavigationController?) -> Coordinator
//  func makeItemCoordinator() -> Coordinator
//  
//  func makeSettingsCoordinator() -> Coordinator
//  func makeSettingsCoordinator(navController: UINavigationController?) -> Coordinator
//  
//  func makeItemCreationCoordinatorBox() ->
//    (configurator: Coordinator & ItemCreateCoordinatorOutput,
//    toPresent: Presentable?)
//  
//  func makeItemCreationCoordinatorBox(navController: UINavigationController?) ->
//    (configurator: Coordinator & ItemCreateCoordinatorOutput,
//    toPresent: Presentable?)
}
