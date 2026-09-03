Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F334C624D4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 06:31:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A97610E03E;
	Thu,  3 Sep 2026 06:31:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c3E7Ulzi";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6759510E03E
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 06:31:49 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2d8f265cbe6so18699515ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 23:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1788417109; x=1789021909;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aiO7Hl1ZhbHbwTakJqGhQbolHtOn10e//zMl8Skl9JQ=;
 b=c3E7UlziwXsP0hFlSqyM43bTUm+U+lXv9uPj6H5mszukgTrU4X/cOiIgELmZlYT4K2
 OrTlWDzWIPj+HAJt/iJg4ATJDy2wNzY/uL2c+FYjpFTUK1KHlAdVON32xEVWuH7Lj2G8
 007/nDf5iRDjViOlEpGaW7IInf1QfR3saoQ7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788417109; x=1789021909;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aiO7Hl1ZhbHbwTakJqGhQbolHtOn10e//zMl8Skl9JQ=;
 b=H1tbcE4Znarx/EhaMpy5ueYd3nT1x8/VymdyTl3fpGwXdRJFeVMMN29YVi9d4s7at/
 oYlK53KovKPs/hGoGg2gHYF22zdYNbMVCN+UPeiizDBakxHuEGLC3soMoDOjyqQgi1s4
 Jx942Yeh1+dwAFwdKdb/kHV6layndhjrP9U1FhoDToZ+brza62VF58e1znF/ncoenNzh
 6AyWREc6cYi5qr1b+lZprGgOA8hFl6uco1XCKo9CkpwjuaoajYvdT6d2gNJtQKRtiXCU
 wmF0hf5ZlyFDjK4v7I1f/JS7Yo+DMbSur4RDKmi9ZhfM5PuA5xpdbYapRiI8L0+18jHp
 M7Ug==
X-Forwarded-Encrypted: i=1;
 AKwUvBy37vqW1dLhLkLlunApFKX1nkgZqCGqD+d4XFO97jPuoeTL//FDWaBfJD/QUPExSVEzOJWQ5DiBA74=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lgsznhzopC0cY6ZqyNM+DAPAyKI3j+1pdaICRTQKhjULCdWcV4
 RQvFTjnXtnlDHTABm2nWsZ8+96sYtAqBcTMe0ZqOTsaxLXtF1py3aSodNIy/qE0Otw==
X-Gm-Gg: AYBFou3u/3KhHDGHJAhJIX22rbZH5S6WVx1fuQ74XUMGnsC6P20jIXiHx9cgnepg71B
 trsPFUZiP8DuVnRB+65Pt3AtVlgjhmemfSKv+pYXXwseXqkq8j0L2g+Qas4dW++EqSU8WRPmOqN
 9GmW28/hK0vOLDwZkFkT8693xbIFxVQUD0ub9obOpm8jiBNEi0op9Hu+lnwK6GXRKdYYYD7Wjzw
 2gEsH2/8k0BGDaQNfepUlCiI0Wmiyv/46IRwJ5UQlpDZbkblcDRpAscpWDwdTXxGRhr3YTe9Rg1
 GI31T0CoVxBIGoJ80NvOnNz+NXEQrH95rHoc8b34yNzlABTRJZibCqceF0HqntHk+ApURhUnSYa
 t1AfE10bXy80RrP8y6wJtp6mOiHK83JcVASiBeleqqgLrwhbZ5g17gJzMUv4oVoqlAaos1vzbpd
 pvRAJAcRoDgWs3L1M3hutbsRS3MxYRghy90HYcs++km2W1b9owE5IJBPUwoJtaTTOOkr5DHGYWs
 /KNw56zbFM5S4Wi6pgwJ4/fGIZ8DZLeytfBY8p1z0f2aEDx53cFmojC
X-Received: by 2002:a17:903:1b44:b0:2d3:78c2:1f19 with SMTP id
 d9443c01a7336-2daec60aefbmr146320265ad.9.1788417108828; 
 Wed, 02 Sep 2026 23:31:48 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com
 ([2a00:79e0:201d:8:59de:d2d:e1ec:bf86])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dafec1d449sm5006775ad.44.2026.09.02.23.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 23:31:47 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/tidss: dispc: Switch to drm_fb_dma_get_gem_addr() for
 framebuffer addresses
Date: Thu,  3 Sep 2026 14:31:10 +0800
Message-ID: <20260903063142.3770509-1-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
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

