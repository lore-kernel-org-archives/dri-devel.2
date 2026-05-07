Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC67CD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 09:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0721310EFC5;
	Thu,  7 May 2026 09:01:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hcXndHCE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SwrzAav1";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 284AC10EFC5
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 09:01:49 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64758t8g3924161
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 09:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BdeZ22yc5lNb0lR3mUu0n4xdAdKcxqKN4LRfXkSTI9o=; b=hcXndHCEpLoUoI9D
 uAhPq4aMJmU9tlVeOs9WdGK74K6/slb7Vvqzxok9GVtrZSJfAO9GLDk1Y9tUWZYP
 1d9BCKweQutn3busPS3OcJjZ2JeC0mxP6NMeVyK5SJWqJmNHP/+7+4rnrBt2rRTz
 2Fvj9HSvfGqGqpnyWydgzLoB02ovQym6CI2fcCZHMZkOQY3V0me40mzzOaMJu6mq
 1Ie3muRCUQ9UL/OWKZDic7JqkIo2wTtZpaY6lufp2iJHzJv6A7YipvZY3Gx4cnUA
 S09McgGb55SId9eT/8gA6GASa0CYIxHXgZkDS+UNWPAShw+24ulBaPD4ZV+or98O
 +rsCAw==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0c88abr0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 09:01:48 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-696233b2816so1074466eaf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 02:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778144507; x=1778749307;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BdeZ22yc5lNb0lR3mUu0n4xdAdKcxqKN4LRfXkSTI9o=;
 b=SwrzAav1Lc2rnb4YqdXO3L75/DWeIFrgujr9urz4XtHD9FtNGkdpJKQMA1CGx2Kyvu
 dtWJ0G1HdnfKWWI57ujrqU97/7p9vpaLSNXwgJnV91rcuAJd4XFiNb4rcEbfjuxtuGzX
 DjYumW4nsXvwlmwLhz3iN6AT/3Ww8yePyXvtd1HnyaxQ6TXnJzGx3Y9uTamK6d/djz04
 jn1vw3tti3VdN4WynRFRrtrLGekPgbYlXWk+9II/s/VFWHgAXoLeiwSzGPXCJSUp21CP
 5B1/pfVLcHyErOwtK2/kwBgXBjuDgEkKCSi4vg5ltUzsj3kMoOac8TVtgDic+nHug/0f
 f/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778144507; x=1778749307;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BdeZ22yc5lNb0lR3mUu0n4xdAdKcxqKN4LRfXkSTI9o=;
 b=PY/TAxpKM/nan6brCGAE3s4AplihUd63TUZvEhxfPJi9bzhC38mfLMc8B0U+bWovXg
 wZ8QRd666QuL6vqzmfVOo2F+j1UjQZKLgIUk7zisJD/DQN88qKleCpO2E06+VbKEAKLv
 /qYlbiy2WH1EES0v4G/xadcMJev5V02xffPSRIXRNjsMrI7oUuquFbYw0us5uuDVDFs5
 6aYomjZkMr0b4J7vv1sy1cfrL4JFrqK0TzaisSHtQU8IjXoVMcMyvBBzQq903gdROpVf
 ZIpJ1ZMKWwqx7pBKooMKj7N+J36xeEqCUg95Ql+7ojVtxxg1LZMAOsVe4tJz4xJ9Iw4V
 7ivQ==
X-Gm-Message-State: AOJu0YxjFamvB19r7LFkgF5ymhLinBz3wkq+DI5masg6ubTD4Yz2trFh
 Cj5u0BDrpDpafgOYVD8v7zAZWLS8DmzkEXWQgeEO8vwA6byyuSbrdSMQU+7N6ENDvYlyiO6SVnB
 L6eRIbcRFO/5tKE+Z0qhqtAh8wttHdtuBAlI7h2Lbdez7Nm5Y6h/hp651dJV8x7l8RqrXki/sqJ
 h3AhM=
