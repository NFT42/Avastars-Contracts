pragma solidity 0.5.14;

import "./PrimeFactory.sol";

/**
 * @title Avastar Replicant Factory
 * @author Cliff Hall
 */
contract ReplicantFactory is PrimeFactory {

    /**
     * @notice Maximum number of Replicants that can be minted
     * in any given generation.
     */
    uint16 public constant MAX_REPLICANTS_PER_GENERATION = 25200;

    /**
     * @notice Event emitted upon the creation of an Avastar Replicant
     * @param id the token ID of the newly minted Replicant
     * @param serial the serial of the Replicant
     * @param generation the generation of the Replicant
     * @param gender the gender of the Replicant
     * @param traits the trait hash of the Replicant
     */
    event NewReplicant(uint256 id, uint256 serial, Generation generation, Gender gender, uint256 traits);

    /**
     * @notice Get the Avastar Replicant metadata associated with a given Generation and Serial
     * @param _generation the generation of the specified Replicant
     * @param _serial the serial of the specified Replicant
     * @return tokenId the Replicant's token ID
     * @return serial the Replicant's serial
     * @return traits the Replicant's trait hash
     * @return generation the Replicant's generation
     * @return gender the Replicant's gender
     * @return ranking the Replicant's ranking
     */
    function getReplicantByGenerationAndSerial(Generation _generation, uint256 _serial)
    external view
    returns (
        uint256 tokenId,
        uint256 serial,
        uint256 traits,
        Generation generation,
        Gender gender,
        uint8 ranking
    ) {
        require(_serial < replicantsByGeneration[uint8(_generation)].length);
        Replicant memory replicant = replicantsByGeneration[uint8(_generation)][_serial];
        return (
            replicant.id,
            replicant.serial,
            replicant.traits,
            replicant.generation,
            replicant.gender,
            replicant.ranking
        );
    }

    /**
     * @notice Get the Avastar Replicant associated with a given Token ID
     * @param _tokenId the token ID of the specified Replicant
     * @return tokenId the Replicant's token ID
     * @return serial the Replicant's serial
     * @return traits the Replicant's trait hash
     * @return generation the Replicant's generation
     * @return gender the Replicant's gender
     * @return ranking the Replicant's ranking
     */
    function getReplicantByTokenId(uint256 _tokenId)
    external view
    returns (
        uint256 tokenId,
        uint256 serial,
        uint256 traits,
        Generation generation,
        Gender gender,
        uint8 ranking
    ) {
        require(_tokenId < avastars.length);
        Avastar memory avastar = avastars[_tokenId];
        require(avastar.wave ==  Wave.REPLICANT);
        Replicant memory replicant = replicantsByGeneration[uint8(avastar.generation)][avastar.serial];
        return (
            replicant.id,
            replicant.serial,
            replicant.traits,
            replicant.generation,
            replicant.gender,
            replicant.ranking
        );
    }

    /**
     * @notice Mint an Avastar Replicant.
     * Only invokable by minter role, when contract is not paused.
     * If successful, emits a `NewReplicant` event.
     * @param _owner the address of the new Avastar's owner
     * @param _traits the new Replicant's trait hash
     * @param _generation the new Replicant's generation
     * @param _gender the new Replicant's gender
     * @param _ranking the new Replicant's rarity ranking
     * @return tokenId the newly minted Replicant's token ID
     * @return serial the newly minted Replicant's serial
     */
    function mintReplicant(
        address _owner,
        uint256 _traits,
        Generation _generation,
        Gender _gender,
        uint8 _ranking
    )
    external onlyMinter whenNotPaused
    returns (uint256 tokenId, uint256 serial)
    {
        require(_traits != 0);
        require(isHashUsedByGeneration[uint8(_generation)][_traits] == false);
        require(_ranking > 0 && _ranking <= 100);
        require(replicantCountByGeneration[uint8(_generation)] < MAX_REPLICANTS_PER_GENERATION);

        // Get Replicant Serial and mint Avastar, getting tokenId
        serial = replicantsByGeneration[uint8(_generation)].length;
        tokenId = mintAvastar(_owner, serial, _traits, _generation, Wave.REPLICANT);

        // Create and store Replicant struct
        replicantsByGeneration[uint8(_generation)].push(
            Replicant(tokenId, serial, _traits, _generation, _gender, _ranking)
        );

        // Increment count for given Generation
        replicantCountByGeneration[uint8(_generation)]++;

        // Send the NewReplicant event
        emit NewReplicant(tokenId, serial, _generation, _gender, _traits);

        // Return the tokenId, serial
        return (tokenId, serial);
    }

}