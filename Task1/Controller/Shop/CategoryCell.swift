//
//  CategoryCell.swift
//  Task1
//
//  Created by PRABALJIT WALIA     on 25/06/20.
//  Copyright © 2020 PRABALJIT WALIA    . All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    
    func updateViews(category: Category) {
           categoryImage.image = UIImage(named: category.imageName)
           categoryTitle.text = category.title
       }

}
