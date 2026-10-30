Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30EF606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cMfXExuJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B1A91127B2;
	Fri, 30 Oct 2026 12:04:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BD391127B2;
 Fri, 30 Oct 2026 12:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793361856; x=1824897856;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fVf6F5CN9mdyZfdiKISmJ6NlGOXmcWlXdNBIDKkAxsI=;
 b=cMfXExuJyHL1c5YI1kH/+3zyr72dMNzyopyHZu9FOuvT180yzMmCP6R+
 OszJYsrqgYTmhryMC/Vq13ervSCwfROtBKxPyJvF3dyLk4ay8CSTfBklz
 7WNxHWbDUCD86uLHaQ3/GYm5XFLx5rwl3aCHL4RqRpzf7phudJr8H9b7k
 qq1oUxpJtEBSd5PrHdq1x700VNLMf/07TxNSxLWf1MwYZkVPSUV6XnhlT
 y9r/2HLW/+FuypYb+JQzcVi0Y9IeskMF+z/YOwVOQxTTHICVNbbVa8Rx3
 3rVHEXu6UALtJskPOLGZhVfOERKl9fllJsTp/+07p34rzTPdfjzm0gR90 g==;
X-CSE-ConnectionGUID: 1Sd0PubhQxKD7aQQzzgAmw==
X-CSE-MsgGUID: hVLgiySTTXWlr+TFGM5qOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2155625"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2155625"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 05:04:15 -0700
X-CSE-ConnectionGUID: AnftaNQRS0O8EcCIzMc/0w==
X-CSE-MsgGUID: wD5famcPSUORU45dszFqqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5382591"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.13])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 05:04:14 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: jani.nikula@intel.com
Subject: [PATCH 13/13] drm/i915/debugfs: prefer drm_printf_indent() over
 inline \t
Date: Fri, 30 Oct 2026 14:03:16 +0200
Message-ID: <415f702e7b254ecfc5cdb290e92b8033675c7af0.1793361738.git.jani.nikula@intel.com>
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

We have a helper drm_printf_indent() for tab indenting the prints. It
makes the actual strings more readable, and highlights the indented
parts better in source.

Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 .../drm/i915/display/intel_display_debugfs.c  | 124 +++++++++---------
 1 file changed, 62 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.c b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
