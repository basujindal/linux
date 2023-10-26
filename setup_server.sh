### install packages

### Ask for name and Email ID

echo "Enter your name: "
read NAME
echo "Enter Mail ID"
read EMAIL

read -p "Do you want to install kubectl? (y/n) " -n 1 -r
INSTALL_KUBECTL=false
if [[ $REPLY =~ ^[Yy]$ ]]; then
    INSTALL_KUBECTL=true
fi

apt update && apt upgrade -y && apt install -y \
    git \
    wget \
    nano \
    curl \
    unzip \
    zip \
    htop \
    net-tools

###  install miniconda

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh &&
    mkdir /.conda &&
    sh Miniconda3-latest-Linux-x86_64.sh -b &&
    rm -f Miniconda3-latest-Linux-x86_64.sh

### add conda to path
echo 'export PATH="/root/miniconda3/bin:$PATH"' >>~/.bashrc
source ~/.bashrc
conda create -y -n myenv python=3.8

echo -e "\e[31muse . activate myenv\e[0m"

### add ssh-keygen with no passphrase
ssh-keygen -t rsa -b 4096 -C $EMAIL -N "" -f ~/.ssh/id_rsa -q
cat ~/.ssh/id_rsa.pub ## add this to github
git config --global user.email $EMAIL
git config --global user.name $NAME

echo -e "\e[31mDont forget to add id_rsa.pub to Github\e[0m"

### install kubectl if needed

if [ "$INSTALL_KUBECTL" = true ]; then
    echo -e "\e[31mInstalling kubectl\e[0m"
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
fi
