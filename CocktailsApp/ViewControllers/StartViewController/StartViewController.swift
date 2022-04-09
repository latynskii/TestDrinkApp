//
//  ViewController.swift
//  CocktailsApp
//
//  Created by EDUARD Latynsky on 30.03.2022.
//

import UIKit
import SnapKit
class StartViewController: UIViewController {
        
    //MARK: Private Properties
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.startAnimating()
        activityIndicator.tintColor = .red
        return activityIndicator
    }()
    
    private let roundedTextField = CustomTextField("Cocktail name", 10)
    private let longTextField = CustomTextField("Cocktail name", 0)
            
    private var startViewModel: StartViewModel? {
        didSet {
            startViewModel?.fetchCocktails(self) {
                self.collectionView?.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    private var collectionView: UICollectionView?
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        longTextField.addTarget(self, action: #selector(checkSearchResult), for: .allEvents)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        startViewModel = StartViewModel()
        makeCollectionView()
        
        setupConstrains()
        setupUI()
        roundedTextField.delegate = self
        longTextField.delegate = self
    }
    
    //MARK: - Methods
    @objc private func checkSearchResult() {
        startViewModel?.searchCocktail(longTextField.text, completion: {
            self.collectionView?.reloadData()
        })
    }
    
    @objc private func keyboardWillShow (notification: NSNotification) {
        longTextField.becomeFirstResponder()
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        self.addLongTextField(keyboardSize.height)
        self.roundedTextField.isHidden = true
    }
    
    @objc private func keyboardWillHide() {
        self.longTextField.isHidden = true
        self.roundedTextField.isHidden = false
        self.roundedTextField.text = self.longTextField.text ?? ""
    }
    
    //MARK: - Create CollectionView
    private func makeCollectionView() {
        let layout = TagFlowLayout()
        layout.estimatedItemSize = CGSize(width: 240, height: 40)
        layout.minimumLineSpacing = 8
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        guard let collectionView = collectionView else { return }
        
        collectionView.frame = view.bounds
        collectionView.register(CloudCell.self, forCellWithReuseIdentifier: CloudCell.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    //MARK: Constrains
    private func addLongTextField(_ keyboardHeight: CGFloat) {
        longTextField.isHidden = false

        let constraintValue = (view.frame.height - keyboardHeight) - (view.frame.height * 0.04)
        
        NSLayoutConstraint.activate([
            longTextField.topAnchor.constraint(equalTo: view.topAnchor,
                                               constant: constraintValue),
            longTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            longTextField.widthAnchor.constraint(equalToConstant: view.frame.width),
            longTextField.heightAnchor.constraint(equalToConstant: view.frame.height * 0.04)
        ])
    }
    
    private func setupConstrains() {
        guard let collectionView = collectionView else { return }

        view.addSubview(collectionView)
        collectionView.addSubview(activityIndicator)
        view.addSubview(roundedTextField)
        view.addSubview(longTextField)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        roundedTextField.translatesAutoresizingMaskIntoConstraints = false
        longTextField.translatesAutoresizingMaskIntoConstraints = false
        longTextField.isHidden = true
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(100)
            make.leading.equalTo(view).offset(10)
            make.trailing.equalTo(view).offset(-10)
            make.height.equalTo(view.frame.height * 0.3)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.centerY.equalTo(collectionView)
            make.centerX.equalTo(collectionView)
        }
        
        roundedTextField.snp.makeConstraints { make in
            make.top.equalTo(view.snp_topMargin).offset(view.frame.height * 0.75)
            make.centerX.equalTo(view)
            make.width.equalTo(view.frame.width * 0.9)
            make.height.equalTo(view.frame.height * 0.04)
        }
    }
    //MARK: - SetupUI
    private func setupUI(){
        longTextField.tintColor = .black
        roundedTextField.tintColor = .black
        view.backgroundColor = .white
    }
}

    //MARK: - CollectionViewDelegate, CollectionViewDataSource
extension StartViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        startViewModel?.numberOfRows() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CloudCell.identifier, for: indexPath) as? CloudCell else { return UICollectionViewCell() }
        guard let startViewModel = startViewModel else { return UICollectionViewCell() }
        cell.viewModel = startViewModel.cells[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let currentCell = startViewModel?.cells[indexPath.row] else { return }
        currentCell.cellSelect()
    }
}
      //MARK: - UITextFieldDelegate
extension StartViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print(#function)
        view.endEditing(true)
    }
}
