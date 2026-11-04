Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C69606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YQS/z7iv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NvP+OE3a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7242610E857;
	Wed,  4 Nov 2026 09:12:11 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F45D10E857
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 09:12:00 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A48KIiE918329
 for <dri-devel@lists.freedesktop.org>; Wed, 4 Nov 2026 09:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fWCd6aPQQe5Uc8iRyEMdNtozTg+e5xvHjtU+V9lBEuY=; b=YQS/z7ivRmx8wgMy
 9E0aN1mthavk/q1TCntqAlc+PTHLnCuSYLw2m+KUcdpYVOvXcP33FS4UZzZeUwgH
 1E++9FtB5o2Lp9zK5qkIlCZ2Py63as7bKm5rFgxdhLi8nx73PSWwDQdHo3e4+iES
 VwHQ/dO4Ma2oE8xdxX0YZ88W/TXr//a1cpDixc8yiEOm9t8q/ULZ14k+1Q6gVeWB
 OVrS3r8O3mZr2cACjgGV8A8a4cNu4Y/p6uor4sCaVcpPXSL66ILKQ8p7wWjp4dvA
 IatPum8TnV45XuiLwv3YnarPNjqUvqgLZ8c3txDEBse4XrAn93XtP73WmvmoUD8K
 uvoedA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqvsg9afg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 09:11:59 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ab2395f104so648122a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 01:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793783518; x=1794388318;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fWCd6aPQQe5Uc8iRyEMdNtozTg+e5xvHjtU+V9lBEuY=;
 b=NvP+OE3agVaoY3IAkYhUkx2r6K0NiRH5OT884N6E7+Tj612hR/Yi8I2VzuFQ6z5O4s
 AdHWgA1KSwM+QkRxPiIZN2ZwP5+ZummBispkiOgI9Wug42Yx9ITZQVVc4mV3T+2gUAgL
 60JsYksRFOM3h8pw0+NuW2nk9tAaDL3QS9BSE3fYKqGPRM0KP6nVb9FxisV+gzRfjK4e
 BdsIwSzh8LpfG+vsQ8NC2F71AY0nItwtpaeyqJCu6JYc19EzMlsobZpzNWXNuvLjSTDJ
 Mh+MUZqsuruM/kCTatXq7i6gUlUs/IUSqLZMVqqRiTvHkePGbmWoFlK0G+gz8i1aigWn
 /roQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793783518; x=1794388318;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fWCd6aPQQe5Uc8iRyEMdNtozTg+e5xvHjtU+V9lBEuY=;
 b=cZSJ5Pm0g2AjJBsbcxlpTrUoV/4xzDjtZvT12PwaG1Vfz7yU+KxZfGLowUL0pldz+G
 5IkTMt/SmBgKheFH0A4DoL8T+AbaS7GK6gcSHqhxR9BR9uGQm4GFb0vAfC2cZqq8z6uI
 ODlOfvZeErhbbxoo1cQ6uHESfELKqQ/LTnqN0FhEv4wca9IqUXFsYiv9vs9y9oGpEXUT
 znCESsNqOSccB9pUTGr7KmSkZXUGDKCYzTMm5XUUJa8EkW8J6Bgxc3+rjwptIwspeUTB
 6R4iGxqraDO5ufLm1txuxDrhkjCuctLJoVpTN+KDzVb+gmv3QTerVtgpbVWu+8xxIITd
 wTCg==
X-Gm-Message-State: APuU4Z+KzIB91eFjzoJp0YaQWijte54ff7V20KkGiBc8FM2ENcSy/Lad
 s9YP7kUpP59+x6JtRb/AqD5zKGMJWEd8X0WwHFjh+4oX4Btc3ib7nVeVzQhUyT3s093nzW6FvQF
 LFAr39IRJ8jZO+/S6QcLQnjkuBc3uUCMOYfRnTS2cjeC1n+eRx4901Tk6in5Wh7IiGwZfM4k=
