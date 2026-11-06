Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DD0606A329
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MX1rJpJQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A174010E3BC;
	Fri,  6 Nov 2026 13:14:51 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7014710E269
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:14:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 83134601BF;
 Fri,  6 Nov 2026 13:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63E61F0089F;
 Fri,  6 Nov 2026 13:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793970882;
 bh=1VVFUDc8ZFkhmW84wt9WArJyplLlcIDu/PJsDVybCLg=;
 h=From:Subject:Date:To:Cc;
 b=MX1rJpJQQFJyTFbmsSXbTjBTj1W7c9yLwYzxJ9ZbXHZdxNfj3tpWUde43mP8OFogb
 S7KAhs9oYVW/IsvJrVLnwdKpRRTdJgmJwfltBdkmj1qxtdLIs/ud3MxYeYXzqmu0mC
 aKHtLnd/LNHObF3RA/2IkBSoAujDZDrv+Sm4SfSNdforOSY7ddfgvF2PJkaTLm3Y1v
 +BzY8E1Mvh/Cv7ANF/wARqpJTJVLlu/siUF7OgmX9gnBVdsiGE6Qt7H9tqmU+NAZIf
 TNj4CHL2E4e4F/5duj9J9zVtLzGyNoDFqjx2jGqy+/De4jWbZItwtFsLTBu7o28/Zu
 DCBQQZdRzx0ZQ==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v8 00/39] drm: Implement state readout support
Date: Fri, 06 Nov 2026 14:14:13 +0100
Message-Id: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/23QTW7jMAwF4KsYWocFJZn68ar3KGahSFQqTG23k
 hvMoMjdB3HQNh17KQH8Hh8/RONauImh+xCVz6WVeRJD5w6diM9hOjGUJIZOKFSEViOkOkJbwsJ
 QOaT5fQGJLqPzUUaN4tCJ18q5/FnNp1+3d+W399LKcvsUx9AY4jyOZRm6pIKLzF4ec7iOj9xaW
 HOHTqEyUiKtqdMM41yvg1MuJ6jceIGzBASZySXJWmuHj7+5TvzyMNeTuKY/l7bM9e9a8CzX+LW
 LR7XT5cb1IZGWlILO/3Nn9UkY7JXeIxQgOOp9djYevXUbQn8TRpk9QgNCIqeItfI+bIn+nvB7R
 A8I5I0xZL1DTvfEobuNeml+XPb1JUz8eVgChEwek0LUWcXNDvS9g0e7t8OVoBxkiDaQ7Lc1zBc
 hUdIeYQDBxIgqJonebwl7R+xfwgKCIiZpdLIU9Q/icrn8A7zhlnkEAwAA
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
 Maxime Ripard <mripard@kernel.org>, Paul Cercueil <paul@crapouillou.net>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Jocelyn Falempe <jfalempe@redhat.com>, 
 Simona Vetter <simona.vetter@ffwll.ch>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=17081; i=mripard@kernel.org;
 h=from:subject:message-id; bh=W+c+TfHvNHsgwDJDuY3/BKzzuEnaipA97eILSRpR29Y=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvL625ZffcRPLGPp5akUuys8/cT5YW23sj20/8rt+bn
 uM2VvVfOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBE6oUYq5gjuyeKnH5xI8HF
 NfjHudzN+Y0skduNr011MIxsvrj9gyT7Z4WoKWan/omuVN6cHd2hyFhnvSfdxz/xsXfMM+2W7eL
 K0ywsM/OfLrtavmzvljmSDVGCx9+83fg86kyUlunL24r/rqUDAA==
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
Maxime Ripard (39):
      drm/ingenic: Convert to devm_drm_bridge_alloc()
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
      drm/panel: Implement state readout support
      fixup! drm/tidss: Implement readout support

 Documentation/admin-guide/kernel-parameters.txt    |   12 +
 Documentation/gpu/drm-kms-helpers.rst              |   26 +
 drivers/gpu/drm/Makefile                           |    2 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |    1 +
 .../drm/arm/display/komeda/komeda_private_obj.c    |    8 +
 drivers/gpu/drm/bridge/display-connector.c         |   69 +
 drivers/gpu/drm/bridge/sii902x.c                   |  120 +-
 drivers/gpu/drm/display/drm_bridge_connector.c     |   65 +-
 drivers/gpu/drm/display/drm_dp_mst_topology.c      |    2 +-
 drivers/gpu/drm/display/drm_dp_tunnel.c            |   21 +-
 drivers/gpu/drm/drm_atomic.c                       |   92 +-
 drivers/gpu/drm/drm_atomic_helper.c                |   45 +
 drivers/gpu/drm/drm_atomic_state_helper.c          |   20 +-
 drivers/gpu/drm/drm_atomic_state_readout.c         | 1058 ++++++++++++
 drivers/gpu/drm/drm_atomic_state_readout_helper.c  | 1125 +++++++++++++
 drivers/gpu/drm/drm_bridge.c                       |  140 +-
 drivers/gpu/drm/drm_bridge_helper.c                |   47 +-
 drivers/gpu/drm/drm_colorop.c                      |    1 +
 drivers/gpu/drm/drm_fb_dma_helper.c                |    8 +
 drivers/gpu/drm/drm_gem_atomic_helper.c            |   14 +-
 drivers/gpu/drm/drm_internal.h                     |   13 +
 drivers/gpu/drm/drm_mode_config.c                  |   76 +-
 drivers/gpu/drm/drm_modeset_helper.c               |   31 +
 drivers/gpu/drm/drm_panel.c                        |  123 ++
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c          |   16 +-
 drivers/gpu/drm/ingenic/ingenic-ipu.c              |    1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |    1 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c           |    1 +
 drivers/gpu/drm/omapdrm/omap_drv.c                 |    1 +
 drivers/gpu/drm/tegra/hub.c                        |    1 +
 drivers/gpu/drm/tests/Makefile                     |    1 +
 .../gpu/drm/tests/drm_atomic_state_readout_test.c  | 1739 ++++++++++++++++++++
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c |   30 +-
 drivers/gpu/drm/tests/drm_kunit_helpers.c          |   78 +
 drivers/gpu/drm/tidss/tidss_crtc.c                 |  119 ++
 drivers/gpu/drm/tidss/tidss_dispc.c                |  525 +++++-
 drivers/gpu/drm/tidss/tidss_dispc.h                |   22 +
 drivers/gpu/drm/tidss/tidss_drv.c                  |   22 +-
 drivers/gpu/drm/tidss/tidss_encoder.c              |   57 +
 drivers/gpu/drm/tidss/tidss_kms.c                  |   20 +-
 drivers/gpu/drm/tidss/tidss_oldi.c                 |  138 ++
 drivers/gpu/drm/tidss/tidss_plane.c                |  205 +++
 drivers/gpu/drm/vc4/vc4_kms.c                      |    3 +
 include/drm/drm_atomic.h                           |   81 +
 include/drm/drm_atomic_state_readout.h             |   66 +
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
 55 files changed, 6836 insertions(+), 123 deletions(-)
