Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AF4C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 03:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FB0310E0D9;
	Wed, 16 Sep 2026 03:33:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i7K+iJ59";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 940DB10E0D9
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 03:33:41 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccb1a990so396636a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 20:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789529621; x=1790134421;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JETOMAWav2dfMHsWYPyuoNMSTDJN0FsRCfFHE94te6U=;
 b=i7K+iJ59mM3oPPhGpccMm+uSrk9kjZZs9Ab+0hYIk6uuvz/FQKFaFKe0WuVl7deInl
 KEdf1FYFS3ZRhaOr6+0+Nh4msx1iTFl7ZLmdA3aCdwTAWNgJ/vo664ee8M1VDnzvBm8r
 Vt2Gxu2NEYXp02OwgrJdInWSvew67b//dGvx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789529621; x=1790134421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JETOMAWav2dfMHsWYPyuoNMSTDJN0FsRCfFHE94te6U=;
 b=MkfY18oIj/vuTL6/1mbMzSVMaBK5KnWsFv7OZPmPxB7iVIhCBOs2YxRIypuvEqUgK9
 F5HrNpgog+UExunzU0/BUXzNwKsY1EHy8gcEEHY14z38X6rotbGydA44idTxEq78wVT0
 GEnVFsX3JKVLqnSn2P+5z56siDXRQkybjGkQww3A7WR2fitmTUUvHst+rnCpG6JmS8h2
 a5+n84M1+hZvhWovGvnIwRT2ufDQIWsY2sxUYPEM7dah3VC9lReHgenufvWfDMx2PjlD
 0n/wMDnEOz/hg0FA5Xc0j6TVUcrMVU4M9uAElDZkmJCwms3P+1QjQ2QQ63onRJCABKUS
 1UTw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxrt6LB5atirLFj0VKpTQnZj7b/syNWk7GMyeZHGe1venFxcecHQqe+yB46uay3OVSXlh1eCHxsWqE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++myRvTNrjpVgFnbbhUKN0UICjz+NXJN6qdrSYq/M57HolnuMPUj
 G/Ngb7rlIe7MFarNLhv58MoCZtGNTB8ykIZA0posZcjEOb8r6x8DmlQlKQE4DDPvzA==
X-Gm-Gg: AYBFou0GEZRCp852405Jvl/FDJVL9A4wtxHKyESqG2o+pq+rqodYPDxHP4JjwTBwS4Y
 TOXFHyDU3wPc2seiVmNbUyKmTvuMAgW7gbtcAUpfbiHGMHSefHNAnhsjTXvVmmQ9QMprOunaT+D
 iB8xcMHaO/NxELIeuFI9n18PHX1V6T4wEWONUEdjqWBVWXbo8o3DI8HCxdok/Dz/h/OVeBx29Mp
 PvvmuGhAQ/ebWEBrxE4kKtjcYgPPN/qvdRV+vEdcbE2H6jab6SXHzIk4gVHfMPEZdMXrCzMIFxP
 U0K7VagICFzU12fXUiLxa8pnaccBAkPjDfwp0ofVVtbLbM85TJAUMDU7ndvv7qtzOWpK4xDRSFq
 pBTew5Zf9wT16k2+xTzDJj5h/korbn9wV+VbDpGsHkUrcZzc0TwC14A+G2tgUZ3EDjft7iYRYww
 8x36Z7gYZbVYiqBpXJ/vcwiV0sn4MsODxNuLHuAHYaGVzsE+G49EmeErmKFcdLmquksFXty39pG
 sxnB/KWUNcjMVuduMG++2w8ZVkxo7WTBRzcq3zo1nduqiEjT65WUrQIAw==
X-Received: by 2002:a17:90b:2604:b0:38e:659b:f366 with SMTP id
 98e67ed59e1d1-39e1df6c05dmr2364892a91.0.1789529621075; 
 Tue, 15 Sep 2026 20:33:41 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com
 ([2a00:79e0:203d:7:1f62:7622:5d61:2578])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e1bbe3e62sm1833477a91.10.2026.09.15.20.33.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 20:33:40 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Liu Ying <victor.liu@nxp.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-sunxi@lists.linux.dev,
 imx@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH RFT v2 1/5] drm: Split framebuffer pixel offset calculation
 from drm_fb_dma_get_gem_addr()
Date: Wed, 16 Sep 2026 11:33:22 +0800
Message-ID: <20260916033327.3054126-2-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
In-Reply-To: <20260916033327.3054126-1-wenst@chromium.org>
References: <20260916033327.3054126-1-wenst@chromium.org>
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

Currently drm_fb_dma_get_gem_addr() calculates the offset into the
framebuffer memory for the framebuffer's unclipped source coordinates,
adds that to the framebuffer's backing storage, and returns the result.

We are about to add a variant that uses the clipped source coordinates,
so there is already some reuse of code. However, calculating the data
offset for a given pixel is not specific to the DMA FB helpers. The
offset is only related to the framebuffer.

