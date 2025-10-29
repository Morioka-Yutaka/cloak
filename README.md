# cloak
A simple FCMP-based check-in/check-out storage system using dictionary objects in SAS-store and retrieve data by key, like a digital cloakroom.  
Additionally, macro-based stack and queue functions are provided.

<img width="300" height="300" alt="Image" src="https://github.com/user-attachments/assets/2bd230ca-a72c-4b7e-b2bb-f2212a089566" /> 

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

# :cloak_char() Function
Description:
  This function simulates a check-in/check-out mechanism for character items 
  using a dictionary (hash-like structure). It accepts a unique tag (character string) 
  and a character value for check-in. If an item with the same tag already exists, 
  it rejects the new entry. If the second argument is missing, the function 
  attempts to check out the item associated with the tag.  
  
Inputs: cloak_char(tag_sign,backage)  
~~~text
  tag_sign - A character string used as a key (up to 1000 characters).
  backage  - A character string to be stored (for check-in), or missing (for check-out).
~~~
~~~text 
Outputs:
  - If check-in: returns a character string "0" (success) or "9999" (failure).
  - If check-out: returns the stored character value, or "9999" if the tag was not found.
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
<img width="657" height="327" alt="Image" src="https://github.com/user-attachments/assets/6f7d653f-8fdb-43c7-9390-faf11f49ce1c" />  

The value checked in with the A tag in the first line is checked out in the last line.  
The value checked in with the C tag in the third line is checked out in the fifth line, so it is clear that it no longer exists in the sixth line.  

Notes:
  - This function uses a persistent dictionary to retain values across calls.
  - It logs success or failure messages via the PUT statement.

# version history
0.1.0(28July2025): Initial version

## What is SAS Packages?

The package is built on top of **SAS Packages Framework(SPF)** developed by Bartosz Jablonski.

For more information about the framework, see [SAS Packages Framework](https://github.com/yabwon/SAS_PACKAGES).

You can also find more SAS Packages (SASPacs) in the [SAS Packages Archive(SASPAC)](https://github.com/SASPAC).

## How to use SAS Packages? (quick start)

### 1. Set-up SAS Packages Framework

First, create a directory for your packages and assign a `packages` fileref to it.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
filename packages "\path\to\your\packages";
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Secondly, enable the SAS Packages Framework.
(If you don't have SAS Packages Framework installed, follow the instruction in 
[SPF documentation](https://github.com/yabwon/SAS_PACKAGES/tree/main/SPF/Documentation) 
to install SAS Packages Framework.)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
%include packages(SPFinit.sas)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


### 2. Install SAS package

Install SAS package you want to use with the SPF's `%installPackage()` macro.

- For packages located in **SAS Packages Archive(SASPAC)** run:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
  %installPackage(packageName)
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- For packages located in **PharmaForest** run:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
  %installPackage(packageName, mirror=PharmaForest)
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- For packages located at some network location run:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
  %installPackage(packageName, sourcePath=https://some/internet/location/for/packages)
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  (e.g. `%installPackage(ABC, sourcePath=https://github.com/SomeRepo/ABC/raw/main/)`)


### 3. Load SAS package

Load SAS package you want to use with the SPF's `%loadPackage()` macro.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
%loadPackage(packageName)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


### Enjoy!

