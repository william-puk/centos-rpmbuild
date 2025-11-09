# Start from the latest CentOS Stream container image
FROM quay.io/centos/centos:stream9

# Install rpmbuild and common RPM build tooling
# - rpm-build: provides rpmbuild
# - rpmdevtools: convenient helpers like rpmdev-setuptree
# - dnf-plugins-core: provides `dnf builddep` for resolving BuildRequires
# - git, make, gcc, tar: common build tools (adjust as needed)
RUN dnf -y update && \
    dnf -y install \
        rpm-build \
        rpmdevtools \
        dnf-plugins-core \
        rpmlint \
        make \
        gcc \
        git \
        tar \
        which \
    && dnf clean all

# Create a non-root user for building (safer than root builds)
ARG UID=1000
ARG GID=1000
RUN groupadd -g ${GID} builder && \
    useradd -m -u ${UID} -g ${GID} -s /bin/bash builder

USER builder
WORKDIR /home/builder

# Set up the standard RPM build tree under ~/rpmbuild
RUN rpmdev-setuptree

# Default workdir for dropping in SPECS and SOURCES
WORKDIR /home/builder/rpmbuild

# Example entrypoint prints rpmbuild version to verify environment
CMD ["rpmbuild", "--version"]
