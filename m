Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9801ACA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:15:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA70510E4F4;
	Mon, 12 Oct 2026 04:15:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B09A610E4C0;
 Mon, 12 Oct 2026 04:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778519; x=1823314519;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KGbuHyYXER+YlsMjzNUdF85Rpb6CzrNY5ldZrqt1aoY=;
 b=IZBePoaCBXoDa8tkT/S46pGypbsDf79h9LgeoKFCJghQHB+sEE2Ds69b
 XuTxdQvR8H52YCWLCfGrPSiWyPQx9PGvpfgIRlJER+ugQVkpJ9erjT0tN
 wh+0+jcOvAkdayXW4U1p1NLlzmuEOWzxHz9HDPZfCizXeUYvU0moDq0rk
 0W6jQheVm0cOmFqmHx1APHzayCRpwDvcKlzsQr+EWtW8+R3FUMKFoBKCx
 yRdqDN91iKsL9/6S7rZeb4QALOtVoHVIiqmDwUpgV1UR4E3SuhNthUF1+
 E2199PpyvB5667xln1LaDpTNs+SNlP6C5eUOSLmgJ8IOU9y+Sdu5mi9gb Q==;
X-CSE-ConnectionGUID: 4Tu5oafgRtaVTgZloqtOKw==
X-CSE-MsgGUID: br5++8c8SR6w9tjFjh7ROg==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380903"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380903"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:13 -0700
X-CSE-ConnectionGUID: np2U+jjnRMWv3RkhbnLfhg==
X-CSE-MsgGUID: bt0XWVZcQH2Xr078eeYGJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256508"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:12 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 26/56] drm/i915/lt_phy: Add helper to check if the FRL rate
 is valid
Date: Mon, 12 Oct 2026 09:27:35 +0530
Message-ID: <20261012035806.3361439-27-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
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
index 4223d806ffd7..ba03e5f1bb87 100644
--- a/drivers/gpu/drm/i915/display/intel_lt_phy.c
+++ b/drivers/gpu/drm/i915/display/intel_lt_phy.c
@@ -2654,3 +2654,19 @@ void intel_lt_phy_verify_plls(struct intel_display *display)
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

