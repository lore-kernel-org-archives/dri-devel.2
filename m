Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FB4FF493F
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 04:22:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18E4710E291;
	Mon, 30 Mar 2026 04:22:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fTPNp45K";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDABB10E263;
 Mon, 30 Mar 2026 04:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774844522; x=1806380522;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0pawYva8l7qMOCH5aJFQdVWxW1YkP3xFfMAP6sK7gaY=;
 b=fTPNp45K4EeYz1zwkrMLxdhTBqQauCk7A7XD0/j0iunZsbDEZg0QwnUo
 y0s2DoBlbnLrbLw1VzCTEte2C4x2M0HA0uNuK+R/eh4dySEpjV/JNHJ4o
 1DUSgKgGyLJUrdh80PR4Xa2PpM2ilJeBG7uf/1fNkg361Ojajh70jrg07
 k+Y1EO/yAUdjV8y4/3aqOWbx3dS+dY7aAxx6f7nyFoZ99ZDkvBphL3NDR
 rRObkZSujnrbsv1UO/JOqGUsdhtTPpx9bMZpdoZ3V//yB9SiBVqOKRTYr
 j5se/8DawaKEMjuZkhOs604DuQyPdXw8DU8ytWDnQhDiwSxBY5EhClJ35 A==;
X-CSE-ConnectionGUID: kRyCGiCdRiWvVGfoToZI8Q==
X-CSE-MsgGUID: XtGrZgIrS2OajvcohkaDlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="87218211"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="87218211"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 21:22:01 -0700
X-CSE-ConnectionGUID: Q8Cq+BISTTijZq2pycspIg==
X-CSE-MsgGUID: /znD+QPBTgaMBYG8dVRQNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="263871032"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 21:21:59 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jouni.hogander@intel.com,
 animesh.manna@intel.com, Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 01/19] drm/dp: Rename and relocate AS SDP payload field masks
Date: Mon, 30 Mar 2026 09:36:38 +0530
Message-ID: <20260330040656.4116502-2-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260330040656.4116502-1-ankit.k.nautiyal@intel.com>
References: <20260330040656.4116502-1-ankit.k.nautiyal@intel.com>
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

