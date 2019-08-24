
# wget https://dl.google.com/android/repository/platform-tools-latest-linux.zip

unzip -f platform-tools-latest-linux.zip -d ./

export PATH="$PWD/platform-tools:$PATH"

apt-get install -y bc \
                bison \
                build-essential \
                ccache \
                curl \
                flex \
                g++-multilib \
                gcc-multilib \
                git \
                gnupg \
                gperf \
                imagemagick \
                lib32ncurses5-dev \
                lib32readline-dev \
                lib32z1-dev \
                liblz4-tool \
                libncurses5-dev \
                libsdl1.2-dev \
                libssl-dev \
                libwxgtk3.0-dev \
                libxml2 \
                libxml2-utils \
                lzop \
                pngcrush \
                rsync \
                schedtool \
                squashfs-tools \
                xsltproc \
                zip \
                zlib1g-dev \

mkdir -p ./bin
mkdir -p ./android/lineage

curl https://storage.googleapis.com/git-repo-downloads/repo > ./bin/repo
chmod a+x ./bin/repo

export PATH="$PWD/bin/:$PATH"

# Initialize the LineageOS source repository
cd ./android/lineage
repo init -u https://github.com/LineageOS/android.git -b cm-14.1

# Download the source code
repo sync -c

# Prepare the device-specific code
cd ./android/lineage
source build/envsetup.sh
breakfast h850

cd ./android/lineage/device/lge/h850
./extract-files.sh

export USE_CCACHE=1
export CCACHE_COMPRESS=1
ccache -M 50G

export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4G"

# build
croot
brunch h850

cd $OUT
