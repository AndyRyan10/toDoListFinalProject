//
//  ToDoViewCell.swift
//  toDoAppFinalProject
//
//  Created by Andrew Ryan on 7/26/17.
//  Copyright © 2017 AndrewRyan. All rights reserved.
//

import UIKit

class ToDoViewCell: UITableViewCell {
    
    @IBOutlet weak var toDoTitle: UILabel!
    
    @IBOutlet weak var pomodoroImageView: UIImageView!
    
    @IBOutlet weak var toDoDueDate: UILabel!
    
    var toDo: ToDoItem? {
        didSet {
            toDoTitle.text = toDo?.title
            
            if toDo?.dueDate != nil {
                let dateDue = toDo?.dueDate!
                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = DateFormatter.Style.none
                dateFormatter.dateStyle = DateFormatter.Style.short
                toDoDueDate.text = "Due: " + dateFormatter.string(from: dateDue!)
            }
            
            if toDo?.pomodoros != nil {
                if let correctImage = self.imageForPoms(pomodoros: (toDo?.pomodoros!)!) {
                    pomodoroImageView.image = correctImage
                }
            }
            
        }
    }
    
    
    func imageForPoms(pomodoros: Int) -> UIImage?{
        let imageName = "POM#\(pomodoros).png"
        return UIImage(named: imageName)
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }


}
