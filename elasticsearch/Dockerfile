# --------------------------------------------------------------------------------
# Docker configuration for ElasticSearch
# --------------------------------------------------------------------------------

# Make sure helix-plugin-filter exists for the exact Elasticsearch version
FROM docker.elastic.co/elasticsearch/elasticsearch:8.19.13

USER root
RUN apt-get update && apt-get install -y wget gnupg
RUN wget -qO - https://package.perforce.com/perforce.pubkey | apt-key add -
RUN echo "deb [arch=amd64] https://package.perforce.com/apt/ubuntu noble release" > /etc/apt/sources.list.d/perforce.list
RUN apt-get update && apt-get install -y helix-plugin-filter=2026.1*

USER elasticsearch
