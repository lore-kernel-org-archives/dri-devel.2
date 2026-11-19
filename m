Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C6C606A333
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NWoIkRYD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCBD910F06C;
	Thu, 19 Nov 2026 17:55:01 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 264D710F04E
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 17:54:49 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4bb606491faso15014345e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795110887; x=1795715687; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v3k0HZdPqxYwdAA2PNjfVeZTkUhOnuqm9brEsVD8HB0=;
 b=NWoIkRYD4PLm9k/8IO/KJR1r5EjnXSsQFGBXMHXAHuw5FaR3HrUUsGMiZ0CeebT1tD
 yzPB9U/AxCnmWILDpVId5hw9s4N6MYKnHjpyXAJpjr+07jussIfNOsFDPb3zH2q+gJmY
 lufGNHgu2qgYRPo1nYkp78S61MFotBODhekicI2Tw1AnMeb2U75AgPQ1+vwe+lT+qs9a
 7UpLCzQQmokVbhOprVE2dG0jJm93fwUAfXqYeGZ03GKypFjNCBGs84nVUi1NTup1p1Se
 N/RuJFckFMRA0fraHn1Jbez+jzZODfI4ZfFCxKRNeu1uN5dgBWx6ajIzdak1nvdhVyGM
 /W/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795110887; x=1795715687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=v3k0HZdPqxYwdAA2PNjfVeZTkUhOnuqm9brEsVD8HB0=;
 b=WAopUKHKU6/cqzOfTeYkk72JWRt+i/uOhfGsj4ab4pzX+aDby/7tsdIxI5mFIPswSy
 3df5xvWLcfZa4InigyeKw2141x9BIgKBX+83KFAX+K7w6agcQu3BBBxsieyGGyKQMP+x
 KYSe85d6krn4z2JyA/oWe5i3oqpbEGViZg9fPj6mYPEYi5740jLBpMdEV5zawDNwxZCn
 RPl6lS+Ze/iMPqq+Xm8cvKCCj7pJ+/l3W2oxvbhdiqRKq0iG4FLHBei+DqezhBqK24R5
 bAvaPm0NGShmYTMuwTO38TIBKgd0rYbx4AZ9XyoZD44fQmN+n6LNifaAoZ9nq/S6khuo
 HXdA==
X-Forwarded-Encrypted: i=1;
 AL+hErFX1Mb03NK2IOzN0eTsn5QiyXGiQZkOo1feNirn54s8fYt2XwTN8uLK7UXCFAkhbRsYvjdNPGa4G3g=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z81wluAl/ydbjYSqFjD/hwpv5WdwRnGHABeL24+UHRwZJlMGO/C
 dN9z/32XDCTtQexe6Vg7uaVK4gyiKI84tZryikEILYfLPsIHm3kTOzyx
X-Gm-Gg: AYBFou1b42SKdtIZh3eRQV5xIDp4aqiw3zo9IuSzBMTJpokZym+7VBG3S/7l46HP2Iv
 2xCL8/gAPrwBFNjHiCTEjhf+gcQfQem0lOMGe+Qwre/SEZqPZFGn1RShHdt3LMSzC51AhXsCuH0
 c44nsDe+HOTMlUL19SMAW4LOMKvVvVOoGtcXwjQsM1mjn4yujitsG/iucRwXgAn3pR5tyI48hXD
 1TTRFT11OApSrjpR7m2Er/6KDiRWv7mVtINIyEL3GP/VtinbKaAOTOiAoVk8cN4GftfPEp/0G4g
 uA4oUO2kWhQl8ex3IdyZbduhMhaXRqI4EscFLkGTQOeLyKkTj4cTjVfiCeL80W2+Vcxp8UAMzxu
 0a0iDJYVuGtN5CjtDTlcYvPlS5mvsiNEzdVqm1xo7wsNmjZDIq/N6PiLdNrkB53a63901sgp6lV
 UfgJQ+woLZzZnkaJu+Zybg00o7fmH9amcB8g5AIxAs9dfHr5Mw1taPTnlkjs7AKTisKu6KKs7/r
 GB6j/LKezz43e2ewMen/P9Ta61TZQ7fxkaj8rTHUkO9IJZ/SR5UmstblDU1GffGKjBgHXMZIX30
 vDxIyvByUlezykijWQCdQ9mxKarou0AW4suzJNf4yKwRg42XD2ZUC6U4Enbk7gCqxcf2+wJwM+o
 v8Uoq05x8WvpoPHgF9D4ynxPf+w3NVTErZ2lg6XZwfXaQmM9b6UZTI69rqmOT0XpPLR+20bR+ni
 rhBFMxCtT5S/dwMLh8hj7jzLB4Grv266AMmI+FUUXBuJ2mAtmB78u7WLDcDpH1sc8jWooPFSoTM
 eLk6qBZNEg8CMEA5R7eVFr2tjcJS9krbmtIdC1yi4YrDNgqz3JcSAPW
