<div class="sidebar__header">
  <h1 class="sidebar__title">
    {% if package.homepage %}
      <a href="{{ package.homepage }}">{{ project_title }}{% if package.version %} - v{{ package.version }}{% endif %}</a>
    {% else %}
      {{ project_title }}
      {% if package.version %}<span class="sidebar__version">Version {{ package.version }}</span>{% endif %}
    {% endif %}
  </h1>
</div>

<div class="sidebar__body">
  {# No item documented #}
  {% if data.length == 0 %}
    <p class="sidebar__item  sidebar__item--heading">No documented item.</p>

  {# Some items documented #}
  {% else %}
    <button type="button" class="btn-toggle  js-btn-toggle" data-alt="Open all">Close all</button>

    {# Loop over the groups #}
    {% for group_name, group in data.byGroupAndType %}
      <p class="sidebar__item  sidebar__item--heading" data-slug="{{ group_name }}"><a href="#{{ group_name }}">{{ groups[group_name] | capitalize }}</a></p>

      {# Loop over the types #}
      {% for type, items in group %}
        {% if loop.first %}<div class="sidebar__group">{% endif %}

        {# If items to be displayed in type #}
        {% if items.length > 0 %}

          {# Loop over the items #}
          {% for item in items %}
            {% if loop.first %}
            <h4 class="sidebar__group--title title-{{ item.context.type }}">{{ groups[group_name] | capitalize }} {% if item.context.type == "css" %}{{ item.context.type | upper }} classes{% else %}{{ item.context.type + 's' }}{% endif %}</h4>
            <ul class="list-unstyled list-{{ item.context.type }}">
            {% endif %}
            <li class="sidebar__item  sassdoc__item" data-group="{{ group_name }}" data-name="{{ item.context.name }}" data-type="{{ item.context.type }}">
              <a href="#{{ group_name }}-{{ item.context.type }}-{{ item.context.name }}">
                {% if item.context.type == "placeholder" %}
                  %{{ item.context.name }}
                {% elseif item.context.type == "variable" %}
                  ${{ item.context.name }}
                {% elseif item.context.type == "mixin" %}
                  @include {{ item.context.name }}
                {% else %}
                  {{ item.context.name }}
                {% endif %}
              {% if item.access[0] == "private" %}<span class="sidebar__annotation  sidebar__annotation--private">private</span>{% endif %}
              {% if item.alias != false %}<span class="sidebar__annotation  sidebar__annotation--alias">alias</span>{% endif %}
              </a>
            </li>
            {% if loop.last %}</ul>{% endif %}
          {% endfor %}
        {% endif %}
        {% if loop.last %}</div>{% endif %}
      {% endfor %}

    {% endfor %}
  {% endif %}
</div>
