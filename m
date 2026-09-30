Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721EFCA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B736A10F202;
	Wed, 30 Sep 2026 07:15:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V95ni53A";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB5AC10F1FE
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 07:15:28 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d3920so37209665e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 00:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790752527; x=1791357327; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xy5wkzMBDai0ibEAQHhU8t8eub8tmRN97Lc336OwGWQ=;
 b=V95ni53A1xoUusjs56giC29RmJz0wW4yV6iURNNKtyzhhoudQZCow+qAFO3+tw3vul
 xiSIjXmZ2XZXOYr7FLUC59Odo6QHd5KwPG8mcPx/RxmtNq5wBaDkVhEs0W20XBlA7dmJ
 SUXGQ2ibgE8MSHPLFDeW7ZuEgIjxP7iu4m84AvR5IPIPyKECJcOnWNWOqWZmz3xKpXQI
 1t1o30B8m7EmzJd+pixyO/1zjcJn3y9mDFve0mqhGcvuTSH73IxIY6VBsL2JR1ZuOAXO
 6Y+7btzNuuilR3lCeXCPHwvWevy1E5bPdD4CBybasqOlTtFJeHlkp23tlyuNKFZWia11
 K+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790752527; x=1791357327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xy5wkzMBDai0ibEAQHhU8t8eub8tmRN97Lc336OwGWQ=;
 b=rlx7fxnCqWWQed8zKeSAv6d9ZOIahBEOtDKyIINfDOgtGiJ1N/lf0Cl02k3lcst3Q3
 HI+E9f/3zT02Wmplv0yY2j8VggQMm0WQlSfZzSzuPZhx0HMxuBDMQYHnPtEqMCSucPb5
 HpjCTct5thK+EvTyES+5ByEmuO0Cfoou1bl/d065Wevpd6HS4/dPOo1ZD5FyVtWuF71/
 cEZAt6gsyA4XLf/YN27mxehtAi14T8WOk0Q+9ocbBnOEnREd83U1GK3gzGY8ZQFltsCG
 PyxfQcQtMxLpcN+vxtoWZAU6RmPbmNS5QPgh7Tq29yrqQjpQf5B6rAyKjSpeLFksOGtR
 daww==
X-Forwarded-Encrypted: i=1;
 AKwUvBwH81cEr83I9pUOGgSeD9HZQfWlgIeyo6OxMp2733FxcU/XmTZ611/TD2Pkwij5EW9E/nJH7m0oeDQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mkraMx0RAN4x9oyPfyH6DUDaWRlriKiFXSQZP+SEcvKEvSuybQ
 yJScb5sUr/8ish2llqutM28cb7orPSHjub+9qoMhITsu1x1uubrJ/7uK
X-Gm-Gg: AYBFou1ZL9VFohtunejk4f+asatRKdW2O3bBLn6DxrlBvGX0kRg0wzYYj0yku8MVJEE
 o8H1+9GjAAfQ82wPLIefJAzGWsQ19LVzB8z9OaLWqS0s9xVJOg83a9cDmdK9bbkCciLnSPK6Acs
 E42Zx1HcpBHrpUA1mw8AIoSEAq9B+sufB49qrK5XFP2XGBAZnglTL4NufR7dZL1PQdRGqf/nKxN
 6RYqOpS1HKJHU80e9AyKbY+4J2SzZkhQcSAtW0RPAKOvwwKjJ5EfeYPtKcPE+i8jcQxxppDe2iQ
 b/ybTtI4b7ieQz5iI/Qaql9fGdVrmN51aw3LR+p9AqGmbgNkxsfNT1WnPbxBYzbImgOHjwv8gGn
 N0G/dsPgcLWRr8kAUO1op93ZHioZigMK1rvgD7AAgFgg95M90Cn4l0sAZxQsoLAV9nEs3Q0dikc
 m4uvZ6oRfX22TCNUWkiWufQirCVkWTrlM2ic/Z3Yr6x3c/Xq7qYUHxaSmWCgnBxwqhpV1jx3WbG
 OTMkcvGZ/emOdvGo7c=
