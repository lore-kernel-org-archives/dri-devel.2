Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85949606A329
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A0+wx90q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE2CA10F169;
	Mon, 16 Nov 2026 13:27:29 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBB8F10F169
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:27:17 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-4910b863b84so2489709f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 05:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794835636; x=1795440436; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ny3ZwgZY30Mi+5Nfyoo4PijzO41OMFelJ3JceOxhb8s=;
 b=A0+wx90qTf5kmRxKouJIBZvmF52FrwoaOdH/u0e9F3V3ruoe6B6pr3s1af9IzLAT1I
 SZFhOGlrrZqAo3vy1BJcIu+8wscqE8De5uaaP4vJbBy5rHdUKAjGy7nmvK3vEcN9yge4
 pQqgaLLI1fqHONU/zix+m3eETvWX4zqL3v39ItDpDhiVH06evisP2NHpdxdBjxPAnpH1
 eaQWYR44T0xEfU5sKTVKngIOkI1abmXb0tZfI7D61t/SNMmEfhG5e44Vd1Pwwji5S/Nh
 h6naCfI1OkXj4pmXA1t1xXKB0z66OUR/1xxSFt0xBA1/DjntkIfzThcmqF5QUovK+zvy
 Hvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794835636; x=1795440436;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ny3ZwgZY30Mi+5Nfyoo4PijzO41OMFelJ3JceOxhb8s=;
 b=CPGmBqljfo9PVnogS6jHiJYT/aL+M7FZova3ncoH7zc45TYdHAHKhsD1t6SNDDZUBR
 CFpnAoc4T07rIkVb7AVej7k8ZI/48Zm2jlJITXd+M5bSwYCKSHGWTO+ABFk+LwSuthKv
 fbCjVhWU4VlLro2IcAnZcx48NeTllamgRD46oZf1T3BXvU3XghnCA1LzN6WLOmyDye9t
 6ULub/hwIMUVVIJepbhoK3OSVj54XT/tJDZfRKf2gpuAvDl9WZTQPhddqMzWtzDZmoHW
 ZUoCW4h/+XCxfCeLQTXxTBzCer/MtVERAK6mEdNb6qCBJTZkCezSk1zZ5xYGdlgXbyxP
 S43Q==
X-Forwarded-Encrypted: i=1;
 AL+hErECpzlyUkJKkJh3WRnzCW5d9cWlurUamK+V/rvtJhdv2efHvdUBXOCiN2tDs9huKJSXFxzD8xd0y4U=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+10Luv0u5zg0+IzYRdt4ff26FicomO/EMStSLIiP+0oBFiQsxQ
 gJkpRxkDZa1BAOIVho4iHIbTrnGaA81SY89/f/SFsh/FTTHNtkz2Jctp
X-Gm-Gg: AZFdTZeiR0jsex9IoBz7TSDnm8JH9FdNFmhDao/zGb2YI9xVaUD5GvXZl8eLqChp6Ff
 m1WXWKXFOxRyx3cTywQYLDEtbiSU/HApBGyXTIxn4ii1DLWljPw9lgYbmbcK7BF0MXZQGi4v8t4
 mkn4bkqcHVT56aLubbjSv+OkdRqbQgGzW9WkprEC5WFByTZXEkFuAYGmBQEND1aAFbiH+8N20tO
 PVa2IY4i6DWR19O8nfMlGZTvYvb/Ne/DddkDngMVPS+6yQzGCZzmIL3rbgaQwQC0vm1xe7i+toE
 eTv44o+AyRKnagdDST0oMEpErmn9O90jXvIPlBzK44VlWSGUvgVGXvEFGs4ZRyEQqxBUYg2m99N
 Wgz/ap/gLEHHRpBRnD/YwQoCfG+vc+F/kCNr/mFOD8S9UtoSII47UG1OAc/r+FK+gUcNq4rjv0Z
 WwzSvzGwqdFiBTgICebJwIXBrnVZZ3w+iqyz8DKG5Ixb4H13Hxp/3x+YFeLGVGapcXVN0dznTJ4
 aRXRzycaiV9yshhm/ZpkvraFviHjqoc1ARmzdArF+l5SWlmWWVFTphjVnclZf2X94WOK2YgXEAY
 F7pJeQzbPgDrT52IfJ4y9OkPFjF+BQhBVtes9ln6l89TiKvdFdtxNDOo
