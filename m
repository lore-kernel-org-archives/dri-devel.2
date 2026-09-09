Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FCEC79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 10:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAECC10F08C;
	Wed,  9 Sep 2026 10:07:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RBw9LdSw";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8450B10F08C
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 10:07:44 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49a97714f5dso55501895e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 03:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788948463; x=1789553263; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cbb3Uw3ukKqnxH5JeLiUaWg1blYZdACAN4qfjZCbhzc=;
 b=RBw9LdSw7FxG1hZpf7F0VnobgIcIMKMcH7Vf1+RiyAPY5g8ZsMdU2RiI4RDLiqM2X4
 Ti3xNEGRke4sBF4wX/dWPflI7g59hGHG0vmV0gial5Avo9S/WXrQ/Jz7MydnUWyJtSkX
 Z+WYvCnQtt1WaTRbIjwBivuCQXSM9SdRMmQSKVdcYRGsPN4qJdr7FnDezPEVeXOeLW3u
 yLW0+vZFVw6vUcKlKcc1eDdtnXMCwYXWbXMi0cNLATPyRf8hKrSQ98i1jYbS43F3yHlG
 dsCN+OK9Q8zSJECmId5R+dT08FinEyYjAimUVjhU3H5UcW1CuyCCZyj1fF/n8ieHr5XP
 MHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788948463; x=1789553263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cbb3Uw3ukKqnxH5JeLiUaWg1blYZdACAN4qfjZCbhzc=;
 b=Cy1ltC30x465MmiQXEsNPnJjbu19uo5iJyQ7J0cQQsR8MZ6exvi8h7lSnYGfXJgagl
 R/VxdHKJpPHx00YdEHNNRIa/TT0ufIaNTGefP9PyV9bAztRwYzSWskGj4nwcoMp2sxc2
 PEX++h4PrwDCRmMidkm+yWX7eNerP42XylWdpV9jzIX1l/c0v/ulzr4rmVFcYMMgfSEY
 7NOnPswyAe6mku5UACSNaxIQm4RurE0J+asq2ss0e+gyIDKaMYbrjzAXI06K64YVabAY
 92wPzSdCNlz8Y7MoVmyEUGT4UUloOaYePSW4n12BepQsNvtZetPJL/g2FZZPAfOJ/d5U
 nlyQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwUFmOlCD5LOlxI7f6XPueX3NVJYScNZ6b2DnO80Q320LsgcP36MyI1DOq6K9DX9B2ZExlKAjAN9M0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lOPTqMio0296X7ei8/o8VupzBcpZsWjTF6bI7qVFUwDZppF8cd
 2WAbYSvk8Hlb5FOWLbseTw/GgTn68ssmgmkeFEYUXpF2AaiIgLWhVGrL
X-Gm-Gg: AYBFou3P8bV2HG5gKV4n8wGucMtwucWLjf0da8iC4LpqIOpIXovYFuu/k1iwZE0Eka2
 e6nhoKt6sfIm5Isx+RlqBwQPlnoQCYltf8GCLaF2yg+x1+7XR+a5VszzOpI3QOi4KxcVZol62hL
 QaTKouFwfs5dlU4sWh9x0jaw9VzYF/xjJpJKOsPhhBrDNh7XQTg7hPbicZrLUE11IgtcJMbbmtM
 0V9430M6Ogtynyib9MmlxdsWaoI3o6/zkcxUVlmsFBRPCwDBMuL/ICJ4aSt7oWA5KcrLWFIyDqU
 sj+M5xYT5UmFM6MzCxBJA1Cwtprko7VW/VhXSSaA/pZ+NanZkeV1x6noXloDFe/39x0ZzaOX2JK
 Oh4m8ryYTQgA/d3ULKYdClYNjqhpOYixlpeNBXO5eJfDeM50/zkLJH8NT84l4yLSR5MDoFppXlH
 fSQ8XH/bhEiXT4984NTi5kF+VK2TPlUJGSVopRo2NY+TZnVGOTrCP3bYnBybEgUFysXeWyh+eFZ
 O04gR0FKOKmEOGZ70P9rhlKtmMj6PEX8aHK3u8OaVTHx4q+aVFzeXjBApOExfycvJ5FX48F4Pai
 MOkaFOY8UlhX15eIvvGBDb6GnazxAPIJ2BgWQQ==
X-Received: by 2002:a05:600c:3f08:b0:49c:fa20:cc04 with SMTP id
 5b1f17b1804b1-49cfa20cd10mr298178875e9.27.1788948462779; 
 Wed, 09 Sep 2026 03:07:42 -0700 (PDT)
Received: from PC-Davide.homenet.telecomitalia.it
 (host-79-24-252-102.retail.telecomitalia.it. [79.24.252.102])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d20da3354sm37813545e9.2.2026.09.09.03.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 03:07:42 -0700 (PDT)
