Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D793606A334
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f3myjR68
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6D181129D1;
	Fri, 20 Nov 2026 12:55:27 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D1241129CD
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:55:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C9446615E4;
 Fri, 20 Nov 2026 12:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086641F000C6;
 Fri, 20 Nov 2026 12:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795179320;
 bh=gUF9+8DKeiOPE0+xA7Nq+Cy2W6LWEGFZQ+mDMLk2WSk=;
 h=From:Subject:Date:To:Cc;
 b=f3myjR68qgnrAYBwrhOoUPhtHh+3YgPE4WQXIpM9gjwnyIdlAFiuShMxeKbmpxRCo
 K2wB8+Xx1S8kMZfL4UbR8223OpK0TwbnNHd88JXb1zgOOJvdL7DRJhLrjN++/uW18F
 2vBH8dyMECp/9F1Q5zM31bkcI3lW3NT2tQ75nd9XVd07CNcBKsqCMiHVcRtDzUyFaq
 AT2P+3N3Dq9smwUKGIXuQtFS3pcbleB2nz6r/Nf0GCkjqX32kTIr5P/IJp/an250yV
 oJTNJ88s1qrWoxVW6qsFL3s/yWBNw6ivejmIY8yV301vxce6Q23Vw3liRAoVH79XXG
 PlgP1LOqxX5Gw==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v9 00/42] drm: Implement state readout support
Date: Fri, 20 Nov 2026 13:54:52 +0100
Message-Id: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/23RTW7bMBAF4KsIXHuKGVLDH616j6ILihzFRGMpo
 RQhReC7F5bR2oW0JAF+783wS81Si8yqa75UlbXMZRpV14RTo9I5ji8CJauuURo1ozMIuV5gXuI
 iUCXm6WMBQj+gD4mSQXVq1FuVoXxu5o+f93OV948yl+V+qfo4C6TpcilL19zAS5kTjPK5gEZtg
 QgobFRc0hlK7prBJ2M859aK7sWlPlqfHLEYGqg3Ej3GlqVXt8RzmZep/t6GWmmL3PoH1Af9VwI
 EamNmQ5yjGb7/kjrK67epvmzcqv8SFlttjggNCJ7bMHiX+uD8jjAPwmp7RBhAyOw1i9EhxD3RP
 hPhiGgBgYO1ll3wKPmZODX3p4Hu6eMEl6kKvL3G8UbMssDKgDBwwKwRzaDTrgM/OgR0Rx1uBA+
 RYnKRqd2PYf8RhMRHhAUEmxLqlAlD2BPuiTjehAMEzcJkTXaczI7wD4Lw8D88IKRenLe6Fer/3
 8X1ev0DH7GFrjsDAAA=
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
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Jocelyn Falempe <jfalempe@redhat.com>, 
 Simona Vetter <simona.vetter@ffwll.ch>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=12852; i=mripard@kernel.org;
 h=from:subject:message-id; bh=+1CydSIAejbAqMBwIdBwxa840fOlMyWDwwHyu9laZlk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNkMzkqZW2K4nZ1SHkQkvd7OqRP8luXOQ4HXamJHOeQ+L
 Gd69ep5x1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZiIWgFjfUDqusBetUtfn655
 mitvF8u57u3ii2dP7TrEvFpGkW3+DCOnl91hW6ul2sS7j7MunPTVnLGKSWjjjEQR08UNbQdulZW
 /jZ3kIbmtL4TrWWXgD7mSVLZ01bmbsvneZ73M89q12HuZegAA
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
Changes in v9:
- Add drm_atomic_get_connector_for_encoder_locked to make locks handling
  easier
- Drop drm_atomic_private_obj_set_name()
- Turn drm_atomic_sro_install_state into a hook and a helper
- Clarify bridge bus flags and formats expectations
- Add bridge install_state hook
- Fix a whole bunch of sashiko issues
- Ease the framebuffer comparisons, since it's often impossible to
  readout the offsets, width and height from the registers
- Ease the plane comparisons since it's often impossible to readout the
  src_x and src_y coordinates
- Ease the plane zpos comparison and only compare one of zpos or
  normalized_zpos, dependending on mode_config.normalize_zpos value
- Only compare connector states if both states are bound to a crtc
- Clarify vblank expectations for the CRTCs, and add unit tests
- Split the tidss readout support into multiple patches to ease review
- Link to v8: https://lore.kernel.org/r/20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org

Changes in v8:
- Convert ingenic to properly allocated bridge
- Improve locking
- Export more functions needed to compile helpers as modules
- Fix idempotency of drm_atomic_private_obj_fini
- Fix DP-MST private objects name
- Handle framebuffers without a GEM object in drm_gem_plane_helper_prepare_fb
- Improve SRO container accessors safety
- Add documentation for kernel parameter
- Drop some easy to trigger WARN calls
- Handle plane, connector and encoder masks better when doing a partial
  update (and readout)
- Only compare the states if they are both active, other comparisons
  improvements
