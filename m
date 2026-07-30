Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F33C54FD2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 10:49:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B715710E683;
	Thu, 30 Jul 2026 10:49:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Xox6P0b1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D02F10E67C;
 Thu, 30 Jul 2026 10:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785408545; x=1816944545;
 h=message-id:date:mime-version:from:to:cc:subject:
 content-transfer-encoding;
 bh=z5/81VdES55/zS6M29WYG6w4eX+A9xaisxalBnxTEYU=;
 b=Xox6P0b1YZ6D3A97asnzUHVjcRz1lAUGMCf4BP248pSHvO5pj828sVxN
 jYZKW9SXuQueRHHEOoSxnvGdDNU7RNZk8t4cfZagQ6Zoj7fLYLraxu9wL
 76L2wlfN6tHRLDun/QWQOTlrKMhuN7PWffTLT6Bd8xuYKHtn+hAxq1K/9
 ntSRsyR2PUdf6dK+Jw7wQVze4LABC//Z9J9KlHFuVsCWrt/yZUvzbnCAk
 Z4pRCu2xYsEvxk+4tkZ5tN0D3j6yleUIFI64nOuNOPc4K4O/KmpxSgEKK
 FkWmlXzjrRhxfxN+CFj5ATIWCLs0xn85PpgdlUBbNldBmDVDR9ttVMa4E w==;
X-CSE-ConnectionGUID: o5VqWMAbT3mIzT0jDCgoMQ==
X-CSE-MsgGUID: 5kwgaGTZQ1a914XO7Wn7tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="103429681"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="103429681"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 03:49:05 -0700
X-CSE-ConnectionGUID: hIJL7LaNTAacw/P1SmEDaQ==
X-CSE-MsgGUID: aOtvmSyiRYqwb2/DTIjPgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="264539710"
Received: from rvuia-mobl.ger.corp.intel.com (HELO [10.245.245.93])
 ([10.245.245.93])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 03:49:01 -0700
Message-ID: <a734faaf-4f77-48ce-a354-a1011524c949@linux.intel.com>
Date: Thu, 30 Jul 2026 12:50:10 +0200
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

drm-misc-next for v7.3!

As mentioned in the -fixes pull, Maxime and Thomas are out.

Kind regards,
~Maarten Lankhorst

drm-misc-next-2026-07-30:
drm-misc-next for v7.3:

UAPI Changes:
- Allow allocating NVDEC channels via abi16 for H.264 decode.

Cross-subsystem Changes:
- Add Opto Logic S.A., DCL Technologies Inc. to dt vendor prefixes.

Core Changes:
- Fix kunit tests for the gpu buddy allocator.

Driver Changes:
- Improve i2c handling for panel-edp.
- Assorted bugfixes and improvements in panthor, panel/jd93656da, panel/nt36536,
  bridge/tc358762 bridge/lt8912b, bridge/hw-dmi, panthor, panel/ili9805.
- Use named initialized for bridge's users of i2c_device_data.
- Add DCLTek 300250 9.35", AYANEO Pocket DS Lower, Ampire
  AM-800480N3TZQW-00H, BOE NE140QDM-NX2, CMN N116BCP-EA2 panels.
- Unconditionally create blend_mode property for nv50+ planes.
- Add i.MX93 parallel display format configuration support.
The following changes since commit e55fead22ff9ee047ab9f1903860c4b43043514e:

  drm/imagination: promote BXM-4-64 MC1 (36.52.104.182) to supported status (2026-07-24 08:37:01 +0100)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-next-2026-07-30

for you to fetch changes up to 35b6cf07851a2b430b0eefbcb7b5a856f9030264:

  drm/panel-edp: Add CMN N116BCP-EA2 (HW: C3) (2026-07-29 18:28:19 -0700)

----------------------------------------------------------------
drm-misc-next for v7.3:

UAPI Changes:
- Allow allocating NVDEC channels via abi16 for H.264 decode.

Cross-subsystem Changes:
- Add Opto Logic S.A., DCL Technologies Inc. to dt vendor prefixes.

Core Changes:
- Fix kunit tests for the gpu buddy allocator.

Driver Changes:
- Improve i2c handling for panel-edp.
- Assorted bugfixes and improvements in panthor, panel/jd93656da, panel/nt36536,
  bridge/tc358762 bridge/lt8912b, bridge/hw-dmi, panthor, panel/ili9805.
- Use named initialized for bridge's users of i2c_device_data.
- Add DCLTek 300250 9.35", AYANEO Pocket DS Lower, Ampire
  AM-800480N3TZQW-00H, BOE NE140QDM-NX2, CMN N116BCP-EA2 panels.
- Unconditionally create blend_mode property for nv50+ planes.
- Add i.MX93 parallel display format configuration support.

----------------------------------------------------------------
Adrián Larumbe (2):
      drm/panthor: Add vm_bind region with kbo range overlap check
      drm/panthor: Fix comment to reflect actual struct field name

Alexandre Hamamdjian (2):
      dt-bindings: display: Add AYANEO Pocket DS lower panel
      drm/panel: st7703: Add AYANEO Pocket DS Lower Panel Support

Colin Ian King (1):
      drm/bridge: lontium-lt8912b: make read-only const array supply_names static

