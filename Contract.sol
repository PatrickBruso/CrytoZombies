pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

    // Declare event when new zombie is added to zombies array
    event NewZombie(uint zombieId, string name, uint dna);

    // Declare variables for determining zombie dna
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    // Zombie struct to create new zombies
    struct Zombie {
        string name;
        uint dna;
    }

    // Create dynamic array of Zombie structs called zombies
    Zombie[] public zombies;

    // Create mappings for zombie owners and zombie counts
    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    // Function that adds new Zombie to array of structs and emits NewZombie event
    function _createZombie(string memory _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        // Set mappings for zombie owner and zombie count
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;
        // Call NewZombie event
        emit NewZombie(id, _name, _dna);
    }

    // Function to generate a length 16 dna for a Zombie
    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    // Function that creates a random Zombie by generating that Zombe's dna and calling _createZombie function
    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}