- More kunit tests to test kernel parameter behaviour, DPMS
- Fix memomry leaks in kunit tests
- Fix bridge_connector of bridges with and whithout SRO support
- Improve runtime_pm handling for tidss hw_reset
- Tentative support for tidss OLDI and multiple plane and CRTCs
- Improve error handling for sii902x
- Implement readout state for panel bridge 
- Link to v7: https://lore.kernel.org/r/20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org

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
Maxime Ripard (42):
      drm/atomic: Add drm_atomic_get_connector_for_encoder_locked()
      drm/bridge-helper: Don't unlock the connection mutex after a backoff
      drm/tests: hdmi-state-helper: Handle EDEADLK in the 420-only test
      drm/tests: hdmi-state-helper: Handle EDEADLK in the color format test
      drm/colorop: Export drm_atomic_helper_colorop_create_state()
      drm/atomic: Fix private obj error handling
      drm/atomic: Add drm_private_obj name
      drm/bridge: Switch print_state to use bridge name
      drm/bridge: Add drm_private_obj_is_bridge()
      drm/fb-dma-helper: Handle framebuffers without a GEM object
      drm/gem-atomic-helper: Handle framebuffers without a GEM object
      drm/atomic: Export drm_atomic_*_print_state
      drm/atomic_sro: Create drm_atomic_sro_state container
      drm/atomic_sro: Create kernel parameter to force or disable readout
      drm/atomic_sro: Add atomic state readout infrastructure
      drm/atomic_sro: Create documentation
      drm/bridge: Handle bridges with hardware state readout
      drm/mode-config: Read out hardware state in drm_mode_config_create_initial_state
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
      drm/tidss: Implement hw_reset
      drm/tidss: crtc: Implement hardware state readout
      drm/tidss: encoder: Implement hardware state readout
      drm/tidss: kms: Hook up hardware state readout
      drm/tidss: plane: Implement hardware state readout
      drm/tidss: dispc: Add hardware state readout helpers
      drm/tidss: encoder: Implement atomic_sro_get_current_crtc
      drm/bridge: sii902x: Implement hw state readout
      drm/panel: Implement state readout support
      [DO NOT MERGE] fixup! drm/tidss: dispc: Add hardware state readout helpers
      [DO NOT MERGE] drm/tidss: oldi: Implement hardware state readout
      [HACK] drm/panel: Prepare and enable panels read out as active

 Documentation/admin-guide/kernel-parameters.txt    |   12 +
 Documentation/gpu/drm-kms-helpers.rst              |   26 +
 drivers/gpu/drm/Makefile                           |    2 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |    1 +
 .../drm/arm/display/komeda/komeda_private_obj.c    |    8 +
 drivers/gpu/drm/bridge/display-connector.c         |   75 +
 drivers/gpu/drm/bridge/sii902x.c                   |  130 +-
 drivers/gpu/drm/display/drm_bridge_connector.c     |   65 +-
 drivers/gpu/drm/display/drm_dp_mst_topology.c      |    2 +-
 drivers/gpu/drm/display/drm_dp_tunnel.c            |   15 +-
 drivers/gpu/drm/drm_atomic.c                       |  119 +-
 drivers/gpu/drm/drm_atomic_helper.c                |   45 +
 drivers/gpu/drm/drm_atomic_state_helper.c          |   20 +-
 drivers/gpu/drm/drm_atomic_state_readout.c         |  909 +++++++++
 drivers/gpu/drm/drm_atomic_state_readout_helper.c  | 1360 ++++++++++++++
 drivers/gpu/drm/drm_bridge.c                       |  180 +-
 drivers/gpu/drm/drm_bridge_helper.c                |   31 +-
 drivers/gpu/drm/drm_colorop.c                      |    1 +
 drivers/gpu/drm/drm_fb_dma_helper.c                |   10 +
 drivers/gpu/drm/drm_gem_atomic_helper.c            |   14 +-
 drivers/gpu/drm/drm_internal.h                     |   13 +
 drivers/gpu/drm/drm_mode_config.c                  |   75 +-
 drivers/gpu/drm/drm_modeset_helper.c               |   31 +
 drivers/gpu/drm/drm_panel.c                        |  152 ++
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c          |    1 +
 drivers/gpu/drm/ingenic/ingenic-ipu.c              |    1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |    1 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c           |    1 +
 drivers/gpu/drm/omapdrm/omap_drv.c                 |    1 +
 drivers/gpu/drm/tegra/hub.c                        |    1 +
 drivers/gpu/drm/tests/Makefile                     |    1 +
 .../gpu/drm/tests/drm_atomic_state_readout_test.c  | 1934 ++++++++++++++++++++
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c |   30 +-
 drivers/gpu/drm/tests/drm_kunit_helpers.c          |   78 +
 drivers/gpu/drm/tidss/tidss_crtc.c                 |  132 ++
 drivers/gpu/drm/tidss/tidss_dispc.c                |  504 ++++-
 drivers/gpu/drm/tidss/tidss_dispc.h                |   24 +
 drivers/gpu/drm/tidss/tidss_encoder.c              |   57 +
 drivers/gpu/drm/tidss/tidss_kms.c                  |   21 +-
 drivers/gpu/drm/tidss/tidss_oldi.c                 |  157 ++
 drivers/gpu/drm/tidss/tidss_plane.c                |  224 +++
 drivers/gpu/drm/vc4/vc4_kms.c                      |    3 +
 include/drm/drm_atomic.h                           |   81 +
 include/drm/drm_atomic_state_readout.h             |  241 +++
 include/drm/drm_atomic_state_readout_helper.h      |  284 +++
 include/drm/drm_bridge.h                           |  135 ++
 include/drm/drm_connector.h                        |   75 +
 include/drm/drm_crtc.h                             |   80 +
 include/drm/drm_encoder.h                          |   18 +
 include/drm/drm_kunit_helpers.h                    |    4 +
 include/drm/drm_mode_config.h                      |   62 +
 include/drm/drm_modeset_helper.h                   |    1 +
 include/drm/drm_modeset_helper_vtables.h           |   63 +
 include/drm/drm_plane.h                            |   75 +
 54 files changed, 7467 insertions(+), 119 deletions(-)
---
base-commit: e6e635c4407e5bb8ddc6017a2e9825c17240e799
change-id: 20250730-drm-state-readout-108f089c1c30
prerequisite-patch-id: f8c3385d46e2be7cba68c715e31f1b3ea80a45eb

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

