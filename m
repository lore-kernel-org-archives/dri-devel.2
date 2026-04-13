Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6909F34C55
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 14:06:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05B2110E49F;
	Mon, 13 Apr 2026 14:06:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FrycF7jE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jLtQzkxG";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E248710E49C
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:06:24 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DDXW87479867
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8LKKLDk/nGutkoYnIlWHeYdiYX58VLqnbBajsoZj2yQ=; b=FrycF7jEDSNkQOIX
 LWGVCkHStfEAfvFYM9Wfl3NK0OETS/GHjvtrzv/A0kPLC0qBhTs5kJin9f1cY1Y2
 4YAFZxCTX2Y0lAhz+YzzIweGWEGH22+RVqr8PA/FKXP6MiIUP6rmhJtcgSkQg+a7
 xJrvThsBQOy4rlekAm1yFBif7wbqZt6FnXnLonbwjhKISPt/uEwbumWuWCVjOPFK
 zkkOhQVnTuzqfRsvHQMPv7KDNvaumuELeo1VenIFUEf+SxGTU2dgOPalS4x8PcYh
 zyYVAYagHnxnLS18DHdS9imYWlmMDTghZu/gu16WNHrMh7IU8l4wKE5qELFvrTm7
 MJCAUw==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dguuj9dqs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:06:24 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-47545742ec3so5278071b6e.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776089183; x=1776693983;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8LKKLDk/nGutkoYnIlWHeYdiYX58VLqnbBajsoZj2yQ=;
 b=jLtQzkxGJTr+a7rD9zSKBGm+XBtoBUl1d7S/h853S61U+UizfXD78X86lywO+mi0pY
 6A5l+dvxrS72uB/6Zl0QrUmTpGfq+xAdV0pkqSmT+C6aNUcsKwZFLqiGq+oaQr3l0e1p
 A5mO+WyeQ9LFrHbnjJJOIkwITmvpJMXz13bwAR+W8V17+rWbWEFRf9dZSeNwbk1kgsqG
 f/4UmAxrymxk1ll5J7TCL3+XAXwCU1lmWUQ43XrM9JxLHPjHXEO236tKdwEIGTqrGCua
 LsAtS30HOm/PoQf1p0b3rK2TymmCbHJNIJcTgq4fhwJPjHNiC27R0MKi55LBqZOeTYDt
 kUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776089183; x=1776693983;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8LKKLDk/nGutkoYnIlWHeYdiYX58VLqnbBajsoZj2yQ=;
 b=W8z5t7wYBfrGa5kUp5ewIlMU48w5fIEq3m7ilHhKR8aCVUXiADCNaMehABKZjfS+bb
 QJ5YCtvG67nzraxK04ernmZea5PYpedghsJxzTwdF+NxH8BbvoqxeGklwanaW11JVfP4
 queCK5yyRNSV4kVJacPHiKh/izCJMJAZtEVS2K5nyPIOQgAF7yQ55v0iOutPcobtrUrD
 HdYxYWQY4XqBgeRfRtBDgK94ePbmmkm23jGBg6bO00id8uCw4zKUFmS9AKb44Bm7NiTi
 d9LJ9k+NDRBEWvXayZD/1GfsH70BSZVXGhYMTrsuiAeuzY0O/JWBUIgI77M8RH+IiauJ
 DUpw==
X-Gm-Message-State: AOJu0Yw75TIZA9vW1Wf8zIulQw+/Qxls5QYNUxiO9jLWyAdkW1QdhtsY
 F8h1gpYEsfiCysDpPHNqBRibc1KvdFCd6aAkyqQgh+lslyp/DWptpBPAmilpXQRhM0UxlXkM5OT
 DCqK/qI94RYF+BYpK+CAYJtBKd2vVzJ6zJWoxGMUTD4s+p+LnZuyALCEeKKAkC5asSceAMkk=
X-Gm-Gg: AeBDiev5xjMjXNWDqyUJEzAqGVavpgW2AZBgu3LcZkHQJahGLvK8pOi96uXxsqjAts9
 E+nS/w++Zb2qc6RjiDB3G52JrUfI56cay44JgppQawqjZHHpxNv9umv9ES4v0pdgcO8znGz9y9i
 ZGFrGzR5OPiLiuLJJ2BcUxSrW1VA75tuJ+x1yr1m9bqeYByKNctyWYVIUyTcUi37N3yVmSHavhj
 db4iyj6Om9yXSozHQ2SZ3sWIzDGkGPGAsXsQqoKM8VTE2ChEMvtfYmL6dJw1lNYJpbEhw5OqgXl
 oOCyeiXkGlnJwUxAxtRnceBy29QLbeV2NdIJrCbc39o4DmSyWBeoK3bO0TXQmec2dhEp+d5LStZ
 0zey10fI5nLI5QpLG0JbzZb5GQQmbQ910MVBuEFtqaCxDhB27+aj6zPHrv0P0cOFE8oUBM3Iz7i
 d7rlyKJy0eTLChn5kVRbRRV3ik+8y8fivpqKc=
X-Received: by 2002:a05:6808:660b:b0:467:58e:5d6e with SMTP id
 5614622812f47-4789f60519cmr6343872b6e.30.1776089183297; 
 Mon, 13 Apr 2026 07:06:23 -0700 (PDT)
X-Received: by 2002:a05:6808:660b:b0:467:58e:5d6e with SMTP id
 5614622812f47-4789f60519cmr6343819b6e.30.1776089182771; 
 Mon, 13 Apr 2026 07:06:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eee8c91csm2687521e87.19.2026.04.13.07.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 07:06:21 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 17:05:42 +0300
