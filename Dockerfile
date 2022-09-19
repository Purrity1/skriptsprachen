FROM jupyter/base-notebook

USER root

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update --yes && \
    apt-get upgrade --yes && \
    apt-get install --yes --no-install-recommends \
    git && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    echo "de_DE.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

# Install nbgrader
RUN pip3 install nbgrader

# Add any other dependencies you might want, e.g. numpy, scipy, etc.
#RUN pip3 install numpy scipy matplotlib scikit-learn pandas 

# Configure grader user
RUN useradd -m grader
RUN chown -R grader:grader /home/grader
USER grader

VOLUME /assignments

# Where the assignments will live (these need to be mounted on runtime)
WORKDIR /assignments

ENTRYPOINT ["tini", "--", "nbgrader"]
