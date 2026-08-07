Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64901C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 10:48:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6582210E2FD;
	Fri,  7 Aug 2026 10:48:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Mqqmen9u";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E710510E2FD
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 10:48:27 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so3145170a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 03:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786099707; x=1786704507;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8LAC89Pa2inBFGUYibeK6Z3jEuTy6YAb4F0fhnyfSBc=;
 b=Mqqmen9uOxD8mUsPr+oaig8FbV4sapEAskod2Z1HCEEkTwaET1hVCJ4tkJCmk8bxTl
 zb2ZalXDVOCNkePWgdl17B6jAA+GLHZh3G9EOYMTATSu1C9chDQZv4+OUqNbfHeG+ccv
 k0mAlUwzAIafJaCOU82Cp1AvcnUX8WpdbWiIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786099707; x=1786704507;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8LAC89Pa2inBFGUYibeK6Z3jEuTy6YAb4F0fhnyfSBc=;
 b=Q171BuejzyG0N0HqPqWkX8YA7N7bzfObq4Xej2/fOCFvvdNzoaf9YLaUp2h6Dod8JR
 fz9XyAZsFcyKeStW/ShP9xVgcwjNHFS3Ddn/tQ4ooM+ZXWT3DY51P3njMw/hrVuzQ6Ym
 /XGDTr6UsUeoLeux1ETNpoj1WLCkb0YTMhllxSkBta/3ViFzhA2HoSme3O0KlM85Cm8B
 NMAw+DOdf7IjRYyKJ72SObJ8soP4VyJ18WSflcta72fhuRINp7ipo80xKksQK5TsLoNf
 ADcZ6NDd3t/p4xeJhIbkeenyaPvGaBWxMbsafG515wIwP7KM4aUzQazTMpDVNjjF9tk9
 kxJQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrjcv26ZCDDrw/3xncxEey3K8sL5GdWoAOVfif6W/m6En8YWutQ7ar4pvWLmjgmoVGfb0SurL8IJKE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzToqZ6ydt7wXkNfOIWbotx0npspjwHAscl+YvQhTtGOOB/Caj/
 Kja3bVENfgsz8rbEPDjyhaQcrZrOIEURoOMK6RVN1R58fNdJNZVtrtbwowHBt9gYboTnS6XO+36
 X8P3vIw==
X-Gm-Gg: AR+sD11I6ckUS4jCJn9aTix5tGyZQTG5ABX8BrXj23RK6lV3jX1Tx1AYUsFRCsfpZLX
 la+c8BWSmeMbzL9MH+vhrLy0OS7j2n+V0R46XcQAKPNr7NiGO5miMNBX/lMoLu6E7ewaXG5bwor
 GeM9PSeUvxHtObJLQ7KA5ItFIeghzOIeeAOvomd3U2rR8eccIP8i3SwK8bBiQ7QV+f9uCy9zq8T
 hcq3oys+YLeRvAvq2GHT7JmGo3UqzNJ3uCHdnpKiCVPhQH8frwHDoBM8kcI+D17SWiK0f0omNaB
 wGGzsc4N409hzZfI+pjGCNDL5rQain4TUB8q4LElIz+S4JLQ4IYk0EjCwkCnOiPlCdjm8tMQnXV
 fj3ZPOtYB6/M7dSy1sAR1tFOfeFM2bciG9TA8dHYS43kGpFx30/IlbJ5OfG4JAgOs17N4uukVQL
 mUEj2B45dnj2pUaIclw/7E8n6t+7RSj4sE4D57AS2o+PLBub8pYppqz7FF0jXbfyUdljDxdYfqw
 YRVLH37x/byBLaIXwoHsvNuW1La/H6zeo6FhX8c1IAKAA==
X-Received: by 2002:a17:90b:5251:b0:38e:4cb:51f with SMTP id
 98e67ed59e1d1-3903c59212bmr22546372a91.11.1786099707376; 
 Fri, 07 Aug 2026 03:48:27 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:3622:c86b:3bef:6958])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-390b37eac8csm957518a91.4.2026.08.07.03.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 03:48:26 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH RFC] drm/verisilicon: Switch to drm_fb_dma_get_addr() for
 framebuffer addresses
Date: Fri,  7 Aug 2026 18:48:18 +0800
Message-ID: <20260807104819.1295812-1-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
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

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---

This is only compile tested. I do not have the hardware.
---
 drivers/gpu/drm/verisilicon/vs_cursor_plane.c |  3 ++-
 drivers/gpu/drm/verisilicon/vs_plane.c        | 20 -------------------
 .../gpu/drm/verisilicon/vs_primary_plane.c    |  6 +++++-
 3 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
index fa4f601dd0c8..ae03d415d66b 100644
--- a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
+++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
@@ -176,7 +176,8 @@ static void vs_cursor_plane_atomic_update(struct drm_plane *plane,
 		break;
 	}
 
-	dma_addr = vs_fb_get_dma_addr(fb, &state->src);
+	/* hardware handles clipping as seen below */
+	dma_addr = drm_fb_dma_get_gem_addr(fb, 0);
 
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
diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
index 1f2be41ae496..46653469caaf 100644
--- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
+++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
@@ -126,7 +126,11 @@ static void vs_primary_plane_atomic_update(struct drm_plane *plane,
 			   VSDC_FB_CONFIG_UV_SWIZZLE_EN,
 			   vs_state->format.uv_swizzle);
 
-	dma_addr = vs_fb_get_dma_addr(fb, &state->src);
+	/*
+	 * Primary plane cannot be moved, no clipping is involved,
+	 * so the non-clipped framebuffer address can be used.
+	 */
+	dma_addr = drm_fb_dma_get_gem_addr(fb, 0);
 
 	regmap_write(dc->regs, VSDC_FB_ADDRESS(output),
 		     lower_32_bits(dma_addr));
-- 
2.55.0.654.g21b8a5bc05-goog

