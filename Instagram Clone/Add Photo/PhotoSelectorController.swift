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
    var images = [UIImage]()
    var selectedImage:UIImage?
    var assets = [PHAsset]()
    var header: PhotoSelectorHeader?
    
    var moreImages = [UIImage]() // it is created to test auto scroll. delete it later.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        setupNavigationButtons()
        collectionView?.register(PhotoSelectorCell.self, forCellWithReuseIdentifier:cellId )
         collectionView?.register(PhotoSelectorHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        fetchPhotos()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: width)
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! PhotoSelectorHeader
        self.header = header
            header.imageView.image = selectedImage
        if let selectedImage = selectedImage
        {
            if let index = self.images.index(of: selectedImage)
            {
                let selectedAsset = self.assets[index]
                let imageManager = PHImageManager.default()
                let targetSize = CGSize(width: 600, height: 600)
                imageManager.requestImage(for: selectedAsset, targetSize: targetSize, contentMode: .default, options: nil, resultHandler: { (image, info) in
                    header.imageView.image = image
                })
            }
        }
        
        return header
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedImage  = moreImages[indexPath.item]
        self.collectionView?.reloadData()
        let indexPath = IndexPath(item: 0, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     return moreImages.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
            as! PhotoSelectorCell
        cell.photoImageView.image = moreImages[indexPath.item]
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
        let sharePhotoCon = SharePhotoController()
    sharePhotoCon.selectedImage = header?.imageView.image
          navigationController?.pushViewController(sharePhotoCon, animated: true)
    }
    
   fileprivate func fetchPhotos()
    {
       let allPhotos = PHAsset.fetchAssets(with: .image, options: assetsFetchOptions())
        DispatchQueue.global(qos: .background).async
        {
            allPhotos.enumerateObjects
                { (asset, count , stop ) in
                
                let imageManager = PHImageManager.default()
                let targetSize = CGSize(width: 200, height: 200)
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options, resultHandler: { (image, info) in
                    if let image = image
                    {
                        self.images.append(image)
                        // for creating more cells with images so that we can test auto scroll
                        self.displayMoreImages(img: image)
                        self.assets.append(asset)
                        if self.selectedImage == nil
                        {
                            self.selectedImage = image
                        }
                        
                    }
                    if count == allPhotos.count - 1
                    {
                        DispatchQueue.main.async {
                            self.collectionView?.reloadData()
                        }
                        
                    }
                 })
               }
          }
        
    }
    fileprivate func assetsFetchOptions() -> PHFetchOptions
    {
        let fetchOptions = PHFetchOptions()
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchOptions.sortDescriptors = [sortDescriptor]
        fetchOptions.fetchLimit = 30
        return fetchOptions
    }
    func displayMoreImages(img:UIImage)
    {
        for _ in 1...5
        {
            self.moreImages.append(img)
           
        }
    }
}
