
import Foundation
import UIKit

protocol CellConfigurable {

    associatedtype ItemType

    func configure(item: ItemType)

    func resetAllContent()
}

protocol CellFactory {

    associatedtype CellType: CellConfigurable
    associatedtype ViewType

    func cell(for item: CellType.ItemType, in view: ViewType, at indexPath: IndexPath) -> CellType

    func configure(_ cell: CellType, with item: CellType.ItemType, at indexPath: IndexPath)
}

extension CellFactory {

    func configure(_ cell: CellType, with item: CellType.ItemType, at indexPath: IndexPath) {
        cell.configure(item: item)
    }
}

struct TableViewCellFactory<CellType>: CellFactory where CellType: CellConfigurable & UITableViewCell {

    typealias ViewType = UITableView

    func cell(for item: CellType.ItemType, in view: UITableView, at indexPath: IndexPath) -> CellType {
        let tableView = view
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CellType.self), for: indexPath) as! CellType
        cell.resetAllContent()
        cell.configure(item: item)
        return cell
    }
}


struct CollectionViewCellFactory<CellType>: CellFactory where CellType: CellConfigurable & UICollectionViewCell {

    typealias ViewType = UICollectionView

    func cell(for item: CellType.ItemType, in view: UICollectionView, at indexPath: IndexPath) -> CellType {
        let collectionView = view
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CellType.self), for: indexPath) as! CellType
        cell.resetAllContent()
        cell.configure(item: item)
        return cell
    }
}
