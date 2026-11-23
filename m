Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AE0606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 22:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gPCp9GG7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DFFC10E6FB;
	Mon, 23 Nov 2026 22:34:20 +0000 (UTC)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com
 [209.85.222.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63A4210E6FB
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 22:34:13 +0000 (UTC)
Received: by mail-ua1-f43.google.com with SMTP id
 a1e0cc1a2514c-9851592ada1so940650241.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 14:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795473252; x=1796078052; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=03w06bSm1yONRYYXB48Ye2MeketUdFgM5u2hRd5PsVE=;
 b=gPCp9GG7vURnnNES81wyaqEwZSRamO4METq99fZ8YD3IOeQTQ+sSE/jE73hmmykeQm
 6hvzHuCPs9KmvXUkvvsMzYVCXy3lPaYEszrPpkn0zBuODwXe34NlQ3jD8sqmmCBsGQwX
 UqFiE/Bp+NWlpb92Nv+V/kokEf/b2IGFNSBdgvdfFJHJ1e7SvYLjwFbrLzhSSLAs/lBq
 X1FYO6fQAIBdyf0/T464ry/ejb0DqN4p+CJYb408HyiePSJZyeoj/3CinT24IUrvbHUU
 OGBj2qUz/mIU7PkuBcpiJu4FL4+gaKvVt/3XTacceFnreBpTjQHXhENCWsv1PkzQI+KJ
 6axg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795473252; x=1796078052;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=03w06bSm1yONRYYXB48Ye2MeketUdFgM5u2hRd5PsVE=;
 b=YuKnrlP+L06VZlHg9wqi1fodI7CSpfqrqvpctzDIl7U219KqAOh4cTjTX0s+yLGYwM
 gwwOEOkhq0+o7VE7a189Aa/Vj7dX6qAEUEzLbmKOos3V/Zl5i+XnJOyzEp76nCO0+U8+
 3dWvXzS2F7GeTsXtB3d9uu2WlKyxNKVlcndiXr10q4yh55ZFMj93xSymphqV976m92kb
 dr+sCGAA3wkKu6cTki3e13Oy3u9XAMcUlEt+X5ndqlsSss6I1DPJ2bg8GA6QDvuK5Dxh
 0EeRX7AUgRq4+17Tnj0zv6jG9YXlIbmGqZ24ZSCwmFBIOhZxPhnKbxH2QtGGKPdM6gPn
 XEhg==
X-Gm-Message-State: APuU4Z/3o2KzGa0JRhRLGNfS6nvAMvMimf202SUf+yxqmebjozrDkT26
 mGm25B/MDaGoQYnvqvHJ5B5KBgu0gkJhLg8zqap0nsA7anYHJZBjUiAc
X-Gm-Gg: AZFdTZdX0c1paA+go53MjoxYgwkWHf29gPlmswMzm8QEkNyprtBWMIDnqa+yhk5nsZU
 CB5mHT+MMqoJlODOGOPigJmY78sQ1w5JNL2Zyt+z5jdn8IJcw85J71U8BTtIPD99kpzqMvwq0Oa
 3YUomizjKBBSHkbjB3KnSrEltM+GTmRtIT3VMIz+qf2L7DcH5c5n4Eomi6D1w1WHCePdS2cl+DO
 1MYOf/HWKUznZc1AzPvpq+AETpF5L2WQg6aBTQrptdUgCEErZYDvDJT593V815nFubF6GSjTbU8
 Yf6QCs/H9YlTT2uP0G1ANZv93AUxDe2A+okDCIs5AJ4fNZdV0eongAmwvNx3xKMicCUWJEsmfke
 48Vi4looZCsSuD9qOop3Tbm++9K9/Z3v66vn10ta+EmUX/UMjJUT2fEGVRV5e/+jIvjvG6+AmXq
 oG4kP86IClEEooByuJcjWqsPBAIUed1XSViaRWdwdyk+03fkqofXn1UfSZ43YBz0N5m36p/knLO
 JC36CBfZt0/B1dxZo+9JDm3fM74wDhwYHy/A/UoT+bN/ddaZlWgQOilzat7FBXysGwPiccG8y/x
 3OSI7FS28M5Fq1g91oeeDedxf02UFytONhtzIfMYjM048mWXJ9os6+a9kQ6hL0DSJO6W3ELzYTC
 YmG23XVdHqP1lfsjCdpZ644Q=
X-Received: by 2002:a05:6102:3f16:b0:7d6:e716:8e05 with SMTP id
 ada2fe7eead31-7d7392a486amr5876555137.5.1795473251968; 
 Mon, 23 Nov 2026 14:34:11 -0800 (PST)
Received: from fabio-X870-EAGLE-WIFI7.tail2bb604.ts.net
 ([2804:1b3:a803:a13e:59e7:dd47:a2cb:e700])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-99e6dec57ddsm12729378241.1.2026.11.23.14.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 14:34:11 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: laurentiu.palcu@oss.nxp.com
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 marek.vasut@mailbox.org, mripard@kernel.org,
 Fabio Estevam <festevam@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v2] drm/mxsfb: lcdif: Fix use-after-free on unbind
