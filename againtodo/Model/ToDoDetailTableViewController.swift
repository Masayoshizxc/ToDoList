import UIKit

class ToDoDetailTableViewController: UITableViewController {

    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    var toDoItem : String!
    var descripItem : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if toDoItem == nil{
            toDoItem = ""
        }
        nameField.text = toDoItem
        descriptionField.text = descripItem
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        toDoItem = nameField.text
        descripItem = descriptionField.text
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingAddMode = presentingViewController is UITabBarController
        if isPresentingAddMode{
            dismiss(animated: true, completion: nil)
        }else{
            navigationController?.popViewController(animated: true)
        }
    }
}
