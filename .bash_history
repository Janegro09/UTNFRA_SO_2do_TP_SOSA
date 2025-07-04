useradd -m -s /bin/bash -c "usuario para tp2" jsosa
sudo useradd -m -s /bin/bash -c "usuario para tp2" jsosa
cd /etc/sudoers.d/
ls -la
cat << EOF >> jsosa 
jsosa ALL=(ALL) NOPASSWD:ALL
