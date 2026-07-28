Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E9EC531F9
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 11:09:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB4E210E880;
	Tue, 28 Jul 2026 11:09:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="O+7g1MM/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bMrWgXIB";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F61F10E880
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 11:09:48 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SAgFMl2698797
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 11:09:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1KQMXNefNDHDFIUoZ03+XbU7eCnUXG/U1CsBp/t4V+c=; b=O+7g1MM/GtX01WtU
 HNpYGJFiUYMIWhPiC6tw2Cjgfl5N6XqYrfucB9IkY22QLlSMDTWkZsm8AQZpdXDD
 AHyy2SNaQWFJTuAwchC6tz1thLalb6DY3QMNeaMoS2pQgCbI717BjJkF2sac6u0g
 nfckUIz6A27r8TBTudoqWkRwAJTrWNdTJz4wDhijTrHmpuJgC3Xb3OFn9ONY4F7G
 V1NCNKGXfVZfvDQC7soa3AJKk2cyeG33RgkrpqGy9fTervDK2JER6XR24d5IDVjQ
 VJCC7uQu+FDnjX8vVXimCd5L7C+DNwqku5wHeSDJ/UN/0R5CHsDKzDWfpOsMpHU5
 05DACw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fptatg897-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 11:09:47 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc640dfde3so49204225ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 04:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785236987; x=1785841787;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1KQMXNefNDHDFIUoZ03+XbU7eCnUXG/U1CsBp/t4V+c=;
 b=bMrWgXIBbOQQxO95qYbIjt6p/ihYfNoDlJhVHNSLRajfldX0iM8ugxXq1LnFaBSOPr
 9uXRMwF7dMCLMwQwu4LfTB0ku/DT8E5B2kbN81sVyLZ2Xx0BFQWPP7a8xptTj/48Ah55
 StuSWqrieWOrrA03JxEno3P3coIRDuU3SwoDUEwTzIMY5AygSQVoyrsvyDOqZcUsk12C
 2anI13CAM79EjO2Gjo+tBVfygtlW89Te657WjITeCzRUz03Y75r6nKsc4a1u/DG2COsa
 +wytTN0h3vIOY4nGrVnXfGSNJTmpbex1qQKOx0b+rOY2HN28yjtFOX6M1BoyiljL7ZpD
 xq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785236987; x=1785841787;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1KQMXNefNDHDFIUoZ03+XbU7eCnUXG/U1CsBp/t4V+c=;
 b=jZ/9n8ZmxeuX3r/O1AkvK2ZAZnKINdchInArKFm705OQSn3GrqIYe0ow5UMY5+E8eC
 C3lu+9dCmpO9hLNFLp5IsSDnk3Ro9TyWi6asdfCji3ahoOqopf3mQyxAzVgvwmXUIuHQ
 Q3IUjXqEGe30iuEOdTE5mofm1bRovJlcMg/JxUUQga787dHJS8sV8cE9V8EVIZqO6F4a
 kq2rjq2CfPuX7dBtFiub4uyQGrahqI1ksB65xFjuyYcnUWV8x8x/oTWP2LeHWYpuAZyi
 gEtoXXABLwtMeULzecXBE6peSV/4jbO8kwU+6Xrj6+czv7lTiZH+ZJ2qjJ1U8u2cFgkk
 MgZw==
X-Gm-Message-State: AOJu0YwJKAcbacEHECUBoP3O6/NScHJsq9D+qV53N5oatQEiwP4zTzY8
 srNbUHIgdhSM6WS12IySsVj9EETHMRmEn8IkJMSIBoxF2KnIMFRIxwaqqBPBNQoObyiyDHJ64np
 QrH1MMHJB9KTrGKJ8FRC7Pn1WzhfBJWirtpBTbsDPBHpay+0jRDSXJO2fqtHNNFf8v51fp/ia3z
 P3tfI=
