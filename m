Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4F8606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 19:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cX4rhzTs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1175A10E366;
	Tue, 10 Nov 2026 19:39:15 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2944E10E334
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 19:39:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 10CE943963;
 Tue, 10 Nov 2026 19:39:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794339541;
 b=T9Dr6vNLpEg6NZ7vFPmJ+tEuNkiJYq3ABdt8qbm+KLPTX/c+8RCW2kUJBExbbw1bjJxQ
 4DB7pQmiVpL3ztgbMbydCgXwkwcwfopQyQaeF5Qz5cOOGO8oPY2AVnGMBmDTWoeHYDMTm
 +6d3+LwM4OESaTdlHT0V85QetKbqjEbWbcPB5BU7LHELaI/rVI+sAYlWzZXExP369JXER
 YfEWgTSKPBtRPZ+TuRrVaXSD2y0Iq6GdD2WoJQhrAZT3RiYfgnn0xt7t4wxp8Ed0lq9lX
 2IGLV4NjlgTR/JWmr6BdgmMfbyk8uifDlTPw1k3AV0rM+85MzNarX+VtbqeThBt4P5g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794339541;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=YJ260lSe/neQCxSi0JebgbI4CTavL15CM9mfgM7fevs=;
 b=TyaYwR5egdOIhwMQnxiwOaEM6DACSDQYm9JuGtX15jJ13w0EbUp+Cun2H+i/REWuHpbw
 r5y67s7nGOZKaPzwHbspUlt8tSSqYT+OblMi1tKb/+k05GR7Mf8kPDiJ8il7zXxoUl8xR
 Y37cDlAxiopaAo24jAQ4xjl4RljaxfPjFCIFjY3LFQXzhZ3+5792EyF1fOmq2FXLSRrXk
 5s33XIT9wuyQQGlw3HB+fpyU8EMmwh+2xSuAlqxtHNk3s0iud7G5GE1RusQJIMEe6ohwI
 ivd021hDH1tHP2YMtrIM6xlpTlBFnFrbgfG1MjQ5I5xIMuuU95YBgtWOsE1XqiUcJVg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 2CEED1F008A2;
 Tue, 10 Nov 2026 19:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794339541;
 bh=YJ260lSe/neQCxSi0JebgbI4CTavL15CM9mfgM7fevs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=cX4rhzTswuzgzoR94Q4+V5WZ8c2QgxfFbKPlMqpcktEL0CYbeyJzZdONU/8unwhgn
 Y6XAcRDk2V0KAS90ZLvuw1pOHbC5EvLcU7EsfXxD3UNuZ2gFE4i+h+DELxQW9C+Emc
 1WC+ER5//l3PIC9eItg3EwN/+o/ldRwQdCbY1qwO/oW/uurvYhye4ddid9XfnOBHsj
 /O/CVPvX2ZDIXUz6N66nutcLuIGUsFwns22h3OsNw2fFVad+SXbDAL5m4TWhnfBECn
 BGE6xBkOLbmXtORKkObIx5n9YMvoDyu6+dAmJDbHASo+0U6cLtWwKpI8XFbsZClXvN
 U8LPg6ncdhvlw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id A692748C72;
 Tue, 10 Nov 2026 19:38:59 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Tue, 10 Nov 2026 21:38:52 +0200
Subject: [PATCH v2 2/2] backlight: add ktd3137 support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-6768-ktd3137-v2-2-9496c51efea4@protonmail.com>
References: <20261110-6768-ktd3137-v2-0-9496c51efea4@protonmail.com>
In-Reply-To: <20261110-6768-ktd3137-v2-0-9496c51efea4@protonmail.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794339538; l=10109;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=kRX2DsfK/P16Pc7K10xoV7BnyUBL78NnDS9+cOkdHAY=;
 b=+U26cyiqgX+/1KRpU5+27JOcBm4PzBE2qGWn6+oX9T/Cw5XmSHQeVNnTN5weFTtsh921w+HKz
 daO5+CnGF6zDhlDYJrU0UpBYPg7VSIXlRQIyZOb0Bx7p+R7ARh300jF
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: rva333@protonmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Roman Vivchar <rva333@protonmail.com>

