Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84B3CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 13:08:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AC7F10E315;
	Fri,  9 Oct 2026 13:08:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HlVhjvr5";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CD5C10E315;
 Fri,  9 Oct 2026 13:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791551311; x=1823087311;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2mJpPAkzCLohtylKsLwks/9dys7yNF3jZSXER5gGgdk=;
 b=HlVhjvr5xg9oNXBajO9M3FVf9DGFnCWkEkr0YLaV9YPXmr0TEJ4VVx3M
 3MS9BBeIQUSMd8nx+P1cN1j6jps6UyhvXnN5q10k65o73TqbYqPoRct3x
 IuzkPhk5M6TSluJ9aTbskG/OENe15pgu7T+dQ5I42NxCfed5a2ELBDjCf
 aCDlqpz3XedYyh+8A2E5n6rAmrYgNELb1hkpMju2U94CrdVJd22KqwZJw
 XEanPLtqhwepM8a5Vl5HYgAjJDdOM00EiffoS5ax46CEcESi7X6f2PlFn
 Y9v/GH2pctl405GZ/tWkc6btASHU+Q8xk6Eih+G4t2mUAwEZqBkUDMJfo A==;
X-CSE-ConnectionGUID: 2JpQTJHNRZO4eFrBpYc6hg==
X-CSE-MsgGUID: iCvx1TDiTfyRlfrnkBODaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="364711"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="364711"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 06:08:30 -0700
X-CSE-ConnectionGUID: b3SxmXMOTD2lWQ+HPyCOiw==
X-CSE-MsgGUID: knlS1P8bS6iE1GLVJ1plKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="754577"
Received: from xiaolu.sh.intel.com ([10.239.146.103])
 by orviesa010.jf.intel.com with ESMTP; 09 Oct 2026 06:08:27 -0700
From: Xiao Lu <xiaolu.xie@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, ville.syrjala@linux.intel.com,
 imre.deak@intel.com, jani.nikula@linux.intel.com, lyude@redhat.com,
 Xiao Lu <xiaolu.xie@intel.com>
Subject: [PATCH] drm/i915/dp: limit UHBR link rates to the cable's capability
Date: Fri,  9 Oct 2026 21:06:11 +0800
Message-ID: <20261009130611.3268451-1-xiaolu.xie@intel.com>
X-Mailer: git-send-email 2.43.0
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

DisplayPort 2.1 defines the CABLE_ATTRIBUTES_UPDATED_BY_DPRX register
(DPCD 0x2217), in which a UHBRx-capable DPRX reports the UHBR link rates
the attached cable can carry. The DPRX determines this via the CONFIG2
voltage handshake (for a DP receptacle) or by parsing the cable eMarker
(for a USB-C receptacle), and updates the register before asserting HPD.

Add the register definitions and a helper,
drm_dp_128b132b_cable_uhbr_rates(), that reads the register and returns
the set of UHBR rates (DP_UHBR10, DP_UHBR13_5, DP_UHBR20) the cable
permits, and intersect the sink's 128b/132b rates with it. This avoids
attempting link training at a UHBR rate the cable cannot carry and then
falling back, e.g. a UHBR20-capable sink connected through a cable that
only supports UHBR10/UHBR13.5.

A register value of 0 ("not UHBR-capable or capability unknown", or a
sink that does not implement the register) yields all UHBR rates, so no
restriction is imposed and the normal rate fallback applies.

See DP Standard v2.1b, Table 2-260 (DPCD 0x2217).

Signed-off-by: Xiao Lu <xiaolu.xie@intel.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 49 +++++++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp.c |  7 ++++
 include/drm/display/drm_dp.h            | 12 ++++++
 include/drm/display/drm_dp_helper.h     |  1 +
 4 files changed, 69 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index e623ccb4c..5898d21cc 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -382,6 +382,55 @@ int drm_dp_128b132b_read_aux_rd_interval(struct drm_dp_aux *aux)
 }
 EXPORT_SYMBOL(drm_dp_128b132b_read_aux_rd_interval);
 
