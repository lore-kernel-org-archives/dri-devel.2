Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3C5CD6E60
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 13:58:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5A29112B55;
	Sun, 31 May 2026 13:58:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="p8dC+5+f";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C932710E164
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 07:47:03 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-c85825bbc4fso828696a12.2
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 00:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780213623; x=1780818423; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZZ904ivttfHdS60TN1sr5eWp6rmZB5uxbrG2ujQs++w=;
 b=p8dC+5+fFOoGtfRN9Zlm6nO3J3lphZjPCn7sf7TjhZBLehmwaxL/Lvca9Yjn3yqxZK
 2GKAf6vEJKOB28YkyK80MfMMZJWqaAsiVihjnR7VpyooyvdUyitdfnajedeMrrRAhTM/
 4zR/lx0wDffOFtiXFizXEas6yBbgeEGjR3dtaST5SaDIvgQSw1V0Y+XbPqGvwYgxqw3L
 GvMVRvlH4znJtixfNYUeri/jiWGYEVwP5U+nZDl7lqlFK53/qHR2XcumPxEI271vbZ9X
 AvCcBQ0u1B2sG3U5EYDyI7AG0/o+wX/BpZtIgpwbZddOrNnG352mJKM20e/Y+AZwazHH
 sfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780213623; x=1780818423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZZ904ivttfHdS60TN1sr5eWp6rmZB5uxbrG2ujQs++w=;
 b=SsY84kdPaLMF7hCVaZc7LX8kxsFYFhVPXzP17XsxAe92q3hsXW086SqjUrJhyzwPbJ
 XN5sKKZJBHJWJ2+FnmdQN+RmQQgsmYQJ2rV0cpkqi7bagxOD0TKxHEj3jwH+Xcz4t4JY
 EI1s2GMQvZ66ZUFm9Jueis19kI+wzmJ6YgwC3mDc18jltZ+J5Fy1sXGRBA+cimpQRGz/
 j1e2fLAJuiX12V92r1E2k7JWsCFk1PKBiW4ZrI81SxQtwBYAQkKFIQaGmAoztL8Ak/bP
 2d46YLu33xJhRWbAN/F3iUA7w22gx92IzHxvG+Hi0iE7FLWZ3EbhoPQIv2goybEiRW3Q
 VwHg==
X-Gm-Message-State: AOJu0YyyOIyHLWkMbppgU7/AE765ynwzRKy1NqrUg/G6Ho9IRaLbXGjQ
 o09izxIZ8tZRgKg7qJtwF6gyTSPZq0zk5GdnIofxfvpZyCMQL50lO1Xe+zGMA+x6
X-Gm-Gg: Acq92OHr8Sf3Univ+YjdvATds/DZjGtDrsbeiNFbGGGxG3gjPESLkOYuYpzwFQitLfE
 Ju1D5lCCrNXs7Z1pWKNVdRxUCQ8AlJ/SUlbtndAs3AlII8a/vB21BXj4HTA1yclM4YDgxpgAaPh
 P5liXLVIdz9SftOUMuBimT4Extof98lvo+bdsJGTIXjlyeb+EYhvPSWQ0NvQ/wVQsRxxz8NBtEk
 hWH5J2w3qR91rfW0y/Xo0E20KVFdwZ+AklxQ7Gb52/uGzaRGPv8Thor1trZg96StwNTC6u2PtU+
 doUB4vzt45+2u9NNI2DyRf+//XjC/pnh+XLcEDOm4taUVvGSo/gwyPoCiZPHpcLoHUo2AW6pK3T
 mIcmu5h6aRr0UcpA3RQ+TOIVQFTYcM6W1OZDyMcNa5jnnsJuyGiLqp9EPi9TSz0Jax11Zt5HFtM
 KG1LS2M4k5ktTlQvVy10sSfvCwi5DzoY317DdsncMqOw==
X-Received: by 2002:a05:6a00:a211:b0:82d:162c:581f with SMTP id
 d2e1a72fcca58-84225a087c4mr5251686b3a.48.1780213623224; 
 Sun, 31 May 2026 00:47:03 -0700 (PDT)
Received: from Naman.Naman ([2401:4900:1f39:4c4a:1e56:d301:ce43:ac25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84246844780sm933636b3a.30.2026.05.31.00.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 00:47:02 -0700 (PDT)
From: Naman Arora <namanarora029@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: tzimmermann@suse.de, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch, neil.armstrong@linaro.org,
 khilman@baylibre.com, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Naman Arora <namanarora029@gmail.com>
Subject: [PATCH 6/6] drm/meson: Open-code drm_simple_encoder_init() in
 encoder_dsi
Date: Sun, 31 May 2026 13:16:27 +0530
Message-Id: <20260531074627.8936-3-namanarora029@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260531074627.8936-1-namanarora029@gmail.com>
References: <20260531073532.8609-1-namanarora029@gmail.com>
 <20260531074627.8936-1-namanarora029@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 31 May 2026 13:58:31 +0000
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

The helper drm_simple_encoder_init() is a thin wrapper around
drm_encoder_init() with a simple destroy-only encoder funcs struct.
Remove the dependency on drm_simple_kms_helper by open-coding the
encoder initialization directly in the driver.

Signed-off-by: Naman Arora <namanarora029@gmail.com>
---
 drivers/gpu/drm/meson/meson_encoder_dsi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_encoder_dsi.c b/drivers/gpu/drm/meson/meson_encoder_dsi.c
index eba246791..e14da1f71 100644
--- a/drivers/gpu/drm/meson/meson_encoder_dsi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_dsi.c
@@ -10,7 +10,6 @@
 #include <linux/of_graph.h>
 
 #include <drm/drm_atomic_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_bridge_connector.h>
 #include <drm/drm_device.h>
@@ -99,6 +98,10 @@ static const struct drm_bridge_funcs meson_encoder_dsi_bridge_funcs = {
 	.atomic_reset = drm_atomic_helper_bridge_reset,
 };
 
+static const struct drm_encoder_funcs meson_encoder_dsi_drm_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 int meson_encoder_dsi_probe(struct meson_drm *priv)
 {
 	struct meson_encoder_dsi *meson_encoder_dsi;
@@ -133,8 +136,9 @@ int meson_encoder_dsi_probe(struct meson_drm *priv)
 	meson_encoder_dsi->priv = priv;
 
 	/* Encoder */
-	ret = drm_simple_encoder_init(priv->drm, &meson_encoder_dsi->encoder,
-				      DRM_MODE_ENCODER_DSI);
+	ret = drm_encoder_init(priv->drm, &meson_encoder_dsi->encoder,
+			       &meson_encoder_dsi_drm_encoder_funcs,
+			       DRM_MODE_ENCODER_DSI, NULL);
 	if (ret)
 		return dev_err_probe(priv->dev, ret,
 				     "Failed to init DSI encoder\n");
-- 
2.20.1