Split out the offset calculation into a new framebuffer helper so that
non-DMA users can also reuse the same code.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: <stable@vger.kernel.org> # dependency for next patch
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- New patch
---
 drivers/gpu/drm/drm_fb_dma_helper.c | 28 ++----------------
 drivers/gpu/drm/drm_framebuffer.c   | 45 +++++++++++++++++++++++++++++
 include/drm/drm_framebuffer.h       |  3 ++
 3 files changed, 51 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_dma_helper.c b/drivers/gpu/drm/drm_fb_dma_helper.c
index fd71969d2fb1..ab0f37d8a5ff 100644
--- a/drivers/gpu/drm/drm_fb_dma_helper.c
+++ b/drivers/gpu/drm/drm_fb_dma_helper.c
@@ -75,36 +75,14 @@ dma_addr_t drm_fb_dma_get_gem_addr(struct drm_framebuffer *fb,
 				   unsigned int plane)
 {
 	struct drm_gem_dma_object *obj;
-	dma_addr_t dma_addr;
-	u8 h_div = 1, v_div = 1;
-	u32 block_w = drm_format_info_block_width(fb->format, plane);
-	u32 block_h = drm_format_info_block_height(fb->format, plane);
-	u32 block_size = fb->format->char_per_block[plane];
-	u32 sample_x;
-	u32 sample_y;
-	u32 block_start_y;
-	u32 num_hblocks;
 
 	obj = drm_fb_dma_get_gem_obj(fb, plane);
 	if (!obj)
 		return 0;
 
-	dma_addr = obj->dma_addr + fb->offsets[plane];
-
-	if (plane > 0) {
-		h_div = fb->format->hsub;
-		v_div = fb->format->vsub;
-	}
-
-	sample_x = (state->src_x >> 16) / h_div;
-	sample_y = (state->src_y >> 16) / v_div;
-	block_start_y = (sample_y / block_h) * block_h;
-	num_hblocks = sample_x / block_w;
-
-	dma_addr += fb->pitches[plane] * block_start_y;
-	dma_addr += block_size * num_hblocks;
-
-	return dma_addr;
+	return obj->dma_addr + drm_framebuffer_get_block_offset(fb, plane,
+								state->src_x >> 16,
+								state->src_y >> 16);
 }
 EXPORT_SYMBOL_GPL(drm_fb_dma_get_gem_addr);
 
diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index d32aceb6ca9b..9e1231162047 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -1208,6 +1208,51 @@ void drm_framebuffer_print_info(struct drm_printer *p, unsigned int indent,
 	}
 }
 
+/**
+ * drm_framebuffer_get_block_offset() - Get offset to start of pixel block for
+ * the given framebuffer and coordinates.
+ * @fb: The framebuffer
+ * @plane: Which plane
+ * @x: x coordinate for pixel
+ * @y: y coordinate for pixel
+ *
+ * This function will usually be called from the PLANE callback functions,
+ * or from one of the helpers that calculates the framebuffer's DMA address.
+ *
+ * Return: offset from start of framebuffer to start of pixel block
+ */
+u32 drm_framebuffer_get_block_offset(struct drm_framebuffer *fb, unsigned int plane,
+				     unsigned int x, unsigned int y)
+{
+	u8 h_div = 1, v_div = 1;
+	u32 block_w = drm_format_info_block_width(fb->format, plane);
+	u32 block_h = drm_format_info_block_height(fb->format, plane);
+	u32 block_size = fb->format->char_per_block[plane];
+	u32 sample_x;
+	u32 sample_y;
+	u32 block_start_y;
+	u32 num_hblocks;
+	u32 offset;
+
+	offset = fb->offsets[plane];
+
+	if (plane > 0) {
+		h_div = fb->format->hsub;
+		v_div = fb->format->vsub;
+	}
+
+	sample_x = x / h_div;
+	sample_y = y / v_div;
+	block_start_y = (sample_y / block_h) * block_h;
+	num_hblocks = sample_x / block_w;
+
+	offset += fb->pitches[plane] * block_start_y;
+	offset += block_size * num_hblocks;
+
+	return offset;
+}
+EXPORT_SYMBOL(drm_framebuffer_get_block_offset);
+
 #ifdef CONFIG_DEBUG_FS
 static int drm_framebuffer_info(struct seq_file *m, void *data)
 {
diff --git a/include/drm/drm_framebuffer.h b/include/drm/drm_framebuffer.h
index 38b24fc8978d..c07aea1cc59f 100644
--- a/include/drm/drm_framebuffer.h
+++ b/include/drm/drm_framebuffer.h
@@ -220,6 +220,9 @@ void drm_framebuffer_remove(struct drm_framebuffer *fb);
 void drm_framebuffer_cleanup(struct drm_framebuffer *fb);
 void drm_framebuffer_unregister_private(struct drm_framebuffer *fb);
 
+u32 drm_framebuffer_get_block_offset(struct drm_framebuffer *fb, unsigned int plane,
+				     unsigned int x, unsigned int y);
+
 /**
  * drm_framebuffer_get - acquire a framebuffer reference
  * @fb: DRM framebuffer
-- 
2.55.0.1032.g73a4cd73de-goog

