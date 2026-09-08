Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC32DC79FA0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 09:08:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E937B10E0CB;
	Tue,  8 Sep 2026 09:08:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k4OaMviN";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBC7110E0CB
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 09:07:59 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-cc2276e6daeso3049900a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 02:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1788858479; x=1789463279;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=htcWMQzzIdN2OMq/lgGMWw6WmNo5HAqJQi0+KH0X9Sk=;
 b=k4OaMviNNNZ9vQRIJKbuMHj7Rs2ku2RsEnoNZYCx/QUmBMC56l/xYjAEI8fU8d2A2u
 fCyq2uX/XF83GHdGN5XmE3eGGSDT4BHdIaFQGTshU/sKJypwALP63uR9dav2l8l3M/F4
 UWQdbboE0rECjIfrp8upupkRwqfsvl1JbMkXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788858479; x=1789463279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=htcWMQzzIdN2OMq/lgGMWw6WmNo5HAqJQi0+KH0X9Sk=;
 b=B/Ed+ph01UDBFatBASJnAQCn5ohG8w+BOkh+94QHsZnts2H5HssFy3A2jt8aVd4F1p
 1lAxAJivJs84uftiU4EQiotZYG9QAF4mgZT2VMEuT+0IR1vq1pDpjW1w98fswc+P5s4a
 EbyqiGfaKppaUcCjJzQVgPHh+D0RKOW8YPVb5qsOhl/N6LqIA+rdWJWiQqMEPRNxcv9d
 wPq1XvjtgqsPsbQk+3hErVh7RGmjnXBaRMdIUatwU2QhNAOq9NvfoKYvrXy5W1tLJ+GZ
 Xn6mFZGGUaMks4vO5zkk5K8clFh36JYjPiCkK7QIZhrH4CmG4uykyIu3W5fPvRhaoXzZ
 IaNw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxzM1U2UBqKo5TzhLTt9PtyXw7ymeXCHGMDBSB8hLIBrX1dn+8VKH0BQxfJrYFHrviJj7RSroN1I2A=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lxLzItnKccjnz3xqr2KrAL7eCylrtm17f3Rl1P083AX788j1/b
 2tGjQhz2L7EPjOR3FZzEHAik3Vjkt/Rz2pjj17IKJgjGOVh2qZHLEvAUcYhznbn6Yw==
X-Gm-Gg: AYBFou0OfdkRf7OpVEIqzgmQoDMoZyB7V5bkvuvTbKgLT3aalQIgKq90qrM9jIr/GbL
 tG1F3b0m31uPyopb8KRx2do+h0dM+86Xyxm7X8mr8f6hS89Q704u6iOKtQyp5wOu0uwLmPgcQdD
 QzHdqGsTQNsua4ItYEMESGi4JMhNcVCMRs+4OMvN7o6HouI/aNJntv5PnfIEq/eY32d6aMrZlPs
 8fsAuGpcIcW3GDns+ziErM6v+kThIRrJetiDZZmRJWhqNbEzH6MSJ1NBysQczuVQ2IdJ6tSOFGF
 TE+pv3X5CMTaExx7zSaRhbFaSfn26+1O34Q0HunCgZ7u8EseXWigYSVsPrmKB8+Q7XkZlDIM0Qe
 hQBz2SHv99E1LVWgIYibNSkDwIh12QNu0EwQrdX33CvbjvBdDjzpuP1RQFb5L7sOdv3JQ4Pkdjm
 2ODi/+K+CNNAa9hObtS+CWZFFv4XPrMOYFU47ykyg0IYezyZpOwIzcZypU2EiVQkp7ig0s8z8ft
 SZDmy7+E5LdOVTcrgKC2a+i2Zd5P+lhgBbXc5holie9DDQ=
X-Received: by 2002:a17:90b:2784:b0:395:4de5:1054 with SMTP id
 98e67ed59e1d1-39b26272bdcmr47233218a91.16.1788858479259; 
 Tue, 08 Sep 2026 02:07:59 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com
 ([2a00:79e0:201d:8:e541:8c2f:4ce9:823a])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b4b72f62esm19718804a91.5.2026.09.08.02.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 02:07:58 -0700 (PDT)
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
Subject: [PATCH 1/4] drm/fb-dma-helper: Add drm_fb_dma_get_gem_clipped_addr()
Date: Tue,  8 Sep 2026 17:07:40 +0800
Message-ID: <20260908090745.1089143-2-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
In-Reply-To: <20260908090745.1089143-1-wenst@chromium.org>
References: <20260908090745.1089143-1-wenst@chromium.org>
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

drm_fb_dma_get_gem_addr() returns the DMA address to the "unclipped"
framebuffer. However some display drivers want the "clipped" framebuffer
instead, as they are also using the clipped coordinates to program the
hardware.

Some of these drivers are open-coding drm_fb_dma_get_gem_addr() with
the source coordinates replaced, while others have been incorrectly
converted to using drm_fb_dma_get_gem_addr(), which would end up
causing incorrect parts of the framebuffer to be displayed if it were
somehow clipped.

Add drm_fb_dma_get_gem_clipped_addr(), a "clipped" version of
drm_fb_dma_get_gem_addr() for these drivers to use.

