Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13453CDE001
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:48:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6797C10EDD6;
	Wed, 24 Jun 2026 07:47:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="n5i0qd8m";
	dkim-atps=neutral
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 280B710EB11
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 12:50:25 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-695f539fc8cso1561887a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 05:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782219023; x=1782823823; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UKUs6CELJR/1Q1bIKn9jYUW7U/GC0CCNgQj6pM1EaDs=;
 b=n5i0qd8mgnFmQaFVxe2eJ5biGC6vq5qhswDnfibjIDI2pidxe8i4UG++oi1oHL7kNR
 75RgDtkjnXuACb+idLRtraqxObLXKS2/8L5hrzf+jiuD2nM+n6LrR634YvdnqI8abW/z
 gXNf6gE67DonmJrxAADmelbe9ucBqt//QYRBddcwXJbSkIJ5PWqczw7kqTIvi/1CbMVb
 IILySybwUgE9klmxi/ASuEXQypVqh2jIOgJo0f00Cv9/FmrmZ6478FTadUGH0s9ISSRS
 OvfsCMXR8mdouk7pxrKJLsU1URM3N0NcdYE9Sh4bdM5B0L1wrGaag6CeYno8qyWhWdCd
 v4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782219023; x=1782823823;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UKUs6CELJR/1Q1bIKn9jYUW7U/GC0CCNgQj6pM1EaDs=;
 b=eVItQ2ODX5AXu6Mp9ZsommztaXwPFlPzvs9BhVwtfo0vnMVbEyknaN2iKzVnbBPu3X
 FLDlWbZugXefV7oXYW9Vw7oiARE628PVEZGHH/wUvkK3/pcoPGgYB28rQ/+yTDjKsKE7
 7/tNKqPaha9y77k1RFTSBHRtSX2qZZSMsrc3vtz/uFFtGtDaw1GCEhhbIkbHejhcj+w3
 vhTSEpNxDdrqzVZDj9OJzjvybg+AJnmhBRUdSAYJQxhk+r/MRk+n5DlKDRJuVmdhwQ2s
 0bV4rJIox3WG8VjK+nat60lZzArtOSOlsss9hIJtBwm42FtrVtmz5eBeCaMvIKfY3DP6
 yJFw==
X-Gm-Message-State: AOJu0YxaUU/dujNDe0bsIayOz85iT7Y8dkxY8AI5210dvYmGpNgf2wYu
 R1xWaZfkHbwnH2KBwNY3HvOaIcwrd577VKXNyHqF68EOzE9HpMLVbkoJ
X-Gm-Gg: AfdE7ckRRFAPqhqvn06MTX+N4aZKaOkJGieKsHkUf73hi9zQapC9ll7gwf+VHAcy1EV
 vNg5PlP6rqx6TU9olDIXXYnXo48QwirHzApWzNAq/MrcNsmaOnn9XD1yAiBufTjR+oWR3ojPjEF
 tAat9qrjatyVsmTsP+u+m2LiUCL2ZT4vUrNso0e6eVrEzngSuIGMEHy2Ya2tX0giYd7kKHhHtY0
 oHVosWnwxHxK4r40VYgCjgIgD1KplQ406Du1Yzd+CEjtNzLxDdprJK97EQKCXb+Xh7ON7lfpg+M
 7dRNtpyK7RJqAKNoNGEjSe2RH73g9hghxRdRAuYBN8YEualIH/RVlBFuePWZmLQx6r4vdBZBNCo
 NRU2VcRV/MxOdgeW78IvBL01qRBL8usYTDm/yFo1ksWPuO/L8S1lVJt32eJZ/lwj0NC+qOYoycB
 2cS0GS4JRwEkCf5jPjlcbO
X-Received: by 2002:a17:907:ec0a:b0:c0f:cbe9:9e7a with SMTP id
 a640c23a62f3a-c10309ba1acmr182459466b.15.1782219023302; 
 Tue, 23 Jun 2026 05:50:23 -0700 (PDT)
