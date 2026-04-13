Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A43F34C49
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 14:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 317B910E4A0;
	Mon, 13 Apr 2026 14:06:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="S/MVJl5d";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hiXsOiaT";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B69F910E4A0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:06:28 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DDSju01224579
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /4NBXSH4Is2yC5xbwXreHyoFBggJh0nMi8dZy/+Iqn0=; b=S/MVJl5dJ9AHE8Fd
 lHnkXrSW2Xr0GuEP+LDKsA5sd+uRPLFkcPvbZ1X/KuPf12TjcHzv3Sr8SqOmWGpA
 S3ZMJsAFtHyORpat/e7E7V37Sl6kCmvOs4MVXaivAb5TPD4xQ9+bSxs0/jGNGBBO
 +I2QxFjF9H5x/WB301k18xgYsLI6t1U/44+3MAHEHWFF2lP6DvDkalsE3fyz6f1S
 q8SDBb68UeqUFqbyZAKhuVtYzEwacBrN5efgphxl1mjnINNEN8jZKgIas/zeKcqV
 zAUZO4wVOYswj/au8jhMd0t0FScuomeViEkWdwEnsofp3JjETCinHUAkgpg8Tu+5
 jUyZnw==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfexfwnyj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:06:27 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-66b612efb4aso6519003eaf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776089187; x=1776693987;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/4NBXSH4Is2yC5xbwXreHyoFBggJh0nMi8dZy/+Iqn0=;
 b=hiXsOiaTsE6XBzYfHetk6yfQlL2lKgmHNxwMcnIay1YSroWZjlVGp1HA4H8j13EJvX
 0lozsDLHn/ep0C9wKhpVi/t8Ze5CS5Oe89ymQ18Y6jJ1wZMFczb9MFWBTrJfta3mz20l
 xzyB5raVxH2FxGyc3M5qYcSz3Ww9iBkxnkV91Sc4Hhw6k21znUSN5eMNofN5JlMmBwRx
 sOcznPvI5N262Rr+/EOPhocYG2cauEX0blhkFsFDrDINWrvul1sRFliMAd3rZvTJDVNO
 Q9u5XVtOt+rovfn/2A9fymKoef7mHF57fs7kAC+1SH5/bal8c4E8VbynZNkFLgvSbOBL
 F+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776089187; x=1776693987;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/4NBXSH4Is2yC5xbwXreHyoFBggJh0nMi8dZy/+Iqn0=;
 b=bfTjNzE5D1ky/x7ysNquptF1zvDmkkFAoI84rebkvy4JXDBpaN4FWHVa4Mb0fhMjLp
 SlJNaF/tEA0Tm615l8Fr5Snb+Q11EdFQkQaBPkYjhe8yZiFicCN2XLN/OrDhxEOJGUeS
 KVryAgsz2jEZ8mZN9lhXiTcFiqlfgIRg5lEbTGyHUCwOrvYwlr7TplY+g8drfB1VejOz
 YSfVfJ35Uun85gj8oJbJnnsbmDMX7YLwdLknLXJX5Ssgj/ko1yolzSpatBQ2qMjyob/9
 WmZvGd7MniF6qjKQRN3REfNyTuuabQJtcNb5uM8IBJrYcASRGptjEXH8wgxjLDL0IXkQ
 PlKQ==
X-Gm-Message-State: AOJu0YxizE7iT14DHG9hXu4esXA6L/7QKV6fOpd4uScgKkYNE8T2wvvk
 FGk9wK3Cqhcu7RfFrYqpyu7To7eoxgHzw40VdPUTGoTEXLh6sEFrnrZyHbOQ7Bc79o9kKs2hAzG
 rRUEw2iKAbUB3YPCcG2nshYehf3q5+pkM4Q28YOQHm8xP+ht4EwDu/ggtxlpsSr20ZcCI7bU=
