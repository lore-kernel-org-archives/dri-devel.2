Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CCECC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:20:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C6B510FE9F;
	Wed, 14 Oct 2026 16:19:54 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CCFD10FE73
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:19:43 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEcXc73209374
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lg+1X4UYycQbuXmzsYAi8MUBS2vFlH2X0853yKqWlqo=; b=gAsesR7wNSCgohsR
 TYio3YkLTjnf8b58W2sQ8voyKIoNCd58lxkMXAe6EMRSsRSfkoXUZFM89/6RHe3m
 72wOZAY9uX01usm4+NOH1lEUfoq21icTT9WkWHw4uyLSWIVOJ+TkaTRLkaB4WEHg
 3y/WuNSQYYLrSUUTqWIdodHdZHREdkdxSl5hgHT4NuL+so0RsS0LEC3gVvtl39yS
 5Dq/+swe8E29zoXlnSBW0DMyknaGgw7sxOuJ6J59w3ExXqJQ7dJnVzRLrZSWI+Jq
 2QVgRxIC+bvZsU3WmocvH+yE35BqLiOSqQp0RNg5LjRqsI8qJHNRMfc/V4/Zma3V
 5RgCZg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9ud6ccrt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:19:42 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5338c215ed2so8623291cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 09:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791994780; x=1792599580;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lg+1X4UYycQbuXmzsYAi8MUBS2vFlH2X0853yKqWlqo=;
 b=M1odzAOx8DXBf39o8gQSwhGjfy/omUp5+qtKmhwN+3CgNePx2L4nSCS4N1wFDELpvh
 Yd9imiHkG5DpQ5lgbgaIpHyJBjLJGYpcBlUw6RK0BvUeew34VE+Yx1A6qjmRbB1zuf9W
 r9P46/tcDCdQesGSVKuLaU74EUcIXCydgenEYfETFm1PsKy0Ci9fG9CGRVWsEZZ0E4z7
 VZVlCe9Sj56B+JSdF9g3bYfNZbaegsJnWEsyoIPICiZFqKNPfsZN6o0RLsg9AKdAXUq3
 lJgYDShFYqMITut5eZMbv70ERpYQJ7NgjHJfjC+3E1hClFAwDCDbyBy975j2/dHpk41U
 bavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791994780; x=1792599580;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lg+1X4UYycQbuXmzsYAi8MUBS2vFlH2X0853yKqWlqo=;
 b=fZ44W8TvTDG/7WUrRQKfT5DvxTnuiBWYR+dj4SqHK3GXIH9fF2Nv3UK7SjxZHL/Kft
 SMhL+oNIhjnEIGawEsaB+MsRSJadugpus1jA9Wpd4Kx7uFhHFOQlV2bxPI+XdrwCgCUY
 t64ejYJ2ip1OgfEbLOFX3sNHyOzO+Lz48RX7l7yHc+/m9Yp2RjWq08HHaOqHTSvfRMTU
 hWLnLN2Zt92EtJTRIdGP9xQ+qMtPz0hB+jJCBp9eo0LJpkyzRdRzWzFbeVGRkSFz/X2E
 IEV2IJRfxcnAgiHlUsUhVVUhffz4doGtm4sEM+XydJmYeDaqk3LPaGST45i2fiJPnTJt
 7USw==
X-Forwarded-Encrypted: i=1;
 AKwUvByBc5qCACIVHMKjxvUnysQqaHzVxcO9L+gZThYtJ9gG66QhFjjsPXx5IOPUVqyWTdmqU2ssm/16QQQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLFPOW2WGzrWTHP1Tvg//Xr0PdfXtFwxd/LBs41QEHTHA3saDYU
 91egFKtezz5NhepYhAwAS6Qdbwx7tzLoVKY1Y3EaQQVTYq1b/CNsk9y9FOimXeadSu2O544JksS
 JGmTWAwmPYUO4aCCXv8BNzg7znabN6ac77HBoMMcbjv25PxmgjHMljo10tqAiHPmxZpZvQN+3tF
 jjRKA=
