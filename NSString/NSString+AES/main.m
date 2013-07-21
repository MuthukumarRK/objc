/* * Objective-C Augments - A small, miscellaneous set of Objective-C String and Data
 * augmentations
 * Copyright (C) 2011- nicerobot
 *
 * This file is part of Objective-C Augments.
 *
 * Objective-C Augments is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Objective-C Augments is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Objective-C Augments.  If not, see <http://www.gnu.org/licenses/>.
 */



#import <stdio.h>
#import <stdlib.h>
#import <getopt.h>
#include <pwd.h>
#include <unistd.h>

#import "main.h"
#import "NSString+AES/NSString+AES.h"
#import "NSData+Output/NSData+Output.h"

void usage(int argc, char *argv[]) {
  printf("Usage: %s [OPTIONS] [value]\n", argv[0]);
}

int main(int argc, char *argv[])
{
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  
  @try {
    int c=0;
    BOOL ascii = FALSE;
    
    NSString *key = nil;
    
    while (c>=0)
    {
      static struct option long_options[] =
      {
        {"ascii",  no_argument,       0, 'a'},
        {"help",   no_argument,       0, 'h'},
        {"key",    required_argument, 0, 'k'},
        {0, 0, 0, 0}
      };
      /* getopt_long stores the option index here. */
      int option_index = 0;
      
      c = getopt_long (argc, argv, "ahk:",
                       long_options, &option_index);
      
      switch (c)
      {
        case -1:
          break;
          
        case 0:
          /* If this option set a flag, do nothing else now. */
          if (long_options[option_index].flag != 0)
            break;
          printf ("option %s", long_options[option_index].name);
          if (optarg)
            printf (" with arg %s", optarg);
          printf ("\n");
          break;

        case 'a':
          ascii = TRUE;
          break;

        case '?':
          /* getopt_long already printed an error message. */
        case 'h':
          usage(argc,argv);
          return 0;
          break;
          
        case 'k':
          key = [NSString stringWithUTF8String:optarg];
          break;
          
        default:
          return 0;
      }
    }
    
    if (!key || optind >= argc) {
      usage(argc,argv);
      return 1;
    }
    
    for (;optind < argc; optind++) {
      NSString *val = [NSString stringWithUTF8String:argv[optind]];
      NSData *ct = [val encrypt:key];
        if (ascii) {
          puts([[ct descriptionAsHex] UTF8String]);
        } else {
          puts([[ct description] UTF8String]);
        }
    }
  }
  @finally {
    [pool drain];
    
  }
  
  return 0;
}
