pragma solidity >=0.5.0 <0.6.0;

import "./zombiefactory.sol";

contract ZombieFeeding is ZombieFactory {
    
    // Create function to feed and multiply zombies
    function feedAndMultiply(uint _zombieId, uint _targetDna) public view {

        // Use require to make sure msg.sender owns this zombie to feed
        require(msg.sender == zombieToOwner[_zombieId]);

        // Create new Zombie on storage and set it equal to Zombie from zombies array
        Zombie storage myZombie = zombies[_zombieId];
    }
}