Cc: <stable@vger.kernel.org> # dependency for next patch
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/drm_fb_dma_helper.c | 63 +++++++++++++++++++++--------
 include/drm/drm_fb_dma_helper.h     |  4 ++
 2 files changed, 51 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_dma_helper.c b/drivers/gpu/drm/drm_fb_dma_helper.c
index fd71969d2fb1..a260e7cd5667 100644
--- a/drivers/gpu/drm/drm_fb_dma_helper.c
+++ b/drivers/gpu/drm/drm_fb_dma_helper.c
@@ -59,20 +59,10 @@ struct drm_gem_dma_object *drm_fb_dma_get_gem_obj(struct drm_framebuffer *fb,
 }
 EXPORT_SYMBOL_GPL(drm_fb_dma_get_gem_obj);
 
-/**
- * drm_fb_dma_get_gem_addr() - Get DMA (bus) address for framebuffer, for pixel
- * formats where values are grouped in blocks this will get you the beginning of
- * the block
- * @fb: The framebuffer
- * @state: Which state of drm plane
- * @plane: Which plane
- * Return the DMA GEM address for given framebuffer.
- *
- * This function will usually be called from the PLANE callback functions.
- */
-dma_addr_t drm_fb_dma_get_gem_addr(struct drm_framebuffer *fb,
-				   struct drm_plane_state *state,
-				   unsigned int plane)
+static dma_addr_t _drm_fb_dma_get_gem_addr(struct drm_framebuffer *fb,
+					   unsigned int plane,
+					   unsigned int x,
+					   unsigned int y)
 {
 	struct drm_gem_dma_object *obj;
 	dma_addr_t dma_addr;
@@ -96,8 +86,8 @@ dma_addr_t drm_fb_dma_get_gem_addr(struct drm_framebuffer *fb,
 		v_div = fb->format->vsub;
 	}
 
-	sample_x = (state->src_x >> 16) / h_div;
-	sample_y = (state->src_y >> 16) / v_div;
+	sample_x = x / h_div;
+	sample_y = y / v_div;
 	block_start_y = (sample_y / block_h) * block_h;
 	num_hblocks = sample_x / block_w;
 
@@ -106,8 +96,49 @@ dma_addr_t drm_fb_dma_get_gem_addr(struct drm_framebuffer *fb,
 
 	return dma_addr;
 }
+
+/**
+ * drm_fb_dma_get_gem_addr() - Get DMA (bus) address for unclipped framebuffer,
+ * for pixel formats where values are grouped in blocks this will get you the
+ * beginning of the block
+ * @fb: The framebuffer
+ * @state: Which state of drm plane
+ * @plane: Which plane
+ *
+ * This function will usually be called from the PLANE callback functions.
+ *
+ * Return: GEM DMA address for given framebuffer, unclipped.
+ */
+dma_addr_t drm_fb_dma_get_gem_addr(struct drm_framebuffer *fb,
+				   struct drm_plane_state *state,
+				   unsigned int plane)
+{
+	return _drm_fb_dma_get_gem_addr(fb, plane, state->src_x >> 16,
+					state->src_y >> 16);
+}
 EXPORT_SYMBOL_GPL(drm_fb_dma_get_gem_addr);
 
+/**
+ * drm_fb_dma_get_gem_clipped_addr() - Get DMA (bus) address for clipped
+ * framebuffer, for pixel formats where values are grouped in blocks this
+ * will get you the beginning of the block
+ * @fb: The framebuffer
+ * @state: Which state of drm plane
+ * @plane: Which plane
+ *
+ * This function will usually be called from the PLANE callback functions.
+ *
+ * Return: GEM DMA address for given framebuffer, clipped.
+ */
+dma_addr_t drm_fb_dma_get_gem_clipped_addr(struct drm_framebuffer *fb,
+					   struct drm_plane_state *state,
+					   unsigned int plane)
+{
+	return _drm_fb_dma_get_gem_addr(fb, plane, state->src.x1 >> 16,
+					state->src.y1 >> 16);
+}
+EXPORT_SYMBOL_GPL(drm_fb_dma_get_gem_clipped_addr);
+
 /**
  * drm_fb_dma_sync_non_coherent - Sync GEM object to non-coherent backing
  *	memory
diff --git a/include/drm/drm_fb_dma_helper.h b/include/drm/drm_fb_dma_helper.h
index c950732c6d36..b2a0bd7ef9d0 100644
--- a/include/drm/drm_fb_dma_helper.h
+++ b/include/drm/drm_fb_dma_helper.h
@@ -17,6 +17,10 @@ dma_addr_t drm_fb_dma_get_gem_addr(struct drm_framebuffer *fb,
 				   struct drm_plane_state *state,
 				   unsigned int plane);
 
+dma_addr_t drm_fb_dma_get_gem_clipped_addr(struct drm_framebuffer *fb,
+					   struct drm_plane_state *state,
+					   unsigned int plane);
+
 void drm_fb_dma_sync_non_coherent(struct drm_device *drm,
 				  struct drm_plane_state *old_state,
 				  struct drm_plane_state *state);
-- 
2.55.0.979.g7e5102b832-goog

