Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D43BC79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 21:02:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F5C510F2BB;
	Wed,  9 Sep 2026 21:02:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DHIGt6ZE";
	dkim-atps=neutral
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com
 [209.85.222.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3F0810F2B1
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 21:02:44 +0000 (UTC)
Received: by mail-ua1-f43.google.com with SMTP id
 a1e0cc1a2514c-97ccaa61510so1354298241.0
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 14:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788987763; x=1789592563; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q46w9/u2wpQp5QGB3PuR+xp/kUloMNPv1YY/PPVAfY4=;
 b=DHIGt6ZEdb2Xrsl25OQrd/ngscl5OgdvKEvvXue4O8SsoI58YVfweTp5evP5AAqb0P
 /EO/Voy5u49YOqrhNpvSF51QOpFcAcudom1RT2dhDLrQkdKdaQ9EEYKgz1f1eAafvyYJ
 NQxTwjM/CKg+25Lf/lN+QUEr9a2zgvJfiCxvJvdLR60YMSML8qgGzZS+HLkF0m2OCb+0
 FY7ZSX0tBReM+FMdlFnfzTgaEnT+t4hvxYTh4ASYIIMUDqatlGwwGhW8GUIsGs/IUgvQ
 bSAMwv9MwXkaXKEiCsbiu/HlI28YAEpmLQtCuHWPzCxw+GR1/lZ89Jdn28T1DL/BbCB4
 J/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788987763; x=1789592563;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q46w9/u2wpQp5QGB3PuR+xp/kUloMNPv1YY/PPVAfY4=;
 b=JrZgbSt974gR8seMClY2dL/J2OUYUjmEngo3IiW0iHUpqRGeJNcaZN+a1ab2d2FkHk
 feK4GlMkFlYQVs+lyjfYtgPX1rNsyGHWBte3S3XGK7vF1lBq19DAC6ywh0vmPXE6rTT6
 vtsxo8eltEqPbF8nJTPmOMWBwYs2o6AkMiarTCiF+TtUVsSbvR6nCuj+TlIXs2LUMRSs
 p3Bo2VZyjTTUqNtv/CY4xoj5PVEUJXJThcXrse5qdUD19jwhU75crLD1KYGbEg7yEj8I
 R4T0Tfu1f6Z9QErbpcQv7AfJUSyf1zQFTp5SOotcx1TGZhYLFk8JSxnRyIGlSRarnn9w
 hyJg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxBT25gTslRKtJm4dyHia+XrChnjMcz5SsvC2slOgZADZKz0uANGq6FbUaGsNf+Rso1XZLUClvhOxI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lD+l2G3WfZPZLnJnfMYHcWydaicq3Lc+5+DwIwdPaXOZzeA5jH
 JSaGq1U4tjCDMgODJwFFfwR786TUhtTynwL4TGN5oSJuDqT1yd4IRUID
X-Gm-Gg: AYBFou1WiM3ilom2XzXwGrjILucOJQhTyYGI3ajIlSt/3ee4uH/+FRwCPBU8z5Mrcbw
 4jGFILWxSqbrDSQdldSWB9SJCuuHHn+AqVC77u0nr+2kzs0xc8/5DReLyxXL2ugCsHVsF/ewWnQ
 jpCNHfwoAXSFPQsLAn0/Wrr4/ihXvzh+MnBI9DMmmsAEAu2ndP0o/iBjo6ELUaqwRB7xw+gaMnp
 1jU3lhSNpTUE056tEz7zyPNPrYK8vUKhHhm6nNMOvOpw4VMqyMgIGscHRLudgURdiKetyYOuHB4
 ySCerMWmotD8jyxhwiiCqYrdQOIIdZlvLEs7NJMAAa9ZIR1Q+hZyN3lUVGiJKuzbaDZWIqgBEOD
 LFHCL33ArFNoTRyW36RJsZn3N5JjOYeV+txbqQ1gUzr89a0JZbwN2eHPPqAZL89cxj4EAaZBzlO
 GyuUEALqj85dyDKt+/uGhoNsaXa8RWeTrlKf08Yh6Q8O22/2rSQytK2r2D2vV0j46tL5nCQqr2A
 Un3agb4d5EyAHENnCz/bItE/aTVjkkPdgIyKPwwVgvlb8fY
X-Received: by 2002:a05:6102:2d03:b0:786:77e2:d8fa with SMTP id
 ada2fe7eead31-78a4a943a32mr14848382137.5.1788987763467; 
 Wed, 09 Sep 2026 14:02:43 -0700 (PDT)
Received: from fabio-X870-EAGLE-WIFI7..
 ([2804:1b3:a803:6c49:659c:692c:9416:2f0d])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-78a4764e321sm12434590137.0.2026.09.09.14.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 14:02:41 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: marex@denx.de
Cc: mripard@kernel.org, imx@lists.linux.dev, dri-devel@lists.freedesktop.org,
 Fabio Estevam <festevam@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] drm/mxsfb: lcdif: Fix use-after-free on unbind
Date: Wed,  9 Sep 2026 18:02:13 -0300
Message-ID: <20260909210213.946159-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
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
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/gpu/drm/mxsfb/lcdif_drv.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lcdif_drv.c
index e2173c4d6fc2..7e9f3b205a45 100644
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
 
-		encoder = devm_kzalloc(dev, sizeof(*encoder), GFP_KERNEL);
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
 
-	lcdif = devm_kzalloc(&pdev->dev, sizeof(*lcdif), GFP_KERNEL);
+	lcdif = drmm_kzalloc(drm, sizeof(*lcdif), GFP_KERNEL);
 	if (!lcdif)
 		return -ENOMEM;
 
-- 
2.43.0

