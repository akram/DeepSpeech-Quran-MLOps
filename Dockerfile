FROM tensorflow:2023.2
# tensorflow

# Copying custom packages
COPY requirements.txt ./

USER 0
# Install packages and cleanup
# (all commands are chained to minimize layer size)
RUN echo "Installing softwares and packages" && \
    # Install Python packages \
    micropipenv install && \
    rm -f ./requirements.txt

# Fix permissions to support pip in OpenShift environments \
RUN chmod -R g+w /opt/app-root/lib/python3.9/site-packages && \
    fix-permissions /opt/app-root -P

WORKDIR /opt/app-root/src
USER 1001

ENTRYPOINT ["start-notebook.sh"]

