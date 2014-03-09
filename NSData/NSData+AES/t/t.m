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


#import <Foundation/Foundation.h>
#import "NSData+AES/NSData+AES.h"

int main (int argc, const char * argv[]) {
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

	NSLog(@"testing symmetric encrypt/decrypt ...");
	NSString *_key = @"hello";
	NSString *_secret = @"hello";
	NSData *_secretData = [_secret dataUsingEncoding:NSASCIIStringEncoding];

	NSLog(@"plaintext string: %@",[[NSString alloc] initWithData:_secretData encoding:NSASCIIStringEncoding]);

	NSData *encryptedData = [_secretData encryptWithString:_key];
	
	NSLog(@"encrypted data: %@", encryptedData);
	
	NSData *data = [encryptedData decryptWithString:_key];
	NSLog(@"decrypted data: %@", data);
	NSString *str = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
	NSLog(@"decrypted string: %@", str);
	NSLog(@"test finished.");

  [pool drain];
  return 0;
}
