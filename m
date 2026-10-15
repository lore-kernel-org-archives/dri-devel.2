Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E920CC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:09:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5345C10E15D;
	Thu, 15 Oct 2026 15:09:21 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CE3D10E15D
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:09:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3501843BA3;
 Thu, 15 Oct 2026 15:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA201F000C4;
 Thu, 15 Oct 2026 15:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792076955;
 bh=0oT7ReOamGm0Opc4ItoiumWcZtNr5O2GeXyfw9JYBAo=;
 h=From:Subject:Date:To:Cc;
 b=eGCWy+WvU9Pqm6a28WRChnkI0W6pk4y0tEPZQf4HweqwkY2CV0S+WtJ48j7HNmmDo
 8D2EBLbSxgi65PlFenCq4PvC7BOCBrEDGg1kObwfekjajKR+rjc0oD7TtZ104Mlynp
 9O8+bzv+RvRaicUMqJVen9IxAOCO0XIE1INqiKQCaFsl7F6k64/K2SEcwJXLh/m2Nw
 uL49Wo5m6PWtYP1DktdEU5ZFSjNPAHLZX4BWJVRA0WKyy4QcPr+6cZUmuFqF+gZp9F
 Xj8zxnzK5uy0QHr/hnxbxzC4Qn48XFAPkx3eGcTJ6DslV8RKhwrpBInpyAcz6A/has
 He0aWWB6DoQNA==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v6 00/28] drm: Implement state readout support
Date: Thu, 15 Oct 2026 17:08:52 +0200
Message-Id: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23PTW7CMBAF4KtEXuNq/BubVe9RdWHsMUQlMdgha
 oW4e02iCiqyHMvvmzdXUjB3WMi2uZKMU1e6NNRBbxriD27YI+1CnQkHrqAVQEPuaRndiDSjC+k
 yUgYmgrGeeQGk5k4ZY/c9mx+fy5zxfKn0uDySnStIfer7btw20lhnlLDe6Uju/w9dGVP+mStNb
 A7M2y3wle0To0CZdEEJpoIT8f0L84DHt5T3MzfxP0KD5GKN4JUwStpoWr+zrXkhxIPQXK8RohJ
 BGa5QcFsPeiHkM2HXCFkJZbXWqrUGMDwTm2aJWrZsHxLtU0Z6OrrhThSsgKpAVBYCBxCR+5cO6
 tHBQrvW4U6o6JjzrVNM/j/jdrv9Ag0sqJgwAgAA
X-Change-ID: 20250730-drm-state-readout-108f089c1c30
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Simona Vetter <simona.vetter@ffwll.ch>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8354; i=mripard@kernel.org;
 h=from:subject:message-id; bh=g70UgJTWNa0ZcredC9KaNvXd3VlWQX8JXS+Ke7Q60Qk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkX3nQdEcm59nBrX+nXda1BKVumyP45tK//geRL0U1xr
 ifOnE9Q75jKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQAT0bRkbDj8//nJerVpU9h3
 n+8s7L70oyjg9P55y/v3X9hqk9L8Nrg1q939a3X1vjCWBR0PZrU97WBsmPPlcvkCrmprwzVpvZ4
 GrzRCnMvOtBU0TdrQxXr7+MM09oMNExhU5v52+Ckj0Ps38NsNAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

Hi,

Here's a series that implement what i915 calls "fastboot", ie,
initializing the initial KMS state from the hardware state at boot, to
skip the first modeset if the firmware already set up the display.

This series creates the infrastructure in KMS to create that state by
relying on driver specific hooks. It also implements some infrastructure
to check during non-blocking commits that the readout helpers work
properly by reading out the state that was just committed and comparing
it to what was supposed to be committed.

This relies on another set of driver hooks to compare the entities
states, with helpers providing the default implementation.

It then implements the readout support in the TIDSS driver, and was
tested with the SK-AM62 board. This board in particular is pretty
interesting, since it relies on an DPI to HDMI bridge, and uses the
drm_bridge_connector infrastructure.

So the readout works with the current state of the art on embedded-ish
platforms.

Unlike the earlier RFCs, it now works fine: the state is picked up
properly, doesn't trigger a modeset if what was programmed is the one
the first modeset tries to pick as well, will switch properly if it
isn't, etc.

Let me know what you think,
Maxime

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Changes in v6:
- Fix private_obj_init error handling
- Fix bridge name lifetime
- Show the bridge name in print_state
- Rebase on current drm-misc-next
- Link to v5: https://lore.kernel.org/r/20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org

Changes in v5:
- Implement readout for bridge/display-connector
- Implement readout for tidss encoders
- Fix sii902 readout implementation
- Add atomic_print_state implementation to tidss crtc
- Rebase over latest changes. In particular, the CRTC conversion to
  atomic_create_state and the introduction of crtc's hw_reset made me
  create a new helper and hook to trigger a device-wide hw_reset
- Add a bunch of NULL pointer checks everywhere
- Fix compare macros calls to __stringify
- Create documentation section for sro
- Fix error path in drm_atomic_sro_state_init
- Improve bisectability
- Link to v4: https://lore.kernel.org/r/20260629-drm-state-readout-v4-0-5966657980ed@kernel.org

Changes in v4:
- Dropped the HACK patch that went into the v3 resend
- Hopefully the kernel.org smtp works this time
- Link to v3: https://lore.kernel.org/r/20260626-drm-state-readout-v3-0-d5825e3299a8@kernel.org

Changes in v3:
- Rebase on top of the current drm-misc-next, with rename of
  drm_atomic_state and the various preliminary series merged.
- Use drm_printf_indent when possible
- Change the access mode for the atomic_readout parameter from 000 to
  400
