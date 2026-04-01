Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B733D3514B
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 07:27:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71B5A10EF24;
	Wed,  1 Apr 2026 07:27:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JpANGx+K";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CreZ/SAB";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4221110EF24
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 07:27:25 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6317EoTi4106695
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 07:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7GMiCfMQvlQASFFq+WsdvEPLNPcgoyaFOU1CUCJmjxI=; b=JpANGx+KUhIhHaqX
 GpACUN6dhcqb0nYfRapQdeHm6Kqlg6Teti2BdvmBi5mOhAZfIX7ajAjalkCfu0xa
 gO1YX/TjdgCn0wJ7YwtQLusOkSX3RNZ1BSxKCtyNYpTfGtZZ51qiny08V6CzmjcY
 4eNEEoPrHPDlM0qM3YRRlvQ2/41yJBGh47ukUn7Bq9n4EnjacrDR1sXwNStLdRlF
 aEhd3wdMX2+puiiQlJ1EiFWw43wH6dvsi8vkvJd2ioVVzqZ34t6DZqA1FdzOfdc2
 viw6bTE+SkOaJ4dCUtiMdUdS+LsiIi9NSwz/cv4jpv5CrJe6unJGMX5E+AcRAw+z
 Jao0rQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8xt901se-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 07:27:24 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5090bc4823cso86763391cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 00:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775028444; x=1775633244;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7GMiCfMQvlQASFFq+WsdvEPLNPcgoyaFOU1CUCJmjxI=;
 b=CreZ/SAB/Cz8wUjA+9SGLdJFyrqDfnTY6uJP1RVT1bt5j/HqsngI63scZb6dLCXhXf
 Xm5nEX9c4jwbX5z3grr75n6zR0uBgaN8wdhudkGL6rHv7hBSENA7IzlOackbnirQjVuZ
 wmAFyiQLIpJq4XMD6RXR199yT47fOhXgH5AMbt2cQqwZ3DC6Iruw8ahV14oD8pFDTf/b
 5+hGUbQF7ssET1QyWTxY/YJjwrT6wmZ99omaKgitVj1k6nt1sP7GS/NJjdLicPuz4CgH
 FtQRexFWHD9hct5puPKpbUxC/GOvY9f9gQvxNt23m/U5HEnEwghrbek8FHB9xj7rfI2F
 8gCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775028444; x=1775633244;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7GMiCfMQvlQASFFq+WsdvEPLNPcgoyaFOU1CUCJmjxI=;
 b=DoQ4kapUiP77RkxXR9irZRK2lpEJzho+NiWbZTUMXiOT+FkoFAFeDlCF7hDFWGskR5
 bWYVOB+5FcI1rUDMmhITY+VSpVditDpetqqYWSDC9840uvg2SBwY+Rk4yXLigv1lczf9
 ZUHqKaEyvKkxZVwXGm8a1yL5ASeFYisnJGbBGct01T4Wa6WNyEJtTT9MQ8evv1cJ4Pkz
 40LOglRtEodoEGahwl2yAWeNvg0vNWRLFWXxjjweGO3yMJ+F8/7mgyddpEy/6hSErGJ9
 ks3/GcY5D6CT+T4o5jDooRmqO7UiRLyahOwg4gXkmnUrSefSK9CtA/cq4uAWsikhvE3Z
 X8Dw==
X-Gm-Message-State: AOJu0YygQ7zMm8Xk6b/3ms6z+bDqJ1BlZ6yZ8uYx7PfO2QuGbD6UBlPv
 YnlCsrCfHUiM8ipGbLf41k13KGDGwT0+eEyjdGvwsNHzKTgM8HysGf07JEBnsOyB/OKeMwsmr5r
 BJccoo8EL65XoCvpGQPFHHH6I9ZxdQrwClnKosO3HCuIxHehGHThjSOdPVM+gnmBUCxFYY+k=