X-Received: by 2002:a05:600c:4fc9:b0:49f:c331:39e4 with SMTP id
 5b1f17b1804b1-4a01aff3ba9mr6314965e9.7.1790752527030; 
 Wed, 30 Sep 2026 00:15:27 -0700 (PDT)
Received: from xeon ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029be7e4sm1256979f8f.12.2026.09.30.00.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 00:15:26 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v1 2/3] mfd: aat2870: Convert to use OF bindings
Date: Wed, 30 Sep 2026 10:15:12 +0300
Message-ID: <20260930071513.54697-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930071513.54697-1-clamor95@gmail.com>
References: <20260930071513.54697-1-clamor95@gmail.com>
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

Conversion of the AAT2870 driver to use OF bindings requires a few complex
changes that should be done simultaneously.

The AAT2870 essentially provides two functions via child devices:
backlight and regulators. Both functions are fairly self-sufficient and
may not be populated on the final board. Consequently, the MFD
registration API was replaced with of_platform_populate(), and each
sub-device was given its own compatible string.

Additionally, aat2870-core utilizes an enable GPIO. Obtaining this GPIO
was converted to use modern gpiod/OF helpers, allowing the redundant
aat2870_enable() and aat2870_disable() helpers to be removed.

The aat2870-regulator driver was updated to register each of the four LDOs
from a dedicated OF node.

The aat2870-backlight driver was changed to populate all required
properties from a dedicated Device Tree node. Its channel map was updated
to use u8 instead of int. Furthermore, because the maximum current is now
parsed as an absolute value rather than an enum entry, the calculation and
application of the maximum current were updated accordingly.

All of the changes above allow platform data to be removed entirely.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/aat2870-core.c            | 115 ++++++--------------------
 drivers/regulator/aat2870-regulator.c |  70 +++++++++++-----
 drivers/video/backlight/aat2870_bl.c  |  54 ++++++------
 include/linux/mfd/aat2870.h           |  95 +--------------------
 4 files changed, 104 insertions(+), 230 deletions(-)

diff --git a/drivers/mfd/aat2870-core.c b/drivers/mfd/aat2870-core.c
index 0d56cd6fbc6a5..8f6d7956e79b2 100644
--- a/drivers/mfd/aat2870-core.c
+++ b/drivers/mfd/aat2870-core.c
@@ -16,8 +16,15 @@
 #include <linux/gpio/legacy.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/aat2870.h>
+#include <linux/of_platform.h>
 #include <linux/regulator/machine.h>
 
