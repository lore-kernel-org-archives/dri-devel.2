Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449D9C5AC82
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 21:47:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC9D910F2F2;
	Thu,  6 Aug 2026 21:47:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iJguDIsZ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41B1C10E023;
 Thu,  6 Aug 2026 21:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786052825; x=1817588825;
 h=message-id:date:mime-version:from:to:cc:subject:
 content-transfer-encoding;
 bh=gr74MxqJPuy53JvPIUH25zpBpJqFG9H1hOy9pCTlG8E=;
 b=iJguDIsZdHdwJv2qaGZooxoAnl/ZGfjO1lpClQ31Q4V4ye8zS405n43d
 T0TJY2ax62dAtlfRxDsG5NUYkqsSTwGCn7oEHk44FRRp06GS42NXvaJ/J
 ncCEfdhIdpW9Ef+0Wl8Ygfp0slJUGva4tX3mynmVFaPudEYoRoUIK2tpn
 KUI3eQ3F284qUTuaRjIvfg2XcCaxwDJozif2o5TuFiRensKSzDInNyL7S
 MTQIJ0tkIArb5GUv8EfZjZglPsqX0eWmF1YsyGCgllMtEewKpUSTQyswl
 Q2Y5Zl8ZlvogBRZu4zjrYXFdfgdrt58XC7bKAjWklzEJM82zZMzjBifRL g==;
X-CSE-ConnectionGUID: PkOEH+IGSIKcLXZNUsfwuA==
X-CSE-MsgGUID: MjhX+AP/T4iSpvq5ZWyeLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86534652"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86534652"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 14:47:05 -0700
X-CSE-ConnectionGUID: I+VrdJjbSQGcZFqLUQxzPw==
X-CSE-MsgGUID: V1fPSDqjRHKnG8dWeSXm1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="300433770"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO [10.245.245.85])
 ([10.245.245.85])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 14:46:59 -0700
Message-ID: <917d462a-8976-4a15-bec4-4513ec51c5c0@linux.intel.com>
Date: Thu, 6 Aug 2026 23:48:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Simona Vetter <simona.vetter@ffwll.ch>, Dave Airlie <airlied@gmail.com>
Cc: dim-tools@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Oded Gabbay <ogabbay@kernel.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PULL] drm-misc-next
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

drm-misc-next for v7.3

As Thomas and Maxime are away, handling this for now.

Seems previous one was not merged, so it's included in the diffstat.

Kind regards,
~Maarten Lankhorst

drm-misc-next-2026-08-06:
drm-misc-next for v7.3:

UAPI Changes:
- Remove the default udmabuf size limit of 64MB.

Cross-subsystem Changes:
- Add dmemcg support for eviction, and hook it up for amdgpu and xe.

Core Changes:
- Changes to TTM to be more aggressive when allocating below protection limit!
- Improve dt binding documentation for renesas.
- Add helper to convert physical address back to buddy block,
  add that to and improve its kunit test.

Driver Changes:
- Assorted small fixes to ti-sn65dsi86, panthor, imagination, omapdrm,
  bridge/synopsys, panel-edp, ssd130x, panel/tdo-tl070wsh30.
- Add Sharp LQ120P1JX51 panel.
- Add dmemcg support to nouveau.
- Various updates and improvements to sun4i, among which YUV and 4k support.
The following changes since commit e55fead22ff9ee047ab9f1903860c4b43043514e:

  drm/imagination: promote BXM-4-64 MC1 (36.52.104.182) to supported status (2026-07-24 08:37:01 +0100)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-next-2026-08-06

for you to fetch changes up to bd4f284df04d76fd65e57141cb1e6e7a49e4c3cb:

  drm/amdgpu: Wire up dmem cgroup reclaim for VRAM manager (2026-08-06 23:38:04 +0200)

----------------------------------------------------------------
drm-misc-next for v7.3:

UAPI Changes:
- Remove the default udmabuf size limit of 64MB.

Cross-subsystem Changes:
- Add dmemcg support for eviction, and hook it up for amdgpu and xe.

