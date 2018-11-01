//
//  ProductsCollectionViewController
//  Holi
//
//  Created by Кирилл on 11.01.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import UIKit
import Nuke

class PhotosViewController: BaseViewController, PhotosView {
    var onFinish: (() -> Void)?
    var onPhotoSelected: ((PhotoProtocol) -> Void)?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 400
        tableView.tableFooterView = UIView()
        tableView.prefetchDataSource = self
        tableView.registerCell(type: PhotoTableViewCell.self)
        return tableView
    }()
    
    lazy var categorySegmentControl: UHSegmentControl = {
        let segmentControl = UHSegmentControl()
        segmentControl.items = [OrderBy.oldest.string.uppercased(), OrderBy.latest.string.uppercased(), OrderBy.popular.string.uppercased()]
        segmentControl.borderColor = .clear
        segmentControl.selectedIndex = viewModel.selectOrderByIndex
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.backgroundColor = .black
        return segmentControl
    }()
    
    var topRoundedView: UIView?
    
    var viewModel: PhotosViewModelProtocol!
    let preheater = ImagePreheater()
    let interactor = Interactor()
    
    var isNearTheBottomEdge: Bool = false {
        didSet {
            guard oldValue != isNearTheBottomEdge, isNearTheBottomEdge else { return }
            viewModel.loadMorePhotos()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupViews()
        setupCategorySegmentControl()
        setupNavigation()
        //setupLoadView()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //hidesBottomBarWhenPushed = true
        
    }
    
    override func bindViewModel() {
        viewModel.didUpdate = {[weak self] in
            //self?.tableView.dg_stopLoading()
            self?.tableView.reloadData()
        }
        
        viewModel.handleError = { error in
            HUDService.showError(withStatus: error.localizedDescription)
        }
    }
    
    private func setupCategorySegmentControl() {
        categorySegmentControl.valueChanged = {[weak self] selectedIndex in
            self?.tableView.setContentOffset(.zero, animated: false)
            self?.viewModel.setSelectedOrderBy(selectedIndex)
            self?.viewModel.reloadPhotos()
        }
    }
    
    private func setupNavigation() {
        navigationItem.title = viewModel.navigationTitle
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 26), NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
//    private func setupLoadView() {
//        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
//        loadingView.tintColor = UIColor.white
//        tableView.dg_addPullToRefreshWithActionHandler({ [weak self] in
//            self?.viewModel.reloadPhotos()
//        }, loadingView: loadingView)
//        tableView.dg_setPullToRefreshFillColor(UIColor.black)
//        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
//    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        let topRoundedView = UIView()
        topRoundedView.translatesAutoresizingMaskIntoConstraints = false
        topRoundedView.backgroundColor = .black
        self.topRoundedView = topRoundedView
        
        view.addSubview(topRoundedView)
        topRoundedView.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        topRoundedView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topRoundedView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topRoundedView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        topRoundedView.addSubview(categorySegmentControl)
        categorySegmentControl.topAnchor.constraint(equalTo: topRoundedView.topAnchor).isActive = true
        categorySegmentControl.leftAnchor.constraint(equalTo: topRoundedView.leftAnchor).isActive = true
        categorySegmentControl.rightAnchor.constraint(equalTo: topRoundedView.rightAnchor).isActive = true
        categorySegmentControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: topRoundedView.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topRoundedView?.roundedView(byRoundingCorners: [.bottomLeft, .bottomRight], radius: viewModel.topRoundedViewRadius)
    }
    
    
    
//    deinit {
//        tableView.dg_removePullToRefresh()
//    }
}

extension PhotosViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y / 3
        if offset >= viewModel.topRoundedViewRadius {
            topRoundedView?.roundedView(byRoundingCorners: [.bottomLeft, .bottomRight], radius: 0)
            topRoundedView?.layoutIfNeeded()
        } else {
            if offset <= 0 {
                topRoundedView?.roundedView(byRoundingCorners: [.bottomLeft, .bottomRight], radius: viewModel.topRoundedViewRadius)
                topRoundedView?.layoutIfNeeded()
            } else {
                topRoundedView?.roundedView(byRoundingCorners: [.bottomLeft, .bottomRight], radius: viewModel.topRoundedViewRadius - offset)
                topRoundedView?.layoutIfNeeded()
            }
        }
        
        isNearTheBottomEdge = scrollView.isNearTheBottomEdge()
    }
}

extension PhotosViewController: SelectableTableViewCell {
    func tableViewCell(didSelectAt indexPaht: IndexPath) {
        let photoCellModel = viewModel.item(at: indexPaht.row)
        onPhotoSelected?(photoCellModel.photoStream)
    }
}

extension PhotosViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let photoCellModel = viewModel.item(at: indexPath.row)
        let cell: PhotoTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.delegate = self
        cell.photoCellModel = photoCellModel
        return cell
    }
}

extension PhotosViewController : UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let requests = imageRequests(indexPaths: indexPaths)
        preheater.startPreheating(with: requests)
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        
        let requests = imageRequests(indexPaths: indexPaths)
        preheater.stopPreheating(with: requests)
    }
    
    func imageRequests(indexPaths: [IndexPath]) -> [ImageRequest] {
        let photoCellModels: [PhotoCellModelOutput] = indexPaths.compactMap { indexPath in
            guard indexPath.row < self.viewModel.itemsCount else { return nil }
            return self.viewModel.item(at: indexPath.row)
        }
        let imageUrls = photoCellModels.compactMap {$0.regularPhoto}
        let requests = imageUrls.map(ImageRequest.init)
        return requests
    }
}


