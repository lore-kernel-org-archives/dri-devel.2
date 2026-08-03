Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41C9C5518F
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 13:52:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08B1A10E5E5;
	Mon,  3 Aug 2026 13:52:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZbG5CFDK";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF99610E5E5
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 13:52:57 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2ceb096e675so39826195ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 06:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785765177; x=1786369977;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KP2LOm/b1vDApC79L7HU3Q+z5sMfbtyywYlbaxYaS3U=;
 b=ZbG5CFDK0mJquv09ZtgJTCyE0kx3pl5sm08M79797O6jm1AH8pdEsJknfrv5zTl/Fd
 VqvBHNLMcdcHrZ2J2P+l/BkwK1XIyUNDLGsPUYSzCKBs0VRwhcXyW1UdAGFPB0fu2d7X
 /9cgbQErmstUApe+H+01OkjgSZSfFTSuBxrTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785765177; x=1786369977;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KP2LOm/b1vDApC79L7HU3Q+z5sMfbtyywYlbaxYaS3U=;
 b=os6l/D5Ked1hJwOvWJZ1fw2aNdemdDGp0GsD8Ly3Aya9RjbS+WGsFCxMUmpV6ukVQq
 uI7LQHtVHEujy8ie92QZ/V71dyIe3R+Pz7RZr69Y2tQkk1AlJkIFLAnzGgoBNI7avoXw
 JxH0+qlzW273tcUks5PI2OUcuRcSbOFY6e0TroGVvfKBjMR6TTXxfUII4Ja79mlOJu3i
 l25qvkVWI4cZqR42QgA6JgFrXsldjMydZxtjZQ4hRPuOIpW3MCsKLLQwUckl4cCV9nC7
 kYG+lSW8ZRNVmAOVrZR11SeBqGvJ0/DaFqXOaAbxwLJNbFMQ+yZcynkqxDOvBMnq7rcK
 B8ww==
X-Forwarded-Encrypted: i=1;
 AHgh+RpsQRjauw8/TiW5FuGssWZUvp28LwmOSGQTg5ZA3xtBNj8MlicXYzPkfPxeR7o2GCmV/YMAVBrDKo8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywzl2BKmjbkdA9pk/3cOKzRNxAuG4SC0ZXhHs1NaxKZrdeU32Ck
 7A4W8ieAH7TVNvtZfPqB0lawQv7u5zk31YO1CtNilik9dNAJXHXjY/MV01pEssbrfg==
X-Gm-Gg: AR+sD12MRpJRMotVrTpZpzc/WqVhagXj8RY/bKnV6CE5STWIShZYbve70ReT2jSuktS
 FusOWIciiZ9A44aSNHUTjIK2DrFvHndqhgJGCvYxSmHgdHko2vnUvPrjjr2h1/oPxTL7zfHbga4
 UlZd1ITWg9LeJ7B+I30Xkg1B/Llrl1g2aF9Le2kvYdEOUhXktdgiVej4HsLdP6LRPL5l3Vk8Lsv
 ISqpkuZJZ2FD6IWRPYsczbyW3Qx6VgSHRNQaCsOrEGOhOtAzP7CylCxXxKZY3dF2EiizDIgc+jY
 nYHeIxATTQ0b3TcztLIJo9/CPD/Nf52lwSe2NrBmV8PaLrv8LypuV3Pxrrapez5FaZqe218yNjQ
 5qhNJDRA7ZoFYvA0VHzLlmOYXK6azcrNR3ZwyNbLDM3hwVCMg2eoWi/+zzSaXhd+VklUMOJ6PkA
 vnLlmm02PTIwRK73iAubyk8JY8MoHof5OejTgtxh3SNBfOiRxV5AdGUWS+TEVwM6QhjxHt2wm7l
 kUBm4EeZiZIthLdHpwMuTV9bIJq/CxhFgMXEYI6nQy5D2gaxKmHhoPL
X-Received: by 2002:a17:902:ce0b:b0:2cc:f4d4:299f with SMTP id
 d9443c01a7336-2d05229b34fmr106179645ad.27.1785765177126; 
 Mon, 03 Aug 2026 06:52:57 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:1c0b:57ba:92e2:e178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04b12066fsm38791965ad.60.2026.08.03.06.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 06:52:56 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/exynos: Set supported modifiers during plane init
Date: Mon,  3 Aug 2026 21:52:47 +0800
Message-ID: <20260803135249.2898083-1-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
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

The exynos driver currently checks the modifier in a helper called by
the plane atomic check helper callback. This check only concerns whether
the selected plane supports the tiled format or not. This is tied to
the plane's hardware capability.

Turns out the tiled support was added around the same time modifiers
were being plumbed through DRM planes. The latter provided a way to
describe per-plane modifier support.

