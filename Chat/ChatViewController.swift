//
//  ChatViewController.swift
//  Chat
//
//  Created by Pranav Bhandari on 8/7/16.
//  Copyright © 2016 Pranav Bhandari. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import MobileCoreServices

class ChatViewController: JSQMessagesViewController {

    var msg = [JSQMessage]()
    @IBAction func logOut(sender: AnyObject) {
        //Log users out
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyBoard.instantiateViewControllerWithIdentifier("loginVC") as! ViewController
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginVC
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.senderId = "1"
        self.senderDisplayName = "Pranav"
    }
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        print("\(text)")
        msg.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text))
        collectionView.reloadData()
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return msg[indexPath.item]
    }
    
    func getMedia(type : CFString)
    {
        let mediaPicker = UIImagePickerController()
        mediaPicker.delegate = self
        mediaPicker.mediaTypes = [type as String]
        self.presentViewController(mediaPicker, animated: true, completion: nil)
    }
    
    override func didPressAccessoryButton(sender: UIButton!) {
        let sheet = UIAlertController(title: "Media messages", message: "Select a media", preferredStyle: UIAlertControllerStyle.ActionSheet)
        self.presentViewController(sheet, animated: true, completion: nil)
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (alert: UIAlertAction) in
            
        }
        
        let photoLib = UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.Default) { (alert:UIAlertAction) in
            self.getMedia(kUTTypeImage)
        }
        
        let videoLib = UIAlertAction(title: "Video Library", style: UIAlertActionStyle.Default) { (alert:UIAlertAction) in
            self.getMedia(kUTTypeMovie)
        }
        
        sheet.addAction(photoLib)
        sheet.addAction(videoLib)
        sheet.addAction(cancel)
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return msg.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! JSQMessagesCollectionViewCell
        return cell
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        return bubbleFactory.outgoingMessagesBubbleImageWithColor(UIColor.blackColor())
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
}

extension ChatViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
       
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        //get the image
        let photo = JSQPhotoMediaItem(image : img)
        msg.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, media: photo))
        self.dismissViewControllerAnimated(true, completion: nil)
        collectionView.reloadData()
    }
}
