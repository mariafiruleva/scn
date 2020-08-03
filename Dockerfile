FROM continuumio/miniconda3

MAINTAINER Maria Firulyova <mmfiruleva@gmail.com>

RUN apt-get update && \
    apt-get install -y libfftw3-double3 wget libxml-libxml-perl && \
    wget https://cf.10xgenomics.com/misc/bamtofastq-1.2.0 && \
    chmod 700 bamtofastq-1.2.0 && \
    wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.10.0/sratoolkit.2.10.0-ubuntu64.tar.gz -O /tmp/sratoolkit.tar.gz && \
    tar zxvf /tmp/sratoolkit.tar.gz -C /opt/ && rm /tmp/sratoolkit.tar.gz && \
    mv bamtofastq-1.2.0 /usr/bin/ && \
    conda install -c conda-forge fit-sne=1.1.0

ENV PATH /usr/bin/bamtofastq-1.2.0:$PATH
ENV PATH="/opt/sratoolkit.2.10.0-ubuntu64/bin/:${PATH}"

ENV TINI_VERSION v0.16.1
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]