X-Gm-Gg: AYBFou31BFxp9ocBnBOA65TtkEUuxZf0L/OQc+d54aC03vlZXq7u8fnAHCPkuQtfa05
 W+5L1eQ1Fw1QEGokMdpOFcuC6oAkxOShvcOD5ytFchDoUlJORSPjvMjoamswFfJwJpc4yqu86MB
 DTpfv43YZOg7VR+gt8eRbFLaEpqI1o/CIz7fX4cq6qwWveMrSasC5sw05ZUjNVNWS9QQ3HQ/gye
 fjN2UTsWvTyLKq+Owp2luIJcNw6oXo/xK49ErWq806KVi8vaX8auSyBv8nroHtg17IVHYEQ2v4H
 1iIYuNhm8bJdLmX+T+Jke4raxaK6VKy0YoarCfebeglrXHWrbs3VIjz+KdJzOZCewBS35VkseiW
 zModHO56mPyopJoA43IY6z7nHd7epz+JdSwDvjmSowD/LHu8zPNIjOvuj0lyOVUNAPzcmeuJmqR
 DP6syUTN/c6Yr/
X-Received: by 2002:a05:620a:a2d4:10b0:93e:c06a:7313 with SMTP id
 af79cd13be357-93ec06a770emr1800874985a.13.1791994779442; 
 Wed, 14 Oct 2026 09:19:39 -0700 (PDT)
X-Received: by 2002:a05:620a:a2d4:10b0:93e:c06a:7313 with SMTP id
 af79cd13be357-93ec06a770emr1800871485a.13.1791994778850; 
 Wed, 14 Oct 2026 09:19:38 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5be33d7d0f6sm740187e87.38.2026.10.14.09.19.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:19:34 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 19:19:17 +0300
Subject: [PATCH v2 2/5] drm/panel: add Novatek NT36850 panel driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-sdm845-hdk-v2-2-6d0b4b42f267@oss.qualcomm.com>
References: <20261014-sdm845-hdk-v2-0-6d0b4b42f267@oss.qualcomm.com>
In-Reply-To: <20261014-sdm845-hdk-v2-0-6d0b4b42f267@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Abel Vesa <abelvesa@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12704;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=gNSjtWnwOazIK6fgq6t4zU0pyYhpFF9yVvxIZkgA79w=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqz6uHc7ofGfbYllRImxVsYMv/vacn1aZaf+E1S
 FMZi7DzYpeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCas+rhwAKCRCLPIo+Aiko
 1QnrCACpbcaDBZpc6wD8enlzlZxHMHlYR4zvVU6e25Kejgoyl5RcXiyLSi1l5lLZuz4EIrHw0j+
 LBwLABifMyuAWHPSyOIh37VVqQ8hJrg9CLqXK2IPh6X5D9gAxaHCY0ZUIWTBzX5Xx1d4CjjwFYb
 VT+bPNgxW9IrOxOleZGUFbOi3Ju8TD7NXVtLPWfqCwJCXrLgvusZwK6kwguBKkn2co3e/jZohak
 rIC0gsmedHbpuygI+lvS2x9X79d2KtsQehSZPC5+OHOAWX/ywp7bpLMIcblCVyNJT3B/wu7MS3e
 9A+Sv8cW8bY9T26sGCOJzNbFgXjBPqmlowcWKnc7bTFqmzlc
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: EDmBYhPRiRIBWrUXzhQLrtHYYizuWp2J
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NCBTYWx0ZWRfX7ldWl64FHCQE
 4iTTqpY59PsdE4ukIf+xzR7BewMeh8NDdo7FcIfr5i64HpU0PBC+dJskRdOSq77x8dDl5XYuJ1O
 ntYoS91QP+TyAh6w9yCiYPgQXQ+GW3g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NCBTYWx0ZWRfX9zKskJFepjbB
 z+MYw9iRvorssBQYuP0Ps+6fGz4+U22LuUURWBTpSlTK1MCtqezDxzYvu9Hz6s5SbFLyHXzWIdn
 j3WpkTdBX7UXrWE52cQOJQZNDm7VpOWOuUV30b6aoDd7oh73z2tc2k1i96EujfGlmc79YsBEYpp
 oLoZXGWBUr7w4o3tW2q8tOn7SQccH0wMBHFZo46ErUGv28PFmKoADBnHsDIRmuTKgMbwBd2BcF1
 MZCSPyLsuXCs+pGJgi0dMNIG7hkzv+NR5YSgwIJu1pxpThswYWlElNIZ1gtiG1rCGUHQmuW+CVb
 o9Aa4Wrn4zeHo/NNL0m8g0+Fp4LYH3S7kTQkxtRmlWj4vKHK/XapYpIpPmIGLWZ6rKicwZrrXsU
 bZzlK0SzS7N/R4IhAFPNoaNezphHak/XFDCcP9d359wqS3J2QTzx+IGdGpSoUQ22EIxd2JR1HQn
 RNsBet2ZBxQL9MEekJg==
