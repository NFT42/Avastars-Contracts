# ERC721Metadata.sol

View Source: [@openzeppelin/contracts/token/ERC721/ERC721Metadata.sol](https://github.com/Dapp-Wizards/Avastars-Contracts/blob/master/@openzeppelin/contracts/token/ERC721/ERC721Metadata.sol)

**ERC721Metadata** **↗ Extends: [Context](contracts/Context.md), [ERC165](contracts/ERC165.md), [ERC721](contracts/ERC721.md), [IERC721Metadata](contracts/IERC721Metadata.md)**
**↘ Derived Contracts: [ERC721Full](contracts/ERC721Full.md)**

## Constructor

Constructor function

```solidity
constructor() public
```

## Contract Members
**Constants & Variables**

```solidity
// private members
string private _name;
string private _symbol;
mapping(uint256 => string) private _tokenURIs;
bytes4 private constant _INTERFACE_ID_ERC721_METADATA;

```

## **Functions**

- [name](#name)
- [symbol](#symbol)
- [tokenURI](#tokenuri)
- [_setTokenURI](#_settokenuri)
- [_burn](#_burn)

### name

⤾ overrides [IERC721Metadata.name](contracts/IERC721Metadata.md#name)

Gets the token name.

```solidity
function name()
external view
returns (string)
```

**Returns**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
|  | string | representing the token name | 

### symbol

⤾ overrides [IERC721Metadata.symbol](contracts/IERC721Metadata.md#symbol)

Gets the token symbol.

```solidity
function symbol()
external view
returns (string)
```

**Returns**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
|  | string | representing the token symbol | 

### tokenURI

⤾ overrides [IERC721Metadata.tokenURI](contracts/IERC721Metadata.md#tokenuri)

⤿ Overridden Implementation(s): [AvastarTeleporter.tokenURI](contracts/AvastarTeleporter.md#tokenuri)

Returns an URI for a given token ID.
Throws if the token ID does not exist. May return an empty string.

```solidity
function tokenURI(uint256 tokenId)
external view
returns (string)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| tokenId | uint256 | uint256 ID of the token to query | 

**Returns**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
|  | string |  | 

### _setTokenURI

Internal function to set the token URI for a given token.
Reverts if the token ID does not exist.

```solidity
function _setTokenURI(uint256 tokenId, string uri)
internal nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| tokenId | uint256 | uint256 ID of the token to set its URI | 
| uri | string | string URI to assign | 

### _burn

⤾ overrides [ERC721._burn](contracts/ERC721.md#_burn)

Internal function to burn a specific token.
Reverts if the token does not exist.
Deprecated, use _burn(uint256) instead.

```solidity
function _burn(address owner, uint256 tokenId)
internal nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| owner | address | owner of the token to burn | 
| tokenId | uint256 | uint256 ID of the token being burned by the msg.sender | 