X-Gm-Gg: AYBFou2Bc78Emk2cmV8Dj6i3v8TXIZ8GoUC5rvHW+O0/Xm2IDCJ2GeRp/PGdwyHFU3N
 o9dzh94SrJJzMEZOPIFc0rO8FMgFY0V0q38TwV8Bfj1vRmk1tUT2I/VW4jd1yLFKdDv+QSzNYll
 R/7EWvjbN0g/M4VKUZZjmbg/xaZ+QTCjTn8+ZD4jxbqZeecd/wrQ+7O18O/EydP0Z7vc5CCs3De
 n7OyIWR0II/Alr8SFcbbs4VP2PK1WbEraXlRIUENVkuzojCqhnIc6xikamEd/Ak3YCNrmH47gKG
 uNhNdU54DXvkP7smF/8MA5FGmvlqYaw7v9GwcDujjkF8ExaH5JcClh1peHIn/kIS3g1ELk2giDP
 TOCphobbjZgCGHw9Pt0uH4EhXBi/QdEswso7X9nYP5H07bkWiyMBWw6wWJstfaggOyG8CgShXSs
 XT6G5yB+lc
X-Received: by 2002:a17:90b:2711:b0:3ac:bc3d:6fe8 with SMTP id
 98e67ed59e1d1-3ae89819919mr12545443a91.34.1793783517937; 
 Wed, 04 Nov 2026 01:11:57 -0800 (PST)
X-Received: by 2002:a17:90b:2711:b0:3ac:bc3d:6fe8 with SMTP id
 98e67ed59e1d1-3ae89819919mr12545422a91.34.1793783517304; 
 Wed, 04 Nov 2026 01:11:57 -0800 (PST)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b07c896cc6sm8253877a91.9.2026.11.04.01.11.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 01:11:56 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Wed, 04 Nov 2026 14:41:37 +0530
Subject: [PATCH 2/2] drm/panel: Add driver for Novatek NT37802
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-jshekhar-nt37802-v1-2-58e5e7fb2556@oss.qualcomm.com>
References: <20261104-jshekhar-nt37802-v1-0-58e5e7fb2556@oss.qualcomm.com>
In-Reply-To: <20261104-jshekhar-nt37802-v1-0-58e5e7fb2556@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Jayant Shekhar <jshekhar@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793783500; l=19819;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=jsNsJ8wu4DGIs1bgzdbU1xJUBm3u1le3ghvVll1wnio=;
 b=8FfcivOd4d1CY/fWyFglNclhvPyCvSXZ2OO+vLtqzESzS57Bkp6Y82/Fg5LOvfqqozMObe8yL
 wFpqVoMT7QRDMmU6VP3jWLypOU5yeHlL+udO2XseJQpwgNYJQhPfKro
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Authority-Analysis: v=2.4 cv=GtnXaU1C c=1 sm=1 tr=0 ts=6aeaf6df cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Jp0wMGyhIy9Y1b2Y_SgA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 4DzIaVVwMCTe20kTLA3R1hWF1D_0r1Vg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzNiBTYWx0ZWRfX0l8iWfUu+gZR
 B2xRAmnc9ULiZAB5uJsu+BSx2a1WJCDqDpi9676LDPFldN3Khdox5gTUbVNpgFY4iwLSEoqTj8K
 lQ3kDV69WoujccV+epceENKC3UYBJO41m06IPjv/PSMJC2SOrgJESV99YZ2RWbKWR1dBmvtfx/P
 CJ1IMSoaQ0YgeSpDMvNQJ5BoVYotwo3Y2aNCsy0nZBZ8YQFCB+NlOdlL1K5j8/ubhe/XvJ15NOY
 S1lZtT8JTGaB7w7SQ0Ht0pBnLlI0f6TO+/SGADP5EDi66wSVaYX9aSIISAauzjNKHLb9fd4TSJs
 w2NUVYfl3RFI4k809kRhPrN1frBS6DddT7UadniQof68KAFxU0QUSMc9scPEZUNjmpNfHk8vhhE
 Nlnr/onNUBFBGWQfZpcmdx/BEljjT3f7PUAKeKxcLdYsHdFGxnqpsp1DvwcNJZgXHvcFO5YaxsZ
 cIc6hPoOeks0s7LZeAg==
X-Proofpoint-GUID: 4DzIaVVwMCTe20kTLA3R1hWF1D_0r1Vg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzNiBTYWx0ZWRfXwyATQYGJuieq
 0CT1Nrld4PAqQLVsXpOJYA2t7XMf/la+VFLmzt+9K5YMU8oUtzcyHqjknAklIro5VpU2pDCPMDy
 b7h43PrS40U1AAW0aDt6oWVDfviuGKE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040036
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a DRM panel driver for the Novatek NT37802 AMOLED DSI command-mode
panel used on the Maili/Pebble platform with a CSOT module.

The panel runs at 1440x3200@120Hz over four DSI lanes and uses DSC
1.2 compression. The driver supports a reset GPIO and exposes DCS
brightness control.

