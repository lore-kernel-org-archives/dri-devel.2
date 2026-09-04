Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187BDC79F80
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 09:07:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A03910F9A1;
	Fri,  4 Sep 2026 09:07:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VQn8s/A8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5356C10F9A4
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 09:07:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CB44860211;
 Fri,  4 Sep 2026 09:07:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018761F00A3D;
 Fri,  4 Sep 2026 09:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788512867;
 bh=b/9WhkU3fr0pks0Fl/c0OH7kRsYR/j4NzrCIdd0I5AM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=VQn8s/A8yeu+78bYmZMHy1sdIiTUQGzkFw/oIJ20LGhBdbjan8zjAM0Y+A/fLlhOk
 KLxZ/YGdftkeAM1aE92XS2a45m7pj5amJjXitr0LA4wfTgarcE4Cp0Yr//y2EJHMsI
 FUTr9q4KDaDlSwhlrE1Rlvz8S1aMJol1Szrbs6IH++IRFD7Gxx3Dg5WaoOmx2DI+zR
 Eo8LhG1DyWzKDX43rXFhpCGvAAQ8v1JNM2uOq/0mCubWFVWHdTAhSV2EKJEmbdx3Kb
 JZjxgszlc8f1zqq+H/aXH1U3tp8oZNejse2FCdfyz4yvlYAjBXCnQDSNgeYGurMxy+
 odLYxtwho7ruw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 04 Sep 2026 11:07:22 +0200
Subject: [PATCH v3 04/13] drm/tilcdc: Move hardware reset to hw_reset hook
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-drm-no-more-crtc-reset-v3-4-27d9891512ce@kernel.org>
References: <20260904-drm-no-more-crtc-reset-v3-0-27d9891512ce@kernel.org>
In-Reply-To: <20260904-drm-no-more-crtc-reset-v3-0-27d9891512ce@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2717; i=mripard@kernel.org;
 h=from:subject:message-id; bh=XYHesTwy4XmDvxFDWZxXOrlstOpW+6tAc//N4COMYlg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmzunxEWXmyr926a8a8gyXY+e4VwUC3yeken5PlDszMf
 HDmnujKjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjARD3vGOmvb43aHbdOOPNhT
 ElyR8fzDegMvhqj8eRUPD0i9t1NedoPzcenjtJNOb1Rd3KdfM4kwYaxPOOCw6Yb8icc/BHYfEvr
 tLvC49M3+N77rHy0WljA9/ZWxbkGZVFKaZZSTjmZUaQGv518A
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
deals with state allocation. Move the hardware reset to the hw_reset
helper hook instead.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Jyri Sarha <jyri.sarha@iki.fi>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
index e07ecb36a27a..b299d73ce385 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
@@ -683,18 +683,16 @@ static void tilcdc_crtc_disable_vblank(struct drm_crtc *crtc)
 			     LCDC_V2_END_OF_FRAME0_INT_ENA);
 
 	spin_unlock_irqrestore(&tilcdc_crtc->irq_lock, flags);
 }
 
-static void tilcdc_crtc_reset(struct drm_crtc *crtc)
+static void tilcdc_crtc_hw_reset(struct drm_crtc *crtc)
 {
 	struct tilcdc_crtc *tilcdc_crtc = to_tilcdc_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
 	int ret;
 
-	drm_atomic_helper_crtc_reset(crtc);
-
 	/* Turn the raster off if it for some reason is on. */
 	pm_runtime_get_sync(dev->dev);
 	if (tilcdc_read(dev, LCDC_RASTER_CTRL_REG) & LCDC_RASTER_ENABLE) {
 		/* Enable DMA Frame Done Interrupt */
 		tilcdc_write(dev, LCDC_INT_ENABLE_SET_REG, LCDC_FRAME_DONE);
@@ -714,11 +712,11 @@ static void tilcdc_crtc_reset(struct drm_crtc *crtc)
 }
 
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
@@ -818,10 +816,11 @@ static const struct drm_crtc_helper_funcs tilcdc_crtc_helper_funcs = {
 	.mode_fixup	= tilcdc_crtc_mode_fixup,
 	.atomic_check	= tilcdc_crtc_atomic_check,
 	.atomic_enable	= tilcdc_crtc_atomic_enable,
 	.atomic_disable	= tilcdc_crtc_atomic_disable,
 	.atomic_flush	= tilcdc_crtc_atomic_flush,
+	.hw_reset	= tilcdc_crtc_hw_reset,
 };
 
 void tilcdc_crtc_update_clk(struct drm_crtc *crtc)
 {
 	struct drm_device *dev = crtc->dev;

-- 
2.55.0

