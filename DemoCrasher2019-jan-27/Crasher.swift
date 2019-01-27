//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

public typealias CellForRowBlock = (UITableView, IndexPath, NSObject) -> UITableViewCell
public typealias CanEditRowBlock = (IndexPath) -> Bool

extension NSObject: IdentifiableType {
    public var identity: NSObject {
        return self
    }
    
    public typealias Identity = NSObject
}

typealias SectionModelImpl = AnimatableSectionModel<NSObject, NSObject>

public class RxTableViewSectionedReloadDataSourceObjC: NSObject {
    public var tableView: UITableView?
    public var cellForRow: CellForRowBlock?
    public var canEditRow: CanEditRowBlock?
    
    func rebindDataSource() {
        guard let tableView = tableView else { return }
        guard let cellforRow = cellForRow else { return }
        let canEditRowBlock: ((TableViewSectionedDataSource<SectionModelImpl>, IndexPath) -> Bool)
        canEditRowBlock = { _, _ in false }
        
        let observableSignal = Observable.just([SectionModelImpl]())
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<SectionModelImpl>(configureCell: { cellforRow($1, $2, $3) })
        
        dataSource.canEditRowAtIndexPath = canEditRowBlock
        
        _ = observableSignal.bind(to: tableView.rx.items(dataSource: dataSource))
    }
    
}
