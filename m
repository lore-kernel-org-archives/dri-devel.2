Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B18F606A322
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=nmBTJSMR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8003A112748;
	Thu, 22 Oct 2026 15:31:44 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013041.outbound.protection.outlook.com
 [52.101.83.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D21DF11274E
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 15:31:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NtXUr6qwQ6pPkPwTjjhAy2zhzzNW1ae79NCD32CFMkTA/Axvmt/sYNxX2Xe3gdVm8NmhCxYrA8iJ7Gwz804tYGLnc9IDNFL7fUNAMfcTwDJeuDZuwO7h0EfAwQmdOo2npeG09UlE0W+UicieG0JaJRv/B3gGxuiVXrlNsDnXmX7qmTYuNhRkYzwdMlPu4fPPitkHFo7QctLmIoBPPCydDjB0Ga5xKlbwd0vJEY3U2++DXiTZr1uWjXMUIkxMcT/ziW3uJbL+jy/sNL56IniWM9lxW2VjflwnP8CrGVR9E8PS511/f+o9y/vI35rK9+jhMxUIYjQWzvnm1jSgPQc1sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kH0guBtzccNnad33TGTeBnWgmDpkNeuDK4pMr0JdUT0=;
 b=wTwlOpBq2IiNdZg5LDyqN9p1HTsbdz2ewOX5RhABNNwFoYbMxmK5UB/9YkbceRKSxX2gCzpu1IvWSPeuVp8dzr/Wdi2TdXj7uHsgob5kJ5C5cS08fEOuYm6ankYopuDLSdq9ImDDm/yySoCjs2SCMbgOioCHuaKXOJHHF85yrfK0wX+AS+LfLcO9ywfYFBJZ8sql2PumsJHgaLZ5pM2PRMDrp97n1Af/e+qHJYOVAXd29ro9zMHKh9Daoxeb5ZbD3jP/HMJZiSEIY047XToCDrRhg7/+BS1o1tTCc1fxzVTV3/4C81JcocAi6WN1JGg4hkOuVL3FcynXwkTJPL/cyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=axis.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kH0guBtzccNnad33TGTeBnWgmDpkNeuDK4pMr0JdUT0=;
 b=nmBTJSMRi0os/qiNc0rN0seBcsxmZtln4C2MpTqWZaqr8nuOgFharbZ6wbFZIa00+RLhbdYmcZ90G+r38/2itX7ch95m13aYe35xm/GtpZmB+DDJ/EqzDuMDEuufWjvffDPPnCqHJf+2ZGDkD/mEtsAdAuo5185QM+6wN6esCXI=
Received: from MA2P292CA0013.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250:1::6) by
 PA4PR02MB7118.eurprd02.prod.outlook.com (2603:10a6:102:105::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 15:31:27 +0000
Received: from MAD0EPF000008B9.eurprd04.prod.outlook.com
 (2603:10a6:250:1:cafe::7a) by MA2P292CA0013.outlook.office365.com
 (2603:10a6:250:1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.17 via Frontend Transport; Thu,
 22 Oct 2026 15:31:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 MAD0EPF000008B9.mail.protection.outlook.com (10.167.241.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 15:31:27 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 22 Oct
 2026 17:31:21 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 22 Oct 2026 17:31:20 +0200
Received: from pc51726-2243.se.axis.com (pc51726-2243.se.axis.com
 [10.88.125.62])
 by se-intmail02x.se.axis.com (Postfix) with ESMTP id E97DC222B;
 Thu, 22 Oct 2026 17:31:20 +0200 (CEST)
Received: by pc51726-2243.se.axis.com (Postfix, from userid 15273)
 id E59B56026028; Thu, 22 Oct 2026 17:31:20 +0200 (CEST)
From: Lars Rask <lars.rask@axis.com>
Date: Thu, 22 Oct 2026 17:31:05 +0200
Subject: [PATCH 1/2] drm/sitronix/st7571-spi: Add support for ST75156
 controller
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261022-add_st75156_support-v1-1-582525a39a39@axis.com>
References: <20261022-add_st75156_support-v1-0-582525a39a39@axis.com>
In-Reply-To: <20261022-add_st75156_support-v1-0-582525a39a39@axis.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <kernel@axis.com>, Lars Rask
 <lars.rask@axis.com>
X-Mailer: b4 0.14.3
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008B9:EE_|PA4PR02MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: 358809ba-5c6d-4430-bd1f-08df305189e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|7416014|6133799003|18002099003|22082099003|3023799007|11063799006|261009223027099003|261009220027099003|261009221727099003|261009221227099003|261021123027099003|261021121427099003|10067099003|261009223327099003|56012099006;
X-Microsoft-Antispam-Message-Info: sUihYIjc18Q5e6buwm3zBlEumYaipehty+b3k1JS0C1CfrNvoGr4xQp96JeqtOYc0bzi9mHqGByyAwoptlVNWUditmSNPqt3j8Cg4VIx/x91FgLAx2DTqn2Qg2JLGuUNuw/0I0bgvE3AGgN1Hq+nKhUPl0LjJonE8GqX4/p2Z0Y3s/uYm7LhfyevJ4DEiN4z9RRMp0LO/ChDle0otf2ZUGvG3+NCN8koS9SrOoO5sqfcaXN++lcGvWlNow3+xXA6MX8oSsbaD/EORHLw/beCESY8wt5oBQNbEN+8pMCbL1LxcfqQ+LaxnRuRPZC75Vh/KXdieYLygFWqktVvL7VK7t67LHjM38epy331Z72wz+j6o6qFcf+PsRxC5o12/7e8saeXyTDyfWVyjBXAIQb5QaSOxd0+wdPtCnvKtUtQfI0Wb/58v/G6ViTjARp5R8bOTpJOv1GHks8U99KzNh0ll5TkXVHQwAmzXSpvgAGqIFDA1qBzbzq7GDQpUkjzPwkctyOqLjQ0sSdO5IcFF13R1sCdQEblapWhahbUE14/9BfkGlSO3KbkyWksPGZuapXl2rrHiAxy6CxjFrWHUAWJ1Ig3mzg8S99Omm5X1godePyvTnxfnftt08iXx+KAkubd2R5t7XfISC9MoJnHrN2Os3bwBbi8lAvPDKwZiDUr71HmK+a+QpG9ovr09qaooQHnHzzYLgWjTF2cP7kEKw+g8w==
X-Forefront-Antispam-Report: CIP:195.60.68.100; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.axis.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(7416014)(6133799003)(18002099003)(22082099003)(3023799007)(11063799006)(261009223027099003)(261009220027099003)(261009221727099003)(261009221227099003)(261021123027099003)(261021121427099003)(10067099003)(261009223327099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Y6GqjZBpFeqY20FwTQ/Z/6wzwHE3UStZvf/zZishWNiegeoaS0vxGKevpvG9lIwekd2UgOLM+C2MAnvcMA2ruIzdiI/bcMnr02NCR0TM1vTH3YUU2bHWUWEuV9oJ8n4vrG9JD8faOLLKGAGkjPOJUQ+48q6jAohIANG30E4YDUVo1uJCz9ROf6fZy6KOPUp5KptwOHhhdXVdxomhuYJg/4lvEafvccyt4mJcwOjgyKqRZhU4HaA8sPsRrVQyyy2f0xoRfDue7fz3k4zNMgvuPi727lgp/svUy7iSXf24Gj5AL+lGQsPFWjyt26fTLgEF8yGDUUlNIMWuY7fvPlrcc3FNqF2ZgdU+eFUVuRtwSOu6FmZZVE7CcSNRhht2XaT4IhpsmiaVlXTgjosyJ8X0PP3j3A7TdAyHmAzT8Keb5UIeZOi1fL/7LB8owPUm5oAB
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 15:31:27.2740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 358809ba-5c6d-4430-bd1f-08df305189e0
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af; Ip=[195.60.68.100];
 Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008B9.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB7118
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

From: Lars Rask <lars.rask@axis.com>

Made additions to st7571 display driver to support st75156.

Signed-off-by: Lars Rask <lars.rask@axis.com>
---
 drivers/gpu/drm/sitronix/st7571-spi.c | 118 +++++++++-
 drivers/gpu/drm/sitronix/st7571.c     | 420 +++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/sitronix/st7571.h     |  20 ++
 3 files changed, 549 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/sitronix/st7571-spi.c b/drivers/gpu/drm/sitronix/st7571-spi.c
index 0206e9162f1c..724c0eb5e7da 100644
--- a/drivers/gpu/drm/sitronix/st7571-spi.c
+++ b/drivers/gpu/drm/sitronix/st7571-spi.c
@@ -17,23 +17,133 @@ static const struct regmap_config st7571_spi_regmap_config = {
 	.can_multi_write = true,
 };
 
+struct spi_device_data {
+	struct spi_device *spi;
+	struct gpio_desc *dc_gpio;
+};
+
+static int regmap_spi_write(void *context, const void *data, size_t count);
+static int regmap_spi_read(void *context, const void *reg, size_t reg_size,
+			   void *val, size_t val_size);
+
+static const struct regmap_bus regmap_spi_dc_bus = {
+	.write = regmap_spi_write,
+	.read = regmap_spi_read,
+};
+
+static int regmap_spi_write(void *context, const void *data, size_t count)
+{
+	struct spi_device_data *spi_data = context;
+	const u8 *buf = data;
+	u8 mode;
+	size_t num_data_bytes;
+	const u8 *data_bytes;
+	int write_result;
+	const u8 *cmdbuf;
+	const u8 *databuf;
+
+	/*
+	 * count is required to be at least two bytes. The first byte is mode,
+	 * which can be either ST7571_COMMAND_MODE or ST7571_DATA_MODE. If the
+	 * first byte is ST7571_COMMAND_MODE, the second byte is a command
+	 * (register address). If the first byte is ST7571_DATA_MODE the second
+	 * byte is a data byte.
+	 */
+
+	if (count < 2)
+		return -EINVAL;
+
+	mode = buf[0];
+
+	if (mode == ST7571_COMMAND_MODE) {
+		gpiod_set_value_cansleep(spi_data->dc_gpio, 0);
+
+		cmdbuf = kmemdup(&buf[1], 1, GFP_KERNEL);
+		if (!cmdbuf)
+			return -ENOMEM;
+
+		write_result = spi_write(spi_data->spi, cmdbuf, 1);
+		kfree(cmdbuf);
+
+		if (write_result != 0)
+			return write_result;
+
+		num_data_bytes = count - 2;
+
+		if (num_data_bytes > 0) {
+			gpiod_set_value_cansleep(spi_data->dc_gpio, 1);
+			data_bytes = &buf[2];
+			databuf = kmemdup(data_bytes, num_data_bytes, GFP_KERNEL);
+
+			write_result = spi_write(spi_data->spi, databuf, num_data_bytes);
+			kfree(databuf);
+
+			if (write_result != 0)
+				return write_result;
+		}
+	} else if (mode == ST7571_DATA_MODE) {
+		num_data_bytes = count - 1;
+
+		if (num_data_bytes > 0) {
+			gpiod_set_value_cansleep(spi_data->dc_gpio, 1);
+			data_bytes = &buf[1];
+			databuf = kmemdup(data_bytes, num_data_bytes, GFP_KERNEL);
+			write_result = spi_write(spi_data->spi, databuf, num_data_bytes);
+			kfree(databuf);
+
+			if (write_result != 0)
+				return write_result;
+		}
+
+	} else {
+		/* Unsupported mode */
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/* The st7571 driver does not read registers but regmap expects a .read */
+static int regmap_spi_read(void *context, const void *reg, size_t reg_size,
+			   void *val, size_t val_size)
+{
+	return -EOPNOTSUPP;
+}
+
 static int st7571_spi_probe(struct spi_device *spi)
 {
 	struct st7571_device *st7571;
 	struct regmap *regmap;
+	struct spi_device_data *spi_data;
+
+	spi_data = devm_kzalloc(&spi->dev, sizeof(*spi_data), GFP_KERNEL);
+	if (IS_ERR(spi_data))
+		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
+				     "Failed to initialize spi data\n");
 
-	regmap = devm_regmap_init_spi(spi, &st7571_spi_regmap_config);
-	if (IS_ERR(regmap)) {
+	spi_data->spi = spi;
+	spi_data->dc_gpio = devm_gpiod_get(&spi->dev, "dc", GPIOD_OUT_LOW);
+
+	if (IS_ERR(spi_data->dc_gpio))
+		/* init regmap for 3 line SPI */
+		regmap = devm_regmap_init_spi(spi, &st7571_spi_regmap_config);
+	else
+		/* init regmap for 4 line SPI */
+		regmap = devm_regmap_init(&spi->dev, &regmap_spi_dc_bus,
+					  spi_data, &st7571_spi_regmap_config);
+
+	if (IS_ERR(regmap))
 		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
 				     "Failed to initialize regmap\n");
-	}
 
 	st7571 = st7571_probe(&spi->dev, regmap);
 	if (IS_ERR(st7571))
 		return dev_err_probe(&spi->dev, PTR_ERR(st7571),
 				     "Failed to initialize regmap\n");
 
+	st7571->spi_data = spi_data;
 	spi_set_drvdata(spi, st7571);
+
 	return 0;
 }
 
@@ -47,6 +157,7 @@ static void st7571_spi_remove(struct spi_device *spi)
 static const struct of_device_id st7571_of_match[] = {
 	{ .compatible = "sitronix,st7567", .data = &st7567_config },
 	{ .compatible = "sitronix,st7571", .data = &st7571_config },
+	{ .compatible = "sitronix,st75156", .data = &st75156_config },
 	{},
 };
 MODULE_DEVICE_TABLE(of, st7571_of_match);
@@ -54,6 +165,7 @@ MODULE_DEVICE_TABLE(of, st7571_of_match);
 static const struct spi_device_id st7571_spi_id[] = {
 	{ "st7567", 0 },
 	{ "st7571", 0 },
+	{ "st75156", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, st7571_spi_id);
diff --git a/drivers/gpu/drm/sitronix/st7571.c b/drivers/gpu/drm/sitronix/st7571.c
index 20954c33eca9..2dd52f2214d2 100644
--- a/drivers/gpu/drm/sitronix/st7571.c
+++ b/drivers/gpu/drm/sitronix/st7571.c
@@ -11,6 +11,7 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/backlight.h>
 
 #include <drm/clients/drm_client_setup.h>
 #include <drm/drm_atomic.h>
@@ -37,9 +38,6 @@
 
 #include "st7571.h"
 
-#define ST7571_COMMAND_MODE			(0x00)
-#define ST7571_DATA_MODE			(0x40)
-
 /* Normal mode command set */
 #define ST7571_DISPLAY_OFF			(0xae)
 #define ST7571_DISPLAY_ON			(0xaf)
@@ -73,6 +71,46 @@
 /* ST7567 commands */
 #define ST7567_SET_LCD_BIAS(m) (0xa2 | FIELD_PREP(GENMASK(0, 0), (m)))
 
+/* ST75156 commands */
+#define ST75156_EXTENSION_COMMAND_1			(0x30)
+#define ST75156_EXTENSION_COMMAND_2			(0x31)
+
+/* ST75156 Extension command 1 */
+#define ST75156_DISPLAY_OFF					(0xae)
+#define ST75156_DISPLAY_ON					(0xaf)
+#define ST75156_SLEEP_OUT					(0x94)
+#define ST75156_POWER_CONTROL				(0x20)
+#define ST75156_SET_VOP						(0x81)
+#define ST75156_DISPLAY_MODE				(0xf0)
+#define ST75156_DISPLAY_CONTROL				(0xca)
+#define ST75156_DATA_SCAN_DIRECTION			(0xbc)
+#define ST75156_NORMAL_DISPLAY				(0xa6)
+#define ST75156_COLUMN_ADDRESS_SETTING		(0x15)
+#define ST75156_PAGE_ADDRESS_SETTING		(0x75)
+#define ST75156_ENTER_WRITE_DDRAM_MODE		(0x5c)
+
+/* ST75156 Extension command 2 */
+#define ST75156_SET_AUTO_READ_INSTRUCTION	(0xd7)
+#define ST75156_DISABLE_AUTO_READ			(0x9f)
+#define ST75156_OTP_WR_RD_CONTROL			(0xe0)
+#define ST75156_OTP_UPLOAD					(0xe3)
+#define ST75156_OTP_CONTROL_OUT				(0xe1)
+#define ST75156_ANALOG_CIRCUIT_SET			(0x32)
+#define ST75156_BOOSTER_LEVEL_X10			(0x51)
+#define ST75156_INTERAL_POWER_SUPPLY		(0x40)
+
+/* Special command used to indicate to the st75156_send_command_list
+ * function that we should sleep for a number of milliseconds before
+ * the next command when sending the init sequence for ST75156.
+ * NOTE: This command is not part of the ST75156 instruction set.
+ */
+#define ST75156_SLEEP_MS					(0x00)
+
+/* ST75156 Command buffer */
+#define ST75156_COMMAND_LEN 1
+#define ST75156_MAX_PARAMETERS 3
+#define ST75156_COMMAND_BUFFER_LEN (ST75156_COMMAND_LEN + ST75156_MAX_PARAMETERS)
+
 #define ST7571_PAGE_HEIGHT 8
 
 #define DRIVER_NAME "st7571"
@@ -99,6 +137,89 @@ static int st7571_send_command_list(struct st7571_device *st7571,
 	return ret;
 }
 
+static int st75156_send_command_list(struct st7571_device *st75156,
+				     const u8 *cmd_list, size_t len)
+{
+	/* Each command in the command list is formatted using the following format:
+	 *
+	 * +---------+--------------------------+-------------+------+-------------+
+	 * | command | number of parameters (n) | parameter 1 | .... | parameter n |
+	 * +---------+--------------------------+-------------+------+-------------+
+	 *
+	 * For example, if a command has 2 parameters it is stored like this:
+	 *
+	 * +---------+------+-------------+--------------+
+	 * | command | 0x02 | parameter 1 |  parameter 2 |
+	 * +---------+------+-------------+--------------+
+	 *
+	 * If a command does not have any parameters it is stored like this:
+	 *
+	 * +---------+------+
+	 * | command | 0x00 |
+	 * +---------+------+
+	 *
+	 * NOTE: The command ST75156_SLEEP_MS (0x00) is a special command defined like this:
+	 *
+	 * +------------------+------+----+
+	 * | ST75156_SLEEP_MS | 0x01 | ms |
+	 * +------------------+------+----+
+	 *
+	 * When this command is sent, the code will sleep for ms milliseconds before
+	 * sending the next command in the command list.
+	 */
+
+	int ret;
+	int i = 0;
+
+	while (i < len) {
+		int command = cmd_list[i];
+		int num_params = cmd_list[i + 1];
+		int current_param = 0;
+		int param;
+		int bufpos = 0;
+		u8 *buf = st75156->commandbuf;
+
+		i = i + 2;
+
+		if (command == ST75156_SLEEP_MS) {
+			msleep(cmd_list[i]);
+		} else {
+			/* Add command to command buffer */
+			buf[bufpos] = command;
+			bufpos++;
+
+			if (bufpos >= ST75156_COMMAND_BUFFER_LEN)
+				return -EINVAL;
+
+			if (num_params > 0) {
+				if (num_params > ST75156_MAX_PARAMETERS)
+					return -EINVAL;
+
+				for (param = 0; param < num_params; param++) {
+					current_param = cmd_list[i + param];
+
+					/* Add parameter to command buffer */
+
+					if (bufpos >= ST75156_COMMAND_BUFFER_LEN)
+						return -EINVAL;
+
+					buf[bufpos] = current_param;
+					bufpos++;
+				}
+			}
+
+			/* Write command buffer */
+			ret = regmap_bulk_write(st75156->regmap, ST7571_COMMAND_MODE, buf, bufpos);
+			if (ret < 0)
+				return ret;
+		}
+
+		i = i + num_params;
+	}
+
+	return 0;
+}
+
 static inline u8 st7571_transform_xy(const char *p, int x, int y, u8 bpp)
 {
 	int xrest = x % 8;
@@ -127,6 +248,37 @@ static inline u8 st7571_transform_xy(const char *p, int x, int y, u8 bpp)
 	return result;
 }
 
+static inline u8 st75156_transform_xy(struct st7571_device *st75156, int x, int y)
+{
+	int xrest = x % 8;
+	u8 result = 0;
+	u8 row_len = (st75156->ncols / 8) * st75156->bpp;
+	int i;
+	const char *p = st75156->hwbuf;
+
+	/*
+	 * Transforms an (x, y) pixel coordinate into a vertical 8-bit
+	 * column from the framebuffer. It calculates the corresponding byte in the
+	 * framebuffer, extracts the bit at the given x position across 8 consecutive
+	 * rows, and packs those bits into a single byte.
+	 *
+	 * Return an 8-bit value representing a vertical column of pixels.
+	 */
+	x = x / 8;
+	y = (y / 8) * 8;
+
+	for (i = 0; i < 8; i++) {
+		int row_idx = y + i;
+		u8 byte = p[row_idx * row_len + x];
+		/* LSB in input is left most pixel */
+		u8 bit = (byte >> xrest) & 1;
+		/* LSB in output is 7th row */
+		result |= (bit << (7 - i));
+	}
+
+	return result;
+}
+
 static int st7571_set_position(struct st7571_device *st7571, int x, int y)
 {
 	u8 cmd_list[] = {
@@ -138,6 +290,23 @@ static int st7571_set_position(struct st7571_device *st7571, int x, int y)
 	return st7571_send_command_list(st7571, cmd_list, ARRAY_SIZE(cmd_list));
 }
 
+static int st75156_set_position(struct st7571_device *st75156, int x, int y)
+{
+	u8 xs_param = st75156->startcol + x;
+	u8 xe_param = st75156->startcol + st75156->ncols - 1;
+	u8 ys_param = y / ST7571_PAGE_HEIGHT;
+	u8 ye_param = ys_param;
+
+	u8 cmd_list[] = {
+		ST75156_EXTENSION_COMMAND_1, 0x00,
+		ST75156_COLUMN_ADDRESS_SETTING, 0x02, xs_param, xe_param,
+		ST75156_PAGE_ADDRESS_SETTING, 0x02, ys_param, ye_param,
+		ST75156_ENTER_WRITE_DDRAM_MODE, 0x00,
+	};
+
+	return st75156_send_command_list(st75156, cmd_list, ARRAY_SIZE(cmd_list));
+}
+
 static int st7571_fb_clear_screen(struct st7571_device *st7571)
 {
 	u32 npixels = st7571->ncols * round_up(st7571->nlines, ST7571_PAGE_HEIGHT) * st7571->bpp;
@@ -150,6 +319,21 @@ static int st7571_fb_clear_screen(struct st7571_device *st7571)
 	return 0;
 }
 
+static int st75156_fb_clear_screen(struct st7571_device *st75156)
+{
+	u32 npixels = st75156->ncols * st75156->bpp;
+	int y;
+
+	memset(st75156->row, 0, npixels);
+
+	for (y = 0; y < st75156->nlines; y += ST7571_PAGE_HEIGHT) {
+		st75156_set_position(st75156, 0, y);
+		regmap_bulk_write(st75156->regmap, ST7571_DATA_MODE, st75156->row, npixels);
+	}
+
+	return 0;
+}
+
 static void st7571_prepare_buffer_monochrome(struct st7571_device *st7571,
 					     const struct iosys_map *vmap,
 					     struct drm_framebuffer *fb,
@@ -284,6 +468,37 @@ static int st7571_fb_update_rect_grayscale(struct drm_framebuffer *fb, struct dr
 	return 0;
 }
 
+static int st75156_fb_update_rect_monochrome(struct drm_framebuffer *fb, struct drm_rect *rect)
+{
+	struct st7571_device *st75156 = drm_to_st7571(fb->dev);
+	struct device *dev = st75156->dev;
+
+	char *row = st75156->row;
+	int x;
+	int y;
+	int num_bytes;
+	int ret;
+
+	/* Align y to display page boundaries */
+	rect->y1 = round_down(rect->y1, ST7571_PAGE_HEIGHT);
+	rect->y2 = min_t(unsigned int, round_up(rect->y2, ST7571_PAGE_HEIGHT), st75156->nlines);
+
+	for (y = rect->y1; y < rect->y2; y += ST7571_PAGE_HEIGHT) {
+		for (x = rect->x1; x < rect->x2; x++)
+			row[x] = st75156_transform_xy(st75156, x, y);
+
+		st75156_set_position(st75156, rect->x1, y);
+
+		num_bytes = (rect->x2) - (rect->x1);
+		ret = regmap_bulk_write(st75156->regmap, ST7571_DATA_MODE,
+					row + rect->x1, num_bytes);
+		if (ret < 0)
+			dev_err(dev, "Failed to write data to display (error code: %i", ret);
+	}
+
+	return 0;
+}
+
 static int st7571_connector_get_modes(struct drm_connector *conn)
 {
 	struct st7571_device *st7571 = drm_to_st7571(conn->dev);
@@ -318,6 +533,17 @@ static const struct st7571_panel_format st7571_grayscale = {
 	.nformats = 3,
 };
 
+static const struct st7571_panel_format st75156_monochrome = {
+	.prepare_buffer = st7571_prepare_buffer_monochrome,
+	.update_rect = st75156_fb_update_rect_monochrome,
+	.mode = ST7571_COLOR_MODE_BLACKWHITE,
+	.formats = {
+		DRM_FORMAT_XRGB8888,
+		DRM_FORMAT_R1,
+	},
+	.nformats = 2,
+};
+
 static const u64 st7571_primary_plane_fmtmods[] = {
 	DRM_FORMAT_MOD_LINEAR,
 	DRM_FORMAT_MOD_INVALID
@@ -388,7 +614,7 @@ static void st7571_primary_plane_helper_atomic_disable(struct drm_plane *plane,
 	if (!drm_dev_enter(drm, &idx))
 		return;
 
-	st7571_fb_clear_screen(st7571);
+	st7571->pdata->fb_clear_screen(st7571);
 	drm_dev_exit(idx);
 }
 
@@ -444,6 +670,13 @@ static void st7571_encoder_atomic_enable(struct drm_encoder *encoder,
 	u8 command = ST7571_DISPLAY_ON;
 	int ret;
 
+	/* ST75156 needs init function to be run earlier than ST7571
+	 * so we need to call it in the probe function instead of
+	 * the encoder_atomic_enable function.
+	 */
+	if (st7571->device_type == DEVICE_TYPE_ST75156)
+		return;
+
 	ret = st7571->pdata->init(st7571);
 	if (ret)
 		return;
@@ -458,6 +691,9 @@ static void st7571_encoder_atomic_disable(struct drm_encoder *encoder,
 	struct st7571_device *st7571 = drm_to_st7571(drm);
 	u8 command = ST7571_DISPLAY_OFF;
 
+	if (st7571->device_type == DEVICE_TYPE_ST75156)
+		return;
+
 	st7571_send_command_list(st7571, &command, 1);
 }
 
@@ -672,6 +908,8 @@ static int st7567_parse_dt(struct st7571_device *st7567)
 	st7567->nlines = dt.vactive.typ;
 	st7567->ncols = dt.hactive.typ;
 
+	st7567->device_type = DEVICE_TYPE_ST7567;
+
 	return 0;
 }
 
@@ -710,6 +948,52 @@ static int st7571_parse_dt(struct st7571_device *st7571)
 		return dev_err_probe(dev, PTR_ERR(st7571->reset),
 				     "Failed to get reset gpio\n");
 
+	st7571->device_type = DEVICE_TYPE_ST7571;
+
+	return 0;
+}
+
+static int st75156_parse_dt(struct st7571_device *st75156)
+{
+	struct device *dev = st75156->dev;
+	struct device_node *np = dev->of_node;
+	struct display_timing dt;
+	int ret;
+
+	ret = of_get_display_timing(np, "panel-timing", &dt);
+
+	if (ret) {
+		dev_err(dev, "Failed to get display timing from DT\n");
+		return ret;
+	}
+
+	of_property_read_u32(np, "width-mm", &st75156->width_mm);
+	of_property_read_u32(np, "height-mm", &st75156->height_mm);
+	st75156->inverted = of_property_read_bool(np, "sitronix,inverted");
+
+	st75156->pformat = &st75156_monochrome;
+	st75156->bpp = 1;
+
+	st75156->startline = dt.vback_porch.typ;
+	st75156->startcol = dt.hback_porch.typ;
+
+	st75156->nlines = dt.vactive.typ;
+	st75156->ncols = dt.hactive.typ;
+
+	st75156->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+
+	if (IS_ERR(st75156->reset)) {
+		return dev_err_probe(dev, PTR_ERR(st75156->reset),
+				     "Failed to get reset gpio from DT\n");
+	}
+
+	st75156->device_type = DEVICE_TYPE_ST75156;
+
+	st75156->backlight = devm_of_find_backlight(dev);
+	if (IS_ERR(st75156->backlight))
+		return dev_err_probe(dev, PTR_ERR(st75156->backlight),
+			"Failed to get backlight from DT\n");
+
 	return 0;
 }
 
@@ -720,6 +1004,14 @@ static void st7571_reset(struct st7571_device *st7571)
 	gpiod_set_value_cansleep(st7571->reset, 0);
 }
 
+static void st75156_reset(struct st7571_device *st7571)
+{
+	gpiod_set_value_cansleep(st7571->reset, 0);
+	usleep_range(20, 10000);
+	gpiod_set_value_cansleep(st7571->reset, 1);
+	msleep(120);
+}
+
 static int st7567_lcd_init(struct st7571_device *st7567)
 {
 	/*
@@ -799,8 +1091,86 @@ static int st7571_lcd_init(struct st7571_device *st7571)
 	return st7571_send_command_list(st7571, commands, ARRAY_SIZE(commands));
 }
 
-struct st7571_device *st7571_probe(struct device *dev,
-				   struct regmap *regmap)
+static int st75156_lcd_init(struct st7571_device *st75156)
+{
+	int ret;
+
+	/* Each command in the command list is formatted using the following format:
+	 *
+	 * +---------+--------------------------+-------------+------+-------------+
+	 * | command | number of parameters (n) | parameter 1 | .... | parameter n |
+	 * +---------+--------------------------+-------------+------+-------------+
+	 *
+	 * For example, if a command has 2 parameters it is stored like this:
+	 *
+	 * +---------+------+-------------+--------------+
+	 * | command | 0x02 | parameter 1 |  parameter 2 |
+	 * +---------+------+-------------+--------------+
+	 *
+	 * If a command does not have any parameters it is stored like this:
+	 *
+	 * +---------+------+
+	 * | command | 0x00 |
+	 * +---------+------+
+	 *
+	 * NOTE: The command ST75156_SLEEP_MS (0x00) is a special command defined like this:
+	 *
+	 * +------------------+------+----+
+	 * | ST75156_SLEEP_MS | 0x01 | ms |
+	 * +------------------+------+----+
+	 *
+	 * When this command is sent, the code will sleep for ms milliseconds before
+	 * sending the next command in the command list.
+	 */
+
+	u8 commands[] = {
+		ST75156_EXTENSION_COMMAND_2, 0x00,
+		ST75156_SET_AUTO_READ_INSTRUCTION, 0x01, ST75156_DISABLE_AUTO_READ,
+		ST75156_OTP_WR_RD_CONTROL, 0x01, 0x10,
+		ST75156_SLEEP_MS, 0x01, 0x0a,
+		ST75156_OTP_UPLOAD, 0x00,
+		ST75156_SLEEP_MS, 0x01, 0x14,
+		ST75156_OTP_CONTROL_OUT, 0x00,
+		ST75156_EXTENSION_COMMAND_1, 0x00,
+		ST75156_SLEEP_OUT, 0x00,
+		ST75156_DISPLAY_OFF, 0x00,
+		ST75156_SLEEP_MS, 0x01, 0x32,
+		ST75156_POWER_CONTROL, 0x01, 0x0b,
+		ST75156_SLEEP_MS, 0x01, 0x64,
+		ST75156_SET_VOP, 0x02, 0x06, 0x03,
+		ST75156_EXTENSION_COMMAND_2, 0x00,
+		ST75156_ANALOG_CIRCUIT_SET, 0x03, 0x00, 0x01, 0x05,
+		ST75156_BOOSTER_LEVEL_X10, 0x01, 0xfb,
+		ST75156_EXTENSION_COMMAND_1, 0x00,
+		ST75156_DISPLAY_MODE, 0x01, 0x10,
+		ST75156_DISPLAY_CONTROL, 0x03, 0x00, 0x3f, 0x00,
+		ST75156_DATA_SCAN_DIRECTION, 0x01, 0x02,
+		ST75156_NORMAL_DISPLAY, 0x00,
+		ST75156_EXTENSION_COMMAND_2, 0x00,
+		ST75156_INTERAL_POWER_SUPPLY, 0x00,
+		ST75156_EXTENSION_COMMAND_1, 0x00,
+		ST75156_COLUMN_ADDRESS_SETTING, 0x02, 0x00, 0xef,
+		ST75156_PAGE_ADDRESS_SETTING, 0x02, 0x00, 0x07,
+		ST75156_DISPLAY_ON, 0x00,
+	};
+
+	/* Perform a reset before initializing the controller */
+	st75156_reset(st75156);
+
+	ret = st75156_send_command_list(st75156, commands, ARRAY_SIZE(commands));
+	if (ret < 0)
+		return ret;
+
+	/* Clear the screen after the controller has been initialized */
+	st75156_fb_clear_screen(st75156);
+
+	/* Enable backlight */
+	backlight_enable(st75156->backlight);
+
+	return 0;
+}
+
+struct st7571_device *st7571_probe(struct device *dev, struct regmap *regmap)
 {
 	struct st7571_device *st7571;
 	struct drm_device *drm;
@@ -832,12 +1202,22 @@ struct st7571_device *st7571_probe(struct device *dev,
 	if (!st7571->hwbuf)
 		return ERR_PTR(-ENOMEM);
 
+	memset(st7571->hwbuf, 0,  (st7571->nlines * st7571->ncols * st7571->bpp) / 8);
+
 	st7571->row = devm_kzalloc(st7571->dev,
 				   (st7571->ncols * st7571->bpp),
 				   GFP_KERNEL);
 	if (!st7571->row)
 		return ERR_PTR(-ENOMEM);
 
+	memset(st7571->row, 0, (st7571->ncols * st7571->bpp));
+
+	st7571->commandbuf = devm_kzalloc(st7571->dev,
+					  ST75156_COMMAND_BUFFER_LEN,
+							GFP_KERNEL);
+	if (!st7571->commandbuf)
+		return ERR_PTR(-ENOMEM);
+
 	ret = st7571_mode_config_init(st7571);
 	if (ret) {
 		dev_err(st7571->dev, "Failed to initialize mode config\n");
@@ -868,6 +1248,18 @@ struct st7571_device *st7571_probe(struct device *dev,
 		return ERR_PTR(ret);
 	}
 
+	if (st7571->device_type == DEVICE_TYPE_ST75156) {
+		/* ST75156 needs init function to be run earlier than ST7571
+		 * so we need to call it in the probe function instead of
+		 * the encoder_atomic_enable function.
+		 */
+		ret = st7571->pdata->init(st7571);
+		if (ret) {
+			dev_err(st7571->dev, "Failed to init display\n");
+			return ERR_PTR(ret);
+		}
+	}
+
 	drm_mode_config_reset(drm);
 
 	ret = drm_dev_register(drm, 0);
@@ -890,6 +1282,7 @@ EXPORT_SYMBOL_GPL(st7571_remove);
 const struct st7571_panel_data st7567_config = {
 	.init = st7567_lcd_init,
 	.parse_dt = st7567_parse_dt,
+	.fb_clear_screen = st7571_fb_clear_screen,
 	.constraints = {
 		.min_nlines = 1,
 		.max_nlines = 64,
@@ -903,6 +1296,7 @@ EXPORT_SYMBOL_NS_GPL(st7567_config, "DRM_ST7571");
 const struct st7571_panel_data st7571_config = {
 	.init = st7571_lcd_init,
 	.parse_dt = st7571_parse_dt,
+	.fb_clear_screen = st7571_fb_clear_screen,
 	.constraints = {
 		.min_nlines = 1,
 		.max_nlines = 128,
@@ -913,6 +1307,20 @@ const struct st7571_panel_data st7571_config = {
 };
 EXPORT_SYMBOL_NS_GPL(st7571_config, "DRM_ST7571");
 
+const struct st7571_panel_data st75156_config = {
+	.init = st75156_lcd_init,
+	.parse_dt = st75156_parse_dt,
+	.fb_clear_screen = st75156_fb_clear_screen,
+	.constraints = {
+		.min_nlines = 1,
+		.max_nlines = 64,
+		.min_ncols = 240,
+		.max_ncols = 240,
+		.support_grayscale = false,
+	},
+};
+EXPORT_SYMBOL_NS_GPL(st75156_config, "DRM_ST7571");
+
 MODULE_AUTHOR("Marcus Folkesson <marcus.folkesson@gmail.com>");
 MODULE_DESCRIPTION("DRM Driver for Sitronix ST7571 LCD controller");
 MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/sitronix/st7571.h b/drivers/gpu/drm/sitronix/st7571.h
index af264f2e2ea4..6e3e70f12c2d 100644
--- a/drivers/gpu/drm/sitronix/st7571.h
+++ b/drivers/gpu/drm/sitronix/st7571.h
@@ -17,11 +17,20 @@
 
 #include <linux/regmap.h>
 
+#define ST7571_COMMAND_MODE			(0x00)
+#define ST7571_DATA_MODE			(0x40)
+
 enum st7571_color_mode {
 	ST7571_COLOR_MODE_GRAY = 0,
 	ST7571_COLOR_MODE_BLACKWHITE = 1,
 };
 
+enum DeviceType {
+	DEVICE_TYPE_ST7567,
+	DEVICE_TYPE_ST7571,
+	DEVICE_TYPE_ST75156
+};
+
 struct st7571_device;
 
 struct st7571_panel_constraints {
@@ -35,6 +44,7 @@ struct st7571_panel_constraints {
 struct st7571_panel_data {
 	int (*init)(struct st7571_device *st7571);
 	int (*parse_dt)(struct st7571_device *st7571);
+	int (*fb_clear_screen)(struct st7571_device *st7571);
 	struct st7571_panel_constraints constraints;
 };
 
@@ -65,12 +75,15 @@ struct st7571_device {
 	const struct st7571_panel_data *pdata;
 	struct gpio_desc *reset;
 	struct regmap *regmap;
+	struct spi_device_data *spi_data;
+	struct backlight_device *backlight;
 
 	bool grayscale;
 	bool inverted;
 	u32 height_mm;
 	u32 width_mm;
 	u32 startline;
+	u32 startcol;
 	u32 nlines;
 	u32 ncols;
 	u32 bpp;
@@ -80,10 +93,17 @@ struct st7571_device {
 
 	/* Row of (transformed) pixels ready to be written to the display */
 	u8 *row;
+
+	/* Buffer containing current command and parameters */
+	u8 *commandbuf;
+
+	/* Type of device */
+	enum DeviceType device_type;
 };
 
 extern const struct st7571_panel_data st7567_config;
 extern const struct st7571_panel_data st7571_config;
+extern const struct st7571_panel_data st75156_config;
 
 struct st7571_device *st7571_probe(struct device *dev, struct regmap *regmap);
 void st7571_remove(struct st7571_device *st7571);

-- 
2.43.0