X-Gm-Gg: AeBDiet+uQJB3cKs9M2MV2WyybY4OqW0QiICixZklSAsUsg4J9XqpGA6UrdFITBndw6
 YSVGR0m8IvBDsslcDPRl5Q7Bn3r3y7uIFN3aCZY4fRZhrlkDXwSQ37Ec2TE8ctr0dfELuQado+x
 o2kqGZwuEpC5DZAesh3xAulKuZ9l7GbVpls5vejnwDhgLBjoprEO5SGCb6H8xtblIiOV3L5eh0e
 LNGHI/jBl5vPUtl9K9l1gf03uEhyJpdroD8RipD0F//97OyfNIAyptWqh2l2T/ZlSKdeEEGy1WL
 s6ycdHfx7JlJa4vHYZ4inaXLFPN1iK8992xvgAGcKYU5IkLyCjXf7dY/3RlCKTy+k175FG07r/P
 thX6grRMy0NbBR56T9CCk12OGllFtyibhxQqj1AbALwwBrsN2rQVWocQe0FrVg6ySyo7JYz9qGT
 1DtwDuPJVlxk3PC+SgAmBxvyaX9PpHH8fSytM=
X-Received: by 2002:a05:6820:628d:b0:683:a6e:970a with SMTP id
 006d021491bc7-68a6b54c90cmr5991209eaf.40.1776089187146; 
 Mon, 13 Apr 2026 07:06:27 -0700 (PDT)
X-Received: by 2002:a05:6820:628d:b0:683:a6e:970a with SMTP id
 006d021491bc7-68a6b54c90cmr5991191eaf.40.1776089186646; 
 Mon, 13 Apr 2026 07:06:26 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eee8c91csm2687521e87.19.2026.04.13.07.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 07:06:25 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 17:05:44 +0300
Subject: [PATCH v3 21/21] gpio: add GPIO controller found on Waveshare DSI
 TOUCH panels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-waveshare-dsi-touch-v3-21-3aeb53022c32@oss.qualcomm.com>
References: <20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com>
In-Reply-To: <20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com>
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
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp3Pgp0CRuEJwBZE0M+s4m5iHBHk23SvG/pqay2
 5QqzBFjhz6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCadz4KQAKCRCLPIo+Aiko
 1WLhB/0cpboMrZy9Q/a48/y4YERdx8SOPJoAKVOFjUn0HrVr5HZHrZ8Rrpg0CsYmnGo0jESQzYg
 H2+46/0JcudTvznVDqZ3TStiWBLo8H82ZGCG4qVj+OvVlmS68e/GMWRCf2eU4EdfdnVYrj8+UUP
 jmkLp5Z3l1mc5v/gcNN40tzi/sb4O/fLRxHFXKNmIHBGylaOg1Km4jYMs67D2E610WAHvuhMzGP
 0GfRy4CXzQ1cecaphhja5AV/hQzAlrstnUzLLgfvmegRby9y0//oJXBcr7IfoyFCpQ2fpaSwja2
 BXBa4dG1a/tM/B6F9nE3RF+t92n5t1JgqpMpvsYDFy9DZKnD
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: pdlz7103lDyolGSqH0FrgtI0eUFAK3-f
X-Authority-Analysis: v=2.4 cv=OpZ/DS/t c=1 sm=1 tr=0 ts=69dcf863 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=BBJQNc9AFPM2Ar9AcygA:9 a=QEXdDO2ut3YA:10 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-ORIG-GUID: pdlz7103lDyolGSqH0FrgtI0eUFAK3-f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEzOCBTYWx0ZWRfXxPscToN0379c
 PHYVTWGk7ikLMOw2DV9rY/9bX5kgvfuRVpFJwRbZxWSXL0JQpQqimmG4Rs1Iu6QFKzt4YmMspEa
 dyDnquUa5knBTdf3lQCNp7KBPy8wF23IIuIwEqU13kY4baLrulVeZaLKHMwkaElabIVfdWEy4qT
 y/TVOL+gXRnDx9DOFm9pAZDQDtWwfX9UeFsfoCIR0eMvqMSw533uvX7uAX3YoSPWy+CsY/TTEOo
 +1XZfkJdP4cQAc/+xVjt+HeB24ddWm9Act+tunoHLWIs+uzdMTLBVWQ4joh2KjF3cxYS4KGptfE
 p8Uz4upzdorzHgtg3UjTgN2ickAvCVCkVgklj39mxWpVtyGUosEe1rGiL2N/KHNsw12VYNpErVR
 eZFF3lxVwG6pLqrnK0L5gzljOxt6iGtnlsj0b1aflI0Ol5XHxkY4a26CfY1QytiSOfwh8ntUTLW
 HI+olPl0Fdr/xGvCPCA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130138
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

