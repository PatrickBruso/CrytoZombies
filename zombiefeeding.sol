pragma solidity >=0.5.0 <0.6.0;

import "./zombiefactory.sol";

contract ZombieFeeding is ZombieFactory {
    
    // Create function to feed and multiply zombies
    function feedAndMultiply(uint _zombieId, uint _targetDna) public view {

        // Use require to make sure msg.sender owns this zombie to feed
        require(msg.sender == zombieToOwner[_zombieId]);

        // Create new Zombie on storage and set it equal to Zombie from zombies array
        Zombie storage myZombie = zombies[_zombieId];

        // Check to make sure target dna is not longer than 16 digits
        _targetDna = _targetDna % dnaModulus;

        // Create new dna variable to hold average of zombie dna and target dna
        uint newDna = (myZombie.dna + _targetDna) / 2;

        // Call createZombie function with new dna parameters and no name
        createZombie("NoName", newDna);
    }
}