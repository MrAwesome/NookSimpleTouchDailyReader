#!/system/bin/sh
                
# NOTE: This file must be populated with your own static IP address for this to work!
ADDR=$(cat /system/bin/ADDR)

NEWS_DIRECTORY="/dev/newsletters"
CHECKER="most_recent.txt"
                         
[ -d "$NEWS_DIRECTORY" ] || mkdir "$NEWS_DIRECTORY"
                                                   
cd "$NEWS_DIRECTORY"                               
                    
#MOST_RECENT=$(wget "http://$ADDR/$CHECKER" -O -)

