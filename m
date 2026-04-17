Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7243F99C69
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 23:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25E6110EADD;
	Fri, 17 Apr 2026 23:16:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="J8On6Anc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EfT6L+L1";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C177D10EADD
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 23:16:41 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63HG4Hxg4068746
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 23:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /4NBXSH4Is2yC5xbwXreHyoFBggJh0nMi8dZy/+Iqn0=; b=J8On6AncEsQT7uOi
 nXaMI5BqK+Lf//c+rn4aagri5zbmE20z6U7jHZXYrzEVBpo7Wk3hNxhrSMNwdfUX
 pkFLevmbt5Y4xjEZLX97znFWMXJJQ7E6esIAbYP71tAaRcZYOTFDN1Nht7atqDCb
 vfDIyQRl4+B7fhHahlDuOANHnOH1th9D9xMY/xsb/yMc4sx/4COdJeu/N1nV4FUK
 LpbtfedzM80U3pWPHV1QPQHNbLjTYZnwUmcb3R7ZnVTbFGnLaw+k7joFqm0YAh+f
 GSGNod66XmXFjeC72WBMKqH4cJ+NWrfnKhkngOXntH5qaN5WQEyLhXAhUmcWSLbx
 Rta4nw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkhpu2kmm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 23:16:40 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d8e8c47a3so36534061cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 16:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776467800; x=1777072600;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/4NBXSH4Is2yC5xbwXreHyoFBggJh0nMi8dZy/+Iqn0=;
 b=EfT6L+L1JKS0qbidKwDxG7Rg5FabKc0GLEKR5vDpbZgzoZYEdLvpa5FSJyEXiUrRdM
 RF+NiwUuTpwpl3jm/1S0nnfLu212uJT2e/7aYu2dqEsLM8NbxQl6vPd4wwEFkmExkqHs
 3h9QKFQaGGl6r7z9zFiXRz0w8d/o5o7WyT/KY/V7QofdNsbYXzTuUR+8HTima8TQgsIL
 UkDsVJiFHQXTe07HnusyPe+HzmAkGfT7Rs25YmMggO7xZb6mW7XFODp6KLqA0J+P8PHj
 Z8gZfuy5wzpN9tfHS/o3V9gV7gL0+bARuDTsAUGMge96SRmlzC4NdZDb5hxe2+jASb1g
 Eg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776467800; x=1777072600;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/4NBXSH4Is2yC5xbwXreHyoFBggJh0nMi8dZy/+Iqn0=;
 b=LOdX88Nx0rY+VmjJ01zAxZB6scOwqy2kLQvFTy19XGZWPWdX1x+5JwTexcvcD6t86T
 xopnLMsLKPcICRrhglHYmkkKLg3kMpZrJo1Rv7fHrVogXXIppwIAw/ndFkDF4nr6HpXh
 FYyWG/ZnPa/IcEYTGvFhhy6HpFj/0dVMDKyhYaQX2nwzDVWMShByNq+PXJ+RxymKfn5a
 U1y51a8QU19NxuI1D2LMshEPhcwlajme3zHYTRBBgzfbXtqUskibE95Mlv09uZT92vGB
 MInrl+/QxaR9XBSWJD/zH79+iEKgelwKFCvjQb7O6xKs1HmLS5d+JEwvbVYr64FGJmCZ
 Gh4A==
X-Gm-Message-State: AOJu0Yz9cYOsXyurpiOnTG3sQ/HDb6p4v9ojj64LDq+Fb+cLmQoWKKnN
 8+a9IVdZDKU4UOzphBvEEo1cmDSzkBfSRetW+R8UQIaQrIr5d7uv5M7VxrZX2mDZCijcxiJEpo+
 ZFTZj+Cm3IEcRfJymLaDq5NU0c3rcyp90qBRMf5oTDOMd9A3osuBSVVvM6Qjcgykz4avzLl0=
X-Gm-Gg: AeBDies3ana2+RAaaBUcKQHEyody2V8sC0bnHa6hr65EeyJP4siXX/Ly9AOt9sPEuX1
 yK2Wsl1U5ErLe9Ag5GcCdTkgoiPu6JFZjx4C4Sws+UjFSXiN1uAzvfqSv5aPrtvAWaN+udQkoPO
 u+Bq5xs0OxCalbLppPPCEvHzEG1r6itlefEA6kN0c/y1qSDkxVEYaKtr9W1FfuWO58U60lylHD/
 dxRxFkwbutEVIbH30ZWhsiqqRiONbmrvKMETLRov7T05yR+VnUS67Xl2oXgMPVjiMuHgXCbAuuT
 771e0m632SZXvIw8k3W7Cx/WN/Kv1BnPIpeKdDOhm1Vd9CLBnMdqK8jFLjFWPz4V6Qv7zyKsNO3
 TamL3blkdG4UNt8+6ow0dSgAbLTiSGBxHkaMjDQIRg/2sXs+Hg4VEej/ORAumWMgCG5KDBE+yBA
 GoUlheUt76BECaxReTCENR8AdGLaMJ19Z3ZtsWntoU3F5vmFbinYUuUXA0
