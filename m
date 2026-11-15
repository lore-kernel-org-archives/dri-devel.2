Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7779606A327
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 06:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VkgcWeHi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 006B010E241;
	Sun, 15 Nov 2026 06:11:56 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5BB510E1D0
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 06:11:31 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4bb6ba3b244so1104195e9.3
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 22:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794723090; x=1795327890; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uUl8Gcdr1CjrV+R7vEydrBbKUTZ9VI9y6BS4nuOZ0fM=;
 b=VkgcWeHiJ4eOFJAdt17UAyTlgzFZHJ+AjXukDG7wL+6UengCEq06rXULaLDn1LAiBn
 uSaqKvCRj9Q+1/cnPvj+gbdByk1p3UXaScJqfUDah8Yh8yd3dcF7eNkbBjZv7StjS1t3
 ZL71jOKPKGzq70qjDHsJsp4UkuYJArb9LcRo3/yFGyLkt2tCxyoJ0b/H3GK13haIoONc
 uZelD5mpP4S9LJ40+cmotSgvnpoqfL4QPpO3yQWOnfI/4s5Vle/AHGDtark3Hfpmyuxc
 fsovCU58yKZuRe5xVZW20CfPBG8kAE5hFp9gBWhBUpzedJZK7yiYVr54wXoo3vS0Jqnj
 k2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794723090; x=1795327890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uUl8Gcdr1CjrV+R7vEydrBbKUTZ9VI9y6BS4nuOZ0fM=;
 b=d/5K9+59AmrzgYNqgkOoCepgkZNPCJoiUUKXRSBAN/9bHNN5BgKQfVhdcBVEOCnHFA
 XvlPA2/uxATCnUOGlnw4DMdvRXBnZokWP9kVIxT+2/69EvUyIlLiKWMVcEdgNujMUiAM
 xF9LaCMyMZAK+pLn8pQRUg5/I+GRZ8cOkZZwAynFF0N+lVgVn0fv/zr4W0Whbookdei6
 W6xrZXXRsPctV9ZB8AELSVR4biCaYXLMndFx7RRv2f0pXBc95oE6+86CCVnw9pz+2bWc
 KPnWTqaew6SrSPycW08MtZb3m+OQtEQj1897jVq03PTkmpWVBlgztx9Ro9N0gMvsG6Mj
 wPfA==
X-Forwarded-Encrypted: i=1;
 AL+hErEnpipXGqgMbCkv5Ty60sioCxCnBnSdv52T5PF7xhC/bk5amOZ+5KleT9NEqCKonVVgR1XizHBIMtg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8w3SqO1hESa4AbxaqkxYKIaXOuOjf8a1FWLgB1F5YfNd0QcxPn
 IKnyF/b5J/kkHa7agiHgYSUAW5lJpWFlFgsrTBtjsaPSDGq4sjKYDu5Z
X-Gm-Gg: AYBFou0bJYyVf7uvmv8AOvVIylR1jsMFRwsI56L25dzRlVDNQVyniBCm2jZik7g5ylk
 Uf4TwdG13P3cMCRb7PsMNmDlc/ocOcRoUqQttcj3jbH5uHKz9mD/NoEM1h02QiHsSm9AWn/V0NI
 JHXjOGvDXemfgt1ds8TPpVWBYi3/V93WAmw+IHKojIHa0uC2c5FVu7q7D6gtk/3ayQ4uO7fl9n0
 fyYSAqlluunbyOZWyD5Kx6lEjQlHiH2rJ2UqyKYCNoo8F2bAEKwBxmYV4BR/y4Oe0WpPUHIh5+N
 tg1CdpSJG8RnRf1JKWoKax2hliP5Y10Cs9W5ymoqH9t+Q5NSG/4vITucNmeRwR4fEfaHpiNCQSn
 j/GH5C4FXC80mr9ledpecDzpGpC+ewOp2rRbgQhXpyugYm1oE1kCRFV5P+lPAOZpM20g6A/L3fs
 lGmXafa1Knjxpur4O8tW5UCCiQPTbIE6ttE2Ku2HtU9C9INr64hRcybUXeNdJYrvHJoAlGqvNxO
 VIgsmLiiCcuw3hE9kMhyUnNptKAu59pYhZPX6ynBHUkoKwQD5hsnLu+Aksxy3wBT41QIYQnV/0u
 JMXHnTB5TysM+4DEhg5y2Ty9prfcmLhGxWkEn6T9opZq8TUxcPJjN1Rqg+ZxHXchqMArxJmYlhA
 8KRvtvKl7zjzPZOHxF56xxYALb94Z7eGn6O1Rs/PqG+kDE97CQ1njoQgxvF2jsucuLn3VVUn9Ji
 2NKDXvCM9NW9liQdnvx5NWn8WZ1IpXbR9/8CHfI16e2b4TFYePavQ2YCKSSG0j0X8JsDeGpnBYT
 q3swo/6KYbjcQ==
X-Received: by 2002:a05:600c:3f12:b0:4a1:dadf:9876 with SMTP id
 5b1f17b1804b1-4bb55a644bfmr147443945e9.23.1794723090126; 
 Sat, 14 Nov 2026 22:11:30 -0800 (PST)
Received: from jernej-laptop ([2a00:ee2:6a02:9300:bb69:6bcf:1b11:e85b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb5ba25b50sm139331075e9.14.2026.11.14.22.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 22:11:29 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, bmasney+clk@redhat.com, jbrunet+clk@baylibre.com,
 sboyd@kernel.org, Andre Przywara <andre.przywara@arm.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 6/8] drm/sun4i: Add DE33 shared plane driver
Date: Sun, 15 Nov 2026 07:11:00 +0100
Message-ID: <20261115061102.229680-7-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261115061102.229680-1-jernej.skrabec@gmail.com>
References: <20261115061102.229680-1-jernej.skrabec@gmail.com>
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

Add a component that owns the shared plane register space, programs the
default channel-to-mixer mapping and creates each mixer's DRM planes
from that mapping.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/Makefile        |   3 +-
 drivers/gpu/drm/sun4i/sun50i_planes.c | 215 ++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun50i_planes.h |  43 ++++++
 3 files changed, 260 insertions(+), 1 deletion(-)
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
index 000000000000..22b9f104a391
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun50i_planes.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) 2025 Jernej Skrabec <jernej.skrabec@gmail.com> */
+
+#include <drm/drm_device.h>
+
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_graph.h>
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
+	if (!of_match_node(sun50i_planes_of_table, dev->of_node)) {
+		dev_err(dev, "Device is not planes driver!\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (!planes) {
+		dev_err(dev, "Planes driver is not loaded yet!\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (mixer > 1) {
+		dev_err(dev, "Mixer index is too high!\n");
+		return ERR_PTR(-EINVAL);
+	}
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
+		if (IS_ERR(layer)) {
+			dev_err(drm->dev,
+				"Couldn't initialize DRM plane\n");
+			return ERR_CAST(layer);
+		}
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
index 000000000000..7be969491f9c
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun50i_planes.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2025 Jernej Skrabec <jernej.skrabec@gmail.com> */
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

