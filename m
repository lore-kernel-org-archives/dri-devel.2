Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AC5C43602
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:46:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9D4210F375;
	Thu,  2 Jul 2026 14:46:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="TNFjjvAB";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 571B210F375
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 14:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783003591;
 bh=Ou+ENO0xLbokUnTy4g0RXMQ2CFxIbN1tHjqNYZz1Vzg=;
 h=From:Subject:Date:To:Cc:From;
 b=TNFjjvABWiyidTVci8wNbQ8aO0cd9LYjF1+I1lby8GQWX/u66fTKDnA/k5jLxviPq
 TU/pVef9Jwed11q+H/ApyPyAg3Z3fezOVdIG2AJno7rJ+1Dayc1gZEi40Q0BkHaCYq
 tf7ipqaIG0K1Lc8B6FnCHgOHbVt/CwOKJ1LvTveSkeGieYUIVljm5YcvOiJIMOLDtm
 rzrh1TE/3+0fxi4Bkelqqu2IuLtXuJAgtgiZFogO4e4+yMrC+08haqDd0Juu4ouCqe
 GYXpqmgGyVns3BY8kgY4djWe1ad8TTO8geNCR77Fgpm0E+tK18IlfADKZ/CQ6SY3Cc
 hOUFNM5Ii64Sg==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 756F317E0CA0;
 Thu,  2 Jul 2026 16:46:31 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v8 00/39] Add HDMI 2.0 support to DW HDMI QP TX
Date: Thu, 02 Jul 2026 17:46:13 +0300
Message-Id: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33Q3UrEMBAF4FdZcm0kM/ntXvke4kWTTG1gu11Tq
 crSd3d2QSoYvDyB+TJnrmKhWmgRx8NVVFrLUuYzh/BwEGnsz68kS+YsUKEFVFrmDznmqci3i1x
 S7acoU445ROtTGjrBc5dKQ/m8m88vnMeyvM/16/7FCrfX/7QVpJJBu4G8UdC77inNp1Mf59o/p
 nkSN3HFH8UpgKaCrPTkIyYbMprcUvRvpWspmhUu5wC8VkOClmJ2RbcbGVY0+KxjiBmh2cjuikH
 XUiwr2ftAXiXWYktxu2JRtRTHCproDW8bfcCW4nfFKWwpnhVjLEVriID+XHfbtm+g7uOPWgIAA
 A==
X-Change-ID: 20251203-dw-hdmi-qp-scramb-cdbd8b57ccf9
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Daniel Stone <daniels@collabora.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Diederik de Haas <diederik@cknow-tech.com>, 
 Maud Spierings <maud_spierings@hotmail.com>
X-Mailer: b4 0.15.2
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

Enable HDMI 2.0 display modes (e.g. 4K@60Hz) on the Synopsys DW HDMI QP
TX controller, as found in Rockchip RK3576 & RK3588 SoCs, by adding SCDC
management for high TMDS clock ratio and scrambling.

Since SCDC state is lost on sink disconnects, the bridge driver needs to
trigger a CRTC reset during connector detection.  To support this, the
series introduces the connector and bridge scrambling infrastructure
(patches 1-8), wires it up through the bridge connector layer with an
atomic-aware detect_ctx hook (patches 9-11), then implements the SCDC
scrambling feature in the DW HDMI QP bridge driver (patches 12-15).

Patches 16-18 are minor cleanups in the Rockchip platform driver.
Patches 19-23 improve HPD handling by deferring IRQ registration until
the connector is fully initialized, adding .enable_hpd()/.disable_hpd()
PHY ops, and restricting HPD events to the affected connector.

Patches 24-25 convert vc4 HDMI to the common SCDC scrambling helpers as
a proof of reuse, replacing the driver-local scrambling implementation.

Patches 26-30 add KUnit tests: connector scrambler validation, a new
4K@60Hz 600MHz EDID, hdmi_state_helper scrambling tests, and EDID
conformity fixes for some of the existing test blobs.

This has been tested on the following boards:

* Radxa ROCK 5B (RK3588)
* Radxa ROCK 4D (RK3576)
* Raspberry Pi 5 Model B Rev 1.1 (BCM2712 D0)