Core Changes:
- Changes to TTM to be more aggressive when allocating below protection limit!
- Improve dt binding documentation for renesas.
- Add helper to convert physical address back to buddy block,
  add that to and improve its kunit test.

Driver Changes:
- Assorted small fixes to ti-sn65dsi86, panthor, imagination, omapdrm,
  bridge/synopsys, panel-edp, ssd130x, panel/tdo-tl070wsh30.
- Add Sharp LQ120P1JX51 panel.
- Add dmemcg support to nouveau.
- Various updates and improvements to sun4i, among which YUV and 4k support.

----------------------------------------------------------------
Adrián Larumbe (2):
      drm/panthor: Add vm_bind region with kbo range overlap check
      drm/panthor: Fix comment to reflect actual struct field name

Akash Sukhavasi (1):
      drm/panel: tdo-tl070wsh30: Use mipi_dsi_*_multi(); fix minor bugs

Alessio Belle (2):
      drm/imagination: Reuse layout check macros for MIPS FW structures
      drm/imagination: Fix repeated typo in KCCB documentation

Alexandre Hamamdjian (2):
      dt-bindings: display: Add AYANEO Pocket DS lower panel
      drm/panel: st7703: Add AYANEO Pocket DS Lower Panel Support

Alexandru Dadu (3):
      drm/imagination: Reorder some fields in struct pvr_device_features
      drm/imagination: Move all FW interface check macros to pvr_checks.h
      drm/imagination: Update Rogue heap comments

Amit Barzilai (2):
      drm/ssd130x: Scale ssd133x per-channel contrast by brightness on init
      drm/ssd130x: Add per-family update backlight logic

Andreas Kemnade (1):
      drm/omap: dsi: Do not copy isr table

Arunpravin Paneer Selvam (1):
      drm/tests/gpu_buddy: fix interleaving in buffer clearance test

Biju Das (3):
      dt-bindings: display: bridge: renesas,dsi: Document RZ/G3L
      dt-bindings: display: renesas,rzg2l-du: Document RZ/G3L SoC
      dt-bindings: display: bridge: Document Renesas RZ/G3L LVDS encoder

Brajesh Gupta (1):
      drm/imagination: Set scheduler timeout period higher than Firmware timeout

Chen-Yu Tsai (1):
      drm/sun4i: framebuffer: Set mode_config.normalize_zpos

Colin Ian King (1):
      drm/bridge: lontium-lt8912b: make read-only const array supply_names static

Dave Airlie (1):
      drm/nouveau: allow allocating NVDEC channels via abi16

David Carlier (1):
      drm/panel: novatek-nt36536: Fix panel double-remove on attach failure

François Roux (1):
      drm/panel-edp: Add Sharp LQ120P1JX51 (Surface Pro 12in 1st Ed.)

Hsin-Te Yuan (1):
      drm/panel-edp: Add pre_unprepare delay

Jernej Skrabec (12):
      drm/sun4i: Fix V3s YUV scanline size
      drm/sun4i: vi scaler: Fix coefficient selection
      drm/sun4i: vi scaler: Restore opaque alpha in video modes
      drm/sun4i: tcon-top: Keep mixer routes distinct
      drm/sun4i: tcon: Set output mux for DSI and LVDS
      drm/sun4i: tcon: Drop TCON TOP device reference
      drm/sun4i: hdmi: Don't leak sync polarity bits into packet control
      drm/sun4i: crtc: Propagate layer initialization error
      drm/sun4i: tcon: Drop remote endpoint reference
      drm/sun4i: dw-hdmi: Drop TCON TOP port reference
      drm/sun4i: Drop node references while building component list
      drm/sun4i: hdmi-phy: Fix H6 8-bit MPLL config at 594 MHz

Johan Hovold (3):
      drm/panel-edp: fix i2c adapter leak on probe failure
      drm/panel-edp: take i2c adapter module reference
      drm/bridge: dw-hdmi: fix i2c adapter leak on probe failure

