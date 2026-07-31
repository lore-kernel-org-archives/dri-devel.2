Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004F5C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:19:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F63A10F2F6;
	Fri, 31 Jul 2026 16:19:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="nggLj6ZI";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 520B110F2ED
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 16:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785514754;
 bh=YP4DJUjjlP6vH6MQv/0+Wyz1BKTSqGIu5iP/nylzH1Q=;
 h=From:Subject:Date:To:Cc:From;
 b=nggLj6ZIML5Vts4/BwbfZXb6cRfHdIfMqAo1NtLHpBbh22WntUXGzyXoG1KU/IqFc
 c3Ywa5Rn3vLjEfDqXp84ye0ylgi6yUwoxNZm6tVD7WQTanC2YH4juyVYjCPp80gOV3
 /SIxqueLpdYNaTy8NLn25SQnPAS7otO6xKBl3vmBd/hBiu5FIKBecIDrdnY7xzhvrs
 M8I8DIXYclbpswt3V/HLBFr9kpWgpqqvi7fW2xWN55yjno56UBgHD0Oj9Cn4IwecjX
 hixpY5iw1zEoX2Ofx9LPkxdzyzCFcq2yHklyZWatgh4tp/o6LiGAf4/TVPTWZORlTu
 LGLXm68H9ZnqQ==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A6A3217E0582;
 Fri, 31 Jul 2026 18:19:14 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v10 00/69] Add HDMI 2.0 support to DW HDMI QP TX
Date: Fri, 31 Jul 2026 19:19:07 +0300
Message-Id: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33Q20oDMRAG4FcpuTaSmZy98j3EixxmbaDt1l1Zl
 bLvblqQLTh4OQP5Mv9/ETNNjWbxtLuIiZY2t/HUB1APO1H26fRGstW+EKjQAiot66fc12OT72c
 5lykdsyw115CtL2WIor87TzS0rxv68trnfZs/xun79scC1+1/2gJSyaDdQN4oSC4+l/FwSHmc0
 mMZj+IqLvirOAXAKtiVRD5jsaGiqZyi75XIKborPZwD8FoNBTjFbIrmE5muaPBV55ArApvIbop
 Bxym2K9X7QF6VrmVOcZtiUXGK6wqa7E2/NvuAnOI3xSnkFN8VYyxla4iA2HbDpnheCbdEMURVl
 coucUq8U5BtN15vGTIgJcRU/rS7rusPMUvw7+cCAAA=
X-Change-ID: 20251203-dw-hdmi-qp-scramb-cdbd8b57ccf9
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>, 
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>, 
 Phong LE <ple@baylibre.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Sashiko <sashiko-bot@kernel.org>, 
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
management for high TMDS clock ratio and scrambling.  Since SCDC state
is lost on sink disconnects, the bridge driver needs to trigger a CRTC
reset during connector detection.

To support this at the DRM infrastructure level, the series first
introduces the HDMI version enum, then prepares for changing the
signature of drmm_connector_hdmi_init(), i.e. dropping the vendor,
product, supported_formats and max_bpc arguments, which are being moved
into struct drm_connector_hdmi_funcs, by temporarily renaming the helper
to drmm_connector_hdmi_ini2().  This lets the new signature be
introduced under the original name while callers are converted
incrementally.  Note the transitional name matches the original's length
so continuation-line arguments stay aligned to the opening parenthesis,
keeping the diff to the identifier itself and avoiding re-alignment
churn.

Appending more HDMI-specific arguments to the init function would not
scale well, hence the hdmi_funcs struct is extended with new fields:
supported_hdmi_ver, supported_tmds_char_rate.  These are used to
infer and/or limit the maximum TMDS character rate permitted for the
connector.

Patches 6-11 build the connector and bridge scrambling infrastructure on
top: the connector scrambler callbacks/flags, the scdc-helper
additions (connector-prefixed debug macro and SCDC version helper), and
the HDMI scrambling management helpers including SCDC source-version
advertisement.

Patches 12-23 wires this up through the hdmi-state-helper and bridge
connector layers: source TMDS rate validation, hotplug SCDC state sync
and the scrambling requirement, new source-side scrambling bridge ops,
the switch to a cached-status, atomic-aware .detect_ctx() connector
helper, and finally hooking up the HDMI 2.0 scrambler callbacks.

The SCDC scrambling feature itself is implemented in the DW HDMI QP
bridge driver, alongside i2c error-message rate limiting,
.enable_hpd()/.disable_hpd() PHY ops and a dw_hdmi_qp_hpd_notify()
helper (patches 24-28).

