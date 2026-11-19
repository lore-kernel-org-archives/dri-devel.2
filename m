Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41BE606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UdULPGhL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E06C10F082;
	Thu, 19 Nov 2026 17:55:15 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9041910F06C
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 17:54:52 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so26901645e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795110891; x=1795715691; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bz3NO8S23PrM10kHofxJdDquSac/ELeH8koKyIr5zoE=;
 b=UdULPGhL1WqIWbD0F6fJT1G2M0DgM7Rz4Is01J00xJGQ1LXrLkVKX1nr16g5Q3fyAg
 0/hE2KithgzYTJ5mSKR2gIMZXSfV7H7pk3iaRaPZYm6nJJG0Rld+j4H+C5K60zjk5TYo
 shFutM1twvjH9L0CB5Y1ilzSZyEhVEkE4JBSPCDEPZHkH7GeoIX4t0IowldWqLg7Yp1H
 LTPsrE/dUaINsw5CT+db/+MKsbYiCqwPyHJfd9XdyDLugcMhAlN+/T+7oXl6K8F4X+Gl
 wALDaUJjbxV1Mf3eZlprAl80Y2xUjXir8ZiRIJoDK7g8XNdL88c4ntjp/ss/Dl3iyPAd
 6vHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795110891; x=1795715691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Bz3NO8S23PrM10kHofxJdDquSac/ELeH8koKyIr5zoE=;
 b=WpRgiilDOigibE7aERxsK7aCNIDYWFYgXjDme77RKqnP6HKc0eMnb76zdOEP/CpyIC
 d0VZjhx9WpY2w9ZB0BZshqA+6n4Qq7jg/lDaUWYOx4PjmrmKnJFjSLb3XVFa8BV312es
 gseFuHLcZ0A9ce+LoTMXHZpqzIgdDmbPilJHwo78zapeG/7b2hitbqVZptPaOWRXvp2I
 9KFEk/cgx7H3RHFx2BxkdyHMadWKeGNvsacxD7d63vsRr/gLR0W5Bb4zj3pIsxYa00Ht
 wt//8BnQjvJlWrkInd9Y0W9SlMbOmSvSInt9tKnPDNS4HUCtEvGojy7TaUSwYEYqo+j5
 Chxw==
X-Forwarded-Encrypted: i=1;
 AL+hErFlVP4t00ucW+z2+RXmHrIV0hkBkvJZbzWwPOYorXWuVvolP9elay7xRiyCKxt38y8wJwBE5kVeSY0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/RBDvUD4cPqIR0GZ7Ixsx5GwomcSq8LyvYpWVeTo9PzDdSIDNP
 Fz53VcmwswsbWvrW8P0DP+aXH5asU5CsmZjw/Ljks8yKgFAYZVvlSfiw
X-Gm-Gg: AYBFou1IqNdUpzwVgOQXDFq6fANCYPXfklDq+Cr3lHGr2KVp47qJNM9JCxtOd0OEFre
 xqgz7ZNjyGDXSt0jTSiaGhl5vjLHxfhJMN26oI3un6xXSIVCHVtoLuzNJKQpWZQY8uhVhXHrCzN
 BWdUI+DdWEP+ZRXSpVvGES+SQ2aK2TRWPMoVYW5+bQeaMehXbZ5XwX+FZgC7Wq5vvWswulz0E7y
 F4t2itci+5QylA6ODBYbS4HjZQRqGOB2t3I5MOoIo0irqCOGlVNilUBmDMDUEgXL6FleNsIbbW9
 aFfnxmjEnjOS8m1LYsHp4G8/lkTGvc5Oc12ArVVgY7Dodgmd6sneGKg3LVSF1578dat+S8TItQp
 QRxStnxvb+UtJUPzYvzFkIXZ8xfcWZG9NJaCJDE+yQkes0bmM+PD9T1VJPV8h3oWeKeRAuEvPPe
 aTEn5UtzaJJdIhNH0ihe1nJc2/oku095FDK6P5/1vkAtLS0SnFkEc0VdmSi+vvwwrUWoPo84AHI
 NZNV6L7RAEgYjIhOOYoKQ9owa5qYHv71WKaAo9+JOBzAos1j52Mb1dEOFq44jNP1/zzjOKtodew
 rKlc3wJizXi3kog7XRoEAQWs2TsRSVfb5DJ6YtVUvxJAakPwg7cLa4DPvz0zCX6ZhC2JvWgunJ2
 Fay8XajnFzqER6E7rWtRL4TYIa1mWLpTEneVc5RTkUw2EhNmKvQqSpEb+859g/EmSCYVcMWfYlw
 p4UnD0Ae2bWci3N9AgBvRu3MiH21gaoVuRWfyiS8oJONgo49mD8jIP2yzeMW4tf7VJfJzvHwCK4
 FGmRAVx871K3pSrfmiV+BbArCMFcrSEy7/Gf6X+Zt19tD8eO93G6n+uJTiMdzi5kk+aYE3KTxu5
 Gw==
