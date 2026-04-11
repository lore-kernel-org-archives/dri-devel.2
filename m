Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A4B1F3ED43
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 12:11:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC31210E1E7;
	Sat, 11 Apr 2026 12:11:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RdqYeQdx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fup6f/NW";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C1FE10E1F3
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:35 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B403Jc516611
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 a6xJZ5euRUkJ01/MhbgNuHprFSRyTM9G9jNcE79fdD8=; b=RdqYeQdxVqul5YUP
 YJv9ALIZxbDX7x/Z5cCkXTFbSom/0+K1yIi8RGidsUR06hvamy4/ccrH2PgOACd/
 Ms5rbdZha2/cyIDevs7ITLt55xwfxXvOefbbt43G48D9JAdIyz8292D4JOFQnVu7
 +lflPqk2ufEwDiSqoGzisdCqJWJFRuv4SlPQUM2n37B0EUF1IAI3IN5iWgjcVohO
 BEJv1EJkBgFvbwOm2qDsZ1ae7WvvBa59vb6X0rqp2XE1W9rAcXyqPg8/LsHKnLfL
 +UI4YRErrOPqWpRpeNV8vRcG1buDkM5vh9oFidyHW5FzE/mGoklDuXQfq6htmd3y
 jbFnrA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfevtgnjr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:34 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8d654ade33aso661695885a.1
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 05:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775909494; x=1776514294;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a6xJZ5euRUkJ01/MhbgNuHprFSRyTM9G9jNcE79fdD8=;
 b=fup6f/NWTlN/ku4swprBkDTCnegGtFKKxwymz+AcGOQBLSbn3VShA9AaXpr2j1rrG7
 vhUBZZV+e55SV+A+kSS+lJP3QXofNydOI79LlubLxmQurCNe+mZh94YzXKhtDy6K08Wb
 UQYf4lOh5bcS4F5Cy3YF1/kvrFmf/oIzzWVeRWCUklXXLaa1esEvmfgqSc3VswIZTD2H
 KZhwEUlHI0FaOy9japj6ANWL8ggJF1TY7qPY7ccKRMkov37QrYUi531X22exQWdXN/mQ
 EotuaesjgfyROs4QBCBf6koYv1AA4WzO66tL92PDx51q0hlNL1A+Fy3YiPaU/yEF8Ksm
 00tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775909494; x=1776514294;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=a6xJZ5euRUkJ01/MhbgNuHprFSRyTM9G9jNcE79fdD8=;
 b=dIMOIHO1C4Yn9X0wuJRejOrr5Accu5W6aIKutpGqgoSOPscaFOsKhFWMPPKvbyEvQ2
 E0ioeWD1ksd2/ez7/xy6Gmzt+SmBRM+GJKZdiTPds6/l6iOd7lgIGsBef63TNXYinebm
 ZQdmaZFeHWd9PQq3qMRnyeFIJYPr1bD32A+lRbHqQbf1TwwJ7hbOcebd9SLmrAQ0igUB
 +cpibwNXHhf7vwsW2OCfiFp3+Za7TP2GVPyPWJSXiADPrbW3EgRKB/W7ZxS9AwxkZ0R8
 LYMQLzhVOPYTRE3pi6VLs7V+2c1kmjwhTn3hBSjx2RtVtCayHBZn+MFH7RLSvm+X5XE3
 xPPA==
X-Gm-Message-State: AOJu0Yy/BUViHHnFRqMvMQPE/z+qtCUysIg03bpkNw8Zu1EEqfn1g8k6
 VaT14qP/q03AKsc8UKTe3FwsNoBVeVTl/2tJkLAu0oxW67absyjORDQIOmyjxy91ksVxqkfwWab
 0vq13NU+XDcpc/KpoeGDzgyt5Qd8XOtb+fdqjbqq6sl/1cobnUHfIHyFBBy5nFmeON87n61Y=
X-Gm-Gg: AeBDievTVAln0yQHVzZLMVGn4GHdpLCvOZN/rpN+YaLBllAsfdRwUeKkX9r2DWo1t+B
 N2U/zxE0XbKSqraplJE6fgqDKBZgXgUzlEKwfbm8Kg2dbOjkSA0cCEfpL3n4AZ7DcYIkX3vfb82
 Oyf2aSpWmXib9urHuhbF9dJi5E95rfM+f5rV5xsus8TGQ5l1J9IiUiCp6BRIvLgL8D+mhofNlF/
 pxXUHWRqmaELC48hMqxbdegp1n0x45JV4a5Krex1LTIC/cQVBJvPJNybwXTniS7MzichVfjcR2a
 PFt9Kn/3eqfooyVgVVW+bwGc3mk1MWZtdIihLAc8tqOjI/dI7Q23lGCkBXGZwm+pSL4Gp8fdWz4
 JuKXgdlkRqTSbM9PjNrbpAqa0GSr08+WWak/nxpEfSl6QKi6YOHfmrwyGSuOhz30OUI2mNP+Xew
 HcMr/70z2qwN2x19iGquyeiSKSE6iGEKQPyvU=