X-Received: by 2002:ac8:7e8b:0:b0:50b:3e14:47f9 with SMTP id
 d75a77b69052e-50e36b4004dmr71207411cf.18.1776467800145; 
 Fri, 17 Apr 2026 16:16:40 -0700 (PDT)
X-Received: by 2002:ac8:7e8b:0:b0:50b:3e14:47f9 with SMTP id
 d75a77b69052e-50e36b4004dmr71206821cf.18.1776467799621; 
 Fri, 17 Apr 2026 16:16:39 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185ad12asm815695e87.1.2026.04.17.16.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 16:16:36 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 18 Apr 2026 02:16:23 +0300
Subject: [PATCH v4 4/4] gpio: add GPIO controller found on Waveshare DSI
 TOUCH panels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260418-waveshare-dsi-touch-v4-4-b249f3e702bd@oss.qualcomm.com>
References: <20260418-waveshare-dsi-touch-v4-0-b249f3e702bd@oss.qualcomm.com>
In-Reply-To: <20260418-waveshare-dsi-touch-v4-0-b249f3e702bd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7752;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=LLB5S+fq0OkGtz5fZjjGOedSRUpC3QiVTV63iuC2ud8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp4r9JDpfhol8AoFz4jD5vkT+meGyDTMarU9bf4
 0SrjTu9wViJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaeK/SQAKCRCLPIo+Aiko
 1YToB/9g1+pGdvvJwBjuO+QerWMC6htvuKdbCWaWfW3Ub/3Gjm5uQ/aT22qdXM7+DG9dBlfXQQZ
 yOCIUPrmbFVsBZidylfPky22sBwJcciv4tY4ud3K9qruS6rVOd6Eq3TA0k0rRuloLI2v/8OPUl4
 ads9WVQ1NEKG8ttZhjMRfAAJLci5IRHYRgDvJ832t5hHxJWQ8K1zT1ftdQ1nh6EXolGf+u3r3mW
 AwxroDcnDomfHF/cTp9WCxxx65eCrMoY3urLVYtu37lK+MsLwyJ27V53reFD5mj79OiMPwewzcX
 ynlLCCXy6XKXzb5pKwXY/4ZA9Ha/tMiFmCiAcY5tjlpaQW+X
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=Kd7idwYD c=1 sm=1 tr=0 ts=69e2bf58 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=BBJQNc9AFPM2Ar9AcygA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: bS3hRpeYrb1kT6TnB1VJF86mxy5CCjTH
X-Proofpoint-ORIG-GUID: bS3hRpeYrb1kT6TnB1VJF86mxy5CCjTH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDIzMCBTYWx0ZWRfX/gnd1K5IaWxC
 pOEyjH63LkOCUniTkgU0gdg8BRWeA2UMjPsoSNEmzbgo/QZS/qgjV5VjYPdCiAS8ZlwvCijOYZm
 1hsDe4dbw4ld9sV69kqw/m+Zaqw7k31CvScyGDhO9O7i05f3PR1u8iOqvR7ZnpMXZGVTUSzUhVS
 OQ83HiPrV4rTlg36uG/G0PLFxlNL+Bcqq+vT3k0gKLpbL+eWIWBFJVSRw5x9z8OSubfD/esbcY4
 kkh3u7yQ32hZeVFpIbGCcyt9D9kNyfv1Nr2iAbrfZF2bni1EQ0hXzn+Jk6YBUPEXkvmDf0jCYW4
 F0iu+bF4HlKiARRven+EcVne63nOKMA666T4hWYXHVI0PpzbkZDBkBFEFTdHtd2RWDReuiZ2fpe
 eHaqCwInv8IU2PyGwIUsRwz5fNEUyR6uKNzib5w5fM4CM8Fp2YGB4rnIhtyg0iE4Aj8H8j7yn/U
 +HkGWCmhj1yDyhEY9RQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604170230
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
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpio/Kconfig              |  10 ++
 drivers/gpio/Makefile             |   1 +
 drivers/gpio/gpio-waveshare-dsi.c | 208 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 219 insertions(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b45fb799e36c..e24ad7e32034 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -804,6 +804,16 @@ config GPIO_VISCONTI
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
 	tristate "Qualcomm Technologies Inc WCD9340/WCD9341 GPIO controller driver"
 	depends on MFD_WCD934X && OF_GPIO
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index c05f7d795c43..94f16f0f28d9 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -206,6 +206,7 @@ obj-$(CONFIG_GPIO_VIRTUSER)		+= gpio-virtuser.o
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