+/**
+ * drm_dp_128b132b_cable_uhbr_rates() - read the UHBR rates a cable can carry
+ * @aux: DisplayPort AUX channel
+ *
+ * Read the CABLE_ATTRIBUTES_UPDATED_BY_DPRX register (DPCD 0x2217) and return
+ * the set of 128b/132b (UHBR) link rates the attached cable is capable of
+ * carrying, as a mask of %DP_UHBR10, %DP_UHBR13_5 and %DP_UHBR20.
+ *
+ * A UHBRx-capable DPRX updates this register with the cable's capability (via
+ * the CONFIG2 voltage handshake for a DP receptacle, or by parsing the eMarker
+ * for a USB-C receptacle). A source can intersect the returned mask with the
+ * sink's (and its own) supported UHBR rates to avoid attempting link training
+ * at a rate the cable cannot carry, saving the time otherwise spent failing
+ * and falling back.
+ *
+ * A register value of 0 means the cable capability is unknown, or the sink does
+ * not implement the register. No restriction can be derived in that case, so
+ * all UHBR rates are returned and the caller's normal rate fallback applies.
+ *
+ * Returns a mask of DP_UHBR* rates the cable permits.
+ */
+u8 drm_dp_128b132b_cable_uhbr_rates(struct drm_dp_aux *aux)
+{
+	u8 cable, rates = DP_UHBR10 | DP_UHBR13_5 | DP_UHBR20;
+
+	if (drm_dp_dpcd_read_byte(aux, DP_CABLE_ATTRIBUTES_UPDATED_BY_DPRX, &cable) < 0)
+		return rates;
+
+	/* Unknown / not implemented: impose no restriction. */
+	if (!cable)
+		return rates;
+
+	rates = 0;
+	switch (cable & DP_CABLE_UHBR10_20_CAPABILITY_MASK) {
+	case DP_CABLE_UHBR10_20_CAPABLE:
+		rates |= DP_UHBR20;
+		fallthrough;
+	case DP_CABLE_UHBR10_CAPABLE:
+		rates |= DP_UHBR10;
+		break;
+	}
+
+	if (cable & DP_CABLE_UHBR13_5_CAPABILITY)
+		rates |= DP_UHBR13_5;
+
+	return rates;
+}
+EXPORT_SYMBOL(drm_dp_128b132b_cable_uhbr_rates);
+
 void drm_dp_link_train_clock_recovery_delay(const struct drm_dp_aux *aux,
 					    const u8 dpcd[DP_RECEIVER_CAP_SIZE])
 {
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 113d767e6..de8f38754 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -278,6 +278,13 @@ static void intel_dp_set_dpcd_sink_rates(struct intel_dp *intel_dp)
 			}
 		}
 
+		/*
+		 * Intersect with the UHBR rates the cable can actually carry
+		 * (DPCD 0x2217), to avoid training at a rate the cable can't
+		 * support. Unknown/unimplemented leaves the rates untouched.
+		 */
+		uhbr_rates &= drm_dp_128b132b_cable_uhbr_rates(&intel_dp->aux);
+
 		if (uhbr_rates & DP_UHBR10)
 			intel_dp->sink_rates[i++] = 1000000;
 		if (uhbr_rates & DP_UHBR13_5)
diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
index e63c7f075..70463572e 100644
--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -1240,6 +1240,18 @@
 # define DP_128B132B_TRAINING_AUX_RD_INTERVAL_32_MS             0x05
 # define DP_128B132B_TRAINING_AUX_RD_INTERVAL_64_MS             0x06
 
+#define DP_CABLE_ATTRIBUTES_UPDATED_BY_DPRX			0x2217 /* 2.1 */
+# define DP_CABLE_UHBR10_20_CAPABILITY_MASK			(3 << 0)
+# define DP_CABLE_NOT_UHBR_CAPABLE				(0 << 0)
+# define DP_CABLE_UHBR10_CAPABLE				(1 << 0)
+# define DP_CABLE_UHBR10_20_CAPABLE				(2 << 0)
+# define DP_CABLE_UHBR13_5_CAPABILITY				(1 << 2)
+# define DP_CABLE_TYPE_MASK					(7 << 3)
+# define DP_CABLE_TYPE_UNKNOWN					(0 << 3)
+# define DP_CABLE_TYPE_PASSIVE					(1 << 3)
+# define DP_CABLE_TYPE_LRD					(2 << 3)
+# define DP_CABLE_TYPE_LTTPR_RETIMER_ACTIVE			(3 << 3)
+
 #define DP_TEST_264BIT_CUSTOM_PATTERN_7_0		0x2230
 #define DP_TEST_264BIT_CUSTOM_PATTERN_263_256	0x2250
 
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index 5b05a7fbe..a70530696 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -59,6 +59,7 @@ void drm_dp_lttpr_link_train_channel_eq_delay(const struct drm_dp_aux *aux,
 					      const u8 caps[DP_LTTPR_PHY_CAP_SIZE]);
 
 int drm_dp_128b132b_read_aux_rd_interval(struct drm_dp_aux *aux);
+u8 drm_dp_128b132b_cable_uhbr_rates(struct drm_dp_aux *aux);
 bool drm_dp_128b132b_lane_channel_eq_done(const u8 link_status[DP_LINK_STATUS_SIZE],
 					  int lane_count);
 bool drm_dp_128b132b_lane_symbol_locked(const u8 link_status[DP_LINK_STATUS_SIZE],
-- 
2.43.0

