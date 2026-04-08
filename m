Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73027FD5F99
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 08:57:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C12B910E5A2;
	Wed,  8 Apr 2026 08:57:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="D21sd7uu";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D646710E59F;
 Wed,  8 Apr 2026 08:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775638661; x=1807174661;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0pawYva8l7qMOCH5aJFQdVWxW1YkP3xFfMAP6sK7gaY=;
 b=D21sd7uu9iqvBBFoRPyNjfgr1rdIflZJ5YXB92T3Dnt8kXw1JtMI0qYH
 q43EIyPmJCw2I7Me500vdufSUfpVjG6jkiBOeONbOflEm55koJg/YCd5V
 Y88VyDQ5PR6VmdjzTmG6WFS6NR7TZLxJgMCtzJxZaqQuae21FrBTcnY3C
 juFhI6W+CQ1SNCo39nDxbiHl+t0mmALr0MrPgGHGVSeEDAgaeJawf0fLK
 dnp/vF0H1V+UxYkqwsjLxOEhk9XJveOy36eC7Z0rtNo0688eIUbJ53CVc
 JtOW2l9VUCFyQrgJIl5p0m0e5MUC7dirgldhx0Al7T5S0QQULNyVBQRZU Q==;
X-CSE-ConnectionGUID: 9880UhauQXyVvFYUcR3ChQ==
X-CSE-MsgGUID: 5bau1+ecSdWU4Hn2GjutRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76516585"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="76516585"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 01:57:41 -0700
X-CSE-ConnectionGUID: iPM9DNFHRWuzAiDgcxDmhA==
X-CSE-MsgGUID: 0V/1j6JTTPetOYnQGuu2fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="227572436"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 01:57:38 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jouni.hogander@intel.com,
 animesh.manna@intel.com, Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 01/26] drm/dp: Rename and relocate AS SDP payload field masks
Date: Wed,  8 Apr 2026 14:12:13 +0530
Message-ID: <20260408084239.1295325-2-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260408084239.1295325-1-ankit.k.nautiyal@intel.com>
References: <20260408084239.1295325-1-ankit.k.nautiyal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The AS SDP payload field masks were misnamed and placed under the DPRX
feature enumeration list. These are not DPRX capability bits, but are
payload field masks for the Adaptive Sync SDP.

Relocate both masks next to the AS SDP definitions.
Update users to the corrected names. No functional change.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 4 ++--
 include/drm/display/drm_dp.h            | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 4955bd8b11d7..602efaf500bd 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -5295,8 +5295,8 @@ int intel_dp_as_sdp_unpack(struct drm_dp_as_sdp *as_sdp,
 	if ((sdp->sdp_header.HB3 & 0x3F) != 9)
 		return -EINVAL;
 
-	as_sdp->length = sdp->sdp_header.HB3 & DP_ADAPTIVE_SYNC_SDP_LENGTH;
-	as_sdp->mode = sdp->db[0] & DP_ADAPTIVE_SYNC_SDP_OPERATION_MODE;
+	as_sdp->length = sdp->sdp_header.HB3 & DP_AS_SDP_LENGTH_MASK;
+	as_sdp->mode = sdp->db[0] & DP_AS_SDP_OPERATION_MODE_MASK;
 	as_sdp->vtotal = (sdp->db[2] << 8) | sdp->db[1];
 	as_sdp->target_rr = (u64)sdp->db[3] | ((u64)sdp->db[4] & 0x3);
 	as_sdp->target_rr_divider = sdp->db[4] & 0x20 ? true : false;
diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
index 8b15d3eeb716..4ea3b5b08a12 100644
--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -1204,8 +1204,6 @@
 
 #define DP_DPRX_FEATURE_ENUMERATION_LIST_CONT_1         0x2214 /* 2.0 E11 */
 # define DP_ADAPTIVE_SYNC_SDP_SUPPORTED    (1 << 0)
-# define DP_ADAPTIVE_SYNC_SDP_OPERATION_MODE		GENMASK(1, 0)
-# define DP_ADAPTIVE_SYNC_SDP_LENGTH				GENMASK(5, 0)
 # define DP_AS_SDP_FIRST_HALF_LINE_OR_3840_PIXEL_CYCLE_WINDOW_NOT_SUPPORTED (1 << 1)
 # define DP_VSC_EXT_SDP_FRAMEWORK_VERSION_1_SUPPORTED  (1 << 4)
 
@@ -1870,4 +1868,7 @@ enum operation_mode {
 	DP_AS_SDP_FAVT_TRR_REACHED = 0x03
 };
 
+#define DP_AS_SDP_OPERATION_MODE_MASK	GENMASK(1, 0)
+#define DP_AS_SDP_LENGTH_MASK		GENMASK(5, 0)
+
 #endif /* _DRM_DP_H_ */
-- 
2.45.2