Patches 29-38 cover the Rockchip platform driver and HPD handling: bug
fixes, minor cleanups, avoiding spurious HDP IRQ wakeups, masking the
RK3576 HPD IRQ in io_init, implementing the .{enable|disable}_hpd() PHY
ops, switching HPD reports to dw_hdmi_qp_hpd_notify() to restrict events
to the affected connector, dropping the now-unused .setup_hpd() PHY op.

Patches 39-46 convert VC4 HDMI to the common infrastructure as a proof
of reuse: adopting the shared TMDS char rate constants, switching to
drm_hdmi_mode_needs_scrambling() and force_ctx(), proper -EDEADLK
handling, and replacing the driver-local scrambling implementation with
the common SCDC scrambling helpers.

Patches 47-55 advertise supported version for all HDMI
connectors/bridges, except the MediaTek HDMI driver (for now), as it
requires non-trivial changes: there's a core library shared between two
drivers, one being HDMI 2.0 compliant.

Patches 56-65 add KUnit tests: HDMI caps-based init coverage and
source-side scrambler validation for the connector, conversion of
hdmi_state_helper to the new drmm_connector_hdmi_init() with
max_tmds_char_rate validation, a new 4K@60Hz 600MHz TMDS EDID,
source-side scrambling decision coverage, and conformity fixes for the
existing 1080p+4K YUV420 200MHz and 4K RGB/YUV 340MHz test EDID blobs.

Eventually patches 66-69 remove the now unused
drmm_connector_hdmi_ini2() helper and drop redundant hdmi fields from
connector structs: vendor, product, supported_formats and max_bpc.

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
Changes in v10:
- Collected T-b from Diederik on relevant patches
- Collected R-b from Dmitry on patch renaming drmm_connector_hdmi_init()
- Added new patches to address Sashiko findings:
  * drm/connector: hdmi: Handle reset() state allocation failure
  * drm/bridge: Fix unlocked list_del in drm_bridge_add()
  * drm/bridge: Fix unlocked list access in drm_bridge_attach()
  * drm/rockchip: dw_hdmi_qp: Cancel pending HPD work on suspend
  * drm/probe-helper: Introduce .force_ctx() connector callback
  * drm/display: bridge_connector: Switch to .force_ctx() connector
    helper
  * drm/vc4: hdmi: Switch to .force_ctx() connector helper
  * drm/display: hdmi-state-helper: Drop
    drm_atomic_helper_connector_hdmi_force()
- Updated "drm/connector: Add drmm_connector_hdmi_init() with new
  signature" to check if the reset callback failed to allocate memory
- Updated "drm/display: hdmi-state-helper: Pass acquire ctx to hotplug
  helpers" to introduce drm_atomic_helper_connector_hdmi_force_ctx()
  implementation and drop the conflicting local ctx from
  drm_atomic_helper_connector_hdmi_force()
- Updated "drm/display: hdmi: Add HDMI 2.0 scrambling management
  helpers" to bail early in the work handler on
  drm_connector_is_unregistered()
- Updated "drm/bridge: dw-hdmi-qp: Provide dw_hdmi_qp_hpd_notify()
  helper" to use READ_ONCE/WRITE_ONCE on hdmi->curr_conn
- Reworked "drm/rockchip: dw_hdmi_qp: Fix NULL deref in PM ops on
  incomplete bind" into "drm/rockchip: dw_hdmi_qp: Fix invalid drvdata
  access in PM ops"
- Fixed "drm/rockchip: rk3066_hdmi: Advertise HDMI 1.4 capabilities" to
  set the expected HDMI_VERSION_1_4 instead of HDMI_VERSION_1_3
- Fixed all KUnit tests that created a dangling pointer by storing the
  address of a stack-allocated drm_connector_hdmi_funcs structure into a
  persistent device-managed object
- Fixed flawed logic in "drm/tests: connector: Add HDMI
  max_tmds_char_rate init coverage" causing a couple of rate limit
  rejection tests to pass for the wrong reason
- Rebased series onto latest drm-misc-next
- Link to v9: https://patch.msgid.link/20260723-dw-hdmi-qp-scramb-v9-0-4fb12ea22ac9@collabora.com

Changes in v9:
- Collected A-b, R-b, T-b tags from Dmitry, Maxime, Maud
- Dropped misleading "HDMI_VERSION_UNKNOWN means legacy/default
  behaviour" from drm_connector_hdmi_caps.supported_hdmi_ver
  documentation
- Warned in drm_bridge_add() if an HDMI bridge leaves supported_hdmi_ver
  unset
- Added max_tmds_char_rate to drm_bridge struct and wire it through
  drm_bridge_connector_init() along with supported_hdmi_ver
