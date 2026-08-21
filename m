Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34D4C5DF95
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:41:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D6F110F2ED;
	Fri, 21 Aug 2026 14:41:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oCShwywj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF61E10F13E
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:40:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8F513433D3;
 Fri, 21 Aug 2026 14:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECE21F00A3A;
 Fri, 21 Aug 2026 14:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323232;
 bh=SAkQgLkZ7nP67DAhLoYOQWm5LELRBEiAoGfoOlKaemA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=oCShwywjtgLjqazwKCi2nGHUe2zF8l9pq8tB79QXnd9MAF5zL2MD6pPAT9DaCU3IS
 5A6DZRup9RfbPEZTf2A6XzIekKm2eHekMj0UnwGjqZgenLmEn4JeG/+cuPSprZJVMS
 erPIttveMQv+d1ERA/RUnot0ndTsUlRY/v3myhr5d4wbmUWCG22zG6MfREXxGBUvVy
 OC2GcnqsMfwHIHOGMDCzUmq32ITXGKyVZ9RL+okN41rhCXMOYact2AHfJwXjMVII6u
 cD4A9woJ0pg3R5FqKAiKETnarX1khzc6dp4VnVxWwsf+lWr/QugxaRX8qEf/3kpHmN
 BzvY14EDfsUEA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:05 +0200
Subject: [PATCH 29/70] drm/tilcdc: Move hardware reset to CRTC creation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-29-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3442; i=mripard@kernel.org;
 h=from:subject:message-id; bh=oHPOn12oxuFX+XIfnFthfPeGpdrjO1Jt1XZte6C6SMk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyawX+n5V/b+XvjFNYa552pI7cXd4+Pa630rcaJmtd
 ad9eb5Mx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhI6wHGWvGnn5Z8aJzf9n2m
 eIilpVxI9DQ5vwNPK6ZsD5Lr9dBNlZuy9t7qfsl/EgyTg3/sypz3nbHhuHx0Rq+bVL9BoVPE3Yv
 PvTd2XzSzzl4UJ81uOElWVlB+9acv5aLsV6XPhLi8TTT/dQkA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

The tilcdc crtc reset hook performs both atomic state initialization
using drm_atomic_helper_crtc_reset() and hardware-level register
writes to disable the raster and clear IRQ status.

The hardware reset is not related to atomic state initialization, and
the reset hook is being converted to atomic_create_state which only
deals with state allocation. Move the hardware reset to the CRTC
creation path instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Jyri Sarha <jyri.sarha@iki.fi>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 49 +++++++++++++++---------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
index e07ecb36a27a..910580c4dada 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
@@ -683,42 +683,14 @@ static void tilcdc_crtc_disable_vblank(struct drm_crtc *crtc)
 			     LCDC_V2_END_OF_FRAME0_INT_ENA);
 
 	spin_unlock_irqrestore(&tilcdc_crtc->irq_lock, flags);
 }
 
-static void tilcdc_crtc_reset(struct drm_crtc *crtc)
-{
-	struct tilcdc_crtc *tilcdc_crtc = to_tilcdc_crtc(crtc);
-	struct drm_device *dev = crtc->dev;
-	int ret;
-
-	drm_atomic_helper_crtc_reset(crtc);
-
-	/* Turn the raster off if it for some reason is on. */
-	pm_runtime_get_sync(dev->dev);
-	if (tilcdc_read(dev, LCDC_RASTER_CTRL_REG) & LCDC_RASTER_ENABLE) {
-		/* Enable DMA Frame Done Interrupt */
-		tilcdc_write(dev, LCDC_INT_ENABLE_SET_REG, LCDC_FRAME_DONE);
-		tilcdc_clear_irqstatus(dev, 0xffffffff);
-
-		tilcdc_crtc->frame_done = false;
-		tilcdc_clear(dev, LCDC_RASTER_CTRL_REG, LCDC_RASTER_ENABLE);
-
-		ret = wait_event_timeout(tilcdc_crtc->frame_done_wq,
-					 tilcdc_crtc->frame_done,
-					 msecs_to_jiffies(500));
-		if (ret == 0)
-			drm_err(dev, "%s: timeout waiting for framedone\n",
-				__func__);
-	}
-	pm_runtime_put_sync(dev->dev);
-}
-
 static const struct drm_crtc_funcs tilcdc_crtc_funcs = {
 	.set_config     = drm_atomic_helper_set_config,
 	.page_flip      = drm_atomic_helper_page_flip,
-	.reset		= tilcdc_crtc_reset,
+	.reset		= drm_atomic_helper_crtc_reset,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
 	.enable_vblank	= tilcdc_crtc_enable_vblank,
 	.disable_vblank	= tilcdc_crtc_disable_vblank,
 };
@@ -1003,7 +975,26 @@ int tilcdc_crtc_create(struct drm_device *dev)
 	spin_lock_init(&tilcdc_crtc->irq_lock);
 	INIT_WORK(&tilcdc_crtc->recover_work, tilcdc_crtc_recover_work);
 
 	drm_crtc_helper_add(crtc, &tilcdc_crtc_helper_funcs);
 
+	/* Turn the raster off if it for some reason is on. */
+	pm_runtime_get_sync(dev->dev);
+	if (tilcdc_read(dev, LCDC_RASTER_CTRL_REG) & LCDC_RASTER_ENABLE) {
+		/* Enable DMA Frame Done Interrupt */
+		tilcdc_write(dev, LCDC_INT_ENABLE_SET_REG, LCDC_FRAME_DONE);
+		tilcdc_clear_irqstatus(dev, 0xffffffff);
+
+		tilcdc_crtc->frame_done = false;
+		tilcdc_clear(dev, LCDC_RASTER_CTRL_REG, LCDC_RASTER_ENABLE);
+
+		ret = wait_event_timeout(tilcdc_crtc->frame_done_wq,
+					 tilcdc_crtc->frame_done,
+					 msecs_to_jiffies(500));
+		if (ret == 0)
+			drm_err(dev, "%s: timeout waiting for framedone\n",
+				__func__);
+	}
+	pm_runtime_put_sync(dev->dev);
+
 	return 0;
 }

-- 
2.55.0

