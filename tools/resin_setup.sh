#!/usr/bin/env bash

DIR=$(pwd)

git init
touch CHANGELOG.md LICENSE README.md

cat << EOF > imx7d-pico.coffee
deviceTypesCommon = require '@resin.io/device-types/common'
{ networkOptions, commonImg, instructions } = deviceTypesCommon

module.exports =
  version: 1
  slug: 'imx7d-pico'
  aliases: [ 'imx7d-pico' ]
  name: 'imx7d-pico'
  arch: 'armv7hf'
  state: 'released'
  
  instructions: commonImg.instructions
  gettingStartedLink:
				windows: 'https://github.com/latitude59/meta-resin-freescale'
				osx: 'https://github.com/latitude59/meta-resin-freescale'
				linux: 'https://github.com/latitude59/meta-resin-freescale'
  supportsBlink: false
  
  yocto:
    machine: 'imx7d-pico'
    image: 'resin-image'
    fstype: 'resinos-img'
    version: 'yocto-rocko'
    deployArtifact: 'resin-image-pico-imx7d.resinos-img'
    compressed: true
    
  options: [ networkOptions.group ]
  
  configuration:
			config:
					partition:
							primary: 1
					path: '/config.json'
  initialization: commonImg.initialization
EOF

VER="2.12.0+rev1"

echo ${VER} > VERSION

git submodule add -b master https://github.com/resin-os/resin-yocto-scripts

mkdir layers && cd layers

git submodule add -b rocko git://git.yoctoproject.org/poky
git submodule add -b rocko https://github.com/openembedded/meta-openembedded.git
git submodule add -b master https://github.com/resin-os/meta-resin
git submodule add -b rocko git://git.yoctoproject.org/meta-freescale
git submodule add -b rocko https://github.com/Freescale/meta-freescale-3rdparty.git
#git submodule add -b rocko https://github.com/Freescale/meta-freescale-distro
git submodule add -b rocko https://github.com/meta-rust/meta-rust.git
git clone -b master https://github.com/latitude59/meta-resin-freescale

cd ${DIR}
git add .
git commit -m "initial commit"

cd layers/meta-rust
git checkout 5a9c23f
cd ${DIR}/layers/poky
git checkout c2b641c
cd ${DIR}
git add layers/meta-rust layers/poky
git commit -m "update rust/poky revs to match resin-raspberrypi"

