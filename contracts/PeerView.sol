//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

contract PeerView {
    // Declaring the videoCount 0 by default
    uint256 public videoCount = 0;
    // Name of your contract
    string public name = "PeerView";
    // Creating a mapping of videoCount to Video
    mapping(uint256 => Video) public videos;

    //  Create a struct called 'Video' with the following properties:
    struct Video {
        uint256 id;
        string hash;
        string title;
        string description;
        string location;
        string category;
        string thumbnailHash;
        string date;
        address author;
    }

    struct Profile {
    uint256 id;
    string name;
    string bio;
    string location;
    address owner;
}
// Creating a mapping of owner address to Profile
mapping(address => Profile) public profiles;


    // Create a 'VideoUploaded' event that emits the properties of the video
    event VideoUploaded(
        uint256 id,
        string hash,
        string title,
        string description,
        string location,
        string category,
        string thumbnailHash,
        string date,
        address author
    );
    // Create a 'ProfileCreated' event that emits the properties of the profile
event ProfileCreated(
    uint256 id,
    string name,
    string bio,
    string location,
   
    address owner
);

    constructor() {}

    // Function to upload a video
    function uploadVideo(
        string memory _videoHash,
        string memory _title,
        string memory _description,
        string memory _location,
        string memory _category,
        string memory _thumbnailHash,
        string memory _date
    ) public {
        // Validating the video hash, title and author's address
        require(bytes(_videoHash).length > 0);
        require(bytes(_title).length > 0);
        require(msg.sender != address(0));

        // Incrementing the video count
        videoCount++;
        // Adding the video to the contract
        videos[videoCount] = Video(
            videoCount,
            _videoHash,
            _title,
            _description,
            _location,
            _category,
            _thumbnailHash,
            _date,
            msg.sender
        );
        // Triggering the event
        emit VideoUploaded(
            videoCount,
            _videoHash,
            _title,
            _description,
            _location,
            _category,
            _thumbnailHash,
            _date,
            msg.sender
        );
    }
     
    function createProfile(
        string memory _name,
        string memory _bio,
        string memory _location
    
    ) public {
    // Validating the name and owner's address
        require(bytes(_name).length > 0);
        require(msg.sender != address(0));

        // Creating a new profile
        Profile memory newProfile = Profile(
            uint256(block.timestamp),
            _name,
            _bio,
            _location,
            
            msg.sender
        );

        // Adding the profile to the contract
        profiles[msg.sender] = newProfile;

        // Triggering the event
        emit ProfileCreated(
             newProfile.id,
            newProfile.name,
            newProfile.bio,
            newProfile.location,
            newProfile.owner
        );
    }

}
