<figure class="image" align='center'>
    <img src="img/header1.png?raw=true">
    <figcaption></figcaption>
</figure>

## Índice
+ [Sobre](#sobre)
+ [Primeiros Passos](#comecando)
    - [Pré-requisitos](#pre_req)
    - [Instalação](#instalacao)
+ [Uso](#uso)
+ [Melhorias](#todo)

<h2 id="sobre">Sobre</h2>

O objetivo desse projeto é controlar o drone DJI Tello, a fim de aprender sobre conceitos de comunicação utilizando o protocolo UDP, linguagem Dart e framework Flutter para desenvolvimento multiplataforma de apliativos mobile.

<div align='center'>
    <img src="https://github.com/mateustoin/Tello-Data-Collector/blob/master/img/tello.png?raw=true">
    <p>Figura 1. DJI Tello Drone</p>
</div>

Realizado durante as lives da twitch no <a href="https://twitch.tv/bittoin">canal BitToin</a>, foi um projeto que utilizou como base um pacote em Dart feito também durante as lives para a comunicação da linguagem suportada em Dart/Flutter com o Drone. Atualmente o pacote está disponível de maneira oficial no site de pacotes do Dart (<a href="https://pub.dev/packages/tello">link do package</a>).

<h2 id="comecando">Começando</h2>

Siga estas instruções para criar, replicar e modificar o modelo de app na sua máquina. 

<h3 id='pre_req'>Pré-requisitos</h3>

O principal pré-requisito do projeto é ter o Drone para testá-lo com o app e modificar á vontade. Caso não tenha ainda é possível aprender bastante coisa relacionado a elementos inerentes ao framework e aplicativo.

Para realizar o deploy da aplicação na sua máquina será necessária a instalação do Dart e Flutter. Entre no link a seguir e acompanhe as instruções de acordo com seu sistema operacional

<code>
<a href="https://flutter.dev/docs/get-started/install"> Guia de instalação do Dart e Flutter na máquina</a>
</code>
<br/>
<br/>

Caso queira clonar este projeto direto do github na sua máquina, também será necessário o git instalado.

<code>
<a href="https://git-scm.com/book/en/v2/Getting-Started-Installing-Git"> Guia de instalação do Git na máquina</a>
</code>
<br/>

<h3 id='instalacao'>Instalação</h3>

Com o ambiente configurado, basta clonar este repositório utilizando o comando no terminal:

```
git clone https://github.com/mateustoin/Flutter-app-DJI-Tello-Drone
```

Para instalar os pacotes necessários, entre na pasta pelo terminal. Com tanto que o ambiente esteja configurado de acordo com o guia anterior, digite:

```
flutter pub get
```

Com os pacotes e dependências instalados corretamente, basta rodar o código:

```
flutter run
```

<h2 id="uso">Uso</h2>

<div align='center'>
    <img src="img/tela-app.png?raw=true">
    <p>Figura 2. App para controle do Drone</p>
</div>

Com o drone em mãos, basta ligá-lo e aguardar o sinal WiFi ser gerado para conectar o aparelho de celular nele. Após a conexão, o aplicativo automaticamente passa a se comunicar com o Drone e todos os botões passam a funcionar.

>### Joystick Esquerdo
> Controla a direção em que o drone se movimenta. Vai para frente, para trás, para esquerda e para direita. Além dos movimentos nas direções citadas, aumenta a velocidade de acordo com o quanto o joystick é puxado para o lado, indo de 0% até 100%.

<br/>

> ### Joystick Direito
> Segue a mesma lógica de funcionamento do anterior, porém controla se o drone vai para cima, para baixo, gira no próprio eixo no sentido horário e no sentido anti-horário. Além dos movimentos nas direções citadas, aumenta a velocidade de acordo com o quanto o joystick é puxado para o lado, indo de 0% até 100%.

<br/>

>### Botão TakeOff
>Faz o Drone sair do repouso e começar a voar.

<br/>

> ### Botão Land
> Faz o Drone pousar.

<br/>

> ### Botão KeepAlive
> Envia o comando 'command' para o drone, a fim de manter conexão quando não estiver em uso.

<br/>

> ### Botão Increase Speed
> Aumenta a velocidade do Drone


> <br/>

> ### Botão Decrease Speed
> Diminui a velocidade do Drone

</p>

<h2 id='todo'>Features</h2>

- [ ] Controlar a velocidade do Drone com uma Slide Bar
- [ ] Deixar responsível para os joystick encaixarem em qualquer tela
- [ ] Toda vez que aumentar ou diminuir a velocidade, aparecer pop up toast na tela
- [ ] Comando de voz?
