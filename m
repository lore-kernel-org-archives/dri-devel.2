Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D25F3ED43
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 12:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D199710E1F1;
	Sat, 11 Apr 2026 12:11:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GuYeWTzn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HRlFAmaE";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3238D10E1E7
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:32 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B41X6o3377254
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VAtbVrs64v1P6uPBhtxx46qRyt71MB1P/3sk9FRUixo=; b=GuYeWTznLIsCyc7L
 wrdMbkL9cbpWmMVrvOgwOyxSwP0HgtAfDaQiYl1Cu2jG6ma8sPtL/5RQDGyoG+NB
 p5IhXrV53GyONcjW0B4/LoLq2ieU0bwR24R9UmHHvwWHRbQ6znOqM7o+Pqne5n7x
 tEXxypoYzeRPHBit27BV2yciSWZiNZsMrSbBb17m9ZqNZl9cZij3HUkxOq2YZz9T
 DCDPJqBblCmOPC18pnfBLFX4vIV2FMhuUgqWZYdUs7Taw4W9RUWg9DyXZz8usqAn
 vMho9ojyAm7vXHSjSNmy6S1b7uXaQeSOMZ10PyqSWUVmJgjUmx1QXzU8w5bVBKX8
 mEJJYw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfewkrnhb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:31 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d5d1c2289so10735741cf.2
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 05:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775909491; x=1776514291;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VAtbVrs64v1P6uPBhtxx46qRyt71MB1P/3sk9FRUixo=;
 b=HRlFAmaE/S2O0CQEK1eQEo8qn7rWAL5n09H2u8/pOxlrcsqM7P9hlOt5ZJl6VfYiQu
 eLexJv5/gZh2fmNwBuLYY20IYNw+O43j7P1PbL5iFd8X4MRA2ljPsJMmKYZFgOvBxLQY
 vQ2vOi99tvqQd9OEfbHI7maRakgtXxe5UM3BO5shjmgakjIzoLT9Ct1hGqYRq00VlhLs
 wGz+FGLhZEJ2I94vol1LizdLm6/6F2NyEgQydDyYeNXnXbqhrUfYgCWCEYQYw3KDqzJF
 MpTQZtJufWSBEDMkv47qh668sryQGnR8N30za15JWC2B3Vh0HZrWR71O4Zbe6MK3u3JW
 34dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775909491; x=1776514291;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VAtbVrs64v1P6uPBhtxx46qRyt71MB1P/3sk9FRUixo=;
 b=aI7BgvYfQx5u6fBUzIPI3ynYUhUxshTms38rU5NB4Y56rKEAbC+VKPdzluBwiUffTI
 aJkWThM1973jMM4qE/xZiFq9XBrTDAjinRZX8HJT0G9Qn6IIQ1sejzLNXdsXGY+xRCEj
 WBkIsJi0MdidfRjnXrPGm7owJFGLeJ/IgQNL92BDN1vIJHMUNZK+JBAfgQLgyn0CaPGf
 AZNwhfhgGPYG+Po2uPbrA0HIwL0DIWVguadpQgCWpjXSTYijDLWgtHldDeZ/IfJpaxq4
 kaxegdv/e8H0IaYz6vchikPO7yVBMOAmCBzcTQE0b7wZ1f/4ip6uDm3gtTY8koB2e4n5
 V36g==
X-Gm-Message-State: AOJu0YzuyYZ4TuNA8UCwk0PESqoFvptY0luUaEkNja6wj9BjtN65Ormr
 yGSOU4Bu0JQSawXZEeSVADMFaBmeOfFM42jU6bUtRqQ5wcjFoGctp4rY6lbvQgSykJzxRWbv7Qv
 i4EgnUn915AsNVkOJK7EUcJnffSbpFv6TnuMJ6dW7HWhCP0X6Nhtzlj+Wybp+24SgCyCQjhs=
