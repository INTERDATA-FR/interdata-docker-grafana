ARG	UBUNTU_IMAGE
FROM	${UBUNTU_IMAGE}

MAINTAINER Thibault CHEVALLERAUD <tchevalleraud@interdata.fr>

RUN	apt-get -y update && \
	apt-get -y upgrade

RUN	apt-get -y install adduser build-essential curl libfontconfig wget

ARG	GRAFANA_IMAGE
RUN	wget https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana_${GRAFANA_IMAGE}_amd64.deb

RUN	dpkg -i grafana_${GRAFANA_IMAGE}_amd64.deb

WORKDIR /

ADD	config/script.init.sh /usr/bin/script.init.sh
RUN	chmod 755 /usr/bin/script.init.sh

ADD	config/img/grafana_icon.svg /usr/share/grafana/public/img/grafana_icon.svg
ADD	config/img/grafana_typelogo.svg /usr/share/grafana/public/img/grafana_typelogo.svg
ADD	config/img/heatmap_bg_test.svg /usr/share/grafana/public/img/heatmap_bg_test.svg

EXPOSE  3000

ENTRYPOINT ["/usr/bin/script.init.sh"]
