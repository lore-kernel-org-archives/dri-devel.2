Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7224EFF886F
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:47:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C50C410F2D5;
	Thu, 30 Apr 2026 09:47:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HANPBMjA";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72A6510F2DA
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 09:47:25 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so9542855e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 02:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777542444; x=1778147244; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OVGWuVeYZSrHV7cWGaHlLzujxCFV0Ak9I1vcraKctWc=;
 b=HANPBMjApmmq3NnO/nYTNvkTqF4CR910eUiUjVYxbD/nH0SYuoK8B39FQ7acneuepB
 FEnGOcChYJrKuTjLvq8wkAT2btWzWdamxg/khu8bRedfLUhxyM6xHl3rVYSaltPN/Rgm
 skXpO4vfvX1vIxMhzNScsgrctA6UDsxOPOZ762MIb6xPGHqOyxbLSIHjP5XlVuBzmHKH
 kfEOAwzBcFZ5B/FoCg8xBJpVO4xM4Svv5iY5xoJ8GeUJ+wDkhsIAtPKTa8OVIZgrI8W1
 ZjJ/ZjM6l+9dgHHfvqGdPEtYVtq5J4YILXqmNJN6tCmPkBkO8w5GmoRRCjmrMX16pTQK
 U4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777542444; x=1778147244;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OVGWuVeYZSrHV7cWGaHlLzujxCFV0Ak9I1vcraKctWc=;
 b=HoFrOLeN51Sbw/HFYBwtOVJFpQ7Hp3x8I6s0IkgcLbYmv+b9enHNwh+hUZx27oOaWO
 G+THft3oZawM/XYte6HFrYqt84c400CbkikLRWcYE51uoU9O+bru5VSm7bl0mCP0Wqwm
 vqO+42ueHnBaDbD6BM3749STHdolOFgeEArPkmnHOUTqXCrFe+2+bRvBRnDUe/EEJIX7
 m68VjZEDdslOBeKy/QSzJAtnCu16a2vQ+lMDMd9qSJMhENJy3+HkwHhOj8NYO11x20Tn
 0iUsmlhZQQZpzhADPlFO8qmxBRsVKNq71FoxZnC/ffAmd6KcYMChZ/e34IZlsvMAFssx
 RTEQ==
X-Gm-Message-State: AOJu0Yx2RLwtKQGs0N06eA8vrgUrpTMFfLw5e0CwTXfEMrDVzkbsxI+T
 Csvo3Lh62f+oyzlnoUqH/yJCKFxlhofFYsPKGjMT7qTtcg0uWGcWoMuuMjD9GNyBiBsX38zdxwd
 NzPwqGy0=
X-Gm-Gg: AeBDieuhxtTl0VbHXaKRN+tBhndJnc9PvZIx98vMKacXCPogKKFzPUi/0wP+pzzugXu
 r9ri4/82JEc5Ikmk4RulWclIuFHgxh0nbZgr39gXHwRkSJj2Av3Wm/s/6TER8auHKy8O7oDAV0K
 oWZVHsrFSf90y07j+hV3mBpsyVhYQqzxi2fssLf5C/LmJfb/WKQuCRaR5o1Ibp5NqEVR1SyYNkn
 gdoiQ6ceD3oFnhyfFThXGqEXQkuN7LsW/1LzsnIDN34JBMmpbYnglDtb39xgPT6cxwW3zrTXsDm
 +ICos/RmIuzvDyHlerhpVCYVNPrr6UXme8Y7Uc5v9yTx8kV++B2ANC0DqN9qzd6Rr8ekmWz8BBl
 tbA0FcNqoz7N+3zPo1N7hFThfEUne+nQtLnyeF3huBot8jleYYw7kguOJtkgaxEP3Ky57bgZDUx
 5OJkyDi6noEP4XOcY2QZvROiiHUKi4JEtgAK7uPDh1F6f8BW20FhZ3MkM=
X-Received: by 2002:a05:600c:1f87:b0:48a:53ea:13df with SMTP id
 5b1f17b1804b1-48a83d66cfdmr33734885e9.2.1777542443755; 
 Thu, 30 Apr 2026 02:47:23 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a81b9493bsm48984745e9.0.2026.04.30.02.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:47:23 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 30 Apr 2026 11:47:16 +0200