Enable the driver as a module in the arm64 defconfig.

Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig                  |   1 +
 drivers/gpu/drm/panel/Kconfig                 |  16 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-novatek-nt37802.c | 544 ++++++++++++++++++++++++++
 4 files changed, 562 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7b4985b29b21..46ae547d3f8f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1036,6 +1036,7 @@ CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
 CONFIG_DRM_PANEL_NOVATEK_NT36672A=m
 CONFIG_DRM_PANEL_NOVATEK_NT36672E=m
 CONFIG_DRM_PANEL_NOVATEK_NT37801=m
+CONFIG_DRM_PANEL_NOVATEK_NT37802=m
 CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
 CONFIG_DRM_PANEL_RAYDIUM_RM692E5=m
 CONFIG_DRM_PANEL_RENESAS_R63419=m
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 7a520b4d60fe..0f94915ee0fd 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -746,6 +746,22 @@ config DRM_PANEL_NOVATEK_NT37801
 	  NT37810) AMOLED DSI Video Mode LCD panel module with 1440x3200
 	  resolution.
 
+config DRM_PANEL_NOVATEK_NT37802
+	tristate "Novatek NT37802 AMOLED DSI command-mode panel"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on GPIOLIB
+	depends on BACKLIGHT_CLASS_DEVICE
+	select DRM_DISPLAY_DSC_HELPER
+	select DRM_DISPLAY_HELPER
+	select DRM_KMS_HELPER
+	help
+	  Say Y here to enable support for the Novatek NT37802 AMOLED
+	  DSI command-mode panel used with the CSOT module on the
+	  Maili/Pebble platform. The panel has a 1440x3200 resolution
+	  and uses DSC 1.2 compression, with DCS brightness control.
+	  To compile this driver as a module, choose M here.
+
 config DRM_PANEL_NOVATEK_NT39016
 	tristate "Novatek NT39016 RGB/SPI panel"
 	depends on OF && SPI
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index da5175909d54..b9cbbf5a9184 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_DRM_PANEL_NOVATEK_NT36672A) += panel-novatek-nt36672a.o
 obj-$(CONFIG_DRM_PANEL_NOVATEK_NT36672E) += panel-novatek-nt36672e.o
 obj-$(CONFIG_DRM_PANEL_NOVATEK_NT37700F) += panel-novatek-nt37700f.o
 obj-$(CONFIG_DRM_PANEL_NOVATEK_NT37801) += panel-novatek-nt37801.o
