FROM mageai/mageai:latest

ARG PIP=pip3

# Add Debian Bullseye repository
RUN echo 'deb http://deb.debian.org/debian bullseye main' > /etc/apt/sources.list.d/bullseye.list

# Install OpenJDK 11
RUN apt-get update -y && \
    apt-get install -y openjdk-11-jdk

# Remove Debian Bullseye repository
RUN rm /etc/apt/sources.list.d/bullseye.list

# Install PySpark
RUN ${PIP} install pyspark

# Set Java and Spark environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV SPARK_HOME=/usr/local/spark
ENV PATH=$PATH:$SPARK_HOME/bin
ENV PYSPARK_DRIVER_PYTHON=jupyter
ENV PYSPARK_DRIVER_PYTHON_OPTS='notebook'

# Set the Mage data directory (modify according to your needs)
ENV MAGE_DATA_DIR=/path/to/your/mage/data

# Expose Jupyter port
EXPOSE 8888

# Command to run Mage AI (modify if you have a specific startup command for Mage)
CMD ["mage", "start"]
