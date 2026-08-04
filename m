Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863D2C55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 12:55:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C80A10EA38;
	Tue,  4 Aug 2026 12:55:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dL/IwKzA";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F176C10EA38;
 Tue,  4 Aug 2026 12:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785848108; x=1817384108;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VL3AIbXUZrdUX6UIbc8v9xIqF35RdmYM1YCtjZ6UeZs=;
 b=dL/IwKzA82mmgjPLePBeWkImsOFMVk+0dWiV3UHk/2u/OzUE4W3vQnbx
 qXuvPx5YY+v2dixjhuZfI1u86Lrqlx4iCx2AKLUVfgfTJWF5fCnCf2kIC
 pZLYe7aIuS24+LDrzrsKVipYWxYEIVC1gDsj8LsLFCQGTAxWP8Y0pmWe9
 A0ms9fq0seiU+kAZLH5k2iXEb7+R+WXIDYj52Cjv1q7dmuLUtzfFaHyua
 o/OfHANDO9avs32+lbrlKx/Vzt1OVshaYmlqyvRkCb9RSBT76pGb8RV1I
 LeTVPxhVCbRT6SQf3fImSbwzgR5CtJ73O8RR9JxNrBZJ93+Gu+lrMHcnI A==;
X-CSE-ConnectionGUID: yJ9nLKbsTQSMdzQWBFCiwg==
X-CSE-MsgGUID: XRsgUqw6STKMzIG/+rdh4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="90073219"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="90073219"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 05:55:08 -0700
X-CSE-ConnectionGUID: 4S2YGQrKRUGJMP2uOR/5HA==
X-CSE-MsgGUID: kseQVWBfQmO0/NlQ6TxL+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="262108340"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by orviesa009.jf.intel.com with ESMTP; 04 Aug 2026 05:55:06 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>
Subject: [v6 4/9] drm/i915/display: simplify glk_plane_color_ctl_input_csc
Date: Tue,  4 Aug 2026 18:01:02 +0530
Message-ID: <20260804123107.2256124-5-chaitanya.kumar.borah@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260804123107.2256124-1-chaitanya.kumar.borah@intel.com>
References: <20260804123107.2256124-1-chaitanya.kumar.borah@intel.com>
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
index 0234492425d5..73be4c6ff1d3 100644
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
2.50.1

