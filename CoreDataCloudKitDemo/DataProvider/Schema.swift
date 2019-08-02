/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Select entities and attributes from the Core Data model. Use these to check whether a persistent history change is relevant to the current view.
*/
import CoreData

/**
 Relevant entities and attributes in the Core Data schema.
 */
enum Schema {
    enum Post: String {
        case title
    }
    enum Tag: String {
        case uuid, name, postCount
    }
}

extension Post {
    
    var tagsList : [Tag] {
        guard let list = self.tags?.allObjects as? [Tag] else { return [] }
        return list.sorted { (lhs, rhs) -> Bool in
            (lhs.name ?? "") < (rhs.name ?? "")
        }
    }
    
    var attachmentsList : [Attachment] {
        guard let list = self.attachments?.allObjects as? [Attachment] else { return [] }
        return list.sorted { (lhs, rhs) -> Bool in
            lhs.objectID.uriRepresentation().absoluteString < rhs.objectID.uriRepresentation().absoluteString
        }
    }
    
}
