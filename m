Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D8B606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZhcyWkjz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OIedG4uZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D3F410FC96;
	Wed, 21 Oct 2026 07:58:10 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7734010FA96
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 07:57:58 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L5jMg72848656
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 07:57:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5mJ09JBpvleqe+LHJqtulMUnVv8bhuVqa0vh8OOGzk4=; b=ZhcyWkjzyS39wApZ
 yofhSIpUl+mnA6ZGqvovKaMigRi7PSfmuhcmD4PJ7gbCKgarIj4nJrEf+jcAlTAx
 yZ/qidyNILe6ni0i4S8YzkAa/LS4t763Sx3gzkgD4eqEp1R5ujJYoG7K/uIu/htG
 O1cbely662PkDrD1+u3E7KaFx/+6YHcXtpZAZ0uvVRDtuLjec3vv6GXZH//4Vswk
 dWZZq4QkuQ8hV3gJauAwxMhykhQ3POwMfITKAsrbXCGcBbS6ynw6dFx+VvKqUCN+
 pn9leQb8WzawERnjVpn6PtrQefJufL7UbifwruQgI0UVKCe1adl9zCtcrLcjOHl5
 xXILVw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heeb9afjw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 07:57:56 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33713e5e6daso738194eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 00:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792569476; x=1793174276;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5mJ09JBpvleqe+LHJqtulMUnVv8bhuVqa0vh8OOGzk4=;
 b=OIedG4uZu1tYnu37dpLWbOJS3CKq9hT3R/DcUwYvtuAD4FmSWl9J6oyXa9lDCteUVc
 9huzrBoXm5NDDtOf43okSdg3/AEYjZTs+BRz1GjOTjIM0+FJdVxMV+SbxyYckrbwIjZ2
 ZaNIkLdy06RKK/p2KSovDojkyrLRXI7DMFwgUNFpdLELyCrZTWEb9Xh/3eFSNu2Lbecf
 k8W3LMVbb/byg8UfdqI2F7DdO7G+OpJsafmNANQv8zBScQ5LfxURARjtrllkFvlN5e5B
 KleX6jw5zJgAUbOOqy5OTutoqmiSq2ltfEht8kwM/IGO18C1fK4T31Sw+whpXvcNuNOk
 7s1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792569476; x=1793174276;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5mJ09JBpvleqe+LHJqtulMUnVv8bhuVqa0vh8OOGzk4=;
 b=y5ZEjqoIZjXruo1rtET4h6hjMSi3Nztg7tocAXkTJR7eSG4i778saJILDJVWlce8ZE
 lMIy5h458F/4UE0vJYaJ0pf6xc5r7toRvaCLlx6gLvVgQAwiYS7Aw4uGixwHFGpNOyA5
 oKVAfU2rsTLDegWjCL+187LJ46mQxHIX4tVTzmuMpj2IrUEzokIocJFcyJB2uCwWijk7
 ZgBeu12MaKO0+HPYXRclMBRpNfYyYm++OvYq+1oJKITkZjEWQIANMtDyI4MZMvWvjoWH
 0n40hk8d8yQWxwNrdlIR0FSokQYHtnimE3rXHh8v2TgpzYQFfuoqV+RwIiT552mbqqfR
 XXKg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzb1YlqKNF0T6dBpwixuOkdlpYY6dOhnVjd8vM4h7dgqKL8OlCUn/Mxbk8ffZUJ42nFG+dA2mzykNo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIFHTTjxoieK9Ab5UhM+ZeOftLqxn41kBwFLK97YT4T2dq+7N6F
 8c6Wh37WPdpMCW0lAkyiJn0IOpfTz0cjycnCTAPs6sW2WE0UeBhU957LC7bLwIrWWbENZaS2+z8
 oE9lQdZ2JuAHRYFJAOEZeyczsT2FytoPzxsaaPbTH6vpwQI69as6JOeXpZ+Zb/knVYnlAdeY=