Krzysztof Niemiec (2):
      gpu: Fix dependencies in CONFIG_GPU_BUDDY_KUNIT_TEST
      gpu/tests: Add a dedicated .kunitconfig

Laurent Pinchart (1):
      drm/bridge: Replace outdated forward declaration

Leonardo Costa (1):
      dt-bindings: vendor-prefixes: Add Opto Logic

Liu Ying (1):
      drm/bridge: imx: Add i.MX93 parallel display format configuration support

Lyude Paul (3):
      drm/nouveau/kms/nv50-: Add .blend_modes to nv50_wndw_func
      drm/nouveau/kms/nv50-: Introduce nv50_wndw_default_state()
      drm/nouveau/kms/nv50-: Unconditionally create blend_mode prop for wndws

Marc-Olivier Champagne (4):
      drm: panel: jd9365da: Enable LPM mode
      dt-bindings: vendor-prefixes: Add DCLTEK
      dt-bindings: display: panel: add compatible for DCLTek 300250 9.35in panel
      drm: panel: jd9365da: Add DCLTek 300250 9.35in display

Matt Coster (1):
      drm/imagination: fixup some docs in pvr_gem.h

Michail Tatas (3):
      drm/panel: ilitek-ili9805: Use _multi variants
      drm/panel: ilitek-ili9805: Use dsi_multi in init
      drm/panel: ilitek-ili9805: make cleanup funcs void

Natalie Vock (7):
      cgroup/dmem: Add queries for protection values
      cgroup,cgroup/dmem: Add (dmem_)cgroup_common_ancestor helper
      drm/ttm: Extract code for attempting allocation in a place
      drm/ttm: Split cgroup charge and resource allocation
      drm/ttm: Be more aggressive when allocating below protection limit
      drm/ttm: Use common ancestor of evictor and evictee as limit pool
      drm/nouveau: Wire up dmem cgroups

Osama Abdelkader (5):
      drm/panthor: return PTR_ERR() from devm_drm_dev_alloc()
      drm/bridge: tc358762: use devm for bridge registration and DSI attach
      drm/bridge: tc358764: use devm for bridge registration and DSI attach
      drm/panthor: harden firmware build-info bounds checks
      drm/panthor: fix firmware control interface bounds checks

Pan Chuang (1):
      drm/bridge: ti-sn65dsi86: Remove redundant dev_err_probe()

Paul Louvel (2):
      dt-bindings: display: simple: Add Ampire AM-800480N3TZQW-00H
      drm/panel: simple: Add Ampire AM-800480N3TZQW-00H

Robert Mader (1):
      dma-buf/udmabuf: Disable the size limit by default

Tejas Upadhyay (2):
      drm/gpu: Add gpu_buddy_allocated_addr_to_block helper
      gpu/tests/gpu_buddy: Add KUnit test for gpu_buddy_allocated_addr_to_block

Terry Hsiao (1):
      drm/panel-edp: Add CMN N116BCP-EA2 (HW: C3)

Thomas Hellström (6):
      drm/amdgpu: Fix init ordering in amdgpu_vram_mgr_init()
      cgroup/dmem: Introduce struct dmem_cgroup_init for region initialization
      cgroup/dmem: Add reclaim callback for lowering max below current usage
      drm/ttm: Hook up a cgroup-aware reclaim callback for the dmem controller
      drm/xe: Wire up dmem cgroup reclaim for VRAM manager
      drm/amdgpu: Wire up dmem cgroup reclaim for VRAM manager

Uwe Kleine-König (The Capable Hub) (1):
      drm/bridge: Use named initializers for arrays of i2c_device_data

Weiji Wang (1):
      drm/panel-edp: Add BOE NE140QDM-NX2

