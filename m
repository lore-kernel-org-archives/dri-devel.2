Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BC4C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:17:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EE9E10E564;
	Mon, 29 Jun 2026 08:17:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DN1ejHe+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8900010E564
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:17:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B5AF9600AA;
 Mon, 29 Jun 2026 08:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4711F00A3A;
 Mon, 29 Jun 2026 08:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782721040;
 bh=XkTCAMlmvHPsjpe2o0ORBFNWQMaOAFCrtD0TuVKsirc=;
 h=From:Subject:Date:To:Cc;
 b=DN1ejHe+g/CjDLJ9QiSQJPg7yULrBxuRO12isTiOg6L0ONhUzo0Tx+fpGBRWASAKs
 R8ZMrExSKQNp9XxIQeDJ+KIza2m3vrvh+dB8RDy0fcwSZPX7nkyfMWjzTMo1chz0jk
 ge5F214pXkIAR5fK/Hy1kHaT9Zxv6YoqdtTt6d1vWT3ZJmsTBhYLJObf7Y9/3YDFZW
 5GeU6ppOMO1GvQt+x8y3QeURPsQNa0ZRQ0QQQ8hlEibZ9IJW1Dc4Z63Bi0O72hSwYT
 d3FkBL0mNZUopetj8QLAEJWbC1IbgV93FLklZjaqt3yX8G/pYJ/tU+MslBgIsqrkYa
 4LrjgmsfhYcmA==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v4 00/30] drm: Implement state readout support
Date: Mon, 29 Jun 2026 10:16:58 +0200
Message-Id: <20260629-drm-state-readout-v4-0-5966657980ed@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23OQW7DIBAF0KtYrDvVAMaGrHqPKAsC4wS1NikQK
 1Xku5c4qqqqXv6R/pt/Z5lSoMx2zZ0lmkMOcaqhfWmYO9vpRBB8zUygUNhLBJ9GyMUWgkTWx2s
 BjnpAbRx3ElntXRIN4baa+8MzJ/q8Vro8j+xoM4GL4xjKrnmAY8gOJroVqH86wA64YY/uOeQS0
 9c6b+ZreV1iUGwsmTkg8NZ6JbnyVg5v75Qm+niN6bRys/ghOmyF3CJEJbRqzaB7dzS9/kfIX6K
 rWzcIWQmvtFAkhTH2L7EsyzeBUSK3dQEAAA==
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
 lidrm_printf_indentnux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7948; i=mripard@kernel.org;
 h=from:subject:message-id; bh=c/enL7bHuHFb8fiykM+HSBgXPBaYpsvIFaqoqaPs44c=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlOWgytU7g+z+rPY9Mym5cgIZcxOUAubKbpZH9vnTcB/
 BztOWodU1kYhDkZZMUUWZ7IhJ1e3r64ysF+5Q+YOaxMIEMYuDgFYCJdCxgb7hw9d0pap0rGe5Ld
 /6BDX71ad4pPE9jeu/jf8xNOt4pOCzW8FDrO7OBnEFU+sfnGy0s2jPXFpelvcjfr3n37JF6u+Ha
 K2W+/9dxzAxq3xzXvWuVqff2ogkFR8z+/vSx/HtR+W9LevQgA
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

It's now in a much better state than the v1 was, but there's still some
notable things broken:

  - Bridges do not read their input and output bus formats and flags

  - The tidss_crtc_state fields are not read properly at the moment
    either.

  - It looks like, when left unattended, we get some atomic_flush
    WARN eventually, maybe because of something broken around
    hotplugging and the monitor shutting itself down?

  - If readout is disabled for any reason, the hardware isn't reset
    anymore.

The main thing works though: the state is picked up properly, doesn't
trigger a modeset if what was programmed is the one the first modeset
tries to pick as well, will switch properly if it isn't, etc.

