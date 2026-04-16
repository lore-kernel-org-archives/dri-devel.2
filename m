Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D9DF8A144
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 08:29:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89B7310E1A9;
	Thu, 16 Apr 2026 08:29:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZY0Cf53b";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3957410E1A9
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 08:29:33 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-488ba840146so75820795e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 01:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776328172; x=1776932972; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AxfxNFJlvGuF2Od+yfnihIdQvBKtTrOm36dg4RbUpAM=;
 b=ZY0Cf53bFFt8DGyZLC34zI2nghVJou5T90X/KG162xxU5Od6uT3ig6ryi34f1ynoeV
 04n7DtLvNpx8GRqRnqEEEdZlLxnd3sAx8VBMgo7eSVQEvzdUMdwOMr2kpjc8A1FmyL0L
 Qkz3C8EyFONlgis5yCzKxUPo0oI7XZLl5lCQYNPKLMW8uOE2X9jdO+c3nhS4M60dtnRS
 9mEJdh7CClmmtmnkMZE7d8Ut2LGRUVK61DODNg70eEjyv8Zrg7Q3g00u4dU/wqoyfIuI
 PMuBXM8h+0M41gzfcKqQ56Xbp7aeZDv2q4zpKGTZEbcToI8lLIErhY6nZhrPWFHtpPv7
 FJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776328172; x=1776932972;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AxfxNFJlvGuF2Od+yfnihIdQvBKtTrOm36dg4RbUpAM=;
 b=OIBvaBlD9cl2A9UIvT1VvuNnBSAEQBBrNGDqJ8rNULqyWXjVzRWkuFp4PmYJufMDUp
 Zc3/JFqeFA4y2mhjH+A5dNGsdW17AHKsWa9ykFl7Ka51tKrGO+M7ZTqnvpfT6tsijzTm
 LRnKBkuPk9cUwsbiKBPf8jEnO3QTsPzvnk40KL5y7NSnU0BO02mKIPlLPFQR6h1oz1jg
 F2Ci7WEXrG8bNz7w9EJhVnQdUahZAq0sI8x2oCIMkhj8BuJFb0IUBh7SqD/Jj3/W5kti
 VjKgumJ5UY0heigy6QVi+CHiD3MlozyBi32r8i+n+4wnwSNaWKb8XU3I17qorb695NiG
 tUIg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8BUwJEolaRhdiqkh8NvLa4zFozomDuBfgUVqXKJ+zlBOD1AHdDk49zfZVFXyOd0eQ6bpGZhBHVXUU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxOGI4594zlzJ1X5D2wMnRKFhtSMHx5PjmMdm55fokm49VSSb5K
 3/cwUz+vHP2Y7IA6ROvIjLYngPzcoSHRJ6m/k6nVPEoj2HNeiDDW1xCB
X-Gm-Gg: AeBDiet0/ZVrAK95CgseWlKM218UJaP8p4JRnTweRDxVxdHrKoRbgnhCwI0IKhSmyRD
 XIgBwqBKS/FGffXilGqP6ARAMB7aNywPE1ec0BA+cthIVvr8q082VvDphDdZQKAAsbYG5UjYoGX
 4N6TFjAf9eaBuYS4f/9bAzOAEyZiPvHEEP0uvl+FCN8DBgo/4OZxQn6Sh3vjXDbEOl4uh/Lr1z8
 gHegjt4WZXbQ0TgPpaK0thBeiUvTpn4stChoPMVpHJk62cD/Xjj6VRHn401LtX4Y/iFYbLsA4Si
 UMYRLoGbQp+NsCDnhglAP/AQFAQjjoYDsk7Ld7YsJXkt+JL0iMbH1xZWDhiZeXVVTliLSej3Y8y
 Y8zjiPuukPWjOwXthcrO3wwgfRAUPq37G1L8ZMLXf+fSB5dCtT26K8cc1MBL6dKOiybM8S3OXzH
 32tpbVQYGRoB7avqFrAOMoPX4oEztLlfBVb0oCL9uu0lxRCV6t7o7CJxXvlw==
