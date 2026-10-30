Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF36606A322
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PdP0WHmq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9786A11279C;
	Fri, 30 Oct 2026 12:03:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 240F511279A;
 Fri, 30 Oct 2026 12:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793361821; x=1824897821;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TOf+txYdXURYKe+LfQ/nZPkJphBAkSzz5B9A8E5IIMI=;
 b=PdP0WHmq+EOLbisLPwe+8pDuNJum1d+/5qDpWMjdFugFNbF3A+jusPOq
 Kz/vldfPyOi0E2X8fXc2sUdqfk++lEKN+DJOGbWSK4moSl8Pmaaeq1yoP
 DCx0Z6CHXHNHDGwFFscbf4sPFq8J7f0AOm4gk+oljKnmmkTc7yeahZu90
 flRLtY+RRYCq2od0NQyr5O3mz5sX1jbSnDQfiITQTsLJhOLmwzMdRTIU8
 00KRiKQCcd6ZTZg9kARh89wmNcwu79zBdO2MIqXyak4psCByK6MuYw16P
 p+I0L0IftoE9sg6RdXLVInWBk9Sp8zIlD5kAkKSIm0qNmxhjcLDaSmLO/ g==;
X-CSE-ConnectionGUID: T9ecmL1hSyazP4YymPA9bQ==
X-CSE-MsgGUID: uEIwIhEeSJW9r9/k1qiZrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2215184"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2215184"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 05:03:41 -0700
X-CSE-ConnectionGUID: yOXQqCEdQBSxTUeNUmgSTg==
X-CSE-MsgGUID: dGJoN7vWQAyQqS71kBgDMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5546187"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.13])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 05:03:39 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: jani.nikula@intel.com
Subject: [PATCH 05/13] drm/i915/debugfs: convert crtc_updates_info() to use
 drm_printf_indent()
Date: Fri, 30 Oct 2026 14:03:08 +0200
Message-ID: <fbe8dd4928f5b125511fa2e920a844a57e9497bf.1793361738.git.jani.nikula@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1793361738.git.jani.nikula@intel.com>
References: <cover.1793361738.git.jani.nikula@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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

Passing the const char *hdr to crtc_updates_info() is only for the
indent. Switch to passing the number of indentation tabs instead, and
use drm_printf_indent(). It makes the actual strings more readable, and
highlights the indented parts better in source.

Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 .../drm/i915/display/intel_display_debugfs.c  | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.c b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
index 507cd8528906..da70047f1449 100644
--- a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
+++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
@@ -444,7 +444,7 @@ static void intel_scaler_info(struct seq_file *m, struct intel_crtc *crtc)
 #if IS_ENABLED(CONFIG_DRM_I915_DEBUG_VBLANK_EVADE)
 static void crtc_updates_info(struct drm_printer *p,
 			      struct intel_crtc *crtc,
-			      const char *hdr)
+			      int indent)
 {
 	u64 count;
 	int row;
@@ -452,7 +452,7 @@ static void crtc_updates_info(struct drm_printer *p,
 	count = 0;
 	for (row = 0; row < ARRAY_SIZE(crtc->debug.vbl.times); row++)
 		count += crtc->debug.vbl.times[row];
-	drm_printf(p, "%sUpdates: %llu\n", hdr, count);
+	drm_printf_indent(p, indent, "Updates: %llu\n", count);
 	if (!count)
 		return;
 
@@ -481,24 +481,24 @@ static void crtc_updates_info(struct drm_printer *p,
 			columns[8 + x] = '\0';
 		}
 
-		drm_printf(p, "%s%s\n", hdr, columns);
+		drm_printf_indent(p, indent, "%s\n", columns);
 	}
 
-	drm_printf(p, "%sMin update: %lluns\n",
-		   hdr, crtc->debug.vbl.min);
-	drm_printf(p, "%sMax update: %lluns\n",
-		   hdr, crtc->debug.vbl.max);
-	drm_printf(p, "%sAverage update: %lluns\n",
-		   hdr, div64_u64(crtc->debug.vbl.sum, count));
-	drm_printf(p, "%sOverruns > %uus: %u\n",
-		   hdr, VBLANK_EVASION_TIME_US, crtc->debug.vbl.over);
+	drm_printf_indent(p, indent, "Min update: %lluns\n",
+			  crtc->debug.vbl.min);
+	drm_printf_indent(p, indent, "Max update: %lluns\n",
+			  crtc->debug.vbl.max);
+	drm_printf_indent(p, indent, "Average update: %lluns\n",
+			  div64_u64(crtc->debug.vbl.sum, count));
+	drm_printf_indent(p, indent, "Overruns > %uus: %u\n",
+			  VBLANK_EVASION_TIME_US, crtc->debug.vbl.over);
 }
 
 static int crtc_updates_show(struct seq_file *m, void *data)
 {
 	struct drm_printer p = drm_seq_file_printer(m);
 
-	crtc_updates_info(&p, m->private, "");
+	crtc_updates_info(&p, m->private, 0);
 
 	return 0;
 }
@@ -539,7 +539,7 @@ static void crtc_updates_add(struct intel_crtc *crtc)
 #else
 static void crtc_updates_info(struct drm_printer *p,
 			      struct intel_crtc *crtc,
-			      const char *hdr)
+			      int indent)
 {
 }
 
@@ -602,7 +602,7 @@ static void intel_crtc_info(struct seq_file *m, struct intel_crtc *crtc)
 		   str_yes_no(!crtc->cpu_fifo_underrun_disabled),
 		   str_yes_no(!crtc->pch_fifo_underrun_disabled));
 
-	crtc_updates_info(&p, crtc, "\t");
+	crtc_updates_info(&p, crtc, 1);
 }
 
 static int i915_display_info(struct seq_file *m, void *unused)
-- 
2.47.3

