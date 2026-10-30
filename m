Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E28606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DXWSuGss
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0879C1127A3;
	Fri, 30 Oct 2026 12:03:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEDBF112780;
 Fri, 30 Oct 2026 12:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793361817; x=1824897817;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qdKwg5vuq8n9JbH2EI86h8eUNUPfPx4EqL1/pC5tc10=;
 b=DXWSuGssoRZH8klExTAbrbRAyDmOsrZkM3A5FfeWjrZyLGALiDCsByHi
 /aSxXhm2exRPK9AY0awoyS4QCPOyQ3tPT2YskYF22wiS6huD/HtpXVM0K
 sSpEiDeDlxpLKyMPfsSjlmJVsfnBG7eAEumuvVkVXHnlgfTOJeMB8Kq+d
 UaZWpg3PnKJThCBDHW9nqENauMbH82xJTXyJ4XQxpBgb1LM/TDBGkfj+X
 TqkU83baUc4nHsY8HNeASV5wpLGSRQ1lLXQzQhlYx8lkV0la0Z6wTlauU
 iZDDRytV1k7K26vYIMVy7KGbO/AHKvpLBJpo6U6d91tf5kH9qZrsJoqH/ Q==;
X-CSE-ConnectionGUID: Q15dl/Q6Q5O6hoOZ0bAO7w==
X-CSE-MsgGUID: rW8lAYNiTdeKNjEXkajHhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2226490"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2226490"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 05:03:37 -0700
X-CSE-ConnectionGUID: vGGqpJ/dTEmYrWx4Xsj7lw==
X-CSE-MsgGUID: Ri7ALf5ZSGmrkTSDn5DyrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="7211023"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.13])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 05:03:35 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: jani.nikula@intel.com
Subject: [PATCH 04/13] drm/i915/debugfs: pass struct drm_printer to
 crtc_updates_info()
Date: Fri, 30 Oct 2026 14:03:07 +0200
Message-ID: <9b394123390eb554376692b758efde5b3eb07f0c.1793361738.git.jani.nikula@intel.com>
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

Pass struct drm_printer to crtc_updates_info().

Prefer struct drm_printer * over struct seq_file * to unify and allow
use of drm_printer helpers.

Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 .../drm/i915/display/intel_display_debugfs.c  | 23 +++++++++++--------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.c b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
index 7b82a51145da..507cd8528906 100644
--- a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
+++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
@@ -442,7 +442,7 @@ static void intel_scaler_info(struct seq_file *m, struct intel_crtc *crtc)
 }
 
 #if IS_ENABLED(CONFIG_DRM_I915_DEBUG_VBLANK_EVADE)
-static void crtc_updates_info(struct seq_file *m,
+static void crtc_updates_info(struct drm_printer *p,
 			      struct intel_crtc *crtc,
 			      const char *hdr)
 {
@@ -452,7 +452,7 @@ static void crtc_updates_info(struct seq_file *m,
 	count = 0;
 	for (row = 0; row < ARRAY_SIZE(crtc->debug.vbl.times); row++)
 		count += crtc->debug.vbl.times[row];
-	seq_printf(m, "%sUpdates: %llu\n", hdr, count);
+	drm_printf(p, "%sUpdates: %llu\n", hdr, count);
 	if (!count)
 		return;
 
@@ -481,22 +481,25 @@ static void crtc_updates_info(struct seq_file *m,
 			columns[8 + x] = '\0';
 		}
 
-		seq_printf(m, "%s%s\n", hdr, columns);
+		drm_printf(p, "%s%s\n", hdr, columns);
 	}
 
-	seq_printf(m, "%sMin update: %lluns\n",
+	drm_printf(p, "%sMin update: %lluns\n",
 		   hdr, crtc->debug.vbl.min);
-	seq_printf(m, "%sMax update: %lluns\n",
+	drm_printf(p, "%sMax update: %lluns\n",
 		   hdr, crtc->debug.vbl.max);
-	seq_printf(m, "%sAverage update: %lluns\n",
+	drm_printf(p, "%sAverage update: %lluns\n",
 		   hdr, div64_u64(crtc->debug.vbl.sum, count));
-	seq_printf(m, "%sOverruns > %uus: %u\n",
+	drm_printf(p, "%sOverruns > %uus: %u\n",
 		   hdr, VBLANK_EVASION_TIME_US, crtc->debug.vbl.over);
 }
 
 static int crtc_updates_show(struct seq_file *m, void *data)
 {
-	crtc_updates_info(m, m->private, "");
+	struct drm_printer p = drm_seq_file_printer(m);
+
+	crtc_updates_info(&p, m->private, "");
+
 	return 0;
 }
 
@@ -534,7 +537,7 @@ static void crtc_updates_add(struct intel_crtc *crtc)
 }
 
 #else
-static void crtc_updates_info(struct seq_file *m,
+static void crtc_updates_info(struct drm_printer *p,
 			      struct intel_crtc *crtc,
 			      const char *hdr)
 {
@@ -599,7 +602,7 @@ static void intel_crtc_info(struct seq_file *m, struct intel_crtc *crtc)
 		   str_yes_no(!crtc->cpu_fifo_underrun_disabled),
 		   str_yes_no(!crtc->pch_fifo_underrun_disabled));
 
-	crtc_updates_info(m, crtc, "\t");
+	crtc_updates_info(&p, crtc, "\t");
 }
 
 static int i915_display_info(struct seq_file *m, void *unused)
-- 
2.47.3