X-Gm-Gg: AeBDiet83aH2qciVngz4S2MjqrV4EY2xS2nDTPi4AKwQ1fRZsAcsdp4vgQynwAmB3+z
 3SIjuGl95zkXqa/3oDo/GGNtN9ISSq8j8xHSTOkqInn9uGILgqNJI87fqZ+kH4IGOD8Bh7Wp/GS
 GJlX6NmGpctMQvudYqNXcQ0RgieOuJifpDxBiPXgHEDOGEjCd6FcX0M+P7+bxZmg6AOKDcAELMN
 f2MspQqRirRoj7v14IBCrPrpN8b9fXAEZSUmSs5+F6pAyi/ADrs0tLfFwJ4kpdETA0E8NuPjz/k
 GOjsyv+yvLuNA/RfQ510xKEyn7UO0hD4ikYN01P/eDRkHpRRKjRw2ygtwUDL6BNByt5JYe8ZkWL
 P8zBmVBteg8y74/+UfP9v6AJnbNl28ygNV3Gego2r8bPiG+Jtpqqz0Nbp74mrxoy0SfgwOwCAP2
 oab8VFxhvp5nBZkZ+Qo3/LD6rhl0/OzBKP3nM=
X-Received: by 2002:a05:622a:4106:b0:50d:72e4:6df9 with SMTP id
 d75a77b69052e-50dd5bf0c2dmr94703121cf.50.1775909490618; 
 Sat, 11 Apr 2026 05:11:30 -0700 (PDT)
X-Received: by 2002:a05:622a:4106:b0:50d:72e4:6df9 with SMTP id
 d75a77b69052e-50dd5bf0c2dmr94702521cf.50.1775909490143; 
 Sat, 11 Apr 2026 05:11:30 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e495b4e73sm11906291fa.41.2026.04.11.05.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 05:11:29 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 11 Apr 2026 15:10:39 +0300
Subject: [PATCH v2 19/21] drm/panel: add driver for Waveshare 8.8" DSI
 TOUCH-A panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-waveshare-dsi-touch-v2-19-75cdbeac5156@oss.qualcomm.com>
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
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7924;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=WCASkZHVOOg0Vh8+TWnnu2ShRAKBsiD2NCC/yOWwdHo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp2jpHiHxJwTago9a/vkDGGAdiGCxbg/AmCLxSW
 hRa4wETJvmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCado6RwAKCRCLPIo+Aiko
 1VkXB/9saVR0cyiSvjOH+jzWachvys2In9GaaDXaijQD6Sbn1gn5iTnp6s2Ee8kjMJ3AZJx9Ih1
 j2d8eaJy6h200zspFKjuJ4l+qDBg+/CpipO9FsvsSeaRTc70BqiZkFgS8WlTY9UhezqX0QhXAOE
 lWU7G4fkDdcnhuzRV4Rgkwib+O094W/ok48ZWW02QfByCa6ITDnPe7wLm4jQyriTJGh/DbdJKl4
 VkZ4uZBDM/FY2nZH1kiPAsOLV7wxSu7Yvu5FIu/RyzYAFFzidM0nbN81KqcFczPwEpcIlxQiaIk
 8oTCWUpTYZNavbFYnlKakp1SpEAJBiiVkPSkmPZvxnLqyRxE
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=bcFbluPB c=1 sm=1 tr=0 ts=69da3a73 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=s8VT41bj3HggknaiP0YA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDEwMiBTYWx0ZWRfX/kRmcIUrl2v4
 1wbnL2S5O5s1E7nvdwjzxJoBq6mzRTFlv5ON6JP+MNHZ/1jB1GwO7DB+gOkbmAzcFLRGzOuTYF7
 bTWjHkJ5oR/gxHFCsNXXZyuE3/gmi7vQxZ/8sINoXkazgOqhRhK/taEX1kApJa/7NQmP8AqP0DC
 hkP4ap9LpBsbYfXhMehgez2YyZuFFJzd6JBaOI93Q7mG6oqI6EsIn+P6OJD/JUHxYFENjohuz8r
 L1/p1HuYuftVWPjaz9lLX4lbVclkbpyvOji5FiT7wf2ePy0vYHv2E7e/ezOYCHC14mH5gR0TeFo
 YwIIQ8MHwuZstKz1WRNIApas6Dfd7y/lEf0NtYmvJrMxhud/6nK7uNa50LvAJo1XcBMSFqYF8PC
 2K6xEf3YOYasxTpLLiYc25cUyfAw/8ChKcQzmdqtc/DkdghQvsAoUyLFDHKkhRz4wm373tLn04L
 +QAbscofYBKLLxvfPRA==
