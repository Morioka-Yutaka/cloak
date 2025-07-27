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
~~~text 
  - To check in: cloak_num("KEY123", 42);
  - To check out: cloak_num("KEY123", .);
~~~
Notes:  
  - This function uses a persistent dictionary to retain values across calls.  
  - It logs success or failure messages via the PUT statement.
