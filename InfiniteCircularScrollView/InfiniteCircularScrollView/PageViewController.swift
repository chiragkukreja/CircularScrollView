//
//  PageViewController.swift
//  InfiniteCircularScrollView
//
//  Created by Chirag Kukreja on 8/9/16.
//  Copyright © 2016 abc. All rights reserved.
//

import UIKit


class PageViewController: UIViewController , UIPageViewControllerDataSource{
    
    // MARK: - Variables
    private var pageViewController: UIPageViewController?
    
    private var CurrentIndex = 0
    // Initialize it right away here
    private let contentImages = ["image1",
                                 "image2",
                                 "image3",
                                 "image4"];
    
    //MARK: - View controller life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        createPageViewController()
        setupPageControl()
        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(moveLeft(_:)), userInfo: nil, repeats: true)
    }
    
    func moveLeft(sender: NSTimer) {
        CurrentIndex += 1
        if let vc = getItemController(CurrentIndex) {
          
             pageViewController!.setViewControllers([vc], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        } else {
          CurrentIndex = 0
          let vc = getItemController(CurrentIndex)!
            pageViewController!.setViewControllers([vc], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        }
        
    }
    
    //MARK: - Create and start page view controller
    private func createPageViewController() {
        let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        pageController.dataSource = self

        
        if contentImages.count > 0 {
            let firstController = getItemController(0)!
            let startingViewControllers: NSArray = [firstController]
            pageController.setViewControllers(startingViewControllers as? [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        }
        
        pageViewController = pageController
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.grayColor()
        appearance.currentPageIndicatorTintColor = UIColor.whiteColor()
        appearance.backgroundColor = UIColor.darkGrayColor()
    }
    
    // MARK: - UIPageViewControllerDataSource
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index: Int = (viewController as! PageContentViewController).itemIndex!
        
        if index == 0 || index == NSNotFound {
            index = contentImages.count
            CurrentIndex = index
        }
        
        index -= 1
        CurrentIndex -= 1

        return getItemController(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?{
        var index: Int = (viewController as! PageContentViewController).itemIndex!
        if index == NSNotFound {return nil}
        index += 1
        if index == contentImages.count {index = 0}
        CurrentIndex += 1

        return getItemController(index)
    }
    
    private func getItemController(itemIndex: Int) -> PageContentViewController? {
        if itemIndex < contentImages.count {
            let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("PageContentViewController") as! PageContentViewController
            pageItemController.itemIndex = itemIndex
            pageItemController.imageName = contentImages[itemIndex]
            return pageItemController
        }
        return nil
    }
    
    // MARK: - Page Indicator
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return contentImages.count
    }
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return CurrentIndex
    }
    
}