Wolfram Sang (1):
      drm/bridge: remove unneeded 'fast_io' parameter in regmap_config

 .../bindings/display/bridge/renesas,dsi.yaml       |   1 +
 .../display/bridge/renesas,r9a08g046-lvds.yaml     | 120 ++++++++
 .../bindings/display/panel/jadard,jd9365da-h3.yaml |   1 +
 .../bindings/display/panel/panel-simple.yaml       |   2 +
 .../display/panel/rocktech,jh057n00900.yaml        |   2 +
 .../bindings/display/renesas,rzg2l-du.yaml         |  26 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |   4 +
 drivers/dma-buf/udmabuf.c                          |   4 +-
 drivers/gpu/Kconfig                                |   3 +-
 drivers/gpu/buddy.c                                |  53 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c       |  65 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h       |   3 +
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |  10 +-
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c |   2 +-
 drivers/gpu/drm/bridge/analogix/anx7625.c          |   4 +-
 drivers/gpu/drm/bridge/chipone-icn6211.c           |   4 +-
 drivers/gpu/drm/bridge/chrontel-ch7033.c           |   2 +-
 drivers/gpu/drm/bridge/imx/Kconfig                 |  11 +
 drivers/gpu/drm/bridge/imx/Makefile                |   1 +
 drivers/gpu/drm/bridge/imx/imx93-pdfc.c            | 222 ++++++++++++++
 drivers/gpu/drm/bridge/ite-it6263.c                |   2 +-
 drivers/gpu/drm/bridge/ite-it6505.c                |   2 +-
 drivers/gpu/drm/bridge/lontium-lt8713sx.c          |   2 +-
 drivers/gpu/drm/bridge/lontium-lt8912b.c           |   6 +-
 drivers/gpu/drm/bridge/lontium-lt9211.c            |   4 +-
 drivers/gpu/drm/bridge/lontium-lt9611.c            |   4 +-
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c         |   2 +-
 .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   |   8 +-
 drivers/gpu/drm/bridge/nxp-ptn3460.c               |   4 +-
 drivers/gpu/drm/bridge/parade-ps8622.c             |   8 +-
 drivers/gpu/drm/bridge/sii902x.c                   |   2 +-
 drivers/gpu/drm/bridge/sii9234.c                   |   2 +-
 drivers/gpu/drm/bridge/sil-sii8620.c               |   2 +-
 drivers/gpu/drm/bridge/synopsys/dw-dp.c            |   1 -
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |   3 +-
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c     |   1 -
 drivers/gpu/drm/bridge/tc358762.c                  |  19 +-
 drivers/gpu/drm/bridge/tc358764.c                  |  19 +-
 drivers/gpu/drm/bridge/tc358767.c                  |   2 +-
 drivers/gpu/drm/bridge/tc358768.c                  |   4 +-
 drivers/gpu/drm/bridge/tc358775.c                  |   4 +-
 drivers/gpu/drm/bridge/tda998x_drv.c               |   2 +-
 drivers/gpu/drm/bridge/ti-dlpc3433.c               |   2 +-
 drivers/gpu/drm/bridge/ti-sn65dsi83.c              |   6 +-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |   6 +-
 drivers/gpu/drm/bridge/ti-tfp410.c                 |   2 +-
 drivers/gpu/drm/drm_drv.c                          |   8 +-
 drivers/gpu/drm/imagination/pvr_ccb.c              |   6 +-
 drivers/gpu/drm/imagination/pvr_check.h            |  36 +++
 drivers/gpu/drm/imagination/pvr_device_info.h      |   6 +-
 drivers/gpu/drm/imagination/pvr_gem.h              |  12 +-
 drivers/gpu/drm/imagination/pvr_queue.c            |   3 +-
 drivers/gpu/drm/imagination/pvr_rogue_fwif_check.h |  26 +-
 .../drm/imagination/pvr_rogue_fwif_client_check.h  |   9 +-
 .../drm/imagination/pvr_rogue_fwif_shared_check.h  |   9 +-
 .../gpu/drm/imagination/pvr_rogue_heap_config.h    |  10 +-
 drivers/gpu/drm/imagination/pvr_rogue_mips_check.h |  71 ++---
 drivers/gpu/drm/nouveau/dispnv50/base.h            |   6 +
 drivers/gpu/drm/nouveau/dispnv50/base507c.c        |   1 +
 drivers/gpu/drm/nouveau/dispnv50/base827c.c        |   1 +
 drivers/gpu/drm/nouveau/dispnv50/base907c.c        |   1 +
 drivers/gpu/drm/nouveau/dispnv50/curs507a.c        |   3 +
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |   4 +
 drivers/gpu/drm/nouveau/dispnv50/wndw.c            |  40 ++-
 drivers/gpu/drm/nouveau/dispnv50/wndw.h            |  11 +
 drivers/gpu/drm/nouveau/dispnv50/wndwc37e.c        |   1 +
 drivers/gpu/drm/nouveau/dispnv50/wndwc57e.c        |   1 +
 drivers/gpu/drm/nouveau/dispnv50/wndwc67e.c        |   1 +
 drivers/gpu/drm/nouveau/dispnv50/wndwca7e.c        |   1 +
 drivers/gpu/drm/nouveau/nouveau_abi16.c            |  14 +-
 drivers/gpu/drm/nouveau/nouveau_drv.h              |   4 +-
 drivers/gpu/drm/nouveau/nouveau_ttm.c              |   8 +
 drivers/gpu/drm/omapdrm/dss/dsi.c                  |   7 +-
 drivers/gpu/drm/omapdrm/dss/dsi.h                  |   2 -
 drivers/gpu/drm/panel/panel-edp.c                  |  47 ++-
 drivers/gpu/drm/panel/panel-ilitek-ili9805.c       | 212 ++++++--------
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c   | 249 +++++++++++++++-
 drivers/gpu/drm/panel/panel-novatek-nt36536.c      |   4 +-
 drivers/gpu/drm/panel/panel-simple.c               |  33 +++
 drivers/gpu/drm/panel/panel-sitronix-st7703.c      |  96 +++++++
 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c       |  42 +--
 drivers/gpu/drm/panthor/panthor_drv.c              |   2 +-
 drivers/gpu/drm/panthor/panthor_fw.c               |  22 +-
 drivers/gpu/drm/panthor/panthor_mmu.c              |  11 +-
 drivers/gpu/drm/solomon/ssd130x.c                  |  67 ++++-
 drivers/gpu/drm/sun4i/sun4i_crtc.c                 |   2 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |   3 +
 drivers/gpu/drm/sun4i/sun4i_framebuffer.c          |  19 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |   2 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |  22 +-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c              |   2 +
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c             |   2 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.c                |   2 +-
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c             |  71 ++++-
 drivers/gpu/drm/sun4i/sun8i_tcon_top.h             |   6 +
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.c            |  20 +-
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.h            |   1 +
 drivers/gpu/drm/ttm/ttm_bo.c                       | 320 ++++++++++++++++++---
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |   3 +-
 drivers/gpu/drm/ttm/ttm_resource.c                 | 111 +++++--
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c               |  71 ++++-
 drivers/gpu/tests/.kunitconfig                     |   2 +
 drivers/gpu/tests/gpu_buddy_test.c                 | 102 +++++--
 include/drm/drm_bridge.h                           |   2 +-
 include/drm/drm_drv.h                              |   4 +-
 include/drm/ttm/ttm_bo.h                           |  10 +
 include/drm/ttm/ttm_resource.h                     |  13 +-
 include/linux/cgroup.h                             |  21 ++
 include/linux/cgroup_dmem.h                        |  63 +++-
 include/linux/gpu_buddy.h                          |   2 +
 include/uapi/drm/nouveau_drm.h                     |   1 +
 kernel/cgroup/dmem.c                               | 194 +++++++++++--
 113 files changed, 2261 insertions(+), 558 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/renesas,r9a08g046-lvds.yaml
 create mode 100644 drivers/gpu/drm/bridge/imx/imx93-pdfc.c
 create mode 100644 drivers/gpu/drm/imagination/pvr_check.h
 create mode 100644 drivers/gpu/tests/.kunitconfig
