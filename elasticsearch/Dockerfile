# --------------------------------------------------------------------------------
# Docker configuration for ElasticSearch
# --------------------------------------------------------------------------------

# Make sure p4search-filter exists for the exact Elasticsearch version
FROM docker.elastic.co/elasticsearch/elasticsearch:9.5.2

USER root

RUN rpm --import https://package.perforce.com/perforce.pubkey

RUN printf '%s\n' \
    '[perforce]' \
    'name=Perforce' \
    'baseurl=https://package.perforce.com/yum/rhel/9/x86_64' \
    'enabled=1' \
    'gpgcheck=1' \
    'gpgkey=https://package.perforce.com/perforce.pubkey' \
    > /etc/yum.repos.d/perforce.repo

RUN microdnf install -y dnf && dnf --forcearch=x86_64 install -y p4search-filter-2026.4\*

USER elasticsearch
