Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6981606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GYhTI0g7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BF3311278E;
	Fri, 30 Oct 2026 12:03:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFCD8112786;
 Fri, 30 Oct 2026 12:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793361813; x=1824897813;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QI2KIrk5zM92DJjuVaPtPyhDMqI8TiRE82mfzIrZt3c=;
 b=GYhTI0g7U1QG6L9V9g0Q9fXUEe99G53zwIOPK1sNoJUxByEYJOyRl+qF
 UNLfP21ITALlYzFPCaZhde0J9umKxtp5KvY0g0wVw7NHYd05pgrIFNjnZ
 uRbc8SxEZUjkCIOVIDrqxk4vPnFktq2P+FLhr2KQhkHgYlvXcW0mowUkY
 dO65ZSeL9Muy8QSMHK4Yw1XQVGCA9rilwlKMREOXFxyRHbLIj4i+wi1mx
 AA4ezXsMGBqEtrHyGAPpeLyUvzwyN8R2O9Wmj6eKvK6sW6sDCTtpDpXNT
 qSZpmRTSGDlqZTl0A7IkyYKwDdXcbqKS1zPW8XOnFuRxhxa32Cx3lhRRH w==;
X-CSE-ConnectionGUID: F40ZsSxdQ2ui4hXcKkNMQA==
X-CSE-MsgGUID: 1jlyNSitTPK2H/uY28S1pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2226489"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2226489"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 05:03:33 -0700
X-CSE-ConnectionGUID: 3TRj7eCaQnatjWa06tfd4A==
X-CSE-MsgGUID: he3cZ+SYTwuha6Udm/rFDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="7210978"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.13])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 05:03:31 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: jani.nikula@intel.com
Subject: [PATCH 03/13] drm/i915/debugfs: pass struct drm_printer to
 intel_plane_info()
Date: Fri, 30 Oct 2026 14:03:06 +0200
Message-ID: <9e962b3c7e9b045f95d102840be83210ce6136fc.1793361738.git.jani.nikula@intel.com>
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

Pass struct drm_printer to intel_plane_info() and its dependencies
intel_plane_uapi_info() and intel_plane_hw_info().

Prefer struct drm_printer * over struct seq_file * to unify and allow
use of drm_printer helpers.

Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 .../drm/i915/display/intel_display_debugfs.c  | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.c b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
index 93e80b5e7ce8..7b82a51145da 100644
--- a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
+++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
@@ -344,7 +344,7 @@ static const char *plane_visibility(const struct intel_plane_state *plane_state)
 	return "hidden";
 }
 
-static void intel_plane_uapi_info(struct seq_file *m, struct intel_plane *plane)
+static void intel_plane_uapi_info(struct drm_printer *p, struct intel_plane *plane)
 {
 	const struct intel_plane_state *plane_state =
 		to_intel_plane_state(plane->base.state);
@@ -358,24 +358,24 @@ static void intel_plane_uapi_info(struct seq_file *m, struct intel_plane *plane)
 	plane_rotation(rot_str, sizeof(rot_str),
 		       plane_state->uapi.rotation);
 
-	seq_puts(m, "\t\tuapi: [FB:");
+	drm_puts(p, "\t\tuapi: [FB:");
 	if (fb)
-		seq_printf(m, "%d] %p4cc,0x%llx,%dx%d", fb->base.id,
+		drm_printf(p, "%d] %p4cc,0x%llx,%dx%d", fb->base.id,
 			   &fb->format->format, fb->modifier, fb->width,
 			   fb->height);
 	else
-		seq_puts(m, "0] n/a,0x0,0x0,");
-	seq_printf(m, ", visible=%s, src=" DRM_RECT_FP_FMT ", dst=" DRM_RECT_FMT
+		drm_puts(p, "0] n/a,0x0,0x0,");
+	drm_printf(p, ", visible=%s, src=" DRM_RECT_FP_FMT ", dst=" DRM_RECT_FMT
 		   ", rotation=%s\n", plane_visibility(plane_state),
 		   DRM_RECT_FP_ARG(&src), DRM_RECT_ARG(&dst), rot_str);
 
 	if (plane_state->planar_linked_plane)
-		seq_printf(m, "\t\tplanar: Linked to [PLANE:%d:%s] as a %s\n",
+		drm_printf(p, "\t\tplanar: Linked to [PLANE:%d:%s] as a %s\n",
 			   plane_state->planar_linked_plane->base.base.id, plane_state->planar_linked_plane->base.name,
 			   plane_state->is_y_plane ? "Y plane" : "UV plane");
 }
 
-static void intel_plane_hw_info(struct seq_file *m, struct intel_plane *plane)
+static void intel_plane_hw_info(struct drm_printer *p, struct intel_plane *plane)
 {
 	const struct intel_plane_state *plane_state =
 		to_intel_plane_state(plane->base.state);
@@ -388,7 +388,7 @@ static void intel_plane_hw_info(struct seq_file *m, struct intel_plane *plane)
 	plane_rotation(rot_str, sizeof(rot_str),
 		       plane_state->hw.rotation);
 
-	seq_printf(m, "\t\thw: [FB:%d] %p4cc,0x%llx,%dx%d, visible=%s, src="
+	drm_printf(p, "\t\thw: [FB:%d] %p4cc,0x%llx,%dx%d, visible=%s, src="
 		   DRM_RECT_FP_FMT ", dst=" DRM_RECT_FMT ", rotation=%s\n",
 		   fb->base.id, &fb->format->format,
 		   fb->modifier, fb->width, fb->height,
@@ -398,17 +398,17 @@ static void intel_plane_hw_info(struct seq_file *m, struct intel_plane *plane)
 		   rot_str);
 }
 
-static void intel_plane_info(struct seq_file *m, struct intel_crtc *crtc)
+static void intel_plane_info(struct drm_printer *p, struct intel_crtc *crtc)
 {
-	struct intel_display *display = node_to_intel_display(m->private);
+	struct intel_display *display = to_intel_display(crtc);
 	struct intel_plane *plane;
 
 	for_each_intel_plane_on_crtc(display->drm, crtc, plane) {
-		seq_printf(m, "\t[PLANE:%d:%s]: type=%s\n",
+		drm_printf(p, "\t[PLANE:%d:%s]: type=%s\n",
 			   plane->base.base.id, plane->base.name,
 			   plane_type(plane->base.type));
-		intel_plane_uapi_info(m, plane);
-		intel_plane_hw_info(m, plane);
+		intel_plane_uapi_info(p, plane);
+		intel_plane_hw_info(p, plane);
 	}
 }
 
@@ -593,7 +593,7 @@ static void intel_crtc_info(struct seq_file *m, struct intel_crtc *crtc)
 				    crtc_state->uapi.encoder_mask)
 		intel_encoder_info(m, crtc, encoder);
 
-	intel_plane_info(m, crtc);
+	intel_plane_info(&p, crtc);
 
 	seq_printf(m, "\tunderrun reporting: cpu=%s pch=%s\n",
 		   str_yes_no(!crtc->cpu_fifo_underrun_disabled),
-- 
2.47.3

