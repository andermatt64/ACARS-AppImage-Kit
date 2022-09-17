FROM debian:bullseye AS stage1

RUN apt update && \
  apt upgrade -y && \
  apt install -y \
  git wget build-essential librtlsdr-dev libsndfile1-dev libliquid-dev libfftw3-dev \
  libconfig++-dev qtmultimedia5-dev libqt5svg5-dev libqcustomplot-dev libczmq-dev \
  gir1.2-gst-plugins-bad-1.0 libmariadb-dev libpq-dev libfbclient2 freetds-dev \
  qt5-qmake cmake libglib2.0-dev imagemagick file libqt5multimedia5-plugins \
  libglfw3-dev libvolk2-dev libiio-dev libad9361-dev librtaudio-dev libzstd-dev \
  libhackrf-dev

WORKDIR /root
RUN git clone https://github.com/pothosware/SoapySDR && \
  cd SoapySDR && \
  mkdir build && \
  cd build && \
  cmake ../ -DCMAKE_INSTALL_PREFIX=/usr && \
  make -j $(nproc) && \
  make install

WORKDIR /root
RUN git clone https://github.com/szpajder/libacars.git && \
  cd libacars && \
  mkdir build && \
  cd build && \
  cmake ../ -DCMAKE_INSTALL_PREFIX=/usr && \
  make -j $(nproc) && \
  make install

WORKDIR /root
RUN git clone https://github.com/TLeconte/acarsdec.git && \
  cd acarsdec && \
  mkdir build && \
  cd build && \
  cmake ../ -Drtl=ON -DCMAKE_INSTALL_PREFIX=/usr && \
  make -j $(nproc) && \
  make install

WORKDIR /root
RUN git clone https://github.com/szpajder/dumpvdl2.git && \
  cd dumpvdl2 && \
  mkdir build && \
  cd build && \
  cmake ../ -DCMAKE_INSTALL_PREFIX=/usr && \
  make -j $(nproc) && \
  make install

WORKDIR /root
RUN git clone https://github.com/airspy/airspyhf.git && \
  cd airspyhf && \
  mkdir build && \
  cd build && \
  cmake ../ -DCMAKE_INSTALL_PREFIX=/usr && \
  make -j $(nproc) && \
  make install

WORKDIR /root
RUN git clone https://github.com/pothosware/SoapyAirspyHF.git && \
  cd SoapyAirspyHF && \
  mkdir build && \
  cd build && \
  cmake ../ -DCMAKE_INSTALL_PREFIX=/usr && \
  make -j $(nproc) && \
  make install

WORKDIR /root
RUN git clone https://github.com/szpajder/dumphfdl.git && \
  cd dumphfdl && \
  mkdir build && \
  cd build && \
  cmake ../ -DCMAKE_INSTALL_PREFIX=/usr && \
  make -j $(nproc) && \
  make install

WORKDIR /root
RUN git clone https://github.com/emqx/qmqtt.git && \
  cd qmqtt && \
  qmake && \
  make -j $(nproc) && \
  make install

WORKDIR /root
RUN git clone https://github.com/quiet/libcorrect && \
  cd libcorrect && \
  mkdir build && \
  cd build && \
  cmake ../ -DCMAKE_INSTALL_PREFIX=/usr && \
  make -j $(nproc) && \
  make install

WORKDIR /root
RUN git clone https://github.com/jontio/libaeroambe && \
  cd libaeroambe/mbelib-master && \
  mkdir build && \
  cd build && \
  cmake ../ -DCMAKE_POSITION_INDEPENDENT_CODE=ON && \
  make -j $(nproc) && \
  rm *.so* && \
  cd ../../libaeroambe && \
  sed -i 's/\$\$\[QT_INSTALL_HEADERS\]/\/usr\/include/g' libaeroambe.pro && \
  sed -i 's/\$\$\[QT_INSTALL_LIBS\]/\/usr\/lib\//g' libaeroambe.pro && \
  echo 'linux: LIBS += -L$$MBELIB_PATH/build/' >> libaeroambe.pro && \
  echo "" >> libaeroambe.pro && \
  qmake && \
  make -j $(nproc) && \
  make install

WORKDIR /root
RUN git clone https://github.com/jontio/JFFT && \
  git clone https://github.com/jontio/JAERO && \
  cd JAERO/JAERO && \
  qmake CONFIG-="CI" && \
  make -j $(nproc) && \
  make install && \
  convert /opt/jaero/jaero.ico /opt/jaero/jaero.png && \
  sed -i 's/\/opt\/jaero\/JAERO/JAERO/g' /usr/share/applications/JAERO.desktop && \
  sed -i 's/\/opt\/jaero\/jaero.ico/jaero/g' /usr/share/applications/JAERO.desktop

