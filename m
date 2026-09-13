Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F278DC88E56
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 09:17:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5903C10E092;
	Sun, 13 Sep 2026 09:17:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MoH6jkvW";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFC8110E092
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 09:16:59 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2db18fe433fso6544085ad.2
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 02:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789291019; x=1789895819; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hl7UPP4ejrps6ty9GNEkOxkDv0jyU5q+6jxLFrutl80=;
 b=MoH6jkvWepfD2BtWNuquJKJL0nOzuhoPMrsOBV1dgQpoDPKr7LLKsdH40Pz2N222cV
 Avl+sW20/L+7TpPw5xBxejUF/7YydvbPZJSqyTZTXoFy2gbcS6eLSieg6yMjnU79N3Lu
 MR4J3SHBuQ0qAfdZOcwYQ2ztwE7C9U2M7p/mQHdJUfIM8IZh+mE417X44Gyj3EKRy5re
 cRdbbsNPThSSsP6HGevPXTpX5ei0W63PP1V4HbGCoFe7vPfrLrPnd19vvH0qat7FecYa
 sAeLcGUfe6dTKZplXdFoGfD8gZlzLhM4p6hA2Gxb0vgTkQ4HftrCCMi56q4X4FrE878e
 8C2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789291019; x=1789895819;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hl7UPP4ejrps6ty9GNEkOxkDv0jyU5q+6jxLFrutl80=;
 b=HlxmQ3rJvCH7tNX71xOZNLLuqGAUVLpQgHpeLNbEFDqtdtCSNyV75yHJ6xniD0fpYw
 ZmY09KFaPv/GdodDfk/53pHo0BBnHzME4amuLzQFmVbycGdgkpV0SOHxUxRafycqYqtu
 OLWBgwq5weMgOY2QSc/DyCAxxfifM7nbKmY18PRCKy+mbFjO8iovAs4b8JNC7HNJah1A
 JAQ4ltNkdpzfSmpylNeNxk0iIpis3+bArcqmOKvb/VzCiiUiMI1lAlUgm76j0Lf00gs+
 CkoojN3ME1OhtbWwkLIvdPLKVvb47hRJHbt1DwBqPznXz2cXdT1V0efQ8HPycTjj90N8
 URsw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwckcWNHrgvj9ur/20WwbthOjCgNvq+/9BYCY4HlqwNcndPlBIJ+iY26JYRLhHTHSqgy6wbLcf2dg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nePKjWXZ3Ff4sAKjxAgq9zFWCO9dS0fw/0bCAodgsOagLD/Squ
 1PbN+eT9b6CSJEziKmg9gZLVjXapeGZ2cWFkYEL0+oZFV4P7O2aGPinS
X-Gm-Gg: AYBFou1XBIcXjV8JnpyJBZvjVufG99qXwMEoR1AuFanY6kWejRSc7ITrXZblFg1i9L5
 ee6/XoeJb2itMrwY+tnhcHRpOvYq7UlGUkOPE0GoQj2vIbrklSmcuv6/razjx7f6198kjtSDBAJ
 PIbR6d9csDwF/qRFGxgVtYVJa4tpydfbEqdBXBEWWbky1Ha1YnXMJAUvScOy0O+3n4NW7glH/wR
 oOhsnFl9XDi3Bf4z4UgEp+e3KKPTiGpWio/aIskm9Ik6o2MLeTgrVZVGyqEGtz4fXusLr8Q0Bgo
 ch223TJdCgCyLVOz9Ivl3+JixcdfLbELRgIU7qX5j8zIvYHRnBMC45RLR7IEzVcoaQIku0qDOcx
 kXs9KaWVJsunCNhC5YnGtPczsIrnzS1IMUyw7jPMC3/S+Bg0I/yHLxqYgC6ZxWcs/xZciNynVu4
 M66jKzgc7dTaUg/FdMFTmcLpdUNXXik3jn+AUt2VxG3Q0uP0NFGLi6ww==
X-Received: by 2002:a17:903:390d:b0:2ca:e19c:986 with SMTP id
 d9443c01a7336-2dd4bc3302bmr114612235ad.1.1789291018960; 
 Sun, 13 Sep 2026 02:16:58 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd2ceb7720sm32169865ad.37.2026.09.13.02.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 02:16:58 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Greg Kroah-Hartman <gregkh@suse.de>,
 Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/omap: dmm_tiler: fix invalid cleanup on probe failure
Date: Sun, 13 Sep 2026 17:16:44 +0800
Message-ID: <20260913091644.1510151-1-lgs201920130244@gmail.com>
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

omap_dmm_probe() uses omap_dmm_remove() to clean up all probe failures,
but the remove path assumes that the MMIO mapping and IRQ registration
have completed successfully.

If probe fails before the MMIO resource is mapped, omap_dmm_remove()
attempts to disable DMM interrupts through an uninitialized MMIO base,
which can result in an invalid memory access.

There is a similar issue with the IRQ. The IRQ number is stored in
omap_dmm before request_irq() is called, so a later probe failure can
make omap_dmm_remove() call free_irq() even though the IRQ was never
successfully requested.

Initialize the stored IRQ to -1 and keep the IRQ number local until
request_irq() succeeds. Only access the interrupt registers and free
the IRQ when it has been successfully registered. Also avoid unmapping
the MMIO region when it has not been mapped.

Propagate errors returned by platform_get_irq() while at it.

This issue was found by manual code inspection.

Fixes: 71e8831f6407 ("drm/omap: DMM/TILER support for OMAP4+ platform")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c | 65 ++++++++++++++++++------
 1 file changed, 49 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
