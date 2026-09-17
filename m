Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B189C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:05:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DE7B10E67A;
	Thu, 17 Sep 2026 09:05:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="I7rf+C1D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YKNoRFXn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xbqu6ldP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3xZhq+ec";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCC9410E67A;
 Thu, 17 Sep 2026 09:05:47 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F1EFE1F74D;
 Thu, 17 Sep 2026 09:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789635941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PgCC5H3p7+0cvXeth4RrRTThzZGGG3LKFScykwMsYHs=;
 b=I7rf+C1DIegf3z45wYY0FQl+QExczvOFQ0KfjvTBq2jAzf1HwGUGt1Wh6cubKQ7vhbGfYa
 bYgBy9RLP6H4RkV500lW4yKnmt1dc9knNLBhxz526v7YKkbTyXHb+eC6zHvgacN3pwtPt0
 rG0zfquRD+aes4tiNm2CwredQI4o/GU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789635941;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PgCC5H3p7+0cvXeth4RrRTThzZGGG3LKFScykwMsYHs=;
 b=YKNoRFXn6/448hmgnQ9l4hiLY24sw7SMUmNhwxwtZq5a3/UObCnnOqzyCsnVbYc+uqyBo6
 Pbo/nHHsFnaMSAAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xbqu6ldP;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3xZhq+ec
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789635937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PgCC5H3p7+0cvXeth4RrRTThzZGGG3LKFScykwMsYHs=;
 b=xbqu6ldPyqnNPFG+vFFfDZNW98fF7EBKsMctk7SSB/ucCf4jcO+2ubvZM0jHFXTkRoHywR
 VCkPPgDnWpMPhwnliypYSZOgl/egne+4VlfwNoHp0pdJX+DFMUMqGVifLbkvWjIX/7nQJq
 bLxmkzXZ6+hX+9CTCGY2PnnCjfLTJEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789635937;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PgCC5H3p7+0cvXeth4RrRTThzZGGG3LKFScykwMsYHs=;
 b=3xZhq+ecs6cI5kAwfncIGrXPl1ArHy8WMIY9ruJD9YK3vIXt5UJ9hZghx6M3WSDxHHxITc
 8JT/nU4bzKbWwMCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70813134B3;
 Thu, 17 Sep 2026 09:05:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id p9sND2Ctq2pLFQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 17 Sep 2026 09:05:36 +0000
Date: Thu, 17 Sep 2026 11:05:34 +0200
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
Message-ID: <20260917090534.GA420415@2a02-2455-9062-2500-ec39-e8a6-193-9c05.dyn6.pyur.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: F1EFE1F74D
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_TO(0.00)[gmail.com,ffwll.ch];
 RCPT_COUNT_TWELVE(0.00)[16]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:url,suse.de:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
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

this is the weekly PR from drm-misc-next. The big highlight is Maxime's
rework of how atomic state is being created. Now with the create_state
callback instead of reset. These changes affect DRM drivers throughout
the tree.

UAPI-wise ivpu adds a parameter.

For cross-subsystem changes, there's a fix to the dma-fence documentation
and the vga_switcheroo code has been decoupled from fbcon.

Best regards
Thomas

drm-misc-next-2026-09-17:
drm-misc-next for v7.4:

UAPI Changes:

ivpu:
- add DRM_IVPU_CAP_CMDQ_SET_PRIORITY

Cross-subsystem Changes:

dma-fence:
- fix documentation

vga_switcheroo:
- disconnect from fbcon; update fbcon from within DRM fbdev emulation

Core Changes:

atomic:
- replace state reset callback with create_state throughout DRM core
and drivers

panic:
- split into core and helpers

sched:
- clean up interface

sysfs:
- drop drm_class_device_register()

Driver Changes:

amdxdna:
- fix BO handling

arcpgu:
- replace simple-display pipeline with regular atomic helpers

aspeed:
- replace simple-display pipeline with regular atomic helpers

gm12u320:
- replace simple-display pipeline with regular atomic helpers

imagination:
- various improvement to firmware interaction

ivpu:
- support command-queue priority ioctl

mcde:
- replace simple-display pipeline with regular atomic helpers

p111:
- replace simple-display pipeline with regular atomic helpers
- drop unsupported alpha formats from primary plane