X-Proofpoint-ORIG-GUID: vKXIk2sKhkrbpOKprMZ4HsZSJhjglwQ4
X-Proofpoint-GUID: vKXIk2sKhkrbpOKprMZ4HsZSJhjglwQ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
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

Add driver for the panel found on Waveshare 8.8" DSI TOUCH-A kit. It
uses ota7290b IC as a controller.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/Kconfig                    |  12 ++
 drivers/gpu/drm/panel/Makefile                   |   1 +
 drivers/gpu/drm/panel/panel-focaltech-ota7290b.c | 208 +++++++++++++++++++++++
 3 files changed, 221 insertions(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index ba527b4d7737..979109c27b9b 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -144,6 +144,18 @@ config DRM_PANEL_FEIYANG_FY07024DI26A30D
 	  Say Y if you want to enable support for panels based on the
 	  Feiyang FY07024DI26A30-D MIPI-DSI interface.
 
+config DRM_PANEL_FOCALTECH_OTA7290B
+	tristate "Focaltech OTA7290B"
+	depends on DRM_MIPI_DSI
+	depends on I2C
+	depends on BACKLIGHT_CLASS_DEVICE
+	select DRM_KMS_HELPER
+	help
+	  Enable support for panels using OTA7290B as a controller (for
+	  example, Waveshare 12.3" DSI TOUCH-A panel). Say Y here if you want
+	  to enable support for this panel. To compile this driver as a module,
+	  choose M here.
+
 config DRM_PANEL_DSI_CM
 	tristate "Generic DSI command mode panels"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index a4291dc3905b..0d694acbfbb6 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_DRM_PANEL_EBBG_FT8719) += panel-ebbg-ft8719.o
 obj-$(CONFIG_DRM_PANEL_ELIDA_KD35T133) += panel-elida-kd35t133.o
 obj-$(CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02) += panel-feixin-k101-im2ba02.o
 obj-$(CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D) += panel-feiyang-fy07024di26a30d.o
+obj-$(CONFIG_DRM_PANEL_FOCALTECH_OTA7290B) += panel-focaltech-ota7290b.o
 obj-$(CONFIG_DRM_PANEL_HIMAX_HX8279) += panel-himax-hx8279.o
 obj-$(CONFIG_DRM_PANEL_HIMAX_HX83102) += panel-himax-hx83102.o
 obj-$(CONFIG_DRM_PANEL_HIMAX_HX83112A) += panel-himax-hx83112a.o
diff --git a/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c b/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c
new file mode 100644
index 000000000000..991d6a4caf17
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Waveshare International Limited
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+
+#include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
+
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_probe_helper.h>
+
+struct ota7290b {
+	struct drm_panel panel;
+	struct mipi_dsi_device *dsi;
+
+	struct regulator *power;
+	struct gpio_desc *reset;
+	struct regulator *avdd;
+	struct regulator *iovcc;
+
+	enum drm_panel_orientation orientation;
+};
+
+static inline struct ota7290b *panel_to_ota(struct drm_panel *panel)
+{
+	return container_of(panel, struct ota7290b, panel);
+}
+
+static int ota7290b_prepare(struct drm_panel *panel)
+{
+	struct ota7290b *ctx = panel_to_ota(panel);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+	int ret;
+
+	if (ctx->iovcc) {
+		ret = regulator_enable(ctx->iovcc);
+		if (ret)
+			dev_err(panel->dev, "failed to enable IO regulator: %d\n", ret);
+	}
+
+	if (ctx->avdd) {
+		ret = regulator_enable(ctx->avdd);
+		if (ret)
+			dev_err(panel->dev, "failed to enable AVDD regulator: %d\n", ret);
+	}
+
+	if (ctx->reset) {
+		gpiod_set_value_cansleep(ctx->reset, 0);
+		msleep(60);
+		gpiod_set_value_cansleep(ctx->reset, 1);
+		msleep(60);
+		gpiod_set_value_cansleep(ctx->reset, 0);
+		msleep(60);
+	}
+
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 120);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 50);
+
+	if (dsi_ctx.accum_err < 0)
+		dev_err(panel->dev, "failed to init panel: %d\n", ret);
+
+	return dsi_ctx.accum_err;
+}
+
+static int ota7290b_unprepare(struct drm_panel *panel)
+{
+	struct ota7290b *ctx = panel_to_ota(panel);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+
+	if (ctx->reset) {
+		gpiod_set_value_cansleep(ctx->reset, 1);
+		msleep(5);
+	}
+
+	if (ctx->avdd)
+		regulator_disable(ctx->avdd);
+
+	if (ctx->iovcc)
+		regulator_disable(ctx->iovcc);
+
+	return 0;
+}
+
+static const struct drm_display_mode waveshare_dsi_touch_8_8_a_mode = {
+	.clock = 75000,
+
+	.hdisplay = 480,
+	.hsync_start = 480 + 50,
+	.hsync_end = 480 + 50 + 50,
+	.htotal = 480 + 50 + 50 + 50,
+
+	.vdisplay = 1920,
+	.vsync_start = 1920 + 20,
+	.vsync_end = 1920 + 20 + 20,
+	.vtotal = 1920 + 20 + 20 + 20,
+
+	.width_mm = 68,
+	.height_mm = 219,
+	.type = DRM_MODE_TYPE_DRIVER,
+};
+
+static int ota7290b_get_modes(struct drm_panel *panel,
+			      struct drm_connector *connector)
+{
+	return drm_connector_helper_get_modes_fixed(connector, &waveshare_dsi_touch_8_8_a_mode);
+}
+
+static enum drm_panel_orientation ota7290b_get_orientation(struct drm_panel *panel)
+{
+	struct ota7290b *ctx = panel_to_ota(panel);
+
+	return ctx->orientation;
+}
+
+static const struct drm_panel_funcs ota7290b_funcs = {
+	.prepare = ota7290b_prepare,
+	.unprepare = ota7290b_unprepare,
+	.get_modes = ota7290b_get_modes,
+	.get_orientation = ota7290b_get_orientation,
+};
+
+static int ota7290b_probe(struct mipi_dsi_device *dsi)
+{
+	struct ota7290b *ctx;
+	int ret;
+
+	ctx = devm_drm_panel_alloc(&dsi->dev, struct ota7290b, panel,
+				   &ota7290b_funcs,
+				   DRM_MODE_CONNECTOR_DSI);
+	if (!ctx)
+		return -ENOMEM;
+	mipi_dsi_set_drvdata(dsi, ctx);
+	ctx->dsi = dsi;
+
+	ctx->reset = devm_gpiod_get_optional(&dsi->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ctx->reset))
+		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->reset),
+				     "Couldn't get our reset GPIO\n");
+
+	ctx->iovcc = devm_regulator_get_optional(&dsi->dev, "iovcc");
+	if (IS_ERR(ctx->iovcc))
+		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->iovcc),
+					"Couldn't get our iovcc supply\n");
+
+	ctx->avdd = devm_regulator_get_optional(&dsi->dev, "avdd");
+	if (IS_ERR(ctx->avdd))
+		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->avdd),
+					"Couldn't get our avdd supply\n");
+
+	ret = of_drm_get_panel_orientation(
+			dsi->dev.of_node, &ctx->orientation);
+	if (ret) {
+		dev_err(&dsi->dev, "%pOF: failed to get orientation: %d\n",
+			dsi->dev.of_node, ret);
+		return ret;
+	}
+
+	ret = drm_panel_of_backlight(&ctx->panel);
+	if (ret)
+		return ret;
+
+	ctx->panel.prepare_prev_first = true;
+
+	ret = devm_drm_panel_add(&dsi->dev, &ctx->panel);
+	if (ret)
+		return ret;
+
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_HSE |
+		MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
+	dsi->format = MIPI_DSI_FMT_RGB888,
+	dsi->lanes = 2;
+
+	return devm_mipi_dsi_attach(&dsi->dev, dsi);
+}
+
+static const struct of_device_id ota7290b_of_match[] = {
+	{ .compatible = "waveshare,8.8-dsi-touch-a", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ota7290b_of_match);
+
+static struct mipi_dsi_driver ota7290b_driver = {
+	.probe		= ota7290b_probe,
+	.driver = {
+		.name		= "focaltech-ota7290b",
+		.of_match_table	= ota7290b_of_match,
+	},
+};
+module_mipi_dsi_driver(ota7290b_driver);
+
+MODULE_DESCRIPTION("Panel driver for Focaltech OTA7290B panels");
+MODULE_LICENSE("GPL");

-- 
2.47.3