index a2c702b831a7..169a158e5e9d 100644
--- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
@@ -769,14 +769,14 @@ static void omap_dmm_remove(struct platform_device *dev)
 
 static int omap_dmm_probe(struct platform_device *dev)
 {
-	int ret = -EFAULT, i;
+	int ret, i;
 	struct tcm_area area = {0};
 	u32 hwinfo, pat_geom;
 	struct resource *mem;
 
 	omap_dmm = kzalloc_obj(*omap_dmm);
 	if (!omap_dmm)
-		goto fail;
+		return -ENOMEM;
 
 	/* initialize lists */
 	INIT_LIST_HEAD(&omap_dmm->alloc_head);
@@ -791,7 +791,7 @@ static int omap_dmm_probe(struct platform_device *dev)
 		if (!match) {
 			dev_err(&dev->dev, "failed to find matching device node\n");
 			ret = -ENODEV;
-			goto fail;
+			goto err_free_dmm;
 		}
 
 		omap_dmm->plat_data = match->data;
@@ -801,7 +801,8 @@ static int omap_dmm_probe(struct platform_device *dev)
 	mem = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	if (!mem) {
 		dev_err(&dev->dev, "failed to get base address resource\n");
-		goto fail;
+		ret = -ENODEV;
+		goto err_free_dmm;
 	}
 
 	omap_dmm->phys_base = mem->start;
@@ -809,12 +810,15 @@ static int omap_dmm_probe(struct platform_device *dev)
 
 	if (!omap_dmm->base) {
 		dev_err(&dev->dev, "failed to get dmm base address\n");
-		goto fail;
+		ret = -ENOMEM;
+		goto err_free_dmm;
 	}
 
 	omap_dmm->irq = platform_get_irq(dev, 0);
-	if (omap_dmm->irq < 0)
-		goto fail;
+	if (omap_dmm->irq < 0) {
+		ret = omap_dmm->irq;
+		goto err_unmap;
+	}
 
 	omap_dmm->dev = &dev->dev;
 
@@ -864,13 +868,13 @@ static int omap_dmm_probe(struct platform_device *dev)
 	if (!omap_dmm->dummy_page) {
 		dev_err(&dev->dev, "could not allocate dummy page\n");
 		ret = -ENOMEM;
-		goto fail;
+		goto err_workaround;
 	}
 
 	/* set dma mask for device */
 	ret = dma_set_coherent_mask(&dev->dev, DMA_BIT_MASK(32));
 	if (ret)
-		goto fail;
+		goto err_free_dummy;
 
 	omap_dmm->dummy_pa = page_to_phys(omap_dmm->dummy_page);
 
@@ -881,7 +885,7 @@ static int omap_dmm_probe(struct platform_device *dev)
 	if (!omap_dmm->refill_va) {
 		dev_err(&dev->dev, "could not allocate refill memory\n");
 		ret = -ENOMEM;
-		goto fail;
+		goto err_free_dummy;
 	}
 
 	/* alloc engines */
@@ -889,7 +893,7 @@ static int omap_dmm_probe(struct platform_device *dev)
 					 omap_dmm->num_engines);
 	if (!omap_dmm->engines) {
 		ret = -ENOMEM;
-		goto fail;
+		goto err_free_refill;
 	}
 
 	for (i = 0; i < omap_dmm->num_engines; i++) {
@@ -907,7 +911,7 @@ static int omap_dmm_probe(struct platform_device *dev)
 	omap_dmm->tcm = kzalloc_objs(*omap_dmm->tcm, omap_dmm->num_lut);
 	if (!omap_dmm->tcm) {
 		ret = -ENOMEM;
-		goto fail;
+		goto err_free_engines;
 	}
 
 	/* init containers */
@@ -921,7 +925,7 @@ static int omap_dmm_probe(struct platform_device *dev)
 		if (!omap_dmm->tcm[i]) {
 			dev_err(&dev->dev, "failed to allocate container\n");
 			ret = -ENOMEM;
-			goto fail;
+			goto err_free_tcm;
 		}
 
 		omap_dmm->tcm[i]->lut_id = i;
@@ -958,7 +962,7 @@ static int omap_dmm_probe(struct platform_device *dev)
 		dev_err(&dev->dev, "couldn't register IRQ %d, error %d\n",
 			omap_dmm->irq, ret);
 		omap_dmm->irq = -1;
-		goto fail;
+		goto err_free_tcm;
 	}
 
 	/* Enable all interrupts for each refill engine except
@@ -980,8 +984,37 @@ static int omap_dmm_probe(struct platform_device *dev)
 
 	return 0;
 
-fail:
-	omap_dmm_remove(dev);
+err_free_tcm:
+	for (i = 0; i < ARRAY_SIZE(containers); i++)
+		containers[i] = NULL;
+
+	for (i = 0; i < omap_dmm->num_lut; i++)
+		if (omap_dmm->tcm[i])
+			omap_dmm->tcm[i]->deinit(omap_dmm->tcm[i]);
+	kfree(omap_dmm->tcm);
+
+err_free_engines:
+	kfree(omap_dmm->engines);
+
+err_free_refill:
+	dma_free_wc(omap_dmm->dev,
+		    REFILL_BUFFER_SIZE * omap_dmm->num_engines,
+		    omap_dmm->refill_va, omap_dmm->refill_pa);
+
+err_free_dummy:
+	__free_page(omap_dmm->dummy_page);
+
+err_workaround:
+	if (omap_dmm->dmm_workaround)
+		dmm_workaround_uninit(omap_dmm);
+
+err_unmap:
+	iounmap(omap_dmm->base);
+
+err_free_dmm:
+	kfree(omap_dmm);
+	omap_dmm = NULL;
+
 	return ret;
 }
 
-- 
2.43.0