- Use drm_drv_uses_atomic_modeset() instead of drm_core_check_feature()
- Introduce a hw_reset hook to deal with device hardware reset when
  needed (ie, SRO fails or is disabled)
- Improve mode flags readout
- Fix plane alpha readout
- Add sii902x state readout

- Link to v2: https://lore.kernel.org/r/20260423-drm-state-readout-v2-0-8549f87cb978@kernel.org

Changes in v2:
- Get rid of patches already applied
- Rebase on top of the current atomic_create_state work
- Use the SRO prefix everywhere
- Create our own states container structure instead of trying to plumb
  it into a drm_atomic_state
- Make a lot more use of helpers
- Add a hook to enable the hardware resources when the readout state
  becomes active
- Move all the tidss readout code into tidss_dispc.c
- Write documentation
- Add drm_private_obj and drm_bridge name for easier debugging
- Add drm_private_obj_is_bridge()
- Link to v1: https://lore.kernel.org/r/20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org

---
Maxime Ripard (28):
      drm/atomic: Fix private obj error handling
      drm/atomic: Add drm_private_obj name
      drm/bridge: Switch print_state to use bridge name
      drm/bridge: Add drm_private_obj_is_bridge()
      drm/atomic: Export drm_atomic_*_print_state
      drm/atomic_sro: Create drm_atomic_sro_state container
      drm/atomic_sro: Create kernel parameter to force or disable readout
      drm/atomic_sro: Add atomic state readout infrastructure
      drm/atomic_sro: Add function to install state into drm objects
      drm/atomic_sro: Create documentation
      drm/bridge: Handle bridges with hardware state readout
      drm/mode-config: Read out hardware state in drm_mode_config_create_state
      drm/atomic_sro: Provide helpers to implement hardware state readout
      drm/mode-config: Introduce hw_reset hook
      drm/modeset-helper: Add drm_mode_config_helper_hw_reset()
      drm/atomic_helper: Compare actual and readout states once the commit is done
      drm/atomic-state-helper: Provide comparison macros
      drm/atomic-state-helper: Provide atomic_compare_state helpers
      drm/atomic-helper: Document State Read-Out as a state initialization approach
      drm/encoder: Create atomic_sro_get_current_crtc hook
      drm/bridge: display-connector: Implement readout support
      drm/bridge_connector: Implement hw readout for connector
      drm/tidss: crtc: Add atomic_print_state implementation
      drm/tidss: dispc: Improve mode checking logs
      drm/tidss: Implement hw_reset
      drm/tidss: Implement readout support
      drm/tidss: encoder: Implement atomic_sro_get_current_crtc
      drm/bridge: sii902x: Implement hw state readout

 Documentation/gpu/drm-kms-helpers.rst              |  26 +
 drivers/gpu/drm/Makefile                           |   2 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   1 +
 .../drm/arm/display/komeda/komeda_private_obj.c    |   8 +
 drivers/gpu/drm/bridge/display-connector.c         |  64 ++
 drivers/gpu/drm/bridge/sii902x.c                   |  82 +-
 drivers/gpu/drm/display/drm_bridge_connector.c     |  35 +
 drivers/gpu/drm/display/drm_dp_mst_topology.c      |   2 +-
 drivers/gpu/drm/display/drm_dp_tunnel.c            |   1 +
 drivers/gpu/drm/drm_atomic.c                       |  41 +-
 drivers/gpu/drm/drm_atomic_helper.c                |  40 +
 drivers/gpu/drm/drm_atomic_sro.c                   | 932 +++++++++++++++++++++
 drivers/gpu/drm/drm_atomic_sro_helper.c            | 679 +++++++++++++++
 drivers/gpu/drm/drm_atomic_state_helper.c          |  20 +-
 drivers/gpu/drm/drm_bridge.c                       | 116 ++-
 drivers/gpu/drm/drm_internal.h                     |  12 +
 drivers/gpu/drm/drm_mode_config.c                  |  55 +-
 drivers/gpu/drm/drm_modeset_helper.c               |  24 +
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c          |   1 +
 drivers/gpu/drm/ingenic/ingenic-ipu.c              |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c           |   1 +
 drivers/gpu/drm/omapdrm/omap_drv.c                 |   1 +
 drivers/gpu/drm/tegra/hub.c                        |   1 +
 drivers/gpu/drm/tidss/tidss_crtc.c                 | 104 +++
 drivers/gpu/drm/tidss/tidss_dispc.c                | 334 +++++++-
 drivers/gpu/drm/tidss/tidss_dispc.h                |  16 +
 drivers/gpu/drm/tidss/tidss_encoder.c              |  57 ++
 drivers/gpu/drm/tidss/tidss_kms.c                  |  20 +-
 drivers/gpu/drm/tidss/tidss_plane.c                | 154 ++++
 drivers/gpu/drm/vc4/vc4_kms.c                      |   3 +
 include/drm/drm_atomic.h                           |  73 +-
 include/drm/drm_atomic_sro.h                       |  59 ++
 include/drm/drm_atomic_sro_helper.h                | 276 ++++++
 include/drm/drm_bridge.h                           |  87 ++
 include/drm/drm_connector.h                        |  69 ++
 include/drm/drm_crtc.h                             |  69 ++
 include/drm/drm_encoder.h                          |  18 +
 include/drm/drm_mode_config.h                      |  50 ++
 include/drm/drm_modeset_helper.h                   |   1 +
 include/drm/drm_modeset_helper_vtables.h           |  23 +
 include/drm/drm_plane.h                            |  69 ++
 42 files changed, 3575 insertions(+), 53 deletions(-)
---
base-commit: 489a8539ca6f347102c1334c2f08198abacc86c8
change-id: 20250730-drm-state-readout-108f089c1c30

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

