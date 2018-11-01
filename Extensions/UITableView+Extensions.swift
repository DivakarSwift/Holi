
import Foundation
import UIKit


extension UITableView {
	
	func dequeueReusableCell<T>(forIndexPath indexPath: IndexPath) -> T where T: UITableViewCell {
		guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
				fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
		}
		return cell
	}
	
    func registerClass<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerCell<T: UITableViewCell>(type: T.Type) {
        register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
    }

}

protocol NibIdentifiable {
    static var nibIdentifier: String { get }
}

extension NibIdentifiable {
    
    static var nib: UINib {
        return UINib(nibName: nibIdentifier, bundle: nil)
    }
    
}

extension UIView: NibIdentifiable {
    
    static var nibIdentifier: String {
        return String(describing: self)
    }
    
}

extension UIViewController: NibIdentifiable {
    
    static var nibIdentifier: String {
        return String(describing: self)
    }
    
}

extension NibIdentifiable where Self: UIView {
    
    static func instantiateFromNib() -> Self {
        guard let view = UINib(nibName: nibIdentifier, bundle: nil)
            .instantiate(withOwner: nil, options: nil).first as? Self
            else { fatalError("Couldn't find nib file for \(String(describing: Self.self))") }
        return view
    }
    
}

extension NibIdentifiable where Self: UIViewController {
    
    static func instantiateFromNib() -> Self {
        return Self(nibName: nibIdentifier, bundle: nil)
    }
    
}

extension NibIdentifiable where Self: UITableView {
    
    static func instantiateFromNib() -> Self {
        guard let tableView = UINib(nibName: nibIdentifier, bundle: nil)
            .instantiate(withOwner: nil, options: nil).first as? Self
            else { fatalError("Couldn't find nib file for \(String(describing: Self.self))") }
        return tableView
    }
    
}

extension NibIdentifiable where Self: UITableViewController {
    
    static func instantiateFromNib() -> Self {
        return Self(nibName: nibIdentifier, bundle: nil)
    }
    
}
