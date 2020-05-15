//
//  SWEntitiesCollectionViewController.swift
//  RogueOne
//
//

import UIKit

class SWEntitiesCollectionViewController: UICollectionViewController {
  var categoryType: SWEntityType? {
    didSet {
      guard let categoryType = categoryType else {
        return
      }
      title = categoryType.description
    }
  }
  private var dataSource: SWEntitiesCollectionViewDataSource?
  private var activityIndicatorView: UIActivityIndicatorView?
  private var entityDetailsViewController: SWDetailsViewController?
  private var searchController: UISearchController?
  private var cacheManager: CacheManager
  private var filteredEntities: [SWEntity] = []
  private var searchActive : Bool = false

  init(cacheManager: CacheManager) {
    self.cacheManager = cacheManager
    super.init(nibName: "SWEntitiesCollectionViewController", bundle: nil)
  }

  required init?(coder: NSCoder) {
    self.cacheManager = CacheManager()
    super.init(coder: coder)
  }


  override func viewDidLoad() {
    super.viewDidLoad()
    configureActivityIndicatorView()
    configureDataSource()
    configureSearchController()
    configureCollectionView()

  }

  private func configureCollectionView() {
    collectionView.delegate = dataSource
    collectionView.dataSource = dataSource
    collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    collectionView.backgroundColor = .lightGray
    collectionView.backgroundView = activityIndicatorView

    let cellNib = UINib(nibName: SWEntityCollectionViewCell.reuseIdentifier,
                        bundle: nil)
    collectionView.register(cellNib,
                            forCellWithReuseIdentifier: SWEntityCollectionViewCell.reuseIdentifier)
    dataSource?.getEntities { [weak self] (finished) in
      if finished {
        guard let strongSelf = self else { return }
        strongSelf.collectionView.reloadData()
        strongSelf.activityIndicatorView!.stopAnimating()
      }
    }
  }

  private func configureActivityIndicatorView() {
    activityIndicatorView = UIActivityIndicatorView(style: .large)
    activityIndicatorView!.translatesAutoresizingMaskIntoConstraints = true
    activityIndicatorView!.color = #colorLiteral(red: 0.1058823529, green: 0.1411764706, blue: 0.1960784314, alpha: 0.9)
    activityIndicatorView!.startAnimating()
  }

  private func configureDataSource() {
    dataSource = EntitiesDataSourceFactory.getEntitiesDataSource(for: categoryType!,
                                                                 delegate: self,
                                                                 cacheManager: cacheManager)
  }

  private func configureSearchController() {
    searchController = UISearchController(searchResultsController: nil)
    searchController?.hidesNavigationBarDuringPresentation = false
    searchController?.searchResultsUpdater = dataSource
    searchController?.searchBar.placeholder = "Search"
    searchController?.searchBar.delegate = self
    searchController?.searchBar.tintColor = #colorLiteral(red: 0.1058823529, green: 0.1411764706, blue: 0.1960784314, alpha: 0.9)
    searchController?.searchBar.sizeToFit()
    searchController?.searchBar.becomeFirstResponder()

    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
  }
}

extension SWEntitiesCollectionViewController: SWEntitiesCollectionViewDataSourceDelegate {
  func presentSelectedEntityViewController(type: SWEntityType,
                                           entity: SWEntity,
                                           cacheManager: CacheManager) {
    switch type {
    case .people:
      guard let people = entity as? People else { return }
      let viewModel = PeopleViewModel(people, cacheManager)
      entityDetailsViewController = SWDetailsViewController(viewModel: viewModel)
      present(entityDetailsViewController!, animated: true)
    default:
      break
    }
  }

  func searchComplete() {
    collectionView.reloadData()
  }
}

extension SWEntitiesCollectionViewController: UISearchBarDelegate {
  //MARK: Search Bar
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    dataSource?.searchActive = false
    collectionView.reloadData()
    self.dismiss(animated: true, completion: nil)
  }

  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    dataSource?.searchActive = true
    guard let searchString = searchBar.text, !searchString.isEmpty else {
      return
    }
    collectionView.reloadData()
  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    dataSource?.searchActive = false
    collectionView.reloadData()
  }
}