Subject: [PATCH v3 19/21] drm/panel: add driver for Waveshare 8.8" DSI
 TOUCH-A panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-waveshare-dsi-touch-v3-19-3aeb53022c32@oss.qualcomm.com>
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
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=8361;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ME4roFLF5kQS3ILE+qVmFR5ny/0HVBFtJjwmIHIWOBw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp3PgpLEhsqxoLgLo3jbYp7nEh2ZBpLYh/4SK12
 4yCFP0QstiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCadz4KQAKCRCLPIo+Aiko
 1XTRB/0U4axfmYExh+0IkahMe1OYpyHDQdRsGD8dI4V0s7G/q68sghoH1RC7a9e6sFOtYXMwghb
 MenUT7wsNkxEShmOBkIFWKv1NkBL+8x1Ir6zRKhfRAr3T8xcd28xsFHkN9JR7esKltz+ODuNj2O
 QMZg2oiZzHEa6RyBlW0R5emeNZGRiMZ95bUVTAYPGgvnmw51X8F7wGXbQ3qxmiGLnYehI82mdfW
 XnZowAoMJ9z4j0ay1D8UYaSA5Ql7sXxpGYdAna18ybuVkhcE/Pvt4kYp/yCApRTgCsyvbrLUo9+
 TCYe5ieK+ckMWs9QapsFC4lZCAc1KgBFzeUeMApyTbhT8JGS
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEzOCBTYWx0ZWRfX/XB8Poern8Iz
 wySRFAnBvwOPmTo3EOgip2cSSimJTh0aVzYVfTvG7YYiiQ5Sofq0LFnTrixPSsJjb0wlQayBul8
 BnIYJVub9Jr16nCoaeuTuuPz25s0Jbwv4K1CL02GQTbcATWLGY7TXTl/EpYKPLlbGLBvTnkvnui
 GVqZ9nsj4ohrILqZVoa81394KJCMvIeGQZXwyL5FHAfVaFQG0PS5IA7+QnsQWHHl2q5TrYWk5RT
 g4MrkrBoDNtF0nnp9gDQUgLoLUS/oUBqkTyG4ifqyQHJZVoD9Iu6U8zmBCoo9lIYExDMVFKsRP/
 sLoODlqwt4ayOmIOuW5nAXwqk7y7n2VZChXtaDKkt+9qynKFA9HVf/4ODpZIkEyUBc6JPjRvx7Y
 emPLWujlp5K/wIQEJru0VBFMAia8ZA1sufrUFeHRLZgdmhl5oW56JZj0XUaReMTV8ONxIZVNOwn
 K8kJuI/F/NlE8pLmIvw==
X-Authority-Analysis: v=2.4 cv=c/ibhx9l c=1 sm=1 tr=0 ts=69dcf860 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=I0FmcsL6nTCMfcQUCV4A:9 a=QEXdDO2ut3YA:10
 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-GUID: hIZ3-_5RB1aYkHAzIr2D2g7fGyeIgF2O
X-Proofpoint-ORIG-GUID: hIZ3-_5RB1aYkHAzIr2D2g7fGyeIgF2O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0
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

Add driver for the panel found on Waveshare 8.8" DSI TOUCH-A kit. It
uses ota7290b IC as a controller.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/Kconfig                    |  12 ++
 drivers/gpu/drm/panel/Makefile                   |   1 +
 drivers/gpu/drm/panel/panel-focaltech-ota7290b.c | 226 +++++++++++++++++++++++
 3 files changed, 239 insertions(+)

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
index 000000000000..8c135697a0fd
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c
@@ -0,0 +1,226 @@
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
+	struct regulator *vdd;
+	struct regulator *vcc;
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
+	if (ctx->vcc) {
+		ret = regulator_enable(ctx->vcc);
+		if (ret)
+			dev_err(panel->dev, "failed to enable VCC regulator: %d\n", ret);
+	}
+
+	if (ctx->reset) {
+		gpiod_set_value_cansleep(ctx->reset, 0);
+		msleep(60);
+		gpiod_set_value_cansleep(ctx->reset, 1);
+		msleep(60);
+	}
+
+	if (ctx->vdd) {
+		ret = regulator_enable(ctx->vdd);
+		if (ret)
+			dev_err(panel->dev, "failed to enable VDD regulator: %d\n", ret);
+	}
+
+	if (ctx->reset) {
+		gpiod_set_value_cansleep(ctx->reset, 0);
+		msleep(60);
+	}
+
+	if (ctx->avdd) {
+		ret = regulator_enable(ctx->avdd);
+		if (ret)
+			dev_err(panel->dev, "failed to enable AVDD regulator: %d\n", ret);
+	}
+
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 120);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 50);
+
+	if (dsi_ctx.accum_err < 0)
+		dev_err(panel->dev, "failed to init panel: %d\n", dsi_ctx.accum_err);
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
+	if (ctx->avdd)
+		regulator_disable(ctx->avdd);
+
+	if (ctx->reset) {
+		gpiod_set_value_cansleep(ctx->reset, 1);
+		msleep(5);
+	}
+
+	if (ctx->vdd)
+		regulator_disable(ctx->vdd);
+
+	if (ctx->vcc)
+		regulator_disable(ctx->vcc);
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
+	ctx->vcc = devm_regulator_get_optional(&dsi->dev, "vcc");
+	if (IS_ERR(ctx->vcc))
+		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->vcc),
+					"Couldn't get our VCC supply\n");
+
+	ctx->avdd = devm_regulator_get_optional(&dsi->dev, "avdd");
+	if (IS_ERR(ctx->avdd))
+		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->avdd),
+					"Couldn't get our AVDD supply\n");
+
+	ctx->vdd = devm_regulator_get_optional(&dsi->dev, "vdd");
+	if (IS_ERR(ctx->vdd))
+		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->vdd),
+					"Couldn't get our VDD supply\n");
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

