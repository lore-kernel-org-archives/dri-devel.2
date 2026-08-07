Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4852EC5AC80
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 20:07:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8645E10E35E;
	Fri,  7 Aug 2026 20:07:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="hdRMQcG1";
	dkim-atps=neutral
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com
 [157.90.84.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4989A10E24A;
 Fri,  7 Aug 2026 20:07:22 +0000 (UTC)
Received: from wsembach-tuxedo.buero.augsburg.tuxedo.de
 (host-212-18-30-247.customer.m-online.net [212.18.30.247])
 (Authenticated sender: wse@tuxedocomputers.com)
 by mail.tuxedocomputers.com (Postfix) with ESMTPA id 4C42E2FC004D;
 Fri,  7 Aug 2026 22:07:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
 s=default; t=1786133241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zcqw3phGqPumtEwKCvYGijd5ryFAPbT280s+LSCI/8c=;
 b=hdRMQcG1JSMcvMN0AD/lPeaLbjwOhOgCDiK2X/lxC3xbHrFsdeYv6PAAKbdGqHC1ouRHxe
 FsMDzl+9KPWqQTCRBBWySFrEQV40/cnWvD/6mGTMwvn/AVUH3PcFnD+P1yzxWO6k8vQt9A
 e2o+JRmZ+G/MRQsEtXGKe+MnGHn30Mk=
Authentication-Results: mail.tuxedocomputers.com;
 auth=pass smtp.auth=wse@tuxedocomputers.com
 smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch, Suraj Kandpal <suraj.kandpal@intel.com>,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: wse@tuxedocomputers.com, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/1] drm/i915/display: Add quirk to force backlight type on
 some TUXEDO devices
Date: Fri,  7 Aug 2026 22:04:30 +0200
Message-ID: <20260807200709.464343-2-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807200709.464343-1-wse@tuxedocomputers.com>
References: <20260807200709.464343-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
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

The display backlight on TUXEDO DX1708 and InsanityBook 15 v1 have a broken
VBT in the AUO 12701 and AUO 12701 panels, but not others. They are
advertising INTEL_BACKLIGHT_DISPLAY_DDI, but are actually failing to use
the Intel interface. Adding a fallback to the VESA interface gives
these devices a working backlight for both the broken and non broken
panel VBTs.

Forcing the fallback can already be achieved via a module parameter,
but this patch adds a quirk to apply this by default on the mentioned
devices.

This patch does not actually test for the exact panels as the ID that is
used in the intel_dpcd_quirks list is sadly zeroed on the devices, but
afaik all these devices use try_intel_interface first anyway so all the
quirk does is to add the fallback to try_vesa_interface, so the behaviour
on the devices not needing the quirk and fallback should functionally stay
the same.

Fixes: f30fddb44023 ("Revert "drm/i915/backlight: Remove try_vesa_interface"")
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/15679
Cc: stable@vger.kernel.org
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 .../drm/i915/display/intel_dp_aux_backlight.c | 22 ++++++++++++++++-
 drivers/gpu/drm/i915/display/intel_quirks.c   | 24 +++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_quirks.h   |  1 +
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
index 266e042e00237..d84def79c4bfb 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
@@ -41,6 +41,7 @@
 #include "intel_display_types.h"
 #include "intel_dp.h"
 #include "intel_dp_aux_backlight.h"
