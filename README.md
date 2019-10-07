# catergos-iso

 [![Build Status](https://travis-ci.org/Catergos/catergos-iso.svg?branch=master)](https://travis-ci.org/Catergos/catergos-iso)
this is the repo with source code of catergos iso 

### Test it on your own fork with travis

- Generate a github oauth token from https://github.com/settings/tokens with repo in scope 

- Install Travis using gem (gem requires ruby to be installed with ruby dev)
   ```sh 
   sudo gem install travis 
   ```   
 - Get your secure part replaced in .travis.yml 
   ```sh 
     travis encrypt <token here> -r our_username/catergos-iso 
   ```
 Now, you will be able to deploy in your own fork to test before actually deploying.
  
![fork and like](https://github.com/xeon-zolt/catergos-iso/blob/master/Peek%202019-10-07%2014-55.gif)
