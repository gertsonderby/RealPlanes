EXCLUDEPARTS =VTProp/PARTS/Props/BMW_IIIA.cfg VTProp/PARTS/Props/LibertyV12.cfg Sounds/sound_fsprop*.wav
ZIPCMD =cd package && /usr/bin/zip

.PHONY: latestRelease
all:
	$(eval PREVIOUS_TAG=$(shell echo `git describe --abbrev=0 --tags`))
	make release-$(subst v,,${PREVIOUS_TAG})

.PHONY: release-%
release-%: RealPlanes-%
	

.PRECIOUS: .git/refs/tags/v%
.git/refs/tags/v%:
	@perl -e 'die "Invalid version number syntax: $$ARGV[0]" unless scalar @ARGV == 1 && $$ARGV[0] =~ /^\d+\.\d+\.\d+.*$$/;' $*
ifneq ($(shell git describe --always --dirty | grep -- -dirty),)
	$(error Working tree is dirty, please commit or stash your changes, then try again)
endif
	git tag v$*
	git push origin `git rev-parse --abbrev-ref HEAD`
	git push origin v$*

RealPlanes-%: .git/refs/tags/v%
	START=`git rev-parse --abbrev-ref HEAD`
	git co v$*
	$(ZIPCMD) -r ../RealPlanes-$*.zip VTProp Readme.txt Rescale.cfg -x $(EXCLUDEPARTS)
	git co ${START}
