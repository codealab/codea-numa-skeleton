# Tutorial Codea | CódigoX

### Crear cuenta en Cloud9
Entra a la página de **[Cloud9](https://c9.io)** y crea una cuenta, seguramente tendrás que activarla en el mail con el que te registraste.

### Crear un nuevo workspace
1. Da click en 'Create a new workspace'
2. En el campo **Create workspace** escribe: `codea-codigox`
3. En el campo **Description** puedes explicar brevemente lo que hará tu aplicación o usar nuestra descripción: `This app creates a dashboard with your favourite artists using Twitter API and sends them to Codea-CodigoX app.`
4. En la opción **Hosted Workspace** seleccionar **'Public'**
5. En el campo **Clone from Git or Mercurial URL** vamos a pegar la siguiente URL: `https://github.com/codealab/esqueleto_codigox`. Esto nos permite clonar (copiar) un esqueleto  con el código mínimo para empezar con tu aplicación.
6. En **Choose a template** seleccionamos el template `Ruby`.
7. Da click en **Create workspace** para pasar al siguiente paso.

![Cloud9 Workspace](https://codealab.files.wordpress.com/2016/09/codigox_creating_workspace.png)

### Interfaz de Cloud9
**Familiarízate con la interfaz de Cloud9**

![Cloud9 Interface](https://codealab.files.wordpress.com/2016/09/codigox_interface_cloud9.png)

## Objetivos Académicos

- Comprender qué es una aplicación web
- Aprender a crear un CRUD
- Crear tu primera aplicación web
- Utilizar la API de Twitter
- Comunicar nuestra aplicación con servicios externos

## Introducción

Vamos a crear una aplicación que te permitirá guardar tus artistas favoritos.

Para ello crearemos un modelo Propuesta que estará compuesto de 3 atributos:

<table class="table table-responsive table-bordered table-condensed">
  <thead>
  <tr>
    <th>Nombre</th>
    <th>Tipo de Dato</th>
    <th>Descripción</th>
  </tr>
  </thead>
  <tbody>
  <tr>
    <td>name</td>
    <td>string</td>
    <td>Nombre</td>
  </tr>
  <tr>
    <td>avatar</td>
    <td>string</td>
    <td>Link de la imagen</td>
  </tr>
  <tr>
    <td>twitter_handle</td>
    <td>string</td>
    <td>Nombre de usuario de Twitter</td>
  </tr>
  </tbody>
</table>

## Actividades

Todas las siguientes instrucciones serán ejecutadas en **Cloud9**. Si necesitas ayuda entendiendo el funcionamiento del sistema pregunta a uno de los instructores.

La estructura de archivos de tu aplicación la puedes encontrar en el lado izquierdo de la interfaz de Cloud9, dentro de la carpeta 'codea-codigox' están todos los archivos que consituyen tu aplicación.

## Configura tu aplicación

- El primer paso es instalar las gemas que necesita tu aplicación para funcionar. Una gema es una librería de código que añade funcionalidades específicas a tu aplicación. Ejecuta el siguiente comando en la Terminal (Consola) ubicada en la parte inferior de la interfaz de Cloud9:

```bash
$ bundle update
```

- En el esqueleto que te damos existe el archivo `/db/migrate/20160601223404_create_proposals.rb` el cual contiene los atributos del modelo **Proposals** para relacionarlo con la Base de Datos. El siguiente comando ejecuta este archivo, creando una tabla y agregándole esos atributos a la DB. Recuerda ejecutarlo en la Terminal:

``` bash
$ rake db:migrate
```

- Vamos a crear el controlador para el modelo **Proposals**. En tu Terminal ejecuta el siguiente comando:

``` bash
$ rails generate controller proposals
```

Este comando nos crea el archivo `codea-codigox/app/controllers/proposals_controller.rb`. Dentro de este archivo vamos a crear la funcionalidad necesaria para las acciones del CRUD de **Proposals**.


### CRUD de `Proposals`

CRUD son las siglas de **Create, Read, Update** y **Destroy** y para nuestras aplicaciones está formado de 7 acciones que se explican a continuación:

<table  class="table table-responsive table-bordered table-condensed">
  <tr>
    <th>Acción</th>
    <th>CRUD</th>
    <th>Vista</th>
    <th>Verbo HTTP</th>
    <th>PATH</th>
    <th>Concepto</th>
  </tr>
  <tr>
    <td>New</td>
    <td rowspan="2">CREATE</td>
    <td>new.html.erb</td>
    <td>GET</td>
    <td>/proposals/new</td>
    <td>Muestra el formulario para un nuevo objeto</td>
  </tr>
  <tr>
    <td>Create</td>
    <td></td>
    <td>POST</td>
    <td>/proposals</td>
    <td>Procesa o guarda el nuevo objeto</td>
  </tr>
  <tr>
    <td>Index</td>
    <td rowspan="2">READ</td>
    <td>index.html.erb</td>
    <td>GET</td>
    <td>/proposals</td>
    <td>Muestra todos los objetos</td>
  </tr>
  <tr>
    <td>Show</td>
    <td>show.html.erb</td>
    <td>GET</td>
    <td>/proposals/:id</td>
    <td>Muestra un objeto especifico</td>
  </tr>
  <tr>
    <td>Edit</td>
    <td rowspan="2">UPDATE</td>
    <td>edit.html.erb</td>
    <td>GET</td>
    <td>/proposals/:id/edit</td>
    <td>Muestra el formulario para editar un objeto</td>
  </tr>
  <tr>
    <td>Update</td>
    <td></td>
    <td>PUT/PATCH</td>
    <td>/proposals/:id</td>
    <td>Guarda los datos editados del objeto</td>
  </tr><tr>
    <td>Destroy</td>
    <td>DELETE</td>
    <td></td>
    <td>DELETE</td>
    <td>/proposals/:id</td>
    <td>Borra un objeto especificado</td>
  </tr>
</table>

## Creando el CRUD

Para crear un objeto `Proposal` necesitamos usar dos acciones:
- `new` - Nos sirve para desplegar un formulario al usuario, donde introducirá el nombre y el link a la foto de la nueva `Proposal`.
- `create` - Nos servirá para crear y guardar la nueva `Proposal` en la base de datos.

**Es importante recordar que todas las acciones (métodos) del controlador las añadirás al archivo `codea-codigox/app/controllers/proposals_controller.rb` dentro de la clase `ProposalsController`, lo que significa que va entre las líneas `class ProposalsController < ApplicationController` y `end`.**

#### Acción `index`

- El primer paso será crear una acción `index` en nuestro controlador. Esta acción enlistará todas las `Proposals` que crearás. Pega el siguiente código en tu controlador:

``` ruby
  def index
    @proposals = Proposal.all
    # render 'proposals/index.html.erb'
  end
```
La acción anterior trae de la base de datos todas las `Proposals` y como especifica el comentario, se mostrará el archivo 'codea-codigox/app/views/proposals/index.html.erb'.

- Copia el siguiente código que combina HTML y Ruby para enlistar los `proposals` que trajimos de la base de datos.

``` erb
<div id="first_section">
  <div class="container">
    <div class="jumbotron well">
      <h1 class="text-center">Artistas favoritos de <%= image_tag("http://www.gob.mx/cms/uploads/identity/image/2537/logo-codigox.png", alt: "TagCDMX", :height => 100)  %></h1>
    </div>
  </div><!-- container -->
</div>
<div class="container container-margin">
  <div class="row">
    <% if @proposals.any? %>
      <% @proposals.each do |proposal| %>
        <div class="col-sm-6 col-md-4">
          <div class="thumbnail thumbnail-fix">
            <% if proposal.avatar == "" %>
              <%= link_to image_tag("http://icons.veryicon.com/128/Avatar/Face%20Avatars/Male%20Face%20N2.png",
                                    class:"pull-left username-card-img"), proposal_path(proposal) %>
            <% else %>
              <% avatar = proposal.avatar.gsub!("_normal", "_bigger") %>
              <%= link_to image_tag(avatar == nil ? proposal.avatar : avatar,
                    class:"pull-left username-card-img"), proposal_path(proposal) %>
            <% end %>
            <div class="caption">
              <h5 class="text-center username-card" style="display:inline-block">
                <%= link_to proposal.name, proposal_path(proposal) %>
              </h5>
              <br>
              <%= link_to "", edit_proposal_path(proposal),
                                              class: "btn btn-warning btn-xs glyphicon glyphicon-pencil" %>
              <%= link_to "", proposal_path(proposal),
                    method: :delete,
                    data: { confirm: "¿Seguro que quieres eliminar la propuesta?" },
                    class: "btn btn-danger btn-xs glyphicon glyphicon-trash" %>
            </div>
          </div>
        </div>
      <% end %>
    <% end %>
  </div>
</div>
```

> ####Levantando el servidor
>
>Para poder visualizar nuestra aplicación en el navegador, tenemos que levantar nuestro servidor web. Te recomendamos abrir una nueva pestaña de terminal y ejecutar tu servidor en ella.
Esto lo haces dando click al símbolo de mas (+) que está junto a las pestañas de tu terminal y en el menú que se abre selecciona `New Terminal`.
En esa nueva pestaña ejecuta el siguiente comando:
>
>```bash
>$ rails s -p $PORT -b $IP
>```

En este punto Cloud9 nos da acceso a una url como la siguiente `https://codea-codigox-username.c9users.io/`, en donde verás la página default de bienvenida de Rails.

El link a tu aplicación te saldrá del lado derecho de tu Terminal en una alerta verde, puedes darle click para que te abra una nueva pestaña con tu aplicación.

![Loading Server](https://codealab.files.wordpress.com/2016/09/codigox_loading_server.png)


#### Acción `new`

- Dentro del controlador pega el siguiente código debajo del método `index`:

``` ruby
  def new
    @proposal = Proposal.new
    # render 'proposal/new.html.erb'
  end
```

La acción anterior crea una `Proposal` vacía y como especifica el comentario, se mostrará el archivo 'codea-codigox/app/views/proposals/new.html.erb'.

- Pega el siguiente código HTML en este archivo.

``` erb
<div id="first_section">
  <div class="container">
    <h1 class="text-center">Agrega tu artista</h1>
    <div class="row">
      <%= form_for @proposal do |f| %>

      <div class="proposal-input col-md-offset-3 col-md-6 ">
        <%= f.text_field :name,   placeholder: "Nombre", class: "form-control" %>
      </div>
      <div class="proposal-input col-md-offset-3 col-md-6 ">
        <%= f.text_field :avatar, placeholder: "Avatar", class: "form-control" %>
      </div>
      <div class="proposal-input col-md-offset-3 col-md-6">
        <%= f.submit "Crear", class: "btn btn-md btn-primary btn-block" %>
      </div>
      <% end %>
    </div><!-- first_section -->
  </div><!-- container -->
</div>
```

- Una vez que hemos hecho esto, podemos ver nuestro formulario dando click al link de `Nueva propuesta` en la barra de navegación de tu aplicación. Si agregas una propuesta y le das click al botón `crear` verás un error, esto es porque no hemos creado el método `create`.

#### Acción `create`

- Al llenar y darle click a `Crear` en el formulario anterior éste se enviará a la acción de `create` de nuestro controlador. Necesitamos crear la acción en el controlador con el siguiente código, que contendrá la lógica para crear y guardar el `proposal` en la base de datos, pegalo debajo de tu acción `new`:

```ruby
  def create
   proposal = Proposal.find_by(name: params[:proposal][:name])
   if proposal == nil
     @proposal = Proposal.create(proposal_params)
     flash[:success] = "Artista Agregado"
   else
     flash[:danger] = "No puedes duplicar un artista"
   end
   redirect_to proposals_path
  end

  private

    def proposal_params
      params.require(:proposal).permit(:name, :avatar)
    end
```

En este código definimos dos métodos `create` que guarda nuestra propuesta y utiliza el otro método, `proposal_params` el cual es privado y se encarga de recibir los parámetros que envió la forma y omitir información no permitida.

**Recuerda grabar tu controlador después de añadir nuevo código, todas las acciones nuevas deberás pegarlas antes de la palabra clave `private` y después del último método definido**

El método 'create' crea una nueva `Proposal` con los parámetros que le pasó el formulario. Después la guarda y redirige al usuario a `proposals_path` que es la vista `index`.

Con este método ya podemos crear propuestas nuevas. Agrega por lo menos 3 propuestas nuevas, recuerda que en avatar deberás poner el link a una imagen de la propuesta que añades o lo puedes dejar vacío.

#### Acción `show`

- En este momento si le das click al nombre de tus propuestas encontrarás un error pues aún no hemos creado la acción que muestra cada una de ellas de manera individual.

- La acción `show` mostrará el detalle de una `Proposal` en particular. Pega el siguiente código en tu controlador antes de la palabra clave `private` y después del último método que tienes:

``` ruby
  def show
    @proposal = Proposal.find(params[:id])
    @counter = @proposal.counter_codea.body
    # render 'proposals/show.html.erb'
  end
```

**Recuerda guardar tus archivos después de cada cambio**

La acción anterior trae de la base de datos una `Proposal` pasándole un `id`. Para acceder al id de la url, utilizamos el hash `params`.

Esta acción mostrará el archivo 'codea-codigox/app/views/proposals/show.html.erb'.

- Accede a este archivo y copia en él el siguiente código que mostrará el detalle del `Proposal` que trajimos de la base de datos.

``` erb
<div class="row container-margin first-row">
  <div class="col-md-4 col-md-offset-4">
    <div class="panel panel-default">
      <div class="panel-body flex-center">
        <% if @proposal.avatar == "" %>
          <%= image_tag("http://icons.veryicon.com/128/Avatar/Face%20Avatars/Male%20Face%20N2.png", class:"img-responsive show-img")%>
        <% else %>
          <% avatar = @proposal.avatar.gsub!("_normal", "") %>
          <%= image_tag(avatar == nil ? @proposal.avatar : avatar, class:"img-responsive show-img")%>
        <% end %>
      </div>
      <div class="panel-footer text-center">
        <div class="row">
          <div class="col-md-12">
            <h2><%= @proposal.name %></h2>
          </div>
        </div>
        <div class="row">
          <div class="col-md-4 col-sm-4 col-xs-4 options-margin">
            <% counter = @counter == "" ? 0 : @counter %>
            <div class="btn btn-danger btn-xs counter-show"><%= counter %></div>
          </div>
          <div class="col-md-4 col-sm-4 col-xs-4">
            <% if @proposal.twitter_handle != nil %>
              <%= link_to image_tag("http://icons.veryicon.com/png/Application/Android%20Lollipop%20Apps/Twitter.png", class:"twitter_link", height: "40px", style: "margin-bottom: 10px;"), "http://www.twitter.com/#{@proposal.twitter_handle}", target: "_blank"%>
            <% end %>
          </div>
          <div class="col-md-4 col-sm-4 col-xs-4 options-margin">
            <%= link_to "", edit_proposal_path(@proposal),
                                    class: "btn btn-warning btn-xs glyphicon glyphicon-pencil" %>
            <%= link_to "", proposal_path(@proposal),
                  method: :delete,
                  data: { confirm: "¿Seguro que quieres eliminar la propuesta?" },
                  class: "btn btn-danger btn-xs glyphicon glyphicon-trash" %>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
```

- Ahora navega a tu página principal de propuestas y da click al nombre de alguna de ellas para que veas la página que acabas de crear.


#### Acción `edit`

La acción `edit`, nos permitirá corregir una `Proposal` en caso de que nos hayamos equivocado al introducirla, cambiar el nombre o el link al avatar de la misma.

- Como en todas las acciones anteriores vamos a comenzar incluyendo el código necesario en el controlador. Agrega las siguientes líneas al mismo:

``` ruby
  def edit
    @proposal = Proposal.find(params[:id])
    # render 'proposals/edit.html.erb'
  end
```

- Agrega el siguiente código al archivo 'codea-codigox/app/views/proposals/edit.html.erb':

``` erb
<div id="first_section">
  <div class="container">
    <h1 class="text-center">Editar Propuesta</h1>
    <div class="row">
      <%= form_for @proposal do |f| %>

      <div class="proposal-input col-md-offset-3 col-md-6 ">
        <%= f.text_field :name,   placeholder: "Nombre", class: "form-control" %>
      </div>
      <div class="proposal-input col-md-offset-3 col-md-6 ">
        <%= f.text_field :avatar, placeholder: "Avatar", class: "form-control" %>
      </div>
      <div class="proposal-input col-md-offset-3 col-md-6">
        <%= f.submit "Guardar", class: "btn btn-md btn-primary btn-block" %>
      </div>
      <% end %>
    </div><!-- first_section -->
  </div><!-- container -->
</div>
```

Con esto ya funcionan los links para editar `E` en las propuestas de tu página `index` y `show`. Al dar click en cualquiera de estos links, podemos ver nuestra forma, la cual al guardarla genera un error al no encontrar el método 'update' el cual crearemos a continuación.


#### Acción `update`

El formulario anterior se enviará a la acción `update` de nuestro controlador.  Necesitamos crear la acción con el código que contendrá la lógica para obtener de la base de datos el `proposal` y guardarlo con los nuevos valores.

- Ve a tu controlador y agrega el siguiente código de la misma manera que haz hecho con los métodos anteriores.

``` ruby
  def update
    @proposal = Proposal.find(params[:id])
    @proposal.update(proposal_params)
    flash[:success] = "Artista actualizado"
    redirect_to proposal_path
  end
```

- Accede a tus propuestas y edita algunas de ellas, cambiales el nombre y la foto a tu gusto para probar la nueva funcionalidad de tu aplicación.

#### Acción `delete`

La última funcionalidad que agregaremos para completar el CRUD es borrar una `Proposal`. Para esto vamos a crear la acción `destroy`. Copia el siguiente código en el controlador.

``` ruby
  def destroy
    @proposal = Proposal.find(params[:id])
    @proposal.destroy
    flash[:danger] = "Artista borrado
    "
    redirect_to proposals_path
  end
```

Este código hace que funcionen el link de la 'basurita' de cada propuesta para borrarla. Pruebalo esta funcionalidad borrando cualquiera de las propuestas que has añadido.

Tu archivo de controlador debe contener el siguiente código al final de estos pasos:

```ruby
class ProposalsController < ApplicationController

  def index
    @proposals = Proposal.all.order(:name)
    # render 'proposals/index.html.erb'
  end

  def new
    @proposal = Proposal.new
    # render 'proposal/new.html.erb'
  end

  def create
    proposal = Proposal.find_by(name: params[:proposal][:name])
    if proposal == nil
      @proposal = Proposal.create(proposal_params)
      flash[:success] = "Artista Agregado"
    else
      flash[:danger] = "No puedes duplicar un artista"
    end
    redirect_to proposals_path
   end

  def show
    @proposal = Proposal.find(params[:id])
    @counter = @proposal.counter_codea.body
    # render 'proposals/show.html.erb'
  end

  def edit
    @proposal = Proposal.find(params[:id])
    # render 'proposals/edit.html.erb'
  end

  def update
    @proposal = Proposal.find(params[:id])
    @proposal.update(proposal_params)
    flash[:success] = "Artista actualizado"
    redirect_to proposal_path
  end

  def destroy
    @proposal = Proposal.find(params[:id])
    @proposal.destroy
    flash[:danger] = "Artista borrado"
    redirect_to proposals_path
  end

  private

    def proposal_params
      params.require(:proposal).permit(:name, :avatar)
    end
end

```

**Con todos estos pasos ya tenemos listos los recursos que hacen funcionar las acciones CRUD que explicamos al inicio.**


##¿Sabes lo que es un API (Application Programming Interface)?

Un **API** es una "Librería" creada para poder comunicarse con un software en particular, de manera sencilla. Normalmente esta librería contiene funciones, especificaciones y procedimientos que te permiten comunicarte con ese software para recibir servicios del mismo.

Un ejemplo muy sencillo es lo que lograremos al integrar la **<a href="https://dev.twitter.com/overview/api" target="_blank">API de Twitter</a>** y la aplicación de artistas para Código X **<a href="http://codea-codigox.herokuapp.com/" target="_blank">Codea-CódigoX</a>**, desarrollada por **<a href="http://www.codea.mx" target="_blank">Codea</a>**.

Tu aplicación podrá buscar a través de **Twitter** información pública de sus usuarios para utilizarlos como propuestas. Para ello nos comunicaremos con **Twitter** utilizando su API y después mandaremos las propuestas creadas a **Codea-CodigoX** para que podamos ver cuáles artistas fueron agregados.

- Si no tienes cuenta de Twitter o no tienes registrado tu número en la misma puedes seguir estos links para realizarlo:

**<a href="https://twitter.com/signup" target="_blank">Crear cuenta de Twitter</a>**

**<a href="https://twitter.com/settings/devices" target="_blank">Registrar número móvil en tu cuenta de Twitter</a>**


Esto es un requisito de la sección de desarrolladores de Twitter para poder crear tu aplicación.

### Creación de un Twitter Client

El primer paso para agregar esta funcionalidad será obtener los códigos de autorización que nos da Twitter para acceder a sus servicios. Entra a la siguiente ruta para hacerlo: **<a href="https://dev.twitter.com/apps/new" target="_blank">https://dev.twitter.com/apps/new</a>**.

A continuación vamos a llenar todos los campos que Twitter nos pide para crear nuestra aplicación.

1. En el campo **Name:** escribe `codea-codigox-` seguido de tu nombre o identificador favorito.
2. En **Description:** puedes explicar brevemente lo que hará tu aplicación o usar nuestra descripción: `This app creates a dashboard with your favourite artists using Twitter API and sends them to Codea-CodigoX app.`
3. En **Website:** copia el link que Cloud9 te dio para tu aplicación. Algo parecido a `https://codea-codigox-username.c9users.io/`.
4. En **Callback URL:** vuelve a copiar la misma URL que pusiste en el campo anterior.
5. Para terminar este paso deberás aceptar los términos y condiciones de Twitter seleccionando el 'checkbox' debajo de éstas.
6. Darle click a `Create your Twitter application`.
![Creating Twitter App](https://codealab.files.wordpress.com/2016/09/codigox_twitter_signin.png)
7. Una vez que tu aplicación sea creada de manera correcta, la página te llevará a un panel de configuración. Dentro de este panel accede a la pestaña de `Keys and Access Tokens` donde encontrarás tu `Consumer Key (API Key)` y tu `Consumer Secret (API Secret)`.
8. Ahora debemos generar los `Access Token` para lo cual deberás ir a la parte inferior de tu página de keys y dar click en el botón que dice `Create my access token`, esto puede tardar unos momentos y deberá darte un mensaje de éxito en la misma página, si vuelves a bajar dentro de la misma encontrarás una sección titulada 'Your Access Token' en donde están ahora el `Access Token` y el `Access Token Secret`.

![Twitter Tokens](https://codealab.files.wordpress.com/2016/09/codigox_twitter_all_tokens.png)

No cierres esta página pues la usaremos más adelante. En este punto deberás tener generados y ubicados los siguientes datos:

- Consumer Key
- Consumer Secret
- Access Token
- Access Token Secret

**Ahora sí tienes todo lo necesario para crear un "Twitter Client".**

### Obtener token de Codea

Este token te permitirá que las propuestas que agregues a tu aplicación aparezcan en la página principal de **Codea-CodigoX**, se publiquen en **Twitter* y podamos ver todos los artistas agregados.

Para conseguir este token debes acceder a la aplicación de Codea-CodigoX entrando al siguiente link:

- **<a href="http://codea-codigox.herokuapp.com/" target="_blank">Codea-CodigoX</a>**

Aquí debes dar click al botón 'Inicio con Twitter' ubicado en la barra de navegación de tu aplicación y autorizar a Twitter para que se conecte con la aplicación.

![Sign In with Twitter](https://codealab.files.wordpress.com/2016/09/codigox_twitter_signin2.png)

Esto nos va a loggear en nuestra aplicación por medio de la API de Twitter. Posteriormente nos va a redirigir al perfil de usuario de nuestra aplicación, donde podremos ver el Token que Codea genera para nosotros.

![Codea Token](https://codealab.files.wordpress.com/2016/09/codigox_codea_token2.png)

### Configurar la API de Twitter y Codea-CodigoX

La información que generamos en el paso anterior es privada y te pertenece, para protegerla utilizaremos un archivo de Rails en dónde guardaremos tus `tokens` y nadie podrá acceder a ellos más que tú, para esto deberás navegar al archivo 'codea/config/twitter_secret.yml' donde verás el siguiente código:

```ruby
CONSUMER_KEY:
CONSUMER_SECRET:
ACCESS_TOKEN:
ACCESS_TOKEN_SECRET:
CODEA_API_TOKEN:
```

- Ve a la página de tu aplicación en Twitter y agrega en el archivo `twitter_secrets.yml` los tokens correspondientes después de los dos puntos y un espacio.

- Copia el `API token` que se encuentra en la sección `Profile` de la aplicación web de **<a href="http://codea-codigox.herokuapp.com/" target="_blank">Codea-CodigoX</a>** y agrégalo en el espacio correspondiente en tu archivo `twitter_secrets.yml`.

- Al finalizar este archivo con los tokens añadidos deberá lucir parecido al siguiente:

![Twitter Secrets](https://codealab.files.wordpress.com/2016/09/codigox_twitter_secrets.png)

Estos códigos no funcionan, así que no los copies a tu aplicación, ten el cuidado de pegar tus propios **tokens** en el mismo.

### Reiniciar el servidor

Tu aplicación necesita ahora recargar los archivos para que estos funcionen, para ellos tiraremos nuestro servidor y lo volveremos a levantar.

- Muevete a la pestaña donde está corriendo tu servidor en la Terminal de Cloud9 y presiona `Ctrl + C` en tu teclado, esto te dará el mensaje 'Exiting' que indica que el servidor se ha detenido.

En este punto si intentas recargar la página de tu aplicación te marcará un error que dirá 'No application seems to be running here!'. Para volver a levantar nuestro servidor debemos correr en la misma pestaña de la consola el siguiente código:

```bash
$ rails s -p $PORT -b $IP
```

Regresa a tu pestaña de Terminal en la que trabajamos (la primera) y preparate para hacer la integración con Twitter.

## Integración con Twitter y Codea-CodigoX

- El archivo `/config/application.rb` se utiliza para definir algunos de los comportamientos básicos de tu aplicación. Dentro de este archivo agregaremos dos partes importantes:
1. El método que lee los tokens del archivo `twitter_secrets.yml`
2. El cliente por medio del cual nos comunicaremos con Twitter.

- Revisa los comentarios dentro de este archivo para que comprendas qué hace este código.

#### Agregando funcionalidad extra

A continuación haremos algunos cambios a nuestras vistas para acceder a esta funcionalidad. Lo primero será crear un link para agregar propuestas desde Twitter en el `header` de tu aplicación.

Necesitamos un controlador que se encargará de agrupar las funciones relacionadas con Twitter, para generarlo ejecuta el siguiente comando en la primera pestaña de tu consola:

```bash
$ rails generate controller twitter
```

En el vamos a colocar los métodos que se encargarán de:

- Dirigir a la página para nuevas propuestas de Twitter
- Buscar una propuesta en Twitter
- Guardar una nueva propuesta de Twitter

Todas estas funciones se ejecutan sustituyendo el contenido del archivo 'codea-codigox/app/controllers/twitter_controller.rb' por el siguiente código, lee los comentarios para entender la función de cada uno de ellos:

```ruby
class TwitterController < ApplicationController

  # Redirige al usuario a la página de Propuesta con Twitter
  def twitter_proposal
    @proposal = Proposal.new
  end

  # Accede al cliente para buscar usuarios de Twitter
  def search_users
    @search_word = params[:twitter][:search]
    @users = CLIENT.user_search(@search_word)
  end

  # Añade el usuario de Twitter a nuestras propuestas
  def add_proposal
    proposal = Proposal.find_by(twitter_handle: params[:proposal][:twitter_handle])
    if proposal == nil
      @proposal = Proposal.create(proposal_params)
      @proposal.send_to_codea
      flash[:success] = "Artista Agregado"
    else
      flash[:danger] = "No puedes duplicar un artista"
    end
    redirect_to proposals_path
  end

  private

  def proposal_params
    params.require(:proposal).permit(:name, :avatar, :twitter_handle)
  end

end
```

Los siguientes links te servirán como documentación para entender de donde salió parte del código anterior.
​
- **<a href="http://www.rubydoc.info/gems/twitter" target="_blank">Esta es la documentación de cómo utilizar la gema para hacer peticiones a twitter</a>**
- **<a href="http://www.rubydoc.info/gems/twitter/Twitter/REST/Users#user_search-instance_method" target="_blank">De esta parte de la documentación sacamos el método para buscar usuarios</a>**
- **<a href="http://www.rubydoc.info/gems/twitter/Twitter/User" target="_blank">Aquí aprendimos con el método 'attrs' a conocer los atributos que podemos utilizar para cada usuario</a>**

**Recuerda grabar tus archivos después de cada modificación.**

En la carpeta 'codea-codigox/app/views/twitter/twitter_proposal.html.erb' hemos creado por ti los archivos de vistas necesarios para estas nuevas funcionalidades.

Con esto ya podrás acceder a tu nueva página en tu aplicación ('Propón con Twitter'), en ella podrás buscar y agregar nuevas propuestas a tu aplicación, intenta agregar varias propuestas por este medio y checa como se ven en tu página principal de propuestas.

Entra a **<a href="http://codea-codigox.herokuapp.com/" target="_blank">Codea-CodigoX</a>** y podrás ver las propuestas que agregaste y las que han hecho otros usuarios.


## <center>¡¡ Felicidades acabas de crear tu primera app de Rails !!</center>