Dave Airlie (1):
      drm/nouveau: allow allocating NVDEC channels via abi16

David Carlier (1):
      drm/panel: novatek-nt36536: Fix panel double-remove on attach failure

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

Michail Tatas (3):
      drm/panel: ilitek-ili9805: Use _multi variants
      drm/panel: ilitek-ili9805: Use dsi_multi in init
      drm/panel: ilitek-ili9805: make cleanup funcs void

Osama Abdelkader (4):
      drm/panthor: return PTR_ERR() from devm_drm_dev_alloc()
      drm/bridge: tc358762: use devm for bridge registration and DSI attach
      drm/bridge: tc358764: use devm for bridge registration and DSI attach
      drm/panthor: harden firmware build-info bounds checks

Paul Louvel (2):
      dt-bindings: display: simple: Add Ampire AM-800480N3TZQW-00H
      drm/panel: simple: Add Ampire AM-800480N3TZQW-00H

Terry Hsiao (1):
      drm/panel-edp: Add CMN N116BCP-EA2 (HW: C3)

Uwe Kleine-König (The Capable Hub) (1):
      drm/bridge: Use named initializers for arrays of i2c_device_data

Weiji Wang (1):
      drm/panel-edp: Add BOE NE140QDM-NX2

 .../bindings/display/panel/jadard,jd9365da-h3.yaml |   1 +
 .../bindings/display/panel/panel-simple.yaml       |   2 +
 .../display/panel/rocktech,jh057n00900.yaml        |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   4 +
 drivers/gpu/Kconfig                                |   3 +-
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |  10 +-
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c |   2 +-
 drivers/gpu/drm/bridge/analogix/anx7625.c          |   4 +-
 drivers/gpu/drm/bridge/chipone-icn6211.c           |   4 +-
 drivers/gpu/drm/bridge/chrontel-ch7033.c           |   2 +-
 drivers/gpu/drm/bridge/imx/Kconfig                 |  11 +
 drivers/gpu/drm/bridge/imx/Makefile                |   1 +
 drivers/gpu/drm/bridge/imx/imx93-pdfc.c            | 222 ++++++++++++++++++
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
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |   3 +-
 drivers/gpu/drm/bridge/tc358762.c                  |  19 +-
 drivers/gpu/drm/bridge/tc358764.c                  |  19 +-
 drivers/gpu/drm/bridge/tc358767.c                  |   2 +-
 drivers/gpu/drm/bridge/tc358768.c                  |   4 +-
 drivers/gpu/drm/bridge/tc358775.c                  |   4 +-
 drivers/gpu/drm/bridge/tda998x_drv.c               |   2 +-
 drivers/gpu/drm/bridge/ti-dlpc3433.c               |   2 +-
 drivers/gpu/drm/bridge/ti-sn65dsi83.c              |   6 +-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |   4 +-
 drivers/gpu/drm/bridge/ti-tfp410.c                 |   2 +-
 drivers/gpu/drm/nouveau/dispnv50/base.h            |   6 +
 drivers/gpu/drm/nouveau/dispnv50/base507c.c        |   1 +
 drivers/gpu/drm/nouveau/dispnv50/base827c.c        |   1 +
 drivers/gpu/drm/nouveau/dispnv50/base907c.c        |   1 +
 drivers/gpu/drm/nouveau/dispnv50/curs507a.c        |   3 +
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |   4 +
 drivers/gpu/drm/nouveau/dispnv50/wndw.c            |  40 +++-
 drivers/gpu/drm/nouveau/dispnv50/wndw.h            |  11 +
 drivers/gpu/drm/nouveau/dispnv50/wndwc37e.c        |   1 +
 drivers/gpu/drm/nouveau/dispnv50/wndwc57e.c        |   1 +
 drivers/gpu/drm/nouveau/dispnv50/wndwc67e.c        |   1 +
 drivers/gpu/drm/nouveau/dispnv50/wndwca7e.c        |   1 +
 drivers/gpu/drm/nouveau/nouveau_abi16.c            |  14 +-
 drivers/gpu/drm/nouveau/nouveau_drv.h              |   4 +-
 drivers/gpu/drm/panel/panel-edp.c                  |  23 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9805.c       | 212 +++++++-----------
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c   | 249 ++++++++++++++++++++-
 drivers/gpu/drm/panel/panel-novatek-nt36536.c      |   4 +-
 drivers/gpu/drm/panel/panel-simple.c               |  33 +++
 drivers/gpu/drm/panel/panel-sitronix-st7703.c      |  96 ++++++++
 drivers/gpu/drm/panthor/panthor_drv.c              |   2 +-
 drivers/gpu/drm/panthor/panthor_fw.c               |   3 +-
 drivers/gpu/drm/panthor/panthor_mmu.c              |  11 +-
 drivers/gpu/tests/.kunitconfig                     |   2 +
 include/drm/drm_bridge.h                           |   2 +-
 include/uapi/drm/nouveau_drm.h                     |   1 +
 63 files changed, 880 insertions(+), 230 deletions(-)
 create mode 100644 drivers/gpu/drm/bridge/imx/imx93-pdfc.c
 create mode 100644 drivers/gpu/tests/.kunitconfig
