//
//  SlidingViewController.swift
//  ServiceProvider
//
//  Created by Amar Patil on 15/04/21.
//

import UIKit

class SlidingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var imageArray = ["facilityone","facilityTwo","facilityThree"]
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.hidesForSinglePage = true
        
        if UserDefaults.standard.value(forKey: "ID") != nil
        {
            let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = story.instantiateViewController(identifier: "sw") as! SWRevealViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        

        // Do any additional setup after loading the view.
    }
    
    
    

    
    @IBAction func chnageImage(_ sender: UIPageControl) {
        self.collectionView.scrollToItem(at: IndexPath(row: sender.currentPage, section: 0), at: .centeredHorizontally, animated: true)
        pageControl.currentPage = pageControl.currentPage + 1
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x

        pageControl.currentPage = Int(x / view.frame.width )
        let last = imageArray.count - 1
   

    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = view.frame.width
        

        let page = floor((collectionView.contentOffset.x - pageWidth / 2) / pageWidth) + 1
        let xOffset: CGFloat = page * pageWidth
        collectionView.setContentOffset(CGPoint(x: xOffset, y: 0.0), animated: true)
        pageControl.currentPage = Int(page)
        collectionView.reloadData()
    }
    
    
  
}



//MARKS: Skip Button Pressed
extension SlidingViewController
{
    @IBAction func btnSkipPressed(_ sender:UIButton)
    {
        let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
     }
}


//MARKS: Next Button Pressed
extension SlidingViewController
{
    @IBAction func btnNextPressed(_ sender:UIButton)
    {
        if pageControl.currentPage == 2
        {
            let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = story.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else
        {
        collectionView.scrollToNextItem()
        }
        
    }
}



//MARKS: CollectionVIew DataSources
extension SlidingViewController:UICollectionViewDataSource
{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return imageArray.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SlidingCollectionViewCell
        cell.imgSlide.image = UIImage(named: imageArray[indexPath.section])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.section
    }
}


//MARKS: Collection FLow Layout delegate\
extension SlidingViewController:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
       {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
       }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = self.collectionView.frame.width
        let cellHeight = self.collectionView.frame.height
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    
}


extension UICollectionView {
    func scrollToNextItem() {
        let contentOffset = CGFloat(floor(self.contentOffset.x + self.bounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
    }
    func moveToFrame(contentOffset : CGFloat) {
            self.setContentOffset(CGPoint(x: contentOffset, y: self.contentOffset.y), animated: true)
        }
}