From: Davide Bonatto <bonatto.davide@gmail.com>
To: Alexey Brodkin <abrodkin@synopsys.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Cc: Davide Bonatto <bonatto.davide@gmail.com>
Subject: [PATCH v2] drm/tiny: arcpgu: Replace simple display pipe with regular
 atomic helpers
Date: Wed,  9 Sep 2026 12:07:36 +0200
Message-ID: <20260909100741.147859-1-bonatto.davide@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909092455.13.19.62-1-bonatto.davide@gmail.com>
References: <20260909092455.13.19.62-1-bonatto.davide@gmail.com>
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
v2:
  - Add .prepare_fb callback to support implicit synchronization.
  - Add .atomic_check using drm_atomic_helper_check_plane_state()
    to validate hardware scaling/clipping constraints.
  - Implement arc_pgu_plane_atomic_disable() to stop DMA and clear
    buffer address register, preventing hardware DMA scanout UAF.

 drivers/gpu/drm/tiny/arcpgu.c | 159 ++++++++++++++++++++++++++--------
 1 file changed, 125 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
index c93d61ac0bb7..e500e6e52b66 100644
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
@@ -117,8 +125,8 @@ static const u32 arc_pgu_supported_formats[] = {
 
 static void arc_pgu_set_pxl_fmt(struct arcpgu_drm_private *arcpgu)
 {
-	const struct drm_framebuffer *fb = arcpgu->pipe.plane.state->fb;
-	uint32_t pixel_format = fb->format->format;
+	const struct drm_framebuffer *fb = arcpgu->plane.state->fb;
+	u32 pixel_format = fb->format->format;
 	u32 format = DRM_FORMAT_INVALID;
 	int i;
 	u32 reg_ctrl;
@@ -139,10 +147,10 @@ static void arc_pgu_set_pxl_fmt(struct arcpgu_drm_private *arcpgu)
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
 
@@ -155,7 +163,7 @@ static enum drm_mode_status arc_pgu_mode_valid(struct drm_simple_display_pipe *p
 
 static void arc_pgu_mode_set(struct arcpgu_drm_private *arcpgu)
 {
-	struct drm_display_mode *m = &arcpgu->pipe.crtc.state->adjusted_mode;
+	struct drm_display_mode *m = &arcpgu->crtc.state->adjusted_mode;
 	u32 val;
 
 	arc_pgu_write(arcpgu, ARCPGU_REG_FMT,
@@ -194,49 +202,107 @@ static void arc_pgu_mode_set(struct arcpgu_drm_private *arcpgu)
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
 
 	arc_pgu_mode_set(arcpgu);
 
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
+	arc_pgu_write(arcpgu, ARCPGU_REG_CTRL,
+		      arc_pgu_read(arcpgu, ARCPGU_REG_CTRL) &
+		      ~ARCPGU_CTRL_ENABLE_MASK);
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
+static const struct drm_crtc_helper_funcs arc_pgu_crtc_helper_funcs = {
+	.mode_valid	= arc_pgu_crtc_mode_valid,
+	.atomic_enable	= arc_pgu_crtc_atomic_enable,
+	.atomic_disable = arc_pgu_crtc_atomic_disable,
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
+	.atomic_update = arc_pgu_plane_atomic_update,
+	.prepare_fb = drm_gem_plane_helper_prepare_fb,
+	.atomic_check = arc_pgu_plane_atomic_check,
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
@@ -301,13 +367,38 @@ static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
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
+	if (ret)
+		return ret;
+
+	drm_plane_helper_add(&arcpgu->plane, &arc_pgu_plane_helper_funcs);
+
+	ret = drm_crtc_init_with_planes(drm, &arcpgu->crtc, &arcpgu->plane, NULL,
+					&arc_pgu_crtc_funcs, NULL);
+
 	if (ret)
 		return ret;
 
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
@@ -315,7 +406,7 @@ static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
 		if (!bridge)
 			return -EPROBE_DEFER;
 
-		ret = drm_simple_display_pipe_attach_bridge(&arcpgu->pipe, bridge);
+		ret = drm_bridge_attach(&arcpgu->encoder, bridge, NULL, 0);
 		if (ret)
 			return ret;
 	}
@@ -342,7 +433,7 @@ static int arcpgu_show_pxlclock(struct seq_file *m, void *arg)
 	struct drm_device *drm = node->minor->dev;
 	struct arcpgu_drm_private *arcpgu = dev_to_arcpgu(drm);
 	unsigned long clkrate = clk_get_rate(arcpgu->clk);
-	unsigned long mode_clock = arcpgu->pipe.crtc.mode.crtc_clock * 1000;
+	unsigned long mode_clock = arcpgu->crtc.mode.crtc_clock * 1000;
 
 	seq_printf(m, "hw  : %lu\n", clkrate);
 	seq_printf(m, "mode: %lu\n", mode_clock);
-- 
2.43.0

