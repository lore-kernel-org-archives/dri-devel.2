Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79628FD5F9D
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 08:57:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C61D810E5A9;
	Wed,  8 Apr 2026 08:57:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dDzv/mP5";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30F8610E5A3;
 Wed,  8 Apr 2026 08:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775638663; x=1807174663;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XjDIcelhTBrb67a2mZBXv/6E7BGm3pawrsiQbz/4hlI=;
 b=dDzv/mP5fDK/SGGrhRO5JHxeBzrM9jIi4bGTp1Yiie39Buw/lj3iQ/aH
 SdE1fRhq9cN10NxM7RfXw0/Zcny2Mm8WoMh/uMkaP8wI5mg88+48hBdiY
 Kai8Y6woI4P0cvhWi2qm3L6DvQ4dNUOp4rrI7i4yTUygH/391isx4R+uj
 tCv9Oai4YXAiyQp0DJncyS2aD1s3+EUFhiQJh8RF7Z/E0KtZOH5kxFPIS
 9ib7pJvkizrvv6kVEKDgxdwVM20/fAZjV7enUTdMwQKKbHf9vh2noNDhk
 BFf7Y7kq3pzL33IluFTv14lWa2sSaTkrw5eLef7yRJEc29ODHqwkG8qWi g==;
X-CSE-ConnectionGUID: lDPA+WOzTvC91a3tgqnTBQ==
X-CSE-MsgGUID: Pt2kF03TSSizEuztItSYLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76516591"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="76516591"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 01:57:42 -0700
X-CSE-ConnectionGUID: PjC9KYshTEGQ5uohULifgw==
X-CSE-MsgGUID: LLwLAb/aRE25S00Qf86DCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="227572448"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 01:57:40 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jouni.hogander@intel.com,
 animesh.manna@intel.com, Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 02/26] drm/dp: Clean up DPRX feature enumeration macros
Date: Wed,  8 Apr 2026 14:12:14 +0530
Message-ID: <20260408084239.1295325-3-ankit.k.nautiyal@intel.com>
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

Align the DP_DPRX feature enumeration macros for better readability and
consistency, and use the BIT() macro instead of open-coded shifts.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 include/drm/display/drm_dp.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
index 4ea3b5b08a12..49f0154eb93c 100644
--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -1202,10 +1202,10 @@
 # define DP_DPRX_SLEEP_WAKE_TIMEOUT_PERIOD_80_MS	0x04
 # define DP_DPRX_SLEEP_WAKE_TIMEOUT_PERIOD_100_MS	0x05
 
-#define DP_DPRX_FEATURE_ENUMERATION_LIST_CONT_1         0x2214 /* 2.0 E11 */
-# define DP_ADAPTIVE_SYNC_SDP_SUPPORTED    (1 << 0)
-# define DP_AS_SDP_FIRST_HALF_LINE_OR_3840_PIXEL_CYCLE_WINDOW_NOT_SUPPORTED (1 << 1)
-# define DP_VSC_EXT_SDP_FRAMEWORK_VERSION_1_SUPPORTED  (1 << 4)
+#define DP_DPRX_FEATURE_ENUMERATION_LIST_CONT_1					0x2214 /* 2.0 E11 */
+# define DP_ADAPTIVE_SYNC_SDP_SUPPORTED						BIT(0)
+# define DP_AS_SDP_FIRST_HALF_LINE_OR_3840_PIXEL_CYCLE_WINDOW_NOT_SUPPORTED	BIT(1)
+# define DP_VSC_EXT_SDP_FRAMEWORK_VERSION_1_SUPPORTED				BIT(4)
 
 #define DP_128B132B_SUPPORTED_LINK_RATES       0x2215 /* 2.0 */
 # define DP_UHBR10                             (1 << 0)
-- 
2.45.2

