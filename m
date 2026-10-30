Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0695A606A323
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WnHuwU6/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E8AA112964;
	Fri, 30 Oct 2026 17:30:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2847110E840;
 Fri, 30 Oct 2026 17:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793381439; x=1824917439;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=nU20Lsk3NegF2cLYRw4s4X6TGExuqWjv/s6tuST/uBk=;
 b=WnHuwU6/ugE8LMeQL/yRzok3qMgeks4Rd2CDpT9lnsu2L2uS/lcxO3HW
 KjW6h3byfNhR92pCmJmxCpg36FnIlj2Av68JoCS4tKDBsk3986avnYuqj
 xaZ9VM7GxBiottk5dXZyrLtGzgBc2mxpknsNHmiXQW8iLLM94hoRgwoCT
 0ggeM2c3DDybM43o8dTO9NChWnfbcBUS1AO0BmrFjqkDToWi74+UvzMKf
 DVWB8VImyDEZM2fBOkYk9eRvgum+fJQz8xf/n1ChoHcpQjHmg8wDvKab7
 0EyWJttYrtxmpvO2K7z/hDv3lZuws+2F6SS/HaFKruzkWoakGCE6eSYhP g==;
X-CSE-ConnectionGUID: 0wKEetzaSZ6UhRB0afcVtQ==
X-CSE-MsgGUID: ORktFIKwSyyRZHkPTqj3ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2045967"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2045967"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 10:30:39 -0700
X-CSE-ConnectionGUID: 8QV7x65MQvaYJeySfr9eMQ==
X-CSE-MsgGUID: 34vEEhlfQsixRV3V+L8fxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5377842"
Received: from aalteres-desk1.fm.intel.com ([10.121.64.173])
 by orviesa008.jf.intel.com with ESMTP; 30 Oct 2026 10:30:39 -0700
From: Alan Previn <alan.previn.teres.alexis@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Alan Previn <alan.previn.teres.alexis@intel.com>,
 dri-devel@lists.freedesktop.org, Raag Jadav <raag.jadav@intel.com>,
 Riana Tauro <riana.tauro@intel.com>
Subject: [PATCH 1/1] drm/xe/pcode: Fix pcode_try_request polling delays
Date: Fri, 30 Oct 2026 10:30:39 -0700
Message-ID: <20261030173038.681250-2-alan.previn.teres.alexis@intel.com>
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

Fixes: 7dc9b92dcfef ("drm/xe: Remove i915_utils dependency from xe_pcode.")
Signed-off-by: Alan Previn <alan.previn.teres.alexis@intel.com>
---
 drivers/gpu/drm/xe/xe_pcode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_pcode.c b/drivers/gpu/drm/xe/xe_pcode.c
index 266deecbb100..25d1a354ee36 100644
--- a/drivers/gpu/drm/xe/xe_pcode.c
+++ b/drivers/gpu/drm/xe/xe_pcode.c
@@ -146,6 +146,7 @@ int xe_pcode_read(struct xe_tile *tile, u32 mbox, u32 *val0, u32 *val1)
 	return err;
 }
 
+#define __XE_MMIO_WAIT_MAX_BACKOFF_100MS (100 * USEC_PER_MSEC)
 static int pcode_try_request(struct xe_tile *tile, u32 mbox,
 			     u32 request, u32 reply_mask, u32 reply,
 			     int *status, bool atomic, int timeout_us, bool locked)
@@ -165,10 +166,11 @@ static int pcode_try_request(struct xe_tile *tile, u32 mbox,
 			return 0;
 
 		if (atomic)
-			udelay(wait);
+			udelay(min_t(int, wait, (MAX_UDELAY_MS * 1000)));
 		else
 			usleep_range(wait, wait << 1);
 		wait <<= 1;
+		wait = min_t(int, wait << 1, __XE_MMIO_WAIT_MAX_BACKOFF_100MS);
 	}
 
 	return -ETIMEDOUT;

base-commit: d8a353e238652bec29fd452babdaae0044d30b9b
-- 
2.43.0

