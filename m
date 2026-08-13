Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B30C5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 06:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8726D10E0E1;
	Thu, 13 Aug 2026 06:51:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O88jV4Tc";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17F1310E0E1
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 06:51:34 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-38e347638adso536955a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 23:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786603893; x=1787208693;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=j+N9yE6d7rB5JmWfr2wLA+1fKPLxUmtPAdPhKfD0XGE=;
 b=O88jV4TcrXfRIUp5+qYfShzhEL8iUsAHNUiJsFFvkX7BaDs3hk7MqUSLUZNQk3/mrg
 nQqirTlZ/tSNcCcZNxCPur2WwuVlB9t5HoIW5mTZW2XO1TFbPwQcss5qpS+nuWQGyoAx
 9fwy4evvPcI11LKHI8/5SwWe2SIUjUzAYaiFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786603893; x=1787208693;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j+N9yE6d7rB5JmWfr2wLA+1fKPLxUmtPAdPhKfD0XGE=;
 b=eb0AacJm1CPp2rtbcjnKIR9USTVRzkrFHXO6g3sMso7WU/3kZod2bHu+Z9EEJlztOo
 OLsedFweVw0L+51NqueQXHxw24g8n1t2aLC3EkaYg2gO957gjIePD882PddfVoH+bn+u
 sl9AgFQByZ9ubSq9rpdoYfrkQ32RQQimO8S8puO6tuG2cQar5ddKlrnr1giqmHKkmKCf
 YneQhblfo4SwWmwMP/KOYyKN5E5/f2u6Oh/UNzHz2cc1bu0zyxzJy0rthStCqsDbcvnt
 Q3LNp37KovBWpTbwv+Q6e07ZDVxskAXdKvy+n7UHAIp+uvHsVcIqbPsXZmQ0aiVDKCCt
 2Jrg==
X-Forwarded-Encrypted: i=1;
 AHgh+RroOgGS3fdyNHCBEBCuByojU9C/BriLy+QnTE88Rxm3km1P8Bjf5/030ADQeuLFRuVE0uQSNoeSKt4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzhlSDQpTrUl2ifzBRddmssS8KU10KK7IthJLAHl5tygtm5RPII
 1pWvsOJ3z+iPGbXdepUcj4R4RkmPYS1oRi9Vjz75mdeuY8AjkcNrBFFBEN6ox9pfng==
X-Gm-Gg: AR+sD12qCI0b0LvXNdyprzSlyX58GkR9n5q/AeH0RaOgzy8lbjJ7CpCPl6RrbIvxZy2
 F7D1QrmwBqR4pWq1V2SGgOrwtzBlZLJUIPfz6QrSKHxugs6/mOLngObolr7D45xnXjFUzoYldi9
 CIOLTDv+CqBfJJX0YCHbKq18ywaEJynFYKvTgAF+XxD6wwmj+sPS4JPa8UkKgLc5nfvw4hved8u
 lE+4q/FOkF+1tX9isko3ALAmqHSu3j6weZGluORZLdeeVsQFZuEEO6ZfyuDIyRthqwQxygkBAVU
 bmkuOZJJJk/LvRdnQgh2cMQz8OtdqMqAGRquuh7AzQiUxRm7YNs3rDnCbb8yny/F8npM5/bArts
 MZ8O2QEWmBZ7WvQhL3WuZHycolwVOfZEnfuA2zlGPEUmS6QhYfh6jOelQj+O130OlIhkV9mLB66
 c35wIdL6lOtzgSJPB6ji3uD67riuebHRqx3sUNcOIPWdJgapJTo2fypYCZm1RlAUj8L1SczWxiq
 UWzRFPMpHsOm9gfLkXHygIRpkvhzxXn9tVhnhyQojzX
X-Received: by 2002:a17:90b:4d08:b0:38d:dfd1:7a8 with SMTP id
 98e67ed59e1d1-3931dfd7b73mr4150306a91.2.1786603893446; 
 Wed, 12 Aug 2026 23:51:33 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:61f:1b11:5c48:d758])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931f44de1esm1694814a91.13.2026.08.12.23.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 23:51:32 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3] drm/verisilicon: Switch to drm_fb_dma_get_addr() for
 framebuffer addresses
Date: Thu, 13 Aug 2026 14:51:26 +0800
Message-ID: <20260813065127.341349-1-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
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

The verisilicon driver has a custom framebuffer address calculating
helper that the common drm_fb_dma_get_addr() can substitute.

Differences from drm_fb_dma_get_addr():

- Uses drm_format_info_min_pitch() to calculate the horizontal offset;
  however the driver does not support any of the blocked formats, so
  this just ends up being the same as in drm_fb_dma_get_addr():
  "cpp[plane] * y"

