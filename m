Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A72D606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 05:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JPc5Xj0w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 298A610FEA5;
	Fri, 20 Nov 2026 05:12:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DD4610F116;
 Fri, 20 Nov 2026 05:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795151513; x=1826687513;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=tDozPjSPD4DxrKeYkSiSxa//vWx69Tp/WnB/FzaZEVg=;
 b=JPc5Xj0wZ7q1WOLDJzVhitYxIBVflneIcKutmcROpupGP8aNu4o0Rcm/
 Q3JD9XPXphgW0PT+XU6PAsEuNIwB6foDda0bB0+LIajv+mETNIQ0NgdIh
 iPOoXd1cj4MQY4NfuRPqCsgn5JbnvB9cI0LWzBYM1sy9YFOfmc8XEIfBf
 yngBePVHnW6XCNIRbbauvH+RBqHkxzPdAleJu4ieoX7VQQAKYyG8ZSwqz
 wMKqoPxdLXKnRZegn1oyJSKMNwuI4JQfF94t1xec9IBNLt8FmgRrVvIX4
 FC5UihenG4MpIHdGex31+aO+eevlFbgeHqpao/EokbWGQud1Dxg2LNgDQ Q==;
X-CSE-ConnectionGUID: Ofi17QPeRH+M6m6fRxOy5w==
X-CSE-MsgGUID: eTYTRdGbQYm3NgMU5y0QuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3907486"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3907486"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 21:11:53 -0800
X-CSE-ConnectionGUID: n3ndZQ1zStWQHj6jmGvhpQ==
X-CSE-MsgGUID: KjCYbGaySPqAXqo3q6BX/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; d="scan'208";a="10607300"
Received: from srr4-3-linux-106-armuthy.iind.intel.com ([10.190.238.56])
 by fmviesa004.fm.intel.com with ESMTP; 19 Nov 2026 21:11:49 -0800
From: Arun R Murthy <arun.r.murthy@intel.com>
Date: Fri, 20 Nov 2026 10:36:10 +0530
Subject: [PATCH v5 11/13] drm/dp: Add a helper for the DP BW margin
 overhead
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-vlk-64036-dp-symbol-tg-v5-11-bf8f78b32709@intel.com>
References: <20261120-vlk-64036-dp-symbol-tg-v5-0-bf8f78b32709@intel.com>
In-Reply-To: <20261120-vlk-64036-dp-symbol-tg-v5-0-bf8f78b32709@intel.com>
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

