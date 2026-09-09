Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A035C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 12:58:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B761C10F140;
	Wed,  9 Sep 2026 12:58:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Gg+2vebf";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F33510F140
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 12:58:12 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-49d036e0e99so24214105e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 05:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788958690; x=1789563490; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fDJIsvQodZTtbEW9SHhG5tI4vA4bsB8pqciFKepxJb0=;
 b=Gg+2vebfZSuWXuANDgRpVqQrZry5OnE/dbGrWRSDB5qyYK/SuDRd077s1A/aM4EaFN
 qT0w8RNMKl3imwcj+T8Z2MwN9KIolqMffbeYfwbBlepvelAlarAcgyMWPNqbgyfyh4Kf
 JRK8V1cU4bjtzigSw6Zm8VvoDEho4+HT9AKKyrkbq/4LblCZnAIAgbnFBcEzTkjJFCSb
 ZjSiZIYN+/5eLLBsbRMbv0aMccaPqzjQ3gWUOnavQcH5zR1UKeJcPYOpMvEc22519dxZ
 2GEo/F+ya0ZwUcVDaFx7+K45R8ftDgU6oADUEUh4E+k4XW0hgVp6Hh4xbK+kEcGWRIQL
 sTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788958690; x=1789563490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fDJIsvQodZTtbEW9SHhG5tI4vA4bsB8pqciFKepxJb0=;
 b=bPL9WL69qE6BwajFCwBBUpOpMeczQgFRfB/5QTyjKnXmDXgABc1UjvqUXs0Mqk+aEx
 wP1m9jDcuEgCcq4/pP36VvP/C4CZ3oKkJfbTYpFe1kqexn1bFNF2Bvtjousx5ECvzck2
 SvZmxt4Dtftn48zUx2s3rjMvrdpKN5md1k6Tu4JsWil3lV9sgWjX1ncj82r8BQ8dhhsq
 zRLdhcmkjaMQpbfHl1/0bGxCVNXGLJQGNCaaVO4k2qMd6RHgLUdBA/RugEnLAHVw6KmF
 pycAOUaABwPidnaQoHiMRi4T78o7zE8UKrBQPIslf5RMORRd/lBX7FA7zSlzuAzLEKWQ
 1UAA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzsXvE2nlHh2H05ai3hR/i/A5Z27GH9DKDiXVzrHsurL9AxsJK9wV+BJlKCmIxYADmp/AYPDNohgsM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k9EdMICW/ypEi17JuKV0UIY/DGMRLas8FR3dgBzfSebn5ncS/P
 2wOlOuXzJkuLj1HoYzKO9nHPjOlVWNmep6Q6sz3tkG+8JntkJXnhfha8
X-Gm-Gg: AYBFou23FGFuXeo0Q5aRc706zAZaQvqNVgO1m22JEQKpSBVoaBYI052gxBxPE5eXpHm
 yBGt4mwAlEiMUGGzzg6OeaV5ng7wiQqh6/jCLojIgpr71nQVCjdlbyhM7FD44ohmoMdtAMSK/Ct
 f5Gcr0/uxrTzRQMVhgi6FUJFc91RhP44JKkatqGJv/UDfDQuP0KHpyGiYUmJ3v1W2anBF4520Hg
 ThckdCdCIuA3shosxlYo2m/Dv6/p5smRwbhL+b1eRTggIvP9rjZaBvErPspeZeIyJZ2heOCEzBO
 XcpHeDPU6zPVbtL8p3t/iQZhsmoFG4Ue218NMv4K6Csd4d96aMQsAP3oJ8IFHJ0WPDPu18vUUZT
 FudgXY/SpIYPUPboZ6f3RF+uZEtNxAz/V20JRSdv3cS9WAow5KrHnXZlGjVhVAhZ1tQMoYZ7SHl
 YcPXsoiBgzBbKry5PYIIZkFJecT+D5u0rE4fe2YL9F57uYjMoBV/WpdaGHGxQgMvSdoWB8i07FQ
 0FA0Y7XwbzychrDZQOi10iCcrm3NX9ENMNGxXzeKjErJgdjL9NcjKo75oICIURPXuKnR3CRKcM8
 0qEwedCeYhe/zV/UP3J2OBZjghhETO48Sdan4nB1PzMQWZ+j
