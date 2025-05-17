# Use Ubuntu 20.04 as base image for x86_64
FROM --platform=linux/amd64 ubuntu:20.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    ca-certificates \
    ca-certificates-java\
    openjdk-8-jre-headless \
    xvfb \
    libxcb1 \
    libx11-6 \
    lib32z1 \
    lib32ncurses6 \
    libc6-i386 \
    libstdc++6 \
    && rm -rf /var/lib/apt/lists/*

# Create interbase user
RUN useradd -m -s /bin/bash interbase

# Set working directory
WORKDIR /opt/interbase

# Copy InterBase installation files
COPY resources/InterBase_2020_Linux/ib_install_linux_x86_64.bin ./
COPY resources/InterBase_2020_Linux/install_linux_x86_64.sh ./

# Make installation scripts executable
RUN chmod +x install_linux_x86_64.sh ib_install_linux_x86_64.bin

# Set environment variables
ENV PATH=$PATH:/opt/interbase/bin
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib
ENV LIBXCB_ALLOW_SLOPPY_LOCK=1

# Install InterBase using console mode with Xvfb
RUN ./install_linux_x86_64.sh -i console || \
    echo "Installation attempted - check logs for details" && \
    pkill Xvfb || true

# Expose InterBase default port
EXPOSE 3050

# Create startup script
RUN echo '#!/bin/bash\n\
# Check if InterBase is installed\n\
if [ -d "/opt/interbase/bin" ]; then\n\
    echo "Starting InterBase server..."\n\
    /opt/interbase/bin/ibmgr -start -forever || echo "Failed to start InterBase"\n\
else\n\
    echo "InterBase not found at /opt/interbase/bin"\n\
fi\n\
# Keep container running\n\
tail -f /dev/null' > /start.sh && \
    chmod +x /start.sh

# Set the startup command
CMD ["/start.sh"]