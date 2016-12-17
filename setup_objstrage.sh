#! /bin/bash

set -xeu

echo "Please enter BUCKET NAME"
read mybucket
echo ""
echo "Please enter ACCESSKEY"
read accesskey
echo ""
echo "Please enter SECRETKEY"
read secretkey

# 必要なものをインストール
yum install -y yum install pkgconfig libcurl libcurl-devel libxml2-devel make automake gcc libstdc++-devel gcc-c++ openssl-devel wget fuse-devel

# ここからs3fsのインストール
cd /usr/local/src
wget https://github.com/libfuse/libfuse/releases/download/fuse-3.0.0/fuse-3.0.0.tar.gz
tar zxvf fuse-3.0.0.tar.gz
cd fuse-3.0.0
./configure --prefix=/usr
make
make install
ldconfig
modprobe fuse
cd /usr/local/src
wget "https://github.com/s3fs-fuse/s3fs-fuse/archive/v1.74.zip"
unzip v1.74.zip
cd s3fs-fuse-1.74
./autogen.sh
./configure --prefix=/usr
make
make install

touch ~/.passwd-s3fs && echo "$mybucket:$accesskey:$secretkey" > ~/.passwd-s3fs
chmod 600 ~/.passwd-s3fs
echo 'user_allow_other' >> /etc/fuse.conf
mkdir -p /mnt/objstragedir

s3fs $mybucket /mnt/objstragedir/ -o allow_other,url=https://b.sakurastorage.jp,nomultipart

# アップロードテスト
dd if=/dev/zero of=/mnt/objstragedir/test1MB bs=1MB count=1
# 変更テスト
mv /mnt/objstragedir/test1MB /mnt/objstragedir/test1MBBB
# ダウンロードテスト
cp /mnt/objstragedir/test1MBBB ~/
# 削除テスト
rm -f /mnt/objstragedir/test1MBBB

# ホームディレクトリの不要なファイルを削除
rm -f ~/test1MBBB