dispc_plane_state_dma_addr() and dispc_plane_state_p_uv_addr() are
basically the same as drm_fb_dma_get_addr(), without the support for
formats with block parameters. Since the driver doesn't support any of
those formats, the result is the same.

Switch to drm_fb_dma_get_gem_addr() for getting the framebuffer addresses.
Drop the const modifier on "struct drm_plane_state *state" for
dispc_plane_setup() so that the state can be passed to
drm_fb_dma_get_gem_addr().

Using the helper also future proofs the driver in case block parameters
are added for more formats, especially the common sub-sampled YUV
formats.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 38 +++--------------------------
 drivers/gpu/drm/tidss/tidss_dispc.h |  2 +-
 2 files changed, 4 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 58d5eb033bdb..2a0ec11a6c90 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -2157,47 +2157,15 @@ int dispc_plane_check(struct dispc_device *dispc, u32 hw_plane,
 	return 0;
 }
 
-static
-dma_addr_t dispc_plane_state_dma_addr(const struct drm_plane_state *state)
-{
-	struct drm_framebuffer *fb = state->fb;
-	struct drm_gem_dma_object *gem;
-	u32 x = state->src_x >> 16;
-	u32 y = state->src_y >> 16;
-
-	gem = drm_fb_dma_get_gem_obj(state->fb, 0);
-
-	return gem->dma_addr + fb->offsets[0] + x * fb->format->cpp[0] +
-		y * fb->pitches[0];
-}
-
-static
-dma_addr_t dispc_plane_state_p_uv_addr(const struct drm_plane_state *state)
-{
-	struct drm_framebuffer *fb = state->fb;
-	struct drm_gem_dma_object *gem;
-	u32 x = state->src_x >> 16;
-	u32 y = state->src_y >> 16;
-
-	if (WARN_ON(state->fb->format->num_planes != 2))
-		return 0;
-
-	gem = drm_fb_dma_get_gem_obj(fb, 1);
-
-	return gem->dma_addr + fb->offsets[1] +
-		(x * fb->format->cpp[1] / fb->format->hsub) +
-		(y * fb->pitches[1] / fb->format->vsub);
-}
-
 void dispc_plane_setup(struct dispc_device *dispc, u32 hw_plane,
-		       const struct drm_plane_state *state,
+		       struct drm_plane_state *state,
 		       u32 hw_videoport)
 {
 	bool lite = dispc->feat->vid_info[hw_plane].is_lite;
 	u32 fourcc = state->fb->format->format;
 	u16 cpp = state->fb->format->cpp[0];
 	u32 fb_width = state->fb->pitches[0] / cpp;
-	dma_addr_t dma_addr = dispc_plane_state_dma_addr(state);
+	dma_addr_t dma_addr = drm_fb_dma_get_gem_addr(state->fb, state, 0);
 	struct dispc_scaling_params scale;
 
 	dispc_vid_calc_scaling(dispc, state, &scale, lite);
@@ -2229,7 +2197,7 @@ void dispc_plane_setup(struct dispc_device *dispc, u32 hw_plane,
 	if (state->fb->format->num_planes == 2) {
 		u16 cpp_uv = state->fb->format->cpp[1];
 		u32 fb_width_uv = state->fb->pitches[1] / cpp_uv;
-		dma_addr_t p_uv_addr = dispc_plane_state_p_uv_addr(state);
+		dma_addr_t p_uv_addr = drm_fb_dma_get_gem_addr(state->fb, state, 1);
 
 		dispc_vid_write(dispc, hw_plane,
 				DISPC_VID_BA_UV_0, p_uv_addr & 0xffffffff);
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/tidss_dispc.h
index 739d211d0018..2183254f1ab7 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.h
+++ b/drivers/gpu/drm/tidss/tidss_dispc.h
@@ -140,7 +140,7 @@ int dispc_plane_check(struct dispc_device *dispc, u32 hw_plane,
 		      const struct drm_plane_state *state,
 		      u32 hw_videoport);
 void dispc_plane_setup(struct dispc_device *dispc, u32 hw_plane,
-		       const struct drm_plane_state *state,
+		       struct drm_plane_state *state,
 		       u32 hw_videoport);
 void dispc_plane_enable(struct dispc_device *dispc, u32 hw_plane, bool enable);
 const u32 *dispc_plane_formats(struct dispc_device *dispc, unsigned int *len);
-- 
2.55.0.970.g62bdec98f9-goog