+#include "intel_quirks.h"
 
 /*
  * DP AUX registers for Intel's proprietary HDR backlight interface. We define
@@ -687,11 +688,30 @@ int intel_dp_aux_init_backlight_funcs(struct intel_connector *connector)
 	struct drm_device *dev = connector->base.dev;
 	struct intel_panel *panel = &connector->panel;
 	bool try_intel_interface = false, try_vesa_interface = false;
+	int enable_dpcd_backlight;
+
+	/*
+	 * Some devices have a broken VBT in some Panels, but not others,
+	 * advertising INTEL_BACKLIGHT_DISPLAY_DDI, but actually failing to use
+	 * the Intel interface. Adding a fallback to the Vesa interface gives
+	 * these devices a working backlight for both the broken and non broken
+	 * panel VBTs.
+	 *
+	 * This fallback can not be made the general default as this has broken
+	 * other devices in the past whose VBT correctly reports
+	 * INTEL_BACKLIGHT_DISPLAY_DDI and whose PWM path is the actual
+	 * backlight control, but whose DPCD optimistically advertises
+	 * DP_EDP_BACKLIGHT_AUX_ENABLE_CAP / _BRIGHTNESS_AUX_SET_CAP.
+	 */
+	enable_dpcd_backlight = display->params.enable_dpcd_backlight;
+	if (enable_dpcd_backlight == INTEL_DP_AUX_BACKLIGHT_AUTO &&
+	    intel_has_dpcd_quirk(intel_dp, QUIRK_ENABLE_DPCD_BACKLIGHT))
+		enable_dpcd_backlight = INTEL_DP_AUX_BACKLIGHT_ON;
 
 	/* Check the VBT and user's module parameters to figure out which
 	 * interfaces to probe
 	 */
-	switch (display->params.enable_dpcd_backlight) {
+	switch (enable_dpcd_backlight) {
 	case INTEL_DP_AUX_BACKLIGHT_OFF:
 		return -ENODEV;
 	case INTEL_DP_AUX_BACKLIGHT_AUTO:
diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
index 33245f44c0d50..89d82364ae45d 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.c
+++ b/drivers/gpu/drm/i915/display/intel_quirks.c
@@ -100,6 +100,14 @@ static void quirk_disable_psr2(struct intel_display *display)
 	drm_info(display->drm, "PSR2 support not currently available for this setup, applying disable PSR2 quirk\n");
 }
 
+static void quirk_enable_dpcd_backlight(struct intel_dp *intel_dp)
+{
+	struct intel_display *display = to_intel_display(intel_dp);
+
+	intel_set_dpcd_quirk(intel_dp, QUIRK_ENABLE_DPCD_BACKLIGHT);
+	drm_info(display->drm, "Applying Enable DPCD Backlight quirk\n");
+}
+
 struct intel_quirk {
 	int device;
 	int subsystem_vendor;
@@ -286,6 +294,22 @@ static const struct intel_dpcd_quirk intel_dpcd_quirks[] = {
 		.sink_oui = SINK_OUI(0x00, 0x22, 0xb9),
 		.hook = quirk_disable_edp_panel_replay,
 	},
+	/* TUXEDO InsanityBook 15 v1 */
+	{
+		.device = 0x591b,
+		.subsystem_vendor = 0x1558,
+		.subsystem_device = 0x9501,
+		.sink_oui = SINK_OUI(0x38, 0xec, 0x11),
+		.hook = quirk_enable_dpcd_backlight,
+	},
+	/* TUXEDO DX1708 */
+	{
+		.device = 0x3e9b,
+		.subsystem_vendor = 0x1558,
+		.subsystem_device = 0x8500,
+		.sink_oui = SINK_OUI(0x38, 0xec, 0x11),
+		.hook = quirk_enable_dpcd_backlight,
+	},
 };
 
 void intel_init_quirks(struct intel_display *display)
diff --git a/drivers/gpu/drm/i915/display/intel_quirks.h b/drivers/gpu/drm/i915/display/intel_quirks.h
index 970a4fe52fafc..4996419ae76bd 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.h
+++ b/drivers/gpu/drm/i915/display/intel_quirks.h
@@ -23,6 +23,7 @@ enum intel_quirk_id {
 	QUIRK_EDP_LIMIT_RATE_HBR2,
 	QUIRK_DISABLE_EDP_PANEL_REPLAY,
 	QUIRK_DISABLE_PSR2,
+	QUIRK_ENABLE_DPCD_BACKLIGHT,
 };
 
 void intel_init_quirks(struct intel_display *display);
-- 
2.43.0

