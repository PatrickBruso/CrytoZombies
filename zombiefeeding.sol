pragma solidity >=0.5.0 <0.6.0;

import "./zombiefactory.sol";

// Create interface to use getKitty function from CryptoKitties smart contract
contract KittyInterface {
    function getKitty(uint256 _id) external view returns (
        bool isGestating,
        bool isReady,
        uint256 cooldownIndex,
        uint256 nextActionAt,
        uint256 siringWithId,
        uint256 birthTime,
        uint256 matronId,
        uint256 sireId,
        uint256 generation,
        uint256 genes
    );
}

contract ZombieFeeding is ZombieFactory {

    // Initialize kittyContract variable
    KittyInterface kittyContract;

    // Create function to set address for kittyContract interface variable
    function setKittyContractAddress(address _address) external onlyOwner {
        kittyContract = KittyInterface(_address);
    }
    
    // Create function to feed and multiply zombies
    function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) public view {

        // Use require to make sure msg.sender owns this zombie to feed
        require(msg.sender == zombieToOwner[_zombieId]);

        // Create new Zombie on storage and set it equal to Zombie from zombies array
        Zombie storage myZombie = zombies[_zombieId];

        // Check to make sure target dna is not longer than 16 digits
        _targetDna = _targetDna % dnaModulus;

        // Create new dna variable to hold average of zombie dna and target dna
        uint newDna = (myZombie.dna + _targetDna) / 2;

        // If statement to check whether dna comes from kitty
        if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
            newDna = newDna - newDna % 100 + 99;
        }

        // Call createZombie function with new dna parameters and no name
        createZombie("NoName", newDna);
    }

    // Create function to obtain kitty dna from kittyContract and pass it to feedAndMultiply function
    function feedOnKitty(uint _zombieId, uint _kittyId) public view {
        uint kittyDna;
        (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
        feedAndMultiply(_zombieId, kittyDna, "kitty");
    }
}