X-Received: by 2002:a05:600c:5307:b0:4a3:d327:6ed with SMTP id
 5b1f17b1804b1-4bb888283d8mr7139155e9.17.1795110890838; 
 Thu, 19 Nov 2026 09:54:50 -0800 (PST)
Received: from jernej-laptop (95-143-148-21.dynamic.telemach.net.
 [95.143.148.21]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb84e50512sm29390035e9.3.2026.11.19.09.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 09:54:49 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Andre Przywara <andre.przywara@arm.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] drm/sun4i: Switch DE33 to split plane bindings
Date: Thu, 19 Nov 2026 18:54:37 +0100
Message-ID: <20261119175437.2520400-6-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119175437.2520400-1-jernej.skrabec@gmail.com>
References: <20261119175437.2520400-1-jernej.skrabec@gmail.com>
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

The shared plane driver and split register resources are now in place.
Switch DE33 mixer discovery to the new bindings and remove the legacy
per-mixer plane setup. Mixer register space now covers only display
blending control, so limit its regmap accordingly.

The old DE33 binding is not supported anymore, since it can't describe
shared planes and was never used by any device tree. If it's detected,
print an error asking the user to update the device tree, instead of
failing silently or misusing the plane register space as blender
registers.

Note that the plane driver doesn't enable the scalers yet, so H616
planes can't be scaled anymore after this change. YUV formats were
already removed for DE33 for the same reason.

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 191 ++++++++++++++++++++--------
 drivers/gpu/drm/sun4i/sun8i_mixer.h |  11 +-
 2 files changed, 136 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index dbde80b32080..4677180ec780 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_graph.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 
@@ -28,6 +29,7 @@
 #include "sun8i_mixer.h"
 #include "sun8i_ui_layer.h"
 #include "sun8i_vi_layer.h"
