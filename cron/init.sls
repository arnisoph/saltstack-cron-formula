#!jinja|yaml

{% from 'cron/defaults.yaml' import rawmap_osfam with context %}
{% set datamap = salt['grains.filter_by'](rawmap_osfam, merge=salt['pillar.get']('cron:lookup')) %}

include: {{ datamap.sls_include|default([]) }}
extend: {{ datamap.sls_extend|default({}) }}

{% set jobs = datamap.jobs|default({}) %}
{% if jobs is iterable %}
{% for k, v in jobs|dictsort %}
cron_job_{{ k }}:
  cron:
    - {{ v.ensure|default('present') }}
    - name: {{ v.cmd }}
    - identifier: {{ k }}
    {% if 'special' in v %}
    - special: '{{ v.special }}'
    {% else %}
    - minute: '{{ v.minute|default('*') }}'
    - hour: '{{ v.hour|default('*') }}'
    - daymonth: '{{ v.daymonth|default('*') }}'
    - month: '{{ v.month|default('*') }}'
    - dayweek: '{{ v.dayweek|default('*') }}'
    {% endif %}
  {% if 'user' in v %}
    - user: {{ v.user }}
  {% endif %}
  {% if 'comment' in v %}
    - comment: {{ v.comment }}
  {% endif %}
{% endfor %}
{% endif %}

{% set envs = datamap.envs|default({}) %}
{% if envs is iterable %}
{% for k, v in envs|dictsort %}
cron_env_{{ k }}:
  {% if v.present %}
  cron.env_present:
  {% else %}
  cron.env_absent:
  {% endif %}
    {% if v.name is defined %}
    - name: {{ v.name }}
    {% else %}
    - name: {{ k }}
    {% endif %}
    - value: {{ v.value|default() }}
  {% if 'user' in v %}
    - user: {{ v.user }}
  {% endif %}
{% endfor %}
{% endif %}
