Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E3ACA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 12:07:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F098C10E58F;
	Fri,  2 Oct 2026 12:07:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="MYHlytzp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="waM5Hq5C";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Tyb5uqbb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="96tx19bW";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18E0D10E587;
 Fri,  2 Oct 2026 12:07:32 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 47D3E1FE35;
 Fri,  2 Oct 2026 12:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790942846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BNciiRCIGQU5OdthUxkMF8NrZXx+0F9d9LZOEZ5esqA=;
 b=MYHlytzpa2isbi77aoI44q+5WeWHYeaFwOhnFAhcXKZ2Je1uATbZvkyGMqCdCJdyE+9bnV
 uDHmWG8YAegW7Seg3DppYJ98pJtLyUhn+Pb0dOiRdD+iu0/nSVwUcIRG9kTCg9Njnq42VV
 tXnrDUNmCe72tYcCxGcPy0UGuLE7kXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790942846;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BNciiRCIGQU5OdthUxkMF8NrZXx+0F9d9LZOEZ5esqA=;
 b=waM5Hq5C+sVFhfRqBy/2JZhG7dLWWUcPSLzjI7byVzhhnN4HxqAu945p51ETwvRnr3zNdG
 89Re8FvsErFHPKDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Tyb5uqbb;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=96tx19bW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790942842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BNciiRCIGQU5OdthUxkMF8NrZXx+0F9d9LZOEZ5esqA=;
 b=Tyb5uqbbGDXfSgpjWCzNy1YHDnPbo5lTjTwL9ipcZWBxkQb06y1J045WHAYcoiCqa5EKEd
 /uhIycWX9W9uGo+HawcpY2NT342OVXe/MHSvj+oeA7rXJpqywRepo7Fkh5XgIwfY7uBwTv
 S/n2NcspOgHnA8fSGFQ+/aHJMkUsSMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790942842;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BNciiRCIGQU5OdthUxkMF8NrZXx+0F9d9LZOEZ5esqA=;
 b=96tx19bW+9I9eEAB0xm05j1EFUTccR3DeP34p7UWNZqXTYutAUCHKg2JtTdK/vRIWqwoSg
 ypUmrHFZanWaNfAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9333F13C70;
 Fri,  2 Oct 2026 12:07:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6VU+HHmev2r+JwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 02 Oct 2026 12:07:21 +0000
Date: Fri, 2 Oct 2026 14:07:20 +0200
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
Message-ID: <20261002120720.GA720384@linux.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 47D3E1FE35
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com,ffwll.ch];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[16];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, suse.de:dkim,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
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

here's the second PR from drm-misc-next in this week. This one has the
additonal fixes for the panel/bridge changes. It also brings resource
partitionaing on host1x and better handlign of syncobjs on tegra.

From the first PR we still have support for the 10" RasPi Touch Display 2
and for the Renesas RZ/G3L SoC. For internal changes, there's a larger
refactoring in how the panel code interacts with bridges. And, of course,
there's the usual number of fixes and clean ups.

Each tag lists its individual changes. The list below contains all of the
week's change merged into one.

Best regards
Thomas

drm-misc-next-2026-10-02:
drm-misc-next for v7.4:

Cross-subsystem Changes:

Documentation:
- Fix indention in display-related DT bindings

Core Changes:

- Provide helpers for calculating absolute and relative timeouts

clients:
- fbdev: Move helpers from drm_kms_helper.ko to drm_client_lib.ko

display:
- dp/mst: Improve DPCD compliance

sched:
- Fix locking

Driver Changes:

amdxdna:
- Support AIE2 rev 9
- Fix UAF access in scheduler fences
- Update workqueue interface

bridge:
- Select DRM_PANEL_BRIDGE for various drivers that require it

host1x:
- Support partitioning

imagination
- Clean up firmware interface

imx:
- Replace simple-display with regular atomic helpers

ivpu:
- Simplify NULL-pointer handling in cleanup code

mxsfb:
- Support bus formats plus DT bindings

panel:
- ebbg-ft8719: Fix MODULE_LICENSE() string; Improve initialization
- edp: NV140WU2-M70
- ilitek-ili9882t: Support Ilitek IL79600A plus DT bindings
- simple: Support Truly TFT320240-229-E plus DT bindings; Support BOE
  DV215FHM-R01 plus DT bindings
