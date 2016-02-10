//
//  Notes.h
//  Two-TwoNotes
//
//  Created by Jiang Zhou on 2/9/16.
//  Copyright © 2016 Jiang Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"

@interface Notes : NSObject

@property (strong, nonatomic) NSMutableArray *notes;
-(id)initWithNotes:(NSArray *)notes;

-(NSInteger)count;
-(Note *)getNoteAtIndex:(NSInteger)index;
-(void)addNote:(Note *)note;
-(Note *)deleteNoteAtIndex:(NSInteger)index;
-(void)moveFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;


@end