Date: Mon, 23 Nov 2026 19:33:57 -0300
Message-ID: <20261123223357.535424-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

lcdif allocates its private data, which embeds the CRTC and primary
plane, and its encoders using devres. These DRM objects are linked into
the mode_config lists.

Since mode_config cleanup is DRM-managed, it is deferred until the DRM
device is released. An open DRM file can keep the DRM device alive after
the platform device has been unbound and devres has freed those objects.
The later mode_config cleanup then dereferences freed memory.

Allocate the private data with drmm before initializing mode_config so
that it remains alive until mode_config cleanup has completed. Allocate
encoders with drmm_plain_encoder_alloc(), which cleans up each encoder
and removes it from the mode_config list before freeing its memory.

This can be reproduced on i.MX8MP by keeping the DRM card open across an
LCDIF unbind and closing it afterwards.

Cc: stable@vger.kernel.org
Fixes: 1c71d925c03a ("drm: lcdif: Switch to drmm_mode_config_init")
Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Rebase onto next-20261123 after the devm_kzalloc_obj() conversion.
- Add Laurentiu's Reviewed-by tag.

 drivers/gpu/drm/mxsfb/lcdif_drv.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lcdif_drv.c
index b7be7e17d1d0..bc1a9a2fc6bd 100644
--- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
+++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
@@ -24,6 +24,7 @@
 #include <drm/drm_fbdev_dma.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_managed.h>
 #include <drm/drm_mode_config.h>
 #include <drm/drm_module.h>
 #include <drm/drm_of.h>
@@ -43,10 +44,6 @@ static const struct drm_mode_config_helper_funcs lcdif_mode_config_helpers = {
 	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
 };
 
-static const struct drm_encoder_funcs lcdif_encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
-};
-
 static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
 {
 	struct device *dev = lcdif->drm->dev;
@@ -74,19 +71,16 @@ static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
 					     "Failed to get bridge for endpoint%u\n",
 					     of_ep.id);
 
-		encoder = devm_kzalloc_obj(dev, *encoder);
-		if (!encoder)
-			return dev_err_probe(dev, -ENOMEM,
-					     "Failed to allocate encoder for endpoint%u\n",
-					     of_ep.id);
-
-		encoder->possible_crtcs = drm_crtc_mask(&lcdif->crtc);
-		ret = drm_encoder_init(lcdif->drm, encoder, &lcdif_encoder_funcs,
-				       DRM_MODE_ENCODER_NONE, NULL);
-		if (ret)
+		encoder = drmm_plain_encoder_alloc(lcdif->drm, NULL,
+						   DRM_MODE_ENCODER_NONE, NULL);
+		if (IS_ERR(encoder)) {
+			ret = PTR_ERR(encoder);
 			return dev_err_probe(dev, ret,
 					     "Failed to initialize encoder for endpoint%u\n",
 					     of_ep.id);
+		}
+
+		encoder->possible_crtcs = drm_crtc_mask(&lcdif->crtc);
 
 		ret = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 		if (ret)
@@ -131,7 +125,7 @@ static int lcdif_load(struct drm_device *drm)
 	struct lcdif_drm_private *lcdif;
 	int ret;
 
-	lcdif = devm_kzalloc_obj(&pdev->dev, *lcdif);
+	lcdif = drmm_kzalloc(drm, sizeof(*lcdif), GFP_KERNEL);
 	if (!lcdif)
 		return -ENOMEM;
 

base-commit: 3191063649dbf7c0d0b768e1f3655e4c5fc6edb5
-- 
2.43.0