X-Received: by 2002:a05:6000:250d:b0:48f:bf71:2aeb with SMTP id
 ffacd0b85a97d-49c70ed8f89mr25651966f8f.23.1794835636080; 
 Mon, 16 Nov 2026 05:27:16 -0800 (PST)
Received: from ingenieria31.oficinasStQ.local ([79.117.0.220])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c8d286480sm40370240f8f.7.2026.11.16.05.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 05:27:15 -0800 (PST)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/4] drm/tilcdc: Implement state readout support
Date: Mon, 16 Nov 2026 15:27:06 +0100
Message-Id: <20261116142707.1299360-4-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261116142707.1299360-1-maximpedraza@gmail.com>
References: <20261116142707.1299360-1-maximpedraza@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reconstruct the display mode from the LCDC raster registers and read out
the primary plane, to build the initial KMS state from what the bootloader
left scanning out instead of resetting the controller. A splash drawn
before Linux takes over stays on screen, and the first commit replaces it,
with no modeset if it keeps the mode.

The registers don't record everything:
- The channel order isn't stored, so RGB is reported for the adopted
  framebuffer. It doesn't change what's on screen.
- tilcdc_crtc_mode_fixup() is undone to get the requested mode, but a
  positive sync can't be told from a mode that doesn't specify it. Such a
  mode will be reported as different by the post-commit comparison.

If the raster isn't running there's nothing to adopt, and the CRTC and the
plane are read out as disabled.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c    | 173 ++++++++++++++++++++++++
 drivers/gpu/drm/tilcdc/tilcdc_drv.c     |  22 ++-
 drivers/gpu/drm/tilcdc/tilcdc_encoder.c |  29 +++-
 drivers/gpu/drm/tilcdc/tilcdc_plane.c   | 106 +++++++++++++++
 4 files changed, 325 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
index f619b7a6e70d..d5c34763bd96 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
@@ -4,6 +4,7 @@
  * Author: Rob Clark <robdclark@gmail.com>
  */
 
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/of_graph.h>
@@ -11,6 +12,8 @@
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_state_readout_helper.h>
+#include <drm/drm_atomic_uapi.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_fb_dma_helper.h>
 #include <drm/drm_fourcc.h>
@@ -711,10 +714,180 @@ static void tilcdc_crtc_hw_reset(struct drm_crtc *crtc)
 	pm_runtime_put_sync(dev->dev);
 }
 
