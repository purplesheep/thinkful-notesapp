//
//  Notes.m
//  Two-TwoNotes
//
//  Created by Jiang Zhou on 2/9/16.
//  Copyright © 2016 Jiang Zhou. All rights reserved.
//

#import "Notes.h"

@implementation Notes

- (id)initWithNotes:(NSArray *)notes {
    self = [super init];

    self.notes = [notes mutableCopy];
    return self;



}


- (NSInteger)count {
    return self.notes.count;
}

- (void)addNote:(Note *)note {
    [self.notes addObject:note];
}

- (Note *)getNoteAtIndex:(NSInteger)index {
    return self.notes[index];
}


- (Note *)deleteNoteAtIndex:(NSInteger)index {
    Note *tempNote = self.notes[index];
    [self.notes removeObjectAtIndex:index];
    return tempNote;
}

- (void)moveFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    Note *tempNote = [self deleteNoteAtIndex:fromIndex];
    [self.notes insertObject:tempNote atIndex:toIndex];
    
}

//lazy instantiation


@end
