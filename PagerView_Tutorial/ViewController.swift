//
//  ViewController.swift
//  PagerView_Tutorial
//
//  Created by Seokhyun Kim on 2020-11-09.
//

import UIKit
import FSPagerView

class ViewController: UIViewController, FSPagerViewDelegate, FSPagerViewDataSource {
    //When pagerView upload to memory.
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            //register cell in pagerView
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            //Item size
            self.pagerView.itemSize = FSPagerView.automaticSize
            //set infinite
            self.pagerView.isInfinite = true
            //set auto sliding interval
            self.pagerView.automaticSlidingInterval = 4.0
        }
    }
    
    @IBOutlet weak var pagerControll: FSPageControl! {
        didSet {
            pagerControll.numberOfPages = imageNames.count
            pagerControll.contentHorizontalAlignment = .right
            pagerControll.itemSpacing = 16
            pagerControll.interitemSpacing = 16
        }
    }
    
    @IBOutlet weak var leftButton: UIButton! {
        didSet {
            print("didSet")
            leftButton.layer.cornerRadius = leftButton.frame.height / 2
        }
    }
    @IBOutlet weak var rightButton: UIButton! {
        didSet {
            rightButton.layer.cornerRadius = rightButton.frame.height / 2
        }
    }
    @IBAction func leftButtonTapped(_ sender: UIButton) {
        pagerControll.currentPage = pagerControll.currentPage - 1
        pagerView.scrollToItem(at: pagerControll.currentPage, animated: true)
    }
    @IBAction func rightButtonTapped(_ sender: UIButton) {
        if (pagerControll.currentPage == imageNames.count - 1) {
            pagerControll.currentPage = 0
        } else {
            pagerControll.currentPage = pagerControll.currentPage + 1
        }
        pagerView.scrollToItem(at: pagerControll.currentPage, animated: true)
    }
    
    fileprivate let imageNames = ["1.png", "2.png", "3.png", "4.png"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pagerView.delegate = self
        pagerView.dataSource = self
    }
    
    //MARK: - FSPagerView Data source
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageNames.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFit
        //cell.textLabel?.text = ...
        return cell
    }
    
    //MARK: - FSPagerView Delegate
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        pagerControll.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        pagerControll.currentPage = pagerView.currentIndex
    }
    
    //Diable tapped image.
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        return false
    }
}