- Got rid of connector's scrambler_supported flag and, instead, relied
  on checking the presence of scrambler callbacks via a new
  drm_connector_hdmi_scrambler_supported() helper (Dmitry)
- Dropped HDMI connector scdc_cb callback and introduced
  scdc_work_initialized flag to perform lazy initialization and guard
  the teardown paths against touching an uninitialized work item
- Unconditionally checked connector->hdmi.max_tmds_char_rate in
  "drm/display: hdmi-state-helper: Add fallback TMDS rate validation"
  and performed s/fallback/source/ in commit subject & description
  (Maxime)
- Added a TODO comment for checking
  drm_display_info.hdmi.scdc.scrambling.low_rates in "drm/display:
  hdmi-state-helper: Set HDMI scrambling requirement" patch (Maxime)
- Moved the prototype changes from "drm/display: hdmi-state-helper: Sync
  SCDC state on hotplug" into a dedicated "drm/display:
  hdmi-state-helper: Pass acquire ctx to hotplug helpers" patch; also
  switched ctx and status args ordering, for consistency with
  detect_ctx() signature (Maxime)
- Ensured HDMI connector's SCDC delayed work is explicitly canceled
  during connector cleanup (Sashiko)
- Fixed a potential NULL pointer dereference in
  drm_connector_hdmi_enable_scrambling() and
  drm_connector_hdmi_sync_scdc() helpers caused by forcing an EDID
  advertising SCDC on a connector that physically lacks an I2C DDC bus
  (Sashiko)
- dw-hdmi-qp
  * Fixed a potential NULL pointer dereference in
    dw_hdmi_qp_hpd_notify() helper by using a local variable to cache
    the connector pointer (Sashiko)
  * Ensured hdmi->phy.ops->disable() is not skipped in
    dw_hdmi_qp_bridge_atomic_disable() by accessing the connector via
    drm_atomic_get_old_connector_for_encoder() instead of
    hdmi->curr_conn (Sashiko)
  * Mitigated a potential use-after-free reported by Sashiko caused when
    HPD interrupt fires after the DRM device is torn down; reworked
    "Defer HPD IRQ enable until after connector setup" into:
    * Factor out HPD interrupt mask/unmask helpers
    * Control the HPD IRQ line via the bridge HPD ops
  * Added new patch addressing another Sashiko finding: drm/rockchip:
    dw_hdmi_qp: Avoid spurious HPD IRQ thread wakeups
  * Added new patch: drm/bridge: dw-hdmi-qp: Remove unused workqueue
    include and define
  * Dropped .hdmi_tmds_char_rate_valid() usage from the
    bridge/synopsys/dw-hdmi-qp.c scrambling support patch, while
    advertising HDMI 1.4 capability for no-hpd configurations
- VC4
  * Passed ctx instead of NULL when calling
    drm_atomic_helper_connector_hdmi_hotplug() from
    vc4_hdmi_handle_hotplug() in the helper preparatory patch
  * Aligned with the expected detect_ctx() semantics in a dedicated
    "drm/vc4: hdmi: Propagate -EDEADLK to the top level" rather than
    bundled in the conversion patch
  * Optimized diff around drm_dev_enter() in the conversion patch
    (Maxime)
  * Simplified vc4_hdmi_connector_clock_valid() logic by deferring max
    clock validation to HDMI helpers (new patch)
- Migrated to a funcs-based HDMI connector init API - new patches:
  * drm/display: hdmi: Rename drmm_connector_hdmi_init() to *_ini2()
  * drm/display: bridge_connector: Convert to drmm_connector_hdmi_init()
  * drm/vc4: hdmi: Convert to drmm_connector_hdmi_init()
  * drm/vc4: hdmi: Convert to common HDMI 2.0 scrambling infrastructure
  * drm/sun4i: hdmi: Convert to drmm_connector_hdmi_init()
  * drm/tests: connector: Convert to drmm_connector_hdmi_init()
  * drm/tests: hdmi_state_helper: Convert to drmm_connector_hdmi_init()
  * drm/bridge: adv7511: Advertise HDMI 1.2 capabilities
  * drm/bridge: inno-hdmi: Advertise HDMI 1.2 capabilities
  * drm/bridge: ite-it6263: Drop redundant .mode_valid hook
  * drm/bridge: ite-it6263: Advertise HDMI 1.3 capabilities
  * drm/bridge: ite-it66121: Advertise HDMI 1.2 capabilities
  * drm/bridge: lontium-lt9611: Advertise HDMI 1.4 capabilities
  * drm/rockchip: rk3066_hdmi: Advertise HDMI 1.4 capabilities
  * drm/sun4i: hdmi: Convert to drmm_connector_hdmi_init()
  * drm/connector: Remove drmm_connector_hdmi_ini2()
  * drm/connector: Drop redundant hdmi vendor/product fields
  * drm/connector: Drop redundant hdmi supported_formats field
  * drm/connector: Drop redundant max_bpc field