+/*
+ * Reconstruct the adjusted mode from the LCDC raster registers. This is the
+ * inverse of the register programming done in tilcdc_crtc_set_mode(): the
+ * horizontal front/back porch and sync width are stored as (value - 1), the
+ * pixels-per-line and lines-per-panel as (value - 1) as well, while the
+ * vertical front/back porch are stored verbatim. On the V2 controller a few
+ * high order bits live in RASTER_TIMING_2.
+ *
+ * tilcdc_crtc_mode_fixup() always sets a HSYNC polarity and the skew, so they
+ * can be told from the registers. A positive VSYNC can't be told from a mode
+ * that doesn't specify it: the latter is assumed.
+ */
+static int tilcdc_crtc_readout_mode(struct drm_crtc *crtc,
+				    struct drm_display_mode *mode)
+{
+	struct drm_device *dev = crtc->dev;
+	struct tilcdc_drm_private *priv = ddev_to_tilcdc_priv(dev);
+	u32 t0, t1, t2, ctrl;
+	u32 ppl, hsw, hfp, hbp;
+	u32 lpp, vsw, vfp, vbp;
+	unsigned long clk_rate;
+	unsigned int clkdiv;
+
+	t0 = tilcdc_read(dev, LCDC_RASTER_TIMING_0_REG);
+	t1 = tilcdc_read(dev, LCDC_RASTER_TIMING_1_REG);
+	t2 = tilcdc_read(dev, LCDC_RASTER_TIMING_2_REG);
+	ctrl = tilcdc_read(dev, LCDC_CTRL_REG);
+
+	/* Horizontal fields, low bits in TIMING_0, V2 high bits in TIMING_2. */
+	ppl = (t0 >> 4) & 0x3f;
+	hsw = (t0 >> 10) & 0x3f;
+	hfp = (t0 >> 16) & 0xff;
+	hbp = (t0 >> 24) & 0xff;
+	if (priv->rev == 2) {
+		ppl |= ((t0 >> 3) & 0x1) << 6;
+		hsw |= ((t2 >> 27) & 0xf) << 6;
+		hfp |= (t2 & 0x3) << 8;
+		hbp |= ((t2 >> 4) & 0x3) << 8;
+	}
+	mode->hdisplay = (ppl + 1) << 4;
+	hsw += 1;
+	hfp += 1;
+	hbp += 1;
+
+	/* Vertical fields, LPP high bit in TIMING_2 on V2. */
+	lpp = t1 & 0x3ff;
+	if (priv->rev == 2 && (t2 & LCDC_LPP_B10))
+		lpp |= 0x400;
+	vsw = ((t1 >> 10) & 0x3f) + 1;
+	vfp = (t1 >> 16) & 0xff;
+	vbp = (t1 >> 24) & 0xff;
+	mode->vdisplay = lpp + 1;
+
+	mode->hsync_start = mode->hdisplay + hfp;
+	mode->hsync_end	  = mode->hsync_start + hsw;
+	mode->htotal	  = mode->hsync_end + hbp;
+
+	mode->vsync_start = mode->vdisplay + vfp;
+	mode->vsync_end	  = mode->vsync_start + vsw;
+	mode->vtotal	  = mode->vsync_end + vbp;
+
+	/* Pixel clock is the functional clock divided by the CTRL divisor. */
+	clkdiv = (ctrl & LCDC_CLK_DIVISOR_MASK) >> 8;
+	clk_rate = clk_get_rate(priv->clk);
+	if (!clkdiv || !clk_rate)
+		return -EINVAL;
+	mode->clock = (clk_rate / clkdiv) / 1000;
+
+	mode->flags |= t2 & LCDC_INVERT_HSYNC ? DRM_MODE_FLAG_NHSYNC :
+						DRM_MODE_FLAG_PHSYNC;
+	if (t2 & LCDC_INVERT_VSYNC)
+		mode->flags |= DRM_MODE_FLAG_NVSYNC;
+
+	mode->hskew = hsw;
+	mode->flags |= DRM_MODE_FLAG_HSKEW;
+
+	mode->type |= DRM_MODE_TYPE_DRIVER;
+	drm_mode_set_name(mode);
+	drm_mode_set_crtcinfo(mode, 0);
+
+	return 0;
+}
+
+static int tilcdc_crtc_readout_state(struct drm_crtc *crtc,
+				     struct drm_atomic_sro_state *state,
+				     struct drm_crtc_state *crtc_state)
+{
+	struct drm_device *dev = crtc->dev;
+	struct drm_display_mode adjusted = {}, mode;
+	int ret;
+
+	pm_runtime_get_sync(dev->dev);
+
+	/* Nothing to adopt unless the bootloader left the raster running. */
+	if (!(tilcdc_read(dev, LCDC_RASTER_CTRL_REG) & LCDC_RASTER_ENABLE))
+		goto out;
+
+	ret = tilcdc_crtc_readout_mode(crtc, &adjusted);
+	if (ret)
+		goto err;
+
+	/* Undo tilcdc_crtc_mode_fixup(). */
+	drm_mode_copy(&mode, &adjusted);
+	mode.hskew = 0;
+	mode.flags &= ~(DRM_MODE_FLAG_HSKEW | DRM_MODE_FLAG_NHSYNC |
+			DRM_MODE_FLAG_PHSYNC);
+	if (adjusted.flags & DRM_MODE_FLAG_PHSYNC)
+		mode.flags |= DRM_MODE_FLAG_NHSYNC;
+
+	ret = drm_atomic_set_mode_for_crtc(crtc_state, &mode);
+	if (WARN_ON(ret))
+		goto err;
+
+	drm_mode_copy(&crtc_state->adjusted_mode, &adjusted);
+
+	crtc_state->active = true;
+	crtc_state->enable = true;
+
+	/* The active plane is filled in by tilcdc_plane_readout_state(). */
+
+out:
+	pm_runtime_put_sync(dev->dev);
+	return 0;
+
+err:
+	pm_runtime_put_sync(dev->dev);
+	return ret;
+}
+
+static void tilcdc_crtc_install_state(struct drm_crtc *crtc,
+				      struct drm_crtc_state *crtc_state)
+{
+	struct tilcdc_crtc *tilcdc_crtc = to_tilcdc_crtc(crtc);
+	struct drm_device *dev = crtc->dev;
+	struct tilcdc_drm_private *priv = ddev_to_tilcdc_priv(dev);
+
+	if (!crtc_state->active)
+		return;
+
+	/*
+	 * The display is already scanning out the bootloader's image. Do what
+	 * tilcdc_crtc_enable() and tilcdc_crtc_set_mode() would have done,
+	 * without touching the raster: keep the controller powered, enable its
+	 * interrupts and fill in the software state derived from the mode. A
+	 * commit that doesn't change the mode relies on it, since no modeset
+	 * will update it: set_scanout() uses crtc->mode for the DMA ceiling.
+	 */
+	pm_runtime_get_sync(dev->dev);
+
+	mutex_lock(&tilcdc_crtc->enable_lock);
+
+	drm_mode_copy(&crtc->mode, &crtc_state->mode);
+	drm_mode_copy(&crtc->hwmode, &crtc_state->adjusted_mode);
+	crtc->enabled = true;
+	tilcdc_crtc->hvtotal_us = tilcdc_mode_hvtotal(&crtc->hwmode);
+	tilcdc_crtc->lcd_fck_rate = clk_get_rate(priv->clk);
+	tilcdc_crtc->last_vblank = ktime_get();
+
+	tilcdc_crtc_enable_irqs(dev);
+
+	drm_calc_timestamping_constants(crtc, &crtc->hwmode);
+	drm_crtc_vblank_on(crtc);
+
+	tilcdc_crtc->enabled = true;
+	mutex_unlock(&tilcdc_crtc->enable_lock);
+}
+
 static const struct drm_crtc_funcs tilcdc_crtc_funcs = {
 	.set_config     = drm_atomic_helper_set_config,
 	.page_flip      = drm_atomic_helper_page_flip,
 	.atomic_create_state = drm_atomic_helper_crtc_create_state,
+	.atomic_sro_readout_state = tilcdc_crtc_readout_state,
+	.atomic_sro_install_state = tilcdc_crtc_install_state,
+	.atomic_sro_compare_state = drm_atomic_helper_crtc_compare_state,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
 	.enable_vblank	= tilcdc_crtc_enable_vblank,
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 1d6c9a423a41..ab88632919fa 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -12,6 +12,8 @@
 
 #include <drm/clients/drm_client_setup.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_state_readout.h>
+#include <drm/drm_atomic_state_readout_helper.h>
 #include <drm/drm_debugfs.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_fbdev_dma.h>
@@ -75,6 +77,12 @@ static const struct drm_mode_config_funcs mode_config_funcs = {
 	.fb_create = drm_gem_fb_create,
 	.atomic_check = tilcdc_atomic_check,
 	.atomic_commit = drm_atomic_helper_commit,
+	.atomic_sro_readout_state = drm_atomic_helper_sro_readout_state,
+	.hw_reset = drm_mode_config_helper_hw_reset,
+};
+
+static const struct drm_mode_config_helper_funcs mode_config_helper_funcs = {
+	.atomic_sro_build_state = drm_atomic_helper_sro_build_state,
 };
 
 static void modeset_init(struct drm_device *dev)
@@ -86,6 +94,7 @@ static void modeset_init(struct drm_device *dev)
 	dev->mode_config.max_width = priv->max_width;
 	dev->mode_config.max_height = 2048;
 	dev->mode_config.funcs = &mode_config_funcs;
+	dev->mode_config.helper_private = &mode_config_helper_funcs;
 }
 
 #ifdef CONFIG_CPU_FREQ
