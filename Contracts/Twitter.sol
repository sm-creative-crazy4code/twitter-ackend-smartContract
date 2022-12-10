// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Twitter {
  // ERRORS
  error Twitter__UserDonotExist();

  // EVENTS
  event TweetAdded(address indexed tweeter, tweet indexed tweets);
  event TweetDeleted(address indexed tweeter, tweet indexed tweets);

  /** @author Sneha Mandal
      @notice This code allows multiple users to add and delete their  tweets in an decentraized manner 
      @dev contains only basic functionalities of adding and deleting the tweets
    
 */

  /**@dev the structure of user storing user data
   */

  struct user {
    address userAddress;
    string userName;
    string profileImageUri;
    string BannerImageUri;
    address[] follower;
    address[] following;
    bool isExisting;
  }

  /**@dev the structure of tweet storing each individual  tweets
   */
  struct tweet {
    address whoTweeted;
    string tweetDescription;
    bool isDeleted;
    bool isLiked;
    uint uniqueid;
  }

  /**@dev mapping of
1.users to each individual addresses
2.each individual account to their tweets
 */
  mapping(address => user) public AllUserMapping;
  mapping(address => tweet[]) public AllTweets;

  //FUNCTIONS

  /**@dev the for setting the profile image
   */
  function setUserProfileImage(string memory _userImageUri) public {
    AllUserMapping[msg.sender].profileImageUri = _userImageUri;
  }

  /**@dev setting the banner image
   */
  function setUserBannermage(string memory _BannerImageUri) public {
    AllUserMapping[msg.sender].profileImageUri = _BannerImageUri;
  }

  /**@dev tfnctionality to add tweets
   */
  function addTweet(string memory _tweetDescription) public {
    if (AllUserMapping[msg.sender].isExisting) {
      uint counter = AllTweets[msg.sender].length;
      (AllTweets[msg.sender]).push(
        tweet(msg.sender, _tweetDescription, false, false, counter)
      );

      emit TweetAdded(msg.sender, AllTweets[msg.sender][counter]);
    } else {
      revert Twitter__UserDonotExist();
    }
  }

  /**@dev functionality to delete tweets
   */
  function deleteTweet(uint index) public {
    AllTweets[msg.sender][index].isDeleted = true;
    emit TweetDeleted(msg.sender, AllTweets[msg.sender][index]);
  }

  /**@dev the to retrive all tweets except the deleted ones
   */

  function getAllTweetsByUserAfterDeletion()
    public
    view
    returns (tweet[] memory)
  {
    tweet[] memory temp = new tweet[](AllTweets[msg.sender].length);
    uint counter = 0;

    for (uint i = 0; i < AllTweets[msg.sender].length; i++) {
      if (AllTweets[msg.sender][i].isDeleted == false) {
        temp[counter] = AllTweets[msg.sender][i];
        counter++;
      }
    }
    tweet[] memory result = new tweet[](counter);
    for (uint i = 0; i < counter; i++) {
      result[i] = temp[i];
    }
    return result;
  }
}