+struct aat2870_register {
+	bool readable;
+	bool writeable;
+	u8 value;
+};
+
 static struct aat2870_register aat2870_regs[AAT2870_REG_NUM] = {
 	/* readable, writeable, value */
 	{ 0, 1, 0x00 },	/* 0x00 AAT2870_BL_CH_EN */
@@ -61,34 +68,6 @@ static struct aat2870_register aat2870_regs[AAT2870_REG_NUM] = {
 	{ 0, 1, 0x00 },	/* 0x26 AAT2870_LDO_EN */
 };
 
-static struct mfd_cell aat2870_devs[] = {
-	{
-		.name = "aat2870-backlight",
-		.id = AAT2870_ID_BL,
-		.pdata_size = sizeof(struct aat2870_bl_platform_data),
-	},
-	{
-		.name = "aat2870-regulator",
-		.id = AAT2870_ID_LDOA,
-		.pdata_size = sizeof(struct regulator_init_data),
-	},
-	{
-		.name = "aat2870-regulator",
-		.id = AAT2870_ID_LDOB,
-		.pdata_size = sizeof(struct regulator_init_data),
-	},
-	{
-		.name = "aat2870-regulator",
-		.id = AAT2870_ID_LDOC,
-		.pdata_size = sizeof(struct regulator_init_data),
-	},
-	{
-		.name = "aat2870-regulator",
-		.id = AAT2870_ID_LDOD,
-		.pdata_size = sizeof(struct regulator_init_data),
-	},
-};
-
 static int __aat2870_read(struct aat2870_data *aat2870, u8 addr, u8 *val)
 {
 	int ret;
@@ -196,22 +175,6 @@ static int aat2870_update(struct aat2870_data *aat2870, u8 addr, u8 mask,
 	return ret;
 }
 
-static inline void aat2870_enable(struct aat2870_data *aat2870)
-{
-	if (aat2870->en_pin >= 0)
-		gpio_set_value(aat2870->en_pin, 1);
-
-	aat2870->is_enable = 1;
-}
-
-static inline void aat2870_disable(struct aat2870_data *aat2870)
-{
-	if (aat2870->en_pin >= 0)
-		gpio_set_value(aat2870->en_pin, 0);
-
-	aat2870->is_enable = 0;
-}
-
 #ifdef CONFIG_DEBUG_FS
 static ssize_t aat2870_dump_reg(struct aat2870_data *aat2870, char *buf)
 {
@@ -332,9 +295,7 @@ static inline void aat2870_init_debugfs(struct aat2870_data *aat2870)
 
 static int aat2870_i2c_probe(struct i2c_client *client)
 {
-	struct aat2870_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct aat2870_data *aat2870;
-	int i, j;
 	int ret = 0;
 
 	aat2870 = devm_kzalloc(&client->dev, sizeof(struct aat2870_data),
@@ -348,60 +309,29 @@ static int aat2870_i2c_probe(struct i2c_client *client)
 
 	aat2870->reg_cache = aat2870_regs;
 
-	if (pdata->en_pin < 0)
-		aat2870->en_pin = -1;
-	else
-		aat2870->en_pin = pdata->en_pin;
+	aat2870->en_pin = devm_gpiod_get_optional(&client->dev, "enable",
+						  GPIOD_OUT_HIGH);
+	if (IS_ERR(aat2870->en_pin))
+		return dev_err_probe(&client->dev, PTR_ERR(aat2870->en_pin),
+				     "Failed to get EN GPIO\n");
 
-	aat2870->init = pdata->init;
-	aat2870->uninit = pdata->uninit;
 	aat2870->read = aat2870_read;
 	aat2870->write = aat2870_write;
 	aat2870->update = aat2870_update;
 
 	mutex_init(&aat2870->io_lock);
 
-	if (aat2870->init)
-		aat2870->init(aat2870);
-
-	if (aat2870->en_pin >= 0) {
-		ret = devm_gpio_request_one(&client->dev, aat2870->en_pin,
-					GPIOF_OUT_INIT_HIGH, "aat2870-en");
-		if (ret < 0) {
-			dev_err(&client->dev,
-				"Failed to request GPIO %d\n", aat2870->en_pin);
-			return ret;
-		}
-	}
-
-	aat2870_enable(aat2870);
-
-	for (i = 0; i < pdata->num_subdevs; i++) {
-		for (j = 0; j < ARRAY_SIZE(aat2870_devs); j++) {
-			if ((pdata->subdevs[i].id == aat2870_devs[j].id) &&
-					!strcmp(pdata->subdevs[i].name,
-						aat2870_devs[j].name)) {
-				aat2870_devs[j].platform_data =
-					pdata->subdevs[i].platform_data;
-				break;
-			}
-		}
-	}
+	gpiod_set_value(aat2870->en_pin, 1);
 
-	ret = mfd_add_devices(aat2870->dev, 0, aat2870_devs,
-			      ARRAY_SIZE(aat2870_devs), NULL, 0, NULL);
-	if (ret != 0) {
-		dev_err(aat2870->dev, "Failed to add subdev: %d\n", ret);
-		goto out_disable;
+	ret = of_platform_populate(client->dev.of_node, NULL, NULL, &client->dev);
+	if (ret) {
+		gpiod_set_value(aat2870->en_pin, 0);
+		return dev_err_probe(&client->dev, ret, "Failed to populate cells\n");
 	}
 
 	aat2870_init_debugfs(aat2870);
 
 	return 0;
-
-out_disable:
-	aat2870_disable(aat2870);
-	return ret;
 }
 
 static int aat2870_i2c_suspend(struct device *dev)
@@ -409,7 +339,7 @@ static int aat2870_i2c_suspend(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct aat2870_data *aat2870 = i2c_get_clientdata(client);
 
-	aat2870_disable(aat2870);
+	gpiod_set_value(aat2870->en_pin, 0);
 
 	return 0;
 }
@@ -421,7 +351,7 @@ static int aat2870_i2c_resume(struct device *dev)
 	struct aat2870_register *reg = NULL;
 	int i;
 
-	aat2870_enable(aat2870);
+	gpiod_set_value(aat2870->en_pin, 1);
 
 	/* restore registers */
 	for (i = 0; i < AAT2870_REG_NUM; i++) {
@@ -436,6 +366,12 @@ static int aat2870_i2c_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(aat2870_pm_ops, aat2870_i2c_suspend,
 				aat2870_i2c_resume);
 
+static const struct of_device_id aat2870_match_table[] = {
+	{ .compatible = "skyworks,aat2870" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, aat2870_match_table);
+
 static const struct i2c_device_id aat2870_i2c_id_table[] = {
 	{ "aat2870" },
 	{ }
@@ -444,6 +380,7 @@ static const struct i2c_device_id aat2870_i2c_id_table[] = {
 static struct i2c_driver aat2870_i2c_driver = {
 	.driver = {
 		.name			= "aat2870",
+		.of_match_table		= aat2870_match_table,
 		.pm			= pm_sleep_ptr(&aat2870_pm_ops),
 		.suppress_bind_attrs	= true,
 	},
diff --git a/drivers/regulator/aat2870-regulator.c b/drivers/regulator/aat2870-regulator.c
index 970d86f2bbb81..4d399d0486d19 100644
--- a/drivers/regulator/aat2870-regulator.c
+++ b/drivers/regulator/aat2870-regulator.c
@@ -15,6 +15,15 @@
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/mfd/aat2870.h>
+#include <linux/regulator/of_regulator.h>
+
+/* Device IDs */
+enum aat2870_regulator_id {
+	AAT2870_ID_LDOA,
+	AAT2870_ID_LDOB,
+	AAT2870_ID_LDOC,
+	AAT2870_ID_LDOD
+};
 
 struct aat2870_regulator {
 	struct aat2870_data *aat2870;
@@ -121,6 +130,13 @@ static struct aat2870_regulator aat2870_regulators[] = {
 	AAT2870_LDO(LDOD),
 };
 
+static struct of_regulator_match aat2870_regulator_matches[] = {
+	{ .name = "ldo-a" },
+	{ .name = "ldo-b" },
+	{ .name = "ldo-c" },
+	{ .name = "ldo-d" },
+};
+
 static struct aat2870_regulator *aat2870_get_regulator(int id)
 {
 	struct aat2870_regulator *ri = NULL;
@@ -136,12 +152,11 @@ static struct aat2870_regulator *aat2870_get_regulator(int id)
 		return NULL;
 
 	ri->enable_addr = AAT2870_LDO_EN;
-	ri->enable_shift = id - AAT2870_ID_LDOA;
+	ri->enable_shift = id;
 	ri->enable_mask = 0x1 << ri->enable_shift;
 
-	ri->voltage_addr = (id - AAT2870_ID_LDOA) / 2 ?
-			   AAT2870_LDO_CD : AAT2870_LDO_AB;
-	ri->voltage_shift = (id - AAT2870_ID_LDOA) % 2 ? 0 : 4;
+	ri->voltage_addr = id / 2 ? AAT2870_LDO_CD : AAT2870_LDO_AB;
+	ri->voltage_shift = id % 2 ? 0 : 4;
 	ri->voltage_mask = 0xF << ri->voltage_shift;
 
 	return ri;
@@ -152,33 +167,50 @@ static int aat2870_regulator_probe(struct platform_device *pdev)
 	struct aat2870_regulator *ri;
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
+	int ret;
 
-	ri = aat2870_get_regulator(pdev->id);
-	if (!ri) {
-		dev_err(&pdev->dev, "Invalid device ID, %d\n", pdev->id);
-		return -EINVAL;
-	}
-	ri->aat2870 = dev_get_drvdata(pdev->dev.parent);
+	ret = of_regulator_match(&pdev->dev, pdev->dev.of_node,
+				 aat2870_regulator_matches,
+				 ARRAY_SIZE(aat2870_regulator_matches));
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Parsing of regulator node failed\n");
 
-	config.dev = &pdev->dev;
-	config.driver_data = ri;
-	config.init_data = dev_get_platdata(&pdev->dev);
+	for (int idx = 0; idx < ARRAY_SIZE(aat2870_regulator_matches); idx++) {
+		if (!aat2870_regulator_matches[idx].of_node)
+			continue;
 
-	rdev = devm_regulator_register(&pdev->dev, &ri->desc, &config);
-	if (IS_ERR(rdev)) {
-		dev_err(&pdev->dev, "Failed to register regulator %s\n",
-			ri->desc.name);
-		return PTR_ERR(rdev);
+		ri = aat2870_get_regulator(idx);
+		if (!ri)
+			return dev_err_probe(&pdev->dev, -EINVAL,
+					     "Invalid device ID, %d\n", idx);
+
+		ri->aat2870 = dev_get_drvdata(pdev->dev.parent);
+
+		config.dev = &pdev->dev;
+		config.driver_data = ri;
+
+		rdev = devm_regulator_register(&pdev->dev, &ri->desc, &config);
+		if (IS_ERR(rdev))
+			return dev_err_probe(&pdev->dev, PTR_ERR(rdev),
+					     "Failed to register regulator %s\n",
+					     ri->desc.name);
 	}
-	platform_set_drvdata(pdev, rdev);
 
 	return 0;
 }
 
+static const struct of_device_id aat2870_regulator_match_table[] = {
+	{ .compatible = "skyworks,aat2870-regulator" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, aat2870_regulator_match_table);
+
 static struct platform_driver aat2870_regulator_driver = {
 	.driver = {
 		.name	= "aat2870-regulator",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.of_match_table = aat2870_regulator_match_table,
 	},
 	.probe	= aat2870_regulator_probe,
 };
diff --git a/drivers/video/backlight/aat2870_bl.c b/drivers/video/backlight/aat2870_bl.c
index 8b790df1e842b..bb4c5f9e5af2e 100644
--- a/drivers/video/backlight/aat2870_bl.c
+++ b/drivers/video/backlight/aat2870_bl.c
@@ -15,11 +15,19 @@
 #include <linux/backlight.h>
 #include <linux/mfd/aat2870.h>
 
+/* Backlight has 8 channels, each bit represents one channel */
+#define AAT2870_BL_CH_ALL	0xFF
+
+/* Backlight current magnitude (mA) */
+#define AAT2870_CURRENT_MIN	450000
+#define AAT2870_CURRENT_MAX	27900000
+#define AAT2870_CURRENT_STEP	900000
+
 struct aat2870_bl_driver_data {
 	struct platform_device *pdev;
 	struct backlight_device *bd;
 
-	int channels;
+	u8 channels;
 	int max_current;
 	int brightness; /* current brightness */
 };
@@ -30,7 +38,7 @@ static inline int aat2870_brightness(struct aat2870_bl_driver_data *aat2870_bl,
 	struct backlight_device *bd = aat2870_bl->bd;
 	int val;
 
-	val = brightness * (aat2870_bl->max_current - 1);
+	val = brightness * aat2870_bl->max_current;
 	val /= bd->props.max_brightness;
 
 	return val;
@@ -42,7 +50,7 @@ static inline int aat2870_bl_enable(struct aat2870_bl_driver_data *aat2870_bl)
 			= dev_get_drvdata(aat2870_bl->pdev->dev.parent);
 
 	return aat2870->write(aat2870, AAT2870_BL_CH_EN,
-			      (u8)aat2870_bl->channels);
+			      aat2870_bl->channels);
 }
 
 static inline int aat2870_bl_disable(struct aat2870_bl_driver_data *aat2870_bl)
@@ -96,24 +104,11 @@ static const struct backlight_ops aat2870_bl_ops = {
 
 static int aat2870_bl_probe(struct platform_device *pdev)
 {
-	struct aat2870_bl_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct aat2870_bl_driver_data *aat2870_bl;
 	struct backlight_device *bd;
 	struct backlight_properties props;
 	int ret = 0;
 
-	if (!pdata) {
-		dev_err(&pdev->dev, "No platform data\n");
-		ret = -ENXIO;
-		goto out;
-	}
-
-	if (pdev->id != AAT2870_ID_BL) {
-		dev_err(&pdev->dev, "Invalid device ID, %d\n", pdev->id);
-		ret = -EINVAL;
-		goto out;
-	}
-
 	aat2870_bl = devm_kzalloc(&pdev->dev,
 				  sizeof(struct aat2870_bl_driver_data),
 				  GFP_KERNEL);
@@ -140,20 +135,16 @@ static int aat2870_bl_probe(struct platform_device *pdev)
 
 	aat2870_bl->bd = bd;
 
-	if (pdata->channels > 0)
-		aat2870_bl->channels = pdata->channels;
-	else
-		aat2870_bl->channels = AAT2870_BL_CH_ALL;
+	aat2870_bl->channels = AAT2870_BL_CH_ALL;
+	device_property_read_u8(&pdev->dev, "skyworks,channels", &aat2870_bl->channels);
 
-	if (pdata->max_current > 0)
-		aat2870_bl->max_current = pdata->max_current;
-	else
-		aat2870_bl->max_current = AAT2870_CURRENT_27_9;
+	device_property_read_u32(&pdev->dev, "led-max-microamp", &aat2870_bl->max_current);
+	aat2870_bl->max_current = clamp(aat2870_bl->max_current, AAT2870_CURRENT_MIN,
+					AAT2870_CURRENT_MAX);
+	aat2870_bl->max_current /= AAT2870_CURRENT_STEP;
 
-	if (pdata->max_brightness > 0)
-		bd->props.max_brightness = pdata->max_brightness;
-	else
-		bd->props.max_brightness = 255;
+	bd->props.max_brightness = 255;
+	device_property_read_u32(&pdev->dev, "max-brightness", &bd->props.max_brightness);
 
 	aat2870_bl->brightness = 0;
 	bd->props.power = BACKLIGHT_POWER_ON;
@@ -181,9 +172,16 @@ static void aat2870_bl_remove(struct platform_device *pdev)
 	backlight_update_status(bd);
 }
 
+static const struct of_device_id aat2870_bl_match_table[] = {
+	{ .compatible = "skyworks,aat2870-backlight" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, aat2870_bl_match_table);
+
 static struct platform_driver aat2870_bl_driver = {
 	.driver = {
 		.name	= "aat2870-backlight",
+		.of_match_table = aat2870_bl_match_table,
 	},
 	.probe		= aat2870_bl_probe,
 	.remove		= aat2870_bl_remove,
diff --git a/include/linux/mfd/aat2870.h b/include/linux/mfd/aat2870.h
index c7a3c53eba681..a7b482b790b4e 100644
--- a/include/linux/mfd/aat2870.h
+++ b/include/linux/mfd/aat2870.h
@@ -54,80 +54,13 @@
 #define AAT2870_LDO_EN		0x26
 #define AAT2870_REG_NUM		0x27
 
-/* Device IDs */
-enum aat2870_id {
-	AAT2870_ID_BL,
-	AAT2870_ID_LDOA,
-	AAT2870_ID_LDOB,
-	AAT2870_ID_LDOC,
-	AAT2870_ID_LDOD
-};
-
-/* Backlight channels */
-#define AAT2870_BL_CH1		0x01
-#define AAT2870_BL_CH2		0x02
-#define AAT2870_BL_CH3		0x04
-#define AAT2870_BL_CH4		0x08
-#define AAT2870_BL_CH5		0x10
-#define AAT2870_BL_CH6		0x20
-#define AAT2870_BL_CH7		0x40
-#define AAT2870_BL_CH8		0x80
-#define AAT2870_BL_CH_ALL	0xFF
-
-/* Backlight current magnitude (mA) */
-enum aat2870_current {
-	AAT2870_CURRENT_0_45 = 1,
-	AAT2870_CURRENT_0_90,
-	AAT2870_CURRENT_1_80,
-	AAT2870_CURRENT_2_70,
-	AAT2870_CURRENT_3_60,
-	AAT2870_CURRENT_4_50,
-	AAT2870_CURRENT_5_40,
-	AAT2870_CURRENT_6_30,
-	AAT2870_CURRENT_7_20,
-	AAT2870_CURRENT_8_10,
-	AAT2870_CURRENT_9_00,
-	AAT2870_CURRENT_9_90,
-	AAT2870_CURRENT_10_8,
-	AAT2870_CURRENT_11_7,
-	AAT2870_CURRENT_12_6,
-	AAT2870_CURRENT_13_5,
-	AAT2870_CURRENT_14_4,
-	AAT2870_CURRENT_15_3,
-	AAT2870_CURRENT_16_2,
-	AAT2870_CURRENT_17_1,
-	AAT2870_CURRENT_18_0,
-	AAT2870_CURRENT_18_9,
-	AAT2870_CURRENT_19_8,
-	AAT2870_CURRENT_20_7,
-	AAT2870_CURRENT_21_6,
-	AAT2870_CURRENT_22_5,
-	AAT2870_CURRENT_23_4,
-	AAT2870_CURRENT_24_3,
-	AAT2870_CURRENT_25_2,
-	AAT2870_CURRENT_26_1,
-	AAT2870_CURRENT_27_0,
-	AAT2870_CURRENT_27_9
-};
-
-struct aat2870_register {
-	bool readable;
-	bool writeable;
-	u8 value;
-};
-
 struct aat2870_data {
 	struct device *dev;
 	struct i2c_client *client;
 
 	struct mutex io_lock;
 	struct aat2870_register *reg_cache; /* register cache */
-	int en_pin; /* enable GPIO pin (if < 0, ignore this value) */
-	bool is_enable;
-
-	/* init and uninit for platform specified */
-	int (*init)(struct aat2870_data *aat2870);
-	void (*uninit)(struct aat2870_data *aat2870);
+	struct gpio_desc *en_pin;
 
 	/* i2c io funcntions */
 	int (*read)(struct aat2870_data *aat2870, u8 addr, u8 *val);
@@ -135,30 +68,4 @@ struct aat2870_data {
 	int (*update)(struct aat2870_data *aat2870, u8 addr, u8 mask, u8 val);
 };
 
-struct aat2870_subdev_info {
-	int id;
-	const char *name;
-	void *platform_data;
-};
-
-struct aat2870_platform_data {
-	int en_pin; /* enable GPIO pin (if < 0, ignore this value) */
-
-	struct aat2870_subdev_info *subdevs;
-	int num_subdevs;
-
-	/* init and uninit for platform specified */
-	int (*init)(struct aat2870_data *aat2870);
-	void (*uninit)(struct aat2870_data *aat2870);
-};
-
-struct aat2870_bl_platform_data {
-	/* backlight channels, default is AAT2870_BL_CH_ALL */
-	int channels;
-	/* backlight current magnitude, default is AAT2870_CURRENT_27_9 */
-	int max_current;
-	/* maximum brightness, default is 255 */
-	int max_brightness;
-};
-
 #endif /* __LINUX_MFD_AAT2870_H */
-- 
2.53.0