@@ -422,10 +431,19 @@ static int tilcdc_pdev_probe(struct platform_device *pdev)
 		goto unregister_cpufreq_notif;
 	}
 
-	drm_mode_config_reset(ddev);
-
 	drm_kms_helper_poll_init(ddev);
 
+	/*
+	 * Build the initial state from whatever the bootloader left running,
+	 * instead of resetting the controller, so a splash drawn before Linux
+	 * takes over is adopted rather than blanked.
+	 */
+	ret = drm_mode_config_create_initial_state(ddev);
+	if (ret) {
+		drm_err(ddev, "failed to create initial state: %d\n", ret);
+		goto stop_poll;
+	}
+
 	ret = drm_dev_register(ddev, 0);
 	if (ret)
 		goto stop_poll;
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_encoder.c b/drivers/gpu/drm/tilcdc/tilcdc_encoder.c
index ac4b5beb2dd5..b3fe18f69f17 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_encoder.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_encoder.c
@@ -9,12 +9,34 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_bridge_connector.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_of.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "tilcdc_drv.h"
 #include "tilcdc_encoder.h"
 
+/*
+ * State readout needs to know which CRTC drives this encoder so the connector
+ * can be tied back to it. tilcdc has a single CRTC, so return the one the
+ * encoder was made possible for.
+ */
+static struct drm_crtc *
+tilcdc_encoder_get_current_crtc(struct drm_encoder *encoder)
+{
+	struct drm_crtc *crtc;
+
+	drm_for_each_crtc(crtc, encoder->dev)
+		if (encoder->possible_crtcs == drm_crtc_mask(crtc))
+			return crtc;
+
+	return NULL;
+}
+
+static const struct drm_encoder_funcs tilcdc_encoder_funcs = {
+	.atomic_sro_get_current_crtc = tilcdc_encoder_get_current_crtc,
+};
+
 static
 int tilcdc_attach_bridge(struct drm_device *ddev, struct drm_bridge *bridge)
 {
@@ -51,8 +73,9 @@ int tilcdc_encoder_create(struct drm_device *ddev)
 	else if (IS_ERR(bridge))
 		return PTR_ERR(bridge);
 
-	encoder = drmm_simple_encoder_alloc(ddev, struct tilcdc_encoder,
-					    base, DRM_MODE_ENCODER_NONE);
+	encoder = drmm_encoder_alloc(ddev, struct tilcdc_encoder, base,
+				     &tilcdc_encoder_funcs,
+				     DRM_MODE_ENCODER_NONE, NULL);
 	if (IS_ERR(encoder)) {
 		drm_err(ddev, "drm_encoder_init() failed %pe\n", encoder);
 		return PTR_ERR(encoder);
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_plane.c b/drivers/gpu/drm/tilcdc/tilcdc_plane.c
index eb0a5562421f..63d936d8cfc6 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_plane.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_plane.c
@@ -4,17 +4,123 @@
  * Author: Jyri Sarha <jsarha@ti.com>
  */
 
+#include <linux/pm_runtime.h>
+
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_state_readout.h>
+#include <drm/drm_atomic_state_readout_helper.h>
+#include <drm/drm_crtc.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
+#include <drm/drm_gem_framebuffer_helper.h>
 
 #include "tilcdc_drv.h"
+#include "tilcdc_regs.h"
+
+static const struct drm_framebuffer_funcs tilcdc_plane_readout_fb_funcs = {
+	.destroy = drm_gem_fb_destroy,
+};
+
+/*
+ * The RASTER_CTRL format bits only encode the pixel depth, not the channel
+ * order, so the RGB/BGR ambiguity is resolved in favour of the RGB variant.
+ * The panel wiring decides the actual order, so this only affects the format
+ * reported for the adopted framebuffer.
+ */
+static u32 tilcdc_plane_readout_format(struct drm_device *dev)
+{
+	u32 ctrl = tilcdc_read(dev, LCDC_RASTER_CTRL_REG);
+
+	if (!(ctrl & LCDC_V2_TFT_24BPP_MODE))
+		return DRM_FORMAT_RGB565;
+	if (ctrl & LCDC_V2_TFT_24BPP_UNPACK)
+		return DRM_FORMAT_XRGB8888;
+	return DRM_FORMAT_RGB888;
+}
+
+static int tilcdc_plane_atomic_readout_state(struct drm_plane *plane,
+					     struct drm_atomic_sro_state *state,
+					     struct drm_plane_state *plane_state)
+{
+	struct drm_device *dev = plane->dev;
+	const struct drm_format_info *info;
+	struct drm_crtc_state *crtc_state;
+	struct drm_framebuffer *fb;
+	struct drm_crtc *crtc;
+	unsigned int w, h;
+	int ret;
+
+	pm_runtime_get_sync(dev->dev);
+
+	if (!(tilcdc_read(dev, LCDC_RASTER_CTRL_REG) & LCDC_RASTER_ENABLE))
+		goto out;
+
+	if (dev->num_crtcs != 1) {
+		ret = -EINVAL;
+		goto err;
+	}
+	crtc = list_first_entry(&dev->mode_config.crtc_list, struct drm_crtc,
+				head);
+
+	crtc_state = drm_atomic_sro_get_crtc_state(state, crtc);
+	if (!crtc_state) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	/* The tilcdc primary plane always covers the whole active area. */
+	w = crtc_state->adjusted_mode.hdisplay;
+	h = crtc_state->adjusted_mode.vdisplay;
+
+	info = drm_format_info(tilcdc_plane_readout_format(dev));
+	if (!info) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	fb = kzalloc_obj(*fb);
+	if (!fb) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	fb->dev = dev;
+	fb->format = info;
+	fb->width = w;
+	fb->height = h;
+	fb->pitches[0] = w * (drm_format_info_bpp(info, 0) / 8);
+	fb->offsets[0] = 0;
+
+	ret = drm_framebuffer_init(dev, fb, &tilcdc_plane_readout_fb_funcs);
+	if (ret) {
+		kfree(fb);
+		goto err;
+	}
+
+	plane_state->fb = fb;
+	plane_state->crtc = crtc;
+	plane_state->src_w = w << 16;
+	plane_state->src_h = h << 16;
+	plane_state->crtc_w = w;
+	plane_state->crtc_h = h;
+
+	crtc_state->plane_mask |= drm_plane_mask(plane);
+
+out:
+	pm_runtime_put_sync(dev->dev);
+	return 0;
+
+err:
+	pm_runtime_put_sync(dev->dev);
+	return ret;
+}
 
 static const struct drm_plane_funcs tilcdc_plane_funcs = {
 	.update_plane	= drm_atomic_helper_update_plane,
 	.disable_plane	= drm_atomic_helper_disable_plane,
 	.atomic_create_state = drm_atomic_helper_plane_create_state,
+	.atomic_sro_readout_state = tilcdc_plane_atomic_readout_state,
+	.atomic_sro_compare_state = drm_atomic_helper_plane_compare_state,
 	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
 };
-- 
2.39.5

