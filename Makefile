NAME = transcendence

GREEN := \033[0;32m

YELLOW := \033[0;33m

RESET := \033[0m

all:
	mkdir -p srcs/friend/tools/data srcs/record/tools/data srcs/record/tools/data
	mkdir -p srcs/user/tools/data srcs/user/tools/avatar

	docker compose -f docker-compose.yml up -d --build
	clear
	@echo "$(GREEN)----------------------FT_TRANSCENDENCE-----------------------$(RESET)"
	@echo "$(GREEN)Pong game is running$(RESET)"
	@echo "$(GREEN)Local launch: https://localhost$(RESET)"
	@echo "$(GREEN)Remote launch: https://server_ip$(RESET)"
	@echo "$(GREEN)-------------------------------------------------------------$(RESET)"
	@echo "--------------------------[Service built]----------------------------" >> log.txt
	@echo >> log.txt
	
	@docker compose -f docker-compose.yml logs -f >> log.txt &

$(NAME): all

start:
	docker compose -f docker-compose.yml up -d
	clear
	@echo "$(GREEN)----------------------FT_TRANSCENDENCE-----------------------$(RESET)"
	@echo "$(GREEN)Pong game is running$(RESET)"
	@echo "$(GREEN)Local launch: https://localhost$(RESET)"
	@echo "$(GREEN)Remote launch: https://server_ip$(RESET)"
	@echo "$(GREEN)-------------------------------------------------------------$(RESET)"
	@echo "--------------------------[Service started]----------------------------" >> log.txt
	@echo >> log.txt

	@docker compose -f docker-compose.yml logs -f >> log.txt &
	

stop:
	docker compose -f docker-compose.yml stop

	@echo >> log.txt

get-data:
	mkdir -p data data/user data/friend data/record
	@docker cp t_user:/app/transcendence/user_manage/data data/user || echo "Warning: failed to copy."
	@docker cp t_user:/app/transcendence/user_manage/avatar data/user || echo "Warning: failed to copy"
	@docker cp t_record:/app/transcendence/record_manage/data data/record || echo "Warning: failed to copy"
	@docker cp t_friend:/app/transcendence/friend_manage/data data/friend || echo "Warning: failed to copy"
	@echo "$(GREEN)--------------------------GET DATA-------------------------$(RESET)"

put-data:
	@mkdir -p srcs/user/tools/data
	@cp -r data/user/data/* srcs/user/tools/data/ || echo "Warning: failed to copy."

	@mkdir -p srcs/user/tools/avatar
	@cp -r data/user/avatar/* srcs/user/tools/avatar/ || echo "Warning: failed to copy."

	@mkdir -p srcs/friend/tools/data
	@cp -r data/friend/data/* srcs/friend/tools/data/ || echo "Warning: failed to copy."

	@mkdir -p srcs/record/tools/data
	@cp -r data/record/data/* srcs/record/tools/data/ || echo "Warning: failed to copy."
	@echo "$(GREEN)--------------------------PUT DATA--------------------------$(RESET)"

restore:
	@docker cp t_user:/app/transcendence/user_manage/data srcs/user/tools && docker cp t_user:/app/transcendence/user_manage/avatar srcs/user/tools || echo "Warning: failed to copy."
	@docker cp t_friend:/app/transcendence/friend_manage/data srcs/friend/tools || echo "Warning: failed to copy."
	@docker cp t_record:/app/transcendence/record_manage/data srcs/record/tools || echo "Warning: failed to copy."

re-restore: restore re
	@echo "$(GREEN)---------------------REBUILD WITH DATA-----------------------$(RESET)"

clean:
	make stop
	docker system prune -af

re: clean all

.PHONY: all start stop clean re get-data put-data restore re-restore


