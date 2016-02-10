//
//  Model.h
//  Two-TwoNotes
//
//  Created by Jiang Zhou on 2/6/16.
//  Copyright © 2016 Jiang Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Notes.h"


@class Note;


@interface Model : NSObject

@property (strong, nonatomic) Notes *notes;

+ (Model *)sharedModel;
//-(void)saveNote:(Note *)note;
//-(Note *)loadNote;

-(void)saveNotes;


@end
