FROM continuumio/miniconda3

MAINTAINER Maria Firulyova <mmfiruleva@gmail.com>

RUN apt-get update && \
    apt-get install -y libfftw3-double3 uuid-runtime && \
    wget https://cf.10xgenomics.com/misc/bamtofastq-1.2.0 && \
    chmod 700 bamtofastq-1.2.0 && \
    mv bamtofastq-1.2.0 /usr/bin/ && \
    conda install -c conda-forge -c bioconda fit-sne=1.1.0 parallel-fastq-dump=0.6.6

RUN mkdir -p /home/.ncbi && \
    mkdir -p /home/ncbi && \
    mkdir -p /home/sra && \
    printf '/LIBS/GUID = "%s"\n' `uuidgen` > /root/.ncbi/user-settings.mkfg && \
    printf '/libs/cloud/report_instance_identity = "true"\n' >> /root/.ncbi/user-settings.mkfg && \
    printf '/repository/user/ad/public/root = "."\n' >> /root/.ncbi/user-settings.mkfg && \
    printf '/repository/user/default-path = "/home/ncbi"\n' >> /root/.ncbi/user-settings.mkfg && \
    printf '/repository/user/main/public/root = "/home/sra"\n' >> /root/.ncbi/user-settings.mkfg

ENV PATH /usr/bin/bamtofastq-1.2.0:$PATH

ENV TINI_VERSION v0.16.1
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]
