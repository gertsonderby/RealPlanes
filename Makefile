EXCLUDEPARTS =VTProp/PARTS/Props/BMW_IIIA.cfg VTProp/PARTS/Props/LibertyV12.cfg Sounds/sound_fsprop*.wav
ZIPCMD =cd package && /usr/bin/zip

all:
	@$(ZIPCMD) -r release.zip VTProp Readme.txt Rescale.cfg -x $(EXCLUDEPARTS)
	@mv package/release.zip .
