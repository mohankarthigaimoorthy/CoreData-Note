//
//  mainViewController.swift
//  pepNote
//
//  Created by Mohan K on 13/03/23.
//

import UIKit

class mainViewController: UIViewController {

    var searchedNotes = [Note]()
    static var notes = [Note]()
    
    var searchController = UISearchController(searchResultsController: nil)
    
    var tableView: UITableView?
    let label = UILabel()
    let button = AddButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        
        definesPresentationContext = true
        setupNavigationController()
        setupTableView()
        setupButton()
        setupLabel()
        fetchNotesFromStorage()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        removeCellIfEmpty()
    }
    
    @objc private func didTapButton() {
        let newNote = CoreData.shared.createNote()
        mainViewController.notes.insert(newNote, at: 0)
        tableView!.beginUpdates()
        tableView!.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        tableView!.endUpdates()
        
        let noteVC = NoteViewController()
        noteVC.noteCell = nil
        noteVC.set(noteId: newNote.id!)
        noteVC.set(noteCell: (tableView?.cellForRow(at: IndexPath(row: 0, section: 0) ) as! NoteCell))
        
        navigationController?.pushViewController(noteVC, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    private func setupButton(){
        view.addSubview(button)
        button.setButtonConstraints(view: view)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    private func setupLabel() {
        view.addSubview(label)
        label.text = "No notes yet"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 30),
            label.widthAnchor.constraint(equalToConstant: 120),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupNavigationController () {
        title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.hidesBarsOnSwipe = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
}

extension mainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else{
            return
        }
        search(text: text)
    }
    
    func search(text: String) {
        searchNotesFromStorage(text)
    }
}