+#include "sun50i_planes.h"
 #include "sunxi_engine.h"
 
 struct de2_fmt_info {
@@ -257,7 +259,6 @@ static void sun8i_mixer_commit(struct sunxi_engine *engine,
 {
 	struct sun8i_mixer *mixer = engine_to_sun8i_mixer(engine);
 	u32 bld_base = sun8i_blender_base(mixer);
-	struct regmap *bld_regs = sun8i_blender_regmap(mixer);
 	struct drm_plane_state *plane_state;
 	struct drm_plane *plane;
 	u32 route = 0, pipe_en = 0;
@@ -294,16 +295,16 @@ static void sun8i_mixer_commit(struct sunxi_engine *engine,
 		route |= layer->index << SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(zpos);
 		pipe_en |= SUN8I_MIXER_BLEND_PIPE_CTL_EN(zpos);
 
-		regmap_write(bld_regs,
+		regmap_write(engine->regs,
 			     SUN8I_MIXER_BLEND_ATTR_COORD(bld_base, zpos),
 			     SUN8I_MIXER_COORD(x, y));
-		regmap_write(bld_regs,
+		regmap_write(engine->regs,
 			     SUN8I_MIXER_BLEND_ATTR_INSIZE(bld_base, zpos),
 			     SUN8I_MIXER_SIZE(w, h));
 	}
 
-	regmap_write(bld_regs, SUN8I_MIXER_BLEND_ROUTE(bld_base), route);
-	regmap_write(bld_regs, SUN8I_MIXER_BLEND_PIPE_CTL(bld_base),
+	regmap_write(engine->regs, SUN8I_MIXER_BLEND_ROUTE(bld_base), route);
+	regmap_write(engine->regs, SUN8I_MIXER_BLEND_PIPE_CTL(bld_base),
 		     pipe_en | SUN8I_MIXER_BLEND_PIPE_CTL_FC_EN(0));
 
 	if (mixer->cfg->de_type != SUN8I_MIXER_DE33)
@@ -318,7 +319,6 @@ static struct drm_plane **sun8i_layers_init(struct drm_device *drm,
 	struct sun8i_mixer *mixer = engine_to_sun8i_mixer(engine);
 	int plane_cnt = mixer->cfg->ui_num + mixer->cfg->vi_num;
 	enum drm_plane_type type;
-	unsigned int phy_index;
 	int i;
 
 	planes = devm_kzalloc_objs(drm->dev, *planes, plane_cnt + 1);
@@ -333,12 +333,8 @@ static struct drm_plane **sun8i_layers_init(struct drm_device *drm,
 		else
 			type = DRM_PLANE_TYPE_OVERLAY;
 
-		phy_index = i;
-		if (mixer->cfg->de_type == SUN8I_MIXER_DE33)
-			phy_index = mixer->cfg->map[i];
-
 		layer = sun8i_vi_layer_init_one(drm, type, mixer->engine.regs,
-						i, phy_index, plane_cnt,
+						i, i, plane_cnt,
 						&mixer->cfg->lay_cfg);
 		if (IS_ERR(layer)) {
 			dev_err(drm->dev,
@@ -358,12 +354,8 @@ static struct drm_plane **sun8i_layers_init(struct drm_device *drm,
 		else
 			type = DRM_PLANE_TYPE_OVERLAY;
 
-		phy_index = index;
-		if (mixer->cfg->de_type == SUN8I_MIXER_DE33)
-			phy_index = mixer->cfg->map[index];
-
 		layer = sun8i_ui_layer_init_one(drm, type, mixer->engine.regs,
-						index, phy_index, plane_cnt,
+						index, index, plane_cnt,
 						&mixer->cfg->lay_cfg);
 		if (IS_ERR(layer)) {
 			dev_err(drm->dev, "Couldn't initialize %s plane\n",
@@ -377,16 +369,34 @@ static struct drm_plane **sun8i_layers_init(struct drm_device *drm,
 	return planes;
 }
 
+static struct drm_plane **sun50i_layers_init(struct drm_device *drm,
+					     struct sunxi_engine *engine)
+{
+	struct sun8i_mixer *mixer = engine_to_sun8i_mixer(engine);
+	unsigned int base = sun8i_blender_base(mixer);
+	struct drm_plane **planes;
+	int i;
+
+	planes = sun50i_planes_setup(mixer->planes_dev, drm, engine->id);
+	if (IS_ERR(planes))
+		return planes;
+
+	for (i = 0; planes[i]; i++)
+		regmap_write(engine->regs,
+			     SUN8I_MIXER_BLEND_MODE(base, i),
+			     SUN8I_MIXER_BLEND_MODE_DEF);
+
+	return planes;
+}
+
 static void sun8i_mixer_mode_set(struct sunxi_engine *engine,
 				 const struct drm_display_mode *mode)
 {
 	struct sun8i_mixer *mixer = engine_to_sun8i_mixer(engine);
-	struct regmap *bld_regs;
 	u32 bld_base, size, val;
 	bool interlaced;
 
 	bld_base = sun8i_blender_base(mixer);
-	bld_regs = sun8i_blender_regmap(mixer);
 	interlaced = !!(mode->flags & DRM_MODE_FLAG_INTERLACE);
 	size = SUN8I_MIXER_SIZE(mode->hdisplay, mode->vdisplay);
 
@@ -398,14 +408,14 @@ static void sun8i_mixer_mode_set(struct sunxi_engine *engine,
 	else
 		regmap_write(mixer->engine.regs, SUN8I_MIXER_GLOBAL_SIZE, size);
 
-	regmap_write(bld_regs, SUN8I_MIXER_BLEND_OUTSIZE(bld_base), size);
+	regmap_write(engine->regs, SUN8I_MIXER_BLEND_OUTSIZE(bld_base), size);
 
 	if (interlaced)
 		val = SUN8I_MIXER_BLEND_OUTCTL_INTERLACED;
 	else
 		val = 0;
 
-	regmap_update_bits(bld_regs, SUN8I_MIXER_BLEND_OUTCTL(bld_base),
+	regmap_update_bits(engine->regs, SUN8I_MIXER_BLEND_OUTCTL(bld_base),
 			   SUN8I_MIXER_BLEND_OUTCTL_INTERLACED, val);
 
 	DRM_DEBUG_DRIVER("Switching display mixer interlaced mode %s\n",
@@ -418,6 +428,12 @@ static const struct sunxi_engine_ops sun8i_engine_ops = {
 	.mode_set	= sun8i_mixer_mode_set,
 };
 
+static const struct sunxi_engine_ops sun50i_engine_ops = {
+	.commit		= sun8i_mixer_commit,
+	.layers_init	= sun50i_layers_init,
+	.mode_set	= sun8i_mixer_mode_set,
+};
+
 static const struct regmap_config sun8i_mixer_regmap_config = {
 	.name		= "layers",
 	.reg_bits	= 32,
@@ -434,12 +450,12 @@ static const struct regmap_config sun8i_top_regmap_config = {
 	.max_register	= 0x3c,
 };
 
-static const struct regmap_config sun8i_disp_regmap_config = {
+static const struct regmap_config sun50i_mixer33_regmap_config = {
 	.name		= "display",
 	.reg_bits	= 32,
 	.val_bits	= 32,
 	.reg_stride	= 4,
-	.max_register	= 0x20000,
+	.max_register	= 0x1fffc,
 };
 
 static int sun8i_mixer_of_get_id(struct device_node *node)
@@ -464,17 +480,14 @@ static int sun8i_mixer_of_get_id(struct device_node *node)
 
 static void sun8i_mixer_init(struct sun8i_mixer *mixer)
 {
-	struct regmap *top_regs, *disp_regs;
 	unsigned int base = sun8i_blender_base(mixer);
+	struct regmap *top_regs;
 	int plane_cnt, i;
 
-	if (mixer->cfg->de_type == SUN8I_MIXER_DE33) {
+	if (mixer->cfg->de_type == SUN8I_MIXER_DE33)
 		top_regs = mixer->top_regs;
-		disp_regs = mixer->disp_regs;
-	} else {
+	else
 		top_regs = mixer->engine.regs;
-		disp_regs = mixer->engine.regs;
-	}
 
 	/* Enable the mixer */
 	regmap_write(top_regs, SUN8I_MIXER_GLOBAL_CTL,
@@ -484,25 +497,29 @@ static void sun8i_mixer_init(struct sun8i_mixer *mixer)
 		regmap_write(top_regs, SUN50I_MIXER_GLOBAL_CLK, 1);
 
 	/* Set background color to black */
-	regmap_write(disp_regs, SUN8I_MIXER_BLEND_BKCOLOR(base),
+	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_BKCOLOR(base),
 		     SUN8I_MIXER_BLEND_COLOR_BLACK);
 
 	/*
 	 * Set fill color of bottom plane to black. Generally not needed
 	 * except when VI plane is at bottom (zpos = 0) and enabled.
 	 */
-	regmap_write(disp_regs, SUN8I_MIXER_BLEND_PIPE_CTL(base),
+	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_PIPE_CTL(base),
 		     SUN8I_MIXER_BLEND_PIPE_CTL_FC_EN(0));
-	regmap_write(disp_regs, SUN8I_MIXER_BLEND_ATTR_FCOLOR(base, 0),
+	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_ATTR_FCOLOR(base, 0),
 		     SUN8I_MIXER_BLEND_COLOR_BLACK);
 
+	/*
+	 * plane_cnt is 0 for DE33. Blend mode will be initialized in
+	 * layer init function, where the number of planes is known.
+	 */
 	plane_cnt = mixer->cfg->vi_num + mixer->cfg->ui_num;
 	for (i = 0; i < plane_cnt; i++)
-		regmap_write(disp_regs,
+		regmap_write(mixer->engine.regs,
 			     SUN8I_MIXER_BLEND_MODE(base, i),
 			     SUN8I_MIXER_BLEND_MODE_DEF);
 
-	regmap_update_bits(disp_regs, SUN8I_MIXER_BLEND_PIPE_CTL(base),
+	regmap_update_bits(mixer->engine.regs, SUN8I_MIXER_BLEND_PIPE_CTL(base),
 			   SUN8I_MIXER_BLEND_PIPE_CTL_EN_MSK, 0);
 }
 
@@ -533,7 +550,6 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
 	if (!mixer)
 		return -ENOMEM;
 	dev_set_drvdata(dev, mixer);
-	mixer->engine.ops = &sun8i_engine_ops;
 	mixer->engine.node = dev->of_node;
 
 	/*
@@ -566,12 +582,33 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
 	if (!mixer->cfg)
 		return -EINVAL;
 
+	if (mixer->cfg->de_type == SUN8I_MIXER_DE33) {
+		/*
+		 * The original DE33 binding described planes as part of
+		 * the mixer, which can't work with more than one mixer.
+		 * It was never used by any device tree, so it's not
+		 * supported.
+		 */
+		if (of_property_match_string(dev->of_node, "reg-names", "layers") >= 0 ||
+		    !of_property_present(dev->of_node, "allwinner,planes"))
+			return dev_err_probe(dev, -EINVAL,
+					     "Unsupported DE33 mixer binding, please update the device tree\n");
+
+		mixer->engine.ops = &sun50i_engine_ops;
+	} else {
+		mixer->engine.ops = &sun8i_engine_ops;
+	}
+
 	regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
-	mixer->engine.regs = devm_regmap_init_mmio(dev, regs,
-						   &sun8i_mixer_regmap_config);
+	if (mixer->cfg->de_type == SUN8I_MIXER_DE33)
+		mixer->engine.regs = devm_regmap_init_mmio(dev, regs,
+							   &sun50i_mixer33_regmap_config);
+	else
+		mixer->engine.regs = devm_regmap_init_mmio(dev, regs,
+							   &sun8i_mixer_regmap_config);
 	if (IS_ERR(mixer->engine.regs)) {
 		dev_err(dev, "Couldn't create the mixer regmap\n");
 		return PTR_ERR(mixer->engine.regs);
@@ -588,17 +625,6 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
 			dev_err(dev, "Couldn't create the top regmap\n");
 			return PTR_ERR(mixer->top_regs);
 		}
-
-		regs = devm_platform_ioremap_resource_byname(pdev, "display");
-		if (IS_ERR(regs))
-			return PTR_ERR(regs);
-
-		mixer->disp_regs = devm_regmap_init_mmio(dev, regs,
-							 &sun8i_disp_regmap_config);
-		if (IS_ERR(mixer->disp_regs)) {
-			dev_err(dev, "Couldn't create the disp regmap\n");
-			return PTR_ERR(mixer->disp_regs);
-		}
 	}
 
 	mixer->reset = devm_reset_control_get(dev, NULL);
@@ -638,6 +664,36 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
 
 	clk_prepare_enable(mixer->mod_clk);
 
+	if (mixer->cfg->de_type == SUN8I_MIXER_DE33) {
+		struct platform_device *planes_pdev;
+		struct device_node *np;
+
+		np = of_parse_phandle(dev->of_node, "allwinner,planes", 0);
+		if (!np) {
+			ret = -ENODEV;
+			goto err_disable_mod_clk;
+		}
+
+		planes_pdev = of_find_device_by_node(np);
+		of_node_put(np);
+		if (!planes_pdev) {
+			ret = -EPROBE_DEFER;
+			goto err_disable_mod_clk;
+		}
+		mixer->planes_dev = &planes_pdev->dev;
+
+		/* Planes driver must not unbind between the check and the link */
+		scoped_guard(device, mixer->planes_dev) {
+			if (!device_is_bound(mixer->planes_dev))
+				ret = -EPROBE_DEFER;
+			else if (!device_link_add(dev, mixer->planes_dev,
+						  DL_FLAG_AUTOREMOVE_CONSUMER))
+				ret = -EINVAL;
+		}
+		if (ret)
+			goto err_put_device;
+	}
+
 	list_add_tail(&mixer->engine.list, &drv->engine_list);
 
 	/* Reset registers and disable unused sub-engines */
@@ -672,6 +728,11 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
 
 	return 0;
 
+err_put_device:
+	if (mixer->cfg->de_type == SUN8I_MIXER_DE33)
+		put_device(mixer->planes_dev);
+err_disable_mod_clk:
+	clk_disable_unprepare(mixer->mod_clk);
 err_disable_bus_clk:
 	clk_disable_unprepare(mixer->bus_clk);
 err_assert_reset:
@@ -686,6 +747,9 @@ static void sun8i_mixer_unbind(struct device *dev, struct device *master,
 
 	list_del(&mixer->engine.list);
 
+	if (mixer->cfg->de_type == SUN8I_MIXER_DE33)
+		put_device(mixer->planes_dev);
+
 	clk_disable_unprepare(mixer->mod_clk);
 	clk_disable_unprepare(mixer->bus_clk);
 	reset_control_assert(mixer->reset);
@@ -867,16 +931,8 @@ static const struct sun8i_mixer_cfg sun50i_h6_mixer0_cfg = {
 };
 
 static const struct sun8i_mixer_cfg sun50i_h616_mixer0_cfg = {
-	.lay_cfg = {
-		.de_type	= SUN8I_MIXER_DE33,
-		.scaler_mask	= 0xf,
-		.scanline_yuv	= 4096,
-	},
 	.de_type	= SUN8I_MIXER_DE33,
 	.mod_rate	= 600000000,
-	.ui_num		= 3,
-	.vi_num		= 1,
-	.map		= {0, 6, 7, 8},
 };
 
 static const struct of_device_id sun8i_mixer_of_table[] = {
@@ -940,7 +996,30 @@ static struct platform_driver sun8i_mixer_platform_driver = {
 		.of_match_table	= sun8i_mixer_of_table,
 	},
 };
-module_platform_driver(sun8i_mixer_platform_driver);
+
+static int __init sun8i_mixer_module_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&sun50i_planes_platform_driver);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&sun8i_mixer_platform_driver);
+	if (ret)
+		platform_driver_unregister(&sun50i_planes_platform_driver);
+
+	return ret;
+}
+
+static void __exit sun8i_mixer_module_exit(void)
+{
+	platform_driver_unregister(&sun8i_mixer_platform_driver);
+	platform_driver_unregister(&sun50i_planes_platform_driver);
+}
+
+module_init(sun8i_mixer_module_init);
+module_exit(sun8i_mixer_module_exit);
 
 MODULE_AUTHOR("Icenowy Zheng <icenowy@aosc.io>");
 MODULE_DESCRIPTION("Allwinner DE2 Mixer driver");
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index e2f83301aae8..9552c0bd9b99 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -193,7 +193,6 @@ struct sun8i_layer_cfg {
  * @de_type: sun8i_mixer_type enum representing the display engine generation.
  * @mod_rate: module clock rate that needs to be set in order to have
  *	a functional block.
- * @map: channel map for DE variants processing YUV separately (DE33)
  */
 
 struct sun8i_mixer_cfg {
@@ -202,7 +201,6 @@ struct sun8i_mixer_cfg {
 	int			ui_num;
 	unsigned int		de_type;
 	unsigned long		mod_rate;
-	unsigned int		map[6];
 };
 
 struct sun8i_mixer {
@@ -216,7 +214,7 @@ struct sun8i_mixer {
 	struct clk			*mod_clk;
 
 	struct regmap			*top_regs;
-	struct regmap			*disp_regs;
+	struct device			*planes_dev;
 };
 
 enum {
@@ -252,13 +250,6 @@ sun8i_blender_base(struct sun8i_mixer *mixer)
 	return mixer->cfg->de_type == SUN8I_MIXER_DE3 ? DE3_BLD_BASE : DE2_BLD_BASE;
 }
 
-static inline struct regmap *
-sun8i_blender_regmap(struct sun8i_mixer *mixer)
-{
-	return mixer->cfg->de_type == SUN8I_MIXER_DE33 ?
-		mixer->disp_regs : mixer->engine.regs;
-}
-
 static inline u32
 sun8i_channel_base(struct sun8i_layer *layer)
 {
-- 
2.43.0

