Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843AE606A32C
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 06:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kTs+4p3i
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB33A10E0CB;
	Mon, 23 Nov 2026 06:14:12 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A992710E0CB
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 06:14:06 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AN5109U1961029; Mon, 23 Nov 2026 06:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CnBZBOZCwYtcqi0L7kGLUyCTi8bsWvb9WI47pnfAJok=; b=kTs+4p3iHHze8RbD
 DNqemke2HWCOVw+axCx36Qqe7vpNGkBnr9R/oab+KlC53frO1FLIHb7NAPuc0AQV
 hf6TFfJwKOGrPEwsqMSF++CAxznDvatK3b6IhunaXycqzM+nTTKn69GM+kHa+82J
 gSGNIdOnxJUZ0nNmxTes1AcEyC/uUKjpqvcMLj7/GPhXoAHuUFSy09v/7KJ9wOo0
 qRBLi/279BNzVVHseE4fZ8s4iRXDS3LINRCbA2p+G+rebR8KcvAE5AJ81yyR/mXy
 BgOMInPqzbodoM9cNJ1EZ/YCV4fEYyS01FteN4gmfhNqibB6fD4of2dn6NdXiTrt
 FSvXHw==
Received: from apblrppmta02.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j32a6nh2b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 23 Nov 2026 06:13:45 +0000 (GMT)
Received: from pps.filterd (apblrppmta02.qualcomm.com [127.0.0.1])
 by APBLRPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AN695vv1807757; Mon, 23 Nov 2026 06:09:05 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-mdsor-hyd.qualcomm.com
 [10.147.243.209])
 by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AN695mH1807751
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 23 Nov 2026 06:09:05 +0000 (GMT)
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4770534)
 id 2B5E55EF; Mon, 23 Nov 2026 11:39:04 +0530 (+0530)
