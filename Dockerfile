FROM continuumio/miniconda3

MAINTAINER Maria Firulyova <mmfiruleva@gmail.com>

RUN wget https://raw.githubusercontent.com/mariafiruleva/scn/master/environment.yml && \
    conda env update -n base environment.yml && \
    echo "conda activate scn" >> ~/.bashrc && \
    wget https://cf.10xgenomics.com/misc/bamtofastq-1.2.0 && \
    chmod 700 bamtofastq-1.2.0 && \
    mv bamtofastq-1.2.0 /usr/bin/

ENV PATH /usr/bin/bamtofastq-1.2.0:$PATH

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]
