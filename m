Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922E2606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RV4u57OX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED9BF112798;
	Fri, 30 Oct 2026 12:03:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B25C3112780;
 Fri, 30 Oct 2026 12:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793361810; x=1824897810;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gotFQCWN8V/Pzph+Gwynkt0D9VF8NIZ8gOJJ/G0kdLs=;
 b=RV4u57OXpBgyHLdgPwhemI4W1cxa7CxTiwp1/S5L6DZIc8/5zGCUrtSi
 BE1ki8j9C66RukiDjtfwHejVdKD+DNyeNu25TgzsA17a7VG9KsAXHgHfG
 df3IjllzIhMFq2MeifRO/siSCR9wpUiQR4GhVsJKpLgyXAvq2VRX1gfvk
 slE6w5fa8haYpVo/SRv6bVpCEjL9cEfYYzz7Jw1Kn1opDzHQMIreQITNm
 cJ4jSzwbDOxPaJ0ELX9mHJnB2yyq5VpQT8FbNxAc+a3RDZN/Bucdfy907
 MB8m8VV2laiq+/RoSGrzqQnkd2Tq1G3M3YYi8y6TpF/nNHg0TlZLwO1Pp A==;
X-CSE-ConnectionGUID: rna9P2TkSiOD5VTQkCtW1g==
X-CSE-MsgGUID: jASNYVwzSoiZwHe6/0oUag==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2215176"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2215176"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 05:03:29 -0700
X-CSE-ConnectionGUID: BA8ZYiT7Tg+tA4hl0CNKAA==
X-CSE-MsgGUID: 1Cd2VKC/T1CY/SLI5FJ85g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5546083"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.13])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 05:03:27 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: jani.nikula@intel.com
Subject: [PATCH 02/13] drm/dp: prefer drm_printf_indent() over inline \t
Date: Fri, 30 Oct 2026 14:03:05 +0200
Message-ID: <6d75f01075e2ea41fde8620677b3182bcdaabff7.1793361738.git.jani.nikula@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1793361738.git.jani.nikula@intel.com>
References: <cover.1793361738.git.jani.nikula@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We have a helper drm_printf_indent() for tab indenting the prints. It
makes the actual strings more readable, and highlights the indented
parts better in source.

Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 35 ++++++++++++-------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 166a77091abe..76d61e74309e 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -1683,68 +1683,67 @@ void drm_dp_downstream_debug(struct drm_printer *p,
 	int type = port_cap[0] & DP_DS_PORT_TYPE_MASK;
 	bool branch_device = drm_dp_is_branch(dpcd);
 
-	drm_printf(p, "\tDP branch device present: %s\n",
-		   str_yes_no(branch_device));
+	drm_printf_indent(p, 1, "DP branch device present: %s\n",
+			  str_yes_no(branch_device));
 
 	if (!branch_device)
 		return;
 
 	switch (type) {
 	case DP_DS_PORT_TYPE_DP:
-		drm_puts(p, "\t\tType: DisplayPort\n");
+		drm_printf_indent(p, 2, "Type: DisplayPort\n");
 		break;
 	case DP_DS_PORT_TYPE_VGA:
-		drm_puts(p, "\t\tType: VGA\n");
+		drm_printf_indent(p, 2, "Type: VGA\n");
 		break;
 	case DP_DS_PORT_TYPE_DVI:
-		drm_puts(p, "\t\tType: DVI\n");
+		drm_printf_indent(p, 2, "Type: DVI\n");
 		break;
 	case DP_DS_PORT_TYPE_HDMI:
-		drm_puts(p, "\t\tType: HDMI\n");
+		drm_printf_indent(p, 2, "Type: HDMI\n");
 		break;
 	case DP_DS_PORT_TYPE_NON_EDID:
-		drm_puts(p, "\t\tType: others without EDID support\n");
+		drm_printf_indent(p, 2, "Type: others without EDID support\n");
 		break;
 	case DP_DS_PORT_TYPE_DP_DUALMODE:
-		drm_puts(p, "\t\tType: DP++\n");
+		drm_printf_indent(p, 2, "Type: DP++\n");
 		break;
 	case DP_DS_PORT_TYPE_WIRELESS:
-		drm_puts(p, "\t\tType: Wireless\n");
+		drm_printf_indent(p, 2, "Type: Wireless\n");
 		break;
 	default:
-		drm_puts(p, "\t\tType: N/A\n");
+		drm_printf_indent(p, 2, "Type: N/A\n");
 	}
 
 	memset(id, 0, sizeof(id));
 	drm_dp_downstream_id(aux, id);
-	drm_printf(p, "\t\tID: %s\n", id);
+	drm_printf_indent(p, 2, "ID: %s\n", id);
 
 	len = drm_dp_dpcd_read_data(aux, DP_BRANCH_HW_REV, &rev[0], 1);
 	if (!len)
-		drm_printf(p, "\t\tHW: %d.%d\n",
-			   (rev[0] & 0xf0) >> 4, rev[0] & 0xf);
+		drm_printf_indent(p, 2, "HW: %d.%d\n", (rev[0] & 0xf0) >> 4, rev[0] & 0xf);
 
 	len = drm_dp_dpcd_read_data(aux, DP_BRANCH_SW_REV, rev, 2);
 	if (!len)
-		drm_printf(p, "\t\tSW: %d.%d\n", rev[0], rev[1]);
+		drm_printf_indent(p, 2, "SW: %d.%d\n", rev[0], rev[1]);
 
 	if (detailed_cap_info) {
 		clk = drm_dp_downstream_max_dotclock(dpcd, port_cap);
 		if (clk > 0)
-			drm_printf(p, "\t\tMax dot clock: %d kHz\n", clk);
+			drm_printf_indent(p, 2, "Max dot clock: %d kHz\n", clk);
 
 		clk = drm_dp_downstream_max_tmds_clock(dpcd, port_cap, drm_edid);
 		if (clk > 0)
-			drm_printf(p, "\t\tMax TMDS clock: %d kHz\n", clk);
+			drm_printf_indent(p, 2, "Max TMDS clock: %d kHz\n", clk);
 
 		clk = drm_dp_downstream_min_tmds_clock(dpcd, port_cap, drm_edid);
 		if (clk > 0)
-			drm_printf(p, "\t\tMin TMDS clock: %d kHz\n", clk);
+			drm_printf_indent(p, 2, "Min TMDS clock: %d kHz\n", clk);
 
 		bpc = drm_dp_downstream_max_bpc(dpcd, port_cap, drm_edid);
 
 		if (bpc > 0)
-			drm_printf(p, "\t\tMax bpc: %d\n", bpc);
+			drm_printf_indent(p, 2, "Max bpc: %d\n", bpc);
 	}
 }
 EXPORT_SYMBOL(drm_dp_downstream_debug);
-- 
2.47.3

