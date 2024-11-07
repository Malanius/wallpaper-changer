SERVICE_NAME=wallpaper_changer
SERVICE_FILE=$(SERVICE_NAME).service
TIMER_FILE=$(SERVICE_NAME).timer
SYSTEMD_DIR=/etc/systemd/system/

.PHONY: all install uninstall

all:
	@echo "Available targets: install, clean"

install:
	@echo "Copying service and timer files to $(SYSTEMD_DIR)"
	sudo cp $(SERVICE_FILE) $(SYSTEMD_DIR)
	sudo cp $(TIMER_FILE) $(SYSTEMD_DIR)
	@echo "Reloading systemd configuration"
	sudo systemctl daemon-reload
	@echo "Enabling and starting $(TIMER_FILE)"
	sudo systemctl enable $(TIMER_FILE)
	sudo systemctl start $(TIMER_FILE)

uninstall:
	@echo "Stopping and disabling timer and service"
	sudo systemctl stop $(TIMER_FILE) || true
	sudo systemctl disable $(TIMER_FILE) || true
	@echo "Removing service and timer files from $(SYSTEMD_DIR)"
	sudo rm -f $(SYSTEMD_DIR)/$(SERVICE_FILE)
	sudo rm -f $(SYSTEMD_DIR)/$(TIMER_FILE)
	@echo "Reloading systemd configuration"
	sudo systemctl daemon-reload
