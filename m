Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D453CDE004
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61E2210EDD5;
	Wed, 24 Jun 2026 07:47:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rLM0fado";
	dkim-atps=neutral
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF91610EB53
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 13:19:57 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-693c51a8a19so8759868a12.3
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 06:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782220796; x=1782825596; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/Y6PphOb9ZABROa1QGn6/qy2YxlaF9xxkPzHynumORE=;
 b=rLM0fadoI73OO7N5avtxcJ74StscCga9rwVBJXWddgLf0NTVh9UKIuidu2nTmMn+DQ
 HE+PFRDydbEacrAvcligp/zRBk+a5nSkxDTFstNLj/mTni9/vj4gR66F+4A/YGRlQIHR
 Dj5alscF4XawXF5Kh+Gw2QK0nmDVzpMBJDeG/Y0FuZYL78CbF34emVL04NtCJ4OmKCey
 hi4C/IUD4tZd3ozBKsvn+luV1aCK6m+CM9uZpfakhqqdTMXlNopPcAH6r0HxoEwehYND
 p7vpBrP/KPrDbORv79rSfqIgr1C4a4QKf2IoloiLGkF7P9q4PpvmodUI0TC6Z/bs5rnK
 YUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782220796; x=1782825596;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/Y6PphOb9ZABROa1QGn6/qy2YxlaF9xxkPzHynumORE=;
 b=XgNg4VsUGb2ng3GXPW1s0w3cVcYM5t+NX60aneqFWeuVJCUPhf4HOUxpVckHdXq61O
 Lh0LU30LX8+Z6W+l5xCA0p8LONM8ABc1B0+5X0KeKDSxHgJ5pJ6uOFvwFqzpD5e77RL6
 g4yndI9XbPbRNEn73AmrJmXKlSJvY16x3HFnZD/K5wGcpAtfpcsqC0f3MYiy85kynjpr
 KOP8I7ilTZF4S+/qlJU9rb1b1c0j+phcie+N7Qn9bqAkuqHfsp4W8d5I6DLDVL1sHHp0
 ZP6bqZpxhxZy2rWssXwjFZqNhp5/nHP6xasjqEhyIAHZpyiZrMwCLNsalepOKtwNJgSU
 Ov0Q==
X-Gm-Message-State: AOJu0YzSbuSyAnTv9vj2v6Fm431KwtUr4pC73hn+GNfqbLsaMF3IkyXS
 cMJtCFPV8s/qtqZjMo28Oh4QUQdZk2nD9bIH2A6x52cpWupfAznImr7f
X-Gm-Gg: AfdE7cluAlKSaFeWZah7BS1RaXH0Rp8DE6Cp8A717x/pnO93BgSQtd6Dur3VYQJK7Ss
 zw/lLRRGB4zEaclY+ZudVfsVBAjb8rH/CC6fvTMR3PekcTS18xJNSaMjerGav3gl9HpeeuVTF3R
 WeAsk13EkfnKBu3Ol0oicgH52FkXo697Lmfue8SA78yO19yIcjNG+ySb0boEGZIDIFGqKwpW704
 d6T7wPoTwuukX0A0GuN2ZeMhutMjgyzkafV02ctqx3Q1JqLae8qxfFn/KgnQgiDZXnushY7Mq+v
 1HtK6KFfEYiQJdpBsYpoCQWLgSXlkaY5Qxc0BwVkBgcrqfLURuxR/9nPfUAD7Qu5+q7VSPsALan
 FxmTo0Drn2Rs2dtoMcOvOJvw4BffSj0iYD82/kKy47WKr9tA1jm6h6WyPSQCVM36iAoGdWt6qlp
 y4ynNd/b4lnE1O7+7KxezF
X-Received: by 2002:a05:6402:2345:b0:697:d4ec:15ed with SMTP id
 4fb4d7f45d1cf-697dbad10c0mr1435510a12.14.1782220796124; 
 Tue, 23 Jun 2026 06:19:56 -0700 (PDT)
