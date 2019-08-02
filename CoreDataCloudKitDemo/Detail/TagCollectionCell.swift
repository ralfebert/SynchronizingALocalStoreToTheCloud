/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A UITableViewCell subclass that implements UICollectionViewDelegate and UICollectionViewDataSource to present the tags of the current post.
*/

import UIKit

class TagCollectionCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    var post: Post?
    
    /**
     The label font, used to calculate the tag text size.
     */
    private var tagLabelFont: UIFont!
    
    /**
     Create a cell and grab the font.
     
     Dequeueing a cell triggers collectionView data loading, but there is no data then so the load should end quickly.
     
     The view controller should call collectionView.reloadData when the data is ready.
     */
    override func awakeFromNib() {
        super.awakeFromNib()

        guard tagLabelFont == nil else { return }
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "tagCVCell", for: IndexPath(item: 0, section: 0)) as? TagCVCell
        tagLabelFont = cell?.tagLabel.font ?? UIFont.systemFont(ofSize: 17)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let post = post, let tags = post.tags else { return 0 }
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagCVCell", for: indexPath) as? TagCVCell else {
            fatalError("###\(#function): Failed to dequeue TagCVCell! Check the cell reusable identifier in Main.storyboard.")
        }
        guard let tag = post?.tagsList[indexPath.row] else { return cell }
        
        cell.tagLabel.text = tag.name
        cell.tagLabel.textColor = tag.color as? UIColor
        return cell
    }
    
    @objc(collectionView:layout:sizeForItemAtIndexPath:)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let tag = post?.tagsList[indexPath.item] as? Tag else {
            fatalError("###\(#function): Failed to retrieve a tag from post.tags at: \(indexPath.item)")
        }
        return TagLabel.sizeOf(text: tag.name!, font: tagLabelFont)
    }
}