+obj-$(CONFIG_DRM_PANEL_NOVATEK_NT37802) += panel-novatek-nt37802.o
 obj-$(CONFIG_DRM_PANEL_NOVATEK_NT39016) += panel-novatek-nt39016.o
 obj-$(CONFIG_DRM_PANEL_NOVATEK_NT51021) += panel-novatek-nt51021.o
 obj-$(CONFIG_DRM_PANEL_MANTIX_MLAF057WE51) += panel-mantix-mlaf057we51.o
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt37802.c b/drivers/gpu/drm/panel/panel-novatek-nt37802.c
new file mode 100644
index 000000000000..632520f04ffa
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-novatek-nt37802.c
@@ -0,0 +1,544 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Novatek NT37802 AMOLED DSI command-mode panel.
+ */
+
+#include <linux/backlight.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+
+#include <drm/display/drm_dsc.h>
+#include <drm/display/drm_dsc_helper.h>
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_probe_helper.h>
+
+#include <video/mipi_display.h>
+
+struct nt37802_cmd {
+	u8 len;
+	u8 data[32];
+};
+
+#define NT37802_CMD(...) \
+	{ .len = sizeof((u8[]){ __VA_ARGS__ }), .data = { __VA_ARGS__ } }
+
+struct novatek_nt37802 {
+	struct drm_panel panel;
+	struct mipi_dsi_device *dsi;
+	struct drm_dsc_config dsc;
+	struct gpio_desc *reset_gpio;
+	struct regulator_bulk_data *supplies;
+	bool prepared;
+	bool enabled;
+};
+
+enum nt37802_supply {
+	NT37802_SUPPLY_VDDIO,
+	NT37802_SUPPLY_VDD,
+	NT37802_SUPPLY_VCI,
+	NT37802_SUPPLY_EXVDD,
+};
+
+static const struct regulator_bulk_data novatek_nt37802_supplies[] = {
+	[NT37802_SUPPLY_VDDIO] = { .supply = "vddio", .init_load_uA = 154000 },
+	[NT37802_SUPPLY_VDD] = { .supply = "vdd", .init_load_uA = 220000 },
+	[NT37802_SUPPLY_VCI] = { .supply = "vci", .init_load_uA = 10000 },
+	[NT37802_SUPPLY_EXVDD] = { .supply = "exvdd" },
+};
+
+static int novatek_nt37802_set_supply_voltages(struct novatek_nt37802 *ctx)
+{
+	int ret;
+
+	ret = regulator_set_voltage(ctx->supplies[NT37802_SUPPLY_VDDIO].consumer,
+				    1800000, 2000000);
+	if (ret)
+		return ret;
+
+	ret = regulator_set_voltage(ctx->supplies[NT37802_SUPPLY_VDD].consumer,
+				    1100000, 1950000);
+	if (ret)
+		return ret;
+
+	return regulator_set_voltage(ctx->supplies[NT37802_SUPPLY_VCI].consumer,
+				     3000000, 3544000);
+}
+
+static int novatek_nt37802_enable_supplies(struct novatek_nt37802 *ctx)
+{
+	int ret;
+
+	ret = regulator_enable(ctx->supplies[NT37802_SUPPLY_VDDIO].consumer);
+	if (ret)
+		return ret;
+
+	msleep(20);
+
+	ret = regulator_enable(ctx->supplies[NT37802_SUPPLY_VDD].consumer);
+	if (ret)
+		goto disable_vddio;
+
+	ret = regulator_enable(ctx->supplies[NT37802_SUPPLY_VCI].consumer);
+	if (ret)
+		goto disable_vdd;
+
+	ret = regulator_enable(ctx->supplies[NT37802_SUPPLY_EXVDD].consumer);
+	if (ret)
+		goto disable_vci;
+
+	msleep(20);
+
+	return 0;
+
+disable_vci:
+	regulator_disable(ctx->supplies[NT37802_SUPPLY_VCI].consumer);
+disable_vdd:
+	regulator_disable(ctx->supplies[NT37802_SUPPLY_VDD].consumer);
+disable_vddio:
+	regulator_disable(ctx->supplies[NT37802_SUPPLY_VDDIO].consumer);
+
+	return ret;
+}
+
+static void novatek_nt37802_disable_supplies(struct novatek_nt37802 *ctx)
+{
+	regulator_disable(ctx->supplies[NT37802_SUPPLY_EXVDD].consumer);
+	regulator_disable(ctx->supplies[NT37802_SUPPLY_VCI].consumer);
+	regulator_disable(ctx->supplies[NT37802_SUPPLY_VDD].consumer);
+	regulator_disable(ctx->supplies[NT37802_SUPPLY_VDDIO].consumer);
+}
+
+static inline struct novatek_nt37802 *
+to_novatek_nt37802(struct drm_panel *panel)
+{
+	return container_of(panel, struct novatek_nt37802, panel);
+}
+
+static const struct nt37802_cmd nt37802_init_cmds[] = {
+	NT37802_CMD(0xf0, 0x55, 0xaa, 0x52, 0x08, 0x08),
+	NT37802_CMD(0xc1, 0x8e, 0xff, 0xee, 0xff, 0xff, 0xee, 0xff,
+		    0xff, 0xee, 0xff, 0xff, 0xee, 0xff, 0xff, 0xee,
+		    0xff, 0xff, 0xff, 0x7f, 0xff, 0x0e, 0xff),
+	NT37802_CMD(0x6f, 0x20),
+	NT37802_CMD(0xc1, 0x3f, 0xfd, 0xff),
+	NT37802_CMD(0x6f, 0x23),
+	NT37802_CMD(0xc1, 0x0e, 0xff, 0xee, 0xff, 0xff, 0xee, 0xff,
+		    0xff, 0xee, 0xff, 0xff, 0xee, 0xff, 0xff, 0xee,
+		    0xff, 0xff, 0xdf, 0x7f, 0x11),
+	NT37802_CMD(0x2a, 0x00, 0x00, 0x05, 0x9f),
+	NT37802_CMD(0x2b, 0x00, 0x00, 0x0c, 0x7f),
+	NT37802_CMD(0x90, 0x03, 0x43),
+	NT37802_CMD(0x91, 0xab, 0xa8, 0x00, 0x14, 0xc2, 0x00, 0x02,
+		    0x68, 0x02, 0x2e, 0x00, 0x0a, 0x05, 0x0e, 0x03, 0xd1, 0x10, 0xf0),
+	NT37802_CMD(0x35, 0x00),
+	NT37802_CMD(0x51, 0x0f, 0xff),
+	NT37802_CMD(0x6f, 0x04),
+	NT37802_CMD(0x51, 0x0f, 0xff),
+	NT37802_CMD(0x53, 0x20),
+	NT37802_CMD(0x6f, 0x01),
+	NT37802_CMD(0x8b, 0x00),
+	NT37802_CMD(0xf0, 0x55, 0xaa, 0x52, 0x08, 0x04),
+	NT37802_CMD(0xc0, 0x20),
+	NT37802_CMD(0x8c, 0x00, 0x00, 0x11),
+	NT37802_CMD(0xff, 0xaa, 0x55, 0xa5, 0x81),
+	NT37802_CMD(0x6f, 0x21),
+	NT37802_CMD(0xf5, 0x03),
+	NT37802_CMD(0x6f, 0x43),
+	NT37802_CMD(0xf5, 0x01, 0x02, 0x01, 0x04, 0x00, 0x01, 0x02, 0x00,
+		    0x00, 0x00, 0x43, 0x02, 0x00, 0x00, 0x10, 0x00, 0x00, 0x10,
+		    0x05, 0x00, 0x11, 0x31, 0x12, 0x11),
+	NT37802_CMD(0x6f, 0x1d),
+	NT37802_CMD(0xfb, 0x64, 0x07, 0x80),
+	NT37802_CMD(0x6f, 0x07),
+	NT37802_CMD(0xfc, 0x04),
+	NT37802_CMD(0xf0, 0x55, 0xaa, 0x52, 0x08, 0x01),
+	NT37802_CMD(0x6f, 0x02),
+	NT37802_CMD(0xd6, 0x03),
+	NT37802_CMD(0xff, 0xaa, 0x55, 0xa5, 0x84),
+	NT37802_CMD(0x6f, 0x9a),
+	NT37802_CMD(0xf3, 0x0f),
+	NT37802_CMD(0x6f, 0x02),
+	NT37802_CMD(0x2f, 0x32),
+	NT37802_CMD(0xf0, 0x55, 0xaa, 0x52, 0x08, 0x03),
+	NT37802_CMD(0xc8, 0x01, 0xff, 0xfb),
+	NT37802_CMD(0xff, 0xaa, 0x55, 0xa5, 0x80),
+	NT37802_CMD(0x6f, 0x22),
+	NT37802_CMD(0xfe, 0x06),
+	NT37802_CMD(0x6d, 0x00),
+	NT37802_CMD(0x68, 0x20),
+	NT37802_CMD(0xf0, 0x55, 0xaa, 0x52, 0x08, 0x00),
+	NT37802_CMD(0x6f, 0x31),
+	NT37802_CMD(0xc0, 0x01, 0x00),
+	NT37802_CMD(0x6f, 0x35),
+	NT37802_CMD(0xc0, 0x23, 0x20),
+	NT37802_CMD(0x6f, 0x01),
+	NT37802_CMD(0x5f, 0x40),
+	NT37802_CMD(0xf0, 0x55, 0xaa, 0x52, 0x08, 0x00),
+	NT37802_CMD(0x6f, 0x78),
+	NT37802_CMD(0xb0, 0x11, 0x00, 0x2a, 0x00, 0xc2, 0x01, 0xda, 0x03, 0x7c,
+		    0x05, 0xb1, 0x08, 0x80, 0x0b, 0xee, 0x0f, 0xff,
+		    0x05, 0x55, 0x05, 0x56, 0x05, 0x55),
+	NT37802_CMD(0x6f, 0x6f),
+	NT37802_CMD(0xb0, 0x02, 0xd0, 0x05, 0xa0, 0x02, 0xd0),
+	NT37802_CMD(0xf0, 0x55, 0xaa, 0x52, 0x08, 0x03),
+	NT37802_CMD(0x6f, 0x04),
+	NT37802_CMD(0xc7, 0xfd),
+	NT37802_CMD(0xf0, 0x55, 0xaa, 0x52, 0x08, 0x00),
+	NT37802_CMD(0xc7, 0x33),
+	NT37802_CMD(0xa3, 0x83, 0x01, 0x9b, 0x01, 0x9b, 0x02, 0x00, 0xc0, 0x09, 0x09, 0x00),
+	NT37802_CMD(0x6f, 0x53),
+	NT37802_CMD(0xa3, 0x02, 0x00, 0xc0, 0x09, 0x09, 0x55),
+	NT37802_CMD(0xf0, 0x55, 0xaa, 0x52, 0x08, 0x00),
+	NT37802_CMD(0xb5, 0x80, 0x02, 0x38, 0xc8, 0x00, 0x00, 0xff, 0x0c,
+		    0x60, 0x00, 0x00, 0x00, 0x0c, 0x60, 0x00, 0x00),
+	NT37802_CMD(0x6f, 0x10),
+	NT37802_CMD(0xb5, 0x00, 0x60, 0x60, 0x60, 0x60, 0x60, 0x00, 0x00,
+		    0x11, 0x2b, 0x00, 0x00, 0x00, 0x11, 0x2b, 0x00),
+	NT37802_CMD(0xf0, 0x55, 0xaa, 0x52, 0x08, 0x00),
+	NT37802_CMD(0x6f, 0x08),
+	NT37802_CMD(0xd5, 0x08),
+	NT37802_CMD(0xd5, 0x4e, 0x10),
+	NT37802_CMD(0x6f, 0x02),
+	NT37802_CMD(0xd5, 0x01),
+	NT37802_CMD(0x6f, 0xd9),
+	NT37802_CMD(0xd5, 0x7f, 0x7f),
+	NT37802_CMD(0x6f, 0x4e),
+	NT37802_CMD(0xd5, 0x02),
+	NT37802_CMD(0x6f, 0x4f),
+	NT37802_CMD(0xd5, 0x05, 0x07),
+	NT37802_CMD(0x6f, 0x52),
+	NT37802_CMD(0xd5, 0x11, 0x02),
+	NT37802_CMD(0x6f, 0x55),
+	NT37802_CMD(0xd5, 0x01),
+	NT37802_CMD(0x6f, 0x56),
+	NT37802_CMD(0xd5, 0x07),
+	NT37802_CMD(0x6f, 0x59),
+	NT37802_CMD(0xd5, 0x70),
+	NT37802_CMD(0x6f, 0x5c),
+	NT37802_CMD(0xd5, 0x03),
+	NT37802_CMD(0x6f, 0x5d),
+	NT37802_CMD(0xd5, 0x02, 0x03, 0x07),
+	NT37802_CMD(0x6f, 0x63),
+	NT37802_CMD(0xd5, 0x08, 0x60, 0x07),
+	NT37802_CMD(0x6f, 0x69),
+	NT37802_CMD(0xd5, 0x01),
+	NT37802_CMD(0x6f, 0x6a),
+	NT37802_CMD(0xd5, 0x07),
+	NT37802_CMD(0x6f, 0x70),
+	NT37802_CMD(0xd5, 0x16),
+	NT37802_CMD(0x6f, 0xb8),
+	NT37802_CMD(0xd5, 0x02),
+	NT37802_CMD(0x6f, 0xb9),
+	NT37802_CMD(0xd5, 0x1c, 0x1f),
+	NT37802_CMD(0x6f, 0xbc),
+	NT37802_CMD(0xd5, 0x5d, 0x02),
+	NT37802_CMD(0x6f, 0xbf),
+	NT37802_CMD(0xd5, 0x01),
+	NT37802_CMD(0x6f, 0xc0),
+	NT37802_CMD(0xd5, 0x1f),
+	NT37802_CMD(0x6f, 0xc3),
+	NT37802_CMD(0xd5, 0x00),
+	NT37802_CMD(0xf0, 0x55, 0xaa, 0x52, 0x08, 0x01),
+	NT37802_CMD(0x6f, 0x04),
+	NT37802_CMD(0xb2, 0x30),
+	NT37802_CMD(0x6f, 0x25),
+	NT37802_CMD(0xd8, 0x30),
+	NT37802_CMD(0xf0, 0x55, 0xaa, 0x52, 0x08, 0x00),
+	NT37802_CMD(0x6f, 0xd1),
+	NT37802_CMD(0xd5, 0x13),
+	NT37802_CMD(0x6f, 0xd2),
+	NT37802_CMD(0xd5, 0x56),
+	NT37802_CMD(0x6f, 0x03),
+	NT37802_CMD(0xb5, 0x35),
+	NT37802_CMD(0xf0, 0x55, 0xaa, 0x52, 0x08, 0x01),
+	NT37802_CMD(0x6f, 0x04),
+	NT37802_CMD(0xb2, 0x20),
+};
+
+static void novatek_nt37802_set_reset(struct novatek_nt37802 *ctx, int value)
+{
+	gpiod_set_value_cansleep(ctx->reset_gpio, value);
+}
+
+static void novatek_nt37802_reset(struct novatek_nt37802 *ctx)
+{
+	novatek_nt37802_set_reset(ctx, 0);
+	usleep_range(10000, 11000);
+	novatek_nt37802_set_reset(ctx, 1);
+	usleep_range(10000, 11000);
+	novatek_nt37802_set_reset(ctx, 0);
+	usleep_range(10000, 11000);
+	/* qcom,platform-reset-gpio-release-delay */
+	msleep(120);
+}
+
+static int novatek_nt37802_write_init(struct novatek_nt37802 *ctx)
+{
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(nt37802_init_cmds); i++)
+		mipi_dsi_dcs_write_buffer_multi(&dsi_ctx,
+						nt37802_init_cmds[i].data,
+						nt37802_init_cmds[i].len);
+
+	return dsi_ctx.accum_err;
+}
+
+static int novatek_nt37802_prepare(struct drm_panel *panel)
+{
+	struct novatek_nt37802 *ctx = to_novatek_nt37802(panel);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+	struct drm_dsc_picture_parameter_set pps;
+	int ret;
+
+	if (ctx->prepared)
+		return 0;
+
+	ret = novatek_nt37802_enable_supplies(ctx);
+	if (ret)
+		return ret;
+
+	novatek_nt37802_reset(ctx);
+	ctx->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	ret = novatek_nt37802_write_init(ctx);
+	if (ret) {
+		novatek_nt37802_set_reset(ctx, 1);
+		novatek_nt37802_disable_supplies(ctx);
+		return ret;
+	}
+
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 120);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 120);
+
+	drm_dsc_pps_payload_pack(&pps, &ctx->dsc);
+	mipi_dsi_picture_parameter_set_multi(&dsi_ctx, &pps);
+	mipi_dsi_compression_mode_multi(&dsi_ctx, true);
+	if (dsi_ctx.accum_err) {
+		novatek_nt37802_set_reset(ctx, 1);
+		novatek_nt37802_disable_supplies(ctx);
+		return dsi_ctx.accum_err;
+	}
+
+	ctx->prepared = true;
+	return 0;
+}
+
+static int novatek_nt37802_enable(struct drm_panel *panel)
+{
+	struct novatek_nt37802 *ctx = to_novatek_nt37802(panel);
+
+	if (!ctx->prepared)
+		return -EPERM;
+
+	if (ctx->enabled)
+		return 0;
+
+	ctx->enabled = true;
+	return 0;
+}
+
+static int novatek_nt37802_disable(struct drm_panel *panel)
+{
+	struct novatek_nt37802 *ctx = to_novatek_nt37802(panel);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+
+	if (!ctx->enabled)
+		return 0;
+
+	/* The off sequence sends display-off in HS mode, then waits 10 ms. */
+	ctx->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 10);
+
+	ctx->enabled = false;
+	return dsi_ctx.accum_err;
+}
+
+static int novatek_nt37802_unprepare(struct drm_panel *panel)
+{
+	struct novatek_nt37802 *ctx = to_novatek_nt37802(panel);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+
+	if (!ctx->prepared)
+		return 0;
+
+	ctx->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 120);
+
+	/* Assert the active-low reset after the downstream sleep delay. */
+	novatek_nt37802_set_reset(ctx, 1);
+	ctx->prepared = false;
+	novatek_nt37802_disable_supplies(ctx);
+
+	return dsi_ctx.accum_err;
+}
+
+static const struct drm_display_mode novatek_nt37802_mode = {
+	/* (1440 + 32 + 16 + 32) * (3200 + 16 + 2 + 48) * 120 Hz */
+	.clock = (1440 + 32 + 16 + 32) * (3200 + 16 + 2 + 48) * 120 / 1000,
+	.hdisplay = 1440,
+	.hsync_start = 1440 + 32,
+	.hsync_end = 1440 + 32 + 16,
+	.htotal = 1440 + 32 + 16 + 32,
+	.vdisplay = 3200,
+	.vsync_start = 3200 + 16,
+	.vsync_end = 3200 + 16 + 2,
+	.vtotal = 3200 + 16 + 2 + 48,
+	.width_mm = 74,
+	.height_mm = 156,
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static int novatek_nt37802_get_modes(struct drm_panel *panel,
+				     struct drm_connector *connector)
+{
+	return drm_connector_helper_get_modes_fixed(connector,
+						    &novatek_nt37802_mode);
+}
+
+static const struct drm_panel_funcs novatek_nt37802_panel_funcs = {
+	.prepare = novatek_nt37802_prepare,
+	.enable = novatek_nt37802_enable,
+	.disable = novatek_nt37802_disable,
+	.unprepare = novatek_nt37802_unprepare,
+	.get_modes = novatek_nt37802_get_modes,
+};
+
+static int novatek_nt37802_bl_update_status(struct backlight_device *bl)
+{
+	struct mipi_dsi_device *dsi = bl_get_data(bl);
+
+	return mipi_dsi_dcs_set_display_brightness_large(dsi,
+							backlight_get_brightness(bl));
+}
+
+static const struct backlight_ops novatek_nt37802_bl_ops = {
+	.update_status = novatek_nt37802_bl_update_status,
+};
+
+static struct backlight_device *
+novatek_nt37802_create_backlight(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	const struct backlight_properties props = {
+		.type = BACKLIGHT_RAW,
+		.brightness = 4095,
+		.max_brightness = 4095,
+	};
+
+	return devm_backlight_device_register(dev, dev_name(dev), dev, dsi,
+					      &novatek_nt37802_bl_ops, &props);
+}
+
+static void novatek_nt37802_init_dsc(struct novatek_nt37802 *ctx)
+{
+	struct drm_dsc_config *dsc = &ctx->dsc;
+
+	dsc->dsc_version_major = 1;
+	dsc->dsc_version_minor = 2;
+	dsc->bits_per_component = 8;
+	dsc->bits_per_pixel = 8 << 4;
+	dsc->block_pred_enable = true;
+	dsc->slice_width = 720;
+	dsc->slice_height = 20;
+	dsc->slice_count = 2;
+}
+
+static int novatek_nt37802_probe(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	struct novatek_nt37802 *ctx;
+	int ret;
+
+	ctx = devm_drm_panel_alloc(dev, struct novatek_nt37802, panel,
+				   &novatek_nt37802_panel_funcs,
+				   DRM_MODE_CONNECTOR_DSI);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	ctx->dsi = dsi;
+	mipi_dsi_set_drvdata(dsi, ctx);
+
+	ret = devm_regulator_bulk_get_const(dev,
+					    ARRAY_SIZE(novatek_nt37802_supplies),
+					    novatek_nt37802_supplies,
+					    &ctx->supplies);
+	if (ret)
+		return ret;
+
+	ret = novatek_nt37802_set_supply_voltages(ctx);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set regulator voltages\n");
+
+	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
+				     "Failed to get reset GPIO\n");
+
+	novatek_nt37802_init_dsc(ctx);
+
+	dsi->lanes = 4;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_MODE_NO_EOT_PACKET |
+			  MIPI_DSI_CLOCK_NON_CONTINUOUS;
+	ctx->panel.prepare_prev_first = true;
+
+	ctx->panel.backlight = novatek_nt37802_create_backlight(dsi);
+	if (IS_ERR(ctx->panel.backlight))
+		return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
+				     "Failed to create backlight\n");
+
+	dsi->dsc = &ctx->dsc;
+	drm_panel_add(&ctx->panel);
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret < 0) {
+		drm_panel_remove(&ctx->panel);
+		return dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
+	}
+
+	return 0;
+}
+
+static void novatek_nt37802_remove(struct mipi_dsi_device *dsi)
+{
+	struct novatek_nt37802 *ctx = mipi_dsi_get_drvdata(dsi);
+	int ret;
+
+	ret = mipi_dsi_detach(dsi);
+	if (ret < 0)
+		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
+
+	drm_panel_remove(&ctx->panel);
+}
+
+static const struct of_device_id novatek_nt37802_of_match[] = {
+	{ .compatible = "novatek,nt37802" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, novatek_nt37802_of_match);
+
+static struct mipi_dsi_driver novatek_nt37802_driver = {
+	.probe = novatek_nt37802_probe,
+	.remove = novatek_nt37802_remove,
+	.driver = {
+		.name = "panel-novatek-nt37802",
+		.of_match_table = novatek_nt37802_of_match,
+	},
+};
+module_mipi_dsi_driver(novatek_nt37802_driver);
+
+MODULE_AUTHOR("Jayant Shekhar <jshekhar@oss.qualcomm.com>");
+MODULE_DESCRIPTION("Panel driver for the Novatek NT37802 AMOLED DSI panel");
+MODULE_LICENSE("GPL");

-- 
2.43.0

