SERVICE_NAME=wallpaper_changer
SERVICE_FILE=$(SERVICE_NAME).service
TIMER_FILE=$(SERVICE_NAME).timer
SCRIPT_FILE=random_wallpaper.sh
SYSTEMD_DIR=~/.config/systemd/user/

.PHONY: all install uninstall

all:
	@echo "Available targets: install, uninstall"

install:
	@echo "Copying service and timer files to $(SYSTEMD_DIR)"
	mkdir -p $(SYSTEMD_DIR)
	cp $(SERVICE_FILE) $(SYSTEMD_DIR)
	cp $(TIMER_FILE) $(SYSTEMD_DIR)
	cp $(SCRIPT_FILE) $(SYSTEMD_DIR)
	@echo "Reloading systemd configuration"
	systemctl --user daemon-reload
	@echo "Enabling and starting $(TIMER_FILE)"
	systemctl --user enable $(TIMER_FILE)
	systemctl --user start $(TIMER_FILE)

uninstall:
	@echo "Stopping and disabling timer and service"
	systemctl --user stop $(TIMER_FILE) || true
	systemctl --user disable $(TIMER_FILE) || true
	@echo "Removing service and timer files from $(SYSTEMD_DIR)"
	rm -f $(SYSTEMD_DIR)/$(SERVICE_FILE)
	rm -f $(SYSTEMD_DIR)/$(TIMER_FILE)
	rm -f $(SYSTEMD_DIR)/$(SCRIPT_FILE)
	@echo "Reloading systemd configuration"
	systemctl --user daemon-reload
