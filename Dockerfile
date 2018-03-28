FROM ros:kinetic-ros-base

RUN apt-get update && apt-get install -y \
    python-pip git cmake\
    && rm -rf /var/lib/apt/lists/
    
RUN pip install --upgrade pip
RUN pip install jupyter

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
WORKDIR ${HOME}/Notebooks

CMD ["jupyter", "notebook"]
