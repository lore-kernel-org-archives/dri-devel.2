Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1413C5AD2C
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 08:08:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BB4B10E449;
	Sat,  8 Aug 2026 08:08:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MJFqNeeX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UcFvRYCm";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A693010E449
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 08:08:15 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6787W1Bu3063168
 for <dri-devel@lists.freedesktop.org>; Sat, 8 Aug 2026 08:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pPbBSPk/16Iro64Nq0uQtONC5P0iAMVzVZPF0VTmd58=; b=MJFqNeeX0Et9N/iI
 W7/1WeZ9O515NnR1f+sCztvIsuPi/5PVxQnKvPqgBWqAjTvmIthRe7lZZ3d8nVv/
 jWZfgwA6Sn4VtpPapQP5TTXlVDZEdXH1cOkZIJhMEO77/rRD6klzqYNK0+ABz79m
 /Qef9Ko9Jp7h85BPSnl/JYubweOdOgfGWFFGJ9nlWy1oKDYOw7skjL7mRGW8OcrL
 hWCuqlu1wnLwXmzSlh9obauMSxbdQplOfEBJqI/UA6xQ26aVM7TFh/i52c2gRDoI
 nWRFNfI0RPgqwVnXrcW4HqPYAjsZbURwcuWMnXc3xUhGuIiPV5d6mXp2DO1hlp84
 sSxMOg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwwr9g9ue-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 08:08:14 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38ecc48b3c2so570234a91.1
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 01:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786176494; x=1786781294;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pPbBSPk/16Iro64Nq0uQtONC5P0iAMVzVZPF0VTmd58=;
 b=UcFvRYCmEoGZBaj7UdI+UZw5ysqHehXfHqakQPyHK8kUbrWVCYAfu5WU4QDv4l0sf7
 XNxRbeFasiCdwvjktiIx5zJujdTAYgy+xf9D2plKMZ8nMmpsTjVhSHDUDSWZ2SgqgyLE
 yY00eEq4Zxe5/6ZTuw3I1oRbr/YE1C7FPGnXa5bhPovDk/ZdoKlTDUn03eK9D9WOdgDV
 jxw+ONPww202rTspNO8M6xhOLCORNN1YWvE5epPMoWFu+3bNGJBT1ZnZtLpomC6Z+Ktz
 CDpkaauppw1arvRlDzMCGPoi7OjvKFjVB7SqSz1dwJjoSihdLn6LSjl5QEB2xXn/Q8mL
 X3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786176494; x=1786781294;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pPbBSPk/16Iro64Nq0uQtONC5P0iAMVzVZPF0VTmd58=;
 b=rfm8BsxhpZBtyQLZq+XxODIYiH7p6GWV1dwfgh9EY5QPqR3SnzKCyTjl4aPG/Mz+Pv
 Il2nAZeDNPmoWBg5WFbvj2RFKak9XjPxGq6L4vLCBzHqjtQOQv11Dfm2Q4cMkly1QMaA
 m+fMEUkOzLIwAvNqXeqqrDvtbetKtMm+MsQjsnZ6p5t9FfjZWG0XqaCY4iZ7yZ4LAUhG
 yrcL7t23lBPylUWSnT/zYcGO9oHmDzxEHTSkzePvmfK2/XbAR4FbGGd9EMWiXRzop+xJ
 u+Qex6crURUUqcWH1WbtxJYLw6ispBJ3EuldUa73eIHijYO41Hkg3IAuMvVon0F3qNEI
 kRfw==
X-Gm-Message-State: AOJu0YxDLU1uNvnYT5tRSFK3E7qhkwQoXmEeph8LVWn7NpMn2N7SlgXx
 2PF3BuQt/0vu2zHXjAaqg/dNBS9QpLjtViluopE5yGYARdHvD6SphEKefi9XF0Z6HwbvHz37q1h
 BJp9YML4d7NqG2ctDsNd0hV14RwXD0EcvFN3m2ejHAFJRtuDOm/PxYB+QDiXqOSi7IVtDcGs=
X-Gm-Gg: AR+sD10kaP3vKX35Y+B8Pu5g+FjRlHKmMfShXk+mqUj3Z1GFGLFHAdfLWItVp6SA5ao
 RbEK5IPsDAnw/JOa3rKfUhYB8uxbc3hjPF5IdaepkUNkcHbjfsRqxpF0uK7kdgAsrrq4JHq7v/p
 NJxXS5p1niOqOjd/xEfG4WhALIV1gS6sKLod0vNmkgFPn3cHk5axQAAnTE32mOo7/tgLPaZ0vIz
 4t6zaI2x3W5rK8j91qni9oMaXZD6wfJDXAD2e3NKACPVhqmyQWegJIZdGX7oZEo81D4IxhhY7zW
 RxhVtiC3d42CTwav83vErjPUNoTTkAV/L6bDYfEJ/G1vDC6fnhLkz1MPxVHNGf7Usuzg2A1b07i
 giqxnB1Z50OLLbPNHsPWpkMaGpQ==
X-Received: by 2002:a17:90b:3881:b0:38e:2517:5d1f with SMTP id
 98e67ed59e1d1-392823aba6fmr5130248a91.9.1786176493832; 
 Sat, 08 Aug 2026 01:08:13 -0700 (PDT)
X-Received: by 2002:a17:90b:3881:b0:38e:2517:5d1f with SMTP id
 98e67ed59e1d1-392823aba6fmr5130170a91.9.1786176493088; 
 Sat, 08 Aug 2026 01:08:13 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39085f2c714sm7497465a91.10.2026.08.08.01.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 01:08:12 -0700 (PDT)
