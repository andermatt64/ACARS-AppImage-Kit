FROM archlinux:base AS stage1

RUN pacman -Syu --noconfirm && \
  pacman -S --noconfirm git base-devel wget cmake libsndfile rtl-sdr soapysdr liquid-dsp liquid-dsp-sse4.1 fftw libconfig

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
RUN wget https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage && \
  mv linuxdeploy-x86_64.AppImage /usr/local/bin && \
  chmod +x /usr/local/bin/linuxdeploy-x86_64.AppImage

WORKDIR /root
RUN touch acarsdec.svg && \
  linuxdeploy-x86_64.AppImage --appimage-extract-and-run --appdir acarsdecAppDir -e /usr/bin/acarsdec --create-desktop-file -i acarsdec.svg --output appimage
RUN touch dumpvdl2.svg && \
  linuxdeploy-x86_64.AppImage --appimage-extract-and-run --appdir dumpvdl2AppDir -e /usr/bin/dumpvdl2 --create-desktop-file -i dumpvdl2.svg --output appimage
RUN touch dumphfdl.svg && \
  linuxdeploy-x86_64.AppImage --appimage-extract-and-run --appdir dumphfdlAppDir -e /usr/bin/dumphfdl --create-desktop-file -i dumphfdl.svg --output appimage

WORKDIR /
COPY builder/entrypoint.sh /
RUN chmod +x /entrypoint.sh

