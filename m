Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1786F606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=KW9Jzxxi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3161110E1FF;
	Thu, 26 Nov 2026 07:13:36 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A32F410E1FF
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 07:13:30 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-8b612fd74e1so2344824b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 23:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795677210; x=1796282010;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aVE6uQY9znCYqrgi6+/JSfmRMS1q7/GU0dj9T9uQX+4=;
 b=KW9JzxxiRWv5b2ZsKSqdMnEwDrkWBD8IjjEoyJemdrTz6XGLb1SHUNuHclkBLdEmg5
 u2x4D3SZ8a1b+GMQKa9NvuJIVe/jLlw91LOrKvol3aYuuOoG2ONuUVDGDFw1eJW3BpP+
 28EzUTtfDbITwvwy37tzJuyAKzzyvqK9D9NlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795677210; x=1796282010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aVE6uQY9znCYqrgi6+/JSfmRMS1q7/GU0dj9T9uQX+4=;
 b=Uv0pLY+iiuto257qv4lga/3a8YpvVYfhv7VBRlY/IJ76w+aSEsF9sUjgMgq6HKWD8p
 uXLyT33G6U25o64tBdlp/Gdb1cim8jSuG8DMqxzGxtfzgo5lFWmqNnOuVA0rkO/o7qSc
 Nthkq77wLbbA/AvKJKGslZnjZW9ulLGt20Giq8FF/uwPzqOZFO/1gHMst/OPNnWKxg6v
 Z05VtjWR+EDsNq1RoXHn66F2JgGsAc9puc9HPlzln3ft5ljT3Mnc7hBEi0aKV+wLafCt
 fQrHCj+d3IWzibqPgvn/DlWnPiZDxn4S8e7xG0XPD6ggjaCOPGppW7J4khveYn0iEUVZ
 7Q+w==
X-Forwarded-Encrypted: i=1;
 AL+hErGRqpNZw1J2ZZ8enq4FMbc5W8ftHGgQnTmZFvDEPkZTaNCK1gAZPMX2HEzhULLZFwg9fZtqWASAElo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+YgumX6vyYMfWR9iOVz4WLBRx9gtiWUyNi0Pq5L5DiYFHt9bJp
 u3L1pad1UbJqy0DYovsTv5lAcCHDt3dipxlAKMSReOa78ZUR6J2sIDwhrQqeaMoGoA==
X-Gm-Gg: AZFdTZfVuw13K7pOaDyg2NGVKy302f/bQ8uQfgS2sS/9K642X6hj/pkD9S33LqkXrjN
 HQ8cgamhQDK6xXN7yygUg+nX8AK1c9PB6/fzwIK56MgXrfapTas4T3gAwI6wsMBsp4dX0GDhAbp
 ZmKyvHnpgV5lwvagCKosb3SDYLBPnZbiaAu2TgIqDLA8JHnydS/QL7DbHCrPY2AVoAwpKOr87Dj
 NnKQWOKu544NH6WJqXhzb+qsarvXH+U5IxcPNOldYcSNI3fPEgJ6Q5OJTgF71B2a3bU/Z/ajSfP
 +5fRO7ugfDbLU39kTfmMK9X3wIdt9YpRihwKHvQF/RFdCnCgspNsZr4Dk13Rbh5DJltx6WDHBMj
 aBQMc/DlTyfYmSBTVwQxjU84KQbjNMq8RUAHu6hBpm+GMvVKIUamoNDmtSMx5eFwtBi75pWXI9a
 CB8M9xR8+m/68EACVHz+odaIjTrI0tUL/Z9mQFr/vjU6z5hCsEdx8QR/XqgkyTj/MptHASau7o/
 nczwPkJW9/lIw6lWGUOmFien3QFYAfcgWurZUH41rWFc/+oj9LGuDjUN+cY2tkP/5Mv/WsK7g0b
 JRDRj91HTQFgqFdm5waVooSjDJ0TtsOSQByxMk9dxU8BUgueJLJDGzYqgpZg
X-Received: by 2002:a05:6a00:238b:b0:89f:521:8089 with SMTP id
 d2e1a72fcca58-8c87bcbcfebmr18588681b3a.19.1795677210131; 
 Wed, 25 Nov 2026 23:13:30 -0800 (PST)
Received: from localhost ([2a00:79e0:203d:7:418f:e7d0:882d:ceec])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-8c87285b60csm10397352b3a.9.2026.11.25.23.13.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 23:13:29 -0800 (PST)
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
Subject: [PATCH RFT v4 1/5] drm: Split framebuffer pixel offset calculation
 from drm_fb_dma_get_gem_addr()
Date: Thu, 26 Nov 2026 15:12:49 +0800
Message-ID: <20261126071314.253890-2-wenst@chromium.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261126071314.253890-1-wenst@chromium.org>
References: <20261126071314.253890-1-wenst@chromium.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
Cc: stable@vger.kernel.org # dependency for next patch
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
fb->offsets and fb->pitches are (or should have been) checked by the
driver's .fb_create callback, either in drm_gem_fb_init_with_funcs()
or reimplementing the checks directly.

Changes since v2:
- Change offset local variable and return type to u64, and use
  mul_u32_u32() to avoid 32-bit overflow before widening
Changes since v1:
- New patch
---
 drivers/gpu/drm/drm_fb_dma_helper.c | 28 ++----------------
 drivers/gpu/drm/drm_framebuffer.c   | 46 +++++++++++++++++++++++++++++
 include/drm/drm_framebuffer.h       |  3 ++
 3 files changed, 52 insertions(+), 25 deletions(-)

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
index d32aceb6ca9b..589619bd8f0b 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -21,6 +21,7 @@
  */
 
 #include <linux/export.h>
+#include <linux/math64.h>
 #include <linux/uaccess.h>
 
 #include <drm/drm_atomic.h>
@@ -1208,6 +1209,51 @@ void drm_framebuffer_print_info(struct drm_printer *p, unsigned int indent,
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
+u64 drm_framebuffer_get_block_offset(struct drm_framebuffer *fb, unsigned int plane,
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
+	u64 offset;
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
+	offset += mul_u32_u32(fb->pitches[plane], block_start_y);
+	offset += mul_u32_u32(block_size, num_hblocks);
+
+	return offset;
+}
+EXPORT_SYMBOL(drm_framebuffer_get_block_offset);
+
 #ifdef CONFIG_DEBUG_FS
 static int drm_framebuffer_info(struct seq_file *m, void *data)
 {
diff --git a/include/drm/drm_framebuffer.h b/include/drm/drm_framebuffer.h
index 38b24fc8978d..6f838b485730 100644
--- a/include/drm/drm_framebuffer.h
+++ b/include/drm/drm_framebuffer.h
@@ -220,6 +220,9 @@ void drm_framebuffer_remove(struct drm_framebuffer *fb);
 void drm_framebuffer_cleanup(struct drm_framebuffer *fb);
 void drm_framebuffer_unregister_private(struct drm_framebuffer *fb);
 
+u64 drm_framebuffer_get_block_offset(struct drm_framebuffer *fb, unsigned int plane,
+				     unsigned int x, unsigned int y);
+
 /**
  * drm_framebuffer_get - acquire a framebuffer reference
  * @fb: DRM framebuffer
-- 
2.56.1.839.g22a8290db9-goog

