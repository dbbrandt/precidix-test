# cbe-test
Cucumber-Watir Integration Testing 

## Getting up and running
    Ideally you have rvm installed and a default version of ruby setup (see below).
    Install chromedriver (ChromeDriver is a standalone server which implements WebDriver's 
    wire protocol for Chromium.) (see below) 

    git clone https://github.com/sagencelearning/cbe-test.git
    cd cbe-web
    bundle
    cp .env.sample .env
    # Edit the .env file to specify the location to put screen captures
    # export SCREENSHOT_DIR=/Users/<my-home-dir>/<projects/cbe-test>/results/screenshots
    rake tag_help
    # Pick sometag to run a test for
    rake tag_run[sometag, html]
    
    The results are put in a directory ./results with the tag and date (ex. coach4_170127.html)
     
## Installing Chromedriver

1. Goto the Chromedriver Project page (https://sites.google.com/a/chromium.org/chromedriver/downloads) 
click on the link for the latest release.  At the time of writing this, the latest version was 2.27
2. Download the chromedriver_mac64.zip
2. Unzip the package and then copy the file to /usr/bin
3. This is a hidden system folder so the easy way to get to this file is 
    - Open another finder window
    - From the Go menu select Go To Folder
    - Check echo $PATH to see if an accessible path is available to copy the file to.  
      Type /usr/local/bin and press enter
    - Now drag and drop the Chromedriver file from your Download folder to this directory. 
      You’ll be prompted for you Admin password.
5. You may need to restart your computer to get the chromedriver working

## Installing RVM
1. \curl -sSL https://get.rvm.io | bash -s stable --ruby
2. rvm -v     # check version
3. rvm install  2.3.1    # install ruby which also results in Hombrew being installed.
4. In the project directory run:
   rvm use 2.3.1 --default
