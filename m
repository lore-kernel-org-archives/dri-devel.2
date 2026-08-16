Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE9AC5DF76
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:05:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 634B610E2FC;
	Sun, 16 Aug 2026 14:05:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=dewith.io header.i=@dewith.io header.b="apIwzkcI";
	dkim-atps=neutral
Received: from meve.dewith.io (meve.dewith.io [157.90.20.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B54D10E1D3
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 10:57:12 +0000 (UTC)
Received: from localhost (70-26-208-87.ftth.glasoperator.nl [87.208.26.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1)
 server-digest SHA256) (No client certificate requested)
 by meve.dewith.io (Postfix) with ESMTPSA id 424DA24E97;
 Sun, 16 Aug 2026 10:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dewith.io; s=default; 
 t=1786877830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uXApw21u7kFbyUeBtXMbtGKYUhRfHXU4v8DzWnU9RlU=;
 b=apIwzkcItKrxUCYq30CHuOQvNhXiok5dEpgh+/6PtOLBcKlc5bLaAJrVCoU2NdrAdblEPK
 fjvFL15iD9yFvodRNcbXHvIUyt9rCfI/5KBQjn2dued+WPxf/cmBF6DrLM+sLZU8Io6JTv
 MjOiuzajs/8BbDck0+/n3gPegKPJYas=
From: Wim de With <wf@dewith.io>
Date: Sun, 16 Aug 2026 12:57:04 +0200
Subject: [PATCH v3 2/2] backlight: Add support for Orient Chip OCP8178
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260816-ocp8178-backlight-v3-2-caf95c453c50@dewith.io>
References: <20260816-ocp8178-backlight-v3-0-caf95c453c50@dewith.io>
In-Reply-To: <20260816-ocp8178-backlight-v3-0-caf95c453c50@dewith.io>
To: Wim de With <wf@dewith.io>, Lee Jones <lee@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Sun, 16 Aug 2026 14:05:11 +0000
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

Add a driver for the Orient Chip OCP8178 backlight controller.

The OCP8178 supports either PWM or a vendor-specific onewire protocol
over GPIO. This driver implements the onewire protocol, which enables
setting static brightness levels without requiring a continuous PWM
signal from the host CPU. Note that while the vendor calls the protocol
1-Wire, it is not the 1-Wire protocol from Dallas Semiconductor as
implemented in drivers/w1.

Signed-off-by: Wim de With <wf@dewith.io>
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
---
 MAINTAINERS                          |   1 +
 drivers/video/backlight/Kconfig      |  10 ++
 drivers/video/backlight/Makefile     |   1 +
 drivers/video/backlight/ocp8178_bl.c | 231 +++++++++++++++++++++++++++++++++++
 4 files changed, 243 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3ca99d9c32ef1..7146e4dea8d78 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19682,6 +19682,7 @@ OCP8178 BACKLIGHT DRIVER
 M:	Wim de With <wf@dewith.io>
 S:	Maintained
 F:	Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml
+F:	drivers/video/backlight/ocp8178_bl.c
 
 OCXL (Open Coherent Accelerator Processor Interface OpenCAPI) DRIVER
 M:	Mahesh J Salgaonkar <mahesh@linux.ibm.com>
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 7aa1c4b21111f..aa845230c5f58 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -226,6 +226,16 @@ config BACKLIGHT_LOCOMO
 	  If you have a Sharp Zaurus SL-5500 (Collie) or SL-5600 (Poodle) say y to
 	  enable the LCD/backlight driver.
 
+config BACKLIGHT_OCP8178
+	tristate "OCP8178 Backlight Driver"
+	depends on GPIOLIB
+	help
+	  If you have an Orient Chip OCP8178, say Y to enable the backlight
+	  driver.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called ocp8178_bl.
+
 config BACKLIGHT_OMAP1
 	tristate "OMAP1 PWL-based LCD Backlight"
 	depends on ARCH_OMAP1 || COMPILE_TEST
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index 21c8313cfb121..c4e87b708ae21 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_BACKLIGHT_MAX25014)	+= max25014.o
 obj-$(CONFIG_BACKLIGHT_MAX8925)		+= max8925_bl.o
 obj-$(CONFIG_BACKLIGHT_MP3309C)		+= mp3309c.o
 obj-$(CONFIG_BACKLIGHT_MT6370)		+= mt6370-backlight.o
+obj-$(CONFIG_BACKLIGHT_OCP8178)		+= ocp8178_bl.o
 obj-$(CONFIG_BACKLIGHT_OMAP1)		+= omap1_bl.o
 obj-$(CONFIG_BACKLIGHT_PANDORA)		+= pandora_bl.o
 obj-$(CONFIG_BACKLIGHT_PWM)		+= pwm_bl.o
diff --git a/drivers/video/backlight/ocp8178_bl.c b/drivers/video/backlight/ocp8178_bl.c
new file mode 100644
index 0000000000000..6c1e8c9451f12
--- /dev/null
+++ b/drivers/video/backlight/ocp8178_bl.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Orient Chip OCP8178 Backlight Driver
+ *
+ * Copyright (C) 2026 Wim de With
+ *
+ * Author: Wim de With <wf@dewith.io>
+ */
+
+#include <linux/backlight.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/irqflags.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+
+#define OCP8178_MAX_BRIGHTNESS 0x1F /* 5 bits */
+
+#define OCP8178_DEVICE_ADDRESS 0x72
+
+#define OCP8178_DATA_RFA BIT(7)
+#define OCP8178_DATA_ADDR GENMASK(6, 5)
+#define OCP8178_DATA_VALUE GENMASK(4, 0)
+
+#define OCP8178_1W_INIT_MAX_RETRIES 5
+#define OCP8178_1W_INIT_SLEEP_US (50 * 1000)
+
+#define OCP8178_T_OFF_US (3 * 1000) /* datasheet specifies at least 2.5 ms */
+#define OCP8178_1W_T_DELAY_US (100 + 10) /* 10 us as safety factor */
+#define OCP8178_1W_T_DETECT_US (260 + 10) /* 10 us as safety factor */
+#define OCP8178_1W_T_START_US 2
+#define OCP8178_1W_T_EOS_US 2
+#define OCP8178_1W_T_WIN_NS (1000 * 1000)
+
+/*
+ * The datasheet specifies 1.7 Kbps to 160 Kbps.
+ * 1 / (160 Kbps) is about 6.67 us, so using 7 us per bit should be fine.
+ * T_HIGH + T_LOW = 7 us
+ * T_HIGH > 2 * T_LOW for high bits
+ * T_LOW > 2 * T_HIGH for low bits
+ */
+#define OCP8178_1W_HIGH_BIT_T_LOW_US 2
+#define OCP8178_1W_HIGH_BIT_T_HIGH_US 5
+#define OCP8178_1W_LOW_BIT_T_LOW_US 5
+#define OCP8178_1W_LOW_BIT_T_HIGH_US 2
+
+struct ocp8178_bl {
+	struct device *dev;
+	struct gpio_desc *gpiod;
+};
+
+static int ocp8178_bl_enable_onewire(struct ocp8178_bl *ocp8178)
+{
+	u64 start, duration;
+
+	gpiod_set_value(ocp8178->gpiod, 0);
+	fsleep(OCP8178_T_OFF_US);
+
+	start = ktime_get_ns();
+
+	gpiod_set_value(ocp8178->gpiod, 1);
+	udelay(OCP8178_1W_T_DELAY_US);
+	gpiod_set_value(ocp8178->gpiod, 0);
+	udelay(OCP8178_1W_T_DETECT_US);
+	gpiod_set_value(ocp8178->gpiod, 1);
+
+	duration = ktime_get_ns() - start;
+
+	if (duration >= OCP8178_1W_T_WIN_NS) {
+		dev_err(ocp8178->dev,
+			"onewire detection window exceeded (%llu ns)\n",
+			duration);
+		return -EAGAIN;
+	}
+
+	return 0;
+}
+
+static void ocp8178_bl_write_u8(struct ocp8178_bl *ocp8178, u8 value)
+{
+	unsigned long flags;
+
+	gpiod_set_value(ocp8178->gpiod, 1);
+	udelay(OCP8178_1W_T_START_US);
+
+	local_irq_save(flags);
+
+	for (int i = 7; i >= 0; i--) {
+		if ((value >> i) & 1) {
+			gpiod_set_value(ocp8178->gpiod, 0);
+			udelay(OCP8178_1W_HIGH_BIT_T_LOW_US);
+			gpiod_set_value(ocp8178->gpiod, 1);
+			udelay(OCP8178_1W_HIGH_BIT_T_HIGH_US);
+		} else {
+			gpiod_set_value(ocp8178->gpiod, 0);
+			udelay(OCP8178_1W_LOW_BIT_T_LOW_US);
+			gpiod_set_value(ocp8178->gpiod, 1);
+			udelay(OCP8178_1W_LOW_BIT_T_HIGH_US);
+		}
+	}
+
+	gpiod_set_value(ocp8178->gpiod, 0);
+	udelay(OCP8178_1W_T_EOS_US);
+	gpiod_set_value(ocp8178->gpiod, 1);
+
+	local_irq_restore(flags);
+}
+
+static void ocp8178_bl_set_brightness(struct ocp8178_bl *ocp8178, u8 brightness)
+{
+	u8 data = 0;
+
+	/*
+	 * We cannot set RFA (request for acknowledge) unless the GPIO pin is
+	 * configured as open drain.
+	 */
+	data |= FIELD_PREP(OCP8178_DATA_RFA, 0);
+	data |= FIELD_PREP(OCP8178_DATA_ADDR, 0);
+	data |= FIELD_PREP(OCP8178_DATA_VALUE, brightness);
+
+	ocp8178_bl_write_u8(ocp8178, OCP8178_DEVICE_ADDRESS);
+	ocp8178_bl_write_u8(ocp8178, data);
+}
+
+static int ocp8178_bl_update_status(struct backlight_device *bl)
+{
+	struct ocp8178_bl *ocp8178 = bl_get_data(bl);
+	u8 brightness = backlight_get_brightness(bl);
+
+	ocp8178_bl_set_brightness(ocp8178, brightness);
+	return 0;
+}
+
+static const struct backlight_ops ocp8178_bl_ops = {
+	.options = BL_CORE_SUSPENDRESUME,
+	.update_status = ocp8178_bl_update_status,
+};
+
+static int ocp8178_bl_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct backlight_device *bl;
+	struct backlight_properties props;
+	struct ocp8178_bl *ocp8178;
+	u32 max_brightness, brightness;
+	int ret, retries;
+
+	ocp8178 = devm_kzalloc(dev, sizeof(*ocp8178), GFP_KERNEL);
+	if (!ocp8178)
+		return -ENOMEM;
+
+	ocp8178->dev = dev;
+
+	ret = device_property_read_u32(dev, "max-brightness", &max_brightness);
+	if (ret)
+		max_brightness = OCP8178_MAX_BRIGHTNESS;
+	if (max_brightness > OCP8178_MAX_BRIGHTNESS) {
+		dev_warn(dev, "max brightness exceeds hardware limit\n");
+		max_brightness = OCP8178_MAX_BRIGHTNESS;
+	}
+
+	ret = device_property_read_u32(dev, "default-brightness", &brightness);
+	if (ret)
+		brightness = max_brightness;
+	if (brightness > max_brightness) {
+		dev_warn(dev, "default brightness exceeds max brightness\n");
+		brightness = max_brightness;
+	}
+
+	ocp8178->gpiod = devm_gpiod_get(dev, "ctrl", GPIOD_OUT_LOW);
+	if (IS_ERR(ocp8178->gpiod))
+		return dev_err_probe(dev, PTR_ERR(ocp8178->gpiod),
+				     "GPIO missing or invalid\n");
+	if (gpiod_cansleep(ocp8178->gpiod))
+		return dev_err_probe(dev, -EINVAL,
+				     "sleeping GPIO not supported\n");
+	gpiod_set_consumer_name(ocp8178->gpiod, dev_name(dev));
+
+	for (retries = 0; retries < OCP8178_1W_INIT_MAX_RETRIES; retries++) {
+		ret = ocp8178_bl_enable_onewire(ocp8178);
+		if (!ret)
+			break;
+		if (ret != -EAGAIN)
+			return ret;
+		fsleep(OCP8178_1W_INIT_SLEEP_US);
+	}
+	if (retries >= OCP8178_1W_INIT_MAX_RETRIES)
+		return dev_err_probe(dev, -ETIMEDOUT,
+				     "failed to initialize onewire protocol\n");
+
+	props = (typeof(props)){
+		.type = BACKLIGHT_RAW,
+		.brightness = brightness,
+		.max_brightness = max_brightness,
+		.power = BACKLIGHT_POWER_ON,
+		.scale = BACKLIGHT_SCALE_NON_LINEAR,
+	};
+
+	bl = devm_backlight_device_register(dev, dev_name(dev), dev, ocp8178,
+					    &ocp8178_bl_ops, &props);
+	if (IS_ERR(bl))
+		return dev_err_probe(dev, PTR_ERR(bl),
+				     "failed to register backlight\n");
+
+	platform_set_drvdata(pdev, bl);
+	backlight_update_status(bl);
+
+	return 0;
+}
+
+static const struct of_device_id ocp8178_bl_of_match[] = {
+	{ .compatible = "ocs,ocp8178" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ocp8178_bl_of_match);
+
+static struct platform_driver ocp8178_bl_driver = {
+	.driver = {
+		.name = "ocp8178-bl",
+		.of_match_table = ocp8178_bl_of_match,
+	},
+	.probe = ocp8178_bl_probe,
+};
+module_platform_driver(ocp8178_bl_driver);
+
+MODULE_AUTHOR("Wim de With <wf@dewith.io>");
+MODULE_DESCRIPTION("Orient Chip OCP8178 Backlight Driver");
+MODULE_LICENSE("GPL");

-- 
2.55.0

