FROM centos:7

# Install rpmbuild and common helpers/tools
# - rpm-build: provides rpmbuild
# - rpmdevtools: helpers like rpmdev-setuptree, spectool
# - redhat-rpm-config: macros commonly required by spec files
# - yum-utils: provides yum-builddep for BuildRequires resolution
# - gcc, make, git, tar, which: typical build tools (adjust as needed)
RUN yum -y update && \
    yum -y install \
        rpm-build \
        rpmdevtools \
        redhat-rpm-config \
        yum-utils \
        rpmlint \
        gcc \
        make \
        git \
        tar \
        which \
    && yum clean all

# Use root as requested and set up the default rpmbuild tree in /root
RUN rpmdev-setuptree

# Default workdir where SPECS and SOURCES live
WORKDIR /root/rpmbuild