Received: from [127.0.0.2] ([194.35.121.133]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6977b82fd6fsm5153967a12.2.2026.06.23.05.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 05:50:22 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Tue, 23 Jun 2026 14:49:44 +0200
Subject: [PATCH 2/2] drm/exynos: Add error handling to drm_encoder_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-exynos-drm-simple-v1-2-bb52f098b1ee@gmail.com>
References: <20260623-exynos-drm-simple-v1-0-bb52f098b1ee@gmail.com>
In-Reply-To: <20260623-exynos-drm-simple-v1-0-bb52f098b1ee@gmail.com>
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
 drivers/gpu/drm/exynos/exynos_dp.c       | 6 +++++-
 drivers/gpu/drm/exynos/exynos_drm_dpi.c  | 7 ++++++-
 drivers/gpu/drm/exynos/exynos_drm_dsi.c  | 4 +++-
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 7 ++++++-
 drivers/gpu/drm/exynos/exynos_hdmi.c     | 7 ++++++-
 5 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/exynos_dp.c
index a2095fb43483..3311674aa32a 100644
--- a/drivers/gpu/drm/exynos/exynos_dp.c
+++ b/drivers/gpu/drm/exynos/exynos_dp.c
@@ -99,8 +99,12 @@ static int exynos_dp_bind(struct device *dev, struct device *master, void *data)
 
 	dp->drm_dev = drm_dev;
 
-	drm_encoder_init(drm_dev, encoder, &exynos_dp_encoder_funcs,
+	ret = drm_encoder_init(drm_dev, encoder, &exynos_dp_encoder_funcs,
 			 DRM_MODE_ENCODER_TMDS, NULL);
+	if (ret) {
+		dev_err(dp->dev, "Failed to initialize encoder\n");
+		return ret;
+	}
 
 	drm_encoder_helper_add(encoder, &exynos_dp_encoder_helper_funcs);
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_dpi.c b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
index 4a3d443a15e6..495fcabca0a1 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dpi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
@@ -198,8 +198,13 @@ int exynos_dpi_bind(struct drm_device *dev, struct drm_encoder *encoder)
 {
 	int ret;
 
-	drm_encoder_init(dev, encoder, &exynos_dpi_encoder_funcs,
+	ret = drm_encoder_init(dev, encoder, &exynos_dpi_encoder_funcs,
 			 DRM_MODE_ENCODER_TMDS, NULL);
+	if (ret) {
+		DRM_DEV_ERROR(encoder_to_dpi(encoder)->dev,
+			      "failed to create encoder ret = %d\n", ret);
+		return ret;
+	}
 
 	drm_encoder_helper_add(encoder, &exynos_dpi_encoder_helper_funcs);
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index 25c438cdc744..73f7c9fe611a 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -83,8 +83,10 @@ static int exynos_dsi_bind(struct device *dev, struct device *master, void *data
 	struct drm_device *drm_dev = data;
 	int ret;
 
-	drm_encoder_init(drm_dev, encoder, &exynos_drm_dsi_encoder_funcs,
+	ret = drm_encoder_init(drm_dev, encoder, &exynos_drm_dsi_encoder_funcs,
 			 DRM_MODE_ENCODER_TMDS, NULL);
+	if (ret)
+		return ret;
 
 	ret = exynos_drm_set_possible_crtcs(encoder, EXYNOS_DISPLAY_TYPE_LCD);
 	if (ret < 0)
diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index b0f3cfc2a283..a639f2ee4933 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -449,8 +449,13 @@ static int vidi_bind(struct device *dev, struct device *master, void *data)
 		return PTR_ERR(ctx->crtc);
 	}
 
-	drm_encoder_init(drm_dev, encoder, &&exynos_vidi_encoder_funcs,
+	ret = drm_encoder_init(drm_dev, encoder, &&exynos_vidi_encoder_funcs,
 			 DRM_MODE_ENCODER_TMDS, NULL);
+	if (ret) {
+		DRM_DEV_ERROR(dev, "failed to initialize encoder ret = %d\n",
+			      ret);
+		return ret;
+	}
 
 	drm_encoder_helper_add(encoder, &exynos_vidi_encoder_helper_funcs);
 
diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 26baf5357997..17323c9233ad 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -1867,8 +1867,13 @@ static int hdmi_bind(struct device *dev, struct device *master, void *data)
 
 	hdata->phy_clk.enable = hdmiphy_clk_enable;
 
-	drm_encoder_init(drm_dev, encoder, &exynos_hdmi_encoder_funcs,
+	ret = drm_encoder_init(drm_dev, encoder, &exynos_hdmi_encoder_funcs,
 			 DRM_MODE_ENCODER_TMDS, NULL);
+	if (ret) {
+		DRM_DEV_ERROR(dev, "failed to initialize encoder ret = %d\n",
+			      ret);
+		return ret;
+	}
 
 	drm_encoder_helper_add(encoder, &exynos_hdmi_encoder_helper_funcs);
 

-- 
2.51.2

