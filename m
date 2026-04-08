Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CEFFD5F7C
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 05:40:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E84710E50C;
	Wed,  8 Apr 2026 05:40:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="griRlvHK";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEC6410E50C;
 Wed,  8 Apr 2026 05:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775626817; x=1807162817;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+07uVr6wYL4crDoDPpUepBx/Y/Umn4vPjRKYTeBwlqY=;
 b=griRlvHKPF/xkFBdaylMI+KK23tk3+L8qB1RKnJSvpuvy0nrGw5+ULYL
 FJPZBFPqSYfgMk4Wuvc479UvZDez2deSzgB/d+RjrpZaQBiLLNhg22UZ8
 9wFYFGT1qFS3KGaBZf4NwD/fJRGd8oIMvYebmzn5CMxp2K67RSpMacI3x
 woeKyPqOdjOBhCmlH0qH4hW7cJuX8L+Pa4+3HO4QugDrMEJX6KBlFlXFx
 e7ZSGVY6HDB8HBE9dP4yDKb3JhbdTxgMvQpM5xRlegZLXsqKp8AS+0Ic7
 Nh90DUCWOzVif8wCu6gNlJNkotQt8rho1/NpHb5k3CgQW8Vg0GWeiwVZ0 g==;
X-CSE-ConnectionGUID: guXTuyk9RMCbbNrz6ozGiw==
X-CSE-MsgGUID: c+q6nfjYSfGXIuDbleYzxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="80194885"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="80194885"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 22:40:17 -0700
X-CSE-ConnectionGUID: i97B5+aiQXeUo1TD5rFmJA==
X-CSE-MsgGUID: UpduDT4xTOyBQIU8TxRpQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="251517998"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by fmviesa002.fm.intel.com with ESMTP; 07 Apr 2026 22:40:12 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: harry.wentland@amd.com, louis.chauvet@bootlin.com, mwen@igalia.com,
 contact@emersion.fr, alex.hung@amd.com, daniels@collabora.com,
 uma.shankar@intel.com, maarten.lankhorst@intel.com,
 pekka.paalanen@collabora.com, pranay.samala@intel.com,
 swati2.sharma@intel.com, chaitanya.kumar.borah@intel.com
Subject: [PATCH v2 04/13] drm/i915/color: Add support for 1D LUT in SDR planes
Date: Wed,  8 Apr 2026 10:45:05 +0530
Message-Id: <20260408051514.608781-5-chaitanya.kumar.borah@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260408051514.608781-1-chaitanya.kumar.borah@intel.com>
References: <20260408051514.608781-1-chaitanya.kumar.borah@intel.com>
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
---
 drivers/gpu/drm/i915/display/intel_color_pipeline.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_color_pipeline.c b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
index 49c621d1bf22..20f5e0e83496 100644
--- a/drivers/gpu/drm/i915/display/intel_color_pipeline.c
+++ b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
@@ -15,6 +15,7 @@
 #define MAX_COLOROP 4
 #define PLANE_DEGAMMA_SIZE 128
 #define PLANE_GAMMA_SIZE 32
+#define PLANE_DEGAMMA_SIZE_SDR 32
 
 static const struct drm_colorop_funcs intel_colorop_funcs = {
 	.destroy = intel_colorop_destroy,
@@ -44,7 +45,9 @@ static const enum intel_color_block hdr_plane_pipeline[] = {
 };
 
 static const enum intel_color_block sdr_plane_pipeline[] = {
+	INTEL_PLANE_CB_PRE_CSC_LUT,
 	INTEL_PLANE_CB_CSC_FF,
+	INTEL_PLANE_CB_POST_CSC_LUT,
 };
 
 static const u64 intel_plane_supported_csc_ff =
@@ -67,8 +70,10 @@ struct intel_colorop *intel_color_pipeline_plane_add_colorop(struct drm_plane *p
 							     enum intel_color_block id)
 {
 	struct drm_device *dev = plane->dev;
+	struct intel_display *display = to_intel_display(dev);
 	struct intel_colorop *colorop;
 	int ret;
+	bool is_hdr = icl_is_hdr_plane(display, to_intel_plane(plane)->id);
 
 	colorop = intel_colorop_create(id);
 
@@ -80,7 +85,9 @@ struct intel_colorop *intel_color_pipeline_plane_add_colorop(struct drm_plane *p
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