From: mohit.dsor@oss.qualcomm.com
Date: Mon, 23 Nov 2026 11:39:03 +0530
Subject: [PATCH v19 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI
 to HDMI driver
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261123-lt9611c-v7-v19-2-1fbe2b7b5211@oss.qualcomm.com>
References: <20261123-lt9611c-v7-v19-0-1fbe2b7b5211@oss.qualcomm.com>
In-Reply-To: <20261123-lt9611c-v7-v19-0-1fbe2b7b5211@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795414144; l=46965;
 i=mohit.dsor@oss.qualcomm.com; s=20260808; h=from:subject:message-id;
 bh=MhB5PmO2P7BWRFubNJ15qOMVGWGuwiNx4MxbQBcjfA4=;
 b=Z+HcWFfC4ExAXLlz9HbpDop61ujniKoeYCCFl3p9fiwhnDgChYmR4MbE5Fk2CJgXQbYugbUry
 x2jAQ4HXpGyBZscaMG6fLn8qblxgqqweNCyuOurC/ChdgsKDf8e0dqD
X-Developer-Key: i=mohit.dsor@oss.qualcomm.com; a=ed25519;
 pk=outHVBN53JhozDw1xkj3G1qrqqE5scMBP7M4WL3aHQQ=
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: y-nkh0LWvkxVL_wFs3iRwTtOu8CQOJcy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAyNCBTYWx0ZWRfX3M8cg+AGifSW
 glXhub23bCGoORNyUC49WOq1Api7kcAn7vvfx5soZJvCPHkuS24roE00hmHoGxMFbXINpOKsn+j
 KirpealcD5izchTMa2RV7OdkjD/D1KA=
X-Proofpoint-ORIG-GUID: y-nkh0LWvkxVL_wFs3iRwTtOu8CQOJcy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAyNCBTYWx0ZWRfXwMOYzL6okkfn
 MjzRTGZbotL4Qb9bJDHXFGpHPLtgEBzOqoUvSA5XsdXcoPTPc0M5+CcR0T+M29tX+kINeyrVy+f
 W21T/sKWgnEzHIKSMO5w4GYHio7pjPIgTKksdPFJOt0Elsy8A48ixfCq0SYJOQxVR4pVjfeLcA+
 ZYI6REPVKwJEXrezkMDhSvIGeHss9XUB7VhpFOfmhsGnhJkfMALA2BWWEIF9qkVMJl6KsY5thNH
 N90JqstE2YfNfqgZWVVBO7yVI2pW0oA0aF2W6eugmG8Xj7OReEL/yTkChDaVDAAot5ofujnVw+V
 OTJzahhHiURgO+n3/tW342m4RiqZW1g4xIy/lx3k5RAIYxsoLEhqEMO6Z7Nf7YnJCmD/AmPlHHW
 PpHdEAfUuCjUZABVyFagxwML90WUlw/5Ld7E7HC9lUUGBY5ijvC8nvYd27OZJOvsuJtTmxpyMQT
 muUEXiE0ymM7DaBZglA==
X-Authority-Analysis: v=2.4 cv=UbHE26SN c=1 sm=1 tr=0 ts=6b03d99a cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=Kz8-B0t5AAAA:8
 a=EUspDBNiAAAA:8 a=teJA_Ks-lSJy_DYq6aUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230024
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
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
 drivers/gpu/drm/bridge/lontium-lt9611c.c         | 1406 ++++++++++++++++++++++
 4 files changed, 1434 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-lontium-firmware b/Documentation/ABI/testing/sysfs-lontium-firmware
new file mode 100644
index 000000000000..1f8b19232c2f
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-lontium-firmware
@@ -0,0 +1,10 @@
+What:		/sys/bus/i2c/drivers/<driver>/.../firmware
+Date:		July 2026
+KernelVersion:	7.5
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
index 000000000000..e7c579cd80d5
--- /dev/null
+++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
@@ -0,0 +1,1406 @@
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
+#define LT9611C_MIN_TMDS_RATE	25000000ULL
+
+/* Regmap address space */
+#define LT9611C_REG_MAX		0xfe9c
+
+/* MCU command protocol registers and values */
+#define LT9611C_MCU_TRIG		0xe0de
+#define LT9611C_MCU_TRIG_REQUEST	0x01	/* signal command request to MCU */
+#define LT9611C_MCU_TRIG_EXECUTE	0x02	/* signal command execute to MCU */
+#define LT9611C_MCU_STATUS		0xe0ae
+#define LT9611C_MCU_STATUS_READY	0x01	/* MCU ready for command */
+#define LT9611C_MCU_STATUS_DONE		0x02	/* MCU command complete */
+#define LT9611C_MCU_CMD_BUF		0xe0b0	/* command header + params buffer start */
+#define LT9611C_MCU_CMD_BUF_END		0xe0dd	/* command buffer end */
+#define LT9611C_MCU_RSP_BUF		0xe085	/* response header + data buffer start */
+#define LT9611C_MCU_HALT		0xe0ee
+#define LT9611C_MCU_HALT_ENABLE		BIT(0)	/* halt MCU for direct register access */
+#define LT9611C_MCU_HALT_DISABLE	0	/* resume MCU */
+#define LT9611C_MCU_FW_VER		0xe080	/* 2-byte firmware version */
+
+/* SPI flash controller registers and values */
+#define LT9611C_FLASH_FIFO_CTRL		0xe103
+#define LT9611C_FLASH_FIFO_RST		0x3f	/* FIFO reset assert */
+#define LT9611C_FLASH_FIFO_RUN		0xff	/* FIFO reset deassert */
+#define LT9611C_FLASH_SRAM_SEL		0xe051
+#define LT9611C_FLASH_SRAM_SEL_CRC	0x00	/* select CRC region */
+#define LT9611C_FLASH_SRAM_SEL_DATA	0xff	/* select firmware data region */
+#define LT9611C_FLASH_CMD		0xe055
+#define LT9611C_FLASH_CMD_ERASE_SET	0x25	/* chip erase setup */
+#define LT9611C_FLASH_CMD_ERASE_GO	0x01	/* chip erase execute */
+#define LT9611C_FLASH_CMD_DATA_WR	0x80	/* write data to SRAM */
+#define LT9611C_FLASH_CMD_CRC_WR	0xc0	/* write CRC to SRAM */
+#define LT9611C_FLASH_MODE		0xe056
+#define LT9611C_FLASH_MODE_RD_STS	0x05	/* SPI read-status-register opcode */
+#define LT9611C_FLASH_CS		0xe058
+#define LT9611C_FLASH_CS_IDLE		0x00	/* chip-select deasserted */
+#define LT9611C_FLASH_CS_ACTIVE		0x21	/* chip-select asserted */
+#define LT9611C_FLASH_DATA		0xe059	/* SRAM data write register */
+#define LT9611C_FLASH_DATA_CFG		0x50	/* initial SRAM configuration byte */
+#define LT9611C_FLASH_OP		0xe05a
+#define LT9611C_FLASH_OP_WR_EN		0x04	/* write-enable pulse */
+#define LT9611C_FLASH_OP_CFG_PUSH	0x10	/* push config byte from DATA to SPI */
+#define LT9611C_FLASH_OP_ERASE		0x01	/* trigger sector erase */
+#define LT9611C_FLASH_OP_PROGRAM	0x30	/* program SRAM contents to flash */
+#define LT9611C_FLASH_OP_WR_DIS		0x08	/* write-disable pulse */
+#define LT9611C_FLASH_OP_NOP		0x00	/* clear / no-op */
+#define LT9611C_FLASH_ADDR_H		0xe05b	/* flash address bits 23:16 */
+#define LT9611C_FLASH_ADDR_M		0xe05c	/* flash address bits 15:8 */
+#define LT9611C_FLASH_ADDR_L		0xe05d	/* flash address bits 7:0 */
+#define LT9611C_FLASH_CTRL		0xe05e
+#define LT9611C_FLASH_CTRL_DATA_WR	0xc1	/* SRAM data write mode */
+#define LT9611C_FLASH_CTRL_RD_STS	0x40	/* read-status mode */
+#define LT9611C_FLASH_CTRL_WR		0xc0	/* write mode */
+#define LT9611C_FLASH_STATUS		0xe05f	/* flash WIP status */
+#define LT9611C_FLASH_CRC		0xe021	/* flash CRC result */
+
+/* Interrupt registers and values */
+#define LT9611C_IRQ_STATUS		0xe084
+#define LT9611C_IRQ_CLR			0xe0df
+#define LT9611C_IRQ_HPD			BIT(0)	/* HPD interrupt bit */
+
+/* Chip identification */
+#define LT9611C_CHIP_ID			0xe100	/* 2-byte chip ID */
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
+		.range_max = LT9611C_REG_MAX,
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
+	.max_register = LT9611C_REG_MAX,
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
+	unsigned int max_params = LT9611C_MCU_CMD_BUF_END - LT9611C_MCU_CMD_BUF + 1;
+
+	regmap_write(lt9611c->regmap, LT9611C_MCU_TRIG, LT9611C_MCU_TRIG_REQUEST);
+
+	ret = regmap_read_poll_timeout(lt9611c->regmap, LT9611C_MCU_STATUS, temp,
+				       temp == LT9611C_MCU_STATUS_READY, 1000, 200 * 1000);
+	if (ret)
+		return -ETIMEDOUT;
+
+	ret = regmap_bulk_write(lt9611c->regmap, LT9611C_MCU_CMD_BUF, &cmd->hdr,
+				LT9611C_CMD_HDR_SIZE);
+	if (ret)
+		return ret;
+
+	for (i = 0; cmd->data && i < cmd->data_len &&
+	     (LT9611C_CMD_HDR_SIZE + i) < max_params; i++)
+		regmap_write(lt9611c->regmap,
+			     LT9611C_MCU_CMD_BUF + LT9611C_CMD_HDR_SIZE + i, cmd->data[i]);
+
+	regmap_write(lt9611c->regmap, LT9611C_MCU_TRIG, LT9611C_MCU_TRIG_EXECUTE);
+
+	ret = regmap_read_poll_timeout(lt9611c->regmap, LT9611C_MCU_STATUS, temp,
+				       temp == LT9611C_MCU_STATUS_DONE, 1000, 200 * 1000);
+	if (ret)
+		return -ETIMEDOUT;
+
+	ret = regmap_bulk_read(lt9611c->regmap, LT9611C_MCU_RSP_BUF,
+			       &rsp->hdr, LT9611C_CMD_HDR_SIZE);
+	if (ret)
+		return ret;
+
+	if (rsp->data && rsp->data_len)
+		ret = regmap_bulk_read(lt9611c->regmap,
+				       LT9611C_MCU_RSP_BUF + LT9611C_CMD_HDR_SIZE,
+				       rsp->data, rsp->data_len);
+
+	return ret;
+}
+
+static void lt9611c_lock(struct lt9611c *lt9611c)
+{
+	mutex_lock(&lt9611c->mcu_lock);
+	regmap_write(lt9611c->regmap, LT9611C_MCU_HALT, LT9611C_MCU_HALT_ENABLE);
+}
+
+static void lt9611c_unlock(struct lt9611c *lt9611c)
+{
+	regmap_write(lt9611c->regmap, LT9611C_MCU_HALT, LT9611C_MCU_HALT_DISABLE);
+	mutex_unlock(&lt9611c->mcu_lock);
+}
+
+static void lt9611c_config_parameters(struct lt9611c *lt9611c)
+{
+	const struct reg_sequence seq_write_paras[] = {
+		REG_SEQ0(LT9611C_MCU_HALT, LT9611C_MCU_HALT_ENABLE),
+		REG_SEQ0(LT9611C_FLASH_FIFO_CTRL, LT9611C_FLASH_FIFO_RST), /* fifo rst */
+		REG_SEQ0(LT9611C_FLASH_FIFO_CTRL, LT9611C_FLASH_FIFO_RUN),
+		REG_SEQ0(LT9611C_FLASH_CTRL, LT9611C_FLASH_CTRL_DATA_WR),
+		REG_SEQ0(LT9611C_FLASH_CS, LT9611C_FLASH_CS_IDLE),
+		REG_SEQ0(LT9611C_FLASH_DATA, LT9611C_FLASH_DATA_CFG),
+		REG_SEQ0(LT9611C_FLASH_OP, LT9611C_FLASH_OP_CFG_PUSH),
+		REG_SEQ0(LT9611C_FLASH_OP, LT9611C_FLASH_OP_NOP),
+		REG_SEQ0(LT9611C_FLASH_CS, LT9611C_FLASH_CS_ACTIVE),
+	};
+
+	regmap_multi_reg_write(lt9611c->regmap, seq_write_paras, ARRAY_SIZE(seq_write_paras));
+}
+
+static void lt9611c_wr_enable(struct lt9611c *lt9611c)
+{
+	regmap_write(lt9611c->regmap, LT9611C_FLASH_OP, LT9611C_FLASH_OP_WR_EN);
+	regmap_write(lt9611c->regmap, LT9611C_FLASH_OP, LT9611C_FLASH_OP_NOP);
+}
+
+static void lt9611c_wr_disable(struct lt9611c *lt9611c)
+{
+	regmap_write(lt9611c->regmap, LT9611C_FLASH_OP, LT9611C_FLASH_OP_WR_DIS);
+	regmap_write(lt9611c->regmap, LT9611C_FLASH_OP, LT9611C_FLASH_OP_NOP);
+}
+
+static void lt9611c_erase_op(struct lt9611c *lt9611c, u32 addr)
+{
+	const struct reg_sequence seq_write[] = {
+		REG_SEQ0(LT9611C_MCU_HALT, LT9611C_MCU_HALT_ENABLE),
+		REG_SEQ0(LT9611C_FLASH_OP, LT9611C_FLASH_OP_WR_EN),
+		REG_SEQ0(LT9611C_FLASH_OP, LT9611C_FLASH_OP_NOP),
+		REG_SEQ0(LT9611C_FLASH_ADDR_H, (addr >> 16) & 0xff),
+		REG_SEQ0(LT9611C_FLASH_ADDR_M, (addr >> 8) & 0xff),
+		REG_SEQ0(LT9611C_FLASH_ADDR_L, addr & 0xff),
+		REG_SEQ0(LT9611C_FLASH_OP, LT9611C_FLASH_OP_ERASE),
+		REG_SEQ0(LT9611C_FLASH_OP, LT9611C_FLASH_OP_NOP),
+	};
+
+	regmap_multi_reg_write(lt9611c->regmap, seq_write, ARRAY_SIZE(seq_write));
+}
+
+static unsigned int read_flash_reg_status(struct lt9611c *lt9611c)
+{
+	const struct reg_sequence seq_write[] = {
+		REG_SEQ0(LT9611C_FLASH_FIFO_CTRL, LT9611C_FLASH_FIFO_RST),
+		REG_SEQ0(LT9611C_FLASH_FIFO_CTRL, LT9611C_FLASH_FIFO_RUN),
+		REG_SEQ0(LT9611C_FLASH_CTRL, LT9611C_FLASH_CTRL_RD_STS),
+		REG_SEQ0(LT9611C_FLASH_MODE, LT9611C_FLASH_MODE_RD_STS),
+		REG_SEQ0(LT9611C_FLASH_CMD, LT9611C_FLASH_CMD_ERASE_SET),
+		REG_SEQ0(LT9611C_FLASH_CMD, LT9611C_FLASH_CMD_ERASE_GO),
+		REG_SEQ0(LT9611C_FLASH_CS, LT9611C_FLASH_CS_ACTIVE),
+	};
+	unsigned int status;
+	int ret;
+
+	regmap_multi_reg_write(lt9611c->regmap, seq_write, ARRAY_SIZE(seq_write));
+	ret = regmap_read(lt9611c->regmap, LT9611C_FLASH_STATUS, &status);
+	if (ret)
+		return 0xff;
+
+	return status;
+}
+
+static void lt9611c_crc_to_sram(struct lt9611c *lt9611c)
+{
+	const struct reg_sequence seq_write[] = {
+		REG_SEQ0(LT9611C_FLASH_SRAM_SEL, LT9611C_FLASH_SRAM_SEL_CRC),
+		REG_SEQ0(LT9611C_FLASH_CMD, LT9611C_FLASH_CMD_CRC_WR),
+		REG_SEQ0(LT9611C_FLASH_CMD, LT9611C_FLASH_CMD_DATA_WR),
+		REG_SEQ0(LT9611C_FLASH_CTRL, LT9611C_FLASH_CTRL_WR),
+		REG_SEQ0(LT9611C_FLASH_CS, LT9611C_FLASH_CS_ACTIVE),
+	};
+
+	regmap_multi_reg_write(lt9611c->regmap, seq_write, ARRAY_SIZE(seq_write));
+}
+
+static void lt9611c_data_to_sram(struct lt9611c *lt9611c)
+{
+	const struct reg_sequence seq_write[] = {
+		REG_SEQ0(LT9611C_FLASH_SRAM_SEL, LT9611C_FLASH_SRAM_SEL_DATA),
+		REG_SEQ0(LT9611C_FLASH_CMD, LT9611C_FLASH_CMD_DATA_WR),
+		REG_SEQ0(LT9611C_FLASH_CTRL, LT9611C_FLASH_CTRL_WR),
+		REG_SEQ0(LT9611C_FLASH_CS, LT9611C_FLASH_CS_ACTIVE),
+	};
+
+	regmap_multi_reg_write(lt9611c->regmap, seq_write, ARRAY_SIZE(seq_write));
+}
+
+static void lt9611c_sram_to_flash(struct lt9611c *lt9611c, size_t addr)
+{
+	const struct reg_sequence seq_write[] = {
+		REG_SEQ0(LT9611C_FLASH_ADDR_H, (addr >> 16) & 0xff),
+		REG_SEQ0(LT9611C_FLASH_ADDR_M, (addr >> 8) & 0xff),
+		REG_SEQ0(LT9611C_FLASH_ADDR_L, addr & 0xff),
+		REG_SEQ0(LT9611C_FLASH_OP, LT9611C_FLASH_OP_PROGRAM),
+		REG_SEQ0(LT9611C_FLASH_OP, LT9611C_FLASH_OP_NOP),
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
+			ret = regmap_write(lt9611c->regmap, LT9611C_FLASH_DATA, value);
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
+	ret = regmap_write(lt9611c->regmap, LT9611C_FLASH_DATA, fw_crc);
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
+	regmap_write(lt9611c->regmap, LT9611C_MCU_HALT, LT9611C_MCU_HALT_ENABLE);
+	ret = regmap_read(lt9611c->regmap, LT9611C_FLASH_CRC, &crc_result);
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
+	ret = regmap_read(lt9611c->regmap, LT9611C_IRQ_STATUS, &irq_status);
+	if (ret) {
+		dev_err(dev, "failed to read irq status: %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	if (!(irq_status & LT9611C_IRQ_HPD))
+		return IRQ_NONE;
+
+	/* Clear interrupt: hardware requires two writes with delay */
+	regmap_write(lt9611c->regmap, LT9611C_IRQ_CLR, LT9611C_IRQ_HPD);
+	usleep_range(10000, 12000);
+	regmap_write(lt9611c->regmap, LT9611C_IRQ_CLR, 0);
+
+	schedule_work(&lt9611c->work);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * Read HPD status from the MCU. msleep_ms > 0 adds a debounce delay before
+ * reading, needed after an interrupt when the MCU hasn't latched the new state
+ * yet. Pass 0 for a direct read (e.g. from bridge detect).
+ */
+static enum drm_connector_status lt9611c_detect_hpd(struct lt9611c *lt9611c,
+						    unsigned int msleep_ms)
+{
+	static const u8 hpd_data[] = { 0x00 };
+	struct lt9611c_cmd cmd = {
+		.hdr = { LT9611C_FUNC_READ, LT9611C_TYPE_HDMI, 0x31, LT9611C_CMD_SEP },
+		.data = hpd_data,
+		.data_len = 1,
+	};
+	u8 hpd_status;
+	struct lt9611c_rsp rsp = { .data = &hpd_status, .data_len = 1 };
+	bool connected = false;
+	int ret;
+
+	if (msleep_ms)
+		msleep(msleep_ms);
+
+	guard(mutex)(&lt9611c->mcu_lock);
+
+	ret = lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
+	if (ret)
+		dev_err(lt9611c->dev, "failed to read HPD status (err=%d)\n", ret);
+	else
+		connected = (hpd_status == 0x02);
+
+	lt9611c->hdmi_connected = connected;
+
+	return connected ? connector_status_connected : connector_status_disconnected;
+}
+
+static void lt9611c_hpd_work(struct work_struct *work)
+{
+	struct lt9611c *lt9611c = container_of(work, struct lt9611c, work);
+	enum drm_connector_status status;
+
+	/*
+	 * Wait for the MCU to debounce and latch the HPD state after the
+	 * interrupt fires. The MCU needs time to update its internal HPD
+	 * register; reading immediately after the interrupt returns stale
+	 * state. 200 ms is empirically sufficient.
+	 */
+	status = lt9611c_detect_hpd(lt9611c, 200);
+
+	drm_bridge_hpd_notify(&lt9611c->bridge, status);
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
+	if (tmds_rate < LT9611C_MIN_TMDS_RATE)
+		return MODE_CLOCK_LOW;
+
+	return MODE_OK;
+}
+
+static int lt9611c_video_setup(struct lt9611c *lt9611c,
+			       const struct drm_display_mode *mode)
+{
+	static const u8 dual_port_data[] = { 0x02, 0x70 };
+	struct device *dev = lt9611c->dev;
+	u8 ack = 0;
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
+	struct lt9611c_rsp dual_rsp = { .data = &ack, .data_len = 1 };
+	struct lt9611c_cmd dual_cmd = {
+		.hdr = { LT9611C_FUNC_WRITE, LT9611C_TYPE_MIPI, 0x31, LT9611C_CMD_SEP },
+		.data = dual_port_data,
+		.data_len = ARRAY_SIZE(dual_port_data),
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
+	if (ret) {
+		dev_err(dev, "video set failed\n");
+		return ret;
+	}
+
+	if (!lt9611c->dual_dsi)
+		return 0;
+
+	ret = lt9611c_read_write_flow(lt9611c, &dual_cmd, &dual_rsp);
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
+	ret = lt9611c_video_setup(lt9611c, mode);
+	if (ret)
+		return;
+
+	drm_atomic_helper_connector_hdmi_update_infoframes(connector, state);
+}
+
+static enum drm_connector_status
+lt9611c_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connector)
+{
+	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
+
+	return lt9611c_detect_hpd(lt9611c, 0);
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
+	struct device_node *dsi0 __free(device_node) =
+		of_graph_get_remote_node(dev->of_node, 0, -1);
+	if (!dsi0)
+		return dev_err_probe(dev, -ENODEV, "failed to get remote node for primary dsi\n");
+
+	struct device_node *dsi1 __free(device_node) =
+		of_graph_get_remote_node(dev->of_node, 1, -1);
+
+	if (dsi1 && lt9611c->cdata->chip_type == CHIP_LT9611C)
+		return dev_err_probe(dev, -EINVAL, "LT9611C does not support dual DSI\n");
+
+	if (dsi1)
+		lt9611c->dual_dsi = true;
+
+	lt9611c->bridge.next_bridge = of_drm_get_bridge_by_endpoint(dev->of_node, 2, -1);
+	if (IS_ERR(lt9611c->bridge.next_bridge))
+		return PTR_ERR(lt9611c->bridge.next_bridge);
+
+	*dsi0_node = no_free_ptr(dsi0);
+	*dsi1_node = no_free_ptr(dsi1);
+	return 0;
+}
+
+static int lt9611c_read_fw_version(struct lt9611c *lt9611c)
+{
+	u8 buf[2];
+	int ret;
+
+	ret = regmap_write(lt9611c->regmap, LT9611C_MCU_HALT, LT9611C_MCU_HALT_ENABLE);
+	if (ret)
+		return ret;
+
+	ret = regmap_bulk_read(lt9611c->regmap, LT9611C_MCU_FW_VER, buf, ARRAY_SIZE(buf));
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
+	ret = regmap_write(lt9611c->regmap, LT9611C_MCU_HALT, LT9611C_MCU_HALT_ENABLE);
+	if (ret)
+		return ret;
+
+	ret = regmap_bulk_read(lt9611c->regmap, LT9611C_CHIP_ID, chipid, 2);
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
+	ret = lt9611c_read_fw_version(lt9611c);
+	if (ret >= 0)
+		WRITE_ONCE(lt9611c->fw_version, ret);
+	lt9611c_unlock(lt9611c);
+
+	if (ret < 0)
+		dev_warn(dev, "upgrade succeeded but failed to read new fw version (err=%d)\n",
+			 ret);
+	else
+		dev_info(dev, "firmware upgrade succeeded, version: 0x%04x\n", ret);
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
+/*
+ * Read the firmware version, upgrading from the firmware file if the MCU
+ * reports version 0. Only one upgrade attempt is made. Returns the version
+ * on success, or a negative error code.
+ */
+static int lt9611c_check_firmware(struct lt9611c *lt9611c)
+{
+	struct device *dev = lt9611c->dev;
+	int fw_version;
+	int ret;
+
+	lt9611c_lock(lt9611c);
+	fw_version = lt9611c_read_fw_version(lt9611c);
+	lt9611c_unlock(lt9611c);
+
+	if (fw_version < 0)
+		return dev_err_probe(dev, fw_version, "failed to read fw version\n");
+
+	if (fw_version == 0) {
+		ret = lt9611c_firmware_upgrade(lt9611c);
+		if (ret < 0)
+			return ret;
+
+		lt9611c_lock(lt9611c);
+		fw_version = lt9611c_read_fw_version(lt9611c);
+		lt9611c_unlock(lt9611c);
+
+		if (fw_version < 0)
+			return dev_err_probe(dev, fw_version,
+					     "failed to read fw version after upgrade\n");
+
+		if (fw_version == 0) {
+			dev_err(dev, "firmware upgrade failed, version still 0\n");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	dev_dbg(dev, "firmware version: 0x%04x\n", fw_version);
+	return fw_version;
+}
+
+static int lt9611c_probe(struct i2c_client *client)
+{
+	struct lt9611c *lt9611c;
+	struct device *dev = &client->dev;
+	struct device_node *dsi0_node __free(device_node) = NULL;
+	struct device_node *dsi1_node __free(device_node) = NULL;
+	struct mipi_dsi_device *dsi;
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
+	if (IS_ERR(lt9611c->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(lt9611c->reset_gpio),
+				     "failed to get reset gpio\n");
+
+	ret = lt9611c_regulator_init(lt9611c);
+	if (ret < 0)
+		return ret;
+
+	lt9611c_reset(lt9611c);
+
+	lt9611c_lock(lt9611c);
+	ret = lt9611c_read_chipid(lt9611c);
+	lt9611c_unlock(lt9611c);
+	if (ret < 0) {
+		dev_err(dev, "failed to read chip id\n");
+		goto err_disable_regulators;
+	}
+
+	ret = lt9611c_check_firmware(lt9611c);
+	if (ret < 0)
+		goto err_disable_regulators;
+	lt9611c->fw_version = ret;
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
+	mutex_lock(&lt9611c->mcu_lock);
+	gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
+	ret = regulator_bulk_disable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
+	mutex_unlock(&lt9611c->mcu_lock);
+
+	if (ret) {
+		dev_err(lt9611c->dev, "regulator bulk disable failed\n");
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
+		dev_err(lt9611c->dev, "regulator bulk enable failed\n");
+		return ret;
+	}
+
+	mutex_lock(&lt9611c->mcu_lock);
+	lt9611c_reset(lt9611c);
+	mutex_unlock(&lt9611c->mcu_lock);
+
+	enable_irq(lt9611c->client->irq);
+	return 0;
+}
+
+DEFINE_SIMPLE_DEV_PM_OPS(lt9611c_bridge_pm_ops,
+			 lt9611c_bridge_suspend, lt9611c_bridge_resume);
+
+static const struct i2c_device_id lt9611c_id[] = {
+	{ .name = "lt9611c",   .driver_data = (kernel_ulong_t)&lt9611c_chip_data[CHIP_LT9611C]   },
+	{ .name = "lt9611ex",  .driver_data = (kernel_ulong_t)&lt9611c_chip_data[CHIP_LT9611EX]  },
+	{ .name = "lt9611uxd", .driver_data = (kernel_ulong_t)&lt9611c_chip_data[CHIP_LT9611UXD] },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(i2c, lt9611c_id);
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
+		.pm = pm_sleep_ptr(&lt9611c_bridge_pm_ops),
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

