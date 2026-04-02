Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A002CC6B2E
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 08:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 506E910F08D;
	Thu,  2 Apr 2026 08:19:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="P/3rs9Y7";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1107310F09C;
 Thu,  2 Apr 2026 08:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775117980; x=1806653980;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XjDIcelhTBrb67a2mZBXv/6E7BGm3pawrsiQbz/4hlI=;
 b=P/3rs9Y7G2UBvkOC3/rvyDe8M0At5lKi981+75X57IvX5Ux7tCTomwA4
 HSCXwcVA1mT5xlpq6CDhfLr6KLNHCQPlsfOyigk6OrZDjuiYkcp071soX
 wsWYlG5b5Ga+jkMaeZJ5/okCmw/p58NJ2WRLZWG6lIb7oyLG3MXEDTtJf
 YGysvPDTT+pqr8mdS5QDuV73moaLhpCRFQTbAqELympUWdJ5MXadTGBkG
 7lRfP0vCeQhVxFwDjrGcb6T/tTGxiX/RA3uM89BLz61+NQqQyuGufXcMJ
 dvvjA10cn1pVrjt7wQodP9xmO45PEHE2cSN2w2pZ0b4tG4ff3vCl66klT g==;
X-CSE-ConnectionGUID: NMABQNFTSyyO/wr0NADiUQ==
X-CSE-MsgGUID: 5qkwkygiTES8uA2hYdeBAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="80060384"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="80060384"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 01:19:40 -0700
X-CSE-ConnectionGUID: VSIhldLnRQ+p0snPm5k9qg==
X-CSE-MsgGUID: jDoB9PEBTqC8pfw8zjVm2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="226776104"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 01:19:38 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jouni.hogander@intel.com,
 animesh.manna@intel.com, Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 02/23] drm/dp: Clean up DPRX feature enumeration macros
Date: Thu,  2 Apr 2026 13:34:02 +0530
Message-ID: <20260402080425.548702-3-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260402080425.548702-1-ankit.k.nautiyal@intel.com>
References: <20260402080425.548702-1-ankit.k.nautiyal@intel.com>
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

