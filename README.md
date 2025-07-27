# cloak
A simple FCMP-based check-in/check-out storage system using dictionary objects in SAS. Store and retrieve data by key, like a digital cloakroom.  

![cloak](./cloak_small.png)  

# :cloak_num() Function
Description:  
  This function simulates a check-in/check-out mechanism for numeric items  
  using a dictionary (hash-like structure). It accepts a unique tag (character string) 
  and a numeric item for check-in. If an item with the same tag already exists, 
  it rejects the new entry. If the second argument is missing, the function 
  attempts to check out the item associated with the tag.  

Inputs:  cloak_num(tag_sign,backage) 
~~~text 
  tag_sign - A character string used as a key (up to 1000 characters).
  backage  - A numeric value to be stored (for check-in), or missing (for check-out).
~~~
Outputs:  
~~~text 
  - If check-in: returns a numeric return code (0 for success, 9999 for failure).
  - If check-out: returns the stored numeric value, or 9999 if the tag was not found.
~~~
Usage:  
~~~sas 
data test;
do i = 1 to 10;
 ID = char("ABCDEFGHIJ",i);
 VAR1 =i ;
 VAR2 =cats(ID,VAR1);
 output;
end;
drop i;
run;

data test_output;
 set test end=eof;
 rc1 = cloak_num(ID,Var1);
 rc2 = cloak_char(ID,Var2);

if _N_ in (5,6) then do;
  out1 = cloak_num("B",.);
  out2 = cloak_char("C","");
end;

if eof then do;
  out1 = cloak_num("A",.);
  out2 = cloak_char("A","");
end;

drop rc:;
run;
~~~
<img width="683" height="316" alt="Image" src="https://github.com/user-attachments/assets/3d31b161-d0a7-4658-9126-28a7ef6c055c" />

The value checked in with the A tag in the first line is checked out in the last line.  
The value checked in with the B tag in the second line is checked out in the fifth line, so it is clear that it no longer exists in the sixth line.  

Notes:  
  - This function uses a persistent dictionary to retain values across calls.  
  - It logs success or failure messages via the PUT statement.
