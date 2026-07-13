Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DF2C44506
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 05:39:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9F8010E79B;
	Mon, 13 Jul 2026 05:39:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hLBxxmAU";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59BE810E79A;
 Mon, 13 Jul 2026 05:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783921179; x=1815457179;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ltH5BrN7Z3fULNLccZCl4YnN+OB3W5aCUsT8/Fg2rFg=;
 b=hLBxxmAUU8Lb4YGY7UGSk1djGYi/ISmmkTDhFxSSR+4ZrJSrmMR3Cnpv
 7NwVxfGMirafyvoOY079kmBgo0/cC8/7+uVSZmE+oZgprCY9d4P8zqe7z
 edMH9RpBEErRu16V74oQmTDUbO0JYYHVFNkSM7hMJfnEit05XkY46Chp4
 sjt6dqh17I/bsTBFHdzKn1+7lPjrfGc1XXWite4+a2fGn4G1sQweBK5r6
 oWU7DNRCrpfpN16gs7IUHfx/qt7MSRO1qU1rTuZm0OHivgx2ZgDK8lqAj
 a9TUVcEQ0hVaRY4AS0Z9IuLUe9HrMNEsXeKrvUVcP608i3rzIhrvk1fPG A==;
X-CSE-ConnectionGUID: Pn9aLHOtQwCrpDxrbXSBVw==
X-CSE-MsgGUID: loNdtd6lR360LX0465l6Gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95670004"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="95670004"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2026 22:39:39 -0700
X-CSE-ConnectionGUID: O+OL8ibKTmmDYFAM7rO7BA==
X-CSE-MsgGUID: IRidxWznQ1OlpRZdchWlGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="252066349"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by fmviesa007.fm.intel.com with ESMTP; 12 Jul 2026 22:39:37 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Pranay Samala <pranay.samala@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>
Subject: [CI v4 11/14] drm/i915/color: Program Pre-CSC registers for SDR
Date: Mon, 13 Jul 2026 10:45:13 +0530
Message-Id: <20260713051516.4087420-12-chaitanya.kumar.borah@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260713051516.4087420-1-chaitanya.kumar.borah@intel.com>
References: <20260713051516.4087420-1-chaitanya.kumar.borah@intel.com>
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

From: Pranay Samala <pranay.samala@intel.com>

Implement plane pre-CSC LUT support for SDR planes.

v2:
- s/drm_color_lut_extract/drm_color_lut32_extract

v3:
- Restructure loop to match HDR function pattern

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Pranay Samala <pranay.samala@intel.com>
Co-developed-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
---
 drivers/gpu/drm/i915/display/intel_color.c | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_color.c b/drivers/gpu/drm/i915/display/intel_color.c
index 2a32ab62721c..abf3b3a2e177 100644
--- a/drivers/gpu/drm/i915/display/intel_color.c
+++ b/drivers/gpu/drm/i915/display/intel_color.c
@@ -3992,6 +3992,46 @@ xelpd_load_hdr_pre_csc_lut(struct intel_display *display,
 	intel_de_write_dsb(display, dsb, PLANE_PRE_CSC_GAMC_INDEX_ENH(pipe, plane, 0), 0);
 }
 
+static void
+xelpd_load_sdr_pre_csc_lut(struct intel_display *display,
+			   struct intel_dsb *dsb,
+			   enum pipe pipe,
+			   enum plane_id plane,
+			   const struct drm_color_lut32 *pre_csc_lut)
+{
+	int i, lut_size = 32;
+	u32 lut_val;
+
+	/*
+	 * First 3 planes are HDR, so reduce by 3 to get to the right
+	 * SDR plane offset
+	 */
+	plane = plane - 3;
+
+	intel_de_write_dsb(display, dsb,
+			   PLANE_PRE_CSC_GAMC_INDEX(pipe, plane, 0),
+			   PLANE_PAL_PREC_AUTO_INCREMENT);
+
+	for (i = 0; i < lut_size + 3; i++) {
+		if (pre_csc_lut) {
+			if (i < lut_size)
+				lut_val = drm_color_lut32_extract(pre_csc_lut[i].green, 16);
+			/* else duplicate last lut_val */
+		} else {
+			if (i < lut_size)
+				lut_val = (i * ((1 << 16) - 1)) / (lut_size - 1);
+			else
+				lut_val = 1 << 16;
+		}
+
+		intel_de_write_dsb(display, dsb,
+				   PLANE_PRE_CSC_GAMC_DATA(pipe, plane, 0),
+				   lut_val);
+	}
+
+	intel_de_write_dsb(display, dsb, PLANE_PRE_CSC_GAMC_INDEX(pipe, plane, 0), 0);
+}
+
 static void
 xelpd_program_plane_pre_csc_lut(struct intel_dsb *dsb,
 				const struct intel_plane_state *plane_state)
@@ -4005,6 +4045,8 @@ xelpd_program_plane_pre_csc_lut(struct intel_dsb *dsb,
 
 	if (icl_is_hdr_plane(display, plane))
 		xelpd_load_hdr_pre_csc_lut(display, dsb, pipe, plane, pre_csc_lut);
+	else
+		xelpd_load_sdr_pre_csc_lut(display, dsb, pipe, plane, pre_csc_lut);
 }
 
 static void
-- 
2.25.1