X-Gm-Gg: ATEYQzw0jImH7GBA+HfHFd74kRzYjsDSUEtDkCsZvh+tH9uZe0Z6Oyy/2lEo3Euhw5g
 y3x6/NbnxvYbBe0XHLVq+pRsnbxwhcQycnADhJRItZJwn/4KW4I+dIkPmCZjj4piHAiLuCYZ0Uq
 SC8nEX+cvTyPvDQ5AlDSLSA+dAGCkkntutHzlqizGbw7cggpNyIJso76qkg8UdMDqSF2PEWLfuR
 s4Q37Pyes9LdsOFyBK6PRMOsMhFicUOykTJEnHOBzHnWpx6SCI5HcB+mctUljIo4Rfv7WncekpG
 rG0ggr3a5tphq27H/O06lV2053q4kwFVh610XbiwdFRUqHzkcF00tUdCfqxCXWFariSEDunamka
 peUkSaV4VzxrjYMTRxBpBuWKKWMKezcLAEm8emRUbkIXP7iJwZ43T1BZ5FG/AiiiEHtJy9sk2M0
 IwefwlzpjQ0wOv2ht0fSiKHP9Ggk1zBiAyucg=
X-Received: by 2002:a05:622a:5a9a:b0:50b:2875:fe26 with SMTP id
 d75a77b69052e-50d3bd9484fmr33488181cf.60.1775028442769; 
 Wed, 01 Apr 2026 00:27:22 -0700 (PDT)
X-Received: by 2002:a05:622a:5a9a:b0:50b:2875:fe26 with SMTP id
 d75a77b69052e-50d3bd9484fmr33487901cf.60.1775028442363; 
 Wed, 01 Apr 2026 00:27:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cb9f31972sm8638421fa.12.2026.04.01.00.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 00:27:19 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 01 Apr 2026 10:26:36 +0300
Subject: [PATCH 17/19] drm/panel: add driver for Waveshare 8.8" DSI TOUCH-A
 panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-waveshare-dsi-touch-v1-17-5e9119b5a014@oss.qualcomm.com>
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
In-Reply-To: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7876;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=th1gZiG+uiTFjdqPeLSNpZDrwBrXUjsQq3S47bfFVWg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpzMit1KFTklyVChksefN2NxG+SAGMFBbH3NSTk
 0JbMpWKXf+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaczIrQAKCRCLPIo+Aiko
 1VDsB/0YT9nMHpMgUBSQt0GOsp/uBKd/ZKTfj/+pk3Wq+jculDzyCppGpEsqS9PgLPKNtWmlABy
 RyvxMvUFdrJ5xAlqKsDSLxiXozWpU3Aw6IMT4i39tjdR1KzmLEhulLM+jMyVCeTHLtVIEUzsSmk
 64OCWCSAE8qDJk3iO9LROJvmee3VTviURbXI5puWlptLHn6Nsg9lYdAysZ73Qmk1LwsqTtwcZ96
 9Sw/PIr8m3CuUanzyT2Ywj4uBnRsGzdpt3+mKdLmMOR2NWHK4dPdu5yPs5jt70fu9xwu/DqamqM
 tx+1P4CE2rZpv7/l1nbwWzINIeRFXimKHHflgOILaBEVXXtX
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: 1QlXvmTq1m6PqwXekaPWdK4GWnUqleeQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA2NCBTYWx0ZWRfXy5xCcDDbSYsx
 1dbDTxxduKG5V53RGIF6ZR74tLD9NPdmFu/4pP4ecn5lE5HEfZROnSMP5gY2tzO0yzzk0NRxx4K
 r4kbAX1ow2UAkt3QgPbvm1Zq6whgPb7r7H1nVmNZqbmb/XSEI/Olx4Zdj2xXzWKoj0Viu1kg1PN
 0+Gqw6egzayJ31blFODu4/pPuZdXk+AF+ZoKmu7g9P4f4MLJCVIazHxS3C/N7LlUhAKscQte8fD
 QIV09v5r7F+Ul8fjgYYOEcntu+lxALOYUkq2nhW3qXPSgYIJK5EEctfTN+tVjE1n7vtJ7x7zDA9
 HfdymKSMGnXCXXMBNamSi9AfilZ8WK3rWgoI0h6vPjBkMGuu/d9BsEKiiiF9/JXxnI82zt0zI1s
 +8hWh73YYTxW14fV4ahq5/hzmn6AYdcCqfH6zTX103xt66K2rN9zPK6j+4YqXWRqtIoPb+zTzSx
 rXKRxHsWR4kYHwTIguw==
X-Proofpoint-ORIG-GUID: 1QlXvmTq1m6PqwXekaPWdK4GWnUqleeQ
X-Authority-Analysis: v=2.4 cv=PoGergM3 c=1 sm=1 tr=0 ts=69ccc8dc cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=EevSAkNhRZFgIoKfYqQA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010064
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

