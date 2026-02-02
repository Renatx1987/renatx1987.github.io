# frozen_string_literal: true
# encoding: utf-8

require 'erb'
require 'fileutils'

# Create public directory
FileUtils.mkdir_p('public')

# Copy CSS
FileUtils.cp('app/assets/stylesheets/application.css', 'public/application.css')

# Helper methods
def link_to(text, url = nil, options = {})
  if block_given?
    options = url || {}
    url = text
    text = yield
  end
  target = options[:target] ? %( target="#{options[:target]}") : ''
  rel = options[:rel] ? %( rel="#{options[:rel]}") : ''
  css_class = options[:class] ? %( class="#{options[:class]}") : ''
  %(<a href="#{url}"#{css_class}#{target}#{rel}>#{text}</a>)
end

def content_for(name)
  nil
end

def csrf_meta_tags
  ''
end

def csp_meta_tag
  ''
end

def stylesheet_link_tag(*_args)
  '<link rel="stylesheet" href="application.css">'
end

def javascript_importmap_tags
  ''
end

def render(partial, locals = {})
  path = partial.to_s
  path = path.gsub('pages/', 'app/views/pages/').gsub('shared/', 'app/views/shared/')

  if path.include?('/')
    parts = path.split('/')
    parts[-1] = "_#{parts[-1]}"
    path = parts.join('/')
  else
    path = "app/views/#{path}"
  end

  path += '.html.erb' unless path.end_with?('.erb')

  template = File.read(path, encoding: 'UTF-8')
  b = binding
  locals.each { |k, v| b.local_variable_set(k, v) }
  ERB.new(template, trim_mode: '-').result(b)
end

class Time
  def self.current
    Time.now
  end
end

# Data
@problems = [
  { title: '«Застрял и не двигаюсь»', description: 'Есть ощущение, что иду не туда. Работа не радует, но что делать дальше — непонятно. Хочется перемен, но страшно.' },
  { title: '«Хаос в голове и делах»', description: 'Задач много, всё срочное и важное. Чувствую себя белкой в колесе. Дела делаются, но результата нет.' },
  { title: '«Не могу довести до конца»', description: 'Есть проект мечты — книга, курс, бизнес-идея. Начинаю и бросаю. Уже несколько лет «вот-вот начну».' }
]

@steps = [
  { number: '01', title: 'Разбираемся', description: 'На диагностике понимаем, что именно застряло и почему. Без этого любые советы — в молоко.' },
  { number: '02', title: 'Планируем', description: 'Превращаем «хочу» в конкретные шаги с дедлайнами. Декомпозиция — моя суперсила после 15 лет в управлении проектами.' },
  { number: '03', title: 'Делаем', description: 'Регулярные встречи, отчётность, поддержка. Я — тот, кто не даст слиться и поможет пройти сложные участки.' }
]

@services = [
  { badge: 'Старт', title: 'Разовая консультация', description: 'Разберём конкретную ситуацию, наметим план действий. Подходит, если нужен взгляд со стороны.', features: ['60 минут работы', 'Запись встречи', 'Краткое резюме с шагами'], price: '3 000 ₽' },
  { badge: 'Оптимум', title: 'Пакет сессий', description: 'Глубокая работа над задачей: карьерный переход, запуск проекта, выстраивание системы.', features: ['4–8 встреч по 60 минут', 'Поддержка в чате между встречами', 'Персональный план действий'], price: 'По запросу' },
  { badge: 'Максимум', title: 'Трекинг 3 месяца', description: 'Полноценное сопровождение до результата. Для тех, кому нужен надёжный партнёр на дистанции.', features: ['Еженедельные встречи', 'Ежедневная поддержка в чате', 'Система трекинга прогресса'], price: 'По запросу' }
]

@credentials = ['PwC', 'Яндекс', 'МТС', 'Т-Банк']

# Render home content
home_template = File.read('app/views/pages/home.html.erb', encoding: 'UTF-8')
home_content = ERB.new(home_template, trim_mode: '-').result(binding)

# Render layout - replace yield placeholder manually
layout_template = File.read('app/views/layouts/application.html.erb', encoding: 'UTF-8')

# Replace ERB yield with actual content
layout_template = layout_template.gsub('<%= yield %>', '{{CONTENT_PLACEHOLDER}}')

# Process the rest of the layout ERB
html = ERB.new(layout_template, trim_mode: '-').result(binding)

# Insert home content
html = html.gsub('{{CONTENT_PLACEHOLDER}}', home_content)

# Write output
File.write('public/index.html', html, encoding: 'UTF-8')

puts "Generated public/index.html"
