#export JAVA_HOME=/usr/local/jdk1.6.0_45
export DEPLOYMENT_HOME=/opt/jenkins-deploy/
export USERPORTAL_HOME=/opt/apache-tomcat-7.0.85

echo "[Deploy] Shutting down tomcat server"
if [ `ps -ef|grep apache-tomcat-7.0.85|grep -v grep|wc -l` -gt 0 ]
then
#for pid in `ps -ef|grep apache-tomcat-7.0.85|grep -v grep|tr -s ' '|cut -d ' ' -f2`
for pid in `ps -ef|grep apache-tomcat-7.0.85|grep -v grep|awk '{print $2}'`
do
kill -9 $pid 2>&1 > /dev/null
done
fi

echo "[Deploy] Cleaning cache for tomcat server"
rm -rf $USERPORTAL_HOME/work/Catalina/localhost/*

echo "[Deploy] Removing old war"
rm -rf $USERPORTAL_HOME/webapps/fxsb*

echo "[Deploy] Copying new war"
mv $DEPLOYMENT_HOME/fxsb-1.0-SNAPSHOT.war $USERPORTAL_HOME/webapps/fxsb.war

echo "[Deploy] Starting up tomcat server"
$USERPORTAL_HOME/bin/startup.sh