Received: from [127.0.0.2] ([194.35.121.133]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6977b82f95dsm5060107a12.3.2026.06.23.06.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 06:19:55 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Tue, 23 Jun 2026 15:19:31 +0200
Subject: [PATCH v2 2/2] drm/exynos: Add error handling to
 drm_encoder_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-exynos-drm-simple-v2-2-a8d59678b7d2@gmail.com>
References: <20260623-exynos-drm-simple-v2-0-a8d59678b7d2@gmail.com>
In-Reply-To: <20260623-exynos-drm-simple-v2-0-a8d59678b7d2@gmail.com>
To: Jingoo Han <jingoohan1@gmail.com>, Inki Dae <inki.dae@samsung.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Diogo Silva <diogompaissilva@gmail.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Wed, 24 Jun 2026 07:47:57 +0000
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

Not handling the return code on drm_encoder_init can lead to silent
failure and/or a drm_encoder_cleanup on a non-initialized encoder.
This patch adds error handling to the drm_encoder_init calls to prevent
that from happening.

Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
---
 drivers/gpu/drm/exynos/exynos_dp.c       | 8 ++++++--
 drivers/gpu/drm/exynos/exynos_drm_dpi.c  | 9 +++++++--
 drivers/gpu/drm/exynos/exynos_drm_dsi.c  | 6 ++++--
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 9 +++++++--
 drivers/gpu/drm/exynos/exynos_hdmi.c     | 9 +++++++--
 5 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/exynos_dp.c
index a2095fb43483..1598892c602b 100644
--- a/drivers/gpu/drm/exynos/exynos_dp.c
+++ b/drivers/gpu/drm/exynos/exynos_dp.c
@@ -99,8 +99,12 @@ static int exynos_dp_bind(struct device *dev, struct device *master, void *data)
 
 	dp->drm_dev = drm_dev;
 
-	drm_encoder_init(drm_dev, encoder, &exynos_dp_encoder_funcs,
-			 DRM_MODE_ENCODER_TMDS, NULL);
+	ret = drm_encoder_init(drm_dev, encoder, &exynos_dp_encoder_funcs,
+			       DRM_MODE_ENCODER_TMDS, NULL);
+	if (ret) {
+		dev_err(dp->dev, "Failed to initialize encoder\n");
+		return ret;
+	}
 
 	drm_encoder_helper_add(encoder, &exynos_dp_encoder_helper_funcs);
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_dpi.c b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
index 4a3d443a15e6..4e42a1da81d1 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dpi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
@@ -198,8 +198,13 @@ int exynos_dpi_bind(struct drm_device *dev, struct drm_encoder *encoder)
 {
 	int ret;
 
-	drm_encoder_init(dev, encoder, &exynos_dpi_encoder_funcs,
-			 DRM_MODE_ENCODER_TMDS, NULL);
+	ret = drm_encoder_init(dev, encoder, &exynos_dpi_encoder_funcs,
+			       DRM_MODE_ENCODER_TMDS, NULL);
+	if (ret) {
+		DRM_DEV_ERROR(encoder_to_dpi(encoder)->dev,
+			      "failed to create encoder ret = %d\n", ret);
+		return ret;
+	}
 
 	drm_encoder_helper_add(encoder, &exynos_dpi_encoder_helper_funcs);
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index 25c438cdc744..6b7561ac9bb0 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -83,8 +83,10 @@ static int exynos_dsi_bind(struct device *dev, struct device *master, void *data
 	struct drm_device *drm_dev = data;
 	int ret;
 
-	drm_encoder_init(drm_dev, encoder, &exynos_drm_dsi_encoder_funcs,
-			 DRM_MODE_ENCODER_TMDS, NULL);
+	ret = drm_encoder_init(drm_dev, encoder, &exynos_drm_dsi_encoder_funcs,
+			       DRM_MODE_ENCODER_TMDS, NULL);
+	if (ret)
+		return ret;
 
 	ret = exynos_drm_set_possible_crtcs(encoder, EXYNOS_DISPLAY_TYPE_LCD);
 	if (ret < 0)
diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index d905dc703c06..59dea853d364 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -449,8 +449,13 @@ static int vidi_bind(struct device *dev, struct device *master, void *data)
 		return PTR_ERR(ctx->crtc);
 	}
 
-	drm_encoder_init(drm_dev, encoder, &exynos_vidi_encoder_funcs,
-			 DRM_MODE_ENCODER_TMDS, NULL);
+	ret = drm_encoder_init(drm_dev, encoder, &exynos_vidi_encoder_funcs,
+			       DRM_MODE_ENCODER_TMDS, NULL);
+	if (ret) {
+		DRM_DEV_ERROR(dev, "failed to initialize encoder ret = %d\n",
+			      ret);
+		return ret;
+	}
 
 	drm_encoder_helper_add(encoder, &exynos_vidi_encoder_helper_funcs);
 
diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 26baf5357997..f44586ce0fdf 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -1867,8 +1867,13 @@ static int hdmi_bind(struct device *dev, struct device *master, void *data)
 
 	hdata->phy_clk.enable = hdmiphy_clk_enable;
 
-	drm_encoder_init(drm_dev, encoder, &exynos_hdmi_encoder_funcs,
-			 DRM_MODE_ENCODER_TMDS, NULL);
+	ret = drm_encoder_init(drm_dev, encoder, &exynos_hdmi_encoder_funcs,
+			       DRM_MODE_ENCODER_TMDS, NULL);
+	if (ret) {
+		DRM_DEV_ERROR(dev, "failed to initialize encoder ret = %d\n",
+			      ret);
+		return ret;
+	}
 
 	drm_encoder_helper_add(encoder, &exynos_hdmi_encoder_helper_funcs);
 

-- 
2.51.2