Add support for the KTD3137 display backlight IC. It's used in various
Xiaomi phones, such as Xiaomi Redmi Note 9.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 MAINTAINERS                       |   1 +
 drivers/video/backlight/Kconfig   |  11 ++
 drivers/video/backlight/Makefile  |   1 +
 drivers/video/backlight/ktd3137.c | 258 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 271 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 24dd5b43f167..23114fd09445 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14622,6 +14622,7 @@ KTD3137 BACKLIGHT DRIVER
 M:	Roman Vivchar <rva333@protonmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/leds/backlight/kinetic,ktd3137.yaml
+F:	drivers/video/backlight/ktd3137.c
 
 KTEST
 M:	Steven Rostedt <rostedt@goodmis.org>
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 7c66b8840d88..0196b8597367 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -199,6 +199,17 @@ config BACKLIGHT_KTD2801
 	  Say Y to enable the backlight driver for the Kinetic KTD2801 1-wire
 	  GPIO-controlled backlight found in Samsung Galaxy Core Prime VE LTE.
 
+config BACKLIGHT_KTD3137
+	tristate "Backlight Driver for Kinetic KTD3137"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say Y to enable the backlight driver for the Kinetic KTD3137
+	  found in various Xiaomi smartphones.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called ktd3137.
+
 config BACKLIGHT_KTZ8866
 	tristate "Backlight Driver for Kinetic KTZ8866"
 	depends on I2C
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index 34469711c6cd..b2d3b69e9e32 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_BACKLIGHT_HP700)		+= jornada720_bl.o
 obj-$(CONFIG_BACKLIGHT_IPAQ_MICRO)	+= ipaq_micro_bl.o
 obj-$(CONFIG_BACKLIGHT_KTD253)		+= ktd253-backlight.o
 obj-$(CONFIG_BACKLIGHT_KTD2801)		+= ktd2801-backlight.o
+obj-$(CONFIG_BACKLIGHT_KTD3137)		+= ktd3137.o
 obj-$(CONFIG_BACKLIGHT_KTZ8866)		+= ktz8866.o
 obj-$(CONFIG_BACKLIGHT_LM3509)		+= lm3509_bl.o
 obj-$(CONFIG_BACKLIGHT_LM3533)		+= lm3533_bl.o
