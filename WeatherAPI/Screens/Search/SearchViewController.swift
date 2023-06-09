//
//  SearchViewController.swift
//  WeatherAPI
//
//  Created by Jatin Patel on 6/8/23.


import UIKit

protocol SearchProtocol: AnyObject {
    func searchPlaceDataWith(model: [SearchResponse])
}

final class SearchViewController: UIViewController, SearchProtocol {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var searchTableView: UITableView!
    
    // MARK: - Variables
    
    var presenter : SearchPresentationProtocol?
    private(set) var searchResult = [SearchResponse]() {
        didSet {
            DispatchQueueMain.async {
                self.searchTableView.reloadData()
            }
        }
    }
    var selectedLocation: ((SearchResponse) -> Void)?
    
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    // MARK: Setup
    
    private func setup() {

        let viewController = self
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        
        //View Controller will communicate with only presenter
        viewController.presenter = presenter
        
        //Presenter will communicate with Interector and Viewcontroller
        presenter.viewController = viewController
        presenter.interactor = interactor
        
        //Interactor will communucate with only presenter.
        interactor.presenter = presenter
    }
    
    
    // MARK: ViewController lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        searchTextField.delegate = self
    }
    
    
    // MARK: Protocol Implementation
    
    func searchPlaceDataWith(model: [SearchResponse]) {
        searchResult = model
    }
}

// MARK: - Tableview Delegate & DataSource

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        searchResult.count == 0 ? tableView.setEmptyMessage(NoResultFoundMessage) : tableView.restore()
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchLocationTableViewCell") as? SearchLocationTableViewCell {
            
            cell.configureData(item: searchResult[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = searchResult[indexPath.row]
        selectedLocation?(item)
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITextField Delegate

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        searchTextField.resignFirstResponder()
        if !(textField.text?.isEmpty ?? false) {
            presenter?.apiCallForSearchPlace(query: textField.text ?? "")
        }
        return false
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        navigationController?.popViewController(animated: true)
        return true
    }
}