Subject: [PATCH v2 2/2] backlight: Add SY7758 6-channel High Efficiency LED
 Driver support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-topic-sm8650-ayaneo-pocket-s2-sy7758-v2-2-308140640de9@linaro.org>
References: <20260430-topic-sm8650-ayaneo-pocket-s2-sy7758-v2-0-308140640de9@linaro.org>
In-Reply-To: <20260430-topic-sm8650-ayaneo-pocket-s2-sy7758-v2-0-308140640de9@linaro.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=10623;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=oLphRrYMc/i7SfmwTz1M2EuUqdpJ7AM0v6IBJaIdGes=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBp8yUoIF1IVAD+WKCk1PLMHraR26aN3AB9AE67gr2L
 BONsRneJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCafMlKAAKCRB33NvayMhJ0Y77D/
 0ZSC96M1+wBb9Ix/L3K2H8VP1HmuMmIDGWIM+/vXOjOp/PMh/EjPC+uH+MQKPJN6jDaYYLqSEDlSKD
 gmSERMhi6N0AGv0NvmiAASXBJ2fjSKT9cCRKJmWSLytK9o9rXreSHYpqUx9ZdGH6+WviehfRUwcNAg
 ITGJBs+AugRBEmfkD+uQnehRzep2mQtbw/E6dpNpxPxJbkVEc9w/YhUZI3AocTiUBsFsG96LjKLMwW
 OD0iXQK9A1tb8zoFq3BOAT7nA1TQxSDhzla2TiMHiMq+xJFALLfYV3b1lfglkBEE+0HjQ85VtOu7zO
 YijnUCkoacdB5kcamrEjjiO9HnB9qo2/Mtxl9zQUUW9oLXz3KlIELy2gHftv+x6F8TjHEy2kyeBPNr
 U+mqOAA4gfLlFAazELGrjUOxvxOKz/cV8PW0aXA+Y18P4FE8bnicT2+JMst5MhbFOxchi85BoyNFl+
 v48sCBVlBDMgfOtjTTkWj55sETlJ6O3irA+fEgMNz8ZcCjkuVsGY7AkCtBR+RXRuHnbMSv/23my9wg
 ntx8TVw3rj9/M6FGnMS3hiY+2iS+rjDTkgoCQCyMpRX7AzlhnJ6Wx6ANVsyTTHxklT7a7cCWP+8l4b
 kYCyhk/fsgJRqti0HRObx9TijfcpaPhHCjLcssxyXmOkLL9r8sqFD60kx+zA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

From: KancyJoe <kancy2333@outlook.com>

Implement support for the Silergy SY7758 6-channel High Efficiency LED
Driver used for backlight brightness control in the Ayaneo Pocket S2
dual-DSI panel.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: KancyJoe <kancy2333@outlook.com>
---
 drivers/video/backlight/Kconfig  |   8 +
 drivers/video/backlight/Makefile |   1 +
 drivers/video/backlight/sy7758.c | 311 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 320 insertions(+)

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index a7a3fbaf7c29..052ac80c8213 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -207,6 +207,14 @@ config BACKLIGHT_KTZ8866
 		Say Y to enable the backlight driver for the Kinetic KTZ8866
 		found in Xiaomi Mi Pad 5 series.
 
+config BACKLIGHT_SY7758
+	tristate "Backlight Driver for Silergy SY7758"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say Y to enable the backlight driver for the Silergy SY7758
+	  backlight controller found in Ayaneo Socket S2.
+
 config BACKLIGHT_LM3533
 	tristate "Backlight Driver for LM3533"
 	depends on MFD_LM3533
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index 794820a98ed4..39ef588b1cf2 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_BACKLIGHT_PWM)		+= pwm_bl.o
 obj-$(CONFIG_BACKLIGHT_QCOM_WLED)	+= qcom-wled.o
 obj-$(CONFIG_BACKLIGHT_RT4831)		+= rt4831-backlight.o
 obj-$(CONFIG_BACKLIGHT_SAHARA)		+= kb3886_bl.o