X-Received: by 2002:a05:600c:a404:b0:487:1108:48b8 with SMTP id
 5b1f17b1804b1-488d67b8d97mr295243195e9.2.1776328171424; 
 Thu, 16 Apr 2026 01:29:31 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:b39:3660:ce8b:3f82])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f582048bsm34597475e9.7.2026.04.16.01.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 01:29:31 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Liu Ying <victor.liu@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2] drm/bridge: ite-it6263: Add suspend/resume support
Date: Thu, 16 Apr 2026 09:29:25 +0100
Message-ID: <20260416082928.169347-1-biju.das.jz@bp.renesas.com>
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

From: Biju Das <biju.das.jz@bp.renesas.com>

On the RZ/G3L SMARC EVK using PSCI, suspend to RAM powers down the ITE
IT6263 chip. The display controller driver's system PM callbacks invoke
drm_mode_config_helper_{suspend,resume}, which in turn call the bridge's
atomic_{disable,enable} callbacks can handle suspend/resume for the
bridge without dedicated PM ops.

Introduce it6263_bridge_init() and it6263_bridge_uninit() helpers to
consolidate power sequencing, hardware reset, I2C address setup, and
LVDS/HDMI configuration. These replace the open-coded init sequence in
probe() and are hooked into atomic_enable/atomic_disable respectively,
guarded by a powered flag to avoid redundant re-initialisation.

Switch from devm_regulator_bulk_get_enable() to devm_regulator_bulk_get()
so that regulators can be explicitly enabled and disabled across power
cycles. Move reset_gpio and regulator state into the it6263 struct so they
are accessible beyond probe time.

Add a remove() callback to cleanly power down the bridge on driver unbind
via it6263_bridge_uninit().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Dropped system PM callbacks instead using bridge's
   atomic_{disable,enable} callbacks to handle suspend/resume.
---
 drivers/gpu/drm/bridge/ite-it6263.c | 88 ++++++++++++++++++++++++-----
 1 file changed, 73 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6263.c b/drivers/gpu/drm/bridge/ite-it6263.c
index 4f3ebb7af4d4..1954bb11f7f4 100644
--- a/drivers/gpu/drm/bridge/ite-it6263.c
+++ b/drivers/gpu/drm/bridge/ite-it6263.c
@@ -200,9 +200,13 @@ struct it6263 {
 	struct regmap *lvds_regmap;
 	struct drm_bridge bridge;
 	struct drm_bridge *next_bridge;
+	struct gpio_desc *reset_gpio;
+	struct regulator_bulk_data *supplies;
+	unsigned int num_supplies;
 	int lvds_data_mapping;
 	bool lvds_dual_link;
 	bool lvds_link12_swap;
+	bool powered;
 };
 
 static inline struct it6263 *bridge_to_it6263(struct drm_bridge *bridge)
@@ -578,6 +582,41 @@ static int it6263_read_edid(void *data, u8 *buf, unsigned int block, size_t len)
 	return 0;
 }
 
