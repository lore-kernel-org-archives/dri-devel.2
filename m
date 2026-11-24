Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C36606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=agcfllee
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33AD710E84B;
	Tue, 24 Nov 2026 11:22:32 +0000 (UTC)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CF4310F4B5
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 11:22:25 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-36a315ed211so5437491eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 03:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795519345; x=1796124145; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zOlLhiHGS+QvddYr4TaDXREtsHzHjMolopc6Gh+4/Zk=;
 b=agcflleeip086sD2E8+xoKnqhij61ESRSae7fYNaEVcnOzoqjFuMU7O2rirqlqZ2s+
 czqWszeCLS44UopONb6vWtYV4UQPwnarvIaBVXjr6T1z4d5cCWxkNOKXxwTkAoHoF/S1
 iMKwA4M5ekydR5PceRECgT/4BL5tvGl7qndRynApe+7K9AVutSYZpsYeHVhj3sCejwLn
 B3xp5CdvaRDbgBH89goD70FXOOin9NIbag+OPDj2Kf71T0i+lSthD5hA/HOqBODNlik0
 64CoEh84yv010zRwpKguNPiBEBWvqhFAU94gnsfos9bw7fjWyhrf4RDbWBgpCnlaaloD
 5PKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795519345; x=1796124145;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zOlLhiHGS+QvddYr4TaDXREtsHzHjMolopc6Gh+4/Zk=;
 b=FU7hrX1sFcVaWKlthiTlOR1bzVd2CM2X6kS5sgVqbLo8RdiXcV92mmA/5DJzgsxXls
 0LEvJe3g+UxsGBo+VeRstC0OEbSDaOMISTIC9ZZgUa9isV/trg/6upR3+UngJeKyzdUj
 vrg0/ARAo/XPuYdCLFQQfmakns9LaWltejI/UKP9ZlANb8jOBhkSx/ffs5j7IYu+KrgV
 +E9grYg9as6IFuC7SZkD1P60Wg8Is5/6i026wCfWV1JjU4f+kz7lfK7pkdGBKkrx6btB
 h1pek2QaD+oRAVGByQEUxvRHAWxhG24ZEpxaeyt/rwXy87Ea1sl6IK9ccKW6bbOvi2vw
 phaQ==
X-Gm-Message-State: APuU4Z/z4uMm3dlCAscG6XLaCrpgvIk1k/yWxtVCPLbMR0glPgqP25AU
 gwQavYFU7knhcjEOoF7h1idxqi5gK6h1i4t5DQ82PIa46P5Z4mvkSAbx
X-Gm-Gg: AZFdTZf0UeC3vsPIhjx+S1tODtIDHG4BeCB23Ip7TCDQoHnRXuSkKmUb9NBqmKD+XTp
 NyLmI7nDKYJGDXejEZtfUl4raZzdzM59Mz6sNroEh0nHNLn1btfa1dxn+FLZUcRNXGpsU4Y0gXp
 igW3kDpoFCdbLwraux7cuzHXV+CG5qMezTgyGCbXuPJt+KHSYpU7Do1bSnnJccm0oCXM7Gpjo1N
 JbdXV4JHFpyscNd7IROwaxqzK/1/GCelpL43xxDBVGxUagzdGwpDKFAioY9xEWxa/BHEQfSQU/B
 v5awJHzx9d7A9Dqgi4k+4r3vaXAmnrOk2auHP1vR9wfUmItaH5Y4tE4rBvKFAvxOy5HgwtHTg27
 DNxRnLr/wx4SUv1SSkFivYgTijI5y6p7XVmMBcQbRXGrv/IBcNsAzQU3CZLVRVJXl6mNyag9vCV
 0r5Sz5uknZDRvGdlsW1Sq6X/2VMuqQxoY6HQQl2n939LsjtnXUsTWBKjCK/bMJacZo8e3qOd8SZ
 1/sUCDlvn9F6l3hRQnscw4B4bZf4DUhaBQC8d5uX5tpibp0PoGuZ0qoDiMFhJ0j6ebyN8e/Lbq6
 QStXHsOluCe3j+7ILu0FOn7HAsMo1X8FNqpcVd75Vx6gu6Th7iDRhv+BzARgqSgdc0jG+ZH4fBe
 GvVAwPTe/u7SDaxyl4Yxt2tY=
X-Received: by 2002:a05:7300:ce81:b0:384:a3c5:35b8 with SMTP id
 5a478bee46e88-384b3986ee5mr18053216eec.8.1795519344585; 
 Tue, 24 Nov 2026 03:22:24 -0800 (PST)
Received: from fabio-X870-EAGLE-WIFI7.tail2bb604.ts.net
 ([2804:1b3:a803:a13e:549d:3701:4c51:db13])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385665f21aesm55112634eec.4.2026.11.24.03.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 03:22:23 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: laurentiu.palcu@oss.nxp.com
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 marek.vasut@mailbox.org, mripard@kernel.org, luca.ceresoli@bootlin.com,
 Fabio Estevam <festevam@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v3] drm/mxsfb: lcdif: Fix use-after-free on unbind
Date: Tue, 24 Nov 2026 08:22:15 -0300
Message-ID: <20261124112215.12255-1-festevam@gmail.com>
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
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v2:
- Return the encoder allocation error directly instead of storing it in ret. (Luca)

 drivers/gpu/drm/mxsfb/lcdif_drv.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lcdif_drv.c
index b7be7e17d1d0..2be5a76e936f 100644
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
@@ -74,19 +71,14 @@ static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
 					     "Failed to get bridge for endpoint%u\n",
 					     of_ep.id);
 
-		encoder = devm_kzalloc_obj(dev, *encoder);
-		if (!encoder)
-			return dev_err_probe(dev, -ENOMEM,
-					     "Failed to allocate encoder for endpoint%u\n",
+		encoder = drmm_plain_encoder_alloc(lcdif->drm, NULL,
+						   DRM_MODE_ENCODER_NONE, NULL);
+		if (IS_ERR(encoder))
+			return dev_err_probe(dev, PTR_ERR(encoder),
+					     "Failed to initialize encoder for endpoint%u\n",
 					     of_ep.id);
 
 		encoder->possible_crtcs = drm_crtc_mask(&lcdif->crtc);
-		ret = drm_encoder_init(lcdif->drm, encoder, &lcdif_encoder_funcs,
-				       DRM_MODE_ENCODER_NONE, NULL);
-		if (ret)
-			return dev_err_probe(dev, ret,
-					     "Failed to initialize encoder for endpoint%u\n",
-					     of_ep.id);
 
 		ret = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 		if (ret)
@@ -131,7 +123,7 @@ static int lcdif_load(struct drm_device *drm)
 	struct lcdif_drm_private *lcdif;
 	int ret;
 
-	lcdif = devm_kzalloc_obj(&pdev->dev, *lcdif);
+	lcdif = drmm_kzalloc(drm, sizeof(*lcdif), GFP_KERNEL);
 	if (!lcdif)
 		return -ENOMEM;
 
-- 
2.43.0

