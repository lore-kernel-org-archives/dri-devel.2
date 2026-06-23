Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C6FCDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 09:46:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F6AC10EA58;
	Tue, 23 Jun 2026 09:46:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="itnO0pVh";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB03310EA59;
 Tue, 23 Jun 2026 09:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782207986; x=1813743986;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6v5mmlSrFdyCDHvN82cKCl2XZtH6G/8T5RULd74x7iU=;
 b=itnO0pVh+G8dtA2QxsHGgIZVDLmChjfmX+mCvJ6e8Se5Tx8cDVs1d3U5
 slAtNGEi8v0LK9GfTvr3JG6mhTrC+eowT2MEDZ/sfw4d/iViLOsLoVPLG
 B6j65zrxqIvvfYJ8STC/ferT96hyPUlbi8QD/awGFAFE4divCFLg0v13m
 bo6edjfn7zQh8yZNenGRrGHaP8ox6JYdwOYJ2xXyyVk88sYlUhcGp2H7F
 WGfVeeiYrGfZTwyzEtDKtEHNUHo4L3r06wjofG5uQJ5AQtJY6jbm7mvtO
 9MhIqqMWeHFCrcli9HChdWlIJyw6LjNDP6dK9X1D56bCTNtT0hoDw8p8o w==;
X-CSE-ConnectionGUID: uqjIALSTQI2nVtJzaeAL/A==
X-CSE-MsgGUID: jPxyqyUVQx+6WNhoXqt/ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="94336282"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="94336282"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 02:46:26 -0700
X-CSE-ConnectionGUID: w4VaeocQQCCymkU6iqgW/A==
X-CSE-MsgGUID: OyKJ8HcyTeq0Jdjz78Aq6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="247130388"
Received: from nemesa.iind.intel.com ([10.190.239.22])
 by fmviesa008.fm.intel.com with ESMTP; 23 Jun 2026 02:46:24 -0700
From: Nemesa Garg <nemesa.garg@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Nemesa Garg <nemesa.garg@intel.com>,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
 Jani Nikula <jani.nikula@intel.com>
Subject: [RESEND 4/4] drm/i915/dp: Decode dsc max delta bpp from sink dpcd
Date: Tue, 23 Jun 2026 15:12:36 +0530
Message-Id: <20260623094236.1586318-5-nemesa.garg@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260623094236.1586318-1-nemesa.garg@intel.com>
References: <20260623094236.1586318-1-nemesa.garg@intel.com>
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

Add intel_dp_dsc_max_delta_bppx16() to parse sink dsc max
delta bpp from dpcd when DP_DSC_MAX_BPP_DELTA_AVAILABILITY
is set. This helper decodes the delta range for both RGB/YCbCr444
and YCbCr420 formats from DP_DSC_MAX_BPP_DELTA.

With this addition, the flow becomes:
1. First, check for a format-specific range and use it to calculate
max compressed bpp.
2. If not, check for sink supported max compressed bpp and
use that
3. If this is also not there go with mandatory
max range supported bpp.

v2: Reorder the check flow for max_bpp. [Ankit]
v3: Put RGB and YCbCr444 mask assignment in the same line. [Ankit]
v4: Zero max_bpp for reserved RGB/YCbCr444 delta values. [sashiko]

Signed-off-by: Nemesa Garg <nemesa.garg@intel.com>
Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 43 +++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 3569e61e7fee..28b887ee5cf1 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -2184,17 +2184,56 @@ static int dsc_compute_link_config(struct intel_dp *intel_dp,
 	return -EINVAL;
 }
 
+static u16 intel_dp_dsc_max_delta_bppx16(const struct intel_connector *connector,
+					 enum intel_output_format output_format)
+{
+	const u8 *dsc_dpcd = connector->dp.dsc_dpcd;
+	u8 max_bpp_delta_v1 = dsc_dpcd[DP_DSC_MAX_BPP_DELTA_VERSION_1 - DP_DSC_SUPPORT];
+	int max_bpp;
+
+	if (!(dsc_dpcd[DP_DSC_MAX_BITS_PER_PIXEL_HI - DP_DSC_SUPPORT] &
+	    DP_DSC_MAX_BPP_DELTA_AVAILABILITY))
+		return 0;
+
+	switch (output_format) {
+	case INTEL_OUTPUT_FORMAT_RGB:
+	case INTEL_OUTPUT_FORMAT_YCBCR444:
+		max_bpp =  max_bpp_delta_v1 & DP_DSC_RGB_YCbCr444_MAX_BPP_DELTA_MASK;
+		if (max_bpp >= 1 && max_bpp <= 21)
+			max_bpp =  max_bpp + DP_DSC_BPP_DELTA_444 - 1;
+		else
+			max_bpp = 0;
+		break;
+	case INTEL_OUTPUT_FORMAT_YCBCR420:
+		max_bpp = (max_bpp_delta_v1 & DP_DSC_NATIVE_YCbCr420_MAX_BPP_DELTA_MASK) >>
+			  DP_DSC_BPP_DELTA_SHIFT_420;
+		if (max_bpp >= 1 && max_bpp <= 7)
+			max_bpp = max_bpp + DP_DSC_BPP_DELTA_420 - 1;
+		break;
+	default:
+		MISSING_CASE(output_format);
+		return 0;
+	}
+
+	return max_bpp << 4;
+}
+
 static
 u16 intel_dp_dsc_max_sink_compressed_bppx16(const struct intel_connector *connector,
 					    enum intel_output_format output_format,
 					    int bpc)
 {
-	u16 max_bppx16 = drm_edp_dsc_sink_output_bpp(connector->dp.dsc_dpcd);
+	u16 max_bppx16 = intel_dp_dsc_max_delta_bppx16(connector, output_format);
+
+	if (max_bppx16)
+		return max_bppx16;
+
+	max_bppx16 = drm_edp_dsc_sink_output_bpp(connector->dp.dsc_dpcd);
 
 	if (max_bppx16)
 		return max_bppx16;
 	/*
-	 * If support not given in DPCD 67h, 68h use the Maximum Allowed bit rate
+	 * If support not given in DPCD 67h, 68h, 6Eh, 6Fh use the Maximum Allowed bit rate
 	 * values as given in spec Table 2-157 DP v2.0
 	 */
 	switch (output_format) {
-- 
2.25.1

