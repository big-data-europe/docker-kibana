FROM kibana:5.5
MAINTAINER esteban.sastre <esteban.sastre@tenforce.com>

ENV KIBANA_PLUGINS /usr/share/kibana/plugins

WORKDIR /bin
RUN kibana-plugin install https://github.com/prelert/kibana-swimlane-vis/releases/download/v5.5.0/prelert_swimlane_vis-5.5.0.zip && \
    kibana-plugin install https://github.com/PhaedrusTheGreek/transform_vis/releases/download/5.5.0/transform_vis-5.5.0.zip

WORKDIR $KIBANA_PLUGINS
RUN apt-get update && apt-get install -y git npm && \
    git clone https://github.com/dlumbrer/kbn_network.git network_vis && cd network_vis && git checkout tags/5.5.X && rm -rf images/ && npm install && \
    git clone https://github.com/dlumbrer/kbn_searchtables kbn_searchtables && cd kbn_searchtables && sed -i "s/5\..\.0/5\.5\.0/g" package.json && npm install
# RUN git clone https://github.com/mstoyano/kbn_c3js_vis.git c3_charts && cd c3_charts && npm install