Add a field to the hardware plane capability struct to allow adding
an optional list of supported modifiers. This is passed to
drm_universal_plane_init(). This also allows the core to generate
and pass to userspace a list of supported modifiers for each plane.

EXYNOS_DRM_PLANE_CAP_TILE and the existing helper are removed, as the
check is now down by the DRM atomic check.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/exynos/exynos_drm_drv.h   |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_plane.c | 30 +----------------------
 drivers/gpu/drm/exynos/exynos_mixer.c     |  8 +++++-
 3 files changed, 9 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.h b/drivers/gpu/drm/exynos/exynos_drm_drv.h
index b126cd129944..ab0edb826261 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_drv.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_drv.h
@@ -92,7 +92,6 @@ struct exynos_drm_plane {
 #define EXYNOS_DRM_PLANE_CAP_DOUBLE	(1 << 0)
 #define EXYNOS_DRM_PLANE_CAP_SCALE	(1 << 1)
 #define EXYNOS_DRM_PLANE_CAP_ZPOS	(1 << 2)
-#define EXYNOS_DRM_PLANE_CAP_TILE	(1 << 3)
 #define EXYNOS_DRM_PLANE_CAP_PIX_BLEND	(1 << 4)
 #define EXYNOS_DRM_PLANE_CAP_WIN_BLEND	(1 << 5)
 
@@ -112,6 +111,7 @@ struct exynos_drm_plane_config {
 	const uint32_t *pixel_formats;
 	unsigned int num_pixel_formats;
 	unsigned int capabilities;
+	const uint64_t *modifiers;
 };
 
 /*
diff --git a/drivers/gpu/drm/exynos/exynos_drm_plane.c b/drivers/gpu/drm/exynos/exynos_drm_plane.c
index 5c04ef87e400..31f5f0941154 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_plane.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_plane.c
@@ -174,30 +174,6 @@ static struct drm_plane_funcs exynos_plane_funcs = {
 	.atomic_destroy_state = exynos_drm_plane_destroy_state,
 };
 
-static int
-exynos_drm_plane_check_format(const struct exynos_drm_plane_config *config,
-			      struct exynos_drm_plane_state *state)
-{
-	struct drm_framebuffer *fb = state->base.fb;
-	struct drm_device *dev = fb->dev;
-
-	switch (fb->modifier) {
-	case DRM_FORMAT_MOD_SAMSUNG_64_32_TILE:
-		if (!(config->capabilities & EXYNOS_DRM_PLANE_CAP_TILE))
-			return -ENOTSUPP;
-		break;
-
-	case DRM_FORMAT_MOD_LINEAR:
-		break;
-
-	default:
-		DRM_DEV_ERROR(dev->dev, "unsupported pixel format modifier");
-		return -ENOTSUPP;
-	}
-
-	return 0;
-}
-
 static int
 exynos_drm_plane_check_size(const struct exynos_drm_plane_config *config,
 			    struct exynos_drm_plane_state *state)
@@ -245,10 +221,6 @@ static int exynos_plane_atomic_check(struct drm_plane *plane,
 	/* translate state into exynos_state */
 	exynos_plane_mode_set(exynos_state);
 
-	ret = exynos_drm_plane_check_format(exynos_plane->config, exynos_state);
-	if (ret)
-		return ret;
-
 	ret = exynos_drm_plane_check_size(exynos_plane->config, exynos_state);
 	return ret;
 }
@@ -312,7 +284,7 @@ int exynos_plane_init(struct drm_device *dev,
 				       &exynos_plane_funcs,
 				       config->pixel_formats,
 				       config->num_pixel_formats,
-				       NULL, config->type, NULL);
+				       config->modifiers, config->type, NULL);
 	if (err) {
 		DRM_DEV_ERROR(dev->dev, "failed to initialize plane\n");
 		return err;
diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index 69dea5049309..d74e605a452b 100644
--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -93,6 +93,12 @@ static const uint32_t vp_formats[] = {
 	DRM_FORMAT_NV21,
 };
 
+static const uint64_t vp_modifiers[] = {
+	DRM_FORMAT_MOD_LINEAR,
+	DRM_FORMAT_MOD_SAMSUNG_64_32_TILE,
+	DRM_FORMAT_MOD_INVALID
+};
+
 struct mixer_context {
 	struct platform_device *pdev;
 	struct device		*dev;
@@ -148,8 +154,8 @@ static const struct exynos_drm_plane_config plane_configs[MIXER_WIN_NR] = {
 		.num_pixel_formats = ARRAY_SIZE(vp_formats),
 		.capabilities = EXYNOS_DRM_PLANE_CAP_SCALE |
 				EXYNOS_DRM_PLANE_CAP_ZPOS |
-				EXYNOS_DRM_PLANE_CAP_TILE |
 				EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
+		.modifiers = vp_modifiers,
 	},
 };
 
-- 
2.55.0.571.g244d577d93-goog

