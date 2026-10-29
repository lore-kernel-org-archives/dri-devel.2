Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09A5606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T+Nwu2Vs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5ADD10FFD1;
	Thu, 29 Oct 2026 07:34:31 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2841610FFCF
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:34:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2E44B600D1;
 Thu, 29 Oct 2026 07:34:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B401F01825;
 Thu, 29 Oct 2026 07:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793259263;
 bh=Xa1Kfj5/fFTEjLVQvCYCAjPC77lpM50kf7+aZxEumQs=;
 h=From:Subject:Date:To:Cc;
 b=T+Nwu2VsK+tspMjIiOFlbPzSR6vPgePiQKkaxTsdB4Rrl11XwKI+CiPv11z4TnDN7
 6KsaS3RFj9UVULwa7JolIvvk6PfqYyag8zyjqa7ov31Jiy1iKSr+fljeK8VMInqVP+
 UZauVpK8vYEH/dumh1mhXC+uRWPH5YrF8ScbbuO5KubrjjgTm/b8OGjokDDllJaMqj
 WfNiTm6ne7iQr0mz+WG+o8aV1uTp+FMKzCpuetijF3dDWY+MvIEyzR7Dq5iXZ8IOwu
 jVUy/aIZxDVj/ZICPNhruZmJBoh34k3cp+c3H2gKn5SmhKSSZwWv4muNQkp3QfC3pa
 Lr1lK8EQ68XBw==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v7 00/34] drm: Implement state readout support
Date: Thu, 29 Oct 2026 08:33:50 +0100
Message-Id: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/23P0W6DIBTG8VcxXPcsBxAUr/Yeyy4oHFuyqi1Q0
 6Xpuy9qtnbRS0i+H3/uLFEMlFhT3FmkMaQw9Kwpql3B3NH2B4LgWVMwgUJhJRF87CBlmwkiWT9
 cM3CsW6yN404i2xXsHKkNt9n8+FzOkS7XkEJeLtneJgI3dF3ITTGBXUgOerplECg0cAQh2bQ9h
 pSH+D3njXwezyUGxUbJyAGBl9YryZW3sn3/otjT6W2Ih5kbxS+hsRRyixCAUKvStHXl9qaqV4R
 8ElroLUICgle1UCSFMXZNlK+E2SJKQFBGa60qUyP5V2JXLFPDl9f7AbohEpxPtp+IRBlGBQitM
 ugFomyFWzWoZ4PBaqthIlRruXWVVbxcf0P/ERy52iI0IGjnUDjP0Zj/xOPx+AGRaeiDfwIAAA=
 =
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
 Jocelyn Falempe <jfalempe@redhat.com>, 
 Simona Vetter <simona.vetter@ffwll.ch>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9848; i=mripard@kernel.org;
 h=from:subject:message-id; bh=1zHA/UEE7dvErvTvEVz2sWfkztCHg+Y6VG2ML5OwzfA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmPvr0oOFLjVc97fOX3D0Lsq84EPxN26xHf5GTFpjc5f
 ulu0xN+HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAii08zNsyw071ypmndnpga
 eU9H8Usdl2fvPi351nBS5pMppv83l//6YHnxsWjykZSWb0ye3QfvmjA2bFvSzCzkm39B6PK8roU
 v4nn2X/K9+zsz3lMm+1TnL36F3zUJbrKLHJQ2uEoLrmEp2u8EAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Changes in v7:
- Add kunit tests for state readout handling
- Fix kunit test breakages
- Fix sashiko reviews
- Rename drm_atomic_sro.c to drm_atomic_state_readout.c
- Improve documentation
- Fix comparisons macros and functions
- Improve tidss readout implementation
- When committing after a commit, only readout and compare the objects
  part of that commit (and we have the locks for)
