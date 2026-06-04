Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851AACD6E6B
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 07:25:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB53B10E144;
	Fri,  5 Jun 2026 07:25:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qp835M0O";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E13D113FB5
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 12:34:42 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4908b92904fso8090455e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 05:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780576481; x=1781181281; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rRDPEW9sbPRXAPtuKH5War+e9LS+bqZ/3dB+HlmzKJU=;
 b=qp835M0O52yFOltbz5Vzr8BDHcpR4EyTqRNVR2AmjHgCwfYrf7IhvmFIwrGvyk387t
 q9M4VWx+RfNy1Uw4Z2EJYGo/IuRXbly04GhC/zICAH/2UFakNpltQt96Yvf4wbSIYSim
 bpdo+kvaSehYUgZVWFQcwH0uR7wcjKuz//W9eng3Rd9fF25qCJQm2l1kUl1+GPIrO51J
 /PXMjnhuZFQSkCe+Vgco+i96Ln3oL1pZXpvu5PFeXFy+Eg7rAKQnaUVKhCbhty45HxUh
 Iu1EdTlko1t/eazDWjyqbvckVlAcG/+bs5qIAp0TOFdhWfCdpkRWIuXA86pfCUkO0UMR
 P8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780576481; x=1781181281;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rRDPEW9sbPRXAPtuKH5War+e9LS+bqZ/3dB+HlmzKJU=;
 b=WuyCehrb9L9MnRnZdPmZ2Z/EOqOfa8Q3PWJtL4ufykhAD+GvVncvCZuQcN9P79u6JN
 /261CdZzMe6hkxKp9YTq7BdGbWKY6og+CykJqujwnKvi/trzTIBNNU8EyE4aGhrW7b3z
 u+JCGcq18FIFVyEGLg7WM/DBLt8oyeKSZ57mke91NORUiXgMN3bRKGYX2pE5WRphzpZT
 Mdbp9vSssqerz+HNZ1FRi4wx+HZ3Vu2qq5HenKHt99DePXHPgEz7YGjpwA0TsmdtUR3w
 fjrieJwf8TmG71eXJ8J53espPLVzblfLjE8BptL3TvaFeCeYn5IDDoBIFXnZzw7+ClTs
 A70w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8RGCkSY5BRVC1uiqgoJrRSZe4Om0psRppA4QIc3nVDfSSEghHhQwzc+JOnizpiWf9veao6Nf9tO5M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywrv+zdAPaa9uusBdoAkeKMaD3HFPmuwDcLQfHB2RFgsSS1hCiu
 3Afgcdhlr656n3T6pKUzA1sm2LWYA2McIOy4wWoBhSouOBJ/FQEKKLO0
X-Gm-Gg: Acq92OGZDi1Mcj6vrjz0SJ7PuQjLSEH9Kg9XSg/K32tG0ClwyJpNf9C7L72XEwdSNLN
 Pogcxbz/0XZNiRb4YlLj5q8idP27cjl9iIIu0V3mdWYoX1sV6XEGLTI5jWP0hqt9FxQeZPxEMMu
 yJgnGw8uRq81YQm3vTKLIrfgQBR+ek96v+81E0TDScmvTPDJCIP416VH4Bif7ldO3vXE4CwRQt2
 mfanhUV3lJQNEAjiehW6v+4obj1yaaE52g8UynwRcRT9H2AwsNFmNS/OZYTzf6igflS7RSiJCCv
 b+c5B5UmRZxCgOP+vFRdSWsekvVbrOfqBxgsuGBv6S+HzLZ8oH21FWl1Zye2iS36TpDTZpsJm8s
 +rGKviRhC3zy2e3qvTT3wXokIcgQbxlZ8w9Nff/2B1g/45A6WLyYjdwvo38YimBSUVIhlZeLI90
 tP1KVaUeqZpOS/S3mG12a/sV12NoWmsNkn2UzWjohJEakrrQ5zn+q0zgkS6/QZQrU=
X-Received: by 2002:a05:600c:8519:b0:490:bccf:2bd6 with SMTP id
 5b1f17b1804b1-490bda66048mr47084715e9.15.1780576480229; 
 Thu, 04 Jun 2026 05:34:40 -0700 (PDT)
Received: from tiolaptop.tail72d7bd.ts.net ([194.35.121.123])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc413adbsm70036085e9.15.2026.06.04.05.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 05:34:39 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Diogo Silva <diogompaissilva@gmail.com>
Subject: [PATCH] drm/rockchip: dsi: Open-code drm_simple_encoder_init()
Date: Thu,  4 Jun 2026 14:32:25 +0200
Message-ID: <20260604123224.192543-2-diogompaissilva@gmail.com>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 05 Jun 2026 07:25:26 +0000
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

Remove the dependency on drm_simple_kms_helper by open-coding the
drm_simple_encoder_init call.

Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 3547d91b25d3..a09b382d208e 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -25,7 +25,6 @@
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_of.h>
 #include <drm/drm_print.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "rockchip_drm_drv.h"
 
@@ -825,6 +824,10 @@ static void dw_mipi_dsi_encoder_enable(struct drm_encoder *encoder)
 	clk_disable_unprepare(dsi->grf_clk);
 }
 
+static const struct drm_encoder_funcs dw_mipi_dsi_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs
 dw_mipi_dsi_encoder_helper_funcs = {
 	.atomic_check = dw_mipi_dsi_encoder_atomic_check,
@@ -840,7 +843,9 @@ static int rockchip_dsi_drm_create_encoder(struct dw_mipi_dsi_rockchip *dsi,
 	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm_dev,
 							     dsi->dev->of_node);
 
-	ret = drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_DSI);
+	ret = drm_encoder_init(drm_dev, encoder,
+				&dw_mipi_dsi_encoder_funcs,
+				DRM_MODE_ENCODER_DSI, NULL);
 	if (ret) {
 		DRM_ERROR("Failed to initialize encoder with drm\n");
 		return ret;
-- 
2.51.2

