Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87341C55AB9
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 16:11:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3C5810E735;
	Mon,  3 Aug 2026 16:11:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L7JGu/0d";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCD2310E738
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 16:11:44 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47fd4531020so2130301f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 09:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785773503; x=1786378303; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K3+RPMRTD2bspWZ1EZegXMowVkzRDKKmin7c2HjnpVI=;
 b=L7JGu/0dq39/p7CP5kY7ZjwfwOCeHUwvHfyqRJM3yT6rvBDm07+k0C50pAUJRD2I7d
 Mc6qv9rRscMt2Hs5kHe5DOmhOIAOCaOtYbWsqZhwcAw0XYxb2IGARx0ocXvJ92P8Ws8Z
 d1Sucb9ikxHOv4GgG1L5v3GL+mIxD/2oEAx07uZ3ddmLUJ0HUhye9HNBfJ2emSYcorQL
 UOVQ4Z82H+R7iFA1Vg5RhkR8z0an2EdoM1QCzOpTx8g9edYdTSqY8xHxUrrHguzVtV6t
 eS/NBLsfDvPewQoTe5DuvZy+0zBwciWX/4rqvNw16YfgAPt8nZNS6lOPu/ZDZrKiDaQ/
 a0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785773503; x=1786378303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K3+RPMRTD2bspWZ1EZegXMowVkzRDKKmin7c2HjnpVI=;
 b=SOE4gj99GCxQSpIz6ScDl1IshrApJA3g5PzrNKXRIirquJh0evq+V42vrdhyurBw1M
 almjXnH6y4XdCSGUNrYTQ7MNpf3mA4omBqIexoZFT5WOXVpUKO8M9X3zhhiFuMXRunq8
 Fj1EUwe85t5NuJLH2Dac867MifEQwZapvJ2EjvuQd/Blo5cAhcqj+PzVM1FWo9WVpbcO
 /9ryGLaHNOpymvzkRrZ83k8ak8xVD6ACQmM0MuQX8gUMIVqXGkU7/PqtyOtkez/LPb3z
 SSCK/0nGBOqUUPuo5rYIZz5dcpVpwcjgQuebyJKuWKs2bt6PgVLmFX2cjNrEjs3rhHkf
 +Lkg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpacs7mlDSKe5Fc4KFWnZxjYZzWGDNk6ojeG0sO5aBrkVU4SrXWGcRJbc+nb2TEyYZjiqdO7Xt/Jk8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzl/iX/Co3hozygMA6cpxI6YafZg3c2TTmJEpXuX+5HzKnGcYlI
 g00iorCEvEImnsNqGpdY1JdSQQZ2QrMeIj2zEaCaXhBVj1J9SiK7yFnb
X-Gm-Gg: AR+sD12kOZEw7uwQ5LsjvZhCerP71MBU6vnhFB/UwXPg0QJyBs43Gv3SSicmh0ojBJJ
 HyA2wnuuT0dy2HZd6zTFuxoLW8jp3He8q6fzKvOTuocqr/0FhebuT/l7+6pOcTw59/mfvSMGzB/
 KOH/8fLB8dKKe8RNRMfZ9Xw9FVlXWH15q6w3Kuj60g+KyWFtnBB800+yREefCUo5hoWlm3Wz1Mj
 8zq/BWEXJS4TTNxvkmsDpKf6a4sJxwtnrk0MaQJainATttxqa+lEzt+xGFqDUCJ8Wb5gJNzLsqf
 78rUP6PpUPmPoTSXn3t7Q7i1ELNvCsqYnnfuhbS0fh5d4kKemJ5l7M4aMhCa5Dry8fSooxFt2NS
 cFPxmwGg6PR1cWlLFEwq6WMWRwTD945H4mECo0dVcnScE1Zl2R7MPzhjSFoJhMcai0Ce+I1WL5T
 Mrsy3M3xiqs6NaDo7eG2L4OnK483paMbSPkaqcOajFcdZsCAwAU1fXAo4atFrYBn2jiGtWg8jqK
 HU7IxfD5DAteeD3MPs0Gv9ysUTlQ8M4St/9FFSl7mvxVB5Mpkk2XFoH9lzgMID0ULPrEkEETsmm
 fb1Kup+EzuIM61LE8Nm12GDj2Pn0sK2wbd7LzX8BsAPG0CZfq+Nfh4gPQFlaYZ55eLLlj7nOPml
 BlPjm3Sn6KRIE1d4iAJ1j/aRA7zjTDwVoRduMRir5ipGKM7NGnhy3O6OFUCIbahGiacm4NB9bZk
 284A==
X-Received: by 2002:a05:600c:c4ac:b0:493:a623:d090 with SMTP id
 5b1f17b1804b1-4980dda1993mr193930475e9.10.1785773503133; 
 Mon, 03 Aug 2026 09:11:43 -0700 (PDT)
Received: from jernej-laptop (APN-122-100-117-gprs.simobil.net.
 [46.122.100.117]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fc2da2sm3363735e9.3.2026.08.03.09.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:11:42 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: wens@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 13/13] drm/sun4i: Align VI buffer addresses for subsampled
 formats
Date: Mon,  3 Aug 2026 18:10:51 +0200
Message-ID: <3980ea1aeb3f7fe8b4700e36560deeba3d050664.1785772659.git.jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785772659.git.jernej.skrabec@gmail.com>
References: <cover.1785772659.git.jernej.skrabec@gmail.com>
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

This is a partial revert of commit 79ac1c945ab8 ("drm/sun4i: layers:
Use drm_fb_dma_get_gem_addr() to get display memory").

Chroma must start at the beginning of a subsampling block, for example
chroma start address for NV12 must be aligned to 2 pixels.
drm_fb_dma_get_gem_addr() offsets luma by the exact source coordinates
and chroma by the coordinates divided by the subsampling factor, so for
odd offsets both planes no longer describe the same pixel, which the
Display Engine scaler can't handle.

Align source coordinates down for all planes instead. Remaining shift
of one pixel is already compensated with scaler phase shift in
sun8i_vi_layer_update_coord().

Fixes: 79ac1c945ab8 ("drm/sun4i: layers: Use drm_fb_dma_get_gem_addr() to get display memory")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index 09f668c8af24..ad036cb9d88e 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -197,15 +197,31 @@ static void sun8i_vi_layer_update_buffer(struct sun8i_layer *layer,
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
 	const struct drm_format_info *format = fb->format;
+	struct drm_gem_dma_object *gem;
+	u32 dx, dy, src_x, src_y;
 	dma_addr_t dma_addr;
 	u32 ch_base;
 	int i;
 
 	ch_base = sun8i_channel_base(layer);
 
+	/* Adjust x and y to be divisible by subsampling factor */
+	src_x = (state->src.x1 >> 16) & ~(format->hsub - 1);
+	src_y = (state->src.y1 >> 16) & ~(format->vsub - 1);
+
 	for (i = 0; i < format->num_planes; i++) {
-		/* Get the start of the displayed memory */
-		dma_addr = drm_fb_dma_get_gem_addr(fb, state, i);
+		gem = drm_fb_dma_get_gem_obj(fb, i);
+		dma_addr = gem->dma_addr + fb->offsets[i];
+
+		dx = src_x;
+		dy = src_y;
+		if (i > 0) {
+			dx /= format->hsub;
+			dy /= format->vsub;
+		}
+
+		dma_addr += dx * format->cpp[i];
+		dma_addr += dy * fb->pitches[i];
 
 		/* Set the line width */
 		DRM_DEBUG_DRIVER("Layer %d. line width: %d bytes\n",
-- 
2.43.0

