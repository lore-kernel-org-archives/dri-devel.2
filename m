Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD0B606EE9A
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SC8sEhVn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 675A710E6B8;
	Mon,  2 Nov 2026 17:46:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19BE410E6AC;
 Mon,  2 Nov 2026 17:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793641570; x=1825177570;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+A0X5YAg5HAUwSeWgjCMHFWaqs4NBHLgfdtiQ6e83g4=;
 b=SC8sEhVncrOaAVA3FqG0k9d8x3NRkc3DPBSycOU/2f5Su7gMG4g/2bTK
 sdk2jTAEeofwrr5g8LW5pM4uhgJed5PDqIJhEP9yKjsFjunNqek3wrxQ9
 ugbzg2yI6Z7p1c9EsiNYoroT8KunFsTtH5qvi1Lf9+/vaiOgfLP3MI3Vv
 y7n1ca27/UNW90wbntR7lsK6hcGRBk/xrpuHWTWIXC7nc+u4g2fIg7kQ9
 WbiK7BCfz2mKkuomdDiVUlEbrTNOXRIj5pbn3bipJP2p7a8MDMUdPGnCr
 9kbSdDYwRkWyCA4mS7jvwg2npie21OJUW9uqBroiNjF8Pmdp5nfQVHkT0 A==;
X-CSE-ConnectionGUID: m6dMeMk4QpmNh3r5lTwuUw==
X-CSE-MsgGUID: TK3S1FUNTs6NyRiG+L+wZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2227898"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2227898"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 09:46:09 -0800
X-CSE-ConnectionGUID: zk1WtUrGSu2i5D5Lepbm3w==
X-CSE-MsgGUID: apb6PfjtQuC4kGdwJTZWRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6294991"
Received: from aalteres-desk1.fm.intel.com ([10.121.64.173])
 by fmviesa005.fm.intel.com with ESMTP; 02 Nov 2026 09:46:10 -0800
From: Alan Previn <alan.previn.teres.alexis@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Alan Previn <alan.previn.teres.alexis@intel.com>,
 dri-devel@lists.freedesktop.org, Raag Jadav <raag.jadav@intel.com>,
 Riana Tauro <riana.tauro@intel.com>
Subject: [PATCH 1/1] drm/xe/pcode: Fix pcode_try_request polling delays
Date: Mon,  2 Nov 2026 09:46:06 -0800
Message-ID: <20261102174608.1279278-2-alan.previn.teres.alexis@intel.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Honor OOB max for udelay. Also add a backoff for 'wait'
as it exponentially increases so that doesn't overflow
and also caps to a sane limit so we dont suffer overtly
extended wait times as we progress.

v2: Fix accumnulation of 'wait' so 'slept' is accurate and
    accounts for atomic-udelay clamping. (Sashiko)

Fixes: 7dc9b92dcfef ("drm/xe: Remove i915_utils dependency from xe_pcode.")
Signed-off-by: Alan Previn <alan.previn.teres.alexis@intel.com>
---
 drivers/gpu/drm/xe/xe_pcode.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pcode.c b/drivers/gpu/drm/xe/xe_pcode.c
index 266deecbb100..d2ed5edf003e 100644
--- a/drivers/gpu/drm/xe/xe_pcode.c
+++ b/drivers/gpu/drm/xe/xe_pcode.c
@@ -146,6 +146,7 @@ int xe_pcode_read(struct xe_tile *tile, u32 mbox, u32 *val0, u32 *val1)
 	return err;
 }
 
+#define __XE_PCODE_WAIT_MAX_BACKOFF_100MS (100 * USEC_PER_MSEC)
 static int pcode_try_request(struct xe_tile *tile, u32 mbox,
 			     u32 request, u32 reply_mask, u32 reply,
 			     int *status, bool atomic, int timeout_us, bool locked)
@@ -164,11 +165,14 @@ static int pcode_try_request(struct xe_tile *tile, u32 mbox,
 		if ((*status == 0) && ((request & reply_mask) == reply))
 			return 0;
 
-		if (atomic)
-			udelay(wait);
-		else
+		wait = min_t(int, wait << 1, __XE_PCODE_WAIT_MAX_BACKOFF_100MS);
+		if (atomic) {
+			/* don't overflow udelay */
+			wait = min_t(int, wait, (MAX_UDELAY_MS * 1000);
+			udelay(wait));
+		} else {
 			usleep_range(wait, wait << 1);
-		wait <<= 1;
+		}
 	}
 
 	return -ETIMEDOUT;

base-commit: 2cd78713d917a02987f21b437561a5e1e13ddda2
-- 
2.43.0

