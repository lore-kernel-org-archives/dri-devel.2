Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FDCFF4943
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 04:22:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3552A10E2A0;
	Mon, 30 Mar 2026 04:22:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CpKen0i0";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4776410E2A0;
 Mon, 30 Mar 2026 04:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774844529; x=1806380529;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WbWi6PwBUWyF29gRl4R64Pp34kqEchhuYA4bCxBUp3Y=;
 b=CpKen0i08cS4U0QShjQBF1naltB7TPh07Y2dSxPmduWO7x6JP0zUoThq
 PDUYULimI8Q3ABXTYI/CfxQIKR3q/Kcq9k4Z5jt3gaXG28/GL3e9ahZ+e
 bIP0lmHT2vbtDsWgWQdppvk5TYjhVfFBvWs7nz3VMk/N9OPNb7MBy1pgX
 xpX9jnoNxEydAaR+BNVTOE+/TKKQEr5SecJWvpo1dorZJv9ZPgz3H7HMZ
 e2BVLqWAevXkdev4BQl30cJWP7pFIX7prDt95pT+Zb6SudlpFWJ9kHCUS
 eRjb+58Gs2ui3xoiDkEYL0S/UgN/ngOlqVL3ZiLCaw5hNNIoVivdX/rWV Q==;
X-CSE-ConnectionGUID: qO6g7lJkRISOA0nlIzFrbw==
X-CSE-MsgGUID: 6bCYRSg4T2my3vRARAnolQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="87218223"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="87218223"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 21:22:09 -0700
X-CSE-ConnectionGUID: zgrYyYMyQdmMxBQafOeZ7A==
X-CSE-MsgGUID: R7R9/jQmT0GWmdYbUdaIPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="263871119"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 21:22:07 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jouni.hogander@intel.com,
 animesh.manna@intel.com, Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 04/19] drm/dp: Add DPCD for configuring AS SDP for PR + VRR
Date: Mon, 30 Mar 2026 09:36:41 +0530
Message-ID: <20260330040656.4116502-5-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260330040656.4116502-1-ankit.k.nautiyal@intel.com>
References: <20260330040656.4116502-1-ankit.k.nautiyal@intel.com>
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

Add additional DPCDs required to be configured to support VRR with Panel
Replay. These DPCDs are specifically required for configuring Adaptive Sync
SDP and are introduced in DP v2.1.

v2:
 - Correct the shift for the bits. (Ville)
 - Add DP_PR_ prefix for the PR-related fields.
v3:
 - Use macro values in their shifted form to match the convention (Ville)

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 include/drm/display/drm_dp.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
index 8d172863eba3..93a188113d36 100644
--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -775,6 +775,11 @@
 # define DP_PANEL_REPLAY_SU_Y_GRANULARITY_EXTENDED_VAL_SEL_MASK  (0xf << 3)
 # define DP_PANEL_REPLAY_SU_REGION_SCANLINE_CAPTURE		 (1 << 7)
 
+#define PANEL_REPLAY_CONFIG3				0x11a /* DP 2.1 */
+# define DP_PR_AS_SDP_SETUP_TIME_T1			(0 << 6)
+# define DP_PR_AS_SDP_SETUP_TIME_DYNAMIC		(1 << 6) /* DP 2.1 Table 2-227 */
+# define DP_PR_AS_SDP_SETUP_TIME_T2			(2 << 6)
+
 #define DP_PAYLOAD_ALLOCATE_SET		    0x1c0
 #define DP_PAYLOAD_ALLOCATE_START_TIME_SLOT 0x1c1
 #define DP_PAYLOAD_ALLOCATE_TIME_SLOT_COUNT 0x1c2
-- 
2.45.2