- KUnit
  * Adapted hdmi_state_helper scrambler tests and reworked a couple of
    max_tmds_char_rate tests according to the latest DRM core changes
  * Fixed a regression in the HDMI caps-based init coverage
  * Fix a couple of bisectability issues, also implied partial commit
    reorder
  * Set supported HDMI version for the test bridges (new patch)
- Rebased series onto latest drm-misc-next and removed "drm/rockchip:
  dw_hdmi_qp: Drop unnecessary #include" patch, since a similar change
  as been already applied
- Link to v8: https://patch.msgid.link/20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com

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
Cristian Ciocaltea (69):
      video/hdmi: Introduce HDMI version enum
      drm/connector: hdmi: Handle reset() state allocation failure
      drm/display: hdmi: Rename drmm_connector_hdmi_init() to *_ini2()
      drm/connector: Add drmm_connector_hdmi_init() with new signature
      drm/display: bridge_connector: Convert to drmm_connector_hdmi_init()
      drm/probe-helper: Introduce .force_ctx() connector callback
      drm/connector: Add HDMI 2.0 scrambler infrastructure
      drm/display: scdc-helper: Add macro for connector-prefixed debug messages
      drm/display: scdc-helper: Add helper to set SCDC version information
      drm/display: hdmi: Add HDMI 2.0 scrambling management helpers
      drm/display: hdmi: Advertise SCDC source version when scrambling
      drm/bridge: Fix unlocked list_del in drm_bridge_add()
      drm/bridge: Fix unlocked list access in drm_bridge_attach()
      drm/bridge: Remove redundant error check in drm_bridge_helper_reset_crtc()
      drm/bridge: Add bridge ops for source-side HDMI 2.0 scrambling
      drm/display: bridge_connector: Use cached connector status in .get_modes()
      drm/display: bridge_connector: Switch to .detect_ctx() connector helper
      drm/display: bridge_connector: Switch to .force_ctx() connector helper
      drm/display: bridge_connector: Wire up HDMI 2.0 scrambler callbacks
      drm/display: hdmi-state-helper: Add source TMDS rate validation
      drm/display: hdmi-state-helper: Pass acquire ctx to hotplug helpers
      drm/display: hdmi-state-helper: Sync SCDC state on hotplug
      drm/display: hdmi-state-helper: Set HDMI scrambling requirement
      drm/bridge: dw-hdmi-qp: Rate limit i2c read error messages
      drm/bridge: dw-hdmi-qp: Provide .{enable,disable}_hpd() PHY ops
      drm/bridge: dw-hdmi-qp: Remove unused workqueue include and define
      drm/bridge: dw-hdmi-qp: Add HDMI 2.0 scrambling support
      drm/bridge: dw-hdmi-qp: Provide dw_hdmi_qp_hpd_notify() helper
      drm/rockchip: dw_hdmi_qp: Fix invalid drvdata access in PM ops
      drm/rockchip: dw_hdmi_qp: Cancel pending HPD work on suspend
      drm/rockchip: dw_hdmi_qp: Add missing newlines in dev_err_probe() messages
      drm/rockchip: dw_hdmi_qp: Use local dev variable consistently in bind()
      drm/rockchip: dw_hdmi_qp: Avoid spurious HPD IRQ thread wakeups
      drm/rockchip: dw_hdmi_qp: Mask RK3576 HPD IRQ in io_init
      drm/rockchip: dw_hdmi_qp: Implement .{enable,disable}_hpd() PHY ops
      drm/rockchip: dw_hdmi_qp: Factor out HPD interrupt (un)mask helpers
      drm/rockchip: dw_hdmi_qp: Control the HPD IRQ line via the bridge HPD ops
      drm/rockchip: dw_hdmi_qp: Use dw_hdmi_qp_hpd_notify() for HPD reports
      drm/bridge: dw-hdmi-qp: Drop unused .setup_hpd() phy op
      drm/vc4: hdmi: Use common TMDS char rate constants
      drm/vc4: hdmi: Switch to drm_hdmi_mode_needs_scrambling()
      drm/vc4: hdmi: Switch to .force_ctx() connector helper
      drm/vc4: hdmi: Propagate -EDEADLK to the top level
      drm/vc4: hdmi: Convert to drmm_connector_hdmi_init()
      drm/vc4: hdmi: Convert to common HDMI 2.0 scrambling infrastructure
      drm/vc4: hdmi: Defer pixel clock validation to HDMI helpers
      drm/display: hdmi-state-helper: Drop drm_atomic_helper_connector_hdmi_force()
      drm/bridge: adv7511: Advertise HDMI 1.2 capabilities
      drm/bridge: inno-hdmi: Advertise HDMI 1.2 capabilities
      drm/bridge: ite-it6263: Drop redundant .mode_valid hook
      drm/bridge: ite-it6263: Advertise HDMI 1.3 capabilities
      drm/bridge: ite-it66121: Advertise HDMI 1.2 capabilities
      drm/bridge: lontium-lt9611: Advertise HDMI 1.4 capabilities
      drm/rockchip: rk3066_hdmi: Advertise HDMI 1.4 capabilities
      drm/sun4i: hdmi: Convert to drmm_connector_hdmi_init()
      drm/tests: edid: Add 4K@60Hz EDID with 600MHz TMDS
      drm/tests: edid: Fix conformity for 1080p+4K YUV420 200MHz EDID
      drm/tests: edid: Fix conformity for 4K RGB/YUV 340MHz EDID
      drm/tests: bridge: Set supported HDMI version
      drm/tests: connector: Convert to drmm_connector_hdmi_init()
      drm/tests: connector: Add HDMI max_tmds_char_rate init coverage
      drm/tests: connector: Add HDMI source-side scrambler coverage
      drm/tests: hdmi_state_helper: Convert to drmm_connector_hdmi_init()
      drm/tests: hdmi_state_helper: Add connector-provided max_tmds_char_rate coverage
      drm/tests: hdmi_state_helper: Cover source-side scrambling decision
      drm/connector: Remove drmm_connector_hdmi_ini2()
      drm/connector: Drop redundant hdmi vendor/product fields
      drm/connector: Drop redundant hdmi supported_formats field
      drm/connector: Drop redundant max_bpc field

 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |  22 +-
 drivers/gpu/drm/bridge/inno-hdmi.c                 |   1 +
 drivers/gpu/drm/bridge/ite-it6263.c                |  33 +-
 drivers/gpu/drm/bridge/ite-it66121.c               |  13 +-
 drivers/gpu/drm/bridge/lontium-lt9611.c            |  16 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c       | 125 ++++-
 drivers/gpu/drm/display/drm_bridge_connector.c     | 183 ++++---
 drivers/gpu/drm/display/drm_hdmi_helper.c          | 303 +++++++++++
 drivers/gpu/drm/display/drm_hdmi_state_helper.c    |  78 ++-
 drivers/gpu/drm/display/drm_scdc_helper.c          |  70 ++-
 drivers/gpu/drm/drm_bridge.c                       |  19 +-
 drivers/gpu/drm/drm_bridge_helper.c                |   2 -
 drivers/gpu/drm/drm_connector.c                    |  92 +++-
 drivers/gpu/drm/drm_probe_helper.c                 |  14 +-
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c     | 189 ++++---
 drivers/gpu/drm/rockchip/rk3066_hdmi.c             |   2 +
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |  14 +-
 drivers/gpu/drm/tests/drm_bridge_test.c            |   2 +
 drivers/gpu/drm/tests/drm_connector_test.c         | 522 ++++++++++++------
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 599 +++++++++++++++------
 drivers/gpu/drm/tests/drm_kunit_edid.c             | 251 +++++++--
 drivers/gpu/drm/tests/drm_kunit_edid.h             |   1 +
 drivers/gpu/drm/vc4/vc4_hdmi.c                     | 357 +++---------
 drivers/gpu/drm/vc4/vc4_hdmi.h                     |  30 +-
 include/drm/bridge/dw_hdmi_qp.h                    |   4 +-
 include/drm/display/drm_hdmi_helper.h              |  15 +
 include/drm/display/drm_hdmi_state_helper.h        |   9 +-
 include/drm/display/drm_scdc_helper.h              |   2 +
 include/drm/drm_bridge.h                           |  49 ++
 include/drm/drm_connector.h                        | 167 +++++-
 include/drm/drm_modeset_helper_vtables.h           |  28 +
 include/linux/hdmi.h                               |  12 +
 32 files changed, 2208 insertions(+), 1016 deletions(-)
---
base-commit: bc47d5937f21c5fc94504f03e18f1adb56d97634
change-id: 20251203-dw-hdmi-qp-scramb-cdbd8b57ccf9

