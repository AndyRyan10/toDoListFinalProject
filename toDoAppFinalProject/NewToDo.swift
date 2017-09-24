//
//  NewToDo.swift
//  toDoAppFinalProject
//
//  Created by Andrew Ryan on 7/27/17.
//  Copyright © 2017 AndrewRyan. All rights reserved.
//

import UIKit

class NewToDo: UIViewController {
    
// MARK: - Identifier Constants
    
    var newTitle: String = ""
    var dueDate: Date? = nil
    var newPoms: Int? = nil
    
// MARK: - Interface Builder Outlets
    
    @IBOutlet weak var userTitle: UITextField!
    
    @IBOutlet weak var dueDateLabel: UILabel!
    
    @IBOutlet weak var dueDateButton: UIButton!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    @IBAction func dueDateButtonPushed(_ sender: Any) {
        dueDatePicker.isHidden = false
        pomSlider.isHidden = true
        zeroLabel.isHidden = true
        threeLabel.isHidden = true
        
    }
    @IBAction func dueDateChanged(_ sender: UIDatePicker) {
        
        dueDate = dueDatePicker.date
        let dateForDisplay = dueDate
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateStyle = DateFormatter.Style.short
        dueDateButton.setTitle(String(dateFormatter.string(from: dateForDisplay!)), for: .normal)

    }
    @IBOutlet weak var pomPickerButton: UIButton!
    @IBOutlet weak var pomPickerImage: UIImageView!
    @IBAction func pomSelectorPushed(_ sender: Any) {
        dueDatePicker.isHidden = true
        pomSlider.isHidden = false
        zeroLabel.isHidden = false
        threeLabel.isHidden = false
        
    }
    @IBOutlet weak var pomSlider: UISlider!
    
    @IBAction func pomSliderChanged(_ sender: Any) {
        
        if pomSlider.value > 0 {
            pomPickerButton.setTitle(nil, for: .normal)
            let poms = Int(pomSlider.value)
            let imageName = "POM#\(poms).png"
            pomPickerButton.setImage(UIImage(named: imageName), for: .normal)
            pomPickerButton.contentMode = .scaleAspectFit
            
        } else {
            
            pomPickerButton.setTitle("None", for: .normal)
        }

    }
    @IBOutlet weak var zeroLabel: UILabel!
    
    @IBOutlet weak var threeLabel: UILabel!
// MARK: - Properties
// MARK: - View Controller Life Cycle
// MARK: - Navigation
// MARK: - IBActions
// MARK: - Helper Functions
// MARK: - Delegates / Extensions
    
    
    func saveViewController() {
        if let newTitle = userTitle.text {
            
            //let newToDo = ToDoItem(title: newTitle, quadrant: nil, pomodoros: Int(pomSlider.value), snoozeDate: nil, dueDate: dueDate)
            
            //toDoData.append(newToDo)
        }
        
        self.dismiss(animated: true, completion: nil)
        }
    
    func imageForPoms(pomodoros: Int) -> UIImage?{
        let imageName = "POM#\(pomodoros).png"
        return UIImage(named: imageName)
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        
        dueDatePicker.isHidden = true
        pomSlider.isHidden = true
        zeroLabel.isHidden = true
        threeLabel.isHidden = true
        
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(NewToDo.saveViewController))
        
        navigationItem.rightBarButtonItem = saveButton

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
