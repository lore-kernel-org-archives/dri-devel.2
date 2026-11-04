Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3909606A326
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cXsaPy4H
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5044510F345;
	Tue,  3 Nov 2026 03:34:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0423010F335;
 Tue,  3 Nov 2026 03:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793676864; x=1825212864;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2ibaC0LwI4fMdA38nqhEQ20mlW1BgDPT1XXy0q2NaVg=;
 b=cXsaPy4HAb4g0tCwkgHdYj3Kt42tgy+Am1ertOZXy2SI84I83PosGD2m
 ov8G+xQzgC4fO44YDdoJ8E0Y2ksfQe991AgbnM/UyRnGLahzk3N9jMDQc
 OZrYjbgd4SmCW9x81c8JZ5lGpjOrbyS9OvivKFQVWVvnNzbqDgb9xGwXo
 ChG4NO3u3PMz3sYWiFQ9Ctcpabc+y08XoNJ1Xg+8PRUv25vOkEweOmq+T
 jw0vktMvBCSP+Kk+9PkXRdemdMInYQH53WETelI0ZHwkkPL5deqY22IiM
 1kDs8umUVb0M96lT/fE1q7rr3Or/AoPFnIqRjCAjFAveFBvhWDBYlZ4Uo Q==;
X-CSE-ConnectionGUID: I1Or65HJRxS+W/bk2yZlPg==
X-CSE-MsgGUID: 043sqmwPTZef0mOHSoAGKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2380803"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2380803"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 19:34:23 -0800
X-CSE-ConnectionGUID: aUffzQs6T5y2KTInS4KtZA==
X-CSE-MsgGUID: ZSxTTBwISoCaBhdgtP3ijA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6159869"
Received: from junxiao.bj.intel.com ([10.238.152.95])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 19:34:20 -0800
From: Junxiao Chang <junxiao.chang@intel.com>
To: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 airlied@gmail.com, simona@ffwll.ch, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: dev@lankhorst.se,
	junxiao.chang@intel.com
Subject: [PATCH 2/2] drm/xe/gsc: warn about GSC stolen memory usage on RT
 kernels
Date: Wed,  4 Nov 2026 11:27:32 +0800
Message-ID: <20261104032732.30681-3-junxiao.chang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104032732.30681-1-junxiao.chang@intel.com>
References: <20261104032732.30681-1-junxiao.chang@intel.com>
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
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_12_24,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The GSC microcontroller requires stolen memory, which can introduce
latency spikes and negatively impact real-time performance.

Print a warning on CONFIG_PREEMPT_RT kernels to inform the user that GSC
is active and that RT performance can be improved by disabling the GSC
firmware (e.g., by setting the module parameter xe.gsc_firmware_path="").

Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
---
 drivers/gpu/drm/xe/xe_gsc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_gsc.c b/drivers/gpu/drm/xe/xe_gsc.c
index aab59dc647fbd..3d06ab6fecbe0 100644
--- a/drivers/gpu/drm/xe/xe_gsc.c
+++ b/drivers/gpu/drm/xe/xe_gsc.c
@@ -427,6 +427,11 @@ int xe_gsc_init(struct xe_gsc *gsc)
 	else if (ret)
 		goto out;
 
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		xe_gt_warn(gt, "RT performance might be impacted by GSC stolen memory usage\n");
+		xe_gt_warn(gt, "Consider disabling GSC (xe.gsc_firmware_path=\"\") to improve it\n");
+	}
+
 	ret = xe_gsc_proxy_init(gsc);
 	if (ret && ret != -ENODEV)
 		goto out;
-- 
2.43.0