X-Received: by 2002:a05:600c:8210:b0:4a1:dbdf:17a8 with SMTP id
 5b1f17b1804b1-4bb887e25e8mr7783735e9.2.1795110887406; 
 Thu, 19 Nov 2026 09:54:47 -0800 (PST)
Received: from jernej-laptop (95-143-148-21.dynamic.telemach.net.
 [95.143.148.21]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb84e50512sm29390035e9.3.2026.11.19.09.54.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 09:54:47 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Andre Przywara <andre.przywara@arm.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] drm/sun4i: Add DE33 shared plane driver
Date: Thu, 19 Nov 2026 18:54:35 +0100
Message-ID: <20261119175437.2520400-4-jernej.skrabec@gmail.com>
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

DE33 makes its plane channels shared resources that mixers select through
routing registers in the display clock block. The existing mixer-local
plane initialization cannot represent that topology.

Add a driver that owns the shared plane register space, programs the
default channel-to-mixer mapping and creates each mixer's DRM planes
from that mapping.

The driver is only added here. It gets registered and used by the
mixer driver in a later patch, which switches DE33 to the new bindings.

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/Makefile        |   3 +-
 drivers/gpu/drm/sun4i/sun50i_planes.c | 209 ++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun50i_planes.h |  43 ++++++
 3 files changed, 254 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/sun4i/sun50i_planes.c
 create mode 100644 drivers/gpu/drm/sun4i/sun50i_planes.h

diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
index bad7497a0d11..501e3d867918 100644
--- a/drivers/gpu/drm/sun4i/Makefile
+++ b/drivers/gpu/drm/sun4i/Makefile
@@ -16,7 +16,8 @@ sun8i-drm-hdmi-y		+= sun8i_hdmi_phy_clk.o
 
 sun8i-mixer-y			+= sun8i_mixer.o sun8i_ui_layer.o \
 				   sun8i_vi_layer.o sun8i_ui_scaler.o \
-				   sun8i_vi_scaler.o sun8i_csc.o
+				   sun8i_vi_scaler.o sun8i_csc.o \
+				   sun50i_planes.o
 
 sun4i-tcon-y			+= sun4i_crtc.o
 sun4i-tcon-y			+= sun4i_tcon_dclk.o
