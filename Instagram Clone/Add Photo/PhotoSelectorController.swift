//
//  PhotoSelectorController.swift
//  Instagram Clone
//
//  Created by Abdullah A Mamun on 1/14/18.
//  Copyright © 2018 Samuel Mamun. All rights reserved.
//

import UIKit
import Photos


class PhotoSelectorController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let cellId  = "cellId"
    let headerId = "HeaderId"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .yellow
        setupNavigationButtons()
        collectionView?.register(PhotoSelectorCell.self, forCellWithReuseIdentifier:cellId )
         collectionView?.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        fetchPhotos()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: width)
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderId", for: indexPath)
        header.backgroundColor = .red
        return header
    }
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     return images.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
            as! PhotoSelectorCell
        cell.photoImageView.image = images[indexPath.item]
        return cell
    }
    // in order to modify size of the cell conform to UICollectionViewDelegateFlowLayout protocol
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // the reason to subtrack 3 is becase we have 4 cells in each row and we have 3 pixel gap between this 4 cells n this three pixels r missing when we calcute the width thats why we need to subtract three from thr entire view to display a gap of 1 pixel between each cell.
        let width = (view.frame.width - 3)/4
        return CGSize(width: width, height: width)
    }
    // horizontal line spacing betwwen cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    //vertical line spacing between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    // add 1 pixel spacing at the top of the cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
    }
    override var prefersStatusBarHidden: Bool {return true}
    fileprivate func setupNavigationButtons()
    {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNext))
    }
   @objc func handleCancel()
    {
        dismiss(animated: true, completion: nil)
    }
   @objc func handleNext()  {
        print(images.count)
    }
    var images = [UIImage]()
   fileprivate func fetchPhotos()
    {
        
        let phfetchOptions = PHFetchOptions()
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        phfetchOptions.sortDescriptors = [sortDescriptor]
        
        phfetchOptions.fetchLimit = 10
       let allPhotos = PHAsset.fetchAssets(with: .image, options: phfetchOptions)
        allPhotos.enumerateObjects { (asset, count , stop ) in
            
            let imageManager = PHImageManager.default()
            let targetSize = CGSize(width: 350, height: 350)
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options, resultHandler: { (image, info) in
                if let image = image
                {
                    self.images.append(image)
                    
                }
                if count == allPhotos.count - 1
                {
                    self.collectionView?.reloadData()
                }
            })
        }
    }
}
