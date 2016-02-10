//
//  Model.m
//  Two-TwoNotes
//
//  Created by Jiang Zhou on 2/6/16.
//  Copyright © 2016 Jiang Zhou. All rights reserved.
//

#import "Model.h"
#import "Note.h"
@class Note;

@implementation Model
+ (Model *)sharedModel
{
    static Model* modelSingleton = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        modelSingleton = [[Model alloc] init];
    });
    return modelSingleton;
}

- (Notes *)notes {
    if (!_notes) {
        _notes = [[Notes alloc] initWithNotes:[self loadNotes]];
    }
    return _notes;
}

-(NSString *)filePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    return ([documentsDirectoryPath stringByAppendingPathComponent:@"noteData"]);
}

-(void)saveNotes {
    [NSKeyedArchiver archiveRootObject:self.notes.notes toFile:[self filePath]];
}

-(NSArray *)loadNotes {
    NSArray *notesArray = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath]];
    if (!notesArray) {
        notesArray = @[];
    }
    return(notesArray);
}



@end
