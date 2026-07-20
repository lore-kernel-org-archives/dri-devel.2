Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A991C44525
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 05:15:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC50A10E65A;
	Mon, 20 Jul 2026 05:15:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HYjwFmEd";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EFF710E660;
 Mon, 20 Jul 2026 05:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784524544; x=1816060544;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9QCrdA7qXHgparRRakYJ2WOmTI06irQWkFfcu76ga5s=;
 b=HYjwFmEdoNQgkMAL83AtblmDfbzxoqr29Ut84y3KWasvhUZKUtNIOLUc
 L5gdg+BWKpMqA33V3m4Nzkka9ZWBFKvyUKfKCgd3BlTtx8e13WEWoSMDh
 0yP/y1khQLfJJ3zsDjSFoW6yHPyo9utyCfBsru32HSeRXv/Ux96cMjvBT
 1aom0yITd6qjv1dJsSx2ibvSRA8vN/n0Xfpp5GwwoXlkby10RLxRbt1tO
 RCHqx5Cj4xZMciSah7NqhxznyajyXAOZIhJPGQASMRLRD51k3QdQlEC1N
 fhW1++EofA/RoO4Dr3qoNqNbm2x7cdlb6mlLYm1TGI8aN9ayjn8/+vjdO Q==;
X-CSE-ConnectionGUID: n5Jl8WgZQ6yKXXuvcmxvvw==
X-CSE-MsgGUID: OoySdJoXS7yOOe6zAP8WSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85133407"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="85133407"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2026 22:15:40 -0700
X-CSE-ConnectionGUID: uwtd+7rXSDSj3UiT93IR2A==
X-CSE-MsgGUID: qY9B0f5JQFW6P1MQBYUxSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="257419787"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by orviesa007.jf.intel.com with ESMTP; 19 Jul 2026 22:15:40 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>
Subject: [v5 04/14] drm/i915/display: simplify glk_plane_color_ctl_input_csc
Date: Mon, 20 Jul 2026 10:21:21 +0530
Message-Id: <20260720045131.971650-5-chaitanya.kumar.borah@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260720045131.971650-1-chaitanya.kumar.borah@intel.com>
References: <20260720045131.971650-1-chaitanya.kumar.borah@intel.com>
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
index f831c1958ff4..e09743179c0c 100644
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

