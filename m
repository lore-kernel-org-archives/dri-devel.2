Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F61C5AC81
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:32:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23BDD10F3B8;
	Fri,  7 Aug 2026 04:32:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BZ29NTLF";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE24310F3B5;
 Fri,  7 Aug 2026 04:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077157; x=1817613157;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nmOTrBUVakJdbiMQ6u1ZFCRd3jehOIi7Z8OhafXgM7c=;
 b=BZ29NTLFTXsD18aec2doAXArzG7S9qmZoFdAKzQxEsRn6pv1ZciiQ9NA
 fA7b7zB8t/NTj+xxrqxG50maOiUgXl5B9bVYx+HNp1qPm0GS6HhkFunNa
 z9nciJ6DKG2/PrmEjzkqgPCCiDiGq6jGpX5M69sYNJ1NlePgaCTZ/HzJ8
 RRZCMV0VSNI2AfbPUSk5ivce8KV/GaFP9+hbX3Qe9qz8ex+5A7ATmt7qs
 NCAwQVPaNVGrMOS572DanPmwBl6Qr4WYRpUTJTUPaptUcN7Rs4sL4ZPeV
 W+UKjdNMpYOQ2KQbSZ6QoaGhSn5X+R3rCKhx4mBuSSXet02HpsmsMlVv/ A==;
X-CSE-ConnectionGUID: 0Qm1dzPiRG+IlxHfnHxlBQ==
X-CSE-MsgGUID: cvaAJzVnTOOz3QlbZTHbeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619352"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619352"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:37 -0700
X-CSE-ConnectionGUID: dabYHJMVSkyJplyrI8xs8w==
X-CSE-MsgGUID: aF0I5rLtSMeHc3YxnEb5rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666423"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:34 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 27/44] drm/i915/lt_phy: Add helper to check if the FRL rate is
 valid
Date: Fri,  7 Aug 2026 09:44:12 +0530
Message-ID: <20260807041430.229038-28-ankit.k.nautiyal@intel.com>
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

Introduce helper intel_lt_phy_hdmi_frl_rate_valid() to check if the
given FRL rate is supported for the LT Phy.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_lt_phy.c | 16 ++++++++++++++++
 drivers/gpu/drm/i915/display/intel_lt_phy.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_lt_phy.c b/drivers/gpu/drm/i915/display/intel_lt_phy.c
index 2c1da689fe00..f7265d32915d 100644
--- a/drivers/gpu/drm/i915/display/intel_lt_phy.c
+++ b/drivers/gpu/drm/i915/display/intel_lt_phy.c
@@ -2652,3 +2652,19 @@ void intel_lt_phy_verify_plls(struct intel_display *display)
 	intel_lt_phy_pll_verify_tables(display, xe3plpd_lt_edp_tables);
 	intel_lt_phy_pll_verify_tables(display, xe3plpd_lt_hdmi_tables);
 }
+
+enum drm_mode_status intel_lt_phy_hdmi_frl_rate_valid(int clock_rate)
+{
+	const struct intel_lt_phy_pll_params *tables = xe3plpd_lt_hdmi_tables;
+	int i;
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
diff --git a/drivers/gpu/drm/i915/display/intel_lt_phy.h b/drivers/gpu/drm/i915/display/intel_lt_phy.h
index 16de39484779..20714ecd9f62 100644
--- a/drivers/gpu/drm/i915/display/intel_lt_phy.h
+++ b/drivers/gpu/drm/i915/display/intel_lt_phy.h
@@ -49,5 +49,6 @@ void intel_xe3plpd_pll_enable(struct intel_encoder *encoder,
 			      const struct intel_dpll_hw_state *dpll_hw_state);
 void intel_xe3plpd_pll_disable(struct intel_encoder *encoder);
 void intel_lt_phy_verify_plls(struct intel_display *display);
+enum drm_mode_status intel_lt_phy_hdmi_frl_rate_valid(int clock_rate);
 
 #endif /* __INTEL_LT_PHY_H__ */
-- 
2.50.1

