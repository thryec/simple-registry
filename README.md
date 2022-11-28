# Simple Name Registry

https://github.com/yieldprotocol/mentorship2022/issues/1

### Objectives

1. Users (identified by an address) can claim a name, which is recorded on-chain.
2. Once a name has been claimed, no other user can claim it.
3. A name owner can release a name.
4. A user can claim any number of names.

### Functions

`registerName()`

- accepts string to register as input parameter
- check that string has not been previously registered, else an error is thrown
- stores the name and the associated user's address in a mapping
- emits a RegisterName event

`revokeName()`

- accepts string to release as input parameter
- check that user is the owner of this name
- reset the storage location of this name to zero
- emits a RevokeName event
