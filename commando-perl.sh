date
DIR=${HOME}/slacks
export PERLBREW_ROOT=${HOME}/perl5/perlbrew
export PERLBREW_HOME=/tmp/.perlbrew
source ${PERLBREW_ROOT}/etc/bashrc
ps augxw | grep slackbot | grep -v grep
echo "Executing kill and waiting 10 seconds"
ps augxw | grep slackbot | grep -v grep | awk '{print "kill",$2}' | sh -v
sleep 10
echo "Currently running:"
ps augxw | grep slackbot | grep -v grep 
cd ${DIR}
echo "Pulling from git"
git pull
echo "Starting daemon"
/bin/rm -f STDERR STDOUT
daemon -d -D ${DIR} -O ${DIR}/STDOUT -E ${DIR}/STDERR -- perlbrew exec --with perl-5.21.2 ${DIR}/slackbot.pl daemon -l "http://localhost:3001"
echo "Sleeping 10 seconds."
sleep 10
echo "Currently running"
ps augx | grep slackbot | grep -v grep
date
echo "Stdout:"
cat STDOUT
echo "Stderr:"
cat STDERR