- Refactor struct drm_panel to contain struct drm_bridge plus fallout in
  various panel drivers

panthor:
- Validate user-space input against firmware limits

renesas:
- Support RZ/G3L SoC

ssd130x:
- ssd132x: Set correct hardware window when clearing screen

tegra:
- Improve syncobj handling on submit

tve200:
- Fix interrupt DT bindings

The following changes since commit 6e375de99d0c420169481fcd36064177ab55b09d:

  drm/v3d: Skip perfmon serialization while a global perfmon is set (2026-09-23 14:28:57 -0300)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-next-2026-10-02

for you to fetch changes up to 589e63c53a9a57cd3c14cff2ea42ad606c1e2a24:

  drm/tegra: Wait for syncpoint syncobj_in fences in hardware (2026-10-02 01:02:54 +0200)

----------------------------------------------------------------
drm-misc-next for v7.4:

Driver Changes:

host1x:
- support partitioning

panel:
- fix fallout from bridge-related changes

tegra:
- improve syncobj handling on submit

----------------------------------------------------------------
Alessio Belle (2):
      drm/imagination: Treat FW connection ctl like other interface structures
      drm/imagination: Don't map FW interface structures unnecessarily

Alexander Sverdlin (1):
      dt-bindings: display: simple: Add Truly TFT320240-229-E panel

Andrzej Kacprowski (1):
      accel/ivpu: Make BO free helper NULL-safe

Biju Das (7):
      drm: renesas: rzg2l_mipi_dsi: Add dphyctrl0_init_val to hw_info
      drm: renesas: rzg2l_mipi_dsi: Add activation_dly to hw_info
      drm: renesas: rzg2l_mipi_dsi: Move global timings into hardware info struct
      drm: renesas: rzg2l_mipi_dsi: Add support for DSI PWRRDY
      drm: renesas: rzg2l_mipi_dsi: Add RZ/G3L MIPI DSI support
      drm: renesas: rz-du: Add RZ/G3L (R9A08G046) DU support
      drm: renesas: rz-du: Add support for RZ/G3L LVDS encoder

Casey Connolly (1):
      drm/panel: ebbg-ft8719: Set prepare_prev_first

David Heidelberg (2):
      drm/panel: ebbg-ft8719: Fix the MODULE_LICENSE() string
      drm/panel: ebbg-ft8719: Split initialization into enable/disable fn

Fabio Piparo (1):
      drm/ssd130x: Set the address window in ssd132x_clear_screen()

Francesco Dolcini (2):
      dt-bindings: lcdif: Add endpoint bus-width property
      drm: mxsfb: Add optional DPI output bus-width configuration

Frank Bodammer (1):
      drm/panel: simple: Add support for Truly TFT320240-229-E panel

George Karagounis (1):
      accel/amdxdna: Replace create_singlethread_workqueue with alloc_ordered_workqueue

Haikun Zhou (1):
      drm/panel-edp: Support NV140WU2-M70 edp panel

Krzysztof Kozlowski (1):
      dt-bindings: display: Use consistent indentation in the example

Linus Walleij (1):
      dt-bindings: display: faraday,tve200: Use a level-high interrupt

Lizhi Hou (2):
      accel/amdxdna: Preallocate hardware context schedulers
      accel/amdxdna: Add support for AIE2 revision 9