panel:
- edp: Add support for BOE NV140FHM-T0A
- samsung: Share test-key helpers

rcar-du:
- support Renesas R-Car V4H DSC
- dsi: Support larger transfers with AXI memory

repaper:
- replace simple-display pipeline with regular atomic helpers

rockchip:
- dsi: improve PHY timings

ssd130x:
- support Solomon SSD1351 OLED plus DT bindings
- ssd133x: upgrade color format to RGB565

tve200:
- replace simple-display pipeline with regular atomic helpers

xen:
- replace simple-display pipeline with regular atomic helpers
The following changes since commit 75ee88dae80d8c1141ef850bda9a26dbd1fe3c21:

  drm/sysfb: Use preferred panel size for panel orientation quirks (2026-09-10 15:44:52 +0200)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-next-2026-09-17

for you to fetch changes up to a8fe4e162ba8212b7e51fdb024b37800f36b496c:

  accel/ivpu: Move register poll timeouts to vdev->timeout (2026-09-17 09:35:08 +0200)

----------------------------------------------------------------
drm-misc-next for v7.4:

UAPI Changes:

ivpu:
- add DRM_IVPU_CAP_CMDQ_SET_PRIORITY

Cross-subsystem Changes:

dma-fence:
- fix documentation

vga_switcheroo:
- disconnect from fbcon; update fbcon from within DRM fbdev emulation

Core Changes:

atomic:
- replace state reset callback with create_state throughout DRM core
and drivers

panic:
- split into core and helpers

sched:
- clean up interface

sysfs:
- drop drm_class_device_register()

Driver Changes:

amdxdna:
- fix BO handling

arcpgu:
- replace simple-display pipeline with regular atomic helpers

aspeed:
- replace simple-display pipeline with regular atomic helpers

gm12u320:
- replace simple-display pipeline with regular atomic helpers

imagination:
- various improvement to firmware interaction

ivpu:
- support command-queue priority ioctl

mcde:
- replace simple-display pipeline with regular atomic helpers

p111:
- replace simple-display pipeline with regular atomic helpers
- drop unsupported alpha formats from primary plane

panel:
- edp: Add support for BOE NV140FHM-T0A
- samsung: Share test-key helpers

rcar-du:
- support Renesas R-Car V4H DSC
- dsi: Support larger transfers with AXI memory

repaper:
- replace simple-display pipeline with regular atomic helpers

rockchip:
- dsi: improve PHY timings

ssd130x:
- support Solomon SSD1351 OLED plus DT bindings
- ssd133x: upgrade color format to RGB565

tve200:
- replace simple-display pipeline with regular atomic helpers

xen:
- replace simple-display pipeline with regular atomic helpers

----------------------------------------------------------------
Alessio Belle (3):
      drm/imagination: Remove duplicated CCB control initialisation
      drm/imagination: Manage FW VM context from its init and fini callbacks
      drm/imagination: Avoid initialisation of unused FW trace buffer pointer

Amit Barzilai (6):
      dt-bindings: display: Add Solomon SSD1351 OLED controller
      drm/ssd130x: Change SSD133X color format to RGB565 from RGB332
      drm/ssd130x: Constify ssd130x_write_data() 'values' parameter
      drm/ssd130x: Replace positional ssd130x_spi_id[] initialization with C99
      drm/ssd130x: Implement ssd130x_write_cmd() on top of ssd130x_write_cmds()
      drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support

Andrzej Kacprowski (1):
      accel/ivpu: Add support for getting and setting command queue priority

Chaoyi Chen (2):
      drm/rockchip: dsi: Add maximum per lane bit rate calculation
      drm/rockchip: dsi: Add dphy_get_timing support for multiple PHY types

Chen-Yu Tsai (1):
      drm/sysfb: Use iosys_map_memset() to clear buffer

Donggeun Yoo (1):
      drm/sched: Drop the unused entity argument from drm_sched_fence_alloc()

Jozef Wludzik (1):
      accel/ivpu: Synchronize context abort work with device reset

Karl Mehltretter (1):
      dma-fence: Fix dma_fence_enable_signaling() reference in kernel-doc

Linus Walleij (2):
      drm/panel: samsung: Add shared test key helpers
      drm/panel: samsung-s6e88a0-ams452ef01: Use test key helpers