From: mohit.dsor@oss.qualcomm.com
Date: Sat, 08 Aug 2026 13:37:51 +0530
Subject: [PATCH v10 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI
 to HDMI driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260808-lt9611c-v7-v10-2-ee90a136d82a@oss.qualcomm.com>
References: <20260808-lt9611c-v7-v10-0-ee90a136d82a@oss.qualcomm.com>
In-Reply-To: <20260808-lt9611c-v7-v10-0-ee90a136d82a@oss.qualcomm.com>
To: Sunyun Yang <syyang@lontium.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mohit Dsor <mohit.dsor@oss.qualcomm.com>,
 venkata.valluru@oss.qualcomm.com, vishnu.saini@oss.qualcomm.com,
 Jessica Zhang <jesszhan0024@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786176472; l=39775;
 i=mohit.dsor@oss.qualcomm.com; s=20260808; h=from:subject:message-id;
 bh=cJ1OhI28WBEW+JwT8QeNr0HSLsCzys8U1imXICK2xb4=;
 b=lhNHOsIGFDI2dS3EKvQanVV6uTDtBeznRNfbZiTxI8TDk1CAe1jvJYKjkVuuIsJdDy+MogDGA
 YQrAeTHCktDBt5xayoMFz8Sz1P+5QjFPWEbbEg9A4BDayGY0gUCeV8w
X-Developer-Key: i=mohit.dsor@oss.qualcomm.com; a=ed25519;
 pk=outHVBN53JhozDw1xkj3G1qrqqE5scMBP7M4WL3aHQQ=
X-Authority-Analysis: v=2.4 cv=d73FDxjE c=1 sm=1 tr=0 ts=6a76e3ef cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=Kz8-B0t5AAAA:8 a=EUspDBNiAAAA:8 a=6KJRpCim67n0dy3d9PwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-ORIG-GUID: NZrhyyE_P4GnskS-i50j5MNQS0rFAshM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDA2NSBTYWx0ZWRfX+uM3vRVUrdmb
 K1fnCjtBXLLi3D3ozRv/PjpqK/TqdvVQRH72Vh9l/kLrmrTETx+bbJUGWOjuwo/P9cb/KFuEGU5
 67RJ6keGtI99N5zm4Q9ugBInGKW6Gs7XiuaI12UvxytbroL7zsggzzmciOZ4hzrerUUFpabmDND
 NU/Kz4841DiPG0rZUUXXhM6aDKDeSKcKo3+unZcx3nsuL2Pc7zwmgrPouG37swO9lb9AQm9K65O
 2PNQ4QmGftj8smnJKTZdTLwMSU1Tr3YHlzpEgQXzLx0dC9TGdZZcRGCAJBRRcBU34nSEuetjOmj
 fH+HttqrcBbu14FvQYHKuUxgxFZfXdOrw7NH01093CqI9dPmJixR791DRkbn3HJ9Ro0ovJvQuwo
 VuDcBDQeNWt5yhzyklNn7uCfH8XcNHrpWIXxLaYFmEJErrHl3MYdzYHxXNRDbQbb36AKzr3NzGw
 IY7uFDc2zrtgowA5Pzg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDA2NSBTYWx0ZWRfX5yvrf3RGC/yd
 Orm0Ekuc6VAXWeARdfGIslaZz81EnRapDqIdBh1HEodF6VGqdcatTZndmabpeuaDbYaXxV7GA4E
 2s42aZyRw5d3Lb5Bzs7pwhBPQPNEUqs=
X-Proofpoint-GUID: NZrhyyE_P4GnskS-i50j5MNQS0rFAshM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608080065
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

From: Sunyun Yang <syyang@lontium.com>

LT9611C(EX/UXD) is an I2C-controlled chip that Receiver signal/dual port
mipi dsi and output hdmi, differences in hardware features:
- LT9611C: supports 1-port mipi dsi to hdmi 1.4
- LT9611EX: supports 2-port mipi dsi to hdmi 1.4
- LT9611UXD: supports 2-port mipi dsi to hdmi 1.4/2.0

Signed-off-by: Sunyun Yang <syyang@lontium.com>
Co-developed-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
---
 Documentation/ABI/testing/sysfs-lontium-firmware |   10 +
 drivers/gpu/drm/bridge/Kconfig                   |   18 +
 drivers/gpu/drm/bridge/Makefile                  |    1 +
 drivers/gpu/drm/bridge/lontium-lt9611c.c         | 1283 ++++++++++++++++++++++
 4 files changed, 1312 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-lontium-firmware b/Documentation/ABI/testing/sysfs-lontium-firmware
new file mode 100644
index 000000000000..8700933ba0f0
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-lontium-firmware
@@ -0,0 +1,10 @@
+What:		/sys/bus/i2c/drivers/<driver>/.../firmware
+Date:		July 2026
+KernelVersion:	7.3
+Contact:	Mohit Dsor <mohit.dsor@oss.qualcomm.com>
+Description:
+		Read: Returns the current firmware version loaded on the
+		Lontium bridge chip in hex format (e.g. "0x0105").
+
+		Write: Triggers a firmware upgrade of the chip using the
+		firmware file loaded via the firmware loader.
diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 4a57d49b4c6d..d1597548e578 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -177,6 +177,24 @@ config DRM_LONTIUM_LT9611
 	  HDMI signals
 	  Please say Y if you have such hardware.
 
+config DRM_LONTIUM_LT9611C
+	tristate "Lontium LT9611C DSI/HDMI bridge"
+	select SND_SOC_HDMI_CODEC if SND_SOC
+	depends on OF && I2C
+	select CRC8
+	select FW_LOADER
+	select DRM_PANEL_BRIDGE
+	select DRM_KMS_HELPER
+	select DRM_MIPI_DSI
+	select DRM_DISPLAY_HELPER
+	select DRM_DISPLAY_HDMI_STATE_HELPER
+	select REGMAP_I2C
+	help
+	  Driver for the Lontium LT9611C(EX/UXD) DSI to HDMI bridge chip.
+	  It converts single or dual MIPI DSI and I2S signals to HDMI
+	  output. Supports HDMI 1.4 (LT9611C/EX) and HDMI 2.0 (LT9611UXD).
+	  Say Y if you have hardware using this chip.
+
 config DRM_LONTIUM_LT9611UXC
 	tristate "Lontium LT9611UXC DSI/HDMI bridge"
 	select SND_SOC_HDMI_CODEC if SND_SOC
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index 15cc821d85b7..f322f3f89f6b 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_DRM_ITE_IT6505) += ite-it6505.o
 obj-$(CONFIG_DRM_LONTIUM_LT8912B) += lontium-lt8912b.o
 obj-$(CONFIG_DRM_LONTIUM_LT9211) += lontium-lt9211.o
 obj-$(CONFIG_DRM_LONTIUM_LT9611) += lontium-lt9611.o
+obj-$(CONFIG_DRM_LONTIUM_LT9611C) += lontium-lt9611c.o
 obj-$(CONFIG_DRM_LONTIUM_LT9611UXC) += lontium-lt9611uxc.o
 obj-$(CONFIG_DRM_LONTIUM_LT8713SX) += lontium-lt8713sx.o
 obj-$(CONFIG_DRM_LVDS_CODEC) += lvds-codec.o
diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/bridge/lontium-lt9611c.c
new file mode 100644
index 000000000000..e6887f2c89a6
--- /dev/null
+++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
@@ -0,0 +1,1283 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Lontium Semiconductor, Inc.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/crc8.h>
+#include <linux/firmware.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/media-bus-format.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_graph.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/unaligned.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_edid.h>
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_of.h>
+#include <drm/drm_print.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/display/drm_hdmi_audio_helper.h>
+#include <drm/display/drm_hdmi_state_helper.h>
+#include <sound/hdmi-codec.h>
+
+#define FW_SIZE (64 * 1024)
+#define LT_PAGE_SIZE 256
+#define FW_FILE  "lt9611c_fw.bin"
+#define LT9611C_CRC_POLYNOMIAL 0x31
+#define LT9611C_PAGE_CONTROL 0xff
+#define LT9611C_INFOFRAME_MAX_SIZE 32
+#define LT9611C_CMD_HDR_SIZE 4
+#define LT9611C_CMD_Y0_SIZE  1  /* Y0 echo byte in ACK response */
+#define LT9611C_EDID_BUF_SIZE 32
+
+struct lt9611c_cmd_hdr {
+	u8 func;
+	u8 type;
+	u8 seq;
+	u8 sep;
+};
+
+/* lt9611c_cmd_hdr.func values */
+#define LT9611C_FUNC_WRITE	0x57 /* 'W' */
+#define LT9611C_FUNC_READ	0x52 /* 'R' */
+#define LT9611C_FUNC_ACK	0x41 /* 'A' */
+
+/* lt9611c_cmd_hdr.type values */
+#define LT9611C_TYPE_MIPI	0x4d /* 'M' */
+#define LT9611C_TYPE_LVDS	0x4c /* 'L' */
+#define LT9611C_TYPE_HDMI	0x48 /* 'H' */
+#define LT9611C_TYPE_AUDIO	0x41 /* 'A' */
+#define LT9611C_TYPE_CUSTOM	0x43 /* 'C' */
+
+/* lt9611c_cmd_hdr.sep is always ':' */
+#define LT9611C_CMD_SEP		0x3a /* ':' */
+
+struct lt9611c_cmd {
+	struct lt9611c_cmd_hdr hdr;
+	const u8 *data;
+	size_t data_len;
+};
+
+struct lt9611c_rsp {
+	struct lt9611c_cmd_hdr hdr;
+	u8 *data;
+	unsigned int data_len;
+};
+
+enum lt9611_chip_type {
+	CHIP_LT9611C = 0,
+	CHIP_LT9611EX,
+	CHIP_LT9611UXD,
+};
+
+struct lt9611c_chip_data {
+	enum lt9611_chip_type chip_type;
+	unsigned long long max_tmds_rate;
+};
+
+static const struct lt9611c_chip_data lt9611c_chip_data[] = {
+	[CHIP_LT9611C]   = { CHIP_LT9611C,   340000000 },
+	[CHIP_LT9611EX]  = { CHIP_LT9611EX,  340000000 },
+	[CHIP_LT9611UXD] = { CHIP_LT9611UXD, 600000000 },
+};
+
+struct lt9611c {
+	struct device *dev;
+	struct i2c_client *client;
+	struct drm_bridge bridge;
+	struct regmap *regmap;
+	struct mutex mcu_lock;
+	struct work_struct work;
+	struct device_node *dsi0_node;
+	struct device_node *dsi1_node;
+	struct mipi_dsi_device *dsi0;
+	struct mipi_dsi_device *dsi1;
+	struct gpio_desc *reset_gpio;
+	struct regulator_bulk_data supplies[2];
+	int fw_version;
+	/* Chip variant: C/EX/UXD */
+	enum lt9611_chip_type chip_type;
+	unsigned long long max_tmds_rate;
+	bool hdmi_connected;
+};
+
+DECLARE_CRC8_TABLE(lt9611c_crc8_table);
+
+static const struct regmap_range_cfg lt9611c_ranges[] = {
+	{
+		.name = "register_range",
+		.range_min =  0,
+		.range_max = 0xfe9c,
+		.selector_reg = LT9611C_PAGE_CONTROL,
+		.selector_mask = 0xff,
+		.selector_shift = 0,
+		.window_start = 0,
+		.window_len = 0x100,
+	},
+};
+
+static const struct regmap_config lt9611c_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0xfe9c,
+	.ranges = lt9611c_ranges,
+	.num_ranges = ARRAY_SIZE(lt9611c_ranges),
+};
+
+static int lt9611c_read_write_flow(struct lt9611c *lt9611c,
+				   const struct lt9611c_cmd *cmd,
+				   struct lt9611c_rsp *rsp)
+{
+	int ret;
+	unsigned int i;
+	unsigned int temp;
+	unsigned int max_params = 0xe0dd - 0xe0b0 + 1;
+
+	regmap_write(lt9611c->regmap, 0xe0de, 0x01);
+
+	ret = regmap_read_poll_timeout(lt9611c->regmap, 0xe0ae, temp,
+				       temp == 0x01, 1000, 200 * 1000);
+	if (ret)
+		return -ETIMEDOUT;
+
+	ret = regmap_bulk_write(lt9611c->regmap, 0xe0b0, &cmd->hdr,
+				LT9611C_CMD_HDR_SIZE);
+	if (ret)
+		return ret;
+
+	for (i = 0; cmd->data && i < cmd->data_len &&
+	     (LT9611C_CMD_HDR_SIZE + i) < max_params; i++)
+		regmap_write(lt9611c->regmap,
+			     0xe0b0 + LT9611C_CMD_HDR_SIZE + i, cmd->data[i]);
+
+	regmap_write(lt9611c->regmap, 0xe0de, 0x02);
+
+	ret = regmap_read_poll_timeout(lt9611c->regmap, 0xe0ae, temp,
+				       temp == 0x02, 1000, 200 * 1000);
+	if (ret)
+		return -ETIMEDOUT;
+
+	ret = regmap_bulk_read(lt9611c->regmap, 0xe085,
+			       &rsp->hdr, LT9611C_CMD_HDR_SIZE);
+	if (ret)
+		return ret;
+
+
+	if (rsp->data && rsp->data_len)
+		ret = regmap_bulk_read(lt9611c->regmap,
+				       0xe085 + LT9611C_CMD_HDR_SIZE,
+				       rsp->data, rsp->data_len);
+
+	return ret;
+}
+
+static void lt9611c_lock(struct lt9611c *lt9611c)
+{
+	mutex_lock(&lt9611c->mcu_lock);
+	regmap_write(lt9611c->regmap, 0xe0ee, 0x01);
+}
+
+static void lt9611c_unlock(struct lt9611c *lt9611c)
+{
+	regmap_write(lt9611c->regmap, 0xe0ee, 0x00);
+	mutex_unlock(&lt9611c->mcu_lock);
+}
+
+static void lt9611c_config_parameters(struct lt9611c *lt9611c)
+{
+	const struct reg_sequence seq_write_paras[] = {
+		REG_SEQ0(0xe0ee, 0x01),
+		REG_SEQ0(0xe103, 0x3f), /*fifo rst*/
+		REG_SEQ0(0xe103, 0xff),
+		REG_SEQ0(0xe05e, 0xc1),
+		REG_SEQ0(0xe058, 0x00),
+		REG_SEQ0(0xe059, 0x50),
+		REG_SEQ0(0xe05a, 0x10),
+		REG_SEQ0(0xe05a, 0x00),
+		REG_SEQ0(0xe058, 0x21),
+	};
+
+	regmap_multi_reg_write(lt9611c->regmap, seq_write_paras, ARRAY_SIZE(seq_write_paras));
+}
+
+static void lt9611c_wren(struct lt9611c *lt9611c)
+{
+	regmap_write(lt9611c->regmap, 0xe05a, 0x04);
+	regmap_write(lt9611c->regmap, 0xe05a, 0x00);
+}
+
+static void lt9611c_wrdi(struct lt9611c *lt9611c)
+{
+	regmap_write(lt9611c->regmap, 0xe05a, 0x08);
+	regmap_write(lt9611c->regmap, 0xe05a, 0x00);
+}
+
+static void lt9611c_erase_op(struct lt9611c *lt9611c, u32 addr)
+{
+	const struct reg_sequence seq_write[] = {
+		REG_SEQ0(0xe0ee, 0x01),
+		REG_SEQ0(0xe05a, 0x04),
+		REG_SEQ0(0xe05a, 0x00),
+		REG_SEQ0(0xe05b, (addr >> 16) & 0xff),
+		REG_SEQ0(0xe05c, (addr >> 8) & 0xff),
+		REG_SEQ0(0xe05d, addr & 0xff),
+		REG_SEQ0(0xe05a, 0x01),
+		REG_SEQ0(0xe05a, 0x00),
+	};
+
+	regmap_multi_reg_write(lt9611c->regmap, seq_write, ARRAY_SIZE(seq_write));
+}
+
+static unsigned int read_flash_reg_status(struct lt9611c *lt9611c)
+{
+	const struct reg_sequence seq_write[] = {
+		REG_SEQ0(0xe103, 0x3f),
+		REG_SEQ0(0xe103, 0xff),
+		REG_SEQ0(0xe05e, 0x40),
+		REG_SEQ0(0xe056, 0x05),
+		REG_SEQ0(0xe055, 0x25),
+		REG_SEQ0(0xe055, 0x01),
+		REG_SEQ0(0xe058, 0x21),
+	};
+	unsigned int status;
+	int ret;
+
+	regmap_multi_reg_write(lt9611c->regmap, seq_write, ARRAY_SIZE(seq_write));
+	ret = regmap_read(lt9611c->regmap, 0xe05f, &status);
+	if (ret)
+		return 0xff;
+
+	return status;
+}
+
+static void lt9611c_crc_to_sram(struct lt9611c *lt9611c)
+{
+	const struct reg_sequence seq_write[] = {
+		REG_SEQ0(0xe051, 0x00),
+		REG_SEQ0(0xe055, 0xc0),
+		REG_SEQ0(0xe055, 0x80),
+		REG_SEQ0(0xe05e, 0xc0),
+		REG_SEQ0(0xe058, 0x21),
+	};
+
+	regmap_multi_reg_write(lt9611c->regmap, seq_write, ARRAY_SIZE(seq_write));
+}
+
+static void lt9611c_data_to_sram(struct lt9611c *lt9611c)
+{
+	const struct reg_sequence seq_write[] = {
+		REG_SEQ0(0xe051, 0xff),
+		REG_SEQ0(0xe055, 0x80),
+		REG_SEQ0(0xe05e, 0xc0),
+		REG_SEQ0(0xe058, 0x21),
+	};
+
+	regmap_multi_reg_write(lt9611c->regmap, seq_write, ARRAY_SIZE(seq_write));
+}
+
+static void lt9611c_sram_to_flash(struct lt9611c *lt9611c, size_t addr)
+{
+	const struct reg_sequence seq_write[] = {
+		REG_SEQ0(0xe05b, (addr >> 16) & 0xff),
+		REG_SEQ0(0xe05c, (addr >> 8) & 0xff),
+		REG_SEQ0(0xe05d, addr & 0xff),
+		REG_SEQ0(0xe05a, 0x30),
+		REG_SEQ0(0xe05a, 0x00),
+	};
+
+	regmap_multi_reg_write(lt9611c->regmap, seq_write, ARRAY_SIZE(seq_write));
+}
+
+static int lt9611c_block_erase(struct lt9611c *lt9611c)
+{
+	struct device *dev = lt9611c->dev;
+	unsigned int block_num;
+	unsigned int flash_status = 0;
+	u32 flash_addr = 0;
+	int ret;
+
+	for (block_num = 0; block_num < 2; block_num++) {
+		flash_addr = block_num * 0x008000;
+		lt9611c_erase_op(lt9611c, flash_addr);
+		msleep(100);
+		ret = read_poll_timeout(read_flash_reg_status, flash_status,
+					!(flash_status & 0x01),
+					50 * USEC_PER_MSEC, 2500 * USEC_PER_MSEC,
+					false, lt9611c);
+		if (ret) {
+			dev_err(dev, "flash erase timeout for block %u\n", block_num);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int lt9611c_write_data(struct lt9611c *lt9611c, const struct firmware *fw, size_t addr)
+{
+	struct device *dev = lt9611c->dev;
+	int ret;
+	unsigned int page = 0, num = 0, i = 0;
+	size_t size, index;
+	const u8 *data;
+	u8 value;
+
+	data = fw->data;
+	size = fw->size;
+	page = DIV_ROUND_UP(size, LT_PAGE_SIZE);
+	if (page * LT_PAGE_SIZE > FW_SIZE) {
+		dev_err(dev, "firmware size out of range\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "%u pages, total size %zu byte\n", page, size);
+
+	for (num = 0; num < page; num++) {
+		lt9611c_data_to_sram(lt9611c);
+
+		for (i = 0; i < LT_PAGE_SIZE; i++) {
+			index = num * LT_PAGE_SIZE + i;
+			value = (index < size) ? data[index] : 0xff;
+
+			ret = regmap_write(lt9611c->regmap, 0xe059, value);
+			if (ret < 0) {
+				dev_err(dev, "write error at page %u, index %u\n", num, i);
+				return ret;
+			}
+		}
+
+		lt9611c_wren(lt9611c);
+		lt9611c_sram_to_flash(lt9611c, addr);
+
+		addr += LT_PAGE_SIZE;
+	}
+
+	lt9611c_wrdi(lt9611c);
+
+	return 0;
+}
+
+static int lt9611c_write_crc(struct lt9611c *lt9611c, u8 fw_crc, size_t addr)
+{
+	struct device *dev = lt9611c->dev;
+	int ret;
+
+	lt9611c_crc_to_sram(lt9611c);
+	ret = regmap_write(lt9611c->regmap, 0xe059, fw_crc);
+	if (ret < 0) {
+		dev_err(dev, "failed to write crc\n");
+		return ret;
+	}
+
+	lt9611c_wren(lt9611c);
+	lt9611c_sram_to_flash(lt9611c, addr);
+	lt9611c_wrdi(lt9611c);
+
+	dev_dbg(dev, "crc 0x%02x written to flash at addr 0x%zx\n", fw_crc, addr);
+
+	return 0;
+}
+
+static void lt9611c_reset(struct lt9611c *lt9611c)
+{
+	gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
+	usleep_range(10000, 12000);
+
+	gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);
+	msleep(400);
+}
+
+static int lt9611c_upgrade_result(struct lt9611c *lt9611c, u8 fw_crc)
+{
+	struct device *dev = lt9611c->dev;
+	unsigned int crc_result;
+	int ret;
+
+	regmap_write(lt9611c->regmap, 0xe0ee, 0x01);
+	ret = regmap_read(lt9611c->regmap, 0xe021, &crc_result);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to read firmware crc\n");
+
+	if (crc_result != fw_crc) {
+		dev_err(dev, "lt9611c fw upgrade failed, expected crc=0x%02x, read crc=0x%02x\n",
+			fw_crc, crc_result);
+		return -EIO;
+	}
+
+	dev_info(dev, "lt9611c firmware upgrade success, crc=0x%02x\n", crc_result);
+	return 0;
+}
+
+static int lt9611c_firmware_upgrade(struct lt9611c *lt9611c)
+{
+	struct device *dev = lt9611c->dev;
+	const struct firmware *fw;
+	u8 *buffer;
+	size_t total_size = FW_SIZE - 1;
+	u8 fw_crc;
+	int ret;
+
+	/* load firmware — must happen outside the mcu_lock */
+	ret = request_firmware(&fw, FW_FILE, dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to load '%s'\n", FW_FILE);
+
+	if (fw->size > total_size) {
+		dev_err(dev, "firmware too large (%zu > %zu)\n", fw->size, total_size);
+		ret = -EINVAL;
+		goto out_release_fw;
+	}
+	dev_dbg(dev, "firmware size: %zu bytes\n", fw->size);
+
+	buffer = kzalloc(total_size, GFP_KERNEL);
+	if (!buffer) {
+		ret = -ENOMEM;
+		goto out_release_fw;
+	}
+
+	memcpy(buffer, fw->data, fw->size);
+	memset(buffer + fw->size, 0xff, total_size - fw->size);
+
+	fw_crc = crc8(lt9611c_crc8_table, buffer, total_size, 0);
+	kfree(buffer);
+
+	dev_info(dev, "starting firmware upgrade, size: %zu bytes, crc: 0x%02x\n",
+		 fw->size, fw_crc);
+
+	/* hardware access requires mcu_lock */
+	lt9611c_lock(lt9611c);
+
+	lt9611c_config_parameters(lt9611c);
+	ret = lt9611c_block_erase(lt9611c);
+	if (ret < 0)
+		goto out_unlock;
+
+	ret = lt9611c_write_data(lt9611c, fw, 0);
+	if (ret < 0) {
+		dev_err(dev, "failed to write firmware data\n");
+		goto out_unlock;
+	}
+
+	ret = lt9611c_write_crc(lt9611c, fw_crc, FW_SIZE - 1);
+	if (ret < 0) {
+		dev_err(dev, "failed to write firmware crc\n");
+		goto out_unlock;
+	}
+
+	lt9611c_reset(lt9611c);
+	ret = lt9611c_upgrade_result(lt9611c, fw_crc);
+
+out_unlock:
+	lt9611c_unlock(lt9611c);
+out_release_fw:
+	release_firmware(fw);
+	return ret;
+}
+
+static struct lt9611c *bridge_to_lt9611c(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct lt9611c, bridge);
+}
+
+static const struct lt9611c *bridge_to_lt9611c_const(const struct drm_bridge *bridge)
+{
+	return container_of_const(bridge, struct lt9611c, bridge);
+}
+
+static irqreturn_t lt9611c_irq_thread_handler(int irq, void *dev_id)
+{
+	struct lt9611c *lt9611c = dev_id;
+	struct device *dev = lt9611c->dev;
+	int ret;
+	unsigned int irq_status;
+
+	guard(mutex)(&lt9611c->mcu_lock);
+
+	ret = regmap_read(lt9611c->regmap, 0xe084, &irq_status);
+	if (ret) {
+		dev_err(dev, "failed to read irq status: %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	if (!(irq_status & BIT(0)))
+		return IRQ_NONE;
+
+	/*Clear interrupt: hardware requires two writes with delay*/
+	regmap_write(lt9611c->regmap, 0xe0df, irq_status & BIT(0));
+	usleep_range(10000, 12000);
+	regmap_write(lt9611c->regmap, 0xe0df, irq_status & (~BIT(0)));
+
+	schedule_work(&lt9611c->work);
+
+	return IRQ_HANDLED;
+}
+
+static void lt9611c_hpd_work(struct work_struct *work)
+{
+	struct lt9611c *lt9611c = container_of(work, struct lt9611c, work);
+	struct device *dev = lt9611c->dev;
+	static const u8 hpd_data[] = { 0x00 };
+	struct lt9611c_cmd cmd = {
+		.hdr = { LT9611C_FUNC_READ, LT9611C_TYPE_HDMI, 0x31, LT9611C_CMD_SEP },
+		.data = hpd_data,
+		.data_len = 1,
+	};
+	u8 hpd_status;
+	struct lt9611c_rsp rsp = { .data = &hpd_status, .data_len = 1 };
+	bool connected;
+	int ret;
+
+	/* Added delay as need time to reflect hpd after interrupt*/
+	msleep(200);
+
+	mutex_lock(&lt9611c->mcu_lock);
+	ret = lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
+	if (ret)
+		dev_err(dev, "failed to read HPD status\n");
+	else
+		lt9611c->hdmi_connected = (hpd_status == 0x02);
+
+	connected = lt9611c->hdmi_connected;
+	mutex_unlock(&lt9611c->mcu_lock);
+
+	drm_bridge_hpd_notify(&lt9611c->bridge,
+			      connected ? connector_status_connected :
+			      connector_status_disconnected);
+}
+
+static int lt9611c_regulator_init(struct lt9611c *lt9611c)
+{
+	struct device *dev = lt9611c->dev;
+	int ret;
+
+	lt9611c->supplies[0].supply = "vcc";
+	lt9611c->supplies[1].supply = "vdd";
+
+	ret = devm_regulator_bulk_get(dev, 2, lt9611c->supplies);
+
+	return ret;
+}
+
+static struct mipi_dsi_device *lt9611c_attach_dsi(struct lt9611c *lt9611c,
+						  struct device_node *dsi_node)
+{
+	const struct mipi_dsi_device_info info = { "lt9611c", 0, NULL };
+	struct mipi_dsi_device *dsi;
+	struct mipi_dsi_host *host;
+	struct device *dev = lt9611c->dev;
+	int ret;
+
+	host = of_find_mipi_dsi_host_by_node(dsi_node);
+	if (!host)
+		return ERR_PTR(dev_err_probe(dev, -EPROBE_DEFER, "failed to find dsi host\n"));
+
+	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
+	if (IS_ERR(dsi))
+		return ERR_PTR(dev_err_probe(dev, PTR_ERR(dsi), "failed to create dsi device\n"));
+
+	dsi->lanes = 4;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+			 MIPI_DSI_MODE_VIDEO_HSE;
+
+	ret = devm_mipi_dsi_attach(dev, dsi);
+	if (ret < 0)
+		return ERR_PTR(dev_err_probe(dev, ret, "failed to attach dsi to host\n"));
+
+	return dsi;
+}
+
+static int lt9611c_bridge_attach(struct drm_bridge *bridge,
+				 struct drm_encoder *encoder,
+				 enum drm_bridge_attach_flags flags)
+{
+	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
+
+	return drm_bridge_attach(encoder, lt9611c->bridge.next_bridge, bridge, flags);
+}
+
+static enum drm_mode_status
+lt9611c_hdmi_tmds_char_rate_valid(const struct drm_bridge *bridge,
+				  const struct drm_display_mode *mode,
+				  unsigned long long tmds_rate)
+{
+	const struct lt9611c *lt9611c = bridge_to_lt9611c_const(bridge);
+
+	if (tmds_rate > lt9611c->max_tmds_rate)
+		return MODE_CLOCK_HIGH;
+
+	if (tmds_rate < 25000000)
+		return MODE_CLOCK_LOW;
+
+	return MODE_OK;
+}
+
+static void lt9611c_video_setup(struct lt9611c *lt9611c,
+				const struct drm_display_mode *mode)
+{
+	struct device *dev = lt9611c->dev;
+	int ret;
+	u32 h_total, hactive, hsync_len, hfront_porch, hback_porch;
+	u32 v_total, vactive, vsync_len, vfront_porch, vback_porch;
+	u8 timing_data[22];
+	struct lt9611c_rsp rsp = {};
+	u8 framerate;
+	u8 vic = 0x00;
+	struct lt9611c_cmd cmd = {
+		.hdr = { LT9611C_FUNC_WRITE, LT9611C_TYPE_MIPI, 0x33, LT9611C_CMD_SEP },
+		.data = timing_data,
+		.data_len = ARRAY_SIZE(timing_data),
+	};
+
+	guard(mutex)(&lt9611c->mcu_lock);
+	h_total = mode->htotal;
+	hactive = mode->hdisplay;
+	hsync_len = mode->hsync_end - mode->hsync_start;
+	hfront_porch = mode->hsync_start - mode->hdisplay;
+	hback_porch = mode->htotal - mode->hsync_end;
+
+	v_total = mode->vtotal;
+	vactive = mode->vdisplay;
+	vsync_len = mode->vsync_end - mode->vsync_start;
+	vfront_porch = mode->vsync_start - mode->vdisplay;
+	vback_porch = mode->vtotal - mode->vsync_end;
+	framerate = drm_mode_vrefresh(mode);
+	vic = drm_match_cea_mode(mode);
+
+	dev_dbg(dev, "hactive=%d, vactive=%d\n", hactive, vactive);
+	dev_dbg(dev, "framerate=%d\n", framerate);
+	dev_dbg(dev, "vic = 0x%02x\n", vic);
+
+	put_unaligned_be16(h_total,       &timing_data[0]);
+	put_unaligned_be16(hactive,       &timing_data[2]);
+	put_unaligned_be16(hfront_porch,  &timing_data[4]);
+	put_unaligned_be16(hsync_len,     &timing_data[6]);
+	put_unaligned_be16(hback_porch,   &timing_data[8]);
+	put_unaligned_be16(v_total,       &timing_data[10]);
+	put_unaligned_be16(vactive,       &timing_data[12]);
+	put_unaligned_be16(vfront_porch,  &timing_data[14]);
+	put_unaligned_be16(vsync_len,     &timing_data[16]);
+	put_unaligned_be16(vback_porch,   &timing_data[18]);
+	timing_data[20] = framerate;
+	timing_data[21] = vic;
+
+	ret = lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
+	if (ret)
+		dev_err(dev, "video set failed\n");
+}
+
+static void lt9611c_bridge_atomic_enable(struct drm_bridge *bridge,
+					 struct drm_atomic_commit *state)
+{
+	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
+	struct drm_connector *connector;
+	struct drm_connector_state *conn_state;
+	struct drm_crtc_state *crtc_state;
+	struct drm_display_mode *mode;
+
+	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
+	if (WARN_ON(!connector))
+		return;
+
+	conn_state = drm_atomic_get_new_connector_state(state, connector);
+	if (WARN_ON(!conn_state))
+		return;
+
+	crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
+	if (WARN_ON(!crtc_state))
+		return;
+
+	mode = &crtc_state->adjusted_mode;
+
+	lt9611c_video_setup(lt9611c, mode);
+}
+
+static enum drm_connector_status
+lt9611c_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connector)
+{
+	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
+	struct device *dev = lt9611c->dev;
+	int ret;
+	bool connected = false;
+	static const u8 hpd_data[] = { 0x00 };
+	struct lt9611c_cmd cmd = {
+		.hdr = { LT9611C_FUNC_READ, LT9611C_TYPE_HDMI, 0x31, LT9611C_CMD_SEP },
+		.data = hpd_data,
+		.data_len = 1,
+	};
+	u8 hpd_status;
+	struct lt9611c_rsp rsp = { .data = &hpd_status, .data_len = 1 };
+
+	guard(mutex)(&lt9611c->mcu_lock);
+
+	ret = lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
+	if (ret)
+		dev_err(dev, "failed to read HPD status (err=%d)\n", ret);
+	else
+		connected = (hpd_status == 0x02);
+
+	lt9611c->hdmi_connected = connected;
+
+	return connected ? connector_status_connected :
+				connector_status_disconnected;
+}
+
+static int lt9611c_get_edid_block(void *data, u8 *buf,
+				  unsigned int block, size_t len)
+{
+	struct lt9611c *lt9611c = data;
+	struct device *dev = lt9611c->dev;
+	u8 edid_raw[LT9611C_CMD_Y0_SIZE + LT9611C_EDID_BUF_SIZE];
+	u8 y0;
+	int ret, i, offset = 0;
+	struct lt9611c_cmd cmd = {
+		.hdr = { LT9611C_FUNC_READ, LT9611C_TYPE_HDMI, 0x33, LT9611C_CMD_SEP },
+	};
+	struct lt9611c_rsp rsp = {
+		.data = edid_raw,
+		.data_len = LT9611C_CMD_Y0_SIZE + LT9611C_EDID_BUF_SIZE,
+	};
+
+	if (len != 128)
+		return -EINVAL;
+	guard(mutex)(&lt9611c->mcu_lock);
+
+	for (i = 0; i < 4; i++) {
+		y0 = block * 4 + i;
+		cmd.data = &y0;
+		cmd.data_len = 1;
+		ret = lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
+		if (ret) {
+			dev_err(dev, "Failed to read EDID block %u packet %d\n",
+				block, i);
+			return ret;
+		}
+		memcpy(buf + offset, &edid_raw[LT9611C_CMD_Y0_SIZE], LT9611C_EDID_BUF_SIZE);
+		offset += LT9611C_EDID_BUF_SIZE;
+	}
+
+	return 0;
+}
+
+static const struct drm_edid *lt9611c_bridge_edid_read(struct drm_bridge *bridge,
+						       struct drm_connector *connector)
+{
+	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
+
+	return drm_edid_read_custom(connector, lt9611c_get_edid_block, lt9611c);
+}
+
+static int lt9611c_write_infoframe(struct lt9611c *lt9611c, u8 type,
+				   const u8 *buffer, size_t len)
+{
+	u8 extra[1 + LT9611C_INFOFRAME_MAX_SIZE];
+	struct lt9611c_rsp rsp = {};
+	struct lt9611c_cmd cmd = {
+		.hdr = { LT9611C_FUNC_WRITE, LT9611C_TYPE_HDMI, 0x35, LT9611C_CMD_SEP },
+	};
+
+	if (WARN_ON(len > LT9611C_INFOFRAME_MAX_SIZE))
+		return -EINVAL;
+
+	extra[0] = type;
+	memcpy(&extra[1], buffer, len);
+	cmd.data = extra;
+	cmd.data_len = 1 + len;
+
+	guard(mutex)(&lt9611c->mcu_lock);
+
+	return lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
+}
+
+static int lt9611c_clear_infoframe(struct lt9611c *lt9611c, u8 type)
+{
+	u8 clear_data = type;
+	struct lt9611c_cmd cmd = {
+		.hdr = { LT9611C_FUNC_WRITE, LT9611C_TYPE_HDMI, 0x42, LT9611C_CMD_SEP },
+		.data = &clear_data,
+		.data_len = 1,
+	};
+	struct lt9611c_rsp rsp = {};
+
+	guard(mutex)(&lt9611c->mcu_lock);
+
+	return lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
+}
+
+static int lt9611c_hdmi_write_avi_infoframe(struct drm_bridge *bridge,
+					    const u8 *buffer, size_t len)
+{
+	return lt9611c_write_infoframe(bridge_to_lt9611c(bridge), 0x01, buffer, len);
+}
+
+static int lt9611c_hdmi_clear_avi_infoframe(struct drm_bridge *bridge)
+{
+	return lt9611c_clear_infoframe(bridge_to_lt9611c(bridge), 0x01);
+}
+
+static int lt9611c_hdmi_write_hdmi_infoframe(struct drm_bridge *bridge,
+					     const u8 *buffer, size_t len)
+{
+	return lt9611c_write_infoframe(bridge_to_lt9611c(bridge), 0x04, buffer, len);
+}
+
+static int lt9611c_hdmi_clear_hdmi_infoframe(struct drm_bridge *bridge)
+{
+	return lt9611c_clear_infoframe(bridge_to_lt9611c(bridge), 0x04);
+}
+
+static int lt9611c_hdmi_write_audio_infoframe(struct drm_bridge *bridge,
+					      const u8 *buffer, size_t len)
+{
+	return lt9611c_write_infoframe(bridge_to_lt9611c(bridge), 0x02, buffer, len);
+}
+
+static int lt9611c_hdmi_clear_audio_infoframe(struct drm_bridge *bridge)
+{
+	return lt9611c_clear_infoframe(bridge_to_lt9611c(bridge), 0x02);
+}
+
+static int lt9611c_hdmi_audio_prepare(struct drm_bridge *bridge,
+				      struct drm_connector *connector,
+				      struct hdmi_codec_daifmt *fmt,
+				      struct hdmi_codec_params *hparms)
+{
+	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
+	u8 audio_extra[2];
+	struct lt9611c_rsp rsp = {};
+	int ret;
+	struct lt9611c_cmd cmd = {
+		.hdr = { LT9611C_FUNC_WRITE, LT9611C_TYPE_HDMI, 0x36, LT9611C_CMD_SEP },
+				   .data = audio_extra,
+				   .data_len = ARRAY_SIZE(audio_extra) };
+
+	if (hparms->sample_width == 32)
+		return -EINVAL;
+
+	switch (fmt->fmt) {
+	case HDMI_I2S:
+		audio_extra[0] = 0x01;
+		break;
+	case HDMI_SPDIF:
+		audio_extra[0] = 0x02;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	audio_extra[1] = hparms->channels;
+
+	scoped_guard(mutex, &lt9611c->mcu_lock) {
+		ret = lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
+		if (ret < 0) {
+			dev_err(lt9611c->dev, "set audio info failed!\n");
+			return ret;
+		}
+	}
+
+	return drm_atomic_helper_connector_hdmi_update_audio_infoframe(connector,
+									&hparms->cea);
+}
+
+static void lt9611c_hdmi_audio_shutdown(struct drm_bridge *bridge,
+					struct drm_connector *connector)
+{
+	drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
+}
+
+static const struct drm_bridge_funcs lt9611c_bridge_funcs = {
+	.attach = lt9611c_bridge_attach,
+	.detect = lt9611c_bridge_detect,
+	.edid_read = lt9611c_bridge_edid_read,
+	.atomic_enable = lt9611c_bridge_atomic_enable,
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
+
+	.hdmi_tmds_char_rate_valid = lt9611c_hdmi_tmds_char_rate_valid,
+	.hdmi_write_avi_infoframe = lt9611c_hdmi_write_avi_infoframe,
+	.hdmi_clear_avi_infoframe = lt9611c_hdmi_clear_avi_infoframe,
+	.hdmi_write_hdmi_infoframe = lt9611c_hdmi_write_hdmi_infoframe,
+	.hdmi_clear_hdmi_infoframe = lt9611c_hdmi_clear_hdmi_infoframe,
+	.hdmi_write_audio_infoframe = lt9611c_hdmi_write_audio_infoframe,
+	.hdmi_clear_audio_infoframe = lt9611c_hdmi_clear_audio_infoframe,
+
+	.hdmi_audio_prepare = lt9611c_hdmi_audio_prepare,
+	.hdmi_audio_shutdown = lt9611c_hdmi_audio_shutdown,
+};
+
+static int lt9611c_parse_dt(struct device *dev,
+			    struct lt9611c *lt9611c)
+{
+	int ret;
+
+	lt9611c->dsi0_node = of_graph_get_remote_node(dev->of_node, 0, -1);
+	if (!lt9611c->dsi0_node)
+		return dev_err_probe(dev, -ENODEV, "failed to get remote node for primary dsi\n");
+
+	lt9611c->dsi1_node = of_graph_get_remote_node(dev->of_node, 1, -1);
+
+	if (lt9611c->dsi1_node && lt9611c->chip_type == CHIP_LT9611C) {
+		ret = dev_err_probe(dev, -EINVAL,
+				    "LT9611C does not support dual DSI\n");
+		goto err_put_dsi1;
+	}
+
+	lt9611c->bridge.next_bridge = of_drm_get_bridge_by_endpoint(dev->of_node, 2, -1);
+	if (IS_ERR(lt9611c->bridge.next_bridge)) {
+		ret = PTR_ERR(lt9611c->bridge.next_bridge);
+		goto err_put_dsi1;
+	}
+
+	return 0;
+
+err_put_dsi1:
+	of_node_put(lt9611c->dsi1_node);
+	of_node_put(lt9611c->dsi0_node);
+	return ret;
+}
+
+static int lt9611c_read_version(struct lt9611c *lt9611c)
+{
+	u8 buf[2];
+	int ret;
+
+	ret = regmap_write(lt9611c->regmap, 0xe0ee, 0x01);
+	if (ret)
+		return ret;
+
+	ret = regmap_bulk_read(lt9611c->regmap, 0xe080, buf, ARRAY_SIZE(buf));
+	if (ret)
+		return ret;
+
+	return (buf[0] << 8) | buf[1];
+}
+
+static int lt9611c_read_chipid(struct lt9611c *lt9611c)
+{
+	struct device *dev = lt9611c->dev;
+	u8 chipid[2];
+	int ret;
+
+	ret = regmap_write(lt9611c->regmap, 0xe0ee, 0x01);
+	if (ret)
+		return ret;
+
+	ret = regmap_bulk_read(lt9611c->regmap, 0xe100, chipid, 2);
+	if (ret)
+		return ret;
+
+	if (chipid[0] != 0x23 || chipid[1] != 0x06) {
+		dev_err(dev, "ChipID: 0x%02x 0x%02x\n", chipid[0], chipid[1]);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static ssize_t firmware_store(struct device *dev, struct device_attribute *attr,
+				      const char *buf, size_t len)
+{
+	struct lt9611c *lt9611c = dev_get_drvdata(dev);
+	int ret;
+
+	dev_warn(dev, "starting firmware upgrade — display will be disrupted\n");
+
+	ret = lt9611c_firmware_upgrade(lt9611c);
+	if (ret < 0) {
+		dev_err(dev, "upgrade failure\n");
+		return ret;
+	}
+
+	lt9611c_lock(lt9611c);
+	lt9611c->fw_version = lt9611c_read_version(lt9611c);
+	lt9611c_unlock(lt9611c);
+
+	if (lt9611c->fw_version < 0)
+		dev_warn(dev, "upgrade succeeded but failed to read new fw version\n");
+	else
+		dev_info(dev, "firmware upgrade succeeded, version: 0x%04x\n",
+			 lt9611c->fw_version);
+
+	return len;
+}
+
+static ssize_t firmware_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct lt9611c *lt9611c = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "0x%04x\n", lt9611c->fw_version);
+}
+
+static DEVICE_ATTR_RW(firmware);
+
+static struct attribute *lt9611c_attrs[] = {
+	&dev_attr_firmware.attr,
+	NULL,
+};
+
+static const struct attribute_group lt9611c_attr_group = {
+	.attrs = lt9611c_attrs,
+};
+
+static const struct attribute_group *lt9611c_attr_groups[] = {
+	&lt9611c_attr_group,
+	NULL,
+};
+
+static int lt9611c_probe(struct i2c_client *client)
+{
+	struct lt9611c *lt9611c;
+	struct device *dev = &client->dev;
+	bool fw_updated = false;
+	int ret;
+
+	crc8_populate_msb(lt9611c_crc8_table, LT9611C_CRC_POLYNOMIAL);
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return dev_err_probe(dev, -ENODEV, "device doesn't support I2C\n");
+
+	lt9611c = devm_drm_bridge_alloc(dev, struct lt9611c, bridge, &lt9611c_bridge_funcs);
+	if (IS_ERR(lt9611c))
+		return dev_err_probe(dev, PTR_ERR(lt9611c), "drm bridge alloc failed.\n");
+
+	lt9611c->dev = dev;
+	lt9611c->client = client;
+
+	const struct lt9611c_chip_data *cdata = i2c_get_match_data(client);
+
+	if (!cdata)
+		return dev_err_probe(dev, -EINVAL, "no match data for device\n");
+
+	lt9611c->chip_type = cdata->chip_type;
+	lt9611c->max_tmds_rate = cdata->max_tmds_rate;
+
+	ret = devm_mutex_init(dev, &lt9611c->mcu_lock);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to init mutex\n");
+
+	lt9611c->regmap = devm_regmap_init_i2c(client, &lt9611c_regmap_config);
+	if (IS_ERR(lt9611c->regmap))
+		return dev_err_probe(dev, PTR_ERR(lt9611c->regmap), "regmap i2c init failed\n");
+
+	ret = lt9611c_parse_dt(dev, lt9611c);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to parse device tree\n");
+
+	lt9611c->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(lt9611c->reset_gpio)) {
+		ret = PTR_ERR(lt9611c->reset_gpio);
+		goto err_of_put;
+	}
+
+	ret = lt9611c_regulator_init(lt9611c);
+	if (ret < 0)
+		goto err_of_put;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
+	if (ret)
+		goto err_of_put;
+
+	lt9611c_reset(lt9611c);
+
+	lt9611c_lock(lt9611c);
+
+	ret = lt9611c_read_chipid(lt9611c);
+	if (ret < 0) {
+		dev_err(dev, "failed to read chip id.\n");
+		lt9611c_unlock(lt9611c);
+		goto err_disable_regulators;
+	}
+
+retry:
+	lt9611c->fw_version = lt9611c_read_version(lt9611c);
+	if (lt9611c->fw_version < 0) {
+		dev_err(dev, "failed to read fw version\n");
+		ret = -EOPNOTSUPP;
+		lt9611c_unlock(lt9611c);
+		goto err_disable_regulators;
+
+	} else if (lt9611c->fw_version == 0) {
+		if (!fw_updated) {
+			fw_updated = true;
+			lt9611c_unlock(lt9611c);
+			ret = lt9611c_firmware_upgrade(lt9611c);
+			if (ret < 0)
+				goto err_disable_regulators;
+			lt9611c_lock(lt9611c);
+			goto retry;
+
+		} else {
+			dev_err(dev, "fw version 0x%04x, update failed\n", lt9611c->fw_version);
+			ret = -EOPNOTSUPP;
+			lt9611c_unlock(lt9611c);
+			goto err_disable_regulators;
+		}
+	}
+
+	lt9611c_unlock(lt9611c);
+	dev_dbg(dev, "current version:0x%04x", lt9611c->fw_version);
+
+	INIT_WORK(&lt9611c->work, lt9611c_hpd_work);
+
+	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+					lt9611c_irq_thread_handler,
+					IRQF_TRIGGER_FALLING |
+					IRQF_ONESHOT |
+					IRQF_NO_AUTOEN,
+					"lt9611c", lt9611c);
+	if (ret) {
+		dev_err(dev, "failed to request irq\n");
+		goto err_disable_regulators;
+	}
+
+	lt9611c->bridge.of_node = client->dev.of_node;
+	lt9611c->bridge.ops = DRM_BRIDGE_OP_DETECT |
+			DRM_BRIDGE_OP_EDID |
+			DRM_BRIDGE_OP_HPD |
+			DRM_BRIDGE_OP_HDMI |
+			DRM_BRIDGE_OP_HDMI_AUDIO;
+	lt9611c->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
+
+	lt9611c->bridge.vendor = "Lontium";
+	lt9611c->bridge.product = "LT9611C";
+
+	lt9611c->bridge.hdmi_audio_dev = dev;
+	lt9611c->bridge.hdmi_audio_max_i2s_playback_channels = 8;
+	lt9611c->bridge.hdmi_audio_dai_port = 2;
+
+	drm_bridge_add(&lt9611c->bridge);
+
+	/* Attach primary DSI */
+	lt9611c->dsi0 = lt9611c_attach_dsi(lt9611c, lt9611c->dsi0_node);
+	if (IS_ERR(lt9611c->dsi0)) {
+		ret = PTR_ERR(lt9611c->dsi0);
+		goto err_remove_bridge;
+	}
+
+	/* Attach secondary DSI, if specified */
+	if (lt9611c->dsi1_node) {
+		lt9611c->dsi1 = lt9611c_attach_dsi(lt9611c, lt9611c->dsi1_node);
+		if (IS_ERR(lt9611c->dsi1)) {
+			ret = PTR_ERR(lt9611c->dsi1);
+			goto err_remove_bridge;
+		}
+	}
+
+	lt9611c->hdmi_connected = false;
+	i2c_set_clientdata(client, lt9611c);
+	enable_irq(client->irq);
+
+	return 0;
+
+err_remove_bridge:
+	drm_bridge_remove(&lt9611c->bridge);
+	cancel_work_sync(&lt9611c->work);
+
+err_disable_regulators:
+	regulator_bulk_disable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
+
+err_of_put:
+	of_node_put(lt9611c->dsi1_node);
+	of_node_put(lt9611c->dsi0_node);
+
+	return ret;
+}
+
+static void lt9611c_remove(struct i2c_client *client)
+{
+	struct lt9611c *lt9611c = i2c_get_clientdata(client);
+
+	disable_irq(client->irq);
+	cancel_work_sync(&lt9611c->work);
+	drm_bridge_remove(&lt9611c->bridge);
+	regulator_bulk_disable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
+	of_node_put(lt9611c->dsi1_node);
+	of_node_put(lt9611c->dsi0_node);
+}
+
+static int lt9611c_bridge_suspend(struct device *dev)
+{
+	struct lt9611c *lt9611c = dev_get_drvdata(dev);
+	int ret;
+
+	disable_irq(lt9611c->client->irq);
+	cancel_work_sync(&lt9611c->work);
+
+	gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
+
+	ret = regulator_bulk_disable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
+	if (ret) {
+		dev_err(lt9611c->dev, "regulator bulk disable failed.\n");
+		gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);
+		enable_irq(lt9611c->client->irq);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int lt9611c_bridge_resume(struct device *dev)
+{
+	struct lt9611c *lt9611c = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
+	if (ret) {
+		dev_err(lt9611c->dev, "regulator bulk enable failed.\n");
+		return ret;
+	}
+	lt9611c_reset(lt9611c);
+	enable_irq(lt9611c->client->irq);
+
+	return ret;
+}
+
+static const struct dev_pm_ops lt9611c_bridge_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(lt9611c_bridge_suspend,
+				lt9611c_bridge_resume)
+};
+
+static struct i2c_device_id lt9611c_id[] = {
+	{ "lontium,lt9611c",   (kernel_ulong_t)&lt9611c_chip_data[CHIP_LT9611C]   },
+	{ "lontium,lt9611ex",  (kernel_ulong_t)&lt9611c_chip_data[CHIP_LT9611EX]  },
+	{ "lontium,lt9611uxd", (kernel_ulong_t)&lt9611c_chip_data[CHIP_LT9611UXD] },
+	{ /* sentinel */ }
+};
+
+static const struct of_device_id lt9611c_match_table[] = {
+	{ .compatible = "lontium,lt9611c",   .data = &lt9611c_chip_data[CHIP_LT9611C]   },
+	{ .compatible = "lontium,lt9611ex",  .data = &lt9611c_chip_data[CHIP_LT9611EX]  },
+	{ .compatible = "lontium,lt9611uxd", .data = &lt9611c_chip_data[CHIP_LT9611UXD] },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, lt9611c_match_table);
+
+static struct i2c_driver lt9611c_driver = {
+	.driver = {
+		.name = "lt9611c",
+		.of_match_table = lt9611c_match_table,
+		.pm = &lt9611c_bridge_pm_ops,
+		.dev_groups = lt9611c_attr_groups,
+	},
+	.probe = lt9611c_probe,
+	.remove = lt9611c_remove,
+	.id_table = lt9611c_id,
+};
+module_i2c_driver(lt9611c_driver);
+
+MODULE_AUTHOR("SunYun Yang <syyang@lontium.com>");
+MODULE_DESCRIPTION("Lontium LT9611C(EX/UXD) MIPI DSI to HDMI driver");
+MODULE_LICENSE("GPL");
+MODULE_FIRMWARE(FW_FILE);

-- 
2.34.1