X-Gm-Gg: AYBFou3iP0QiV1UZGuF4i9SHsUVsB41AGaQMmI74GR6uimP8L0wKC1aN+LXlpUkORDR
 zgJTbupqRZlYnoBI4agpgtfpJ45R+ZiGo0pKxuvs5crYawTC98+D3c4Ulrx/iaG7b8mYuepX7Jm
 oTz6pKzgI2XAUgacK1PTsaPglxXLu+buVailWiLnCgEirDtCXzy7S4OcOCb3fu4i6fF5wVnBk2V
 SqIPJ0SCWO9CngICJqnvqDc3XIGillY8gmOSSVFtwLuvp/mrkY1RFmHtuxFkQbDqFQsFYgRpJPM
 xSlMfSb58JkdQQVszzE/Y4QUcGbVogiM5G1xABRcT5MYbXrkqpHehAo7MEytBJK7RT8FJuZtEEL
 aCkY6zk6cxW+ROmLIa8NUuwBE
X-Received: by 2002:a05:7301:550d:b0:366:7b5c:820e with SMTP id
 5a478bee46e88-367477b28dfmr1950534eec.0.1792569475154; 
 Wed, 21 Oct 2026 00:57:55 -0700 (PDT)
X-Received: by 2002:a05:7301:550d:b0:366:7b5c:820e with SMTP id
 5a478bee46e88-367477b28dfmr1950445eec.0.1792569472508; 
 Wed, 21 Oct 2026 00:57:52 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36741e71eaesm10244209eec.26.2026.10.21.00.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 00:57:51 -0700 (PDT)
