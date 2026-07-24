Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F00C531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 08:22:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 511C010E02A;
	Fri, 24 Jul 2026 08:22:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="hNIcP4OD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YBzm1kcn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hNIcP4OD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YBzm1kcn";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3228810E63D
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 08:22:08 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B29863E6F;
 Fri, 24 Jul 2026 08:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784881326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pXNhgntt4H9EYe6kHPDzSmBU41EYKnSH/pNguOzn3qQ=;
 b=hNIcP4ODkKB30M5sniYEtbC8l6SKc69OcVNt+jg8qpBusyOUUWjytPeWjZo0dKj442o8qD
 fJydvMcNyZShY/AhjnDEArO+efBKLBqumaD5qVSQo/EbhPhHDEkfOK9dnD4hva6jBzSC14
 EDiNy2f4QGyKmbD4NfyWyq8cdMe+484=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784881326;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pXNhgntt4H9EYe6kHPDzSmBU41EYKnSH/pNguOzn3qQ=;
 b=YBzm1kcnVFc+1jF7g23mCmkikdyDBW74EuOYgmMtYFh8gJ9z95nxtBUt7yjAGem1W/IgQs
 rAM8wiUjGCQ09eCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784881326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pXNhgntt4H9EYe6kHPDzSmBU41EYKnSH/pNguOzn3qQ=;
 b=hNIcP4ODkKB30M5sniYEtbC8l6SKc69OcVNt+jg8qpBusyOUUWjytPeWjZo0dKj442o8qD
 fJydvMcNyZShY/AhjnDEArO+efBKLBqumaD5qVSQo/EbhPhHDEkfOK9dnD4hva6jBzSC14
 EDiNy2f4QGyKmbD4NfyWyq8cdMe+484=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784881326;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pXNhgntt4H9EYe6kHPDzSmBU41EYKnSH/pNguOzn3qQ=;
 b=YBzm1kcnVFc+1jF7g23mCmkikdyDBW74EuOYgmMtYFh8gJ9z95nxtBUt7yjAGem1W/IgQs
 rAM8wiUjGCQ09eCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F577779BA;
 Fri, 24 Jul 2026 08:22:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Vg0bEq4gY2phdAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 24 Jul 2026 08:22:06 +0000
Date: Fri, 24 Jul 2026 10:22:04 +0200
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dim-tools@lists.freedesktop.org
Subject: [PULL] drm-misc-next
Message-ID: <20260724082204.GA18774@linux.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[gmail.com,ffwll.ch];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[16];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo]
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Dave, Sima,

this is this week's PR from drm-misc-next. Note that there are two
changes that slightly affect UAPI behaviour. One of them is in the
cgroup subsystem.

Apart from that, the PR has the usual fixes throughout drivers. There's
support for several new panels. The larges change is in host1x and tegra,
which now support Tegra264 SoCs.

Best regards
Thomas

drm-misc-next-2026-07-24:
drm-misc-next for v7.3:

UAPI Changes:

cgroup:
- dmem: accept one region per limit

drm:
- send per-connector hotplug events

Core Changes:

buddy:
- tests: test buffer clearence on resume

panel:
- implement ref counting for struct drm_panel throughout the DRM tree

Driver Changes:

etnaviv:
- force flush on power register ops

gma:
- replace simple-kms helpers with regular atomic helpers
- clean up

host1x:
- support Tegra264 plus DT bindings
- fix minor issues throughout driver

hypervdrm:
- clean up PCI-device binding

imagination:
- mark BXM-4-64 MC1 (36.52.104.182) as supported
- clean up

ivpu:
- clean up

nouveau:
- remove redundant call to pm_runtime_mark_last_busy()

panel:
- support Novatek NT36536 plus DT bindings
- sofef00: fix backlight updates
- osd101t2587: use mipi_dsi_*_multi interface
- panel-edp: adjust timing for AUO displays
- panel-lvds: support Opto Logic SCX1001511GGC49
- panel-simple: support Kyocera tcg070wvlq

panfrost:
- clean up

solomon:
- clean up variables

tve200:
- add OF module alias for autoloading

v3d:
- fix job BO handling

