#!/bin/bash
# Redeploy the latest code from GitHub on the EC2 instance.
# Usage (as the ubuntu user):  bash /opt/app/deploy.sh   (or copy this file to the server)
set -e
cd /opt/app
git pull
source venv/bin/activate
pip install -r requirements.txt
set -a; source /etc/tpms.env; set +a
python manage.py migrate
python manage.py collectstatic --noinput
sudo systemctl restart tpms
sudo systemctl status tpms --no-pager | head -5
echo "Deployed."
