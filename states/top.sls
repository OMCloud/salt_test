base:
  '*':
    - init.env_init

prod:
  'node2':
    - cluster.haproxy-outside