Note that commit d87773de9efe1 ("clocksource/drivers/arm_arch_timer:
Default to EL2 virtual timer when running VHE"), introduced in v7.2-rc1,
causes Raspberry Pi 5 to hang during boot.  Reverting the commit
restores normal boot.  This issue has already been reported in [1];
alternatively, the workaround proposed in [2] can be applied.

Regards,
Cristian

[1] https://lore.kernel.org/all/ea15cce1-b393-43f6-8d58-3d6f90f0c0cd@samsung.com/
[2] https://lore.kernel.org/all/20260619204832.586079-1-dan@reactivated.net/

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Changes in v8:
- Added an enum hdmi_version under video/hdmi to describe the HDMI
  specification version a source/sink supports (new patch 1)
- Introduced HDMI connector capabilities API and reworked the
  infrastructure patches on top of it: drmm_connector_hdmi_init() now
  takes a drm_connector_hdmi_caps struct that carries supported_formats,
  max_bpc, supported_hdmi_ver and max_tmds_char_rate (new patches 2-3)
- Moved all the new SCDC helpers covering both source and sink to
  display/drm_hdmi_helper.c
- Renamed drm_scdc_{start,stop}_scrambling() to
  drm_connector_hdmi_{enable,disable}_scrambling() and added a
  connector-state argument so the scrambler_needed flag is checked
  centrally instead of in every driver
- Renamed drm_scdc_sync_status() to drm_connector_hdmi_sync_scdc(),
  aligned its lifecycle with vc4_hdmi_reset_link(), and removed the
  internal drm_scdc_reset_crtc() helper; it now also gates on CRTC state
  and an in-flight commit (Maxime)
- Changed the prototype of drm_atomic_helper_connector_hdmi_hotplug() to
  take an acquire context and an int return, instead of adding a new
  _ctx variant (Maxime)
- Added drm_hdmi_mode_needs_scrambling() to centralise the above-340 MHz
  decision (new patch 7)
- Made SCDC source version negotiation optional and moved it to a
  dedicated patch "drm/display: hdmi: Advertise SCDC source version when
  scrambling" (new patch 8), backed by a new
  drm_scdc_set_source_version() helper in "drm/display: scdc-helper: Add
  helper to set SCDC version information" (new patch 6)
- Added a fallback TMDS rate validation patch using the connector-level
  max_tmds_char_rate when the driver provides no .tmds_char_rate_valid()
  hook (new patch 9)
- Split scrambler_needed flag handling into its own hdmi-state-helper
  dedicate change (new patch 11)
- VC4:
  * Replaced vc4_hdmi_mode_needs_scrambling() with
    drm_hdmi_mode_needs_scrambling() (new patch 30)
  * Restored drm_dev_{enter,exit}() pairing around the converted
    scrambling paths
  * Removed now unused output_{bpc,color_format} fields from vc4_hdmi as
    part of the SCDC conversion
- KUnit:
  * Covered the caps-based connector init path: NULL caps, inferred
    max_tmds_char_rate per supported_hdmi_ver, and override validation
    (new patch 32)
  * Switched drm_hdmi_state_helper_test to the caps-based init helper
    and exposed it through
    drm_kunit_helper_connector_hdmi_init_with_caps_edid_funcs() (new
    patch 34)
  * Added max_tmds_char_rate fallback coverage in
    drm_hdmi_state_helper_test (new patch 35)
- Rebased onto latest drm-misc-next and dropped the already applied
  "drm/fb-helper: Remove unused local variable in hotplug_event()" patch
- Link to v7: https://patch.msgid.link/20260602-dw-hdmi-qp-scramb-v7-0-445eb54ee1ed@collabora.com

Changes in v7:
- Split the scrambler_needed flag computation from the SCDC scrambling
  helpers into a standalone hdmi_state_helper patch for clarity (new
  patch 6)
- Added vc4 HDMI conversion to common TMDS char rate constants and SCDC
  scrambling helpers as a proof of reuse (new patches 24-25)
- Added KUnit tests for connector scrambler_supported/callback
  consistency validation (new patch 26)
- Added 4K@60Hz 600MHz TMDS test EDID for high-rate scrambling coverage
  (new patch 27)
- Added KUnit tests for hdmi_state_helper scrambler_needed flag:
  low-rate, high-rate, and source-no-support cases (new patch 28)
- Fixed EDID conformity issues (edid-decode v1.33.0 failures) in the
  existing 1080p+4K YUV420 200MHz and 4K RGB/YUV 340MHz test EDIDs
  without changing the capabilities used by existing tests (new patches
  29-30)
- Rebased onto latest drm-misc-next
- Link to v6: https://patch.msgid.link/20260520-dw-hdmi-qp-scramb-v6-0-24b74603b782@collabora.com

Changes in v6:
- Collected R-b & A-b tags from Dmitry and Heiko
- Restructured the series from 10 into 22 patches, splitting the SCDC
  scrambling helpers, connector infrastructure, bridge operations,
  bridge_connector plumbing, dw-hdmi-qp implementation, and Rockchip
  platform changes into distinct commits
- Added drm_scdc_dbg() macro to simplify debug messages (new patch)
- Added drm_scdc_start/stop/sync_status() helpers for full scrambling
  lifecycle management (reworked from v5 patch 5)
- Added drm_atomic_helper_connector_hdmi_hotplug_ctx() to propagate
  modeset acquire context for SCDC sync on hotplug (new patch)
- Added connector scrambler callbacks and SCDC work/flag infrastructure
  as a separate patch (split from v5 patch 5)
- Added DRM_BRIDGE_OP_HDMI_SCRAMBLER bridge operation with
  hdmi_scrambler_enable/disable callbacks (new patch)
- Implemented bridge_connector scrambler interface wiring (new patch)
- Added .enable_hpd()/.disable_hpd() PHY ops for dw-hdmi-qp bridge and
  Rockchip platform drivers, replacing the obsolete .setup_hpd() op
- Added dw_hdmi_qp_hpd_notify() helper for targeted connector-only HPD
  notification (split from v5 patch 10)
- Dropped drm_fb_helper_hotplug_event() unused variable (new cleanup)
- Dropped unused drm_simple_kms_helper.h include (new cleanup)
- Masked RK3576 HPD IRQ in io_init() for consistency with RK3588
- Rebased onto latest drm-misc-next
- Link to v5: https://patch.msgid.link/20260426-dw-hdmi-qp-scramb-v5-0-d778e70c317b@collabora.com

Changes in v5:
- Added new patches: 1/10, 3/10, 6/10, 7/10, 8/10
- Removed redundant no-op error check in drm_bridge_helper_reset_crtc()
  (patch 1)
- Removed the EDEADLK retry loop from the bridge .detect_ctx() callback,
  as that's already handled in the drm_bridge_detect_ctx() helper or by
  the caller when ctx is provided (patch 2)
- Refactored drm_bridge_detect() to delegate to drm_bridge_detect_ctx()
  and added a WARN_ON for unexpected negative return values (patch 2)
- Split the bridge-connector .detect_ctx() switch into a preparatory
  patch to use cached connector status in .get_modes() (patch 3)
- Improved error handling in SCDC scrambling setup: roll back high TMDS
  clock ratio on scrambling failure, reset scramb_enabled flag on
  set_scramb failure, and add SCDC version read/write error checks
  (patch 5)
- Annotated scramb_enabled with READ_ONCE/WRITE_ONCE for cross-context
  access between modeset paths and the scrambling work item (patch 5)
- Renamed SCDC_MIN_SOURCE_VERSION to SCDC_MAX_SOURCE_VERSION (patch 5)
- Rate limited i2c error messages (patch 6)
- Added missing newlines in dev_err_probe() messages (patch 7)
- Replaced indirect device pointer accesses with local dev variable in
  bind() (patch 8)
- Split the HPD connector restriction (formerly patch 4/4): register HPD
  IRQ after connector setup first (patch 9), then restrict HPD event to
  the affected connector (patch 10); also collected R-b from Heiko
- Rebased onto latest drm-misc-next
- Link to v4: https://lore.kernel.org/r/20260303-dw-hdmi-qp-scramb-v4-0-317d3b8bd219@collabora.com

Changes in v4:
- Fixed conflicts while rebasing onto latest drm-misc-next
- Link to v3: https://lore.kernel.org/r/20260119-dw-hdmi-qp-scramb-v3-0-bd8611730fc1@collabora.com

Changes in v3:
- Used drm_bridge_helper_reset_crtc() helper to reset the display
  pipeline and got rid of some boilerplate code (Maxime)
- Rebased onto latest drm-misc-next
- Link to v2: https://lore.kernel.org/r/20260113-dw-hdmi-qp-scramb-v2-0-ae7b2c58d24d@collabora.com

Changes in v2:
- Collected Tested-by tags from Diederik and Maud
- Rebased onto latest drm-misc-next
- Ensured the recently introduced 'no-hpd' support for dealing with
  unconnected/repurposed/broken HPD pin is limited to HDMI 1.4 rates
- Link to v1: https://lore.kernel.org/r/20251203-dw-hdmi-qp-scramb-v1-0-836fe7401a69@collabora.com

---
Cristian Ciocaltea (39):
      video/hdmi: Introduce HDMI version enum
      drm/connector: Add caps-based HDMI connector init helper
      drm/display: bridge_connector: Pass HDMI capabilities through caps struct
      drm/connector: Add HDMI 2.0 scrambler infrastructure
      drm/display: scdc-helper: Add macro for connector-prefixed debug messages
      drm/display: scdc-helper: Add helper to set SCDC version information
      drm/display: hdmi: Add HDMI 2.0 scrambling management helpers
      drm/display: hdmi: Advertise SCDC source version when scrambling
      drm/display: hdmi-state-helper: Add fallback TMDS rate validation
      drm/display: hdmi-state-helper: Sync SCDC state on hotplug
      drm/display: hdmi-state-helper: Set HDMI scrambling requirement
      drm/bridge: Remove redundant error check in drm_bridge_helper_reset_crtc()
      drm/bridge: Add bridge ops for source-side HDMI 2.0 scrambling
      drm/display: bridge_connector: Use cached connector status in .get_modes()
      drm/display: bridge_connector: Switch to .detect_ctx() connector helper
      drm/display: bridge_connector: Wire up HDMI 2.0 scrambler callbacks
      drm/bridge: dw-hdmi-qp: Rate limit i2c read error messages
      drm/bridge: dw-hdmi-qp: Provide .{enable|disable}_hpd() PHY ops
      drm/bridge: dw-hdmi-qp: Add HDMI 2.0 SCDC scrambling support
      drm/bridge: dw-hdmi-qp: Provide dw_hdmi_qp_hpd_notify() helper
      drm/rockchip: dw_hdmi_qp: Add missing newlines in dev_err_probe() messages
      drm/rockchip: dw_hdmi_qp: Use local dev variable consistently in bind()
      drm/rockchip: dw_hdmi_qp: Drop unnecessary #include
      drm/rockchip: dw_hdmi_qp: Defer HPD IRQ enable until after connector setup
      drm/rockchip: dw_hdmi_qp: Mask RK3576 HPD IRQ in io_init
      drm/rockchip: dw_hdmi_qp: Implement .{enable|disable}_hpd() PHY ops
      drm/rockchip: dw_hdmi_qp: Use dw_hdmi_qp_hpd_notify() for HPD reports
      drm/bridge: dw-hdmi-qp: Drop unused .setup_hpd() phy op
      drm/vc4: hdmi: Use common TMDS char rate constants
      drm/vc4: hdmi: Switch to drm_hdmi_mode_needs_scrambling()
      drm/vc4: hdmi: Convert to common SCDC scrambling infrastructure
      drm/tests: connector: Add HDMI caps-based init coverage
      drm/tests: connector: Add HDMI source-side scrambler coverage
      drm/tests: hdmi_state_helper: Use drmm_connector_hdmi_init_with_caps()
      drm/tests: hdmi_state_helper: Add max_tmds_char_rate fallback tests
      drm/tests: edid: Add 4K@60Hz EDID with 600MHz TMDS
      drm/tests: hdmi_state_helper: Cover source-side scrambling decision
      drm/tests: edid: Fix conformity for 1080p+4K YUV420 200MHz EDID
      drm/tests: edid: Fix conformity for 4K RGB/YUV 340MHz EDID

 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c       | 129 ++++++--
 drivers/gpu/drm/display/drm_bridge_connector.c     | 146 +++++----
 drivers/gpu/drm/display/drm_hdmi_helper.c          | 267 +++++++++++++++++
 drivers/gpu/drm/display/drm_hdmi_state_helper.c    |  32 +-
 drivers/gpu/drm/display/drm_scdc_helper.c          |  70 ++++-
 drivers/gpu/drm/drm_bridge_helper.c                |   2 -
 drivers/gpu/drm/drm_connector.c                    | 222 ++++++++++----
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c     | 130 ++++----
 drivers/gpu/drm/tests/drm_connector_test.c         | 330 +++++++++++++++++++++
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 315 +++++++++++++++++++-
 drivers/gpu/drm/tests/drm_kunit_edid.c             | 251 +++++++++++++---
 drivers/gpu/drm/tests/drm_kunit_edid.h             |   1 +
 drivers/gpu/drm/vc4/vc4_hdmi.c                     | 301 ++++---------------
 drivers/gpu/drm/vc4/vc4_hdmi.h                     |  21 --
 include/drm/bridge/dw_hdmi_qp.h                    |   4 +-
 include/drm/display/drm_hdmi_helper.h              |  15 +
 include/drm/display/drm_hdmi_state_helper.h        |   6 +-
 include/drm/display/drm_scdc_helper.h              |   2 +
 include/drm/drm_bridge.h                           |  41 +++
 include/drm/drm_connector.h                        | 132 +++++++++
 include/linux/hdmi.h                               |  12 +
 21 files changed, 1869 insertions(+), 560 deletions(-)
---
base-commit: 44d19b8a7548aa25cbc6ebd5f27e958f7142c36b
change-id: 20251203-dw-hdmi-qp-scramb-cdbd8b57ccf9