X-Authority-Analysis: v=2.4 cv=fJ6sTpae c=1 sm=1 tr=0 ts=6acfab9e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=Avzf8x2XDEdYhfZFVJMA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: EDmBYhPRiRIBWrUXzhQLrtHYYizuWp2J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140064
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

Add support for the Truly WQHD dual-DSI command mode panel built around
the Novatek NT36850, found on the display card for the Qualcomm SDM845
and SM8150 HDK. The driver is based on panel-novatek-nt36523, the power
and command sequences follow the vendor device tree.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/Kconfig                 |  10 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-novatek-nt36850.c | 343 ++++++++++++++++++++++++++
 3 files changed, 354 insertions(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 53a1fc2913fe..869a5501e709 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -723,6 +723,16 @@ config DRM_PANEL_NOVATEK_NT36672E
 	  LCD panel module. The panel has a resolution of 1080x2408 and uses 24 bit
 	  RGB per pixel.
 
+config DRM_PANEL_NOVATEK_NT36850
+	tristate "Novatek NT36850 panel driver"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y here if you want to enable support for the panels built
+	  around the Novatek NT36850 display controller, such as some
+	  Truly panels used in Qualcomm development kits.
+
 config DRM_PANEL_NOVATEK_NT37700F
 	tristate "Novatek NT37700F DSI panel"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index f2c9c80a218f..8dd8eb7080cb 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_DRM_PANEL_NOVATEK_NT36532) += panel-novatek-nt36532.o
 obj-$(CONFIG_DRM_PANEL_NOVATEK_NT36536) += panel-novatek-nt36536.o
 obj-$(CONFIG_DRM_PANEL_NOVATEK_NT36672A) += panel-novatek-nt36672a.o
 obj-$(CONFIG_DRM_PANEL_NOVATEK_NT36672E) += panel-novatek-nt36672e.o
