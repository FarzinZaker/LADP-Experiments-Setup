
sudo systemctl stop tomcat

git -C /home/src/DP-Application pull

rm -rf /home/src/DP-Application/build/libs/*.war

(cd /home/src/DP-Application && /home/grails/grails-3.2.6/bin/grails clean)

(cd /home/src/DP-Application && /home/grails/grails-3.2.6/bin/grails war)

sudo rm -rf /opt/tomcat/webapps/ROOT
sudo rm -rf /opt/tomcat/webapps/ROOT.war

sudo cp /home/src/DP-Application/build/libs/*.war /opt/tomcat/webapps/ROOT.war

sudo systemctl start tomcat