X-Received: by 2002:a05:622a:1c0c:b0:50d:8ed0:7f10 with SMTP id
 d75a77b69052e-50dd6abfc41mr80286521cf.13.1775909493607; 
 Sat, 11 Apr 2026 05:11:33 -0700 (PDT)
X-Received: by 2002:a05:622a:1c0c:b0:50d:8ed0:7f10 with SMTP id
 d75a77b69052e-50dd6abfc41mr80286161cf.13.1775909493152; 
 Sat, 11 Apr 2026 05:11:33 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e495b4e73sm11906291fa.41.2026.04.11.05.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 05:11:32 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 11 Apr 2026 15:10:41 +0300
Subject: [PATCH v2 21/21] gpio: add GPIO controller found on Waveshare DSI
 TOUCH panels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-waveshare-dsi-touch-v2-21-75cdbeac5156@oss.qualcomm.com>
References: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
In-Reply-To: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
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
 Bartosz Golaszewski <brgl@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Riccardo Mereu <r.mereu@arduino.cc>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7737;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=hmXTmyPe2+8CQYPgL4u755xNdxBVwLTJmFYBmxJpfok=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp2jpIAhcDDnqAbT569t4Y6yYBcC7UU+uWhTpAV
 0kIUUmkVj2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCado6SAAKCRCLPIo+Aiko
 1Y4LB/49p6uXzAnYxBtCIJJINoYExIC34T8A+v+6+4Hp3IsBSs9yXVGxN30mvWRcA8HhqRSCM0K
 XoaS/4PG+5LPwJkqRIxD0ZiwFO+PJ15Oh6S3jGWE3poikGgO+SmnsPTsyI/QEv7EKqxSzPfVyNw
 rzfWqq3Zu0+wHuKFX2bAi4pN6gtg99qY2a/esrjqOOW60H5DNybgHK+a5DKTUmeys2G3ry5LGSR
 sp6OQc3NF3MDzjbJS9zT4YIvVie2Cun5eu5KGf2gDMHjWpaMQIwR24tgbn3J44yBhq8O6Mlm9Gj
 IF3ik1hbXueFlEI2vastpmeSH3FuFa4tzbpMmg8qPijfnKtj
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=RYWgzVtv c=1 sm=1 tr=0 ts=69da3a76 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=BBJQNc9AFPM2Ar9AcygA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: u6GqYfsrSn8tTTm9SXhuWhhnRMGtBTXs
X-Proofpoint-ORIG-GUID: u6GqYfsrSn8tTTm9SXhuWhhnRMGtBTXs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDEwMiBTYWx0ZWRfX4IBs3qmcIO6m
 Sls3fRl4QkvcgPvFmEallLcRnMTxRE+WkftM1OzLO3xcidV/z/J/toQ2e0fXMh9LbdKg67niDAD
 7S2iwZGNBj6xYgDDye9A8Kp2hZUkICI1w9AjU3rssOw8+p7iIKskQVp5vf43cdmmCUFp/uZyqZ4
 g/L4jLyoxoTHhXnozlL9i1QSv7xyY89aAEwDtnt5Ve62scasc5KOpFg4GE8OpAS27B8c5id++Bd
 q7hf90wOcuRsVLRmMp+wVBTxanl+NOTUxmyM1xAVFcCJzaHXWPDYWaE8Omob0PICojf7WavH0Zr
 hN7FQdGmHXIP9txmHqMjZx+0Hlw3Ou7xAm2pf1+XUluvfYaFuS4wMDbrXjcth23IlnhwxJX0uLJ
 5LuHj3a43v2Rd0lRIo5+iHuzvDMEAVH6SlshWJ14muJnuFy29d8LayZ8BzVNZgJwuVAuj4D8TuV
 ZIAs9mJ00lyHNt0BpFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604110102
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
index dbe7c6e63eab..1b210c451151 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -805,6 +805,16 @@ config GPIO_VISCONTI
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
 	depends on MFD_WCD934X
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 20d4a57afdaa..75ce89fc3b93 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -207,6 +207,7 @@ obj-$(CONFIG_GPIO_VIRTUSER)		+= gpio-virtuser.o
 obj-$(CONFIG_GPIO_VIRTIO)		+= gpio-virtio.o
 obj-$(CONFIG_GPIO_VISCONTI)		+= gpio-visconti.o
 obj-$(CONFIG_GPIO_VX855)		+= gpio-vx855.o
+obj-$(CONFIG_GPIO_WAVESHARE_DSI_TOUCH)	+= gpio-waveshare-dsi.o
 obj-$(CONFIG_GPIO_WCD934X)		+= gpio-wcd934x.o
 obj-$(CONFIG_GPIO_WHISKEY_COVE)		+= gpio-wcove.o
 obj-$(CONFIG_GPIO_WINBOND)		+= gpio-winbond.o
diff --git a/drivers/gpio/gpio-waveshare-dsi.c b/drivers/gpio/gpio-waveshare-dsi.c
new file mode 100644
index 000000000000..f4a1d4d3b872
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
+	.max_register = REG_PWM,
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

