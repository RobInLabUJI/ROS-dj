FROM ros:kinetic-ros-base

# install jupyter

RUN apt-get update && apt-get install -y \
    python-pip git cmake\
    && rm -rf /var/lib/apt/lists/
    
RUN pip install --upgrade pip
RUN pip install jupyter

RUN git clone http://root.cern.ch/git/llvm.git src && \
    cd src && \
    git checkout cling-patches && \
    cd tools && \
    git clone http://root.cern.ch/git/cling.git && \
    git clone http://root.cern.ch/git/clang.git && \
    cd clang && \
    git checkout cling-patches && \
    cd ../.. && \
    mkdir build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_BUILD_TYPE=Release ..\src && \
    cmake --build . && \
    cmake --build . --target install && \
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
