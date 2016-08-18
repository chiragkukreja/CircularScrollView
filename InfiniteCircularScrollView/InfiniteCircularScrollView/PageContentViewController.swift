//
//  PageContentViewController.swift
//  InfiniteCircularScrollView
//
//  Created by Chirag Kukreja on 8/9/16.
//  Copyright © 2016 abc. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var itemIndex : Int?
    var imageName : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(named: imageName!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