diff --git a/drivers/video/backlight/ktd3137.c b/drivers/video/backlight/ktd3137.c
new file mode 100644
index 000000000000..1595aefd46e6
--- /dev/null
+++ b/drivers/video/backlight/ktd3137.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2025-2026 Roman Vivchar <rva333@protonmail.com>
+ *
+ * Backlight driver for the Kinetic KTD3137
+ */
+
+#include <linux/backlight.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+#define KTD3137_REG_DEV_ID		0x00
+#define KTD3137_REG_SW_RESET		0x01
+#define KTD3137_REG_MODE		0x02
+#define KTD3137_REG_CONTROL		0x03
+#define KTD3137_REG_RATIO_LSB		0x04
+#define KTD3137_REG_RATIO_MSB		0x05
+#define KTD3137_REG_PWM			0x06
+#define KTD3137_REG_RAMP_ON		0x07
+#define KTD3137_REG_TRANS_RAMP		0x08
+#define KTD3137_REG_FLASH_SETTING	0x09
+#define KTD3137_REG_STATUS		0x0a
+#define KTD3137_REG_MAX			0x0a
+
+/* KTD3137_REG_DEV_ID */
+#define KTD3137_DEV_ID_A		0x12
+#define KTD3137_DEV_ID_B		0x18
+
+/* KTD3137_REG_MODE */
+#define KTD3137_MODE_BL_EN		BIT(0)
+#define KTD3137_MODE_CURRENT_MASK	GENMASK(7, 3)
+
+/* KTD3137_REG_CONTROL */
+#define KTD3137_CONTROL_LINEAR		(BIT(1) | BIT(2))
+#define KTD3137_CONTROL_IND_2P6A	BIT(3)
+#define KTD3137_CONTROL_OVP_32V		BIT(5)
+#define KTD3137_CONTROL_FREQ_1000KHZ	BIT(6)
+#define KTD3137_CONTROL_DEFAULT		(KTD3137_CONTROL_IND_2P6A | \
+					 KTD3137_CONTROL_OVP_32V | \
+					 KTD3137_CONTROL_FREQ_1000KHZ)
+
+/* KTD3137_REG_RATIO_LSB */
+#define KTD3137_RATIO_LSB_MASK		GENMASK(2, 0)
+
+/* KTD3137_REG_PWM */
+#define KTD3137_PWM_CH1_EN		BIT(0)
+#define KTD3137_PWM_CH2_EN		BIT(1)
+#define KTD3137_PWM_FILTER_6LSB		(BIT(3) | BIT(4))
+#define KTD3137_PWM_DISABLE		BIT(7)
+#define KTD3137_PWM_DEFAULT		(KTD3137_PWM_CH1_EN | \
+					 KTD3137_PWM_CH2_EN | \
+					 KTD3137_PWM_FILTER_6LSB | \
+					 KTD3137_PWM_DISABLE)
+
+/* KTD3137_REG_RAMP_ON */
+#define KTD3137_RAMP_ON_MASK		GENMASK(7, 4)
+#define KTD3137_RAMP_OFF_MASK		GENMASK(3, 0)
+/* Ramp ON: 2ms, OFF: 8ms */
+#define KTD3137_RAMP_DEFAULT		(FIELD_PREP(KTD3137_RAMP_ON_MASK, 4) | \
+					 FIELD_PREP(KTD3137_RAMP_OFF_MASK, 4))
+
+#define KTD3137_MAX_BRIGHTNESS		2047
+
+#define KTD3137_I_MIN_UA		5000
+#define KTD3137_I_MAX_UA		29800
+#define KTD3137_I_STEP_UA		800
+#define KTD3137_I_DEFAULT_UA		20200
+
+struct ktd3137 {
+	struct device *dev;
+	struct regmap *regmap;
+	struct gpio_desc *enable_gpio;
+	u32 led_current;
+};
+
+static const struct regmap_config ktd3137_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = KTD3137_REG_MAX,
+};
+
+static int ktd3137_init(struct ktd3137 *ktd)
+{
+	int ret;
+
+	ret = regmap_write(ktd->regmap, KTD3137_REG_CONTROL,
+			   KTD3137_CONTROL_DEFAULT | KTD3137_CONTROL_LINEAR);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(ktd->regmap, KTD3137_REG_PWM, KTD3137_PWM_DEFAULT);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(ktd->regmap, KTD3137_REG_RAMP_ON, KTD3137_RAMP_DEFAULT);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(ktd->regmap, KTD3137_REG_TRANS_RAMP, 0x00);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(ktd->regmap, KTD3137_REG_MODE,
+				  KTD3137_MODE_CURRENT_MASK, ktd->led_current);
+}
+
+static int ktd3137_backlight_update_status(struct backlight_device *backlight_dev)
+{
+	struct ktd3137 *ktd = bl_get_data(backlight_dev);
+	unsigned int brightness = backlight_get_brightness(backlight_dev);
+	int ret;
+
+	if (brightness > 0) {
+		ret = regmap_write(ktd->regmap, KTD3137_REG_RATIO_LSB,
+				   brightness & KTD3137_RATIO_LSB_MASK);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(ktd->regmap, KTD3137_REG_RATIO_MSB,
+				   brightness >> 3);
+		if (ret)
+			return ret;
+	}
+
+	return regmap_update_bits(ktd->regmap, KTD3137_REG_MODE,
+				  KTD3137_MODE_BL_EN,
+				  brightness ? KTD3137_MODE_BL_EN : 0);
+}
+
+static const struct backlight_ops ktd3137_backlight_ops = {
+	.options = BL_CORE_SUSPENDRESUME,
+	.update_status = ktd3137_backlight_update_status,
+};
+
+static int ktd3137_parse_dt(struct ktd3137 *ktd)
+{
+	u32 max_ua = KTD3137_I_DEFAULT_UA;
+	u32 val;
+
+	device_property_read_u32(ktd->dev, "led-max-microamp", &max_ua);
+
+	if (max_ua < KTD3137_I_MIN_UA || max_ua > KTD3137_I_MAX_UA)
+		return dev_err_probe(ktd->dev, -EINVAL,
+				     "led-max-microamp (%u) out of range\n", max_ua);
+
+	val = (max_ua - KTD3137_I_MIN_UA) / KTD3137_I_STEP_UA;
+	ktd->led_current = FIELD_PREP(KTD3137_MODE_CURRENT_MASK, val);
+
+	return 0;
+}
+
+static int ktd3137_probe(struct i2c_client *client)
+{
+	struct backlight_device *backlight_dev;
+	struct backlight_properties props = { };
+	struct ktd3137 *ktd;
+	u32 val;
+	int ret;
+
+	ktd = devm_kzalloc(&client->dev, sizeof(*ktd), GFP_KERNEL);
+	if (!ktd)
+		return -ENOMEM;
+
+	ktd->dev = &client->dev;
+
+	ret = devm_regulator_get_enable(ktd->dev, "vin");
+	if (ret)
+		return dev_err_probe(ktd->dev, ret, "failed to power up\n");
+
+	ktd->enable_gpio = devm_gpiod_get_optional(ktd->dev, "enable",
+						   GPIOD_OUT_HIGH);
+	if (IS_ERR(ktd->enable_gpio))
+		return dev_err_probe(ktd->dev, PTR_ERR(ktd->enable_gpio),
+				     "failed to get enable gpio\n");
+
+	/* HWEN should stay HIGH for at least 150us before I2C can be used */
+	fsleep(150);
+
+	ktd->regmap = devm_regmap_init_i2c(client, &ktd3137_regmap_config);
+	if (IS_ERR(ktd->regmap))
+		return dev_err_probe(ktd->dev, PTR_ERR(ktd->regmap),
+				     "failed to init regmap\n");
+
+	ret = regmap_read(ktd->regmap, KTD3137_REG_DEV_ID, &val);
+	if (ret)
+		return dev_err_probe(ktd->dev, ret, "failed to read chip id\n");
+
+	if (val != KTD3137_DEV_ID_A && val != KTD3137_DEV_ID_B)
+		return dev_err_probe(ktd->dev, -ENODEV,
+				     "unsupported chip id: 0x%02x\n", val);
+
+	ret = ktd3137_parse_dt(ktd);
+	if (ret)
+		return ret;
+
+	ret = ktd3137_init(ktd);
+	if (ret)
+		return dev_err_probe(ktd->dev, ret, "failed to init chip\n");
+
+	props.type = BACKLIGHT_RAW;
+	props.max_brightness = KTD3137_MAX_BRIGHTNESS;
+	props.brightness = KTD3137_MAX_BRIGHTNESS;
+	props.scale = BACKLIGHT_SCALE_LINEAR;
+	device_property_read_u32(ktd->dev, "default-brightness", &props.brightness);
+
+	backlight_dev = devm_backlight_device_register(ktd->dev,
+						       "ktd3137-backlight",
+						       ktd->dev, ktd,
+						       &ktd3137_backlight_ops,
+						       &props);
+	if (IS_ERR(backlight_dev))
+		return dev_err_probe(ktd->dev, PTR_ERR(backlight_dev),
+				     "failed to register backlight device\n");
+
+	i2c_set_clientdata(client, backlight_dev);
+	return backlight_update_status(backlight_dev);
+}
+
+static void ktd3137_remove(struct i2c_client *client)
+{
+	struct backlight_device *backlight_dev = i2c_get_clientdata(client);
+
+	backlight_dev->props.brightness = 0;
+	backlight_update_status(backlight_dev);
+}
+
+static const struct i2c_device_id ktd3137_ids[] = {
+	{ "ktd3137" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ktd3137_ids);
+
+static const struct of_device_id ktd3137_match_table[] = {
+	{ .compatible = "kinetic,ktd3137" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ktd3137_match_table);
+
+static struct i2c_driver ktd3137_driver = {
+	.driver = {
+		.name = "ktd3137",
+		.of_match_table = ktd3137_match_table,
+	},
+	.probe = ktd3137_probe,
+	.remove = ktd3137_remove,
+	.id_table = ktd3137_ids,
+};
+module_i2c_driver(ktd3137_driver);
+
+MODULE_DESCRIPTION("Kinetic KTD3137 Backlight Driver");
+MODULE_LICENSE("GPL");

-- 
2.56.0


