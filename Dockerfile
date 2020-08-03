FROM continuumio/miniconda3

MAINTAINER Maria Firulyova <mmfiruleva@gmail.com>

RUN apt-get update && \
    apt-get install -y libfftw3-double3 uuid-runtime && \
    wget https://cf.10xgenomics.com/misc/bamtofastq-1.2.0 && \
    chmod 700 bamtofastq-1.2.0 && \
    mv bamtofastq-1.2.0 /usr/bin/ && \
    conda install -c conda-forge fit-sne=1.1.0 && \
    mkdir -p /home/.ncbi && \
    printf '/LIBS/GUID = "%s"\n' `uuidgen` > /home/.ncbi/user-settings.mkfg

ENV PATH /usr/bin/bamtofastq-1.2.0:$PATH

ENV TINI_VERSION v0.16.1
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]
