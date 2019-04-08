//
//  HomePageViewController.swift
//  Mirror Lender
//
//  Created by Waheguru on 06/08/18.
//  Copyright © 2018 Pollysys. All rights reserved.
//


import Foundation
import UIKit

class HomePageViewController: UIPageViewController
{
    
    weak var homePageDelegate: HomePageViewControllerDelegate?
    
    private(set) lazy var orderedViewControllers: [UIViewController] =
    {
        // The view controllers will be shown in this order
        return [self.nextCountViewController(count: "one"),
                self.nextCountViewController(count: "two"),
                self.nextCountViewController(count: "three"),
                self.nextCountViewController(count: "four")]
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        isPagingEnabled = false
        
        if let initialViewController = orderedViewControllers.first {
            scrollToViewController(viewController: initialViewController)
        }
        
        homePageDelegate?.homePageViewController(homePageViewController: self, didUpdatePageCount: orderedViewControllers.count)
        
        NotificationCenter.default.addObserver(self, selector: #selector(scrollToNextViewController(notification:)), name: Notification.Name("changePage"), object: nil)
    }
    
    
    
    /**
     Scrolls to the next view controller.
     */
    @objc func scrollToNextViewController(notification: Notification)
    {
        print(notification.object!)
        if notification.object! as! String == "1"
        {
            if let visibleViewController = viewControllers?.first,
                let nextViewController = pageViewController(self, viewControllerAfter: visibleViewController)
            {
                scrollToViewController(viewController: nextViewController)
            }
        }
        else if notification.object! as! String == "2"
        {
            if let visibleViewController = viewControllers?.first,
                let nextViewController = pageViewController(self, viewControllerBefore: visibleViewController)
            {
                scrollToViewControllerReverse(viewController: nextViewController)
            }
        }
    }
    
    /**
     Scrolls to the view controller at the given index. Automatically calculates
     the direction.
     
     - parameter newIndex: the new index to scroll to
     */
    func scrollToViewController(index newIndex: Int)
    {
        print(viewControllers?.first)
        if let firstViewController = viewControllers?.first,
            let currentIndex = orderedViewControllers.index(of: firstViewController) {
            let _: UIPageViewControllerNavigationDirection = newIndex >= currentIndex ? .forward : .reverse
            _ = orderedViewControllers[newIndex]
        }
    }
    
    private func nextCountViewController(count: String) -> UIViewController
    {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(count)ViewController")
    }
    
    /**
     Scrolls to the given 'viewController' page.
     
     - parameter viewController: the view controller to show.
     */
    private func scrollToViewController(viewController: UIViewController,
                                        direction: UIPageViewControllerNavigationDirection = .forward)
    {
        setViewControllers([viewController],
                           direction: direction,
                           animated: true,
                           completion: { (finished) -> Void in
                            // Setting the view controller programmatically does not fire
                            // any delegate methods, so we have to manually notify the
                            // 'tutorialDelegate' of the new index.
                            self.notifyTutorialDelegateOfNewIndex()
        })
    }
    
    private func scrollToViewControllerReverse(viewController: UIViewController,
                                               direction: UIPageViewControllerNavigationDirection = .reverse)
    {
        setViewControllers([viewController],
                           direction: direction,
                           animated: true,
                           completion: { (finished) -> Void in
                            // Setting the view controller programmatically does not fire
                            // any delegate methods, so we have to manually notify the
                            // 'tutorialDelegate' of the new index.
                            self.notifyTutorialDelegateOfNewIndex()
        })
    }
    
    /**
     Notifies '_tutorialDelegate' that the current page index was updated.
     */
    @objc func notifyTutorialDelegateOfNewIndex()
    {
        print(viewControllers?.first)
        if let firstViewController = viewControllers?.first,
            
            let index = orderedViewControllers.index(of: firstViewController)
        {
            homePageDelegate?.homePageViewController(homePageViewController: self, didUpdatePageIndex: index)
        }
    }
}

// MARK: UIPageViewControllerDataSource
extension HomePageViewController: UIPageViewControllerDataSource
{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else
        {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        
        if previousIndex == -1
        {
            return nil
        }
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else
        {
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else
        {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else
        {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        if nextIndex == 5
        {
            return nil
        }
        
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
}

extension HomePageViewController: UIPageViewControllerDelegate
{
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        notifyTutorialDelegateOfNewIndex()
    }
}

protocol HomePageViewControllerDelegate: class
{
    /**
     Called when the number of pages is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter count: the total number of pages.
     */
    func homePageViewController(homePageViewController: HomePageViewController, didUpdatePageCount count: Int)
    
    /**
     Called when the current index is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func homePageViewController(homePageViewController: HomePageViewController, didUpdatePageIndex index: Int)
}

extension UIPageViewController {
    var isPagingEnabled: Bool {
        get {
            var isEnabled: Bool = true
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    isEnabled = subView.isScrollEnabled
                }
            }
            return isEnabled
        }
        set {
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    subView.isScrollEnabled = newValue
                }
            }
        }
    }
}

