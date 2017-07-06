# Trabalho de Grafos
## Rodrigo Castro azevedo

### Acesso

Pode ser acessado através do link trabalho-grafos-20171.herokuapp.com

**O sistema foi hospedado no Heroku para visualização do resultado final sem
precisar fazer todo o processo de instalação do Ruby e gems para rodar local,
mas eu também especifiquei essas instruções abaixo.**

### Execução local (em ambiente Linux)

O sistema deveria funcionar no Linux, iOS e Windows, porém eu não possuo Mac,
então não providenciarei instruções de execução nessa plataforma, mas deve ser
muito similar às instruções de Linux.

Também não providenciarei instruções para o Windows pois é comum Ruby ter
problemas ao executar no Windows, podendo deixar o sistema instável ou sem
funcionar.

Abaixo seguem instruções para execução no ambiente Linux (baseado em Debian).

Para executar o projeto localmente, deve-se ter instalado a linguagem Ruby e
as seguintes gems:

- [Sinatra](https://github.com/sinatra/sinatra)
- [Puma](https://github.com/puma/puma)

A forma mais simples de instalar o Ruby (com a versão correta que deve ser a
partir da 2.3.x) é através do [RVM](https://rvm.io/):

1. `gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB`
2. `sudo apt-get install curl` (caso não tenha instalado)
3. `\curl -sSL https://get.rvm.io | bash -s stable`
4. `rvm install ruby-2.4`

E para executar o sistema:

1. `gem install sinatra`
2. `gem install puma`
3. `rackup -p 3000`
4. Acesse o browser no endereço `localhost:3000`
