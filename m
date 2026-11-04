Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2B3606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GmV5es4F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5540210F343;
	Tue,  3 Nov 2026 03:34:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7449810E739;
 Tue,  3 Nov 2026 03:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793676860; x=1825212860;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tPEb9o4uooly0P6Vn6Zb4V3J2QjIghdBAo+Njsa2fTY=;
 b=GmV5es4F6xPRxFNEal8pjCUz8elhNnC26BgbTXNb6NZoxlNo4fpfxswi
 9Ep0BCjg+rXhCT+f/7ZelFqH5+H4KiPD0KqHKkEf5l5+5Xk36wFaYelh5
 RvVRfNNcfBKYzsa78Dbc+sm+SSvcbqrliSEbnSv04MmzM7YtpJ+EIVXyn
 I0dC3wX09I44mTJLuIVSz9uzqUC0K+0aUwT8EPGOX6idnXGbldxBo6TJI
 cvJvHnF4R+hrYQ49tTGlbPU/t1WLxiTPym3eil6QqBI9pTr625Hx+e4u6
 VwTYWeuwwVlz/cU7ByK2r3Dlm0WbAvBQewRkcsVnhAShSxkxvBfCYj5RZ g==;
X-CSE-ConnectionGUID: o150lzYbQ1u0zoRiNrbGRA==
X-CSE-MsgGUID: T1m8zmTJSfmPAxoXPVeHTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2380793"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2380793"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 19:34:20 -0800
X-CSE-ConnectionGUID: SjVktQ/8Q2qhttV3t15hww==
X-CSE-MsgGUID: DV4tbILtRKuKe4Cme2ectg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6159845"
Received: from junxiao.bj.intel.com ([10.238.152.95])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 19:34:16 -0800
From: Junxiao Chang <junxiao.chang@intel.com>
To: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 airlied@gmail.com, simona@ffwll.ch, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: dev@lankhorst.se,
	junxiao.chang@intel.com
Subject: [PATCH 1/2] drm/xe/display: Skip initial plane allocation from stolen
 memory on RT
Date: Wed,  4 Nov 2026 11:27:31 +0800
Message-ID: <20261104032732.30681-2-junxiao.chang@intel.com>
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

CPU access to stolen memory ranges can introduce latency spikes that
compromise real-time (RT) guarantees on PREEMPT_RT kernels.

On PREEMPT_RT configurations, bypass retrieving the initial plane's
framebuffer from stolen memory. This forces the driver to fall back to
standard allocations, preventing RT latency degradation at the expense
of seamless boot display takeover.

Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
---
 drivers/gpu/drm/xe/display/xe_initial_plane.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/xe/display/xe_initial_plane.c b/drivers/gpu/drm/xe/display/xe_initial_plane.c
index 0f86b73036d03..fd0e2962412dd 100644
--- a/drivers/gpu/drm/xe/display/xe_initial_plane.c
+++ b/drivers/gpu/drm/xe/display/xe_initial_plane.c
@@ -87,6 +87,12 @@ initial_plane_bo(struct xe_device *xe,
 		struct ttm_resource_manager *stolen;
 		u64 pte;
 
+		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+			drm_dbg_kms(&xe->drm,
+				    "Skipping FB allocation from stolen mem due to PREEMPT_RT\n");
+			return NULL;
+		}
+
 		stolen = ttm_manager_type(&xe->ttm, XE_PL_STOLEN);
 		if (!stolen) {
 			drm_dbg_kms(&xe->drm, "No stolen for initial FB\n");
-- 
2.43.0