X-Gm-Gg: AR+sD11acmSj7Yc5WrGHlO15FEKkNK80HHr2SDq1Pw8YAaQjlm6BtjfQ2uWZGSEPVjk
 hRZ5H90r19kf+7YNPKEM/ubP8fYJywG7Hx9pwWBE57jWXrcLNeSGx1T5hYox8mQ36QzXulqWNzT
 94YjBHvmzJjwSDhfw30FEXVbn275fxaTp2R194AwT58iSMgaR7yiSih8Zy3CV1rHQlZTtx2J64Q
 c9dWDmlCJLpaiWsEmGxOv0f9FmkgQYWyGA/ywUQZKVmhKZSNg6bpgROSSukaVP16ES7ln9hdNE8
 i8mKadhUgfH1MPgs8dAa9Kxo2wZa58KHDUpJgLB+JElwguo9ZL2z5fPvRGuqUxBdkhfX8A0onZa
 IFYkR4DL+ahyyxsmc4uVIvLVIZQ==
X-Received: by 2002:a17:902:d4cd:b0:2c0:e2ea:6b0c with SMTP id
 d9443c01a7336-2d015c17676mr22195475ad.21.1785236986542; 
 Tue, 28 Jul 2026 04:09:46 -0700 (PDT)
X-Received: by 2002:a17:902:d4cd:b0:2c0:e2ea:6b0c with SMTP id
 d9443c01a7336-2d015c17676mr22194905ad.21.1785236985888; 
 Tue, 28 Jul 2026 04:09:45 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde7bc4f4sm50292145ad.39.2026.07.28.04.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 04:09:45 -0700 (PDT)