X-Received: by 2002:a05:600c:6098:b0:49c:fc6c:be05 with SMTP id
 5b1f17b1804b1-49cfc6cbfdbmr373559205e9.28.1788958689949; 
 Wed, 09 Sep 2026 05:58:09 -0700 (PDT)
Received: from PC-Davide.homenet.telecomitalia.it
 (host-79-24-252-102.retail.telecomitalia.it. [79.24.252.102])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf772692dsm550297605e9.10.2026.09.09.05.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 05:58:09 -0700 (PDT)
From: Davide Bonatto <bonatto.davide@gmail.com>
To: Alexey Brodkin <abrodkin@synopsys.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Cc: Davide Bonatto <bonatto.davide@gmail.com>
Subject: [PATCH v5] drm/tiny: arcpgu: Replace simple display pipe with regular
 atomic helpers
Date: Wed,  9 Sep 2026 14:58:02 +0200
Message-ID: <20260909125806.174851-1-bonatto.davide@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909092455.131962-1-bonatto.davide@gmail.com>
References: <20260909092455.131962-1-bonatto.davide@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

The drm_simple_display_pipe helper is considered legacy/deprecated in
favor of explicitly managing individual plane, CRTC, and encoder objects
using standard atomic helpers.

Migrate arcpgu to initialize its primary plane, CRTC, and encoder
explicitly, and route mode validation, enable, and disable hooks
through drm_crtc_helper_funcs, and plane updates through
drm_plane_helper_funcs.

Signed-off-by: Davide Bonatto <bonatto.davide@gmail.com>
---
v5:
  - Fix NULL pointer dereference in arc_pgu_crtc_atomic_check() by checking
    crtc_state->plane_mask instead of manually querying plane state.
v4:
  - Use drm_atomic_get_plane_state() in CRTC .atomic_check to ensure
    the primary plane state is attached and locked, avoiding false -EINVAL
    rejections and broken partial atomic commits.
v3:
  - Add CRTC .atomic_check hook to validate primary plane presence
    and avoid NULL pointer dereference in arc_pgu_set_pxl_fmt().
  - Pass framebuffer explicitly to arc_pgu_mode_set() and read plane
    state via drm_atomic_get_new_plane_state() in CRTC enable to prevent UAF.
  - Keep CRTC global enable bit intact during plane disable to avoid
    hardware state desync.
v2:
  - Add .prepare_fb callback to support implicit synchronization.
  - Add .atomic_check using drm_atomic_helper_check_plane_state()
    to validate hardware scaling/clipping constraints.
  - Implement arc_pgu_plane_atomic_disable() to stop DMA and clear
    buffer address register, preventing hardware DMA scanout UAF.

 drivers/gpu/drm/tiny/arcpgu.c | 188 +++++++++++++++++++++++++++-------
 1 file changed, 150 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
index c93d61ac0bb7..c6308fee568d 100644
--- a/drivers/gpu/drm/tiny/arcpgu.c
+++ b/drivers/gpu/drm/tiny/arcpgu.c
@@ -5,6 +5,8 @@
  * Copyright (C) 2016 Synopsys, Inc. (www.synopsys.com)
  */
 
+#include "drm/drm_gem_atomic_helper.h"
+
 #include <linux/clk.h>
 
 #include <drm/clients/drm_client_setup.h>
@@ -23,6 +25,8 @@
 #include <drm/drm_of.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_simple_kms_helper.h>
+#include <drm/drm_atomic.h>
+#include <drm/drm_bridge.h>
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/of_reserved_mem.h>
@@ -52,13 +56,17 @@ struct arcpgu_drm_private {
 	struct drm_device	drm;
 	void __iomem		*regs;
 	struct clk		*clk;
-	struct drm_simple_display_pipe pipe;
+	struct drm_plane	plane;
+	struct drm_crtc		crtc;
+	struct drm_encoder	encoder;
 	struct drm_connector	sim_conn;
 };
 
 #define dev_to_arcpgu(x) container_of(x, struct arcpgu_drm_private, drm)
 