Lizhi Hou (3):
      accel/amdxdna: Disable BO import via flink
      accel/amdxdna: Fix potential deadlock in BO open and close callbacks
      accel/amdxdna: Fix unsafe use of handle_mm_fault()

Luca Ceresoli (3):
      drm/mcde: dsi: simplify device_node management using scoped for_each variant
      drm/omap: dsi: remove unused includes
      drm/tve200: remove unused includes

Marek Vasut (3):
      dt-bindings: display: bridge: Document Renesas R-Car V4H DSC bindings
      drm/rcar-du: dsc: Add rudimentary Renesas R-Car V4H DSC driver
      drm/rcar-du: dsi: Implement DSI command TX using AXI memory access

Matt Coster (4):
      drm/imagination: Explicitly set CACHED flag on META FW
      drm/imagination: Unify repeated register defines
      drm/imagination: Move FWCORE_* macros to register defines
      drm/imagination: Collect KCCB initialisation

Maxime Ripard (76):
      drm/crtc: Introduce hw_reset helper hook
      drm/amdgpu: vkms: Switch to drm_atomic_helper_crtc_create_state
      drm/logicvc: Switch to drm_atomic_helper_crtc_create_state
      drm/tilcdc: Move hardware reset to hw_reset hook
      drm/tilcdc: Switch to drm_atomic_helper_crtc_create_state
      drm/amdgpu: dm: Convert to atomic_create_state
      drm/loongson: Move hardware reset to hw_reset hook
      drm/loongson: Convert to atomic_create_state
      drm/mediatek: Convert to atomic_create_state
      drm/sitronix: st7920: Convert to atomic_create_state
      drm/atomic: colorop: Rename state to state_to_destroy
      drm/atomic: Fix unused but set warning in state iterator macros
      drm/atomic_helper: Skip over NULL private_obj pointers
      drm/bridge: Implement atomic_print_state
      drm/atomic: Only call atomic_destroy_state on a !NULL pointer
      drm/atomic_helper: Pass nonblock to commit_tail
      drm/atomic: Convert drm_priv_to_bridge_state to container_of_const
      drm/simple-kms: Remove unused reset_plane hook
      drm/vkms: Move frame_info into vkms_plane_state
      drm/vkms: Convert to atomic_create_state
      drm/gem-atomic-helper: Remove __drm_gem_reset_shadow_plane()
      drm/amdgpu: Convert to atomic_create_state
      drm/fsl-dcu: Convert to atomic_create_state
      drm/hisilicon/kirin: Convert to atomic_create_state
      drm/imx/dc: Convert to atomic_create_state
      drm/kmb: Convert to atomic_create_state
      drm/logicvc: Convert to atomic_create_state
      drm/loongson: Convert to atomic_create_state
      drm/lcdif: Convert to atomic_create_state
      drm/mxsfb: Convert to atomic_create_state
      drm/qxl: Convert to atomic_create_state
      drm/rockchip: Convert to atomic_create_state
      drm/sprd: Convert to atomic_create_state
      drm/sti: Convert to atomic_create_state
      drm/stm: Convert to atomic_create_state
      drm/tests: kunit: Convert to atomic_create_state
      drm/tilcdc: Convert to atomic_create_state
      drm/vboxvideo: Convert to atomic_create_state
      drm/verisilicon: Convert to atomic_create_state
      drm/virtio: Convert to atomic_create_state
      drm/xlnx: Convert to atomic_create_state
      drm/amdgpu_dm: Convert to atomic_create_state
      drm/armada: Convert to atomic_create_state
      drm/atmel-hlcdc: Drop spurious csc_init call from reset
      drm/atmel-hlcdc: Convert to atomic_create_state
      drm/exynos: Convert to atomic_create_state
      drm/imx/ipuv3: Convert to atomic_create_state
      drm/mediatek: Convert to atomic_create_state
      drm/nouveau: Convert to atomic_create_state
      drm/omap: Convert to atomic_create_state
      drm/rcar-du: Convert to atomic_create_state
      drm/rz-du: Convert to atomic_create_state
      drm/shmobile: Convert to atomic_create_state
      drm/sun4i: layer: Convert to atomic_create_state
      drm/vmwgfx: Convert to atomic_create_state
      drm/amdgpu_dm: tests: Fix wrong variable declaration after merge conflict
      drm/arcgpu: Switch to drm_atomic_helper_crtc_create_state
      drm/aspeed: Switch to drm_atomic_helper_crtc_create_state
      drm/gm12u320: Switch to drm_atomic_helper_crtc_create_state
      drm/mcde: Switch to drm_atomic_helper_crtc_create_state
      drm/pl111: Switch to drm_atomic_helper_crtc_create_state
      drm/repaper: Switch to drm_atomic_helper_crtc_create_state
      drm/tve200: Switch to drm_atomic_helper_crtc_create_state
      drm/xen: Switch to drm_atomic_helper_crtc_create_state
      drm/atomic-helper: Remove drm_atomic_helper_crtc_reset
      drm/atomic-helper: Remove __drm_atomic_helper_crtc_reset
      drm/crtc: Remove reset
      drm/arcgpu: Switch to drm_atomic_helper_plane_create_state
      drm/aspeed: Switch to drm_atomic_helper_plane_create_state
      drm/mcde: Switch to drm_atomic_helper_plane_create_state
      drm/pl111: Switch to drm_atomic_helper_plane_create_state
      drm/tve200: Switch to drm_atomic_helper_plane_create_state
      drm/xen: Switch to drm_atomic_helper_plane_create_state
      drm/atomic-state-helper: Remove drm_atomic_helper_plane_reset()
      drm/atomic-state-helper: Remove __drm_atomic_helper_plane_reset()
      drm/plane: Remove reset

