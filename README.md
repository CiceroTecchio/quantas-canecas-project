# quantas-canecas-project

Nos arquivos do App, alterar a linha 5 do arquivo "lib/services/canecas_service.dart" para o ip local da máquina;
 
Após rodar o docker-compose up, rodar o seguinte comando 
"docker exec -it <id_do_container_laravel> php artisan migrate:fresh --seed"
Isso vai criar a tabela em banco e inserir o registro utilizado.
