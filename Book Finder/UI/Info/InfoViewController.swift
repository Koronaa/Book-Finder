//
//  InfoViewController.swift
//  Book Finder
//
//  Created by Sajith Konara on 2021-02-11.
//

import UIKit
import RxSwift

class InfoViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    fileprivate let bag = DisposeBag()
    var infoVM:InfoViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservables()
        
    }
    
    private func setupObservables(){
        infoVM.title.subscribe(onNext: { (titleString) in
            if let title = titleString{
                self.titleLabel.text = title
            }
        }).disposed(by: bag)
        
        infoVM.author.subscribe(onNext: { (authorString) in
            if let author = authorString{
                self.authorLabel.text = author
            }
        }).disposed(by: bag)
        
        infoVM.description.subscribe(onNext: { (desc) in
            if let description = desc{
                self.descriptionLabel.text = description
            }
        }).disposed(by: bag)
        
        infoVM.imageURL.subscribe(onNext: { (url) in
            if let imageURL = url{
                self.bookImageView.kf.setImage(with: imageURL)
            }
        }).disposed(by: bag)
        
        infoVM.error.subscribe(onNext: { (e) in
            if let error = e{
                print(error)
            }
        }).disposed(by: self.bag)
    }
    
    
    @IBAction func backButtonOnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
