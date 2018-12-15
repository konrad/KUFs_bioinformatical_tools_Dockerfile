FROM ubuntu:18.10

MAINTAINER Konrad Förstner <konrad@foerstner.org>

LABEL description="A collection of bioinformatical tools (by Konrad Förstner)"

RUN apt-get clean all \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
	 bzip2 \
	 curl \
	 gzip \
	 parallel \	 
	 pbzip2 \
	 xz-utils \
         wget

# Conda
RUN  wget -P /tmp https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
     && /bin/bash /tmp/Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda \
     && rm /tmp/Miniconda3-latest-Linux-x86_64.sh \
     && export PATH=/opt/conda/bin:${PATH} \
     && conda config --add channels r \
     && conda config --add channels bioconda \
     && conda config --add channels biobuilds \
     && conda config --add channels biocore \
     && conda upgrade conda \
     && conda install \
	  bedtools \
	  bioconductor-deseq2 \
	  blast-plus \
	  bwa \
	  circos \
	  emboss \
	  fastqc \
	  fastx-toolkit \
	  gatk4 \
	  kallisto \
	  minialign \
	  samtools \
	  segemehl \
	  sra-tools \
	  star \
	  ucsc-wigtobigwig

ENV PATH=/opt/conda/bin:${PATH}

RUN pip install cutadapt reademption

RUN mkdir /data
WORKDIR /data

CMD ["/bin/bash"]