Maíra Canal (2):
      drm/v3d: Remove the now-redundant reset lock
      drm/sysfs: Remove drm_class_device_(un)register()

Mika Penttilä (1):
      drm/tests: hdmi: fix infoframes tests

Roshan Kumar (1):
      drm/pl111: drop alpha formats the hardware cannot scan out

Terry Hsiao (1):
      drm/panel-edp: Add BOE NV140FHM-T0A

Thomas Zimmermann (21):
      drm/edid: Include <linux/fb.h>
      drm/client: Add acquire_outputs callback; implement for fbdev emulation
      vga_switcheroo: Add pre_switch callback to client ops
      vga_switcheroo: Add post_switch callback to client ops
      drm: Implement struct vga_switcheroo_client_ops.pre_switch
      drm: Implement vga_switcheroo_client_ops.post_switch
      vga-switcheroo: Remove unused interfaces
      drm/panic: Do not use un-escaped URL as format string
      drm/panic: Test address from kmap op for NULL
      drm/panic: Return -EINVAL if font is not available
      drm/panic: Return errno codes if panic output fails
      drm/panic: Pass colors to draw_panic_dispatch()
      drm/panic: Pass global module parameters to drm_panic_dispatch()
      drm/panic: Return from screen_user if display is too small
      drm/panic: Retry in dispatch function if panic output fails
      drm/panic: Split draw_panic_plane()
      drm/panic: Restrict to primary planes
      drm/panic: Display panic screen via per-plane callback
      drm/panic: Internalize panic locking in DRM core and helpers
      drm/panic: Move panic display code into helper library
      drm/panic: Compile KUnit tests as module

Tomasz Rusinowicz (1):
      accel/ivpu: Move register poll timeouts to vdev->timeout

Tomi Valkeinen (1):
      drm/rcar-du: dsi: Support DSC in the pipeline

