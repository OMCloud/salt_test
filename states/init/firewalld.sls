firewall-stop:
  service.dead:
    - name: firewalld.service
    - enable: False