+obj-$(CONFIG_DRM_PANEL_NOVATEK_NT36850) += panel-novatek-nt36850.o
 obj-$(CONFIG_DRM_PANEL_NOVATEK_NT37700F) += panel-novatek-nt37700f.o
 obj-$(CONFIG_DRM_PANEL_NOVATEK_NT37801) += panel-novatek-nt37801.o
 obj-$(CONFIG_DRM_PANEL_NOVATEK_NT39016) += panel-novatek-nt39016.o
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36850.c b/drivers/gpu/drm/panel/panel-novatek-nt36850.c
new file mode 100644
index 000000000000..6956ec7263fb
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36850.c
@@ -0,0 +1,343 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Novatek NT36850 DriverIC panels driver
+ *
+ * Copyright (c) 2022, 2023 Jianhua Lu <lujianhua000@gmail.com>
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries
+ */
+
+#include <linux/backlight.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_graph.h>
+#include <linux/regulator/consumer.h>
+
+#include <video/mipi_display.h>
+
+#include <drm/drm_crtc.h>
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_of.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_probe_helper.h>
+
+struct panel_info {
+	struct drm_panel panel;
+	struct mipi_dsi_device *dsi[2];
+	const struct panel_desc *desc;
+	enum drm_panel_orientation orientation;
+
+	struct gpio_desc *reset_gpio;
+	struct backlight_device *backlight;
+	struct regulator *vddio;
+	struct regulator *avdd;
+	struct regulator *avee;
+};
+
+struct panel_desc {
+	unsigned int bpc;
+	unsigned int lanes;
+	unsigned long mode_flags;
+	enum mipi_dsi_pixel_format format;
+
+	const struct drm_display_mode *mode;
+	const struct mipi_dsi_device_info dsi_info;
+	int (*init_sequence)(struct panel_info *pinfo);
+
+	bool is_dual_dsi;
+};
+
+static inline struct panel_info *to_panel_info(struct drm_panel *panel)
+{
+	return container_of(panel, struct panel_info, panel);
+}
+
+static int truly_wqhd_init_sequence(struct panel_info *pinfo)
+{
+	struct mipi_dsi_device *dsi0 = pinfo->dsi[0];
+	struct mipi_dsi_device *dsi1 = pinfo->dsi[1];
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = NULL };
+
+	mipi_dsi_dual_dcs_write_seq_multi(&dsi_ctx, dsi0, dsi1, 0xff, 0x10);
+	mipi_dsi_dual_dcs_write_seq_multi(&dsi_ctx, dsi0, dsi1, 0xfb, 0x01);
+	mipi_dsi_dual_dcs_write_seq_multi(&dsi_ctx, dsi0, dsi1,
+					  MIPI_DCS_SET_ADDRESS_MODE, 0x00);
+	mipi_dsi_dual(mipi_dsi_dcs_set_tear_on_multi, &dsi_ctx, dsi0, dsi1,
+		      MIPI_DSI_DCS_TEAR_MODE_VBLANK);
+	mipi_dsi_dual(mipi_dsi_dcs_set_tear_scanline_multi, &dsi_ctx, dsi0, dsi1,
+		      1000);
+	mipi_dsi_dual_dcs_write_seq_multi(&dsi_ctx, dsi0, dsi1,
+					  MIPI_DCS_SET_DISPLAY_BRIGHTNESS,
+					  0xff);
+	mipi_dsi_dual_dcs_write_seq_multi(&dsi_ctx, dsi0, dsi1,
+					  MIPI_DCS_WRITE_CONTROL_DISPLAY,
+					  0x2c);
+	mipi_dsi_dual_dcs_write_seq_multi(&dsi_ctx, dsi0, dsi1,
+					  MIPI_DCS_WRITE_POWER_SAVE, 0x01);
+	mipi_dsi_dual_dcs_write_seq_multi(&dsi_ctx, dsi0, dsi1,
+					  MIPI_DCS_EXIT_INVERT_MODE);
+	mipi_dsi_usleep_range(&dsi_ctx, 10000, 11000);
+	mipi_dsi_dual_dcs_write_seq_multi(&dsi_ctx, dsi0, dsi1, 0xbb, 0x10);
+	mipi_dsi_dual(mipi_dsi_dcs_exit_sleep_mode_multi, &dsi_ctx, dsi0, dsi1);
+	mipi_dsi_msleep(&dsi_ctx, 120);
+	mipi_dsi_dual(mipi_dsi_dcs_set_display_on_multi, &dsi_ctx, dsi0, dsi1);
+	mipi_dsi_msleep(&dsi_ctx, 120);
+
+	return dsi_ctx.accum_err;
+}
+
+static const struct drm_display_mode truly_wqhd_mode = {
+	.clock = (720 + 120 + 20 + 140) * 2 * (2560 + 8 + 4 + 20) * 60 / 1000,
+	.hdisplay = 720 * 2,
+	.hsync_start = (720 + 120) * 2,
+	.hsync_end = (720 + 120 + 20) * 2,
+	.htotal = (720 + 120 + 20 + 140) * 2,
+	.vdisplay = 2560,
+	.vsync_start = 2560 + 8,
+	.vsync_end = 2560 + 8 + 4,
+	.vtotal = 2560 + 8 + 4 + 20,
+};
+
+static const struct panel_desc truly_wqhd_desc = {
+	.mode = &truly_wqhd_mode,
+	.bpc = 8,
+	.lanes = 4,
+	.format = MIPI_DSI_FMT_RGB888,
+	.mode_flags = MIPI_DSI_CLOCK_NON_CONTINUOUS | MIPI_DSI_MODE_LPM,
+	.init_sequence = truly_wqhd_init_sequence,
+	.is_dual_dsi = true,
+};
+
+static void nt36850_reset(struct panel_info *pinfo)
+{
+	gpiod_set_value_cansleep(pinfo->reset_gpio, 0);
+	usleep_range(10000, 11000);
+	gpiod_set_value_cansleep(pinfo->reset_gpio, 1);
+	usleep_range(10000, 11000);
+	gpiod_set_value_cansleep(pinfo->reset_gpio, 0);
+	msleep(50);
+}
+
+static int nt36850_prepare(struct drm_panel *panel)
+{
+	struct panel_info *pinfo = to_panel_info(panel);
+	int ret;
+
+	ret = regulator_enable(pinfo->vddio);
+	if (ret) {
+		dev_err(panel->dev, "failed to enable vddio regulator: %d\n", ret);
+		return ret;
+	}
+
+	msleep(20);
+
+	ret = regulator_enable(pinfo->avdd);
+	if (ret) {
+		dev_err(panel->dev, "failed to enable avdd regulator: %d\n", ret);
+		goto err_vddio;
+	}
+
+	ret = regulator_enable(pinfo->avee);
+	if (ret) {
+		dev_err(panel->dev, "failed to enable avee regulator: %d\n", ret);
+		goto err_avdd;
+	}
+
+	msleep(20);
+
+	nt36850_reset(pinfo);
+
+	ret = pinfo->desc->init_sequence(pinfo);
+	if (ret < 0) {
+		dev_err(panel->dev, "failed to initialize panel: %d\n", ret);
+		goto err_avee;
+	}
+
+	return 0;
+
+err_avee:
+	gpiod_set_value_cansleep(pinfo->reset_gpio, 1);
+	regulator_disable(pinfo->avee);
+err_avdd:
+	regulator_disable(pinfo->avdd);
+err_vddio:
+	regulator_disable(pinfo->vddio);
+
+	return ret;
+}
+
+static int nt36850_num_dsi_hosts(struct panel_info *pinfo)
+{
+	return pinfo->desc->is_dual_dsi ? 2 : 1;
+}
+
+static int nt36850_disable(struct drm_panel *panel)
+{
+	struct panel_info *pinfo = to_panel_info(panel);
+	struct mipi_dsi_device *dsi0 = pinfo->dsi[0];
+	struct mipi_dsi_device *dsi1 = pinfo->dsi[1];
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = NULL };
+
+	dsi0->mode_flags &= ~MIPI_DSI_MODE_LPM;
+	dsi1->mode_flags &= ~MIPI_DSI_MODE_LPM;
+
+	mipi_dsi_dual(mipi_dsi_dcs_set_display_off_multi, &dsi_ctx, dsi0, dsi1);
+	mipi_dsi_msleep(&dsi_ctx, 120);
+	mipi_dsi_dual(mipi_dsi_dcs_enter_sleep_mode_multi, &dsi_ctx, dsi0, dsi1);
+	mipi_dsi_msleep(&dsi_ctx, 120);
+
+	dsi0->mode_flags |= MIPI_DSI_MODE_LPM;
+	dsi1->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	return dsi_ctx.accum_err;
+}
+
+static int nt36850_unprepare(struct drm_panel *panel)
+{
+	struct panel_info *pinfo = to_panel_info(panel);
+
+	gpiod_set_value_cansleep(pinfo->reset_gpio, 1);
+	regulator_disable(pinfo->avee);
+	regulator_disable(pinfo->avdd);
+	regulator_disable(pinfo->vddio);
+
+	return 0;
+}
+
+static int nt36850_get_modes(struct drm_panel *panel,
+			       struct drm_connector *connector)
+{
+	struct panel_info *pinfo = to_panel_info(panel);
+
+	connector->display_info.bpc = pinfo->desc->bpc;
+
+	return drm_connector_helper_get_modes_fixed(connector, pinfo->desc->mode);
+}
+
+static enum drm_panel_orientation nt36850_get_orientation(struct drm_panel *panel)
+{
+	struct panel_info *pinfo = to_panel_info(panel);
+
+	return pinfo->orientation;
+}
+
+static const struct drm_panel_funcs nt36850_panel_funcs = {
+	.disable = nt36850_disable,
+	.prepare = nt36850_prepare,
+	.unprepare = nt36850_unprepare,
+	.get_modes = nt36850_get_modes,
+	.get_orientation = nt36850_get_orientation,
+};
+
+static int nt36850_probe(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	struct device_node *dsi1;
+	struct mipi_dsi_host *dsi1_host;
+	struct panel_info *pinfo;
+	const struct mipi_dsi_device_info *info;
+	int i, ret;
+
+	pinfo = devm_drm_panel_alloc(dev, struct panel_info, panel,
+				     &nt36850_panel_funcs,
+				     DRM_MODE_CONNECTOR_DSI);
+	if (IS_ERR(pinfo))
+		return PTR_ERR(pinfo);
+
+	pinfo->vddio = devm_regulator_get(dev, "vddio");
+	if (IS_ERR(pinfo->vddio))
+		return dev_err_probe(dev, PTR_ERR(pinfo->vddio), "failed to get vddio regulator\n");
+
+	pinfo->avdd = devm_regulator_get(dev, "avdd");
+	if (IS_ERR(pinfo->avdd))
+		return dev_err_probe(dev, PTR_ERR(pinfo->avdd), "failed to get avdd regulator\n");
+
+	pinfo->avee = devm_regulator_get(dev, "avee");
+	if (IS_ERR(pinfo->avee))
+		return dev_err_probe(dev, PTR_ERR(pinfo->avee), "failed to get avee regulator\n");
+
+	pinfo->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(pinfo->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(pinfo->reset_gpio), "failed to get reset gpio\n");
+
+	pinfo->desc = of_device_get_match_data(dev);
+	if (!pinfo->desc)
+		return -ENODEV;
+
+	/* If the panel is dual dsi, register DSI1 */
+	if (pinfo->desc->is_dual_dsi) {
+		info = &pinfo->desc->dsi_info;
+
+		dsi1 = of_graph_get_remote_node(dsi->dev.of_node, 1, -1);
+		if (!dsi1) {
+			dev_err(dev, "cannot get secondary DSI node.\n");
+			return -ENODEV;
+		}
+
+		dsi1_host = of_find_mipi_dsi_host_by_node(dsi1);
+		of_node_put(dsi1);
+		if (!dsi1_host)
+			return dev_err_probe(dev, -EPROBE_DEFER, "cannot get secondary DSI host\n");
+
+		pinfo->dsi[1] = devm_mipi_dsi_device_register_full(dev, dsi1_host, info);
+		if (IS_ERR(pinfo->dsi[1])) {
+			dev_err(dev, "cannot get secondary DSI device\n");
+			return PTR_ERR(pinfo->dsi[1]);
+		}
+	}
+
+	pinfo->dsi[0] = dsi;
+	mipi_dsi_set_drvdata(dsi, pinfo);
+
+	ret = drm_of_get_panel_orientation(dev->of_node, &pinfo->orientation);
+	if (ret < 0) {
+		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, ret);
+		return ret;
+	}
+
+	pinfo->panel.prepare_prev_first = true;
+
+	ret = drm_panel_of_backlight(&pinfo->panel);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get backlight\n");
+
+	ret = devm_drm_panel_add(&dsi->dev, &pinfo->panel);
+	if (ret)
+		return dev_err_probe(dev, ret, "can't add the panel\n");
+
+	for (i = 0; i < nt36850_num_dsi_hosts(pinfo); i++) {
+		pinfo->dsi[i]->lanes = pinfo->desc->lanes;
+		pinfo->dsi[i]->format = pinfo->desc->format;
+		pinfo->dsi[i]->mode_flags = pinfo->desc->mode_flags;
+
+		ret = devm_mipi_dsi_attach(dev, pinfo->dsi[i]);
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "cannot attach to DSI%d host.\n", i);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id nt36850_of_match[] = {
+	{
+		.compatible = "truly,wqhd60-nt36850",
+		.data = &truly_wqhd_desc,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, nt36850_of_match);
+
+static struct mipi_dsi_driver nt36850_driver = {
+	.probe = nt36850_probe,
+	.driver = {
+		.name = "panel-novatek-nt36850",
+		.of_match_table = nt36850_of_match,
+	},
+};
+module_mipi_dsi_driver(nt36850_driver);
+
+MODULE_AUTHOR("Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>");
+MODULE_DESCRIPTION("DRM driver for Novatek NT36850 based MIPI DSI panels");
+MODULE_LICENSE("GPL");

-- 
2.47.3

