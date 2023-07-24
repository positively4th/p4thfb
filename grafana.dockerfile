FROM grafana/grafana-enterprise:latest

ADD p4thfb_api/grafana.provisioning/dashboards/* /etc/grafana/provisioning/dashboards/
ADD p4thfb_api/grafana.provisioning/datasources/* /etc/grafana/provisioning/datasources/
