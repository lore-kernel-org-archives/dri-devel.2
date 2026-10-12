Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A087CA9ED6
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:15:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6736410E568;
	Mon, 12 Oct 2026 04:15:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C72910E454;
 Mon, 12 Oct 2026 04:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778518; x=1823314518;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LMdRE147hJCli+xnv0Zo3ichAgzxlno7X4PXYFxAs3k=;
 b=X1LdAsESa4Qt5uVuyv0u42ztwWuIa2CjWU46gsCNc5HHfuZ3lsGwndg3
 0I//nUAQBncsuQvGwNksZESTc57MsI9QfMKP1PPvtgiP8ZZUTeCpNL6SM
 4NArVwo4MYcJtWtGhJdqNeGYsCx9EMq5hlDQf5ztlPi5db/ntHpQeI8FH
 1ZJqbv3knCOZqEO0+OJpXLNJlIjGifqT+r4vDYhZbvcIIAgqhIuagWRPQ
 6YpwKJqt7knkttTjYg+E8GDpx1Q0tX8lTsYpQR41McQ4e5Bqvy2dYd9br
 q59hYbnEDsHIf7HmZrCho4eukK33REcNJ8O/PMQzfDEIVcaB8iYkMYryA g==;
X-CSE-ConnectionGUID: 1kW0mJXrRFupL5EdfLaWZQ==
X-CSE-MsgGUID: e5aJgaFCRNO04IFttqoAPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380902"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380902"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:11 -0700
X-CSE-ConnectionGUID: Chiq8wR1TqOVRrzYLccKaw==
X-CSE-MsgGUID: Et2KxZ5UR1+sLYF31eEr9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256501"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:10 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 25/56] drm/i915/cx0: Add helper to check if the FRL rate is
 valid
Date: Mon, 12 Oct 2026 09:27:34 +0530
Message-ID: <20261012035806.3361439-26-ankit.k.nautiyal@intel.com>
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

Introduce helper intel_cx0_phy_hdmi_frl_rate_valid() to check if the
given FRL rate is supported for the c10/20 Phys.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_cx0_phy.c | 23 ++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_cx0_phy.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_cx0_phy.c b/drivers/gpu/drm/i915/display/intel_cx0_phy.c
index b83f0afaa9b5..d7fefb4871b7 100644
--- a/drivers/gpu/drm/i915/display/intel_cx0_phy.c
+++ b/drivers/gpu/drm/i915/display/intel_cx0_phy.c
@@ -3870,3 +3870,26 @@ void intel_cx0pll_verify_plls(struct intel_display *display)
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