Ze Huang (8):
      drm/gm12u320: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/pl111: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/arcpgu: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/aspeed: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/mcde: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/repaper: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/tve200: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/xen: replace struct drm_simple_display_pipe with regular atomic helpers

 .../display/bridge/renesas,r8a779g0-dsc.yaml       |  96 +++
 .../bindings/display/solomon,ssd1351.yaml          |  42 +
 Documentation/gpu/drm-kms-helpers.rst              |  11 +-
 Documentation/gpu/drm-kms.rst                      |   3 +
 MAINTAINERS                                        |  11 +-
 drivers/accel/amdxdna/amdxdna_gem.c                | 185 +++-
 drivers/accel/ivpu/ivpu_drv.c                      |  13 +
 drivers/accel/ivpu/ivpu_drv.h                      |   3 +
 drivers/accel/ivpu/ivpu_hw.c                       |  22 +
 drivers/accel/ivpu/ivpu_hw_ip.c                    |   6 +-
 drivers/accel/ivpu/ivpu_job.c                      |  92 +-
 drivers/accel/ivpu/ivpu_job.h                      |   5 +-
 drivers/accel/ivpu/ivpu_mmu.c                      |  12 +-
 drivers/gpu/drm/Kconfig                            |   9 +-
 drivers/gpu/drm/Kconfig.debug                      |   1 +
 drivers/gpu/drm/Makefile                           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |   4 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  31 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h |   2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |  30 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h    |   2 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c  |  23 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_plane_test.c |  30 +-
 drivers/gpu/drm/armada/armada_overlay.c            |  39 +-
 drivers/gpu/drm/armada/armada_plane.c              |  15 +-
 drivers/gpu/drm/armada/armada_plane.h              |   2 +-
 drivers/gpu/drm/aspeed/aspeed_gfx.h                |  11 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c           | 203 +++--
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c            |   3 +-
 drivers/gpu/drm/ast/ast_mode.c                     |   2 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c    |  33 +-
 drivers/gpu/drm/clients/drm_fbdev_client.c         |  23 +-
 drivers/gpu/drm/drm_atomic.c                       |  32 +-
 drivers/gpu/drm/drm_atomic_helper.c                |  10 +-
 drivers/gpu/drm/drm_atomic_state_helper.c          |  86 --
 drivers/gpu/drm/drm_bridge.c                       |  21 +
 drivers/gpu/drm/drm_client_event.c                 |  18 +
 drivers/gpu/drm/drm_crtc_internal.h                |   2 -
 drivers/gpu/drm/drm_drv.c                          |   3 +-
 drivers/gpu/drm/drm_edid.c                         |   1 +
 drivers/gpu/drm/drm_gem_atomic_helper.c            |  20 -
 drivers/gpu/drm/drm_kms_helper_common.c            |  14 +
 drivers/gpu/drm/drm_mode_config.c                  |  21 +-
 drivers/gpu/drm/drm_modeset_helper.c               |   2 +
 drivers/gpu/drm/drm_panic.c                        | 927 ++-------------------
 drivers/gpu/drm/drm_panic_helper.c                 | 919 ++++++++++++++++++++
 .../{drm_panic_qr.rs => drm_panic_helper_qr.rs}    |   4 +-
 drivers/gpu/drm/drm_panic_internal.h               |  69 ++
 drivers/gpu/drm/drm_sysfs.c                        |  32 -
 drivers/gpu/drm/exynos/exynos_drm_plane.c          |  22 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c        |   2 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c    |   2 +-
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c        |   2 +
 drivers/gpu/drm/i915/display/i9xx_plane.c          |   3 +
 drivers/gpu/drm/i915/display/skl_universal_plane.c |   4 +
 drivers/gpu/drm/i915/i915_switcheroo.c             |  11 +-
 drivers/gpu/drm/imagination/pvr_ccb.c              |  43 +-
 drivers/gpu/drm/imagination/pvr_device.c           |  25 +-
 drivers/gpu/drm/imagination/pvr_fw.c               |  23 +-
 drivers/gpu/drm/imagination/pvr_fw.h               |   2 +-
 drivers/gpu/drm/imagination/pvr_fw_meta.c          |  18 +-
 drivers/gpu/drm/imagination/pvr_fw_riscv.c         |  40 +-
 drivers/gpu/drm/imagination/pvr_fw_startstop.c     |  22 +-
 drivers/gpu/drm/imagination/pvr_fw_trace.c         |   1 -
 drivers/gpu/drm/imagination/pvr_rogue_cr_defs.h    | 920 +++-----------------
 drivers/gpu/drm/imagination/pvr_rogue_defs.h       |  22 +-
 drivers/gpu/drm/imagination/pvr_rogue_riscv.h      |   2 -
 drivers/gpu/drm/imx/dc/dc-plane.c                  |   2 +-
 drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c            |  21 +-
 drivers/gpu/drm/kmb/kmb_plane.c                    |   2 +-
 drivers/gpu/drm/logicvc/logicvc_crtc.c             |   2 +-
 drivers/gpu/drm/logicvc/logicvc_layer.c            |   2 +-
 drivers/gpu/drm/loongson/lsdc_crtc.c               |  30 +-
 drivers/gpu/drm/loongson/lsdc_plane.c              |   2 +-
 drivers/gpu/drm/mcde/mcde_display.c                | 272 +++---
 drivers/gpu/drm/mcde/mcde_drm.h                    |  12 +-
 drivers/gpu/drm/mcde/mcde_drv.c                    |   3 +-
 drivers/gpu/drm/mcde/mcde_dsi.c                    |   8 +-
 drivers/gpu/drm/mediatek/mtk_crtc.c                |  18 +-
 drivers/gpu/drm/mediatek/mtk_plane.c               |  21 +-
 drivers/gpu/drm/mgag200/mgag200_drv.h              |   4 +-
 drivers/gpu/drm/mxsfb/lcdif_kms.c                  |   2 +-
 drivers/gpu/drm/mxsfb/mxsfb_kms.c                  |   2 +-
 drivers/gpu/drm/nouveau/dispnv50/wndw.c            |  17 +-
 drivers/gpu/drm/nouveau/nouveau_vga.c              |  28 +-
 drivers/gpu/drm/omapdrm/dss/dsi.c                  |   1 -
 drivers/gpu/drm/omapdrm/omap_drv.c                 |   1 -
 drivers/gpu/drm/omapdrm/omap_plane.c               |  13 +-
 drivers/gpu/drm/panel/panel-edp.c                  |   1 +
 drivers/gpu/drm/panel/panel-samsung-dsi.h          |  38 +
 drivers/gpu/drm/panel/panel-samsung-s6e3fc2x01.c   |  71 +-
 drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c      |  70 +-
 .../drm/panel/panel-samsung-s6e88a0-ams452ef01.c   |   6 +-
 .../gpu/drm/panel/panel-samsung-s6e8fc0-m1906f9.c  |  23 +-
 drivers/gpu/drm/panel/panel-samsung-sofef00.c      |  15 +-
 drivers/gpu/drm/pl111/pl111_display.c              | 207 +++--
 drivers/gpu/drm/pl111/pl111_drm.h                  |   5 +-
 drivers/gpu/drm/pl111/pl111_drv.c                  |  19 +-
 drivers/gpu/drm/pl111/pl111_versatile.c            |  18 -
 drivers/gpu/drm/qxl/qxl_display.c                  |   4 +-
 drivers/gpu/drm/radeon/radeon_device.c             |   9 +-
 drivers/gpu/drm/renesas/rcar-du/Kconfig            |  12 +
 drivers/gpu/drm/renesas/rcar-du/Makefile           |   1 +
 drivers/gpu/drm/renesas/rcar-du/rcar_dsc.c         | 153 ++++
 drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c  |  17 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c    |  19 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c      |  17 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c    |  51 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c       |  15 +-
 drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c |  19 +-
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c    |  66 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |   2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c       |   2 +-
 drivers/gpu/drm/scheduler/sched_fence.c            |   3 +-
 drivers/gpu/drm/scheduler/sched_internal.h         |   3 +-
 drivers/gpu/drm/scheduler/sched_main.c             |   2 +-
 drivers/gpu/drm/sitronix/st7920.c                  |  12 +-
 drivers/gpu/drm/solomon/ssd130x-spi.c              |  25 +-
 drivers/gpu/drm/solomon/ssd130x.c                  | 421 ++++++++--
 drivers/gpu/drm/solomon/ssd130x.h                  |  10 +-
 drivers/gpu/drm/sprd/sprd_dpu.c                    |   2 +-
 drivers/gpu/drm/sti/sti_cursor.c                   |   2 +-
 drivers/gpu/drm/sti/sti_gdp.c                      |   2 +-
 drivers/gpu/drm/sti/sti_hqvdp.c                    |   2 +-
 drivers/gpu/drm/stm/ltdc.c                         |   2 +-
 drivers/gpu/drm/sun4i/sun4i_layer.c                |  21 +-
 drivers/gpu/drm/sysfb/drm_sysfb_helper.h           |   4 +-
 drivers/gpu/drm/sysfb/drm_sysfb_modeset.c          |   8 +-
 drivers/gpu/drm/sysfb/vesadrm.c                    |   1 +
 drivers/gpu/drm/tests/Makefile                     |   1 +
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c |  54 --
 drivers/gpu/drm/tests/drm_kunit_helpers.c          |   2 +-
 .../{drm_panic_test.c => drm_panic_helper_test.c}  |  75 +-
 drivers/gpu/drm/tidss/tidss_plane.c                |   2 +
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c               |   7 +-
 drivers/gpu/drm/tilcdc/tilcdc_plane.c              |   2 +-
 drivers/gpu/drm/tiny/arcpgu.c                      | 201 +++--
 drivers/gpu/drm/tiny/bochs.c                       |   4 +-
 drivers/gpu/drm/tiny/gm12u320.c                    | 138 ++-
 drivers/gpu/drm/tiny/repaper.c                     | 138 ++-
 drivers/gpu/drm/ttm/ttm_module.c                   |   1 -
 drivers/gpu/drm/tve200/tve200_display.c            | 220 +++--
 drivers/gpu/drm/tve200/tve200_drm.h                |   6 +-
 drivers/gpu/drm/tve200/tve200_drv.c                |  12 +-
 drivers/gpu/drm/v3d/v3d_drv.h                      |   6 -
 drivers/gpu/drm/v3d/v3d_gem.c                      |   3 -
 drivers/gpu/drm/v3d/v3d_sched.c                    |   4 -
 drivers/gpu/drm/vboxvideo/vbox_mode.c              |   2 +-
 drivers/gpu/drm/verisilicon/vs_cursor_plane.c      |   2 +-
 drivers/gpu/drm/verisilicon/vs_plane.c             |  14 +-
 drivers/gpu/drm/verisilicon/vs_plane.h             |   2 +-
 drivers/gpu/drm/verisilicon/vs_primary_plane.c     |   2 +-
 drivers/gpu/drm/virtio/virtgpu_plane.c             |   4 +-
 drivers/gpu/drm/vkms/vkms_composer.c               |  30 +-
 drivers/gpu/drm/vkms/vkms_drv.h                    |   2 +-
 drivers/gpu/drm/vkms/vkms_formats.c                |  48 +-
 drivers/gpu/drm/vkms/vkms_plane.c                  |  36 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |  17 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |   4 +-
 drivers/gpu/drm/xen/xen_drm_front.h                |   6 +-
 drivers/gpu/drm/xen/xen_drm_front_kms.c            | 188 +++--
 drivers/gpu/drm/xlnx/zynqmp_kms.c                  |   2 +-
 drivers/gpu/vga/vga_switcheroo.c                   |  41 +-
 drivers/video/fbdev/core/fbcon.c                   |   8 -
 include/drm/drm_atomic.h                           |  89 +-
 include/drm/drm_atomic_state_helper.h              |   6 -
 include/drm/drm_client.h                           |  14 +
 include/drm/drm_client_event.h                     |   3 +
 include/drm/drm_crtc.h                             |  12 -
 include/drm/drm_gem_atomic_helper.h                |   2 -
 include/drm/drm_mode_config.h                      |   4 +-
 include/drm/drm_modeset_helper_vtables.h           |  25 +-
 include/drm/drm_panic.h                            | 117 +--
 include/drm/drm_panic_helper.h                     |  41 +
 include/drm/drm_plane.h                            |  69 +-
 include/drm/drm_simple_kms_helper.h                |   1 -
 include/drm/drm_sysfs.h                            |   4 -
 include/linux/dma-fence.h                          |   2 +-
 include/linux/vga_switcheroo.h                     |  29 +-
 include/uapi/drm/ivpu_accel.h                      |  17 +-
 rust/bindings/bindings_helper.h                    |   4 +-
 185 files changed, 4479 insertions(+), 3418 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/renesas,r8a779g0-dsc.yaml
 create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd1351.yaml
 create mode 100644 drivers/gpu/drm/drm_panic_helper.c
 rename drivers/gpu/drm/{drm_panic_qr.rs => drm_panic_helper_qr.rs} (99%)
 create mode 100644 drivers/gpu/drm/drm_panic_internal.h
 create mode 100644 drivers/gpu/drm/panel/panel-samsung-dsi.h
 create mode 100644 drivers/gpu/drm/renesas/rcar-du/rcar_dsc.c
 rename drivers/gpu/drm/tests/{drm_panic_test.c => drm_panic_helper_test.c} (77%)
 create mode 100644 include/drm/drm_panic_helper.h

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)