- Add kunit tests for the read-out logic
- Improve tidss read-out implementation
- Improve si902x read-out implementation
- Link to v6: https://lore.kernel.org/r/20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org

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
Maxime Ripard (34):
      drm/bridge-helper: Don't unlock the connection mutex after a backoff
      drm/tests: hdmi-state-helper: Handle EDEADLK in the 420-only test
      drm/tests: hdmi-state-helper: Handle EDEADLK in the color format test
      drm/atomic: Fix private obj error handling
      drm/atomic: Add drm_private_obj name
      drm/bridge: Switch print_state to use bridge name
      drm/bridge: Add drm_private_obj_is_bridge()
      drm/fb-dma-helper: Handle framebuffers without a GEM object
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
      drm/tests: kunit: Add a drm_printer helper
      drm/tests: Add tests for the atomic state readout
      drm/encoder: Create atomic_sro_get_current_crtc hook
      drm/bridge: display-connector: Implement readout support
      drm/bridge_connector: Implement hw readout for connector
      drm/tidss: crtc: Add atomic_print_state implementation
      drm/tidss: dispc: Improve mode checking logs
      drm/tidss: Implement hw_reset
      drm/tidss: Implement readout support
      drm/tidss: encoder: Implement atomic_sro_get_current_crtc
      drm/bridge: sii902x: Implement hw state readout

 Documentation/gpu/drm-kms-helpers.rst              |   26 +
 drivers/gpu/drm/Makefile                           |    2 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |    1 +
 .../drm/arm/display/komeda/komeda_private_obj.c    |    8 +
 drivers/gpu/drm/bridge/display-connector.c         |   69 +
 drivers/gpu/drm/bridge/sii902x.c                   |   91 +-
 drivers/gpu/drm/display/drm_bridge_connector.c     |   36 +
 drivers/gpu/drm/display/drm_dp_mst_topology.c      |    2 +-
 drivers/gpu/drm/display/drm_dp_tunnel.c            |    1 +
 drivers/gpu/drm/drm_atomic.c                       |   57 +-
 drivers/gpu/drm/drm_atomic_helper.c                |   45 +
 drivers/gpu/drm/drm_atomic_state_helper.c          |   20 +-
 drivers/gpu/drm/drm_atomic_state_readout.c         |  974 +++++++++++++
 drivers/gpu/drm/drm_atomic_state_readout_helper.c  |  974 +++++++++++++
 drivers/gpu/drm/drm_bridge.c                       |  131 +-
 drivers/gpu/drm/drm_bridge_helper.c                |   35 +-
 drivers/gpu/drm/drm_fb_dma_helper.c                |    8 +
 drivers/gpu/drm/drm_internal.h                     |   13 +
 drivers/gpu/drm/drm_mode_config.c                  |   76 +-
 drivers/gpu/drm/drm_modeset_helper.c               |   31 +
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c          |    1 +
 drivers/gpu/drm/ingenic/ingenic-ipu.c              |    1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |    1 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c           |    1 +
 drivers/gpu/drm/omapdrm/omap_drv.c                 |    1 +
 drivers/gpu/drm/tegra/hub.c                        |    1 +
 drivers/gpu/drm/tests/Makefile                     |    1 +
 .../gpu/drm/tests/drm_atomic_state_readout_test.c  | 1501 ++++++++++++++++++++
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c |   30 +-
 drivers/gpu/drm/tests/drm_kunit_helpers.c          |   78 +
 drivers/gpu/drm/tidss/tidss_crtc.c                 |  101 ++
 drivers/gpu/drm/tidss/tidss_dispc.c                |  371 ++++-
 drivers/gpu/drm/tidss/tidss_dispc.h                |   19 +
 drivers/gpu/drm/tidss/tidss_encoder.c              |   57 +
 drivers/gpu/drm/tidss/tidss_kms.c                  |   20 +-
 drivers/gpu/drm/tidss/tidss_plane.c                |  178 +++
 drivers/gpu/drm/vc4/vc4_kms.c                      |    3 +
 include/drm/drm_atomic.h                           |   78 +-
 include/drm/drm_atomic_state_readout.h             |   59 +
 include/drm/drm_atomic_state_readout_helper.h      |  283 ++++
 include/drm/drm_bridge.h                           |   97 ++
 include/drm/drm_connector.h                        |   74 +
 include/drm/drm_crtc.h                             |   74 +
 include/drm/drm_encoder.h                          |   18 +
 include/drm/drm_kunit_helpers.h                    |    4 +
 include/drm/drm_mode_config.h                      |   54 +
 include/drm/drm_modeset_helper.h                   |    1 +
 include/drm/drm_modeset_helper_vtables.h           |   34 +
 include/drm/drm_plane.h                            |   74 +
 49 files changed, 5749 insertions(+), 66 deletions(-)
---
base-commit: 128013e9fec562672562dffd4ad468492f5915c8
change-id: 20250730-drm-state-readout-108f089c1c30

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

