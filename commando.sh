# Commando recipe for starting
date
DIR=${HOME}/slacks
echo "Currently running:"
ps augxw | grep slacks.jar | grep -v grep
echo "Executing kill and waiting 10 seconds"
ps augxw | grep slacks.jar | grep -v grep | awk '{print "kill",$2}' | sh -v
sleep 10
echo "Currently running:"
ps augxw | grep slacks.jar | grep -v grep 
cd ${DIR}
echo "Pulling from git and building uberjar"
git pull
lein ring uberjar
export PORT=3001
echo "Starting daemon"
/bin/rm -f STDERR STDOUT
daemon -D ${DIR} -O ${DIR}/STDOUT -E ${DIR}/STDERR -- java -jar ${DIR}/target/slacks.jar
# daemon -D ${HOME}/slacks  -O $HOME/slacks/STDOUT -E $HOME/slacks/STDERR -- lein ring server-headless 3001
echo "Sleeping 30 seconds."
sleep 30
echo "Currently running"
ps augx | grep slacks | grep -v grep
date
echo "Stdout:"
cat STDOUT
echo "Stderr:"
cat STDERR