WORKDIR /root
RUN git clone https://github.com/jeroenbeijer/SDRReceiver && \
  cd SDRReceiver && \
  sed -i 's/\/opt\/sdrreceiver/\/usr/g' SDRReceiver.pro && \
  sed -i 's/\/opt\/$${TARGET}\/bin/\/usr\/bin/g' SDRReceiver.pro && \
  qmake CONFIG-="CI" && \
  make -j $(nproc) && \
  make install

WORKDIR /root
RUN git clone https://github.com/airspy/airspyone_host.git && \
  cd airspyone_host && \
  mkdir build && \
  cd build && \
  cmake ../ -DCMAKE_INSTALL_PREFIX=/usr && \
  make -j $(nproc) && \
  make install

WORKDIR /root
RUN git clone https://github.com/AlexandreRouma/SDRPlusPlus && \
  cd SDRPlusPlus && \
  mkdir build && \
  cd build && \
  cmake ../ -DCMAKE_INSTALL_PREFIX=/usr && \
  make -j $(nproc) && \
  make install && \
  sed -i 's/\/usr\/bin\/sdrpp/sdrpp/g' /usr/share/applications/sdrpp.desktop && \
  sed -i 's/\/usr\/share\/sdrpp\/icons\/sdrpp.png/sdrpp/g' /usr/share/applications/sdrpp.desktop

WORKDIR /root
RUN wget https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage && \
  wget https://github.com/linuxdeploy/linuxdeploy-plugin-qt/releases/download/continuous/linuxdeploy-plugin-qt-x86_64.AppImage && \
  mkdir bin && \
  mv linuxdeploy-plugin-qt-x86_64.AppImage bin/ && \
  mv linuxdeploy-x86_64.AppImage /usr/local/bin && \
  chmod +x /usr/local/bin/linuxdeploy-x86_64.AppImage && \
  chmod +x /root/bin/linuxdeploy-plugin-qt-x86_64.AppImage

WORKDIR /root
RUN touch acarsdec.svg && \
  linuxdeploy-x86_64.AppImage --appimage-extract-and-run --appdir acarsdecAppDir -e /usr/bin/acarsdec --create-desktop-file -i acarsdec.svg --output appimage

RUN touch dumpvdl2.svg && \
  linuxdeploy-x86_64.AppImage --appimage-extract-and-run --appdir dumpvdl2AppDir -e /usr/bin/dumpvdl2 --create-desktop-file -i dumpvdl2.svg --output appimage

RUN touch dumphfdl.svg && \
  linuxdeploy-x86_64.AppImage --appimage-extract-and-run --appdir dumphfdlAppDir -e /usr/bin/dumphfdl --create-desktop-file -i dumphfdl.svg --output appimage

RUN linuxdeploy-x86_64.AppImage --appimage-extract-and-run --appdir jaeroAppDir -e /opt/jaero/JAERO -d /usr/share/applications/JAERO.desktop -i /opt/jaero/jaero.png --output appimage && \
  /root/bin/linuxdeploy-plugin-qt-x86_64.AppImage --appimage-extract-and-run --appdir jaeroAppDir && \
  linuxdeploy-x86_64.AppImage --appimage-extract-and-run --appdir jaeroAppDir -e /opt/jaero/JAERO -d /usr/share/applications/JAERO.desktop -i /opt/jaero/jaero.png --output appimage

RUN touch SDRReceiver.svg && \
  linuxdeploy-x86_64.AppImage --appimage-extract-and-run --appdir sdrRecvAppDir -e /usr/bin/SDRReceiver --create-desktop-file -i SDRReceiver.svg --output appimage && \
  /root/bin/linuxdeploy-plugin-qt-x86_64.AppImage --appimage-extract-and-run --appdir sdrRecvAppDir && \
  linuxdeploy-x86_64.AppImage --appimage-extract-and-run --appdir sdrRecvAppDir -e /usr/bin/SDRReceiver --create-desktop-file -i SDRReceiver.svg --output appimage

RUN linuxdeploy-x86_64.AppImage --appimage-extract-and-run --appdir sdrppAppDir -e /usr/bin/sdrpp -d /usr/share/applications/sdrpp.desktop -i /usr/share/sdrpp/icons/sdrpp.png --output appimage

WORKDIR /
COPY common/entrypoint.sh /
RUN chmod +x /entrypoint.sh