From: mohit.dsor@oss.qualcomm.com
Date: Wed, 21 Oct 2026 13:27:19 +0530
Subject: [PATCH v18 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI
 to HDMI driver
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261021-lt9611c-v7-v18-2-4978b94896f1@oss.qualcomm.com>
References: <20261021-lt9611c-v7-v18-0-4978b94896f1@oss.qualcomm.com>
In-Reply-To: <20261021-lt9611c-v7-v18-0-4978b94896f1@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
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
Cc: Mohit Dsor <mohit.dsor@oss.qualcomm.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>,
 Sunyun Yang <syyang@lontium.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792569448; l=42250;
 i=mohit.dsor@oss.qualcomm.com; s=20260808; h=from:subject:message-id;
 bh=yFFQ/s6SCNGf1D/oPVNy8YYsxZPA6cUTVjejQa+ifhs=;
 b=CsG8ZLJfEonDA67dTS09SY2ruVWQxAgUUxEWZPZwdIF9tniW9TkEKlcA6gcSnRqkHUoxI1spI
 fDgHSu0DJw8BnhNdvBhLUUfVSltkABzZLKc7ltJi5yeotmFfK85xbZM
X-Developer-Key: i=mohit.dsor@oss.qualcomm.com; a=ed25519;
 pk=outHVBN53JhozDw1xkj3G1qrqqE5scMBP7M4WL3aHQQ=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAzMSBTYWx0ZWRfXxLhrllfOk6wh
 1m23uYemMQDWd+oXuv4fQvJOJQtfMMCX4uu3QqZw22hyEIBd3MrjhboD3/SRe2YsOyl7/5Nx9aK
 V6HBRb3zHZuHNIoiVLf+CK4xZWbY95I=
X-Proofpoint-GUID: 0GnIH-FsjmNgaYRNaCPttHy3CfioFTx7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAzMSBTYWx0ZWRfX4bGnegvARZhN
 JVJDUKk9MPcm9WS52qlHBqtps9Gmv3ijvXUfTCCeG/ekA92xbXBnEZEt3d9U9qH/p9D7LmXiG1M
 gp6CVWJx6rctKLFolQagE+RCsnWs4UMlE4HRu1bov52tYXVYBYHB+33tgVsEkYOehzg4kjao/Br
 /Jw1h+ARpwnc9eNZg0aRylczIZDRwdB3npbdmLVIzzlXPgERWycufT3BtTkxbwkRjmL7T5Bi8/0
 ATp08qyBm66dRA6BpK8049mNJJmkEHyxbXzEnGTVTZzlJQiEjl+jWa2zLTQPh8PQuihhWJOJ1m+
 /CVUYCrZWiLVJsIeMTQU9J7HtGQ/N62jwpAOvyhYjijNmlb5A888RSnvN5Fsb2zxsMW20whP5BM
 LcdRNvufiNwX7yzyEIjBwL1bGmRVDozp+YzTtby6FctnlIthgwQ7HqChmjXBBjc6sDeC3UgdjWn
 ueHCibEFHHAi/5UUVUA==
X-Authority-Analysis: v=2.4 cv=R42WitRX c=1 sm=1 tr=0 ts=6ad87084 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=Kz8-B0t5AAAA:8 a=EUspDBNiAAAA:8 a=YZJnAe6K5UBwDXtkP4YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-ORIG-GUID: 0GnIH-FsjmNgaYRNaCPttHy3CfioFTx7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210031
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sunyun Yang <syyang@lontium.com>

LT9611C(EX/UXD) is an I2C-controlled chip that receives single or dual
port MIPI DSI and outputs HDMI. Differences in hardware features:
- LT9611C:   supports 1-port MIPI DSI to HDMI 1.4
- LT9611EX:  supports 2-port MIPI DSI to HDMI 1.4
- LT9611UXD: supports 2-port MIPI DSI to HDMI 1.4/2.0

The driver supports:
- EDID read and mode filtering via custom MCU command protocol
- HPD detection and interrupt handling
- HDMI audio output via I2S
- Firmware upgrade via sysfs
- Dual DSI bonded mode for LT9611EX and LT9611UXD variants

Signed-off-by: Sunyun Yang <syyang@lontium.com>
Co-developed-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
---
 Documentation/ABI/testing/sysfs-lontium-firmware |   10 +
 drivers/gpu/drm/bridge/Kconfig                   |   17 +
 drivers/gpu/drm/bridge/Makefile                  |    1 +
 drivers/gpu/drm/bridge/lontium-lt9611c.c         | 1361 ++++++++++++++++++++++
 4 files changed, 1389 insertions(+)

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
index c7da6b02d7b6..0a66831fb482 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -177,6 +177,23 @@ config DRM_LONTIUM_LT9611
 	  HDMI signals
 	  Please say Y if you have such hardware.
 
+config DRM_LONTIUM_LT9611C
+	tristate "Lontium LT9611C DSI/HDMI bridge"
+	select SND_SOC_HDMI_CODEC if SND_SOC
+	depends on OF && I2C
+	select CRC8
+	select FW_LOADER
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
index 000000000000..8fc86c073212
--- /dev/null
+++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
@@ -0,0 +1,1361 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Lontium Semiconductor, Inc.
+ * Copyright (C) Qualcomm Technologies, Inc. and/or its subsidiaries.
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
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_edid.h>
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/display/drm_hdmi_audio_helper.h>
+#include <drm/display/drm_hdmi_state_helper.h>
+#include <sound/hdmi-codec.h>
+
+#define FW_SIZE (64 * 1024)
+#define LT_PAGE_SIZE 256
+#define FW_FILE  "Lontium/lt9611c_fw.bin"
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
+	struct gpio_desc *reset_gpio;
+	struct regulator_bulk_data supplies[2];
+	int fw_version;
+	const struct lt9611c_chip_data *cdata;
+	bool hdmi_connected;
+	bool dual_dsi;
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
+	ret = regmap_bulk_read(lt9611c->regmap, 0xe085, /* MCU response buffer */
+			       &rsp->hdr, LT9611C_CMD_HDR_SIZE);
+	if (ret)
+		return ret;
+
+	if (rsp->data && rsp->data_len)
+		ret = regmap_bulk_read(lt9611c->regmap,
+				       0xe085 + LT9611C_CMD_HDR_SIZE, /* data follows header */
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
+		REG_SEQ0(0xe103, 0x3f), /* fifo rst */
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
+static void lt9611c_wr_enable(struct lt9611c *lt9611c)
+{
+	regmap_write(lt9611c->regmap, 0xe05a, 0x04);
+	regmap_write(lt9611c->regmap, 0xe05a, 0x00);
+}
+
+static void lt9611c_wr_disable(struct lt9611c *lt9611c)
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
+	unsigned int npages;
+	unsigned int flash_status;
+	int ret;
+	size_t size = fw->size;
+	const u8 *data = fw->data;
+
+	npages = DIV_ROUND_UP(size, LT_PAGE_SIZE);
+	if (npages * LT_PAGE_SIZE > FW_SIZE) {
+		dev_err(dev, "firmware size out of range\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "%u pages, total size %zu byte\n", npages, size);
+
+	for (unsigned int num = 0; num < npages; num++) {
+		lt9611c_data_to_sram(lt9611c);
+
+		for (unsigned int i = 0; i < LT_PAGE_SIZE; i++) {
+			size_t index = num * LT_PAGE_SIZE + i;
+			u8 value = (index < size) ? data[index] : 0xff;
+
+			ret = regmap_write(lt9611c->regmap, 0xe059, value);
+			if (ret < 0) {
+				dev_err(dev, "write error at page %u, index %u\n", num, i);
+				return ret;
+			}
+		}
+
+		lt9611c_wr_enable(lt9611c);
+		lt9611c_sram_to_flash(lt9611c, addr);
+
+		ret = read_poll_timeout(read_flash_reg_status, flash_status,
+					!(flash_status & 0x01),
+					50 * USEC_PER_MSEC, 2500 * USEC_PER_MSEC,
+					false, lt9611c);
+		if (ret) {
+			dev_err(dev, "flash write timeout at page %u\n", num);
+			return ret;
+		}
+
+		addr += LT_PAGE_SIZE;
+	}
+
+	lt9611c_wr_disable(lt9611c);
+
+	return 0;
+}
+
+static int lt9611c_write_crc(struct lt9611c *lt9611c, u8 fw_crc, size_t addr)
+{
+	struct device *dev = lt9611c->dev;
+	unsigned int flash_status;
+	int ret;
+
+	lt9611c_crc_to_sram(lt9611c);
+	ret = regmap_write(lt9611c->regmap, 0xe059, fw_crc);
+	if (ret < 0) {
+		dev_err(dev, "failed to write crc\n");
+		return ret;
+	}
+
+	lt9611c_wr_enable(lt9611c);
+	lt9611c_sram_to_flash(lt9611c, addr);
+
+	ret = read_poll_timeout(read_flash_reg_status, flash_status,
+				!(flash_status & 0x01),
+				50 * USEC_PER_MSEC, 2500 * USEC_PER_MSEC,
+				false, lt9611c);
+	if (ret) {
+		dev_err(dev, "flash crc write timeout\n");
+		return ret;
+	}
+
+	lt9611c_wr_disable(lt9611c);
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
+	const size_t total_size = FW_SIZE - 1;
+	u8 fw_crc;
+	int ret;
+
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
+	fw_crc = crc8(lt9611c_crc8_table, fw->data, fw->size, 0);
+	for (unsigned int i = 0; i < total_size - fw->size; i++)
+		fw_crc = lt9611c_crc8_table[(fw_crc ^ 0xff) & 0xff];
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
+	ret = lt9611c_write_crc(lt9611c, fw_crc, total_size);
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
+	/* Clear interrupt: hardware requires two writes with delay */
+	regmap_write(lt9611c->regmap, 0xe0df, BIT(0));
+	usleep_range(10000, 12000);
+	regmap_write(lt9611c->regmap, 0xe0df, 0x00);
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
+	/*
+	 * Wait for the MCU to debounce and latch the HPD state after the
+	 * interrupt fires. The MCU needs time to update its internal HPD
+	 * register; reading immediately after the interrupt returns stale
+	 * state. 200 ms is empirically sufficient.
+	 */
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
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
+	if (ret)
+		return ret;
+
+	return regulator_bulk_enable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
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
+	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
+		return -EINVAL;
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
+	if (tmds_rate > lt9611c->cdata->max_tmds_rate)
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
+	struct {
+		__be16 htotal;
+		__be16 hactive;
+		__be16 hfront_porch;
+		__be16 hsync_len;
+		__be16 hback_porch;
+		__be16 vtotal;
+		__be16 vactive;
+		__be16 vfront_porch;
+		__be16 vsync_len;
+		__be16 vback_porch;
+		u8 framerate;
+		u8 vic;
+	} timing_data;
+	struct lt9611c_rsp rsp = {};
+	struct lt9611c_cmd cmd = {
+		.hdr = { LT9611C_FUNC_WRITE, LT9611C_TYPE_MIPI, 0x33, LT9611C_CMD_SEP },
+		.data = (u8 *)&timing_data,
+		.data_len = sizeof(timing_data),
+	};
+
+	timing_data.htotal      = cpu_to_be16(mode->htotal);
+	timing_data.hactive     = cpu_to_be16(mode->hdisplay);
+	timing_data.hfront_porch = cpu_to_be16(mode->hsync_start - mode->hdisplay);
+	timing_data.hsync_len   = cpu_to_be16(mode->hsync_end - mode->hsync_start);
+	timing_data.hback_porch = cpu_to_be16(mode->htotal - mode->hsync_end);
+	timing_data.vtotal      = cpu_to_be16(mode->vtotal);
+	timing_data.vactive     = cpu_to_be16(mode->vdisplay);
+	timing_data.vfront_porch = cpu_to_be16(mode->vsync_start - mode->vdisplay);
+	timing_data.vsync_len   = cpu_to_be16(mode->vsync_end - mode->vsync_start);
+	timing_data.vback_porch = cpu_to_be16(mode->vtotal - mode->vsync_end);
+	timing_data.framerate   = drm_mode_vrefresh(mode);
+	timing_data.vic         = drm_match_cea_mode(mode);
+
+	dev_dbg(dev, "hactive=%d, vactive=%d\n", mode->hdisplay, mode->vdisplay);
+	dev_dbg(dev, "framerate=%d\n", timing_data.framerate);
+	dev_dbg(dev, "vic = 0x%02x\n", timing_data.vic);
+
+	guard(mutex)(&lt9611c->mcu_lock);
+
+	ret = lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
+	if (ret)
+		dev_err(dev, "video set failed\n");
+}
+
+/*
+ * Enables dual DSI port input on the LT9611UXD/EX. Must be called
+ * after video_setup when two DSI hosts are connected.
+ */
+static int lt9611c_dual_port_enable(struct lt9611c *lt9611c)
+{
+	static const u8 dual_port_data[] = { 0x02, 0x70 };
+	struct device *dev = lt9611c->dev;
+	u8 ack = 0;
+	int ret;
+	struct lt9611c_rsp rsp = { .data = &ack, .data_len = 1 };
+	struct lt9611c_cmd cmd = {
+		.hdr = { LT9611C_FUNC_WRITE, LT9611C_TYPE_MIPI, 0x31, LT9611C_CMD_SEP },
+		.data = dual_port_data,
+		.data_len = ARRAY_SIZE(dual_port_data),
+	};
+
+	guard(mutex)(&lt9611c->mcu_lock);
+
+	ret = lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
+	if (ret || !ack) {
+		dev_err(dev, "failed to enable dual DSI port (err=%d)\n", ret);
+		return ret ? ret : -EIO;
+	}
+
+	return 0;
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
+	int ret;
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
+
+	if (lt9611c->dual_dsi) {
+		ret = lt9611c_dual_port_enable(lt9611c);
+		if (ret)
+			dev_err(lt9611c->dev, "failed to enable dual DSI port (err=%d)\n", ret);
+	}
+
+	drm_atomic_helper_connector_hdmi_update_infoframes(connector, state);
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
+	lockdep_assert_held(&lt9611c->mcu_lock);
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
+	lockdep_assert_held(&lt9611c->mcu_lock);
+
+	return lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
+}
+
+static int lt9611c_hdmi_write_avi_infoframe(struct drm_bridge *bridge,
+					    const u8 *buffer, size_t len)
+{
+	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
+
+	guard(mutex)(&lt9611c->mcu_lock);
+	return lt9611c_write_infoframe(lt9611c, 0x01, buffer, len);
+}
+
+static int lt9611c_hdmi_clear_avi_infoframe(struct drm_bridge *bridge)
+{
+	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
+
+	guard(mutex)(&lt9611c->mcu_lock);
+	return lt9611c_clear_infoframe(lt9611c, 0x01);
+}
+
+static int lt9611c_hdmi_write_hdmi_infoframe(struct drm_bridge *bridge,
+					     const u8 *buffer, size_t len)
+{
+	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
+
+	guard(mutex)(&lt9611c->mcu_lock);
+	return lt9611c_write_infoframe(lt9611c, 0x04, buffer, len);
+}
+
+static int lt9611c_hdmi_clear_hdmi_infoframe(struct drm_bridge *bridge)
+{
+	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
+
+	guard(mutex)(&lt9611c->mcu_lock);
+	return lt9611c_clear_infoframe(lt9611c, 0x04);
+}
+
+static int lt9611c_hdmi_write_audio_infoframe(struct drm_bridge *bridge,
+					      const u8 *buffer, size_t len)
+{
+	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
+
+	guard(mutex)(&lt9611c->mcu_lock);
+	return lt9611c_write_infoframe(lt9611c, 0x02, buffer, len);
+}
+
+static int lt9611c_hdmi_clear_audio_infoframe(struct drm_bridge *bridge)
+{
+	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
+
+	guard(mutex)(&lt9611c->mcu_lock);
+	return lt9611c_clear_infoframe(lt9611c, 0x02);
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
+	mutex_lock(&lt9611c->mcu_lock);
+	ret = lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
+	mutex_unlock(&lt9611c->mcu_lock);
+	if (ret < 0) {
+		dev_err(lt9611c->dev, "set audio info failed!\n");
+		return ret;
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
+			    struct lt9611c *lt9611c,
+			    struct device_node **dsi0_node,
+			    struct device_node **dsi1_node)
+{
+	int ret;
+
+	*dsi0_node = of_graph_get_remote_node(dev->of_node, 0, -1);
+	if (!*dsi0_node)
+		return dev_err_probe(dev, -ENODEV, "failed to get remote node for primary dsi\n");
+
+	*dsi1_node = of_graph_get_remote_node(dev->of_node, 1, -1);
+
+	if (*dsi1_node && lt9611c->cdata->chip_type == CHIP_LT9611C) {
+		ret = dev_err_probe(dev, -EINVAL,
+				    "LT9611C does not support dual DSI\n");
+		goto err_put_dsi1;
+	}
+
+	if (*dsi1_node)
+		lt9611c->dual_dsi = true;
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
+	of_node_put(*dsi1_node);
+	of_node_put(*dsi0_node);
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
+	if (!lt9611c)
+		return -ENODEV;
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
+	WRITE_ONCE(lt9611c->fw_version, lt9611c_read_version(lt9611c));
+	lt9611c_unlock(lt9611c);
+
+	if (READ_ONCE(lt9611c->fw_version) < 0)
+		dev_warn(dev, "upgrade succeeded but failed to read new fw version\n");
+	else
+		dev_info(dev, "firmware upgrade succeeded, version: 0x%04x\n",
+			 READ_ONCE(lt9611c->fw_version));
+
+	return len;
+}
+
+static ssize_t firmware_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct lt9611c *lt9611c = dev_get_drvdata(dev);
+
+	if (!lt9611c)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "0x%04x\n", READ_ONCE(lt9611c->fw_version));
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
+	struct device_node *dsi0_node = NULL;
+	struct device_node *dsi1_node = NULL;
+	struct mipi_dsi_device *dsi;
+	bool fw_updated = false;
+	int ret;
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
+	i2c_set_clientdata(client, lt9611c);
+
+	const struct lt9611c_chip_data *cdata = i2c_get_match_data(client);
+
+	if (!cdata)
+		return dev_err_probe(dev, -EINVAL, "no match data for device\n");
+
+	lt9611c->cdata = cdata;
+
+	ret = devm_mutex_init(dev, &lt9611c->mcu_lock);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to init mutex\n");
+
+	lt9611c->regmap = devm_regmap_init_i2c(client, &lt9611c_regmap_config);
+	if (IS_ERR(lt9611c->regmap))
+		return dev_err_probe(dev, PTR_ERR(lt9611c->regmap), "regmap i2c init failed\n");
+
+	ret = lt9611c_parse_dt(dev, lt9611c, &dsi0_node, &dsi1_node);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to parse device tree\n");
+
+	lt9611c->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(lt9611c->reset_gpio)) {
+		ret = PTR_ERR(lt9611c->reset_gpio);
+		goto err_put_nodes;
+	}
+
+	ret = lt9611c_regulator_init(lt9611c);
+	if (ret < 0)
+		goto err_put_nodes;
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
+	dsi = lt9611c_attach_dsi(lt9611c, dsi0_node);
+	if (IS_ERR(dsi)) {
+		ret = PTR_ERR(dsi);
+		goto err_remove_bridge;
+	}
+
+	/* Attach secondary DSI, if specified */
+	if (dsi1_node) {
+		dsi = lt9611c_attach_dsi(lt9611c, dsi1_node);
+		if (IS_ERR(dsi)) {
+			ret = PTR_ERR(dsi);
+			goto err_remove_bridge;
+		}
+	}
+
+	lt9611c->hdmi_connected = false;
+	enable_irq(client->irq);
+
+	of_node_put(dsi1_node);
+	of_node_put(dsi0_node);
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
+err_put_nodes:
+	of_node_put(dsi1_node);
+	of_node_put(dsi0_node);
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
+		msleep(400);
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
+static const struct i2c_device_id lt9611c_id[] = {
+	{ .name = "lt9611c",   .driver_data = (kernel_ulong_t)&lt9611c_chip_data[CHIP_LT9611C]   },
+	{ .name = "lt9611ex",  .driver_data = (kernel_ulong_t)&lt9611c_chip_data[CHIP_LT9611EX]  },
+	{ .name = "lt9611uxd", .driver_data = (kernel_ulong_t)&lt9611c_chip_data[CHIP_LT9611UXD] },
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
+
+static int __init lt9611c_init(void)
+{
+	crc8_populate_msb(lt9611c_crc8_table, LT9611C_CRC_POLYNOMIAL);
+	return i2c_add_driver(&lt9611c_driver);
+}
+module_init(lt9611c_init);
+
+static void __exit lt9611c_exit(void)
+{
+	i2c_del_driver(&lt9611c_driver);
+}
+module_exit(lt9611c_exit);
+
+MODULE_AUTHOR("SunYun Yang <syyang@lontium.com>");
+MODULE_DESCRIPTION("Lontium LT9611C(EX/UXD) MIPI DSI to HDMI driver");
+MODULE_LICENSE("GPL");
+MODULE_FIRMWARE(FW_FILE);

-- 
2.34.1