Let me know what you think,
Maxime

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
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
Maxime Ripard (30):
      drm/atomic: Fix unused but set warning in state iterator macros
      drm/atomic_helper: Skip over NULL private_obj pointers
      drm/atomic-state-helper: Remove memset in __drm_atomic_helper_bridge_reset()
      drm/atomic: Convert drm_priv_to_bridge_state to container_of_const
      drm/atomic: Add drm_private_obj name
      drm/bridge: Add drm_private_obj_is_bridge()
      drm/bridge: Implement atomic_print_state
      drm/atomic: Export drm_atomic_*_print_state
      drm/atomic: Only call atomic_destroy_state on a !NULL pointer
      drm/atomic_sro: Create drm_atomic_sro_state container
      drm/atomic_sro: Create kernel parameter to force or disable readout
      drm/atomic_sro: Add atomic state readout infrastructure
      drm/atomic_sro: Add function to install state into drm objects
      drm/atomic_sro: Create documentation
      drm/bridge: Handle bridges with hardware state readout
      drm/mode-config: Read out hardware state in drm_mode_config_create_state
      drm/mode-config: Introduce hw_reset hook
      drm/atomic_sro: Provide helpers to implement hardware state readout
      drm/atomic_helper: Pass nonblock to commit_tail
      drm/atomic_helper: Compare actual and readout states once the commit is done
      drm/atomic-state-helper: Provide comparison macros
      drm/atomic-state-helper: Provide atomic_compare_state helpers
      drm/encoder: Create atomic_sro_get_current_crtc hook
      drm/bridge: display-connector: Implement readout support
      drm/bridge_connector: Implement hw readout for connector
      drm/tidss: dispc: Improve mode checking logs
      drm/tidss: Switch to drm_mode_config_create_initial_state()
      drm/tidss: Implement readout support
      drm/tidss: encoder: Implement atomic_sro_get_current_crtc
      drm/bridge: sii902x: Implement hw state readout

 drivers/gpu/drm/Makefile                           |   2 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   1 +
 .../drm/arm/display/komeda/komeda_private_obj.c    |   8 +
 drivers/gpu/drm/bridge/display-connector.c         |  15 +
 drivers/gpu/drm/bridge/sii902x.c                   |  72 +-
 drivers/gpu/drm/display/drm_bridge_connector.c     |  31 +
 drivers/gpu/drm/display/drm_dp_mst_topology.c      |   2 +-
 drivers/gpu/drm/display/drm_dp_tunnel.c            |   1 +
 drivers/gpu/drm/drm_atomic.c                       |  46 +-
 drivers/gpu/drm/drm_atomic_helper.c                |  46 +-
 drivers/gpu/drm/drm_atomic_sro.c                   | 854 +++++++++++++++++++++
 drivers/gpu/drm/drm_atomic_sro_helper.c            | 676 ++++++++++++++++
 drivers/gpu/drm/drm_atomic_state_helper.c          |   3 +-
 drivers/gpu/drm/drm_bridge.c                       | 133 +++-
 drivers/gpu/drm/drm_internal.h                     |  12 +
 drivers/gpu/drm/drm_mode_config.c                  |  51 +-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c          |   1 +
 drivers/gpu/drm/ingenic/ingenic-ipu.c              |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c           |   1 +
 drivers/gpu/drm/omapdrm/omap_drv.c                 |   1 +
 drivers/gpu/drm/tegra/hub.c                        |   1 +
 drivers/gpu/drm/tidss/tidss_crtc.c                 |  93 +++
 drivers/gpu/drm/tidss/tidss_dispc.c                | 296 ++++++-
 drivers/gpu/drm/tidss/tidss_dispc.h                |  15 +
 drivers/gpu/drm/tidss/tidss_drv.c                  |   6 +-
 drivers/gpu/drm/tidss/tidss_encoder.c              |  37 +-
 drivers/gpu/drm/tidss/tidss_kms.c                  |  14 +-
 drivers/gpu/drm/tidss/tidss_plane.c                | 154 ++++
 drivers/gpu/drm/vc4/vc4_kms.c                      |   3 +
 include/drm/drm_atomic.h                           | 144 +++-
 include/drm/drm_atomic_sro.h                       |  59 ++
 include/drm/drm_atomic_sro_helper.h                | 275 +++++++
 include/drm/drm_bridge.h                           |  87 +++
 include/drm/drm_connector.h                        |  69 ++
 include/drm/drm_crtc.h                             |  69 ++
 include/drm/drm_encoder.h                          |  18 +
 include/drm/drm_mode_config.h                      |  50 ++
 include/drm/drm_modeset_helper_vtables.h           |  23 +
 include/drm/drm_plane.h                            |  69 ++
 40 files changed, 3354 insertions(+), 86 deletions(-)
---
base-commit: 4c85094a73431c26d5774aa74e422fc6bb94a7d5
change-id: 20250730-drm-state-readout-108f089c1c30

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

