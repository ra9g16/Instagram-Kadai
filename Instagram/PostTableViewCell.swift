//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by Ryota Akai on 2017/08/02.
//  Copyright © 2017年 ryota.akai. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPostData(postData: PostData) {
        self.postImageView.image = postData.image
        
        self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"
        
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale!
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateString:String = formatter.string(from: postData.date! as Date)
        self.dataLabel.text = dateString
        
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: UIControlState.normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: UIControlState.normal)
        }
        var post = [String]()
        for comment in postData.comments {
            let userName = comment["userName"]
            let commentText = comment["comment"]
            let nameComment = "\(String(describing: userName!)) : \(String(describing: commentText!))"
            post.append(nameComment)
        }
        
        self.commentLabel.text = post.joined(separator: "\n")
        
        commentButton.addTarget(self, action: #selector(PostTableViewCell.comment), for: UIControlEvents.touchUpInside)
    }
    
    //投稿ボタンが押されたらキーボードを閉じる
    func comment(){
        commentTextField.resignFirstResponder()
    }
}
