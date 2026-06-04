# Guía de Desarrollo Local (Jekyll)

Esta guía detalla el flujo de trabajo para configurar y ejecutar localmente el sitio web de Hypenosys (`hypenosys.github.io`). El sitio utiliza **Jekyll**, un generador de sitios estáticos basado en Ruby, y está configurado para ser compatible con GitHub Pages.

## 1. Prerrequisitos

Antes de empezar, asegúrate de tener instalado lo siguiente:

- **Ruby 2.5.0** o superior (puedes comprobarlo con `ruby -v`).
- **RubyGems** (incluido con Ruby).
- **GCC y Make** (necesarios para compilar extensiones nativas de gemas).
- **Bundler** (instálalo con `gem install bundler`).
- **Jekyll** (gestionado a través de Bundler, no se instala globalmente).

## 2. Instalación por Sistema Operativo

### GNU/Linux (Debian/Ubuntu)

```bash
sudo apt-get update -y
sudo apt-get install -y make gcc ruby-full build-essential zlib1g-dev

# Configurar el path de instalación de Ruby Gems
echo '# Ruby Gems installation path' >> ~/.bashrc
echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

gem install jekyll bundler
```

### macOS

```bash
brew install ruby
echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc
gem install jekyll bundler
```

### Windows (vía RubyInstaller)

1. Descarga e instala **Ruby+Devkit** desde [rubyinstaller.org](https://rubyinstaller.org/).
2. Ejecuta `ridk install` al finalizar la instalación para configurar el entorno de desarrollo.
3. En una terminal, ejecuta: `gem install jekyll bundler`.

## 3. Clonación y Configuración del Proyecto

Clona el repositorio del sitio web y prepara el entorno:

```bash
git clone https://github.com/hypenosys/hypenosys.github.io.git
cd hypenosys.github.io
bundle install
```

> [!NOTE]
> El comando `bundle install` lee el archivo `Gemfile` e instala todas las dependencias necesarias, incluyendo la versión exacta de Jekyll utilizada por GitHub Pages.

## 4. Ejecución del Servidor Local

Para previsualizar el sitio en tu máquina:

```bash
bundle exec jekyll serve
```

- **Importante:** Usa siempre `bundle exec` para asegurar que se usen las versiones de las gemas gestionadas por Bundler.
- **Previsualización:** Accede a `http://localhost:4000`.
- **Auto-regeneración:** El servidor detecta cambios en los archivos y reconstruye el sitio automáticamente.

## 5. Servir con anulación de baseurl

Si el archivo `_config.yml` tiene un `baseurl` configurado (ej. para subdirectorios), los enlaces podrían no funcionar correctamente en localhost. Para solucionar esto, ejecuta:

```bash
bundle exec jekyll serve --baseurl ""
```

## 6. Live Reload (Opcional)

Para que el navegador se refresque automáticamente al guardar cambios:

```bash
bundle exec jekyll serve --livereload
```

## 7. Resolución de Problemas Comunes

### Error: webrick missing (Ruby 3.0+)
Ruby 3.0 eliminó `webrick` de su librería estándar. Si obtienes un error relacionado, añádela manualmente:

```bash
bundle add webrick
bundle exec jekyll serve
```

### Conflictos en Gemfile.lock tras un pull
Si al bajar cambios el archivo `Gemfile.lock` ha cambiado, ejecuta siempre:

```bash
bundle install
```

## 8. Referencia del Gemfile

El proyecto debe incluir al menos estas dependencias en su `Gemfile`:

```ruby
source 'https://rubygems.org'

gem 'github-pages', group: :jekyll_plugins
gem 'webrick'

# Compatibilidad con Windows
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'wdm', '>= 0.1.0' if Gem.win_platform?
```

## 9. Entradas recomendadas para .gitignore

Asegúrate de que estos archivos/directorios no se suban al repositorio:

```text
_site/
.jekyll-cache/
.jekyll-metadata
Gemfile.lock
vendor/
```

## 10. Resumen de Comandos Útiles

| Comando | Propósito |
|---|---|
| `bundle install` | Instalar todas las dependencias (gemas) |
| `bundle exec jekyll serve` | Iniciar servidor local en localhost:4000 |
| `bundle exec jekyll serve --baseurl ""` | Iniciar servidor ignorando el baseurl |
| `bundle exec jekyll serve --livereload` | Iniciar con auto-refresco de navegador |
| `bundle exec jekyll build` | Construir el sitio en `_site/` sin servirlo |
| `bundle add webrick` | Solucionar error de webrick en Ruby 3.0+ |
| `bundle update github-pages` | Actualizar gemas para coincidir con GitHub Pages |

---
**Vínculos:**
- [[Web-hypenosys.github.io|Informe del Repositorio Web]]
- [[00-Inicio/README|Inicio del Vault]]
- [Documentación oficial de GitHub Pages + Jekyll](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/testing-your-github-pages-site-locally-with-jekyll)
