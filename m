Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E181C44506
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 05:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E3BB10E794;
	Mon, 13 Jul 2026 05:39:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DWctvU23";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8722F10E792;
 Mon, 13 Jul 2026 05:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783921176; x=1815457176;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MNjyIEFDPUIA/LwxYKXC1e215e9zEKP86cOt984mK38=;
 b=DWctvU23XYPzeIyPq1ar2CE16tTKSJbTN2RME+1hUVCFneLc+36U/LdX
 bUsNgtu71PB7rsZBJijNRM83fCiWQMek+dmBiLLvE730M0+iPymDAfeTk
 8P0M2CO/weM0jXygftnWhpamdFnziD3q1gOxyLrKA0yE9FhvReEJ3fgh+
 OepIVLtSFI9wipZ8I5rNr9C7JXwajBlAHrOdRbTqOR04q+L2h4dasizaq
 e9xpF6vE7Y3qUzTvcQB1DKACSvADU64sbfdMNYqVDsrOwfg0mKeoMsPNg
 Q0EKtMQOgU5TjdLS8ywRxhYqSk9eQI4l07sjQpdsSpyKEiTzVttCOAYGf A==;
X-CSE-ConnectionGUID: cpieRe+vRPCeHcAf1CNbVQ==
X-CSE-MsgGUID: IIe54DbnS0mxo3tysw/hMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95670001"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="95670001"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2026 22:39:35 -0700
X-CSE-ConnectionGUID: nziKExQkTJ6Pl8WTOx4qlQ==
X-CSE-MsgGUID: r3/tyxSES96nf4Pdt17M4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="252066341"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by fmviesa007.fm.intel.com with ESMTP; 12 Jul 2026 22:39:34 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>
Subject: [CI v4 09/14] drm/i915/color: Add support for 1D LUT in SDR planes
Date: Mon, 13 Jul 2026 10:45:11 +0530
Message-Id: <20260713051516.4087420-10-chaitanya.kumar.borah@intel.com>
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

Extend the SDR plane color pipeline to include pre- and post-CSC
1D LUT blocks.

SDR planes use a smaller LUT size than HDR planes and therefore
initialize the 1D LUT colorops with the appropriate hardware
capacity.

Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
---
 drivers/gpu/drm/i915/display/intel_color_pipeline.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_color_pipeline.c b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
index 7457fa51cb97..136b9378ca48 100644
--- a/drivers/gpu/drm/i915/display/intel_color_pipeline.c
+++ b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
@@ -15,6 +15,7 @@
 #define MAX_COLOROP 4
 #define PLANE_DEGAMMA_SIZE 128
 #define PLANE_GAMMA_SIZE 32
+#define PLANE_DEGAMMA_SIZE_SDR 32
 
 static const struct drm_colorop_funcs intel_colorop_funcs = {
 	.destroy = intel_colorop_destroy,
@@ -45,7 +46,9 @@ static const enum intel_color_block hdr_plane_pipeline[] = {
 
 static const enum intel_color_block sdr_plane_pipeline[] = {
 	INTEL_PLANE_CB_YUV_RANGE_CORRECT,
+	INTEL_PLANE_CB_PRE_CSC_LUT,
 	INTEL_PLANE_CB_CSC_FF,
+	INTEL_PLANE_CB_POST_CSC_LUT,
 };
 
 static const u64 intel_plane_supported_csc_ff =
@@ -68,8 +71,10 @@ struct intel_colorop *intel_color_pipeline_plane_add_colorop(struct drm_plane *p
 							     enum intel_color_block id)
 {
 	struct drm_device *dev = plane->dev;
+	struct intel_display *display = to_intel_display(dev);
 	struct intel_colorop *colorop;
 	int ret;
+	bool is_hdr = icl_is_hdr_plane(display, to_intel_plane(plane)->id);
 
 	colorop = intel_colorop_create(id);
 
@@ -81,7 +86,9 @@ struct intel_colorop *intel_color_pipeline_plane_add_colorop(struct drm_plane *p
 		ret = drm_plane_colorop_curve_1d_lut_init(dev,
 							  &colorop->base, plane,
 							  &intel_colorop_funcs,
-							  PLANE_DEGAMMA_SIZE,
+							  is_hdr ?
+							  PLANE_DEGAMMA_SIZE :
+							  PLANE_DEGAMMA_SIZE_SDR,
 							  DRM_COLOROP_LUT1D_INTERPOLATION_LINEAR,
 							  DRM_COLOROP_FLAG_ALLOW_BYPASS);
 		break;
-- 
2.25.1