vc4:
- ref i2c-adapter module
The following changes since commit ec6444a00c49e6c2b5e9a507272a28126677f9ee:

  drm/bridge: tc358767: clamp the reported AUX read size to the request (2026-07-15 11:38:01 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-next-2026-07-24

for you to fetch changes up to e55fead22ff9ee047ab9f1903860c4b43043514e:

  drm/imagination: promote BXM-4-64 MC1 (36.52.104.182) to supported status (2026-07-24 08:37:01 +0100)

----------------------------------------------------------------
drm-misc-next for v7.3:

UAPI Changes:

cgroup:
- dmem: accept one region per limit

drm:
- send per-connector hotplug events

Core Changes:

buddy:
- tests: test buffer clearence on resume

panel:
- implement ref counting for struct drm_panel throughout the DRM tree

Driver Changes:

etnaviv:
- force flush on power register ops

gma:
- replace simple-kms helpers with regular atomic helpers
- clean up

host1x:
- support Tegra264 plus DT bindings
- fix minor issues throughout driver

hypervdrm:
- clean up PCI-device binding

imagination:
- mark BXM-4-64 MC1 (36.52.104.182) as supported
- clean up

ivpu:
- clean up

nouveau:
- remove redundant call to pm_runtime_mark_last_busy()

panel:
- support Novatek NT36536 plus DT bindings
- sofef00: fix backlight updates
- osd101t2587: use mipi_dsi_*_multi interface
- panel-edp: adjust timing for AUO displays
- panel-lvds: support Opto Logic SCX1001511GGC49
- panel-simple: support Kyocera tcg070wvlq

panfrost:
- clean up

solomon:
- clean up variables

tve200:
- add OF module alias for autoloading

v3d:
- fix job BO handling

vc4:
- ref i2c-adapter module

----------------------------------------------------------------
Albert Esteve (4):
      drm/panel: have drm_panel_add/remove manage a list reference
      drm/bridge/panel: hold a reference to the wrapped panel
      drm/panel: of_drm_find_panel() return a counted reference
      drm/panel: find_panel_by_fwnode() return a counted reference

Andrzej Kacprowski (1):
      accel/ivpu: Remove unnecessary min_t()/max_t() usage

Arunpravin Paneer Selvam (1):
      drm/tests/gpu_buddy: add a new test case for buffer clearance during resume

Can Peng (1):
      drm/tve200: add OF module alias for autoloading

Cédric Bellegarde (1):
      drm/panel: sofef00: Fix DSI transfer errors on backlight update

Dio Zhang (1):
      drm/panel: panel-edp: Adjust T8 timing for AUO B116XAK01.6 and B140XTK02.4

Diogo Silva (2):
      drm/gma500: cdv_intel_dp: fix indentation to use tabs instead of spaces
      drm/gma500: Remove dependency on DRM simple helpers

Eric Chanudet (1):
      cgroup/dmem: accept only one region per limit write

Frank Binns (2):
      drm/imagination: update GPU support documentation
      drm/imagination: promote BXM-4-64 MC1 (36.52.104.182) to supported status

Heiko Schocher (1):
      drm/panel: simple: Add Kyocera tcg070wvlq panel

Iker Pedrosa (1):
      drm/solomon: remove unneeded variables in blit functions

Johan Hovold (1):
      drm/vc4: hdmi: take i2c adapter module reference

Leonardo Costa (1):
      dt-bindings: display: panel-lvds: Add compatible for Opto Logic SCX1001511GGC49

Markus Elfring (1):
      drm/nouveau: Omit a redundant pm_runtime_mark_last_busy() call in nouveau_pmops_runtime_idle()

Matt Coster (2):
      drm/imagination: Add and use FLEX_ARRAY_CHECK()
      drm/imagination: Use struct_size_t()

Maíra Canal (2):
      drm/v3d: Associate BOs with every job that accesses them
      drm/panfrost: Remove unused scheduled_jobs list

Mikko Perttunen (11):
      gpu: host1x: Wait for timeout worker completion on channel free
      gpu: host1x: Avoid double device_add when clients already present
      gpu: host1x: Fix offset calculation in trace_write_gather
      gpu: host1x: Avoid stack over-read in debug output helpers
      gpu: host1x: Change pin_job() return type to int
      gpu: host1x: Annotate intentional syncpoint wrap-around
      dt-bindings: display: tegra: Changes to support Tegra264
      dt-bindings: display: tegra: Add Tegra264 compatible for VIC
      gpu: host1x: Correctly parse linear ranges of context devices
      drm/tegra: falcon: Add support for RISC-V external boot
      drm/tegra: vic: Add Tegra264 support

Natalie Vock (1):
      MAINTAINERS: Update Natalie Vock's email

Neil Armstrong (1):
      drm: fix missing header include for drm_panel_put()

Nicolas Frattaroli (2):
      drm/connector: Fix epoch_counter docs to reflect reality
      drm: Send per-connector hotplug events

Pengyu Luo (2):
      dt-bindings: display: panel: Add Novatek NT36536
      drm/panel: Add Novatek NT36536 panel driver

Randolph Sapp (1):
      drm/etnaviv: force flush on power register ops

Robert-Andrei Mercea (1):
      drm/panel: osd101t2587: migrate to newer mipi_dsi* functions

Santosh BS (1):
      gpu: host1x: Add Tegra264 support

Uwe Kleine-König (The Capable Hub) (3):
      drm/hyperv: Unregister pci driver in error path before module unload
      drm/hyperv: Explicitly set subvendor and subdevice for pci match array
      drm/hyperv: Move MODULE_DEVICE_TABLE to the device_id arrays

 .mailmap                                           |   3 +-
 .../bindings/display/panel/novatek,nt36536.yaml    |  91 +++
 .../bindings/display/panel/panel-lvds.yaml         |   2 +
 .../display/tegra/nvidia,tegra124-vic.yaml         |   1 +
 .../display/tegra/nvidia,tegra20-host1x.yaml       |  20 +-
 MAINTAINERS                                        |   2 +-
 drivers/accel/ivpu/ivpu_fw.c                       |   2 +-
 drivers/accel/ivpu/ivpu_mmu_context.c              |   4 +-
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c |  12 +
 drivers/gpu/drm/bridge/fsl-ldb.c                   |   1 +
 drivers/gpu/drm/bridge/lontium-lt9211.c            |   1 +
 drivers/gpu/drm/bridge/lvds-codec.c                |   1 +
 drivers/gpu/drm/bridge/panel.c                     |  20 +-
 drivers/gpu/drm/bridge/samsung-dsim.c              |   1 +
 drivers/gpu/drm/bridge/ssd2825.c                   |   1 +
 drivers/gpu/drm/bridge/tc358767.c                  |   2 +
 drivers/gpu/drm/bridge/tc358768.c                  |   1 +
 drivers/gpu/drm/bridge/waveshare-dsi.c             |   1 +
 drivers/gpu/drm/drm_of.c                           |   3 +-
 drivers/gpu/drm/drm_panel.c                        |  24 +-
 drivers/gpu/drm/drm_panel.c.orig                   | 722 +++++++++++++++++++++
 drivers/gpu/drm/drm_probe_helper.c                 |  53 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c              |  10 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h              |   6 +
 drivers/gpu/drm/exynos/exynos_dp.c                 |  19 +-
 drivers/gpu/drm/exynos/exynos_drm_dpi.c            |   3 +
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c          |  18 +
 drivers/gpu/drm/gma500/cdv_intel_crt.c             |   9 +-
 drivers/gpu/drm/gma500/cdv_intel_dp.c              | 120 ++--
 drivers/gpu/drm/gma500/cdv_intel_hdmi.c            |  10 +-
 drivers/gpu/drm/gma500/cdv_intel_lvds.c            |   9 +-
 drivers/gpu/drm/gma500/oaktrail_hdmi.c             |   9 +-
 drivers/gpu/drm/gma500/oaktrail_lvds.c             |   9 +-
 drivers/gpu/drm/gma500/psb_intel_lvds.c            |   9 +-
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c            |  14 +-
 drivers/gpu/drm/imagination/pvr_device.c           |   4 +-
 drivers/gpu/drm/imagination/pvr_drv.c              |   5 +-
 drivers/gpu/drm/imagination/pvr_queue.c            |  11 +-
 drivers/gpu/drm/imagination/pvr_rogue_fwif_check.h |  19 +-
 drivers/gpu/drm/imx/dcss/dcss-kms.c                |   4 +
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c          |   4 +-
 drivers/gpu/drm/logicvc/logicvc_interface.c        |  12 +
 drivers/gpu/drm/mcde/mcde_drv.c                    |   1 +
 drivers/gpu/drm/mcde/mcde_dsi.c                    |   1 +
 drivers/gpu/drm/mxsfb/mxsfb_drv.c                  |   2 +
 drivers/gpu/drm/nouveau/nouveau_drm.c              |   1 -
 drivers/gpu/drm/omapdrm/dss/output.c               |   1 +
 drivers/gpu/drm/panel/Kconfig                      |  11 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-edp.c                  |   4 +-
 drivers/gpu/drm/panel/panel-novatek-nt36536.c      | 488 ++++++++++++++
 drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c |  14 +-
 drivers/gpu/drm/panel/panel-samsung-sofef00.c      |   4 +
 drivers/gpu/drm/panel/panel-simple.c               |   3 +
 drivers/gpu/drm/panfrost/panfrost_device.c         |   1 -
 drivers/gpu/drm/panfrost/panfrost_device.h         |   1 -
 drivers/gpu/drm/pl111/pl111_drv.c                  |   1 +
 drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c  |   1 +
 drivers/gpu/drm/renesas/rcar-du/rcar_lvds.c        |   1 +
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c   |   1 +
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |  11 +
 drivers/gpu/drm/rockchip/rockchip_lvds.c           |   4 +
 drivers/gpu/drm/rockchip/rockchip_rgb.c            |   3 +
 drivers/gpu/drm/solomon/ssd130x.c                  |   9 +-
 drivers/gpu/drm/sti/sti_dvo.c                      |   3 +
 drivers/gpu/drm/stm/ltdc.c                         |   2 +
 drivers/gpu/drm/stm/lvds.c                         |  12 +-
 drivers/gpu/drm/sun4i/sun4i_lvds.c                 |  13 +
 drivers/gpu/drm/sun4i/sun4i_rgb.c                  |  13 +
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |   2 +
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c             |   6 +-
 drivers/gpu/drm/tegra/drm.c                        |   1 +
 drivers/gpu/drm/tegra/dsi.c                        |   5 +
 drivers/gpu/drm/tegra/falcon.c                     |  66 +-
 drivers/gpu/drm/tegra/falcon.h                     |  23 +
 drivers/gpu/drm/tegra/output.c                     |  24 +-
 drivers/gpu/drm/tegra/vic.c                        |  92 ++-
 drivers/gpu/drm/tegra/vic.h                        |   9 +-
 drivers/gpu/drm/tidss/tidss_kms.c                  |  16 +-
 drivers/gpu/drm/tve200/tve200_drv.c                |   2 +
 drivers/gpu/drm/v3d/v3d_drv.h                      |   5 +
 drivers/gpu/drm/v3d/v3d_submit.c                   |  92 ++-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |   8 +-
 drivers/gpu/host1x/Makefile                        |   3 +-
 drivers/gpu/host1x/bus.c                           |   2 +-
 drivers/gpu/host1x/cdma.c                          |   3 +-
 drivers/gpu/host1x/context.c                       |  13 +-
 drivers/gpu/host1x/debug.c                         |   4 +-
 drivers/gpu/host1x/dev.c                           |  41 ++
 drivers/gpu/host1x/hw/cdma_hw.c                    |  14 +-
 drivers/gpu/host1x/hw/channel_hw.c                 |  15 +-
 drivers/gpu/host1x/hw/host1x10.c                   |  33 +
 drivers/gpu/host1x/hw/host1x10.h                   |  15 +
 drivers/gpu/host1x/hw/host1x10_hardware.h          |  21 +
 drivers/gpu/host1x/hw/hw_host1x10_common.h         |   6 +
 drivers/gpu/host1x/hw/hw_host1x10_hypervisor.h     |  10 +
 drivers/gpu/host1x/hw/hw_host1x10_uclass.h         | 181 ++++++
 drivers/gpu/host1x/hw/hw_host1x10_vm.h             |  36 +
 drivers/gpu/host1x/intr.c                          |   5 +-
 drivers/gpu/host1x/job.c                           |   2 +-
 drivers/gpu/host1x/syncpt.c                        |   7 +-
 drivers/gpu/host1x/syncpt.h                        |   3 +-
 drivers/gpu/tests/gpu_buddy_test.c                 |  41 ++
 include/drm/drm_connector.h                        |   5 +-
 kernel/cgroup/dmem.c                               |  71 +-
 105 files changed, 2459 insertions(+), 302 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36536.yaml
 create mode 100644 drivers/gpu/drm/drm_panel.c.orig
 create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt36536.c
 create mode 100644 drivers/gpu/host1x/hw/host1x10.c
 create mode 100644 drivers/gpu/host1x/hw/host1x10.h
 create mode 100644 drivers/gpu/host1x/hw/host1x10_hardware.h
 create mode 100644 drivers/gpu/host1x/hw/hw_host1x10_common.h
 create mode 100644 drivers/gpu/host1x/hw/hw_host1x10_hypervisor.h
 create mode 100644 drivers/gpu/host1x/hw/hw_host1x10_uclass.h
 create mode 100644 drivers/gpu/host1x/hw/hw_host1x10_vm.h

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)