- Uses clipped source coordinates instead of non-clipped coordinates
  as in drm_fb_dma_get_addr();

  For the primary plane this doesn't matter, since the primary plane
  must match the output, i.e. it cannot be clipped. Also this driver
  doesn't support scaling.

  For the cursor plane this seems wrong, as the clipping seems to be
  done by the hardware, and thus the buffer address should be unclipped.

As such, it should be fine to use the common helper and drop the custom
code.

Tested-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Reviewed-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Fixes: 8c4ae2189125 ("drm: verisilicon: add support for cursor planes")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- Dropped vs_fb_get_dma_addr() prototype from header (Sashiko)

Changes since v1:
- Fixed compile issues

Compile tested by me. I do not have the hardware. Icenowy tested on
actual hardware.
---
 drivers/gpu/drm/verisilicon/vs_cursor_plane.c |  4 +++-
 drivers/gpu/drm/verisilicon/vs_plane.c        | 20 -------------------
 drivers/gpu/drm/verisilicon/vs_plane.h        |  2 --
 .../gpu/drm/verisilicon/vs_primary_plane.c    |  7 ++++++-
 4 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
index fa4f601dd0c8..59778433ae84 100644
--- a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
+++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
@@ -12,6 +12,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_fb_dma_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_atomic_helper.h>
@@ -176,7 +177,8 @@ static void vs_cursor_plane_atomic_update(struct drm_plane *plane,
 		break;
 	}
 
-	dma_addr = vs_fb_get_dma_addr(fb, &state->src);
+	/* hardware handles clipping as seen below */
+	dma_addr = drm_fb_dma_get_gem_addr(fb, state, 0);
 
 	regmap_write(dc->regs, VSDC_CURSOR_ADDRESS(output),
 		     lower_32_bits(dma_addr));
diff --git a/drivers/gpu/drm/verisilicon/vs_plane.c b/drivers/gpu/drm/verisilicon/vs_plane.c
index d81f7b8f4c65..38b8b536eccb 100644
--- a/drivers/gpu/drm/verisilicon/vs_plane.c
+++ b/drivers/gpu/drm/verisilicon/vs_plane.c
@@ -107,26 +107,6 @@ int drm_format_to_vs_format(u32 drm_format, struct vs_format *vs_format)
 	return 0;
 }
 
-dma_addr_t vs_fb_get_dma_addr(struct drm_framebuffer *fb,
-			      const struct drm_rect *src_rect)
-{
-	struct drm_gem_dma_object *gem;
-	dma_addr_t dma_addr;
-
-	/* Get the physical address of the buffer in memory */
-	gem = drm_fb_dma_get_gem_obj(fb, 0);
-
-	/* Compute the start of the displayed memory */
-	dma_addr = gem->dma_addr + fb->offsets[0];
-
-	/* Fixup framebuffer address for src coordinates */
-	dma_addr += drm_format_info_min_pitch(fb->format, 0,
-					      src_rect->x1 >> 16);
-	dma_addr += (src_rect->y1 >> 16) * fb->pitches[0];
-
-	return dma_addr;
-}
-
 struct drm_plane_state *vs_plane_duplicate_state(struct drm_plane *plane)
 {
 	struct vs_plane_state *vs_state, *vs_state_old;
diff --git a/drivers/gpu/drm/verisilicon/vs_plane.h b/drivers/gpu/drm/verisilicon/vs_plane.h
index 32ed1d70f3b8..e4f82f1fc6e9 100644
--- a/drivers/gpu/drm/verisilicon/vs_plane.h
+++ b/drivers/gpu/drm/verisilicon/vs_plane.h
@@ -75,8 +75,6 @@ static inline struct vs_plane_state *to_vs_plane_state(struct drm_plane_state *s
 }
 
 int drm_format_to_vs_format(u32 drm_format, struct vs_format *vs_format);
-dma_addr_t vs_fb_get_dma_addr(struct drm_framebuffer *fb,
-			      const struct drm_rect *src_rect);
 
 struct drm_plane_state *vs_plane_duplicate_state(struct drm_plane *plane);
 void vs_plane_destroy_state(struct drm_plane *plane,
diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
index 1f2be41ae496..2750016a7f2c 100644
--- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
+++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
@@ -8,6 +8,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_fb_dma_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_atomic_helper.h>
@@ -126,7 +127,11 @@ static void vs_primary_plane_atomic_update(struct drm_plane *plane,
 			   VSDC_FB_CONFIG_UV_SWIZZLE_EN,
 			   vs_state->format.uv_swizzle);
 
-	dma_addr = vs_fb_get_dma_addr(fb, &state->src);
+	/*
+	 * Primary plane cannot be moved, no clipping is involved,
+	 * so the non-clipped framebuffer address can be used.
+	 */
+	dma_addr = drm_fb_dma_get_gem_addr(fb, state, 0);
 
 	regmap_write(dc->regs, VSDC_FB_ADDRESS(output),
 		     lower_32_bits(dma_addr));
-- 
2.55.0.691.gc56d675ccc-goog

