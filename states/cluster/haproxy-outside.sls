include:
  - haproxy.install

haproxy-service:
  file.managed:
    - name: /etc/haproxy/haproxy.cfg
    - source: salt://cluster/files/haproxy-outside.cfg
    - user: root
    - group: root
    - mode: 644

  cmd.run:
    - name: mkdir -p /usr/local/haproxy/logs && mkdir -p /var/lib/haproxy
    - unless: test -d /usr/local/haproxy/logs 
    - require:
      - file: haproxy-service

  service.running:
    - name: haproxy
    - enable: True
    - reload: True
    - require:
      - cmd: haproxy-init
    - watch:
      - file: haproxy-service
