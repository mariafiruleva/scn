FROM continuumio/miniconda3

MAINTAINER Maria Firulyova <mmfiruleva@gmail.com>

RUN wget https://cf.10xgenomics.com/misc/bamtofastq-1.2.0 && \
    chmod 700 bamtofastq-1.2.0 && \
    mv bamtofastq-1.2.0 /usr/bin/ && \
    conda install -c conda-forge fit-sne

ENV PATH /usr/bin/bamtofastq-1.2.0:$PATH

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]
