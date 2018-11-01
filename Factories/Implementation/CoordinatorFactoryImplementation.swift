import UIKit
import Foundation

final class CoordinatorFactoryImplementation: CoordinatorFactory {
  
    func makeTabbarCoordinator() -> (configurator: Coordinator & TabbarCoordinatorOutput, toPresent: Presentable?) {
        let controller = TabbarController()
        let coordinator = TabbarCoordinator(tabbarView: controller, coordinatorFactory: CoordinatorFactoryImplementation(), router: router(nil))
        return (coordinator, controller)
    }
    
    func makePhotosCoordinator() -> Coordinator {
        return makePhotosCoordinator(navController: nil)
    }
    
    func makePhotosCoordinator(navController: UINavigationController?) -> Coordinator {
        let coordinator = PhotosCoordinator(coordinatorFactory: CoordinatorFactoryImplementation(), factory: ModuleFactoryImplementation(), router: router(navController))
        return coordinator
    }
    
//    func makeAuthCoordinatorBox() -> (configurator: AuthCoordinatorOutput & Coordinator, toPresent: Presentable?) {
//        return makeAuthCoordinatorBox(navController: navigationController(nil))
//    }
//
//    func makeAuthCoordinatorBox(navController: UINavigationController?) -> (configurator: AuthCoordinatorOutput & Coordinator, toPresent: Presentable?) {
//        let router = self.router(navController)
//        //let controller = LoginController()
//        let coordinator = AuthCoordinator(router: router, factory: ModuleFactoryImplementation())
//        return (coordinator, router)
//    }
//
//    func makeUserProfileCoordinator(navController: UINavigationController?) -> Coordinator & UserProfileCoordinatorOutput {
//        let coordinator = UserProfileCoordinator(factory: ModuleFactoryImplementation(), router: router(navController), coordinatorFactory: CoordinatorFactoryImplementation())
//        return coordinator
//    }

  
    private func router(_ navController: UINavigationController?) -> Router {
        return RouterImplementation(rootController: navigationController(navController))
    }
  
    private func navigationController(_ navController: UINavigationController?) -> UINavigationController {
        if let navController = navController { return navController }
        else { return CustomNavigationController.controllerFromStoryboard(.main) }
    }
}
