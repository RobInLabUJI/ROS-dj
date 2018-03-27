FROM ros:kinetic-ros-base

# install jupyter

RUN apt-get update && apt-get install -y \
    python-pip wget cmake\
    && rm -rf /var/lib/apt/lists/
    
RUN pip install --upgrade pip
RUN pip install jupyter

RUN mkdir -p ~/builds && cd ~/builds && \
    wget https://root.cern.ch/download/cling/cling_2017-04-15_sources.tar.bz2 && \
    tar jxf cling_2017-04-15_sources.tar.bz2 && \
    mv src cling_2017-04-15 && \
    mkdir -p ~/builds/cling_2017-04-15/build && \
    cd ~/builds/cling_2017-04-15/build && \
    cmake -DCMAKE_BUILD_TYPE=Release ../ && \
    make -j4 && \
    make install && \
    ldconfig && \
    cd /usr/local/share/cling/Jupyter/kernel && \
    pip install -e . && \
    jupyter kernelspec install cling-cpp11

EXPOSE 8888
ENV NB_USER user
ENV NB_UID 1000
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}

USER ${NB_USER}
WORKDIR ${HOME}

CMD ["jupyter", "notebook", "--ip=0.0.0.0"]
