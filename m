Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515E5606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S3+FxdwW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 060A61121AF;
	Thu, 26 Nov 2026 08:40:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AE6E112186;
 Thu, 26 Nov 2026 08:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795682450; x=1827218450;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=tDozPjSPD4DxrKeYkSiSxa//vWx69Tp/WnB/FzaZEVg=;
 b=S3+FxdwWT2oTVA/ZgWADAhtjBOUK1zFTp8HYHjUAjxfDnWeO1hnSgPln
 zPBj6K/X9BUq0hTjHox11m46NvntSwUuwHNytjowr/F3lECxqm40iwies
 TcIRQl3gWHRDzUnzbLt8t7/S4iCcO+A7lDmT1aXPwgdPeBAxP26531xqd
 3DI2nJ8bIT+ZG2D/PpIGoFOsjNCUW5i7xCiXXyInrXyEmpCut7TXS3++L
 sRnGWcOxMc/VDeZrJN5gMgHWe2V8rAWpOOZB0YeEo1qDA1Qyx6I3zrW4A
 1brTt2TNNsokY9WYWVDVlKvmc3adD+ZqnRyl9BnZbZfNwJiMsufiTdEPE Q==;
X-CSE-ConnectionGUID: m/Abml5iSgWr6XwlXFMlpg==
X-CSE-MsgGUID: dmBWtY8/QR+glZYLF0hEXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4488582"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4488582"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 00:40:40 -0800
X-CSE-ConnectionGUID: XL7HxtPKRViDHq5IXVRIsQ==
X-CSE-MsgGUID: foW0VHkiSsevJ/nYyzJ/BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; d="scan'208";a="12125744"
Received: from srr4-3-linux-106-armuthy.iind.intel.com ([10.190.238.56])
 by orviesa007.jf.intel.com with ESMTP; 26 Nov 2026 00:40:38 -0800
From: Arun R Murthy <arun.r.murthy@intel.com>
Date: Thu, 26 Nov 2026 14:05:06 +0530
Subject: [PATCH v6 11/13] drm/dp: Add a helper for the DP BW margin
 overhead
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-vlk-64036-dp-symbol-tg-v6-11-835a4f5c0a12@intel.com>
References: <20261126-vlk-64036-dp-symbol-tg-v6-0-835a4f5c0a12@intel.com>
In-Reply-To: <20261126-vlk-64036-dp-symbol-tg-v6-0-835a4f5c0a12@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
 chaitanya.kumar.borah@intel.com, uma.shankar@intel.com, 
 suraj.kandpal@intel.com, Arun R Murthy <arun.r.murthy@intel.com>
X-Mailer: b4 0.15-dev
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

Split out the SSC/REF_CLK and FEC margin part of the BW overhead from
drm_dp_bw_overhead(), as it doesn't depend on the timings of the stream.
This allows calculating the BW of a stream whose symbol alignment padding
is accounted for by other means, for instance by an effective bpp.