---
base-commit: d2a8cee91bfa8616f713c7c8f539a81e8e3554ea
change-id: 20250730-drm-state-readout-108f089c1c30
prerequisite-message-id: 20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org
prerequisite-patch-id: 3fd105fbfdbb4eee1f8ae9682b359477d5c2d610
prerequisite-patch-id: ed1d1dd244e64b18c5682800b546ebb2d0f44ec8
prerequisite-patch-id: 6b00324107d28bfe6ccd346730c6370d8f8362c4
prerequisite-patch-id: bac8bfa53c3c77a832500f711322530e39d26c74
prerequisite-patch-id: 60002e0ea0141b4051f2062152244b545450ffdf
prerequisite-patch-id: a82ef0b22909efd3a2f1a779e27ad60b08554203
prerequisite-patch-id: 4d4db6fb993ce12a03f5f22e07b060defc28b7d8
prerequisite-patch-id: 7a716ac0b6df5a2d9423bfa09457e7c2ae11e35f
prerequisite-patch-id: 35c60176b5a45a76a30285767fba4f83c5059868
prerequisite-patch-id: 23ef4052a7a932ec4611b640d4323e0f93760a6d
prerequisite-patch-id: f6a08bc40145c9a61508a37fe632e007c58566b9
prerequisite-patch-id: 942ec51b8579c4a7d5652d390dbcaa6fe1ef35bb
prerequisite-patch-id: cac9b8740c50ed002bdb7df8471c4493a53948b0
prerequisite-patch-id: 083d50c81b3609bc6756a2b9c89b30c5918dbcd3
prerequisite-patch-id: 97dd764d28e34d6c1fd346602931c1688aa4fe8d
prerequisite-patch-id: 566c8a35a9734a8e8a254afcc0fbd9765c980334
prerequisite-patch-id: a2ae7568eef2833217f55eb9528e2f846c73f993
prerequisite-patch-id: 4bdc653ad663151585ed7d71ed9f70ac702301fa
prerequisite-patch-id: ee3f427f087dde1290f0c0a3e821379427552961
prerequisite-patch-id: d14cd6008b88c7c9b61ca5241c961c4747a6fdfe
prerequisite-patch-id: c642e4fcebdbfc0ab86bba68c957ad5bbe62ef58
prerequisite-patch-id: 71afb7db95568dfa686ab670039ba60faeb91914
prerequisite-patch-id: 6557c88b83cd8d2ded0e4d70378c9a868659fea0
prerequisite-patch-id: 4020d12428794416f75edb398d84a6a14905f588
prerequisite-patch-id: a4806b41921baa3b8a3039d5431e099138fe6fa6
prerequisite-patch-id: 7a742e65aa5d69a733376641d0eb45281239b866
prerequisite-patch-id: ba3e625c15aa8e34747292c95ea9158b0cb98b34
prerequisite-patch-id: ba92010fead3c007e2cbaeb15bce922eb304ccac
prerequisite-patch-id: 2fc97bb7478092919001b21d2455a73373a5ba73
prerequisite-patch-id: 97a28c8af17b043429e3b40325576f74518ff802
prerequisite-patch-id: 37ae6417556eea439aab01725cfd920c1107e630
prerequisite-patch-id: 3f8725771832d7cccd8c88a33b4fac362a2a1221
prerequisite-patch-id: 5d51033ca88aa46e8347396cdc17fd5473636c13
prerequisite-patch-id: 983be3e35801efe3052f0983d728a9703e7ded88
prerequisite-patch-id: 20f874f2f1b44d9a27824a2e3944477fc3c02af5
prerequisite-patch-id: fc7f1510621f228d42bf1666c06f34926f3e10f4
prerequisite-patch-id: b9e987299142a89ca3a7bfb5b0335a215c7cdd52
prerequisite-patch-id: 1d11dea3090f6b72322c3827bd260ed3d12e1201
prerequisite-patch-id: 4182aa31cbc4b985e3a628c3dc9a2fd039188f7e
prerequisite-patch-id: 7b7f07b1c57398f185a93d6b3212394753292be7
prerequisite-patch-id: e6bd5afbc9593e93203caa0ae9f08545511e2bf2
prerequisite-patch-id: c6d466588800f94684ebf9fb785ce085510c8f93
prerequisite-patch-id: 5f8a9d6fd20c05d708df6424102575251d32331f
prerequisite-patch-id: 18c2d823dc5b44514c0b2278986933a1a9834f02
prerequisite-patch-id: a8c4944302cbea92690957fd18162ca303757874
prerequisite-patch-id: 962e6cc26e53a3319302fd4c2aae2bc4b593f4be
prerequisite-patch-id: 366fc63bc744ea4a2af4f16befaa1d7e8c66bf84
prerequisite-patch-id: 33c4fd1e1ccd1eac9fde961a0f7ed8509e713c7e
prerequisite-patch-id: 496318ad0a87ec138780d4a50a2f8a49ca126ca6
prerequisite-patch-id: f85ec023f5ab9903987d867c330bde94b3c24c55
prerequisite-patch-id: 34fc06cb69e34ec4d67015187969e8d2c0c56660
prerequisite-patch-id: 3b789a4e47c47f855c44c125a75de3a79709d411
prerequisite-patch-id: b03787ca5a3d60d4ad5682313424a114c1862fb0
prerequisite-patch-id: 4ec079edf0025f849b1b8c7e3beb47db057ab6d2
prerequisite-patch-id: b44382d38528c92150f2d7cac5722cf8e09c0fab
prerequisite-patch-id: 02e42a505f17dbf5bc3e85b55d5df716e3819141
prerequisite-patch-id: faf2c686c253faa5a81801f78ba955d3ae8c0c4f
prerequisite-patch-id: 6407fec511e4d3bf785c3be581b828abac884ba7
prerequisite-patch-id: 1a9fc394fdf6b19434652a4c137a0ea819702325
prerequisite-patch-id: 6de415eec4ab2f2b8dec1f194fb89cfe01568f9b
prerequisite-patch-id: 73e1360c2be46882c0ca58d6d60f0c394f1d47f4
prerequisite-patch-id: fada6f5ef59f7119d5b202b64ce2184795428d7c
prerequisite-patch-id: 7f31438e1f326350688f7aa7169038a7a33b4ddc
prerequisite-patch-id: a9940a88c19f95573008a9e2bd950a43c12b7e3c
prerequisite-patch-id: 2d5e46c029b523f6d6f13a0716e56267691757cf
prerequisite-patch-id: 7aa60266913380f85e46f8dc71885356e3d7902a
prerequisite-patch-id: cd12813a72a4c558660f8f8d093928533ddbf5ee
prerequisite-patch-id: 186129fe8188f5b7cb6fef2701400fc6772aaf2e
prerequisite-patch-id: c99a84af1b60e1c8f80168706f5ed600a6eb4553
prerequisite-patch-id: 598515adbecc5c14e8ffe631206a906fb2c9f59c
prerequisite-patch-id: cf84de09ca65f4577268e9a4a8a166436735b7da
prerequisite-patch-id: cfd9ec749b0f3c78e0a64a73756f978bfd853391
prerequisite-patch-id: 87104eb556b1cef43ded0979f0b806f35ec819bb
prerequisite-patch-id: 5536c46e78e53cc31224b2730ca5fb454cd17761
prerequisite-patch-id: 48e3546e357a8e68e4abaeb2faf1081afb8f3ae3
prerequisite-patch-id: be78356c5aabcd0e68c61b2bc785c73a0c2edff9
prerequisite-patch-id: 7192a8aa88903ca758655dea8eaac94b98481e82
prerequisite-patch-id: f28910d02bfc6e11c1ecc2ce03db57ccaba0d185
prerequisite-patch-id: 48fc2a91c98aac131457deed8d9c2965eaffd1fb
prerequisite-patch-id: 0c829edd4d3d8cb4765d649411dec1124fd20fbd
prerequisite-patch-id: e994569657dc0537d6d3b9f7cd4d919ba2602126
prerequisite-patch-id: bce46caeb9616651be519c0474855ce9341de611
prerequisite-patch-id: a2a70a62d2684c072e3927abeb7a9e86dbec759b

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

