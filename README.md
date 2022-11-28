# Simple Name Registry

### Objectives

1. Users (identified by an address) can claim a name, which is recorded on-chain.
2. Once a name has been claimed, no other user can claim it.
3. A name owner can release a name.
4. A user can claim any number of names.

### Functions

`registerName()`

- accepts string to register as input parameter
- check for string equality with existing registered names by hashing the input
- stores the user's address together with the hash of the input string

`releaseName()`

- accepts string to release as input parameter
- check that user has registered this name previously
- reset the storage location of this name to zero
