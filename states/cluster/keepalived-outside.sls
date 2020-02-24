include:
  - keepalived.install

keepalived-service:
  file.managed:
    - name: /etc/keepalived/keepalived.conf
    - source: salt://cluster/files/keepalived-outside.conf
    - mode: 644
    - user: root
    - group: root
    - template: jinja
    {% if grains['fqdn'] == 'node2' %}
    - ROUTEID: haproxy_ha
    - STATEID: MASTER
    - PRIORITYID: 100
    {% elif grains['fqdn'] == 'node3' %}
    - ROUTEID: haproxy_ha
    - STATEID: BACKUP
    - PRIORITYID: 60
    {% endif %}

  service.running:
    - name: keepalived
    - enable: True
    - watch:
      - file: keepalived-service
