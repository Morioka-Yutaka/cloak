/*** HELP START ***//*

options cmplib=work.f ; is required prior to function is used.

Function Name: cloak_num
Author: Yutaka Morioka

Description:
  This function simulates a check-in/check-out mechanism for numeric items 
  using a dictionary (hash-like structure). It accepts a unique tag (character string) 
  and a numeric item for check-in. If an item with the same tag already exists, 
  it rejects the new entry. If the second argument is missing, the function 
  attempts to check out the item associated with the tag.

Inputs:
  tag_sign - A character string used as a key (up to 1000 characters).
  backage  - A numeric value to be stored (for check-in), or missing (for check-out).

Outputs:
  - If check-in: returns a numeric return code (0 for success, 9999 for failure).
  - If check-out: returns the stored numeric value, or 9999 if the tag was not found.

Usage:
  - To check in: cloak_num("KEY123", 42);
  - To check out: cloak_num("KEY123", .);

Notes:
  - This function uses a persistent dictionary to retain values across calls.
  - It logs success or failure messages via the PUT statement.

*//*** HELP END ***/

function cloak_num(tag_sign $ ,backage);
length tag  $1000;
tag=tag_sign;
 declare dictionary cloak;
 if ^missing(backage) then do;
    check=cloak[tag];
    if ^missing(check) then do;
      rc=9999;
      put "NOTE:FAILURE: An item is already checked in under this tag. Unable to accept another." tag= backage=;
    end;
   else do;
      rc=0;
     cloak[tag]=backage;
      put "NOTE:SUCCESS: The item was successfully checked in." tag= backage=;
   end;
    return(rc);
 end;

 else if missing(backage) then do;
    check=cloak[tag];
    if missing(check) then do;
      rc=9999;
      put "NOTE:FAILURE: No checked-in item was found for the provided tag." tag= backage=;
    end;
   else do;
      rc=0;
      _backage=cloak[tag];
      cloak[tag]=.;
      put "NOTE:SUCCESS: The item was successfully checked out." tag= backage=;
   end;
    return(_backage);
 end;
 call missing(of backage check);

 endsub;
