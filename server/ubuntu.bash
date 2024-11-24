# install required stuff
sudo apt install curl nodejs
sudo apt install git
git config --global user.email lkb2438834817@gmail.com
sudo apt install vim
sudo apt install openssh-server
echo "alias startSsh='sudo systemctl enable --now sshd'" >> ~/.bashrc
echo "alias restartSsh='sudo systemctl restart ssh'" >> ~/.bashrc
sudo apt install tmux
sudo snap install docker


# conf file
git clone git@github.com:AEsir777/manjaro-zephyrusg14-setup.git
ln -s manjaro-zephyrusg14-setup/.vimrc ~/.vimrc
ln -s manjaro-zephyrusg14-setup/.tmux.conf ~/.tmux.conf

# docker
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl xsel
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# dns
sudo apt-get install bind9




