//
//  NewsTableViewController.swift
//  RxSwift_NewsApp
//
//  Created by max on 29.06.2022.
//

import UIKit
import RxSwift
import RxCocoa


class NewsTableViewController: UITableViewController {
    
    let disposeBag = DisposeBag()
    
    private var articlesListViewModel: NewsListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        populateNews()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesListViewModel == nil ? 0 : articlesListViewModel.newsVM.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else { fatalError() }
        
        let articleVM = articlesListViewModel.newsAt(indexPath.row)
        articleVM.title.asDriver(onErrorJustReturn: "")
            .drive(cell.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        articleVM.description.asDriver(onErrorJustReturn: "")
            .drive(cell.descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        return cell
    }
    
    private func populateNews() {
        
        URLRequest.load(resource: ArticleList.all)
            .subscribe(onNext: { newsResponse in
                
                let articles = newsResponse.articles
                self.articlesListViewModel = NewsListViewModel(articles)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }).disposed(by: disposeBag)
    }
}
