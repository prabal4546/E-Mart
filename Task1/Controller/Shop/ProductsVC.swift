//
//  ProductsVC.swift
//  Task1
//
//  Created by PRABALJIT WALIA     on 24/06/20.
//  Copyright © 2020 PRABALJIT WALIA    . All rights reserved.
//

import UIKit

class ProductsVC: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
  
    

    @IBOutlet weak var productsCollection: UICollectionView!
    
    private (set) public var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        productsCollection.dataSource = self
        productsCollection.delegate = self
    
    }
    func initProducts(category: Category) {
           products = DataService.instance.getProducts(forCategoryTitle: category.title)
           navigationItem.title = category.title
       }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductViewCell", for: indexPath) as? ProductViewCell{
            let product = products[indexPath.row]
            cell.updateViews(product: product)
            return cell
        }
        return ProductViewCell()
      }
    

   

}
