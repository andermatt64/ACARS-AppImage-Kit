# ACARS AppImage Kit
AppImage build kit for ACARS-related toolset.

## How do I use this?
To start the build, run
<pre>
./build-acars-kit.sh
</pre>
After the script successfully completes, the `export/` directory will be populated with AppImages.

## What AppImages are built?
The following AppImages are then built with the above tools and libraries:
 * `acarsdec-x86_64.AppImage` (RTL-SDR support only) 
 * `dumphfdl-x86_64.AppImage` (RTL-SDR + SoapySDR w/ Airspy HF)
 * `dumpvdl2-x86_64.AppImage` (RTL-SDR + SoapySDR)
 * `JAERO-x86_64.AppImage` (AeroAMBE + ZeroMQ)
 * `SDR++-x86_64.AppImage` (RTL-SDR + SoapySDR + Airspy/Airspy HF + HackRF + Audio Sink)
 * `SDRReceiver-x86_64.AppImage` (RTL-SDR)

## What libaries/tools are you building with?
We pull and compile the latest version of the following libraries/tools:
 * [SoapySDR](https://github.com/pothosware/SoapySDR)
 * [libacars](https://github.com/szpajder/libacars.git)
 * [acarsdec](https://github.com/TLeconte/acarsdec.git)
 * [dumpvdl2](https://github.com/szpajder/dumpvdl2.git)
 * [airspyhf](https://github.com/airspy/airspyhf.git)
 * [SoapyAirspyHF](https://github.com/pothosware/SoapyAirspyHF.git)
 * [dumphfdl](https://github.com/szpajder/dumphfdl.git)
 * [qmqtt](https://github.com/emqx/qmqtt.git)
 * [libcorrect](https://github.com/quiet/libcorrect)
 * [libaeroambe](https://github.com/jontio/libaeroambe)
 * [JFFT](https://github.com/jontio/JFFT)
 * [JAERO](https://github.com/jontio/JAERO)
 * [SDRReceiver](https://github.com/jeroenbeijer/SDRReceiver)
 * [airspyone_host](https://github.com/airspy/airspyone_host.git)
 * [SDRPlusPlus](https://github.com/andermatt64/SDRPlusPlus)
  
## What platform are these AppImages targeting/tested for?
The AppImages are built in a `x86_64` Debian Bullseye container with `glibc 2.31`. In theory, any Linux distro with `glibc 2.31` and above should be able to run the AppImages. 

The primary target platform for these AppImages is the SteamDeck. However, we have tested and confirmed that it also works on the following configurations:
 * Debian Bullseye (x86_64)
 * Fedora 36 (x86_64)
 * SteamDeck SteamOS

## Why do you use a forked SDRPlusPlus?
SDRPlusPlus is not AppImage friendly by default. It uses a `config.json` that defines the modules and resources directory as a hardcoded value. We had to modify the logic to dynamically find the installation prefix. The bulk of the changes are in `core/src/core.cpp` for those interested.

