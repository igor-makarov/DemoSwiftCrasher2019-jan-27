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

@objc(RxTableViewSectionedDataSource)
public final class RxTableViewSectionedReloadDataSourceObjC: NSObject {
    @objc
    public final var tableView: UITableView? {
        didSet {
            rebindDataSource()
        }
    }
    
    @objc
    public final var cellForRow: CellForRowBlock? {
        didSet {
            rebindDataSource()
        }
    }
    
    @objc
    public final var canEditRow: CanEditRowBlock? {
        didSet {
            rebindDataSource()
        }
    }
    
    weak var dataSource: TableViewSectionedDataSource<SectionModelImpl>?
    
    
    func rebindDataSource() {
        let disposeBag = DisposeBag()
        guard let tableView = tableView else { return }
        guard let cellforRow = cellForRow else { return }
        let canEditRowBlock: ((TableViewSectionedDataSource<SectionModelImpl>, IndexPath) -> Bool)
        canEditRowBlock = { _, _ in false }
        
        let observableSignal = Observable.just([SectionModelImpl]())
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<SectionModelImpl>(configureCell: { cellforRow($1, $2, $3) })
        self.dataSource = dataSource
        
        dataSource.canEditRowAtIndexPath = canEditRowBlock
        
        observableSignal
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
}