Signed-off-by: Arun R Murthy <arun.r.murthy@intel.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 86 +++++++++++++++++++++------------
 include/drm/display/drm_dp_helper.h     |  1 +
 2 files changed, 57 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 488fd123a01adb7c063d14e3952370726a3b65d6..576c62c2268a684b2c370190249d537b070bf41a 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -4773,45 +4773,23 @@ int drm_dp_link_symbol_cycles(int lane_count, int pixels, int dsc_slice_count,
 EXPORT_SYMBOL(drm_dp_link_symbol_cycles);
 
 /**
- * drm_dp_bw_overhead - Calculate the BW overhead of a DP link stream
- * @lane_count: DP link lane count
- * @hactive: pixel count of the active period in one scanline of the stream
- * @dsc_slice_count: number of slices for DSC or '0' for non-DSC
- * @bpp_x16: bits per pixel in .4 binary fixed point
+ * drm_dp_bw_margin_overhead - Calculate the margin BW overhead of a DP link stream
  * @flags: DRM_DP_OVERHEAD_x flags
  *
- * Calculate the BW allocation overhead of a DP link stream, depending
- * on the link's
- * - @lane_count
- * - SST/MST mode (@flags / %DRM_DP_OVERHEAD_MST)
- * - symbol size (@flags / %DRM_DP_OVERHEAD_UHBR)
+ * Calculate the part of the BW allocation overhead of a DP link stream which
+ * only depends on the link's
  * - FEC mode (@flags / %DRM_DP_OVERHEAD_FEC)
  * - SSC/REF_CLK mode (@flags / %DRM_DP_OVERHEAD_SSC_REF_CLK)
- * as well as the stream's
- * - @hactive timing
- * - @bpp_x16 color depth
- * - compression mode (@dsc_slice_count != 0)
- * Note that this overhead doesn't account for the 8b/10b, 128b/132b
- * channel coding efficiency, for that see
- * @drm_dp_link_bw_channel_coding_efficiency().
+ * and not on the stream's timings, that is the overhead excluding the one
+ * from the symbol alignment padding calculated by drm_dp_bw_overhead(). This
+ * is useful if the symbol alignment is accounted for in another way, for
+ * instance by the stream's effective bpp.
  *
  * Returns the overhead as 100% + overhead% in 1ppm units.
  */
-int drm_dp_bw_overhead(int lane_count, int hactive,
-		       int dsc_slice_count,
-		       int bpp_x16, unsigned long flags)
+int drm_dp_bw_margin_overhead(unsigned long flags)
 {
-	int symbol_size = flags & DRM_DP_BW_OVERHEAD_UHBR ? 32 : 8;
-	bool is_mst = flags & DRM_DP_BW_OVERHEAD_MST;
 	u32 overhead = 1000000;
-	int symbol_cycles;
-
-	if (lane_count == 0 || hactive == 0 || bpp_x16 == 0) {
-		DRM_DEBUG_KMS("Invalid BW overhead params: lane_count %d, hactive %d, bpp_x16 " FXP_Q4_FMT "\n",
-			      lane_count, hactive,
-			      FXP_Q4_ARGS(bpp_x16));
-		return 0;
-	}
 
 	/*
 	 * DP Standard v2.1 2.6.4.1
@@ -4845,6 +4823,54 @@ int drm_dp_bw_overhead(int lane_count, int hactive,
 	WARN_ON((flags & DRM_DP_BW_OVERHEAD_UHBR) &&
 		(flags & DRM_DP_BW_OVERHEAD_FEC));
 
+	return overhead;
+}
+EXPORT_SYMBOL(drm_dp_bw_margin_overhead);
+
+/**
+ * drm_dp_bw_overhead - Calculate the BW overhead of a DP link stream
+ * @lane_count: DP link lane count
+ * @hactive: pixel count of the active period in one scanline of the stream
+ * @dsc_slice_count: number of slices for DSC or '0' for non-DSC
+ * @bpp_x16: bits per pixel in .4 binary fixed point
+ * @flags: DRM_DP_OVERHEAD_x flags
+ *
+ * Calculate the BW allocation overhead of a DP link stream, depending
+ * on the link's
+ * - @lane_count
+ * - SST/MST mode (@flags / %DRM_DP_OVERHEAD_MST)
+ * - symbol size (@flags / %DRM_DP_OVERHEAD_UHBR)
+ * - FEC mode (@flags / %DRM_DP_OVERHEAD_FEC)
+ * - SSC/REF_CLK mode (@flags / %DRM_DP_OVERHEAD_SSC_REF_CLK)
+ * as well as the stream's
+ * - @hactive timing
+ * - @bpp_x16 color depth
+ * - compression mode (@dsc_slice_count != 0)
+ * Note that this overhead doesn't account for the 8b/10b, 128b/132b
+ * channel coding efficiency, for that see
+ * @drm_dp_link_bw_channel_coding_efficiency().
+ *
+ * Returns the overhead as 100% + overhead% in 1ppm units.
+ */
+int drm_dp_bw_overhead(int lane_count, int hactive,
+		       int dsc_slice_count,
+		       int bpp_x16, unsigned long flags)
+{
+	int symbol_size = flags & DRM_DP_BW_OVERHEAD_UHBR ? 32 : 8;
+	bool is_mst = flags & DRM_DP_BW_OVERHEAD_MST;
+	u32 overhead;
+	int symbol_cycles;
+
+	if (lane_count == 0 || hactive == 0 || bpp_x16 == 0) {
+		DRM_DEBUG_KMS("Invalid BW overhead params: lane_count %d, hactive %d, bpp_x16 "
+			      FXP_Q4_FMT "\n",
+			      lane_count, hactive,
+			      FXP_Q4_ARGS(bpp_x16));
+		return 0;
+	}
+
+	overhead = drm_dp_bw_margin_overhead(flags);
+
 	symbol_cycles = drm_dp_link_symbol_cycles(lane_count, hactive,
 						  dsc_slice_count,
 						  bpp_x16, symbol_size,
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index 5b05a7fbe174a6497bb98cab34dc3f5607233815..a568da6b249b52914c253a92d815e5a96fd773f5 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -1028,6 +1028,7 @@ int drm_dp_pcon_convert_rgb_to_ycbcr(struct drm_dp_aux *aux, u8 color_spc);
 #define DRM_DP_BW_OVERHEAD_FEC		BIT(3)
 #define DRM_DP_BW_OVERHEAD_DSC		BIT(4)
 
+int drm_dp_bw_margin_overhead(unsigned long flags);
 int drm_dp_bw_overhead(int lane_count, int hactive,
 		       int dsc_slice_count,
 		       int bpp_x16, unsigned long flags);

-- 
2.25.1

