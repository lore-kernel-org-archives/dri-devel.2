Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBDD606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VgYk0SBf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A725112780;
	Fri, 30 Oct 2026 12:04:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0641F1127AC;
 Fri, 30 Oct 2026 12:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793361833; x=1824897833;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RTe5Pj3APmxQdMB1cSjOCEeSluLDKUk20vf81YpWVgs=;
 b=VgYk0SBfMLDu9TnSvmWNb0zJHYuo99PexE5QyCtdzFf8L/RpVgNHaAn4
 Z8XEjZ3BLYzO6eG5Uf7bj2isodwiPczXf9RAvymAt/zA+u6K/K/WDrqb6
 xThURpWlDl2mf3drak8H0bnOZb7h+1To4oPmDVmZ8KcgGN9DW5TxfNn6b
 CvYQezdbLMwy1PMllQg3dAErAcJLgXvUycYVjOzMU9ETrUkie0HW1TAqS
 P7FLgtqnabdlgch6HYA0aCuJvyRUrxsBtlbU3yrBnYL+dFvPKeShYLxLD
 XuaYVyUyREqjb2Bh/qp9+f+4S2QwdXT+kisomQlT1CrPj1PCiVzGoK4l6 Q==;
X-CSE-ConnectionGUID: rOpsWHWNTfajQVeLle0twg==
X-CSE-MsgGUID: AHIDZJYMSrKcesho2K17mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2155576"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2155576"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 05:03:53 -0700
X-CSE-ConnectionGUID: e907xTV5QH2jY1Iytb//Ww==
X-CSE-MsgGUID: wD677DIqQR2AbJaaXqFk8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5382414"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.13])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 05:03:51 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: jani.nikula@intel.com
Subject: [PATCH 08/13] drm/i915/debugfs: pass struct drm_printer to
 intel_crtc_info()
Date: Fri, 30 Oct 2026 14:03:11 +0200
Message-ID: <983ef8920842aafee33a908ce6e8c71185deedb3.1793361738.git.jani.nikula@intel.com>
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

Pass struct drm_printer to intel_crtc_info().

Prefer struct drm_printer * over struct seq_file * to unify and allow
use of drm_printer helpers.

Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 .../drm/i915/display/intel_display_debugfs.c  | 38 +++++++++----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.c b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
index 075f29c241d1..3faee47e5854 100644
--- a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
+++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
@@ -547,66 +547,66 @@ static void crtc_updates_add(struct intel_crtc *crtc)
 }
 #endif
 
-static void intel_crtc_info(struct seq_file *m, struct intel_crtc *crtc)
+static void intel_crtc_info(struct drm_printer *p, struct intel_crtc *crtc)
 {
-	struct intel_display *display = node_to_intel_display(m->private);
-	struct drm_printer p = drm_seq_file_printer(m);
+	struct intel_display *display = to_intel_display(crtc);
 	const struct intel_crtc_state *crtc_state =
 		to_intel_crtc_state(crtc->base.state);
 	struct intel_encoder *encoder;
 
-	seq_printf(m, "[CRTC:%d:%s]:\n",
+	drm_printf(p, "[CRTC:%d:%s]:\n",
 		   crtc->base.base.id, crtc->base.name);
 
-	seq_printf(m, "\tuapi: enable=%s, active=%s, mode=" DRM_MODE_FMT "\n",
+	drm_printf(p, "\tuapi: enable=%s, active=%s, mode=" DRM_MODE_FMT "\n",
 		   str_yes_no(crtc_state->uapi.enable),
 		   str_yes_no(crtc_state->uapi.active),
 		   DRM_MODE_ARG(&crtc_state->uapi.mode));
 
-	seq_printf(m, "\thw: enable=%s, active=%s\n",
+	drm_printf(p, "\thw: enable=%s, active=%s\n",
 		   str_yes_no(crtc_state->hw.enable), str_yes_no(crtc_state->hw.active));
-	seq_printf(m, "\tadjusted_mode=" DRM_MODE_FMT "\n",
+	drm_printf(p, "\tadjusted_mode=" DRM_MODE_FMT "\n",
 		   DRM_MODE_ARG(&crtc_state->hw.adjusted_mode));
-	seq_printf(m, "\tpipe__mode=" DRM_MODE_FMT "\n",
+	drm_printf(p, "\tpipe__mode=" DRM_MODE_FMT "\n",
 		   DRM_MODE_ARG(&crtc_state->hw.pipe_mode));
 
-	seq_printf(m, "\tpipe src=" DRM_RECT_FMT ", dither=%s, bpp=%d\n",
+	drm_printf(p, "\tpipe src=" DRM_RECT_FMT ", dither=%s, bpp=%d\n",
 		   DRM_RECT_ARG(&crtc_state->pipe_src),
 		   str_yes_no(crtc_state->dither), crtc_state->pipe_bpp);
-	seq_printf(m, "\tport_clock=%d, lane_count=%d\n",
+	drm_printf(p, "\tport_clock=%d, lane_count=%d\n",
 		   crtc_state->port_clock, crtc_state->lane_count);
 
-	intel_scaler_info(&p, crtc);
+	intel_scaler_info(p, crtc);
 
 	if (DISPLAY_VER(display) >= 9) {
 		u32 background = crtc_state->hw.background_color;
 
-		seq_printf(m, "\tbackground color (10bpc XRGB2101010): %08x\n", background);
+		drm_printf(p, "\tbackground color (10bpc XRGB2101010): %08x\n", background);
 	}
 
 	if (crtc_state->joiner_pipes)
-		seq_printf(m, "\tLinked to 0x%x pipes as a %s\n",
+		drm_printf(p, "\tLinked to 0x%x pipes as a %s\n",
 			   crtc_state->joiner_pipes,
 			   intel_crtc_is_joiner_secondary(crtc_state) ? "slave" : "master");
 
-	intel_vdsc_state_dump(&p, 1, crtc_state);
+	intel_vdsc_state_dump(p, 1, crtc_state);
 
 	for_each_intel_encoder_mask(display->drm, encoder,
 				    crtc_state->uapi.encoder_mask)
-		intel_encoder_info(&p, encoder);
+		intel_encoder_info(p, encoder);
 
-	intel_plane_info(&p, crtc);
+	intel_plane_info(p, crtc);
 
-	seq_printf(m, "\tunderrun reporting: cpu=%s pch=%s\n",
+	drm_printf(p, "\tunderrun reporting: cpu=%s pch=%s\n",
 		   str_yes_no(!crtc->cpu_fifo_underrun_disabled),
 		   str_yes_no(!crtc->pch_fifo_underrun_disabled));
 
-	crtc_updates_info(&p, crtc, 1);
+	crtc_updates_info(p, crtc, 1);
 }
 
 static int i915_display_info(struct seq_file *m, void *unused)
 {
 	struct intel_display *display = node_to_intel_display(m->private);
+	struct drm_printer p = drm_seq_file_printer(m);
 	struct intel_crtc *crtc;
 	struct drm_connector *connector;
 	struct drm_connector_list_iter conn_iter;
@@ -619,7 +619,7 @@ static int i915_display_info(struct seq_file *m, void *unused)
 	seq_printf(m, "CRTC info\n");
 	seq_printf(m, "---------\n");
 	for_each_intel_crtc(display, crtc)
-		intel_crtc_info(m, crtc);
+		intel_crtc_info(&p, crtc);
 
 	seq_printf(m, "\n");
 	seq_printf(m, "Connector info\n");
-- 
2.47.3