Luca Ceresoli (33):
      drm/bridge: tc358764: don't select unused DRM_PANEL
      drm/bridge: ti-dlpc3433: don't depend on DRM_PANEL, select DRM_PANEL_BRIDGE
      drm/bridge: nxp-ptn3460: select DRM_PANEL_BRIDGE, not DRM_PANEL
      drm/bridge: parade-ps8622: select DRM_PANEL_BRIDGE, not DRM_PANEL
      drm/bridge: tc358775: select DRM_PANEL_BRIDGE, not DRM_PANEL
      drm/bridge: tc358767: select DRM_PANEL_BRIDGE
      drm/bridge: tc358768: select DRM_PANEL_BRIDGE
      drm/bridge: ssd2825: select DRM_PANEL_BRIDGE
      drm/bridge: tc358764: select DRM_PANEL_BRIDGE
      drm: of: move drm_of_find_panel_or_bridge() from drm_of.c to drm_panel.c
      drm: of: remove now unnecessary forward declarations
      drm/panel: move to a new module
      drm/bridge: panel: move all code to drm_panel.c
      drm/panel: embed a drm_bridge into every drm_panel
      drm/bridge: remove devm_drm_put_bridge()
      drm/panel: deprecate panel-bridge APIs
      drm/todo: add entry for removing the panel_bridge API
      drm/bridge: tc358767: don't create a panel_bridge
      drm/bridge: waveshare-dsi: don't create a panel_bridge
      drm/mcde: dsi: remove unused includes
      drm/mcde: dsi: don't create a panel_bridge
      drm/bridge: fsl-ldb: don't create a panel_bridge
      drm/bridge: samsung-dsim: don't create a panel_bridge
      drm/bridge: tc358768: don't create a panel_bridge
      drm/bridge: ssd2825: don't create a panel_bridge
      drm/omap: dss: don't create a panel_bridge
      drm/tve200: don't create a panel_bridge
      drm/bridge: analogix_dp: don't create a panel_bridge
      drm/imx/lcdc: stop using deprecated devm_drm_of_get_bridge()
      drm: verisilicon: stop using deprecated devm_drm_of_get_bridge()
      drm/bridge: dw-mipi-dsi: stop using deprecated devm_drm_of_get_bridge()
      drm/bridge: dw-mipi-dsi2: stop using deprecated devm_drm_of_get_bridge()
      drm: renesas: shmobile: stop using deprecated devm_drm_of_get_bridge()

Marek Vasut (4):
      dt-bindings: display: panel: Document 10" Raspberry Pi Touch Display 2
      drm/panel: ilitek-ili9882t: Make enable GPIO optional
      drm/panel: ilitek-ili9882t: Set prepare_prev_first
      drm/panel: ilitek-ili9882t: Add support for Ilitek IL79600A-based panels

Maíra Canal (7):
      drm: Move drm_timeout_abs_to_jiffies() to drm_timeout.c
      drm: Add drm_timeout_rel_to_jiffies()
      drm/amdgpu: Use drm_timeout_abs_to_jiffies()
      drm/v3d: Use drm_timeout_rel_to_jiffies()
      drm/i915: Use drm_timeout_rel_to_jiffies()
      drm/vc4: Use drm_timeout_rel_to_jiffies()
      drm: Rename drm_utils.h to drm_panel_quirks.h

Mikko Perttunen (12):
      dt-bindings: display: tegra: Make non-vm registers optional
      dt-bindings: display: tegra: Add channel/syncpoint range properties
      gpu: host1x: Support running without hv/common registers
      gpu: host1x: Allow limiting usable channel and syncpoint ranges
      gpu: host1x: Memory context stealing
      gpu: host1x: Add option for disabling context stealing
      drm/tegra: Fix syncobj_in wait return value check
      drm/tegra: Don't pass an ERR_PTR to drm_syncobj_replace_fence()
      drm/tegra: Drop reference on postfence
      drm/tegra: Remove unused includes from submit.c
      gpu: host1x: Add host1x_fence_extract()
      drm/tegra: Wait for syncpoint syncobj_in fences in hardware

Osama Abdelkader (1):
      drm/panthor: validate userspace queue count against initialized firmware slot count

Philipp Stanner (2):
      drm/sched: Remove forgotten header
      drm/sched: Protect entity->last_scheduled with spinlock

Randy Dunlap (1):
      Documentation/gpu: fix location of drm_panel kernel-doc

Sasha Levin (1):
      drm/panel: select DRM_KMS_HELPER

Thomas Zimmermann (2):
      drm/fbdev: Move fbdev module parameters next to module init
      drm/fbdev: Move fbdev helpers into client library

Vishnu Saini (2):
      dt-bindings: display: simple: Add boe,dv215fhm-r01 compatible
      drm/panel: simple: Add BOE DV215FHM-R01 panel

Xiao Lu (1):
      drm/dp/mst: reject DPCD read/write on ports with ddps=0

