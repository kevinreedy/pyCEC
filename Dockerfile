FROM python:3.7

RUN apt-get update
RUN apt-get install -y cmake libudev-dev libxrandr-dev python3-dev swig git

RUN mkdir -p /tmp/Pulse-Eight
WORKDIR /tmp/Pulse-Eight

RUN git clone https://github.com/Pulse-Eight/platform.git
RUN mkdir platform/build
WORKDIR /tmp/Pulse-Eight/platform/build
RUN cmake ..
RUN make
RUN make install

WORKDIR /tmp/Pulse-Eight
RUN git clone https://github.com/Pulse-Eight/libcec.git
RUN mkdir libcec/buid
WORKDIR /tmp/Pulse-Eight/libcec/build
RUN cmake -DRPI_INCLUDE_DIR=/opt/vc/include -DRPI_LIB_DIR=/opt/vc/lib ..
RUN make -j4
RUN make install
RUN ldconfig

ENV PYTHONPATH=/usr/local/lib/python3.7/dist-packages

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN /usr/local/bin/pip install --no-cache-dir -r requirements.txt

CMD ["python", "-m", "pycec"]
