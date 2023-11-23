//
//  MovieDetailsViewController.swift
//  Systems-Orange Assignment
//
//  Created by Refaey on 02/11/2023.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headerView: PageHeaderView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var genersLbl: UILabel!
    @IBOutlet weak var castLbl: UILabel!
    @IBOutlet weak var photosCV: UICollectionView!
    @IBOutlet weak var photosCollectionHeight: NSLayoutConstraint!
    
    //MARK: - Properties
    var presenter: MovieDetailsPresenterProtocol!
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.fetchPhotos()
        setData()
    }

    //MARK: - Private Methods
    private func setupUI() {
        setupTable()
        setupHeader()
    }
    
    private func setupTable() {
        photosCV.delegate = self
        photosCV.dataSource = self
        photosCV.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")

        // apply pagination
        CustomPullForScroll.addInfiniteScroll(scrollview: scrollView) { [weak self] in
            guard let self = self else { return }
            self.presenter.fetchNextPage()
        }
    }
    
    private func setupHeader() {
        headerView.onBackPressed = { [weak self] in
            guard let self = self else {return}
            self.dismiss(animated: true)
        }
    }
    
    private func setData() {
        let movie = presenter.getMovieViewModel()
        titleLbl.text = movie.title
        yearLbl.text = movie.year
        genersLbl.text = movie.genres
        castLbl.text = movie.cast
    }
}


//MARK: - Protocol Methods
extension MovieDetailsViewController: MovieDetailsViewProtocol{
    func startLoading() {
        AppLoading.show()
    }
    
    func finishLoading() {
        AppLoading.hide()
        CustomPullForScroll.stopInfiniteScroll(scrollview: scrollView)
    }
    
    func success() {
        photosCV.reloadData()
        photosCV.fitHeightToContent(view: self.view, heightConstraint: photosCollectionHeight)
    }
    
    func showNetworkError(message: String?) {
        AppAlert.showError(message: message ?? "")
    }
    
}


//MARK: - Table View Methods
extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell {
            cell.configure(path: presenter.getPhotoPath(index: indexPath.row))
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let height = collectionView.frame.width/2 - 10
        return CGSize(width: height, height: 180)
    }
        
}

