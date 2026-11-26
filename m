Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BE8606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CxpJT/8T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1CCB11216A;
	Thu, 26 Nov 2026 08:40:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12C6710E27B;
 Thu, 26 Nov 2026 08:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795682427; x=1827218427;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=uefqFL6syJ7U25C4O1frL407UHxl5H7D28v6/DZbwPc=;
 b=CxpJT/8TvnsbIV5QEivYtuTt7El4WarQvnYkYKxJt7BBJAZ+ioH0rqY6
 Pi7VikPkYkPANAeBG/lUa/isZLC+YTYhRIybXL4V/DAapEK0/zHgJU76k
 pibl4nbvX6omerDKVhrcDBGTi6ZD15mqWKTSkngYE8C5mr/NFe967WCu7
 I9AUBYhCQiawE3QBD4ApCHKWwRMSiE2H6Oumma3zwiaEiMW0UwF+AnAuA
 klfXM/6iGvLwVUJGL5s0EiGDJ9VJs1c6oLhZx/uTmMdcaPfD+/3EBi1/5
 mjffB8KUeXJ3D30bNnNmZIVBjrZ8mC8vOHadLD4ySFUAD9dwh1fuAzygx g==;
X-CSE-ConnectionGUID: FUTPv1QsT8uZI5wikKECfQ==
X-CSE-MsgGUID: ihCNn7JWQbmLe20bTTUcUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4488541"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4488541"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 00:40:27 -0800
X-CSE-ConnectionGUID: uwz4DViuQH+UVM0fn97rDQ==
X-CSE-MsgGUID: 3Ik+IUJIS4yJeDPHadp3fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; d="scan'208";a="12125695"
Received: from srr4-3-linux-106-armuthy.iind.intel.com ([10.190.238.56])
 by orviesa007.jf.intel.com with ESMTP; 26 Nov 2026 00:40:22 -0800
From: Arun R Murthy <arun.r.murthy@intel.com>
Date: Thu, 26 Nov 2026 14:05:00 +0530
Subject: [PATCH v6 05/13] drm/dp: Add the DPCD definitions of the Rx
 minimum Hblank
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-vlk-64036-dp-symbol-tg-v6-5-835a4f5c0a12@intel.com>
References: <20261126-vlk-64036-dp-symbol-tg-v6-0-835a4f5c0a12@intel.com>
In-Reply-To: <20261126-vlk-64036-dp-symbol-tg-v6-0-835a4f5c0a12@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
 chaitanya.kumar.borah@intel.com, uma.shankar@intel.com, 
 suraj.kandpal@intel.com, Arun R Murthy <arun.r.murthy@intel.com>
X-Mailer: b4 0.15-dev
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the DPCD registers with which an Rx enumerates its minimum Hblank
requirement, in link layer symbol cycles, for 8b/10b and 128b/132b.

Signed-off-by: Arun R Murthy <arun.r.murthy@intel.com>
---
 include/drm/display/drm_dp.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
index e63c7f075f54c09d66bb1f9e97ac28db20f4f176..1e9b673d606924bbd1774e1f7590d10482829369 100644
--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -1224,6 +1224,11 @@
 # define DP_AS_SDP_FAVT_PAYLOAD_FIELDS_PARSING_SUPPORTED			BIT(2) /* 2.1 */
 # define DP_VSC_EXT_SDP_FRAMEWORK_VERSION_1_SUPPORTED				BIT(4)
 
+#define DP_RX_MIN_HBLANK_8B10B				0x221a /* 2.1 */
+#define DP_RX_MIN_HBLANK_128B132B			0x221b /* 2.1 */
+# define DP_RX_MIN_HBLANK_MASK				0x0f
+# define DP_RX_MIN_HBLANK_ENABLE			BIT(4)
+
 #define DP_128B132B_SUPPORTED_LINK_RATES       0x2215 /* 2.0 */
 # define DP_UHBR10                             (1 << 0)
 # define DP_UHBR20                             (1 << 1)

-- 
2.25.1

