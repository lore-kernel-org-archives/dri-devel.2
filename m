Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39595606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QikNuVoO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 698CD10E967;
	Mon, 26 Oct 2026 05:40:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19D4010E95E;
 Mon, 26 Oct 2026 05:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792993219; x=1824529219;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tAY7yuABVsYOwrAejFIHwx5gGpAfOUVBL1hiFIDSjTc=;
 b=QikNuVoOvrrpdtrN4/IokXU4B4BPRMHHrAoYbcNghnrBUCOCqBHydbzc
 PRh+zf3qsQ5j6dLf81UQbu2Toha6tEMPiDmyOE41nnZThRbmD/Lup0/s+
 P2SoUssyasslZXSVKlhF2QHfXbt6OjradjmWeMPzo8EEfKEINCV0bCNEn
 HaJ/IryR1V6XRoqFcbT+ZZg/DZpL5rjM8EAFSUuN4oHbMpf0m948LoFYa
 ktuealALOy4rC5zTZy1MjlJnvhoGc8+kU8grC0G4f2je3xnyvFssYCFyL
 QO4MUdD5+FYGSZ4pihICM7nED2puU6N/c99xZXm1WIrzmdGiWSO4s1Onc Q==;
X-CSE-ConnectionGUID: curI/6onSbeeySwr3i8qxg==
X-CSE-MsgGUID: RLPd1jrDTgWvpG8FW0dQiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1550159"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1550159"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2026 22:40:19 -0700
X-CSE-ConnectionGUID: Xq/84vleT7qZMXXdtm6WfA==
X-CSE-MsgGUID: ZqBAAy+nRuiyT6lwePA+WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="6001840"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa013.fm.intel.com with ESMTP; 25 Oct 2026 22:40:17 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v7 02/20] drm/dp: Add DPCD definitions for DP2.1 ALPM
 capability
Date: Mon, 26 Oct 2026 11:09:13 +0530
Message-ID: <20261026054001.799894-3-animesh.manna@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026054001.799894-1-animesh.manna@intel.com>
References: <20261026054001.799894-1-animesh.manna@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the LTTPR ALPM capabilities register (0xf0009) with the AUX-less
ALPM supported bit, and the total LTTPR count register (0xf000a), both
added in DP2.1. They are needed to enable DP2.1 ALPM with LTTPRs.

Extend DP_LTTPR_COMMON_CAP_SIZE from 8 to 10 so that the LTTPR ALPM
capability is read as part of the LTTPR common capabilities. This makes
drm_dp_read_lttpr_common_caps() read two more bytes for all its users,
DP_PHY_REPEATER_EQ_DONE (0xf0008) and DP_LTTPR_ALPM_CAPABILITIES
(0xf0009). The existing helpers don't use these bytes.

v2: Add DP_LTTPR_AUX_LESS_ALPM_SUPPORTED bit definition.
v3: Use drm/dp prefix and describe the DP_LTTPR_COMMON_CAP_SIZE change.

Cc: Jouni Högander <jouni.hogander@intel.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 include/drm/display/drm_dp.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
index e63c7f075f54..ea8cd497b658 100644
--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -1541,6 +1541,9 @@
 /* See DP_128B132B_SUPPORTED_LINK_RATES for values */
 #define DP_PHY_REPEATER_128B132B_RATES			    0xf0007 /* 2.0 */
 #define DP_PHY_REPEATER_EQ_DONE                             0xf0008 /* 2.0 E11 */
+#define DP_LTTPR_ALPM_CAPABILITIES                          0xf0009 /* 2.1 */
+# define DP_LTTPR_AUX_LESS_ALPM_SUPPORTED                   (1 << 0)
+#define DP_TOTAL_LTTPR_CNT                                  0xf000a /* 2.1 */
 
 enum drm_dp_phy {
 	DP_PHY_DPRX,
@@ -1720,7 +1723,7 @@ enum drm_dp_phy {
 #define DP_DSC_BRANCH_CAP_SIZE		3
 #define EDP_PSR_RECEIVER_CAP_SIZE	2
 #define EDP_DISPLAY_CTL_CAP_SIZE	5
-#define DP_LTTPR_COMMON_CAP_SIZE	8
+#define DP_LTTPR_COMMON_CAP_SIZE	10
 #define DP_LTTPR_PHY_CAP_SIZE		3
 
 #define DP_SDP_AUDIO_TIMESTAMP		0x01
-- 
2.43.0

