export COMPLETED=false
while [ "$COMPLETED" == "false" ]; do
(
 set -e errexit
 set -o pipefail
 # workaround https://github.com/ansible/ansible/issues/21562
 export HOME=/root
 cd /tmp/
 rm -rf bin local share roles include lib || true
 dpkg-query -l libffi-dev || ( apt update -y && apt install libffi-dev -y )
 dpkg-query -l libssl-dev || ( apt update -y && apt install libssl-dev -y )
 test -e /usr/bin/python || ( apt update -y && apt install python-minimal -y )
 test -e /usr/bin/pip || ( apt update -y && apt install python-pip -y )
 test -e /usr/bin/virtualenv || ( apt update -y && apt install virtualenv -y )
 pip install -r /tmp/requirements.txt
 virtualenv .
 source bin/activate
 pip install -r /tmp/requirements.txt
 ansible-playbook -e ansible_python_interpreter=/usr/bin/python --connection=local playbook.yml
) >> /var/log/cloud-scripts.log 2>&1
if [ $? == 0 ]; then
  COMPLETED=true
fi
sleep 1
done