From: mohit.dsor@oss.qualcomm.com
Date: Tue, 28 Jul 2026 16:39:19 +0530
Subject: [PATCH v8 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI to
 HDMI driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-lt9611c-v7-v8-2-bda216bfaf37@oss.qualcomm.com>
References: <20260728-lt9611c-v7-v8-0-bda216bfaf37@oss.qualcomm.com>
In-Reply-To: <20260728-lt9611c-v7-v8-0-bda216bfaf37@oss.qualcomm.com>
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
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA5OCBTYWx0ZWRfX0IEI/J2IZMGU
 b7EstDpfBfmKFTDpkhcFKUDwh7s+g3SqX9YppVbGkRl05T5EYFwPcYBu8AhOLQvEsOzEQ/mTP7K
 ImMxEw1rYNSdpk90RsVw/VaBxQEPZrY=
X-Proofpoint-ORIG-GUID: -GqhAFv721BMvM8vAwFw4NbZ5o7sBKKw
X-Authority-Analysis: v=2.4 cv=KtJ9H2WN c=1 sm=1 tr=0 ts=6a688dfb cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=Kz8-B0t5AAAA:8 a=EUspDBNiAAAA:8 a=pZRRnxfUaOvZTz4fmkIA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-GUID: -GqhAFv721BMvM8vAwFw4NbZ5o7sBKKw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA5OCBTYWx0ZWRfX40palEPnU2RD
 ABY/GqjqGZSPofk6BW0MoQQD1gQWo+hfICzmJk9scld5RWEb21PPBwFnKE+qo9rkJsGzt78nzXq
 0swHl/kvP2Y2Y073J5et6pfFWNcEqw3mUzTdjDbfq02ob6lHa30eJVA/ThjdOSBagRsu5B1IoPB
 bTHxyZrqfZ00C+raE4tdt2HrIeM0ZB2b2ZMfkBEjaidHFnQo1ND5htG1GVdz0Dix7sygacFnxSy
 xBU4+KJfOjsGz2AGRZ2vIGFR8gc9OHf8mu6ZBfq+dP5X7/5djSXnGLFRSQWyvhYca/iTAvFhxes
 /TUQu15Sr9ISgkGJ1m/JOQR5h7FFhSsflVZaPibUDerbgOfy4SjCbn1osoINvaFA56INVRwZ9cy
 meOMtK185VR1c1RqVU2RmXXhGAVnHnNwR8IpJIQt1AK/ixDZCw06qAYWsQfnGOsRKEgctjZDuYT
 Bwg/BlNN4gSCbhqz22Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280098
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
 .../ABI/testing/sysfs-driver-lontium-lt9611c       |   11 +
 drivers/gpu/drm/bridge/Kconfig                     |   17 +
 drivers/gpu/drm/bridge/Makefile                    |    1 +
 drivers/gpu/drm/bridge/lontium-lt9611c.c           | 1344 ++++++++++++++++++++
 4 files changed, 1373 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-lontium-lt9611c b/Documentation/ABI/testing/sysfs-driver-lontium-lt9611c
new file mode 100644
index 000000000000..440e102a8bd8
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-lontium-lt9611c
@@ -0,0 +1,11 @@
+What:		/sys/bus/i2c/drivers/lt9611c/.../lt9611c_firmware
+Date:		July 2026
+KernelVersion:	7.3
+Contact:	Mohit Dsor <mohit.dsor@oss.qualcomm.com>
+Description:
+		Read: Returns the current firmware version loaded on the
+		LT9611C(EX/UXD) chip in hex format (e.g. "0x0105").
+
+		Write: Triggers a firmware upgrade of the LT9611C(EX/UXD)
+		chip using the firmware file Lontium/lt9611c_fw.bin loaded
+		via the firmware loader.
diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 4a57d49b4c6d..bb3caaff8a12 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -177,6 +177,23 @@ config DRM_LONTIUM_LT9611
 	  HDMI signals
 	  Please say Y if you have such hardware.
 
+config DRM_LONTIUM_LT9611C
+	tristate "Lontium LT9611C DSI/HDMI bridge"
+	select SND_SOC_HDMI_CODEC if SND_SOC
+	depends on OF
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
+	  output. Say Y if you have hardware using this chip.
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
index 000000000000..704b829abe57
--- /dev/null
+++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
@@ -0,0 +1,1344 @@
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
+struct lt9611c {
+	struct device *dev;
+	struct i2c_client *client;
+	struct drm_bridge bridge;
+	struct regmap *regmap;
+	/* Protects all accesses to registers by stopping the on-chip MCU */
+	struct mutex ocm_lock;
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
+	 /* HDMI cable connection status */
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
+	regmap_write(lt9611c->regmap, 0xe0b0 + 0, cmd->hdr.func);
+	regmap_write(lt9611c->regmap, 0xe0b0 + 1, cmd->hdr.type);
+	regmap_write(lt9611c->regmap, 0xe0b0 + 2, cmd->hdr.seq);
+	regmap_write(lt9611c->regmap, 0xe0b0 + 3, cmd->hdr.sep);
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
+static void read_flash_reg_status(struct lt9611c *lt9611c, unsigned int *status)
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
+
+	regmap_multi_reg_write(lt9611c->regmap, seq_write, ARRAY_SIZE(seq_write));
+
+	regmap_read(lt9611c->regmap, 0xe05f, status);
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
+static void lt9611c_block_erase(struct lt9611c *lt9611c)
+{
+	int i;
+	unsigned int block_num;
+	unsigned int flash_status = 0;
+	u32 flash_addr = 0;
+
+	for (block_num = 0; block_num < 2; block_num++) {
+		flash_addr = (block_num * 0x008000);
+		lt9611c_erase_op(lt9611c, flash_addr);
+		msleep(100);
+		i = 0;
+		while (1) {
+			read_flash_reg_status(lt9611c, &flash_status);
+			if ((flash_status & 0x01) == 0)
+				break;
+
+			if (i > 50)
+				break;
+
+			i++;
+			msleep(50);
+		}
+	}
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
+	page = (size + LT_PAGE_SIZE - 1) / LT_PAGE_SIZE;
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
+
+	regmap_write(lt9611c->regmap, 0xe0ee, 0x01);
+	regmap_read(lt9611c->regmap, 0xe021, &crc_result);
+
+	if (crc_result != fw_crc) {
+		dev_err(dev, "lt9611c fw upgrade failed, expected crc=0x%02x, read crc=0x%02x\n",
+			fw_crc, crc_result);
+		return -1;
+	}
+
+	dev_dbg(dev, "lt9611c firmware upgrade success, crc=0x%02x\n", crc_result);
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
+	/* 1. load firmware */
+	ret = request_firmware(&fw, FW_FILE, dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to load '%s'\n", FW_FILE);
+
+	/* 2. check size */
+	if (fw->size > total_size) {
+		dev_err(dev, "firmware too large (%zu > %zu)\n", fw->size, total_size);
+		ret = -EINVAL;
+		goto out_release_fw;
+	}
+	dev_dbg(dev, "firmware size: %zu bytes\n", fw->size);
+
+	/* 3. calculate crc8 */
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
+	/* 4. firmware upgrade */
+	lt9611c_config_parameters(lt9611c);
+	lt9611c_block_erase(lt9611c);
+
+	ret = lt9611c_write_data(lt9611c, fw, 0);
+	if (ret < 0) {
+		dev_err(dev, "failed to write firmware data\n");
+		goto out_release_fw;
+	}
+
+	ret = lt9611c_write_crc(lt9611c, fw_crc, FW_SIZE - 1);
+	if (ret < 0) {
+		dev_err(dev, "failed to write firmware crc\n");
+		goto out_release_fw;
+	}
+
+	/* 5. check upgrade of result */
+	lt9611c_reset(lt9611c);
+	ret = lt9611c_upgrade_result(lt9611c, fw_crc);
+
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
+static void lt9611c_lock(struct lt9611c *lt9611c)
+{
+	mutex_lock(&lt9611c->ocm_lock);
+	regmap_write(lt9611c->regmap, 0xe0ee, 0x01);
+}
+
+static void lt9611c_unlock(struct lt9611c *lt9611c)
+{
+	regmap_write(lt9611c->regmap, 0xe0ee, 0x00);
+	mutex_unlock(&lt9611c->ocm_lock);
+}
+
+static irqreturn_t lt9611c_irq_thread_handler(int irq, void *dev_id)
+{
+	struct lt9611c *lt9611c = dev_id;
+	struct device *dev = lt9611c->dev;
+	int ret;
+	unsigned int irq_status;
+
+	guard(mutex)(&lt9611c->ocm_lock);
+
+	ret = regmap_read(lt9611c->regmap, 0xe084, &irq_status);
+	if (ret) {
+		dev_err(dev, "failed to read irq status: %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	if (!(irq_status & BIT(0)))
+		return IRQ_HANDLED;
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
+	mutex_lock(&lt9611c->ocm_lock);
+	ret = lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
+	if (ret) {
+		dev_err(dev, "failed to read HPD status\n");
+	} else {
+		lt9611c->hdmi_connected = (hpd_status == 0x02);
+	}
+	connected = lt9611c->hdmi_connected;
+	mutex_unlock(&lt9611c->ocm_lock);
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
+	if (lt9611c->chip_type == CHIP_LT9611UXD) {
+		if (tmds_rate > 600000000)
+			return MODE_CLOCK_HIGH;
+
+	} else {
+		if (tmds_rate > 340000000)
+			return MODE_CLOCK_HIGH;
+	}
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
+	guard(mutex)(&lt9611c->ocm_lock);
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
+	timing_data[0] = (h_total >> 8) & 0xff;
+	timing_data[1] = h_total & 0xff;
+	timing_data[2] = (hactive >> 8) & 0xff;
+	timing_data[3] = hactive & 0xff;
+	timing_data[4] = (hfront_porch >> 8) & 0xff;
+	timing_data[5] = hfront_porch & 0xff;
+	timing_data[6] = (hsync_len >> 8) & 0xff;
+	timing_data[7] = hsync_len & 0xff;
+	timing_data[8] = (hback_porch >> 8) & 0xff;
+	timing_data[9] = hback_porch & 0xff;
+	timing_data[10] = (v_total >> 8) & 0xff;
+	timing_data[11] = v_total & 0xff;
+	timing_data[12] = (vactive >> 8) & 0xff;
+	timing_data[13] = vactive & 0xFF;
+	timing_data[14] = (vfront_porch >> 8) & 0xff;
+	timing_data[15] = vfront_porch & 0xff;
+	timing_data[16] = (vsync_len >> 8) & 0xff;
+	timing_data[17] = vsync_len & 0xff;
+	timing_data[18] = (vback_porch >> 8) & 0xff;
+	timing_data[19] = vback_porch & 0xff;
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
+	guard(mutex)(&lt9611c->ocm_lock);
+
+	ret = lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
+	if (ret) {
+		dev_err(dev, "failed to read HPD status (err=%d)\n", ret);
+	} else {
+		connected = (hpd_status == 0x02);
+	}
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
+	guard(mutex)(&lt9611c->ocm_lock);
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
+static int lt9611c_hdmi_write_avi_infoframe(struct drm_bridge *bridge,
+					    const u8 *buffer, size_t len)
+{
+	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
+	u8 extra[1 + LT9611C_INFOFRAME_MAX_SIZE];
+	struct lt9611c_rsp rsp = {};
+	struct lt9611c_cmd cmd = {
+		.hdr = { LT9611C_FUNC_WRITE, LT9611C_TYPE_HDMI, 0x35, LT9611C_CMD_SEP },
+	};
+
+	if (WARN_ON(len > LT9611C_INFOFRAME_MAX_SIZE))
+		return -EINVAL;
+
+	extra[0] = 0x01; /* write avi */
+	memcpy(&extra[1], buffer, len);
+	cmd.data = extra;
+	cmd.data_len = 1 + len;
+
+	guard(mutex)(&lt9611c->ocm_lock);
+
+	return lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
+}
+
+static int lt9611c_hdmi_clear_avi_infoframe(struct drm_bridge *bridge)
+{
+	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
+	static const u8 clear_data[] = { 0x01 };
+	struct lt9611c_cmd cmd = {
+		.hdr = { LT9611C_FUNC_WRITE, LT9611C_TYPE_HDMI, 0x42, LT9611C_CMD_SEP },
+				   .data = clear_data, .data_len = 1 };
+	struct lt9611c_rsp rsp = {};
+	int ret;
+
+	guard(mutex)(&lt9611c->ocm_lock);
+
+	ret = lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
+
+	if (ret < 0) {
+		dev_err(lt9611c->dev, "clear avi infoframe failed!\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int lt9611c_hdmi_write_hdmi_infoframe(struct drm_bridge *bridge,
+					     const u8 *buffer, size_t len)
+{
+	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
+	u8 extra[1 + LT9611C_INFOFRAME_MAX_SIZE];
+	struct lt9611c_rsp rsp = {};
+	struct lt9611c_cmd cmd = {
+		.hdr = { LT9611C_FUNC_WRITE, LT9611C_TYPE_HDMI, 0x35, LT9611C_CMD_SEP },
+	};
+
+	if (WARN_ON(len > LT9611C_INFOFRAME_MAX_SIZE))
+		return -EINVAL;
+
+	extra[0] = 0x04; /* write vsif */
+	memcpy(&extra[1], buffer, len);
+	cmd.data = extra;
+	cmd.data_len = 1 + len;
+
+	guard(mutex)(&lt9611c->ocm_lock);
+
+	return lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
+}
+
+static int lt9611c_hdmi_clear_hdmi_infoframe(struct drm_bridge *bridge)
+{
+	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
+	static const u8 clear_data[] = { 0x04 };
+	struct lt9611c_cmd cmd = {
+		.hdr = { LT9611C_FUNC_WRITE, LT9611C_TYPE_HDMI, 0x42, LT9611C_CMD_SEP },
+				   .data = clear_data, .data_len = 1 };
+	struct lt9611c_rsp rsp = {};
+	int ret;
+
+	guard(mutex)(&lt9611c->ocm_lock);
+
+	ret = lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
+
+	if (ret < 0) {
+		dev_err(lt9611c->dev, "clear hdmi infoframe failed!\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int lt9611c_hdmi_write_audio_infoframe(struct drm_bridge *bridge,
+					      const u8 *buffer, size_t len)
+{
+	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
+	u8 extra[1 + LT9611C_INFOFRAME_MAX_SIZE];
+	struct lt9611c_rsp rsp = {};
+	struct lt9611c_cmd cmd = {
+		.hdr = { LT9611C_FUNC_WRITE, LT9611C_TYPE_HDMI, 0x35, LT9611C_CMD_SEP },
+	};
+
+	extra[0] = 0x02; /* write audio */
+	memcpy(&extra[1], buffer, len);
+	cmd.data = extra;
+	cmd.data_len = 1 + len;
+
+	guard(mutex)(&lt9611c->ocm_lock);
+
+	return lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
+}
+
+static int lt9611c_hdmi_clear_audio_infoframe(struct drm_bridge *bridge)
+{
+	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
+	static const u8 clear_data[] = { 0x02 };
+	struct lt9611c_cmd cmd = {
+		.hdr = { LT9611C_FUNC_WRITE, LT9611C_TYPE_HDMI, 0x42, LT9611C_CMD_SEP },
+				   .data = clear_data, .data_len = 1 };
+	struct lt9611c_rsp rsp = {};
+	int ret;
+
+	guard(mutex)(&lt9611c->ocm_lock);
+
+	ret = lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
+
+	if (ret < 0) {
+		dev_err(lt9611c->dev, "clear audio infoframe failed!\n");
+		return ret;
+	}
+
+	return 0;
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
+	guard(mutex)(&lt9611c->ocm_lock);
+
+	ret = lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
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
+static void lt9611c_bridge_hpd_enable(struct drm_bridge *bridge)
+{
+	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
+	static const u8 hpd_data[] = { 0x00 };
+	struct lt9611c_cmd cmd = {
+		.hdr = { LT9611C_FUNC_READ, LT9611C_TYPE_HDMI, 0x31, LT9611C_CMD_SEP },
+		.data = hpd_data,
+		.data_len = 1,
+	};
+	u8 hpd_status;
+	struct lt9611c_rsp rsp = { .data = &hpd_status, .data_len = 1 };
+	int ret;
+
+	mutex_lock(&lt9611c->ocm_lock);
+	ret = lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
+	if (!ret)
+		lt9611c->hdmi_connected = (hpd_status == 0x02);
+	mutex_unlock(&lt9611c->ocm_lock);
+
+	schedule_work(&lt9611c->work);
+}
+
+static int lt9611c_hdmi_audio_startup(struct drm_bridge *bridge,
+				      struct drm_connector *connector)
+{
+	return 0;
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
+	.hpd_enable = lt9611c_bridge_hpd_enable,
+
+	.hdmi_tmds_char_rate_valid = lt9611c_hdmi_tmds_char_rate_valid,
+	.hdmi_write_avi_infoframe = lt9611c_hdmi_write_avi_infoframe,
+	.hdmi_clear_avi_infoframe = lt9611c_hdmi_clear_avi_infoframe,
+	.hdmi_write_hdmi_infoframe = lt9611c_hdmi_write_hdmi_infoframe,
+	.hdmi_clear_hdmi_infoframe = lt9611c_hdmi_clear_hdmi_infoframe,
+	.hdmi_write_audio_infoframe = lt9611c_hdmi_write_audio_infoframe,
+	.hdmi_clear_audio_infoframe = lt9611c_hdmi_clear_audio_infoframe,
+
+	.hdmi_audio_startup = lt9611c_hdmi_audio_startup,
+	.hdmi_audio_prepare = lt9611c_hdmi_audio_prepare,
+	.hdmi_audio_shutdown = lt9611c_hdmi_audio_shutdown,
+};
+
+static int lt9611c_parse_dt(struct device *dev,
+			    struct lt9611c *lt9611c)
+{
+	lt9611c->dsi0_node = of_graph_get_remote_node(dev->of_node, 0, -1);
+	if (!lt9611c->dsi0_node)
+		return dev_err_probe(dev, -ENODEV, "failed to get remote node for primary dsi\n");
+
+	lt9611c->dsi1_node = of_graph_get_remote_node(dev->of_node, 1, -1);
+
+	if (lt9611c->dsi1_node && lt9611c->chip_type == CHIP_LT9611C) {
+		of_node_put(lt9611c->dsi1_node);
+		of_node_put(lt9611c->dsi0_node);
+		return dev_err_probe(dev, -EINVAL,
+				     "LT9611C does not support dual DSI\n");
+	}
+
+	lt9611c->bridge.next_bridge = of_drm_get_bridge_by_endpoint(dev->of_node, 2, -1);
+	if (IS_ERR(lt9611c->bridge.next_bridge)) {
+		of_node_put(lt9611c->dsi1_node);
+		of_node_put(lt9611c->dsi0_node);
+		return PTR_ERR(lt9611c->bridge.next_bridge);
+	}
+
+	return 0;
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
+static ssize_t lt9611c_firmware_store(struct device *dev, struct device_attribute *attr,
+				      const char *buf, size_t len)
+{
+	struct lt9611c *lt9611c = dev_get_drvdata(dev);
+	int ret;
+
+	lt9611c_lock(lt9611c);
+
+	ret = lt9611c_firmware_upgrade(lt9611c);
+	if (ret < 0)
+		dev_err(dev, "upgrade failure\n");
+
+	lt9611c_unlock(lt9611c);
+
+	return ret < 0 ? ret : len;
+}
+
+static ssize_t lt9611c_firmware_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct lt9611c *lt9611c = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "0x%04x\n", lt9611c->fw_version);
+}
+
+static DEVICE_ATTR_RW(lt9611c_firmware);
+
+static struct attribute *lt9611c_attrs[] = {
+	&dev_attr_lt9611c_firmware.attr,
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
+	lt9611c->chip_type = (unsigned long)i2c_get_match_data(client);
+
+	ret = devm_mutex_init(dev, &lt9611c->ocm_lock);
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
+			ret = lt9611c_firmware_upgrade(lt9611c);
+			if (ret < 0) {
+				lt9611c_unlock(lt9611c);
+				goto err_disable_regulators;
+			}
+
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
+	devm_drm_bridge_add(dev, &lt9611c->bridge);
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
+	if (ret)
+		dev_err(lt9611c->dev, "regulator bulk disable failed.\n");
+
+	return ret;
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
+	enable_irq(lt9611c->client->irq);
+	lt9611c_reset(lt9611c);
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
+	/* chip_type */
+	{ "lontium,lt9611c", CHIP_LT9611C },
+	{ "lontium,lt9611ex", CHIP_LT9611EX },
+	{ "lontium,lt9611uxd", CHIP_LT9611UXD },
+	{ /* sentinel */ }
+};
+
+static const struct of_device_id lt9611c_match_table[] = {
+	{ .compatible = "lontium,lt9611c", .data = (void *)CHIP_LT9611C },
+	{ .compatible = "lontium,lt9611ex", .data = (void *)CHIP_LT9611EX },
+	{ .compatible = "lontium,lt9611uxd", .data = (void *)CHIP_LT9611UXD },
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

