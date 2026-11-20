Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26435606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 05:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N7p2JAdm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 588C110FBB6;
	Fri, 20 Nov 2026 05:11:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F409510ECCF;
 Fri, 20 Nov 2026 05:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795151497; x=1826687497;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=uefqFL6syJ7U25C4O1frL407UHxl5H7D28v6/DZbwPc=;
 b=N7p2JAdmFJDw1VDk/X+nANpNbggPbrocYyz7/iogRS7KSnCH0DeujNYQ
 dB91BJZKA5uknFUup+7eJ554x/Uaqtva2jMWwDR985QXx9TQy8W2GwgAS
 TBQwjrGIYfb8KJGGQMicCrmQ0O7xzvTL9ullbOhtTHLyau1qRjGzppzV9
 Dat/iacvkt7q3mJEhrSYEy3CumJ+zHhvaKYU+hkD8A7caHu8WL4bCSJYi
 9HlGrZRB+7EPpMvGOpJogTwEbUA2pAPndaR1ReVAR+adYZnPXd04TNGx6
 hrIiaWJ4cWnz4pWNIgmQiOg7duvQxZFoVlS3fhgGdZGMRwUbKO5JdfaWF w==;
X-CSE-ConnectionGUID: DSgktPz7RLGF7WOcUQmEIQ==
X-CSE-MsgGUID: jdMfwGUNT/W7bsin+Q753Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3907440"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3907440"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 21:11:37 -0800
X-CSE-ConnectionGUID: POmSn1NnRsmMmQVEYBjWww==
X-CSE-MsgGUID: qaGwO5xWQdq9RWtl4ZFcvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; d="scan'208";a="10607131"
Received: from srr4-3-linux-106-armuthy.iind.intel.com ([10.190.238.56])
 by fmviesa004.fm.intel.com with ESMTP; 19 Nov 2026 21:11:34 -0800
From: Arun R Murthy <arun.r.murthy@intel.com>
Date: Fri, 20 Nov 2026 10:36:04 +0530
Subject: [PATCH v5 05/13] drm/dp: Add the DPCD definitions of the Rx
 minimum Hblank
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-vlk-64036-dp-symbol-tg-v5-5-bf8f78b32709@intel.com>
References: <20261120-vlk-64036-dp-symbol-tg-v5-0-bf8f78b32709@intel.com>
In-Reply-To: <20261120-vlk-64036-dp-symbol-tg-v5-0-bf8f78b32709@intel.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
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

