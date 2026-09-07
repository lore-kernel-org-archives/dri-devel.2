Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF05C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:24:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E46E10E3A6;
	Mon,  7 Sep 2026 13:24:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="StggVfRh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CCF710E3A6
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:24:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6147C60AB5;
 Mon,  7 Sep 2026 13:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909801F00A3A;
 Mon,  7 Sep 2026 13:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788787441;
 bh=47oNMAiVsEVMcK2+Mo0jIloG8vxUOIaS88Qm/XVcDkA=;
 h=From:Subject:Date:To:Cc;
 b=StggVfRhKUP2H1aRukBcT2ALZl3/RB8gorjdq57Rzo4MRvuSzOG8blZgPaGwKE1VT
 FUIqJYGOgSquEn56E/WUv61b3hTEE9kqxHYVdMmoTj0NYxjutyLMsTFsCqGn9S2GOZ
 a39VivVtgA9LxrASom0dBtPChTiBk7z9YTyM/NyNpMMkZGJqGMj2rVtt2nPksJucov
 nE7XOKbzhHM/Zf+uyabGn19HMaoWTn856I4QCoMYn5ZzKynbAA1bEzEQ8T36ZO2fk4
 3AWSoEZpFTJXhVV9uc9Cy7uxnAN2QllPpow57vDFhz8kw6IOzGXeMN92QkdjsrdGsm
 RiGQJNqVnZIDg==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v5 00/33] drm: Implement state readout support
Date: Mon, 07 Sep 2026 15:23:36 +0200
Message-Id: <20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23PTW7DIBAF4KtYrEs15s/gVe9RdYFhnKDWpgVip
 Ypy92JHVVrFyzdivuFdSMYUMJO+uZCES8ghzjXIp4a4o50PSIOvmTBgEjoO1KeJ5mIL0oTWx1O
 hLegRtHGt40Dq3mfCMZw38/XtlhN+nSpdbsO73DfVVdCB2dw50ikmpC4VV/mMFRdWeDk47UXbL
 3z1B5vrkzhNofTNujaF7OiM50JXjVYMOFkvH0MuMX1v5ZZ2O731MMB2eiwthfWel7yV3vLx5R3
 TjB/PMR02bmG/hALB+B7BKqGlMKPu3GA6/UDwO6HqX3cIXgkvNZPImTH2kRB/CbNHiEpIo5SSn
 dGA/h9xvV5/AKGH4JP2AQAA
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
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9421; i=mripard@kernel.org;
 h=from:subject:message-id; bh=NMnPNPrzeF0CpVeu7SGRBAjtpj9gfiDvH3ojfmiRTH4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnzdt3dzCjNOWmix1fBbRH7Ohd9/L70AfO8q1fVZheyZ
 jVb7Ji7qWMqC4MwJ4OsmCLLE5mw08vbF1c52K/8ATOHlQlkCAMXpwBM5OQ7xob2r0sjuSa3BTT2
 Sq2RnbKluVW+QqYrZWZQi0+taqRSZtKFiYvP5GxcdOlQv+qnqOTTGxhrhbneOj87Pqc//mCQ4W6
 zJfkdDN5BvPkrjSuOTPmhEWO7WnMyI8eehWuiF3dJKVZe+uoKAA==
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
Maxime Ripard (33):
      drm/atomic: Fix unused but set warning in state iterator macros
      drm/atomic_helper: Skip over NULL private_obj pointers
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
      drm/atomic_sro: Provide helpers to implement hardware state readout
      drm/mode-config: Introduce hw_reset hook
      drm/modeset-helper: Add drm_mode_config_helper_hw_reset()
      drm/atomic_helper: Pass nonblock to commit_tail
      drm/atomic_helper: Compare actual and readout states once the commit is done
      drm/atomic-state-helper: Provide comparison macros
      drm/atomic-state-helper: Provide atomic_compare_state helpers
      drm/atomic-helper: Document State Read-Out as a state initialization approach
      drm/encoder: Create atomic_sro_get_current_crtc hook
      drm/bridge: display-connector: Implement readout support
      drm/bridge_connector: Implement hw readout for connector
      drm/tidss: crtc: Add atomic_print_state implementation
      drm/tidss: dispc: Improve mode checking logs
      drm/tidss: Switch to drm_mode_config_create_initial_state()
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
 drivers/gpu/drm/drm_atomic.c                       |  46 +-
 drivers/gpu/drm/drm_atomic_helper.c                |  46 +-
 drivers/gpu/drm/drm_atomic_sro.c                   | 932 +++++++++++++++++++++
 drivers/gpu/drm/drm_atomic_sro_helper.c            | 679 +++++++++++++++
 drivers/gpu/drm/drm_atomic_state_helper.c          |  20 +-
 drivers/gpu/drm/drm_bridge.c                       | 132 ++-
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
 drivers/gpu/drm/tidss/tidss_drv.c                  |   6 +-
 drivers/gpu/drm/tidss/tidss_encoder.c              |  57 ++
 drivers/gpu/drm/tidss/tidss_kms.c                  |  20 +-
 drivers/gpu/drm/tidss/tidss_plane.c                | 154 ++++
 drivers/gpu/drm/vc4/vc4_kms.c                      |   3 +
 include/drm/drm_atomic.h                           | 144 +++-
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
 43 files changed, 3644 insertions(+), 88 deletions(-)
---
base-commit: 17c6b88e85ffe5de5720004ae8c2176d52944aca
change-id: 20250730-drm-state-readout-108f089c1c30
prerequisite-change-id: 20260709-drm-no-more-crtc-reset-14a4d5bc8d41:v3
prerequisite-patch-id: 58c15cfdaac5894112d6b55152cee55444e59c2c
prerequisite-patch-id: f1d676df498396acf15592ca7ead5be61138f47a
prerequisite-patch-id: 0b4247d6f5e7d16522473260c92ad1b4a235e5d6
prerequisite-patch-id: 454462ebf2b4cc237d83aa8b3631252e158d16d0
prerequisite-patch-id: ffa6afc89be0c75a3b3565d204e998841fcd7c15
prerequisite-patch-id: c20225c4fc6139ca606ca94d44d973b22d94ad94
prerequisite-patch-id: a0b461fed6e896d3ea179caff28a00d912aee47a
prerequisite-patch-id: ae43b98d635078d5d2d76a9dee7dffba082c3dd4
prerequisite-patch-id: 91c7bc55447b4c4fc97000bc257a72d1694d8aa6
prerequisite-patch-id: 527b8258f3d80c3dafc1833732f66d7283e7bbb5
prerequisite-patch-id: 9ef306a7e4c68ac38a6ed26c0f18b02dd9e3beeb
prerequisite-patch-id: 576654f19b1d56754bdb115f673438140f242fda
prerequisite-patch-id: 166fb879fa7744d42ee56d6735cc344585a74b2a

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