X-Gm-Gg: AeBDievl4FUewLZGDgC3XfLmxOGDonYyv0v+2TXePdc6kLJ2fhYleeXCJn+C1lwa40Z
 XbpqJRCuEyNbMXLt+hm6kxkPaAvGAekX+MgPzyg8nFjp9avfxEYL0gqgC9Ee7M2iDo7LZARJDbb
 QWyMu2wPQUk3f4a2mxoOxH8si+VhnPDIrRW5ClBwTiVhcodxULdBuTm6EUUvAkcWMh3zTqHc+6+
 pY83PGtVTesEmP1korZMlnuYX2RjdMtSAaGGUiF+H56gKfCKz5DreiwZk/ZvRJBvHe+X0yQfEI7
 CElkN5tiOFRLkrqK5RqGDUa72Rv5QsvRh1ufrp9vT+SPnnfd4k21Hi5wY3LCWdvVI9N484TO06d
 /Ye+wfBK1frmp6fNNf9ZTINd7zN/DgBIvTygxHMk/zmPWCxf7AyqCkGscVK+fqkNM0de4ViY6wH
 6JABEKfR4eTBdF1bhdCWmSHa/Zq0umjQr5EGtjnc6YR0h9XA==
X-Received: by 2002:a05:6820:160c:b0:696:924d:2fe5 with SMTP id
 006d021491bc7-69998d30716mr3943924eaf.51.1778144506519; 
 Thu, 07 May 2026 02:01:46 -0700 (PDT)
X-Received: by 2002:a05:6820:160c:b0:696:924d:2fe5 with SMTP id
 006d021491bc7-69998d30716mr3943878eaf.51.1778144505963; 
 Thu, 07 May 2026 02:01:45 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a870f96cb1sm3480516e87.22.2026.05.07.02.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:01:44 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 12:01:33 +0300
Subject: [PATCH v5 2/2] gpio: add GPIO controller found on Waveshare DSI
 TOUCH panels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-waveshare-dsi-touch-v5-2-d2ac7ccc22d4@oss.qualcomm.com>
References: <20260507-waveshare-dsi-touch-v5-0-d2ac7ccc22d4@oss.qualcomm.com>
In-Reply-To: <20260507-waveshare-dsi-touch-v5-0-d2ac7ccc22d4@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>,
 Jagan Teki <jagan@edgeble.ai>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Jie Gan <jie.gan@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Riccardo Mereu <r.mereu@arduino.cc>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7772;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=KKME6iYlsGtIRkbeCWgSysWc/SsTcPMTPytNfArf9VU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp/FTv507N2zMjhKuukBTJZaa24cJ52RhkWf8FC
 R3Xr3WCMUqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafxU7wAKCRCLPIo+Aiko
 1TMICACcfSSppOas5sNdyuHnJaTnorQ4H4K6p9AZctZ3mtr9uNvuMqNmQoNMQRwx5CZ6HyuJAI5
 T7pZpxp+e0HT8uhMMb6kWtDcwX96R/x86fZcoEI9OKfwKdcO5Blq1W0wglbBzus8AgSKiymzxGX
 mg+Js05+m5YJ6RoDGSZrf6E1aD/G3F+LWT7s1Nvp3hAoqJmwG0qAr7D3MX9iiHvVdk45VZxlxXf
 GWr/o5mphMoKl20Zw2j79LgOkaSDIa3+n9r9Z8VwjDQqACCubq1OmhA7CY6vrGvdDnrkYKBvcQw
 Qb0rEi5p1zkofCg6tWMlYI/r5SJXVJhoZRk/dvhW4NSto+A3
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: VVZO5Q4E5JU1JWbej2ftVMI16lwKKLG7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA4OSBTYWx0ZWRfX6tcvYGoJ2cOC
 K84NmWvGlOvzxycQlRQoWj5fxfKmsE9UvBZxohYapYyvjyizE1ppyk3KM/Usm5FxqBW0zLpwdIb
 bdCuOD76jDI1Q606lHZSWvxkn2soCZvGQ6FJbTh/Yn8zgHGjaBcssoNA75/knPKC/XS0ihmhX64
 f6hoCMiOP9sinnXbBmGlAJCVl3i01RWLUctLE4JUjZ8ZyZ2CLYaF1sYP4jncX3r/8Q29uk9fFIV
 qkZ6ZLiaIvq4VuaYd7Rp7IS2HZjY0MUImbU+SGhkd3I/IKoa4AqKTonifEjx8sOXWnhGym7RYRR
 pMsbzAxCC42PNJu2GHRuexRcXlIn01gLeq4zyOKdy634jG3Nkkec1rygVlAgChhgn3KB09sm3PJ
 NbQRQ2Oxbpt7bZcfJiwnsIl5BvWALPfmKJ4Xfpr+cyIprsp7azN3Qw2fgHEIaGU1/VVM5CWdYTO
 Difu3BhnIacnHB+Y8sA==