-#define pipe_to_arcpgu_priv(x) container_of(x, struct arcpgu_drm_private, pipe)
+#define crtc_to_arcpgu_priv(x) container_of(x, struct arcpgu_drm_private, crtc)
+
+#define plane_to_arcpgu(x) container_of(x, struct arcpgu_drm_private, plane)
 
 static inline void arc_pgu_write(struct arcpgu_drm_private *arcpgu,
 				 unsigned int reg, u32 value)
@@ -115,14 +123,19 @@ static const u32 arc_pgu_supported_formats[] = {
 	DRM_FORMAT_ARGB8888,
 };
 
-static void arc_pgu_set_pxl_fmt(struct arcpgu_drm_private *arcpgu)
+static void arc_pgu_set_pxl_fmt(struct arcpgu_drm_private *arcpgu,
+				const struct drm_framebuffer *fb)
 {
-	const struct drm_framebuffer *fb = arcpgu->pipe.plane.state->fb;
-	uint32_t pixel_format = fb->format->format;
+	u32 pixel_format;
 	u32 format = DRM_FORMAT_INVALID;
 	int i;
 	u32 reg_ctrl;
 
+	if (!fb)
+		return;
+
+	pixel_format = fb->format->format;
+
 	for (i = 0; i < ARRAY_SIZE(arc_pgu_supported_formats); i++) {
 		if (arc_pgu_supported_formats[i] == pixel_format)
 			format = arc_pgu_supported_formats[i];
@@ -139,10 +152,10 @@ static void arc_pgu_set_pxl_fmt(struct arcpgu_drm_private *arcpgu)
 	arc_pgu_write(arcpgu, ARCPGU_REG_CTRL, reg_ctrl);
 }
 
-static enum drm_mode_status arc_pgu_mode_valid(struct drm_simple_display_pipe *pipe,
-					       const struct drm_display_mode *mode)
+static enum drm_mode_status arc_pgu_crtc_mode_valid(struct drm_crtc *crtc,
+						    const struct drm_display_mode *mode)
 {
-	struct arcpgu_drm_private *arcpgu = pipe_to_arcpgu_priv(pipe);
+	struct arcpgu_drm_private *arcpgu = crtc_to_arcpgu_priv(crtc);
 	long rate, clk_rate = mode->clock * 1000;
 	long diff = clk_rate / 200; /* +-0.5% allowed by HDMI spec */
 
@@ -153,9 +166,10 @@ static enum drm_mode_status arc_pgu_mode_valid(struct drm_simple_display_pipe *p
 	return MODE_NOCLOCK;
 }
 
-static void arc_pgu_mode_set(struct arcpgu_drm_private *arcpgu)
+static void arc_pgu_mode_set(struct arcpgu_drm_private *arcpgu,
+			     const struct drm_framebuffer *fb)
 {
-	struct drm_display_mode *m = &arcpgu->pipe.crtc.state->adjusted_mode;
+	struct drm_display_mode *m = &arcpgu->crtc.state->adjusted_mode;
 	u32 val;
 
 	arc_pgu_write(arcpgu, ARCPGU_REG_FMT,
@@ -189,54 +203,127 @@ static void arc_pgu_mode_set(struct arcpgu_drm_private *arcpgu)
 	arc_pgu_write(arcpgu, ARCPGU_REG_STRIDE, 0);
 	arc_pgu_write(arcpgu, ARCPGU_REG_START_SET, 1);
 
-	arc_pgu_set_pxl_fmt(arcpgu);
+	arc_pgu_set_pxl_fmt(arcpgu, fb);
 
 	clk_set_rate(arcpgu->clk, m->crtc_clock * 1000);
 }
 
-static void arc_pgu_enable(struct drm_simple_display_pipe *pipe,
-			   struct drm_crtc_state *crtc_state,
-			   struct drm_plane_state *plane_state)
+static void arc_pgu_crtc_atomic_enable(struct drm_crtc *crtc,
+				       struct drm_atomic_commit *state)
 {
-	struct arcpgu_drm_private *arcpgu = pipe_to_arcpgu_priv(pipe);
+	struct arcpgu_drm_private *arcpgu = crtc_to_arcpgu_priv(crtc);
+	struct drm_plane_state *plane_state =
+		drm_atomic_get_new_plane_state(state, &arcpgu->plane);
+	const struct drm_framebuffer *fb = plane_state ? plane_state->fb : NULL;
 
-	arc_pgu_mode_set(arcpgu);
+	arc_pgu_mode_set(arcpgu, fb);
 
 	clk_prepare_enable(arcpgu->clk);
 	arc_pgu_write(arcpgu, ARCPGU_REG_CTRL,
 		      arc_pgu_read(arcpgu, ARCPGU_REG_CTRL) |
-		      ARCPGU_CTRL_ENABLE_MASK);
+		ARCPGU_CTRL_ENABLE_MASK);
 }
 
-static void arc_pgu_disable(struct drm_simple_display_pipe *pipe)
+static void arc_pgu_crtc_atomic_disable(struct drm_crtc *crtc,
+					struct drm_atomic_commit *state)
 {
-	struct arcpgu_drm_private *arcpgu = pipe_to_arcpgu_priv(pipe);
+	struct arcpgu_drm_private *arcpgu = crtc_to_arcpgu_priv(crtc);
 
 	clk_disable_unprepare(arcpgu->clk);
 	arc_pgu_write(arcpgu, ARCPGU_REG_CTRL,
-			      arc_pgu_read(arcpgu, ARCPGU_REG_CTRL) &
-			      ~ARCPGU_CTRL_ENABLE_MASK);
+		      arc_pgu_read(arcpgu, ARCPGU_REG_CTRL) &
+		~ARCPGU_CTRL_ENABLE_MASK);
 }
 
-static void arc_pgu_update(struct drm_simple_display_pipe *pipe,
-			   struct drm_plane_state *state)
+static void arc_pgu_plane_atomic_update(struct drm_plane *plane,
+					struct drm_atomic_commit *state)
 {
-	struct arcpgu_drm_private *arcpgu;
+	struct arcpgu_drm_private *arcpgu = plane_to_arcpgu(plane);
+	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
 	struct drm_gem_dma_object *gem;
 
-	if (!pipe->plane.state->fb)
+	if (!new_plane_state->fb)
 		return;
 
-	arcpgu = pipe_to_arcpgu_priv(pipe);
-	gem = drm_fb_dma_get_gem_obj(pipe->plane.state->fb, 0);
+	gem = drm_fb_dma_get_gem_obj(new_plane_state->fb, 0);
 	arc_pgu_write(arcpgu, ARCPGU_REG_BUF0_ADDR, gem->dma_addr);
 }
 
-static const struct drm_simple_display_pipe_funcs arc_pgu_pipe_funcs = {
-	.update = arc_pgu_update,
-	.mode_valid = arc_pgu_mode_valid,
-	.enable	= arc_pgu_enable,
-	.disable = arc_pgu_disable,
+static void arc_pgu_plane_atomic_disable(struct drm_plane *plane,
+					 struct drm_atomic_commit *state)
+{
+	struct arcpgu_drm_private *arcpgu = plane_to_arcpgu(plane);
+
+	arc_pgu_write(arcpgu, ARCPGU_REG_BUF0_ADDR, 0);
+}
+
+static int arc_pgu_plane_atomic_check(struct drm_plane *plane,
+				      struct drm_atomic_commit *state)
+{
+	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_crtc_state *crtc_state;
+
+	if (!new_plane_state->crtc)
+		return 0;
+
+	crtc_state = drm_atomic_get_new_crtc_state(state, new_plane_state->crtc);
+	if (!crtc_state)
+		return -EINVAL;
+
+	return drm_atomic_helper_check_plane_state(new_plane_state, crtc_state,
+						   DRM_PLANE_NO_SCALING,
+						   DRM_PLANE_NO_SCALING,
+						   false, true);
+}
+
+static int arc_pgu_crtc_atomic_check(struct drm_crtc *crtc,
+				     struct drm_atomic_commit *state)
+{
+	struct drm_crtc_state *crct_state = drm_atomic_get_new_crtc_state(state, crtc);
+
+	if (!crct_state->enable)
+		return 0;
+
+	if (!crct_state->plane_mask)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct drm_crtc_helper_funcs arc_pgu_crtc_helper_funcs = {
+	.mode_valid	= arc_pgu_crtc_mode_valid,
+	.atomic_enable	= arc_pgu_crtc_atomic_enable,
+	.atomic_disable = arc_pgu_crtc_atomic_disable,
+	.atomic_check	= arc_pgu_crtc_atomic_check,
+};
+
+static const struct drm_crtc_funcs arc_pgu_crtc_funcs = {
+	.reset			= drm_atomic_helper_crtc_reset,
+	.destroy		= drm_crtc_cleanup,
+	.set_config		= drm_atomic_helper_set_config,
+	.page_flip		= drm_atomic_helper_page_flip,
+	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
+};
+
+static const struct drm_plane_helper_funcs arc_pgu_plane_helper_funcs = {
+	.atomic_update	= arc_pgu_plane_atomic_update,
+	.prepare_fb	= drm_gem_plane_helper_prepare_fb,
+	.atomic_check	= arc_pgu_plane_atomic_check,
+	.atomic_disable = arc_pgu_plane_atomic_disable,
+};
+
+static const struct drm_plane_funcs arc_pgu_plane_funcs = {
+	.update_plane = drm_atomic_helper_update_plane,
+	.disable_plane = drm_atomic_helper_disable_plane,
+	.destroy = drm_plane_cleanup,
+	.reset = drm_atomic_helper_plane_reset,
+	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
+};
+
+static const struct drm_encoder_funcs arc_pgu_encoder_funcs = {
+	.destroy = drm_encoder_cleanup
 };
 
 static const struct drm_mode_config_funcs arcpgu_drm_modecfg_funcs = {
@@ -301,13 +388,38 @@ static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
 			return ret;
 	}
 
-	ret = drm_simple_display_pipe_init(drm, &arcpgu->pipe, &arc_pgu_pipe_funcs,
-					   arc_pgu_supported_formats,
-					   ARRAY_SIZE(arc_pgu_supported_formats),
-					   NULL, connector);
+	ret = drm_universal_plane_init(drm, &arcpgu->plane, 0,
+				       &arc_pgu_plane_funcs, arc_pgu_supported_formats,
+				       ARRAY_SIZE(arc_pgu_supported_formats), NULL,
+				       DRM_PLANE_TYPE_PRIMARY, NULL);
+
 	if (ret)
 		return ret;
 
+	drm_plane_helper_add(&arcpgu->plane, &arc_pgu_plane_helper_funcs);
+
+	ret = drm_crtc_init_with_planes(drm, &arcpgu->crtc, &arcpgu->plane, NULL,
+					&arc_pgu_crtc_funcs, NULL);
+
+	if (ret)
+		return ret;
+
+	drm_crtc_helper_add(&arcpgu->crtc, &arc_pgu_crtc_helper_funcs);
+
+	ret = drm_encoder_init(drm, &arcpgu->encoder, &arc_pgu_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
+
+	if (ret)
+		return ret;
+
+	arcpgu->encoder.possible_crtcs = drm_crtc_mask(&arcpgu->crtc);
+
+	if (connector) {
+		ret = drm_connector_attach_encoder(connector, &arcpgu->encoder);
+		if (ret)
+			return ret;
+	}
+
 	if (encoder_node) {
 		/* Locate drm bridge from the hdmi encoder DT node */
 		struct drm_bridge *bridge __free(drm_bridge_put) =
@@ -315,7 +427,7 @@ static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
 		if (!bridge)
 			return -EPROBE_DEFER;
 
-		ret = drm_simple_display_pipe_attach_bridge(&arcpgu->pipe, bridge);
+		ret = drm_bridge_attach(&arcpgu->encoder, bridge, NULL, 0);
 		if (ret)
 			return ret;
 	}
@@ -342,7 +454,7 @@ static int arcpgu_show_pxlclock(struct seq_file *m, void *arg)
 	struct drm_device *drm = node->minor->dev;
 	struct arcpgu_drm_private *arcpgu = dev_to_arcpgu(drm);
 	unsigned long clkrate = clk_get_rate(arcpgu->clk);
-	unsigned long mode_clock = arcpgu->pipe.crtc.mode.crtc_clock * 1000;
+	unsigned long mode_clock = arcpgu->crtc.mode.crtc_clock * 1000;
 
 	seq_printf(m, "hw  : %lu\n", clkrate);
 	seq_printf(m, "mode: %lu\n", mode_clock);
-- 
2.43.0

