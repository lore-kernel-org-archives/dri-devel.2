Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71115C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:39:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6345E10E622;
	Tue, 15 Sep 2026 18:39:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mHp+JmX1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5E0310E57E;
 Tue, 15 Sep 2026 18:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789497540; x=1821033540;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UYT03MiDA42QaMw3IlH/vQki8FmgSXHwpZDoyI0fSRw=;
 b=mHp+JmX1GPD96DzHH1rf8AYvOJzGo425Z/2YicqMUSdvdFWTBzf8bTLi
 VKyfXlvlLz4Uq26N6srZbRfp3EGK2e7zA34s258KNhNU/Rp9a9dTe3cEa
 ZmhoQRa5dzNLaJPpfz0x71lGfN1ApBdntSsJbwsDK1au5gbL4b7Ybnk6G
 RTZnm5wVdtcDT3C3Vdz+VNxo0QkDzffzR+vIvCdMcN2OOtJ2MMTpwPpwL
 kInY24Uzbt++PyHhEd3XnpHGmz4cZxmriqYUO3D1D7mLDVkFjQkxcEKkf
 05YUz3c8usy60ZV+edLy+4s2MD9oWfRrsNIkaAn8Nul8UpRAJx/8KBYog Q==;
X-CSE-ConnectionGUID: M7qfVPLITSqouL2t+ct2xw==
X-CSE-MsgGUID: dlgYUF3HT06qmP6UYlkVmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92380257"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="92380257"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 11:39:00 -0700
X-CSE-ConnectionGUID: i8jgcedlRQGby7OaFPfoZg==
X-CSE-MsgGUID: 7PtwZA+jSuyXYEOLkghUTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="298148446"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa001.fm.intel.com with ESMTP; 15 Sep 2026 11:38:57 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v6 01/18] drm/i915/alpm: Add DPCD definition for DP2.1 ALPM
 capability
Date: Tue, 15 Sep 2026 23:34:32 +0530
Message-Id: <20260915180449.277933-2-animesh.manna@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20260915180449.277933-1-animesh.manna@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
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

Add required DPCD address which will be needed to enable DP2.1 ALPM.

Cc: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 include/drm/display/drm_dp.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
index e63c7f075f54..9f1e9ef5cdb6 100644
--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -1541,6 +1541,8 @@
 /* See DP_128B132B_SUPPORTED_LINK_RATES for values */
 #define DP_PHY_REPEATER_128B132B_RATES			    0xf0007 /* 2.0 */
 #define DP_PHY_REPEATER_EQ_DONE                             0xf0008 /* 2.0 E11 */
+#define DP_LTTPR_ALPM_CAPABILITIES                          0xf0009 /* 2.1 */
+#define DP_TOTAL_LTTPR_CNT                                  0xf000a /* 2.1 */
 
 enum drm_dp_phy {
 	DP_PHY_DPRX,
@@ -1720,7 +1722,7 @@ enum drm_dp_phy {
 #define DP_DSC_BRANCH_CAP_SIZE		3
 #define EDP_PSR_RECEIVER_CAP_SIZE	2
 #define EDP_DISPLAY_CTL_CAP_SIZE	5
-#define DP_LTTPR_COMMON_CAP_SIZE	8
+#define DP_LTTPR_COMMON_CAP_SIZE	10
 #define DP_LTTPR_PHY_CAP_SIZE		3
 
 #define DP_SDP_AUDIO_TIMESTAMP		0x01
-- 
2.29.0