Ze Huang (2):
      drm/imx/lcdc: avoid duplicate clk_per enable
      drm/imx: replace struct drm_simple_display_pipe with regular atomic helpers

 .../display/allwinner,sun6i-a31-mipi-dsi.yaml      |  10 +-
 .../display/bridge/fsl,imx8qxp-pxl2dpi.yaml        |   4 +-
 .../bindings/display/bridge/lontium,lt8912b.yaml   |   8 +-
 .../bridge/megachips,stdp2690-ge-b850v3-fw.yaml    |   2 +-
 .../bindings/display/bridge/nxp,tda998x.yaml       |   2 +-
 .../bindings/display/bridge/toshiba,tc358764.yaml  |   2 +-
 .../bindings/display/bridge/toshiba,tc358775.yaml  |  12 +-
 .../bindings/display/faraday,tve200.yaml           |   2 +-
 .../devicetree/bindings/display/fsl,lcdif.yaml     |  12 +-
 .../devicetree/bindings/display/himax,hx8357.yaml  |   2 +-
 .../bindings/display/imx/fsl,imx-lcdc.yaml         |   2 +-
 .../bindings/display/imx/fsl,imx6q-ldb.yaml        |  54 +-
 .../bindings/display/mediatek/mediatek,ethdr.yaml  |  90 +--
 .../bindings/display/mediatek/mediatek,hdmi.yaml   |  24 +-
 .../bindings/display/panel/ilitek,il79900a.yaml    |  13 +-
 .../panel/panel-simple-lvds-dual-ports.yaml        |   2 +
 .../bindings/display/panel/panel-simple.yaml       |   2 +
 .../bindings/display/panel/samsung,ams495qa01.yaml |   2 +-
 .../bindings/display/sitronix,st7567.yaml          |   4 +-
 .../devicetree/bindings/display/st,stm32-dsi.yaml  |  46 +-
 .../devicetree/bindings/display/st,stm32-ltdc.yaml |   6 +-
 .../bindings/display/st,stm32mp25-lvds.yaml        |   4 +-
 .../display/tegra/nvidia,tegra20-host1x.yaml       |  52 +-
 Documentation/gpu/drm-kms-helpers.rst              |   8 +-
 Documentation/gpu/todo.rst                         |  33 +-
 drivers/accel/amdxdna/aie2_ctx.c                   | 117 +++-
 drivers/accel/amdxdna/aie2_msg_priv.h              |   1 +
 drivers/accel/amdxdna/aie2_pci.c                   |  15 +-
 drivers/accel/amdxdna/aie2_pci.h                   |   6 +-
 drivers/accel/amdxdna/amdxdna_mailbox.c            |   2 +-
 drivers/accel/amdxdna/npu4_regs.c                  |   1 +
 drivers/accel/ethosu/ethosu_drv.c                  |   2 +-
 drivers/accel/ivpu/ivpu_fw.c                       |  65 +-
 drivers/accel/ivpu/ivpu_gem.c                      |   5 +-
 drivers/accel/ivpu/ivpu_ipc.c                      |  11 +-
 drivers/accel/ivpu/ivpu_job.c                      |   6 +-
 drivers/accel/ivpu/ivpu_ms.c                       |  17 +-
 drivers/accel/rocket/rocket_gem.c                  |   2 +-
 drivers/gpu/drm/Kconfig                            |   7 +-
 drivers/gpu/drm/Makefile                           |   5 +-
 drivers/gpu/drm/adp/adp-mipi.c                     |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |   2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   1 -
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |   1 -
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c   |   1 +
 drivers/gpu/drm/armada/armada_fbdev.c              |   2 +-
 drivers/gpu/drm/bridge/Kconfig                     |  18 +-
 drivers/gpu/drm/bridge/analogix/Kconfig            |   1 +
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  40 +-
 drivers/gpu/drm/bridge/aux-bridge.c                |   1 +
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c     |   1 +
 drivers/gpu/drm/bridge/fsl-ldb.c                   |  19 +-
 drivers/gpu/drm/bridge/imx/imx93-pdfc.c            |   1 +
 drivers/gpu/drm/bridge/panel.c                     | 563 -----------------
 drivers/gpu/drm/bridge/samsung-dsim.c              |  24 +-
 drivers/gpu/drm/bridge/ssd2825.c                   |  23 +-
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      |  11 +-
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c     |  11 +-
 drivers/gpu/drm/bridge/tc358767.c                  |  64 +-
 drivers/gpu/drm/bridge/tc358768.c                  |  25 +-
 drivers/gpu/drm/bridge/ti-tdp158.c                 |   1 +
 drivers/gpu/drm/bridge/waveshare-dsi.c             |  17 +-
 drivers/gpu/drm/clients/Makefile                   |   3 +-
 drivers/gpu/drm/clients/drm_fbdev_client.c         |   2 +-
 .../drm_fbdev_helper.c}                            |  34 +-
 drivers/gpu/drm/display/drm_bridge_connector.c     |   1 +
 drivers/gpu/drm/display/drm_dp_mst_topology.c      |   6 +
 drivers/gpu/drm/drm_bridge.c                       |  17 -
 drivers/gpu/drm/drm_connector.c                    |   2 +-
 drivers/gpu/drm/drm_crtc_helper_internal.h         |   9 +
 drivers/gpu/drm/drm_fbdev_dma.c                    |   2 +-
 drivers/gpu/drm/drm_fbdev_shmem.c                  |   2 +-
 drivers/gpu/drm/drm_fbdev_ttm.c                    |   2 +-
 drivers/gpu/drm/drm_kms_helper_common.c            |  39 ++
 drivers/gpu/drm/drm_of.c                           |  63 --
 drivers/gpu/drm/drm_panel.c                        | 664 +++++++++++++++++++--
 drivers/gpu/drm/drm_panel_backlight_quirks.c       |   2 +-
 drivers/gpu/drm/drm_panel_orientation_quirks.c     |   2 +-
 drivers/gpu/drm/drm_syncobj.c                      |  35 +-
 drivers/gpu/drm/drm_timeout.c                      |  95 +++
 drivers/gpu/drm/exynos/exynos_dp.c                 |  36 +-
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c          |   2 +-
 drivers/gpu/drm/gma500/fbdev.c                     |   2 +-
 drivers/gpu/drm/i915/display/intel_fbdev.c         |   2 +-
 drivers/gpu/drm/i915/gem/i915_gem_wait.c           |  17 +-
 drivers/gpu/drm/imagination/pvr_fw.c               | 130 ++--
 drivers/gpu/drm/imagination/pvr_fw.h               |  18 +-
 drivers/gpu/drm/imx/dc/dc-kms.c                    |   1 +
 drivers/gpu/drm/imx/dcss/Kconfig                   |   1 +
 drivers/gpu/drm/imx/lcdc/imx-lcdc.c                | 261 +++++---
 drivers/gpu/drm/ingenic/Kconfig                    |   1 +
 drivers/gpu/drm/lima/lima_gem.c                    |   2 +-
 drivers/gpu/drm/logicvc/Kconfig                    |   1 +
 drivers/gpu/drm/mcde/Kconfig                       |   2 +-
 drivers/gpu/drm/mcde/mcde_display.c                |   1 +
 drivers/gpu/drm/mcde/mcde_dsi.c                    |  45 +-
 drivers/gpu/drm/msm/dp/dp_display.c                |   1 +
 drivers/gpu/drm/msm/dsi/dsi.c                      |   3 +-
 drivers/gpu/drm/msm/msm_debugfs.c                  |   2 +-
 drivers/gpu/drm/msm/msm_fbdev.c                    |   2 +-
 drivers/gpu/drm/mxsfb/mxsfb_drv.c                  |  43 ++
 drivers/gpu/drm/mxsfb/mxsfb_drv.h                  |   2 +
 drivers/gpu/drm/mxsfb/mxsfb_kms.c                  |  12 +
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |   1 -
 drivers/gpu/drm/omapdrm/dss/omapdss.h              |   1 -
 drivers/gpu/drm/omapdrm/dss/output.c               |  42 +-
 drivers/gpu/drm/omapdrm/omap_debugfs.c             |   2 +-
 drivers/gpu/drm/omapdrm/omap_fbdev.c               |   2 +-
 drivers/gpu/drm/panel/Kconfig                      |   3 +-
 drivers/gpu/drm/panel/panel-ebbg-ft8719.c          |  23 +-
 drivers/gpu/drm/panel/panel-edp.c                  |   1 +
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c      | 234 +++++++-
 drivers/gpu/drm/panel/panel-simple.c               |  57 ++
 drivers/gpu/drm/panfrost/panfrost_drv.c            |   2 +-
 drivers/gpu/drm/panthor/panthor_drv.c              |   1 -
 drivers/gpu/drm/panthor/panthor_sched.c            |   3 +
 drivers/gpu/drm/pl111/Kconfig                      |   1 +
 drivers/gpu/drm/radeon/radeon_device.c             |   2 +-
 drivers/gpu/drm/radeon/radeon_fbdev.c              |   2 +-
 drivers/gpu/drm/renesas/rz-du/Kconfig              |  13 +
 drivers/gpu/drm/renesas/rz-du/Makefile             |   1 +
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c       |  24 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h       |   3 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c   |  24 +
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c     | 162 ++++-
 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c         | 275 +++++++++
 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h    |  25 +
 drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c  |   5 +-
 drivers/gpu/drm/rockchip/Kconfig                   |   2 +
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |  11 -
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c        |   2 +-
 drivers/gpu/drm/scheduler/sched_entity.c           |  51 +-
 drivers/gpu/drm/scheduler/sched_main.c             |   1 -
 drivers/gpu/drm/sitronix/st7571.c                  |   1 -
 drivers/gpu/drm/solomon/ssd130x.c                  |  30 +-
 drivers/gpu/drm/stm/Kconfig                        |   1 +
 drivers/gpu/drm/tegra/fbdev.c                      |   2 +-
 drivers/gpu/drm/tegra/rgb.c                        |   1 +
 drivers/gpu/drm/tegra/submit.c                     | 145 ++++-
 drivers/gpu/drm/tegra/uapi.c                       |  51 +-
 drivers/gpu/drm/tegra/uapi.h                       |   3 +-
 drivers/gpu/drm/tidss/Kconfig                      |   1 +
 drivers/gpu/drm/tve200/Kconfig                     |   2 +-
 drivers/gpu/drm/tve200/tve200_drm.h                |   1 -
 drivers/gpu/drm/tve200/tve200_drv.c                |  31 +-
 drivers/gpu/drm/v3d/v3d_bo.c                       |   3 +-
 drivers/gpu/drm/v3d/v3d_drv.h                      |  10 -
 drivers/gpu/drm/vboxvideo/vbox_mode.c              |   2 +-
 drivers/gpu/drm/vc4/vc4_gem.c                      |   3 +-
 drivers/gpu/drm/verisilicon/vs_bridge.c            |  11 +-
 drivers/gpu/drm/verisilicon/vs_bridge.h            |   1 -
 drivers/gpu/drm/xe/xe_wait_user_fence.c            |   2 +-
 drivers/gpu/host1x/channel.c                       |   6 +-
 drivers/gpu/host1x/context.c                       | 383 +++++++++++-
 drivers/gpu/host1x/context.h                       |  18 +-
 drivers/gpu/host1x/dev.c                           |  52 +-
 drivers/gpu/host1x/dev.h                           |   3 +
 drivers/gpu/host1x/fence.c                         |  43 ++
 drivers/gpu/host1x/hw/cdma_hw.c                    |   3 +
 drivers/gpu/host1x/hw/channel_hw.c                 |   3 +-
 drivers/gpu/host1x/hw/debug_hw_1x06.c              |   3 +
 drivers/gpu/host1x/syncpt.c                        |  21 +-
 drivers/video/fbdev/efifb.c                        |   2 +-
 include/drm/bridge/analogix_dp.h                   |   1 -
 .../drm_fbdev_helper.h}                            |   4 +-
 include/drm/drm_bridge.h                           |  54 --
 include/drm/drm_of.h                               |  15 +-
 include/drm/drm_panel.h                            |  99 ++-
 include/drm/{drm_utils.h => drm_panel_quirks.h}    |  10 +-
 include/drm/drm_timeout.h                          |  17 +
 include/drm/gpu_scheduler.h                        |  10 +-
 include/linux/host1x.h                             |  53 +-
 include/uapi/drm/tegra_drm.h                       |   4 +-
 176 files changed, 3351 insertions(+), 1809 deletions(-)
 delete mode 100644 drivers/gpu/drm/bridge/panel.c
 rename drivers/gpu/drm/{drm_fb_helper.c => clients/drm_fbdev_helper.c} (97%)
 create mode 100644 drivers/gpu/drm/drm_timeout.c
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h
 rename include/drm/{drm_fb_helper.h => clients/drm_fbdev_helper.h} (99%)
 rename include/drm/{drm_utils.h => drm_panel_quirks.h} (57%)
 create mode 100644 include/drm/drm_timeout.h

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)
