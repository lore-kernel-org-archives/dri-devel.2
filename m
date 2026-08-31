Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F62DC624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 15:34:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5625810E950;
	Mon, 31 Aug 2026 15:34:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l/vSXiiR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0D5B10E94F
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:34:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 449C1601FD;
 Mon, 31 Aug 2026 15:34:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F181F000E9;
 Mon, 31 Aug 2026 15:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788190485;
 bh=6cFBk1/llqBNlXF+tOJQTjIkX7GujrEOb8JFifqT8K8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=l/vSXiiR4yMNqOBsAPGYi32gVXhJ9Gs/t+ZlzsJyir2mpzn3nDvAZHPdSBSpNqywS
 nMeiIUyth6Voz0w4cWgDcVmzzwXyQzmzOLWRtMGgL5RLwRjaRYmF7NPS3H+9SmyRt5
 JdDeiUmF3p+Z9Ber5zmPisWWrzU24G0yMvcGU7biKKk8r/drm2SPz4/hy0yjeAqMOg
 9/H4a1W2pk66w6lMyG9sh1YWOtRckBZFfXqaTe3YEivYQKVaq5Bwn1m7lRJyaV0b17
 kLA61Dx+/aEvhtP0eG0cZAo223NLuve0irADh8plq0gnrs56s8os3FLRk/MVTIj92i
 Xuw0geIMmp8aw==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 31 Aug 2026 17:34:17 +0200
Subject: [PATCH v2 04/13] drm/tilcdc: Move hardware reset to CRTC creation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-drm-no-more-crtc-reset-v2-4-4500d49a337f@kernel.org>
References: <20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org>
In-Reply-To: <20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3400; i=mripard@kernel.org;
 h=from:subject:message-id; bh=I6ipqH/eW3HhSQD8ZpOuFLfuOXdeJ159nfyz4t9WJv8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlT5/1t2Fj78ElTrlS15/6K+Per3TP+bP2S9WW1bIqb8
 OdfutMSO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEZpxjbDgYGXO1suLM1Knm
 7ixe1dv1V3pcfmvBxWGwq7nqgZxnCVNI6tlg38kfsko9JyttcFlny9jwYAPHK7PDhv+X862b7H+
 z4aG2Zjxf6t1wmZL5B591202+cEf75bVw79bnN8Sfi1cX/eIAAA==
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
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 7 +++----
 drivers/gpu/drm/tilcdc/tilcdc_drv.c  | 2 ++
 2 files changed, 5 insertions(+), 4 deletions(-)

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
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 1d6c9a423a41..827f15d14fad 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -247,13 +247,15 @@ static int tilcdc_pm_suspend(struct device *dev)
 }
 
 static int tilcdc_pm_resume(struct device *dev)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct tilcdc_drm_private *priv = ddev_to_tilcdc_priv(ddev);
 
 	/* Select default pin state */
 	pinctrl_pm_select_default_state(dev);
+
 	return  drm_mode_config_helper_resume(ddev);
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(tilcdc_pm_ops,
 				tilcdc_pm_suspend, tilcdc_pm_resume);

-- 
2.55.0

