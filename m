Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52023C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 05:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F85610E788;
	Mon, 13 Jul 2026 05:39:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="I9v/cAkU";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7F9D10E778;
 Mon, 13 Jul 2026 05:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783921167; x=1815457167;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5QZS6Ek0PRHPI+LOFA/iOZPc+q0FKIZOcECepjl2onU=;
 b=I9v/cAkUAYvTbEHRNj1Y3r//1zC+lYGw99N/OD4LFK1sq0EN1MVcditk
 1xV4IB/Tf4Ce1rt7+IxJLSK3I/Dp51tw93ZaCw2F90paXT5nK1lIZaxZp
 EfBg08BqHjwE4jvZrn/wjvl39Na6USBbYgZnS5YkMIjKlVivxUSbqJG+H
 /FVsUuowZnz4zVnsEkc3AO/TJf8CdfWbLtRVIOddEwQFVHcJbZKL1+S5W
 tbZ+1x8mz5w9pOZiBEvlzHjIyne5S8khuOmvt3lZ7/RwgXEHpZhysAwCy
 ZnLxc2yPqTFUnNWLFDN5ycT2IwO3ESshe8tZ52UxqRhjLzPLPTPdqZ8um w==;
X-CSE-ConnectionGUID: 1MLzIbLRR2+yHhW2MiL/gA==
X-CSE-MsgGUID: nJeLfDKgRo+RImlPNwkx8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95669991"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="95669991"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2026 22:39:26 -0700
X-CSE-ConnectionGUID: QuB2vRvfSlOgzvatQYApqg==
X-CSE-MsgGUID: +4dsZWi+Q4a6q+w5W77GqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="252066317"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by fmviesa007.fm.intel.com with ESMTP; 12 Jul 2026 22:39:25 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>
Subject: [CI v4 04/14] drm/i915/display: simplify glk_plane_color_ctl_input_csc
Date: Mon, 13 Jul 2026 10:45:06 +0530
Message-Id: <20260713051516.4087420-5-chaitanya.kumar.borah@intel.com>
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

Add early return for non-YUV formats and hoist the duplicated
color_range check out of the if/else branches. No functional change.

Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
---
 drivers/gpu/drm/i915/display/skl_universal_plane.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers/gpu/drm/i915/display/skl_universal_plane.c
index 50c6ceef9b9a..da2df5be9848 100644
--- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
+++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
@@ -1247,7 +1247,10 @@ static u32 glk_plane_color_ctl_input_csc(const struct intel_plane_state *plane_s
 	struct intel_plane *plane = to_intel_plane(plane_state->uapi.plane);
 	u32 ctl = 0;
 
-	if (fb->format->is_yuv && !icl_is_hdr_plane(display, plane->id)) {
+	if (!fb->format->is_yuv)
+		return 0;
+
+	if (!icl_is_hdr_plane(display, plane->id)) {
 		switch (plane_state->hw.color_encoding) {
 		case DRM_COLOR_YCBCR_BT709:
 			ctl |= PLANE_COLOR_CSC_MODE_YUV709_TO_RGB709;
@@ -1258,14 +1261,13 @@ static u32 glk_plane_color_ctl_input_csc(const struct intel_plane_state *plane_s
 		default:
 			ctl |= PLANE_COLOR_CSC_MODE_YUV601_TO_RGB601;
 		}
-		if (plane_state->hw.color_range == DRM_COLOR_YCBCR_FULL_RANGE)
-			ctl |= PLANE_COLOR_YUV_RANGE_CORRECTION_DISABLE;
-	} else if (fb->format->is_yuv) {
+	} else {
 		ctl |= PLANE_COLOR_INPUT_CSC_ENABLE;
-		if (plane_state->hw.color_range == DRM_COLOR_YCBCR_FULL_RANGE)
-			ctl |= PLANE_COLOR_YUV_RANGE_CORRECTION_DISABLE;
 	}
 
+	if (plane_state->hw.color_range == DRM_COLOR_YCBCR_FULL_RANGE)
+		ctl |= PLANE_COLOR_YUV_RANGE_CORRECTION_DISABLE;
+
 	return ctl;
 }
 
-- 
2.25.1