diff --git a/drivers/gpu/drm/sun4i/sun50i_planes.c b/drivers/gpu/drm/sun4i/sun50i_planes.c
new file mode 100644
index 000000000000..05607445cc38
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun50i_planes.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) 2026 Jernej Skrabec <jernej.skrabec@gmail.com> */
+
+#include <drm/drm_device.h>
+
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include "sun50i_planes.h"
+#include "sun8i_ui_layer.h"
+#include "sun8i_vi_layer.h"
+
+static const struct sun50i_planes_quirks sun50i_h616_planes_quirks = {
+	.def_map = {
+		{
+			.map = {0, 6, 7},
+			.num_ch = 3,
+		},
+		{
+			.map = {1, 2, 8},
+			.num_ch = 3,
+		},
+	},
+	.cfg = {
+		.de_type	= SUN8I_MIXER_DE33,
+		/*
+		 * TODO: All planes support scaling, but driver needs
+		 * improvements to properly support it.
+		 */
+		.scaler_mask    = 0,
+		.scanline_yuv	= 4096,
+	},
+};
+
+static const struct of_device_id sun50i_planes_of_table[] = {
+	{
+		.compatible = "allwinner,sun50i-h616-de33-planes",
+		.data = &sun50i_h616_planes_quirks
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sun50i_planes_of_table);
+
+struct drm_plane **
+sun50i_planes_setup(struct device *dev, struct drm_device *drm,
+		    unsigned int mixer)
+{
+	struct sun50i_planes *planes = dev_get_drvdata(dev);
+	const struct sun50i_planes_quirks *quirks;
+	struct drm_plane **drm_planes;
+	const struct default_map *map;
+	unsigned int i;
+
+	if (!of_match_node(sun50i_planes_of_table, dev->of_node))
+		return ERR_PTR(dev_err_probe(dev, -EINVAL,
+					     "Device is not planes driver!\n"));
+
+	if (!planes)
+		return ERR_PTR(dev_err_probe(dev, -EINVAL,
+					     "Planes driver is not loaded yet!\n"));
+
+	if (mixer >= MAX_DISP)
+		return ERR_PTR(dev_err_probe(dev, -EINVAL,
+					     "Mixer index is too high!\n"));
+
+	quirks = planes->quirks;
+	map = &quirks->def_map[mixer];
+
+	drm_planes = devm_kcalloc(drm->dev, map->num_ch + 1,
+				  sizeof(*drm_planes), GFP_KERNEL);
+	if (!drm_planes)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < map->num_ch; i++) {
+		unsigned int phy_ch = map->map[i];
+		struct sun8i_layer *layer;
+		enum drm_plane_type type;
+
+		if ((i == 0 && map->num_ch == 1) || i == 1)
+			type = DRM_PLANE_TYPE_PRIMARY;
+		else
+			type = DRM_PLANE_TYPE_OVERLAY;
+
+		if (phy_ch < UI_PLANE_OFFSET)
+			layer = sun8i_vi_layer_init_one(drm, type, planes->regs,
+							i, phy_ch, map->num_ch,
+							&quirks->cfg);
+		else
+			layer = sun8i_ui_layer_init_one(drm, type, planes->regs,
+							i, phy_ch, map->num_ch,
+							&quirks->cfg);
+
+		if (IS_ERR(layer))
+			return ERR_PTR(dev_err_probe(drm->dev, PTR_ERR(layer),
+						     "Couldn't initialize DRM plane\n"));
+
+		drm_planes[i] = &layer->plane;
+	}
+
+	return drm_planes;
+}
+
+static void sun50i_planes_init_mapping(struct sun50i_planes *planes)
+{
+	const struct sun50i_planes_quirks *quirks = planes->quirks;
+	unsigned int i, j;
+	u32 mapping;
+
+	mapping = 0;
+	for (j = 0; j < MAX_DISP; j++)
+		for (i = 0; i < quirks->def_map[j].num_ch; i++) {
+			unsigned int ch = quirks->def_map[j].map[i];
+
+			if (ch < UI_PLANE_OFFSET)
+				mapping |= j << (ch * 2);
+			else
+				mapping |= j << ((ch - UI_PLANE_OFFSET) * 2 + 16);
+		}
+	regmap_write(planes->mapping, SUNXI_DE33_DE_CHN2CORE_MUX_REG, mapping);
+
+	for (j = 0; j < MAX_DISP; j++) {
+		mapping = 0;
+		for (i = 0; i < quirks->def_map[j].num_ch; i++) {
+			unsigned int ch = quirks->def_map[j].map[i];
+
+			if (ch >= UI_PLANE_OFFSET)
+				ch += 2;
+
+			mapping |= ch << (i * 4);
+		}
+		regmap_write(planes->mapping, SUNXI_DE33_DE_PORT02CHN_MUX_REG + j * 4, mapping);
+	}
+}
+
+static const struct regmap_config sun50i_planes_regmap_config = {
+	.name		= "planes",
+	.reg_bits	= 32,
+	.val_bits	= 32,
+	.reg_stride	= 4,
+	.max_register	= 0x17fffc,
+};
+
+static int sun50i_planes_probe(struct platform_device *pdev)
+{
+	struct platform_device *clk_pdev;
+	struct device *dev = &pdev->dev;
+	struct sun50i_planes *planes;
+	struct device_node *np;
+	void __iomem *regs;
+
+	planes = devm_kzalloc(dev, sizeof(*planes), GFP_KERNEL);
+	if (!planes)
+		return -ENOMEM;
+
+	planes->quirks = of_device_get_match_data(dev);
+	if (!planes->quirks)
+		return dev_err_probe(dev, -EINVAL, "Unable to get quirks\n");
+
+	np = of_parse_phandle(dev->of_node,
+			      "allwinner,plane-mapping", 0);
+	if (!np)
+		return dev_err_probe(dev, -EINVAL, "Missing mapping phandle\n");
+
+	clk_pdev = of_find_device_by_node(np);
+	of_node_put(np);
+	if (!clk_pdev)
+		return dev_err_probe(dev, -EPROBE_DEFER, "Unable to get mapping\n");
+
+	/* Regmap is registered by display clocks driver during its probe. */
+	planes->mapping = dev_get_regmap(&clk_pdev->dev, NULL);
+	if (!planes->mapping) {
+		platform_device_put(clk_pdev);
+		return dev_err_probe(dev, -EPROBE_DEFER, "Unable to get regmap\n");
+	}
+
+	if (!device_link_add(dev, &clk_pdev->dev,
+			     DL_FLAG_AUTOREMOVE_CONSUMER)) {
+		platform_device_put(clk_pdev);
+		return dev_err_probe(dev, -EINVAL, "Failed to create link\n");
+	}
+	platform_device_put(clk_pdev);
+
+	regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	planes->regs = devm_regmap_init_mmio(dev, regs, &sun50i_planes_regmap_config);
+	if (IS_ERR(planes->regs))
+		return PTR_ERR(planes->regs);
+
+	sun50i_planes_init_mapping(planes);
+
+	dev_set_drvdata(dev, planes);
+
+	return 0;
+}
+
+struct platform_driver sun50i_planes_platform_driver = {
+	.probe		= sun50i_planes_probe,
+	.driver		= {
+		.name		= "sun50i-planes",
+		.of_match_table	= sun50i_planes_of_table,
+	},
+};
diff --git a/drivers/gpu/drm/sun4i/sun50i_planes.h b/drivers/gpu/drm/sun4i/sun50i_planes.h
new file mode 100644
index 000000000000..9b4f77a6b94e
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun50i_planes.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2026 Jernej Skrabec <jernej.skrabec@gmail.com> */
+
+#ifndef _SUN50I_PLANES_H_
+#define _SUN50I_PLANES_H_
+
+#include "sun8i_mixer.h"
+
+/* mapping registers, located in clock register space */
+#define SUNXI_DE33_DE_CHN2CORE_MUX_REG	0x24
+#define SUNXI_DE33_DE_PORT02CHN_MUX_REG	0x28
+#define SUNXI_DE33_DE_PORT12CHN_MUX_REG	0x2c
+
+#define MAX_DISP	2
+#define MAX_CHANNELS	8
+#define UI_PLANE_OFFSET	6
+
+struct regmap;
+struct drm_device;
+
+struct default_map {
+	unsigned int map[MAX_CHANNELS];
+	unsigned int num_ch;
+};
+
+struct sun50i_planes_quirks {
+	struct default_map	def_map[MAX_DISP];
+	struct sun8i_layer_cfg	cfg;
+};
+
+struct sun50i_planes {
+	struct regmap				*regs;
+	struct regmap				*mapping;
+	const struct sun50i_planes_quirks	*quirks;
+};
+
+struct drm_plane **
+sun50i_planes_setup(struct device *dev, struct drm_device *drm,
+		    unsigned int mixer);
+
+extern struct platform_driver sun50i_planes_platform_driver;
+
+#endif /* _SUN50I_PLANES_H_ */
-- 
2.43.0