+obj-$(CONFIG_BACKLIGHT_SY7758)		+= sy7758.o
 obj-$(CONFIG_BACKLIGHT_SKY81452)	+= sky81452-backlight.o
 obj-$(CONFIG_BACKLIGHT_TPS65217)	+= tps65217_bl.o
 obj-$(CONFIG_BACKLIGHT_WM831X)		+= wm831x_bl.o
diff --git a/drivers/video/backlight/sy7758.c b/drivers/video/backlight/sy7758.c
new file mode 100644
index 000000000000..9b2d3bbb4ded
--- /dev/null
+++ b/drivers/video/backlight/sy7758.c
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Silergy SY7758 6-channel High Efficiency LED Driver
+ *
+ * Copyright (C) 2025 Kancy Joe <kancy2333@outlook.com>
+ * Copyright (C) 2026 Linaro Limited
+ * Author: Neil Armstrong <neil.armstrong@linaro.org>
+ */
+#include <linux/backlight.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/of.h>
+#include <linux/err.h>
+#include <linux/bits.h>
+#include <linux/regmap.h>
+#include <linux/bitfield.h>
+#include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
+
+#define DEFAULT_BRIGHTNESS 1024
+#define MAX_BRIGHTNESS 4080
+#define REG_MAX 0xAE
+
+/* Registers */
+#define REG_BRT_8BIT 0x00
+#define REG_DEV_CTL 0x01
+#define REG_STATUS 0x02
+#define REG_DEV_ID 0x03
+#define REG_DIRECT_CTL 0x04
+#define REG_STATUS2 0x05
+#define REG_BRT_12BIT_L 0x10
+#define REG_BRT_12BIT_H 0x11
+#define REG_LED_ENABLE 0x16
+
+/* OTP memory */
+#define REG_OTP_CFG98 0x98
+#define REG_OTP_CFG9E 0x9E
+#define REG_OTP_CFG0 0xA0
+#define REG_OTP_CFG1 0xA1
+#define REG_OTP_CFG2 0xA2
+#define REG_OTP_CFG3 0xA3
+#define REG_OTP_CFG4 0xA4
+#define REG_OTP_CFG5 0xA5
+#define REG_OTP_CFG6 0xA6
+#define REG_OTP_CFG7 0xA7
+#define REG_OTP_CFG9 0xA9
+#define REG_OTP_CFGA 0xAA
+#define REG_OTP_CFGE 0xAE
+
+/* Fields */
+#define BIT_DEV_CTL_FAST BIT(7)
+#define MSK_DEV_CTL_BRT_MODE GENMASK(2, 1)
+#define BIT_DEV_CTL_BL_CTLB BIT(0)
+
+#define BIT_STATUS_OPEN BIT(7)
+#define BIT_STATUS_SHORT BIT(6)
+#define BIT_STATUS_VREF_OK BIT(5)
+#define BIT_STATUS_VBST_OK BIT(4)
+#define BIT_STATUS_OVP BIT(3)
+#define BIT_STATUS_OCP BIT(2)
+#define BIT_STATUS_TSD BIT(1)
+#define BIT_STATUS_UVLO BIT(0)
+
+#define MSK_DIRECT_CTL_OUT GENMASK(5, 0)
+
+#define BIT_STATUS2_OCP50MS_LATCH BIT(0)
+#define BIT_STATUS2_OCP2 BIT(0)
+
+#define MSK_BRT_12BIT_L GENMASK(7, 0)
+#define MSK_BRT_12BIT_H GENMASK(3, 0)
+#define MSK_LED_ENABLE GENMASK(5, 0)
+
+#define BIT_CFG98_IBST_LIM_2X BIT(7)
+#define BIT_CFG98_A0_FSETB BIT(0)
+
+#define BIT_CFG9E_VBST_RANGE BIT(5)
+#define MSK_CFG9E_HEADROOM_OFFSET GENMASK(3, 0)
+
+#define MSK_CFG0_CURRENT_LOW GENMASK(7, 0)
+
+#define BIT_CFG1_PDET_STDBY BIT(7)
+#define MSK_CFG1_CURRENT_MAX GENMASK(6, 4)
+#define MSK_CFG1_CURRENT_HIGH GENMASK(3, 0)
+
+#define BIT_CFG2_UVLO_EN BIT(5)
+#define BIT_CFG2_UVLO_TH BIT(4)
+#define BIT_CFG2_BL_ON BIT(3)
+#define BIT_CFG2_ISET_EN BIT(2)
+#define BIT_CFG2_BST_ESET_EN BIT(1)
+
+#define MSK_CFG3_SLOPE GENMASK(6, 4)
+#define MSK_CFG3_FILTER GENMASK(3, 2)
+#define MSK_CFG3_PWM_INPUT_HYSTERESIS GENMASK(1, 0)
+#define MSK_CFG4_PWM_TO_I_TH GENMASK(7, 4)
+
+#define BIT_CFG5_PWM_DIRECT BIT(7)
+#define MSK_CFG5_PS_MODE GENMASK(6, 4)
+#define MSK_CFG5_PWM_FREQ GENMASK(3, 0)
+
+#define MSK_CFG6_BST_FREQ GENMASK(7, 6)
+#define MSK_CFG6_VBST GENMASK(5, 0)
+
+#define BIT_CFG7_EN_DRV3 BIT(5)
+#define BIT_CFG7_EN_DRV2 BIT(4)
+#define MSK_CFG7_IBST_LIM GENMASK(1, 0)
+
+#define MSK_CFG9_VBST_MAX GENMASK(7, 5)
+#define BIT_CFG9_JUMP_EN BIT(4)
+#define MSK_CFG9_JUMP_TH GENMASK(3, 2)
+#define MSK_CFG9_JUMP_VOLTAGE GENMASK(1, 0)
+
+#define BIT_CFGA_SSCLK_EN BIT(7)
+#define BIT_CFGA_ADAPTIVE BIT(3)
+#define MSK_CFGA_DRIVER_HEADROOM GENMASK(2, 0)
+#define MSK_CFGE_STEP_UP GENMASK(7, 6)
+#define MSK_CFGE_STEP_DN GENMASK(5, 4)
+#define MSK_CFGE_LED_FAULT_TH GENMASK(3, 2)
+#define MSK_CFGE_LED_COMP_HYST GENMASK(1, 0)
+
+struct sy7758 {
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct gpio_desc *gpio;
+	struct backlight_device *bl;
+};
+
+static const struct regmap_config sy7758_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = REG_MAX,
+};
+
+static int sy7758_backlight_update_status(struct backlight_device *backlight_dev)
+{
+	struct sy7758 *sydev = bl_get_data(backlight_dev);
+	unsigned int brightness = backlight_get_brightness(backlight_dev);
+	int ret;
+
+	ret = regmap_write(sydev->regmap, REG_BRT_12BIT_L,
+			   FIELD_PREP(MSK_BRT_12BIT_L,
+				      brightness & 0xff));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(sydev->regmap, REG_BRT_12BIT_H,
+			   FIELD_PREP(MSK_BRT_12BIT_H,
+				      (brightness >> 8) & 0xf));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct backlight_ops sy7758_backlight_ops = {
+	.options = BL_CORE_SUSPENDRESUME,
+	.update_status = sy7758_backlight_update_status,
+};
+
+static int sy7758_init(struct sy7758 *sydev)
+{
+	int ret = 0;
+
+	ret = regmap_write(sydev->regmap, REG_DEV_CTL,
+			   BIT_DEV_CTL_FAST | BIT_DEV_CTL_BL_CTLB |
+			   FIELD_PREP(MSK_DEV_CTL_BRT_MODE, 2));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(sydev->regmap, REG_BRT_12BIT_L,
+			   FIELD_PREP(MSK_BRT_12BIT_L,
+				      DEFAULT_BRIGHTNESS & 0xff));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(sydev->regmap, REG_BRT_12BIT_H,
+			   FIELD_PREP(MSK_BRT_12BIT_H,
+				      (DEFAULT_BRIGHTNESS >> 8)));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(sydev->regmap, REG_OTP_CFG5,
+			   FIELD_PREP(MSK_CFG5_PS_MODE, 6) |
+			   FIELD_PREP(MSK_CFG5_PWM_FREQ, 4));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(sydev->regmap, REG_OTP_CFG0,
+			   FIELD_PREP(MSK_CFG0_CURRENT_LOW, 85));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(sydev->regmap, REG_OTP_CFG1,
+			   BIT_CFG1_PDET_STDBY |
+			   FIELD_PREP(MSK_CFG1_CURRENT_MAX, 1) |
+			   FIELD_PREP(MSK_CFG1_CURRENT_HIGH, 10));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(sydev->regmap, REG_OTP_CFG9,
+			   FIELD_PREP(MSK_CFG9_VBST_MAX, 4));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(sydev->regmap, REG_OTP_CFG2,
+			   BIT_CFG2_BL_ON | BIT_CFG2_UVLO_EN);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int sy7758_probe(struct i2c_client *client)
+{
+	struct backlight_properties props = { };
+	struct device *dev = &client->dev;
+	struct sy7758 *sydev;
+	unsigned int dev_id;
+	int ret;
+
+	sydev = devm_kzalloc(dev, sizeof(*sydev), GFP_KERNEL);
+	if (!sydev)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, sydev);
+
+	/* Initialize regmap */
+	sydev->client = client;
+	sydev->regmap = devm_regmap_init_i2c(client, &sy7758_regmap_config);
+	if (IS_ERR(sydev->regmap))
+		return dev_err_probe(dev, PTR_ERR(sydev->regmap),
+				     "failed to init regmap\n");
+
+	/* Get and enable regulators */
+	ret = devm_regulator_get_enable(dev, "vddio");
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get regulator\n");
+
+	usleep_range(100, 200);
+
+	/* Get enable GPIO and set to high */
+	sydev->gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(sydev->gpio))
+		return dev_err_probe(dev, PTR_ERR(sydev->gpio),
+				     "failed to get enable GPIO\n");
+
+	/* Let some time for HW to settle */
+	usleep_range(10000, 11000);
+
+	/* try read and check device id */
+	ret = regmap_read(sydev->regmap, REG_DEV_ID, &dev_id);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read device id\n");
+	if (dev_id != 0x63) {
+		dev_err(dev, "unexpected device id: 0x%02x\n", dev_id);
+		return -ENODEV;
+	}
+
+	/* Initialize and set default brightness */
+	ret = sy7758_init(sydev);
+	if (ret)
+		return ret;
+
+	props.type = BACKLIGHT_RAW;
+	props.max_brightness = MAX_BRIGHTNESS;
+	props.brightness = DEFAULT_BRIGHTNESS;
+	props.scale = BACKLIGHT_SCALE_LINEAR;
+
+	sydev->bl = devm_backlight_device_register(dev, "sy7758-backlight",
+						   dev, sydev, &sy7758_backlight_ops,
+						   &props);
+	if (IS_ERR(sydev->bl))
+		return dev_err_probe(dev, PTR_ERR(sydev->bl),
+				     "failed to register backlight device\n");
+
+	return backlight_update_status(sydev->bl);
+}
+
+static void sy7758_remove(struct i2c_client *client)
+{
+	struct sy7758 *sydev = i2c_get_clientdata(client);
+
+	backlight_disable(sydev->bl);
+}
+
+static const struct i2c_device_id sy7758_ids[] = {
+	{ "sy7758" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, sy7758_ids);
+
+static const struct of_device_id sy7758_match_table[] = {
+	{ .compatible = "silergy,sy7758", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sy7758_match_table);
+
+static struct i2c_driver sy7758_driver = {
+	.driver = {
+		.name = "sy7758",
+		.of_match_table = sy7758_match_table,
+	},
+	.probe = sy7758_probe,
+	.remove = sy7758_remove,
+	.id_table = sy7758_ids,
+};
+
+module_i2c_driver(sy7758_driver);
+
+MODULE_DESCRIPTION("Silergy SY7758 Backlight Driver");
+MODULE_AUTHOR("Kancy Joe <kancy2333@outlook.com>");
+MODULE_LICENSE("GPL");

-- 
2.34.1