X-Proofpoint-GUID: VVZO5Q4E5JU1JWbej2ftVMI16lwKKLG7
X-Authority-Analysis: v=2.4 cv=X8Zi7mTe c=1 sm=1 tr=0 ts=69fc54fc cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=BBJQNc9AFPM2Ar9AcygA:9 a=QEXdDO2ut3YA:10
 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070089
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

The Waveshare DSI TOUCH family of panels has separate on-board GPIO
controller, which controls power supplies to the panel and the touch
screen and provides reset pins for both the panel and the touchscreen.
Also it provides a simple PWM controller for panel backlight. Add
support for this GPIO controller.

Tested-by: Riccardo Mereu <r.mereu@arduino.cc>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpio/Kconfig              |  10 ++
 drivers/gpio/Makefile             |   1 +
 drivers/gpio/gpio-waveshare-dsi.c | 208 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 219 insertions(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index ce95a25298a8..8ae6a423da6d 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -806,6 +806,16 @@ config GPIO_VISCONTI
 	help
 	  Say yes here to support GPIO on Tohisba Visconti.
 
+config GPIO_WAVESHARE_DSI_TOUCH
+	tristate "Waveshare GPIO controller for DSI panels"
+	depends on BACKLIGHT_CLASS_DEVICE
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Enable support for the GPIO and PWM controller found on Waveshare DSI
+	  TOUCH panel kits. It provides GPIOs (used for regulator control and
+          resets) and backlight support.
+
 config GPIO_WCD934X
 	tristate "Qualcomm WCD9340/WCD9341 GPIO controller driver"
 	depends on MFD_WCD934X
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index b267598b517d..2ea47d9d3dca 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -205,6 +205,7 @@ obj-$(CONFIG_GPIO_VIRTUSER)		+= gpio-virtuser.o
 obj-$(CONFIG_GPIO_VIRTIO)		+= gpio-virtio.o
 obj-$(CONFIG_GPIO_VISCONTI)		+= gpio-visconti.o
 obj-$(CONFIG_GPIO_VX855)		+= gpio-vx855.o
+obj-$(CONFIG_GPIO_WAVESHARE_DSI_TOUCH)	+= gpio-waveshare-dsi.o
 obj-$(CONFIG_GPIO_WCD934X)		+= gpio-wcd934x.o
 obj-$(CONFIG_GPIO_WHISKEY_COVE)		+= gpio-wcove.o
 obj-$(CONFIG_GPIO_WINBOND)		+= gpio-winbond.o
diff --git a/drivers/gpio/gpio-waveshare-dsi.c b/drivers/gpio/gpio-waveshare-dsi.c
new file mode 100644
index 000000000000..38f52351bb58
--- /dev/null
+++ b/drivers/gpio/gpio-waveshare-dsi.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Waveshare International Limited
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/backlight.h>
+#include <linux/err.h>
+#include <linux/fb.h>
+#include <linux/gpio/driver.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+
+/* I2C registers of the microcontroller. */
+#define REG_TP		0x94
+#define REG_LCD		0x95
+#define REG_PWM		0x96
+#define REG_SIZE	0x97
+#define REG_ID		0x98
+#define REG_VERSION	0x99
+
+enum {
+	GPIO_AVDD = 0,
+	GPIO_PANEL_RESET = 1,
+	GPIO_BL_ENABLE = 2,
+	GPIO_IOVCC = 4,
+	GPIO_VCC = 8,
+	GPIO_TS_RESET = 9,
+};
+
+#define NUM_GPIO 16
+
+struct waveshare_gpio {
+	struct mutex dir_lock;
+	struct mutex pwr_lock;
+	struct regmap *regmap;
+	u16 poweron_state;
+
+	struct gpio_chip gc;
+};
+
+static const struct regmap_config waveshare_gpio_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = REG_VERSION,
+};
+
+static int waveshare_gpio_get(struct waveshare_gpio *state, unsigned int offset)
+{
+	u16 pwr_state;
+
+	guard(mutex)(&state->pwr_lock);
+	pwr_state = state->poweron_state & BIT(offset);
+
+	return !!pwr_state;
+}
+
+static int waveshare_gpio_set(struct waveshare_gpio *state, unsigned int offset, int value)
+{
+	u16 last_val;
+	int err;
+
+	guard(mutex)(&state->pwr_lock);
+
+	last_val = state->poweron_state;
+	if (value)
+		last_val |= BIT(offset);
+	else
+		last_val &= ~BIT(offset);
+
+	state->poweron_state = last_val;
+
+	err = regmap_write(state->regmap, REG_TP, last_val >> 8);
+	if (!err)
+		err = regmap_write(state->regmap, REG_LCD, last_val & 0xff);
+
+	return err;
+}
+
+static int waveshare_gpio_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
+{
+	return GPIO_LINE_DIRECTION_OUT;
+}
+
+static int waveshare_gpio_gpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct waveshare_gpio *state = gpiochip_get_data(gc);
+
+	return waveshare_gpio_get(state, offset);
+}
+
+static int waveshare_gpio_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
+{
+	struct waveshare_gpio *state = gpiochip_get_data(gc);
+
+	return waveshare_gpio_set(state, offset, value);
+}
+
+static int waveshare_gpio_update_status(struct backlight_device *bl)
+{
+	struct waveshare_gpio *state = bl_get_data(bl);
+	int brightness = backlight_get_brightness(bl);
+
+	waveshare_gpio_set(state, GPIO_BL_ENABLE, brightness);
+
+	return regmap_write(state->regmap, REG_PWM, brightness);
+}
+
+static const struct backlight_ops waveshare_gpio_bl = {
+	.update_status = waveshare_gpio_update_status,
+};
+
+static int waveshare_gpio_probe(struct i2c_client *i2c)
+{
+	struct backlight_properties props = {};
+	struct waveshare_gpio *state;
+	struct device *dev = &i2c->dev;
+	struct backlight_device *bl;
+	struct regmap *regmap;
+	unsigned int data;
+	int ret;
+
+	state = devm_kzalloc(dev, sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return -ENOMEM;
+
+	ret = devm_mutex_init(dev, &state->dir_lock);
+	if (ret)
+		return ret;
+
+	ret = devm_mutex_init(dev, &state->pwr_lock);
+	if (ret)
+		return ret;
+
+	regmap = devm_regmap_init_i2c(i2c, &waveshare_gpio_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to allocate register map\n");
+
+	state->regmap = regmap;
+	i2c_set_clientdata(i2c, state);
+
+	ret = regmap_read(regmap, REG_ID, &data);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to read register\n");
+
+	dev_dbg(dev, "waveshare panel hw id = 0x%x\n", data);
+
+	ret = regmap_read(regmap, REG_SIZE, &data);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to read register\n");
+
+	dev_dbg(dev, "waveshare panel size = %d\n", data);
+
+	ret = regmap_read(regmap, REG_VERSION, &data);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to read register\n");
+
+	dev_dbg(dev, "waveshare panel mcu version = 0x%x\n", data);
+
+	ret = waveshare_gpio_set(state, GPIO_TS_RESET, 1);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to program GPIOs\n");
+
+	msleep(20);
+
+	state->gc.parent = dev;
+	state->gc.label = i2c->name;
+	state->gc.owner = THIS_MODULE;
+	state->gc.base = -1;
+	state->gc.ngpio = NUM_GPIO;
+
+	/* it is output only */
+	state->gc.get = waveshare_gpio_gpio_get;
+	state->gc.set = waveshare_gpio_gpio_set;
+	state->gc.get_direction = waveshare_gpio_gpio_get_direction;
+	state->gc.can_sleep = true;
+
+	ret = devm_gpiochip_add_data(dev, &state->gc, state);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to create gpiochip\n");
+
+	props.type = BACKLIGHT_RAW;
+	props.max_brightness = 255;
+	props.brightness = 255;
+	bl = devm_backlight_device_register(dev, dev_name(dev), dev, state,
+					    &waveshare_gpio_bl, &props);
+	return PTR_ERR_OR_ZERO(bl);
+}
+
+static const struct of_device_id waveshare_gpio_dt_ids[] = {
+	{ .compatible = "waveshare,dsi-touch-gpio" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, waveshare_gpio_dt_ids);
+
+static struct i2c_driver waveshare_gpio_regulator_driver = {
+	.driver = {
+		.name = "waveshare-regulator",
+		.of_match_table = of_match_ptr(waveshare_gpio_dt_ids),
+	},
+	.probe = waveshare_gpio_probe,
+};
+
+module_i2c_driver(waveshare_gpio_regulator_driver);
+
+MODULE_DESCRIPTION("GPIO controller driver for Waveshare DSI touch panels");
+MODULE_LICENSE("GPL");

-- 
2.47.3

