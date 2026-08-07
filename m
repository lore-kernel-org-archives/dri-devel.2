Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF73C5AC9E
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:32:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DF9910F3B5;
	Fri,  7 Aug 2026 04:32:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DL7q/ZLd";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F18F10F39E;
 Fri,  7 Aug 2026 04:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077154; x=1817613154;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DAtUAKd0VXum2eO4HgdNTbuLt0Qs8kJUjncwgfFFIPs=;
 b=DL7q/ZLdkUkPWmOjXgMVJWqg1VJLWL0dWCBZle0bXxvaAnZR7uBWXYoI
 hMHqLikv7VUzWmG0JcegdwR1drqpWUn0tsGMfJdrD4GcdiMZUeZQVYr8w
 EC2eoY1ptZmY5hxZD08U/x9U6VpxC+bQ57YgmdhLososGUDmWASyqNSkk
 xcsLp0dDVREcEY2wOAO8f81Aa8rE1ElzITCD9W6zBjWIGlq+/4yETXZow
 rOXaH/0rnaVrlO9jvFSa7kcCpetQNrd8Xipe/jS35aor+lW+pqZezSb5V
 3jDDR/szeedftGhxUfTvgqE3GHp1QvTgVwAhd2KZObjxG3u/zZ2VmgekU Q==;
X-CSE-ConnectionGUID: R7Jb4Fj2TqCcfcCbJXYSrQ==
X-CSE-MsgGUID: Fdk8rennRPicwgCXFrg5mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619349"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619349"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:34 -0700
X-CSE-ConnectionGUID: vH6Bczi/QcCROxzK7I0Odg==
X-CSE-MsgGUID: 0pGFjYKxSEWUNhdJWf5u3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666402"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:32 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 26/44] drm/i915/cx0: Add helper to check if the FRL rate is
 valid
Date: Fri,  7 Aug 2026 09:44:11 +0530
Message-ID: <20260807041430.229038-27-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260807041430.229038-1-ankit.k.nautiyal@intel.com>
References: <20260807041430.229038-1-ankit.k.nautiyal@intel.com>
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

Introduce helper intel_cx0_phy_hdmi_frl_rate_valid() to check if the
given FRL rate is supported for the c10/20 Phys.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_cx0_phy.c | 23 ++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_cx0_phy.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_cx0_phy.c b/drivers/gpu/drm/i915/display/intel_cx0_phy.c
index 452062417ce9..4391bc4cb48a 100644
--- a/drivers/gpu/drm/i915/display/intel_cx0_phy.c
+++ b/drivers/gpu/drm/i915/display/intel_cx0_phy.c
@@ -3868,3 +3868,26 @@ void intel_cx0pll_verify_plls(struct intel_display *display)
 	intel_cx0pll_verify_tables(display, xe3lpd_c20_dp_edp_tables);
 	intel_cx0pll_verify_tables(display, mtl_c20_hdmi_tables);
 }
+
+enum drm_mode_status
+intel_cx0_phy_hdmi_frl_rate_valid(struct intel_hdmi *hdmi, int clock_rate)
+{
+	struct intel_digital_port *dig_port = hdmi_to_dig_port(hdmi);
+	const struct intel_cx0pll_params *tables;
+	int i;
+
+	if (intel_encoder_is_c10phy(&dig_port->base))
+		tables = mtl_c10_hdmi_tables;
+	else
+		tables = mtl_c20_hdmi_tables;
+
+	for (i = 0; tables[i].name; i++) {
+		if (!intel_hdmi_is_frl(tables[i].clock_rate))
+			continue;
+
+		if (clock_rate == tables[i].clock_rate)
+			return MODE_OK;
+	}
+
+	return MODE_CLOCK_RANGE;
+}
diff --git a/drivers/gpu/drm/i915/display/intel_cx0_phy.h b/drivers/gpu/drm/i915/display/intel_cx0_phy.h
index 95c20eb4b4b7..b7785bcebecb 100644
--- a/drivers/gpu/drm/i915/display/intel_cx0_phy.h
+++ b/drivers/gpu/drm/i915/display/intel_cx0_phy.h
@@ -84,5 +84,6 @@ void intel_lnl_mac_transmit_lfps(struct intel_encoder *encoder,
 void intel_mtl_tbt_pll_enable(struct intel_encoder *encoder,
 			      const struct intel_crtc_state *crtc_state);
 void intel_mtl_tbt_pll_disable(struct intel_encoder *encoder);
+enum drm_mode_status intel_cx0_phy_hdmi_frl_rate_valid(struct intel_hdmi *hdmi, int clock_rate);
 
 #endif /* __INTEL_CX0_PHY_H__ */
-- 
2.50.1