+static int it6263_bridge_init(struct it6263 *it)
+{
+	int ret;
+
+	ret = regulator_bulk_enable(it->num_supplies, it->supplies);
+	if (ret) {
+		dev_err(it->dev, "failed to enable power supplies\n");
+		return ret;
+	}
+
+	it6263_hw_reset(it->reset_gpio);
+
+	ret = it6263_lvds_set_i2c_addr(it);
+	if (ret) {
+		dev_err(it->dev, "failed to set I2C addr\n");
+		regulator_bulk_disable(it->num_supplies, it->supplies);
+		return ret;
+	}
+
+	it6263_lvds_config(it);
+	it6263_hdmi_config(it);
+
+	it->powered = true;
+
+	return 0;
+}
+
+static int it6263_bridge_uninit(struct it6263 *it)
+{
+	regulator_bulk_disable(it->num_supplies, it->supplies);
+	it->powered = false;
+
+	return 0;
+}
+
 static void it6263_bridge_atomic_disable(struct drm_bridge *bridge,
 					 struct drm_atomic_state *state)
 {
@@ -587,6 +626,8 @@ static void it6263_bridge_atomic_disable(struct drm_bridge *bridge,
 	regmap_write(it->hdmi_regmap, HDMI_REG_PKT_GENERAL_CTRL, 0);
 	regmap_write(it->hdmi_regmap, HDMI_REG_AFE_DRV_CTRL,
 		     AFE_DRV_RST | AFE_DRV_PWD);
+
+	it6263_bridge_uninit(it);
 }
 
 static void it6263_bridge_atomic_enable(struct drm_bridge *bridge,
@@ -603,6 +644,9 @@ static void it6263_bridge_atomic_enable(struct drm_bridge *bridge,
 	bool pclk_high;
 	int i, ret;
 
+	if (!it->powered)
+		it6263_bridge_init(it);
+
 	connector = drm_atomic_get_new_connector_for_encoder(state,
 							     bridge->encoder);
 	crtc = drm_atomic_get_new_connector_state(state, connector)->crtc;
@@ -840,7 +884,6 @@ static const struct drm_bridge_funcs it6263_bridge_funcs = {
 static int it6263_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
-	struct gpio_desc *reset_gpio;
 	struct it6263 *it;
 	int ret;
 
@@ -858,13 +901,21 @@ static int it6263_probe(struct i2c_client *client)
 		return dev_err_probe(dev, PTR_ERR(it->hdmi_regmap),
 				     "failed to init I2C regmap for HDMI\n");
 
-	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(reset_gpio))
-		return dev_err_probe(dev, PTR_ERR(reset_gpio),
+	it->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(it->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(it->reset_gpio),
 				     "failed to get reset gpio\n");
 
-	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(it6263_supplies),
-					     it6263_supplies);
+	it->num_supplies = ARRAY_SIZE(it6263_supplies);
+	it->supplies = devm_kcalloc(dev, it->num_supplies,
+				    sizeof(*it->supplies), GFP_KERNEL);
+	if (!it->supplies)
+		return -ENOMEM;
+
+	for (unsigned int i = 0; i < it->num_supplies; i++)
+		it->supplies[i].supply = it6263_supplies[i];
+
+	ret = devm_regulator_bulk_get(dev, it->num_supplies, it->supplies);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to get power supplies\n");
 
@@ -872,12 +923,6 @@ static int it6263_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	it6263_hw_reset(reset_gpio);
-
-	ret = it6263_lvds_set_i2c_addr(it);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to set I2C addr\n");
-
 	it->lvds_i2c = devm_i2c_new_dummy_device(dev, client->adapter,
 						 LVDS_INPUT_CTRL_I2C_ADDR);
 	if (IS_ERR(it->lvds_i2c))
@@ -890,8 +935,9 @@ static int it6263_probe(struct i2c_client *client)
 		return dev_err_probe(dev, PTR_ERR(it->lvds_regmap),
 				     "failed to init I2C regmap for LVDS\n");
 
-	it6263_lvds_config(it);
-	it6263_hdmi_config(it);
+	ret = it6263_bridge_init(it);
+	if (ret)
+		return ret;
 
 	i2c_set_clientdata(client, it);
 
@@ -903,7 +949,18 @@ static int it6263_probe(struct i2c_client *client)
 	it->bridge.vendor = "ITE";
 	it->bridge.product = "IT6263";
 
-	return devm_drm_bridge_add(dev, &it->bridge);
+	ret = devm_drm_bridge_add(dev, &it->bridge);
+	if (ret)
+		it6263_bridge_uninit(it);
+
+	return ret;
+}
+
+static void it6263_remove(struct i2c_client *i2c)
+{
+	struct it6263 *it = i2c_get_clientdata(i2c);
+
+	it6263_bridge_uninit(it);
 }
 
 static const struct of_device_id it6263_of_match[] = {
@@ -920,6 +977,7 @@ MODULE_DEVICE_TABLE(i2c, it6263_i2c_ids);
 
 static struct i2c_driver it6263_driver = {
 	.probe = it6263_probe,
+	.remove = it6263_remove,
 	.driver = {
 		.name = "it6263",
 		.of_match_table = it6263_of_match,
-- 
2.43.0