index a0644959d30e..9332532b5a60 100644
--- a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
+++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
@@ -178,8 +178,8 @@ static void intel_encoder_info(struct drm_printer *p,
 	struct drm_connector_list_iter conn_iter;
 	struct drm_connector *connector;
 
-	drm_printf(p, "\t[ENCODER:%d:%s]: connectors:\n",
-		   encoder->base.base.id, encoder->base.name);
+	drm_printf_indent(p, 1, "[ENCODER:%d:%s]: connectors:\n",
+			  encoder->base.base.id, encoder->base.name);
 
 	drm_connector_list_iter_begin(display->drm, &conn_iter);
 	drm_for_each_connector_iter(connector, &conn_iter) {
@@ -189,8 +189,8 @@ static void intel_encoder_info(struct drm_printer *p,
 		if (conn_state->best_encoder != &encoder->base)
 			continue;
 
-		drm_printf(p, "\t\t[CONNECTOR:%d:%s]\n",
-			   connector->base.id, connector->name);
+		drm_printf_indent(p, 2, "[CONNECTOR:%d:%s]\n",
+				  connector->base.id, connector->name);
 	}
 	drm_connector_list_iter_end(&conn_iter);
 }
@@ -203,7 +203,7 @@ static void intel_panel_info(struct drm_printer *p,
 	if (list_empty(&connector->panel.fixed_modes))
 		return;
 
-	drm_puts(p, "\tfixed modes:\n");
+	drm_printf_indent(p, 1, "fixed modes:\n");
 
 	list_for_each_entry(fixed_mode, &connector->panel.fixed_modes, head)
 		intel_print_mode(p, 2, fixed_mode);
@@ -214,9 +214,9 @@ static void intel_dp_info(struct drm_printer *p, struct intel_connector *connect
 	struct intel_encoder *intel_encoder = intel_attached_encoder(connector);
 	struct intel_dp *intel_dp = enc_to_intel_dp(intel_encoder);
 
-	drm_printf(p, "\tDPCD rev: %x\n", intel_dp->dpcd[DP_DPCD_REV]);
-	drm_printf(p, "\taudio support: %s\n",
-		   str_yes_no(connector->base.display_info.has_audio));
+	drm_printf_indent(p, 1, "DPCD rev: %x\n", intel_dp->dpcd[DP_DPCD_REV]);
+	drm_printf_indent(p, 1, "audio support: %s\n",
+			  str_yes_no(connector->base.display_info.has_audio));
 
 	drm_dp_downstream_debug(p, intel_dp->dpcd, intel_dp->downstream_ports,
 				connector->detect_edid, &intel_dp->aux);
@@ -227,7 +227,7 @@ static void intel_dp_mst_info(struct drm_printer *p,
 {
 	bool has_audio = connector->base.display_info.has_audio;
 
-	drm_printf(p, "\taudio support: %s\n", str_yes_no(has_audio));
+	drm_printf_indent(p, 1, "audio support: %s\n", str_yes_no(has_audio));
 }
 
 static void intel_hdmi_info(struct drm_printer *p,
@@ -235,7 +235,7 @@ static void intel_hdmi_info(struct drm_printer *p,
 {
 	bool has_audio = connector->base.display_info.has_audio;
 
-	drm_printf(p, "\taudio support: %s\n", str_yes_no(has_audio));
+	drm_printf_indent(p, 1, "audio support: %s\n", str_yes_no(has_audio));
 }
 
 static void intel_connector_info(struct drm_printer *p,
@@ -252,12 +252,12 @@ static void intel_connector_info(struct drm_printer *p,
 	if (connector->status == connector_status_disconnected)
 		return;
 
-	drm_printf(p, "\tphysical dimensions: %dx%dmm\n",
-		   connector->display_info.width_mm,
-		   connector->display_info.height_mm);
-	drm_printf(p, "\tsubpixel order: %s\n",
-		   drm_get_subpixel_order_name(connector->display_info.subpixel_order));
-	drm_printf(p, "\tCEA rev: %d\n", connector->display_info.cea_rev);
+	drm_printf_indent(p, 1, "physical dimensions: %dx%dmm\n",
+			  connector->display_info.width_mm,
+			  connector->display_info.height_mm);
+	drm_printf_indent(p, 1, "subpixel order: %s\n",
+			  drm_get_subpixel_order_name(connector->display_info.subpixel_order));
+	drm_printf_indent(p, 1, "CEA rev: %d\n", connector->display_info.cea_rev);
 
 	switch (connector->connector_type) {
 	case DRM_MODE_CONNECTOR_DisplayPort:
@@ -281,11 +281,11 @@ static void intel_connector_info(struct drm_printer *p,
 
 	intel_hdcp_info(p, intel_connector);
 
-	drm_printf(p, "\tmax bpc: %u\n", connector->display_info.bpc);
+	drm_printf_indent(p, 1, "max bpc: %u\n", connector->display_info.bpc);
 
 	intel_panel_info(p, intel_connector);
 
-	drm_printf(p, "\tmodes:\n");
+	drm_printf_indent(p, 1, "modes:\n");
 	list_for_each_entry(mode, &connector->modes, head)
 		intel_print_mode(p, 2, mode);
 }
@@ -350,7 +350,7 @@ static void intel_plane_uapi_info(struct drm_printer *p, struct intel_plane *pla
 	plane_rotation(rot_str, sizeof(rot_str),
 		       plane_state->uapi.rotation);
 
-	drm_puts(p, "\t\tuapi: [FB:");
+	drm_printf_indent(p, 2, "uapi: [FB:");
 	if (fb)
 		drm_printf(p, "%d] %p4cc,0x%llx,%dx%d", fb->base.id,
 			   &fb->format->format, fb->modifier, fb->width,
@@ -362,9 +362,9 @@ static void intel_plane_uapi_info(struct drm_printer *p, struct intel_plane *pla
 		   DRM_RECT_FP_ARG(&src), DRM_RECT_ARG(&dst), rot_str);
 
 	if (plane_state->planar_linked_plane)
-		drm_printf(p, "\t\tplanar: Linked to [PLANE:%d:%s] as a %s\n",
-			   plane_state->planar_linked_plane->base.base.id, plane_state->planar_linked_plane->base.name,
-			   plane_state->is_y_plane ? "Y plane" : "UV plane");
+		drm_printf_indent(p, 2, "planar: Linked to [PLANE:%d:%s] as a %s\n",
+				  plane_state->planar_linked_plane->base.base.id, plane_state->planar_linked_plane->base.name,
+				  plane_state->is_y_plane ? "Y plane" : "UV plane");
 }
 
 static void intel_plane_hw_info(struct drm_printer *p, struct intel_plane *plane)
@@ -380,14 +380,14 @@ static void intel_plane_hw_info(struct drm_printer *p, struct intel_plane *plane
 	plane_rotation(rot_str, sizeof(rot_str),
 		       plane_state->hw.rotation);
 
-	drm_printf(p, "\t\thw: [FB:%d] %p4cc,0x%llx,%dx%d, visible=%s, src="
-		   DRM_RECT_FP_FMT ", dst=" DRM_RECT_FMT ", rotation=%s\n",
-		   fb->base.id, &fb->format->format,
-		   fb->modifier, fb->width, fb->height,
-		   str_yes_no(plane_state->uapi.visible),
-		   DRM_RECT_FP_ARG(&plane_state->uapi.src),
-		   DRM_RECT_ARG(&plane_state->uapi.dst),
-		   rot_str);
+	drm_printf_indent(p, 2, "hw: [FB:%d] %p4cc,0x%llx,%dx%d, visible=%s, src="
+			  DRM_RECT_FP_FMT ", dst=" DRM_RECT_FMT ", rotation=%s\n",
+			  fb->base.id, &fb->format->format,
+			  fb->modifier, fb->width, fb->height,
+			  str_yes_no(plane_state->uapi.visible),
+			  DRM_RECT_FP_ARG(&plane_state->uapi.src),
+			  DRM_RECT_ARG(&plane_state->uapi.dst),
+			  rot_str);
 }
 
 static void intel_plane_info(struct drm_printer *p, struct intel_crtc *crtc)
@@ -396,9 +396,9 @@ static void intel_plane_info(struct drm_printer *p, struct intel_crtc *crtc)
 	struct intel_plane *plane;
 
 	for_each_intel_plane_on_crtc(display->drm, crtc, plane) {
-		drm_printf(p, "\t[PLANE:%d:%s]: type=%s\n",
-			   plane->base.base.id, plane->base.name,
-			   plane_type(plane->base.type));
+		drm_printf_indent(p, 1, "[PLANE:%d:%s]: type=%s\n",
+				  plane->base.base.id, plane->base.name,
+				  plane_type(plane->base.type));
 		intel_plane_uapi_info(p, plane);
 		intel_plane_hw_info(p, plane);
 	}
@@ -413,12 +413,12 @@ static void intel_scaler_info(struct drm_printer *p, struct intel_crtc *crtc)
 
 	/* Not all platforms have a scaler */
 	if (num_scalers) {
-		drm_printf(p, "\tnum_scalers=%d, scaler_users=%x scaler_id=%d scaling_filter=%d sharpness_strength=%d",
-			   num_scalers,
-			   crtc_state->scaler_state.scaler_users,
-			   crtc_state->scaler_state.scaler_id,
-			   crtc_state->hw.scaling_filter,
-			   crtc_state->hw.sharpness_strength);
+		drm_printf_indent(p, 1, "num_scalers=%d, scaler_users=%x scaler_id=%d scaling_filter=%d sharpness_strength=%d",
+				  num_scalers,
+				  crtc_state->scaler_state.scaler_users,
+				  crtc_state->scaler_state.scaler_id,
+				  crtc_state->hw.scaling_filter,
+				  crtc_state->hw.sharpness_strength);
 
 		for (i = 0; i < num_scalers; i++) {
 			const struct intel_scaler *sc =
@@ -429,7 +429,7 @@ static void intel_scaler_info(struct drm_printer *p, struct intel_crtc *crtc)
 		}
 		drm_puts(p, "\n");
 	} else {
-		drm_puts(p, "\tNo scalers available on this platform\n");
+		drm_printf_indent(p, 1, "No scalers available on this platform\n");
 	}
 }
 
@@ -550,36 +550,36 @@ static void intel_crtc_info(struct drm_printer *p, struct intel_crtc *crtc)
 	drm_printf(p, "[CRTC:%d:%s]:\n",
 		   crtc->base.base.id, crtc->base.name);
 
-	drm_printf(p, "\tuapi: enable=%s, active=%s, mode=" DRM_MODE_FMT "\n",
-		   str_yes_no(crtc_state->uapi.enable),
-		   str_yes_no(crtc_state->uapi.active),
-		   DRM_MODE_ARG(&crtc_state->uapi.mode));
+	drm_printf_indent(p, 1, "uapi: enable=%s, active=%s, mode=" DRM_MODE_FMT "\n",
+			  str_yes_no(crtc_state->uapi.enable),
+			  str_yes_no(crtc_state->uapi.active),
+			  DRM_MODE_ARG(&crtc_state->uapi.mode));
 
-	drm_printf(p, "\thw: enable=%s, active=%s\n",
-		   str_yes_no(crtc_state->hw.enable), str_yes_no(crtc_state->hw.active));
-	drm_printf(p, "\tadjusted_mode=" DRM_MODE_FMT "\n",
-		   DRM_MODE_ARG(&crtc_state->hw.adjusted_mode));
-	drm_printf(p, "\tpipe__mode=" DRM_MODE_FMT "\n",
-		   DRM_MODE_ARG(&crtc_state->hw.pipe_mode));
+	drm_printf_indent(p, 1, "hw: enable=%s, active=%s\n",
+			  str_yes_no(crtc_state->hw.enable), str_yes_no(crtc_state->hw.active));
+	drm_printf_indent(p, 1, "adjusted_mode=" DRM_MODE_FMT "\n",
+			  DRM_MODE_ARG(&crtc_state->hw.adjusted_mode));
+	drm_printf_indent(p, 1, "pipe__mode=" DRM_MODE_FMT "\n",
+			  DRM_MODE_ARG(&crtc_state->hw.pipe_mode));
 
-	drm_printf(p, "\tpipe src=" DRM_RECT_FMT ", dither=%s, bpp=%d\n",
-		   DRM_RECT_ARG(&crtc_state->pipe_src),
-		   str_yes_no(crtc_state->dither), crtc_state->pipe_bpp);
-	drm_printf(p, "\tport_clock=%d, lane_count=%d\n",
-		   crtc_state->port_clock, crtc_state->lane_count);
+	drm_printf_indent(p, 1, "pipe src=" DRM_RECT_FMT ", dither=%s, bpp=%d\n",
+			  DRM_RECT_ARG(&crtc_state->pipe_src),
+			  str_yes_no(crtc_state->dither), crtc_state->pipe_bpp);
+	drm_printf_indent(p, 1, "port_clock=%d, lane_count=%d\n",
+			  crtc_state->port_clock, crtc_state->lane_count);
 
 	intel_scaler_info(p, crtc);
 
 	if (DISPLAY_VER(display) >= 9) {
 		u32 background = crtc_state->hw.background_color;
 
-		drm_printf(p, "\tbackground color (10bpc XRGB2101010): %08x\n", background);
+		drm_printf_indent(p, 1, "background color (10bpc XRGB2101010): %08x\n", background);
 	}
 
 	if (crtc_state->joiner_pipes)
-		drm_printf(p, "\tLinked to 0x%x pipes as a %s\n",
-			   crtc_state->joiner_pipes,
-			   intel_crtc_is_joiner_secondary(crtc_state) ? "slave" : "master");
+		drm_printf_indent(p, 1, "Linked to 0x%x pipes as a %s\n",
+				  crtc_state->joiner_pipes,
+				  intel_crtc_is_joiner_secondary(crtc_state) ? "slave" : "master");
 
 	intel_vdsc_state_dump(p, 1, crtc_state);
 
@@ -589,9 +589,9 @@ static void intel_crtc_info(struct drm_printer *p, struct intel_crtc *crtc)
 
 	intel_plane_info(p, crtc);
 
-	drm_printf(p, "\tunderrun reporting: cpu=%s pch=%s\n",
-		   str_yes_no(!crtc->cpu_fifo_underrun_disabled),
-		   str_yes_no(!crtc->pch_fifo_underrun_disabled));
+	drm_printf_indent(p, 1, "underrun reporting: cpu=%s pch=%s\n",
+			  str_yes_no(!crtc->cpu_fifo_underrun_disabled),
+			  str_yes_no(!crtc->pch_fifo_underrun_disabled));
 
 	crtc_updates_info(p, crtc, 1);
 }
-- 
2.47.3

