Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBCD10F9318
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 01:38:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3306410EA19;
	Wed,  1 Apr 2026 01:38:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MN6xtnmZ";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E28710EA19
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 01:38:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVeqrQixEJi++8JEtOTQ+9etY6xbSpNOzU5QGQyvpQnRluqm2zwXwM4SlPRXE18oRzTjw94hJfw16NncNie7yZysDbYEA6fKzZsMP49Xuzdv+xvKNk1aZVDN3f8D1TMi1am9eONMw0Aorku7k0pjG+j3Zl44lLgCTr/dALa4vENTBFEbgPfCCp3/MCQKqvfo1wj3fng+yeSvcoo1LI/VkguQEfsKsDDeR8igc6AXhXHwcTRQN7e8YHU8JAG0TtrHhQ815Uj6xmG/qRFfXWE1ubtDf7F3lHKM9Iixl/0LJKN0F2WCTt5KB2sIoyWm1A+k+1WQGVWQ8ncADL7/tDulJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsPTxubmSO6BbnbaJYSKbs9/3l/bth/mMPif6X+qGe4=;
 b=ck3MMIu+CvY0qGQQRe6pYebnBd0vs2KAoDdYdFURXGoXnM67DNzQjLyrMlbNQ7AkB3s26GYze+63SVqZY3LFkPQ3qJiKD+qKAGiP/1D7ACth37QzfrusGm6CFF8h3d7ivO2KFpu31wz0E5VSOBrZ9RvS5gepP5GrEDTL9SmlnWAfp5Ciz4S7dqc2dTa95xCaelcafOmTJha6+iRd/+AeWL75GkIbzLcWr/EdZnsKY9qbcZEQiVOMh5SFZpyslQOk95CgzyrBJyzxRrbHOZoeOcvZlkFg4yid873KNkpHRLO6T+s7hA9WGoGurtGJNVuDMNF9IiPAKpswt1Fb7Jyptg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsPTxubmSO6BbnbaJYSKbs9/3l/bth/mMPif6X+qGe4=;
 b=MN6xtnmZSAffEYLrntYLuYJZM5/imO+cQU1yMi7hc446Mg5tkEspr6l1TJMCofqKpTy+1HqEZojfws/SUyLu/mKcE3hD+sfbYnQhTTg66xjYct0xDasnVo5mIMLx3fbhJCfISHMB2khhzdQdfGiUAuDIJ1iiBl09f+Zj+Yf7TDY=
Received: from CY5PR15CA0024.namprd15.prod.outlook.com (2603:10b6:930:14::16)
 by LV3PR10MB7983.namprd10.prod.outlook.com (2603:10b6:408:218::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 01:38:17 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:14:cafe::b6) by CY5PR15CA0024.outlook.office365.com
 (2603:10b6:930:14::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 01:38:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 01:38:14 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 31 Mar
 2026 20:38:11 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 31 Mar
 2026 20:38:11 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 31 Mar 2026 20:38:11 -0500
Received: from localhost (mz02jj9v.dhcp.ti.com [128.247.81.246])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6311cBrY3810273;
 Tue, 31 Mar 2026 20:38:11 -0500
From: Sen Wang <sen@ti.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>
CC: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Devarsh
 Thakkar" <devarsht@ti.com>, Rahul Donadkar <r-donadkar@ti.com>, Siddharth
 Jain <s-jain1@ti.com>, Sen Wang <sen@ti.com>
Subject: [PATCH] drm/bridge: sii902x: Add Power Management hooks with audio
 context
Date: Tue, 31 Mar 2026 20:37:58 -0500
Message-ID: <20260401013758.4149091-1-sen@ti.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|LV3PR10MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: c7f03db6-0f86-4afb-b7cb-08de8f8f5786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|7416014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: fULLqFT1PMHNwwSB/fd2hAQLjS5VGVTs0JJ5/fvrmJKrcIjhjmg9OGVM+ycfouWn9BQimnkyqhU5I+cqz+uBMEy98EYAKgkrvkfCF0zK9zMvrdNFshuT/+wQGx2VqlE4SFEDYLh3He9Woh6f1fc/JrU2dIeqUJxsTdVjQWMnPKmuGcHdtRMZNG36xIK7prd1GqlUsWjGeLpcvhxCj+dnhxCfYmonqLOMlYC77d+pOoay/OzGaCNyag9uHDuYVESNMzENSj1cJ++MeTBmWrX3YSe81KdQZ8aTI1BIznx7cZnndZH0fv5E413OqER5D4CAyTQ6lpSxl6mjO6keYiNtIkg4cjKJGobVDitP3nrGZJjKgUN5tylvyqkZFw3I/oEov+SI+sfmIV/He2a6WrbUyaLe+fr+RtvTGAuqCry1egJ4eV85O+aZM2Y3chEOtb7Rp4vtJWfp26Os+C2BBTemIE2Q2zfhv/FByF/n/vY9VOBTER3Y8ik6g0+cOcNSnf8uqAf818db5H0dV0rO9jh10P4/xYuRlgiGUZwcjMCxGQOAWFdMboQ2SRoByki2yrvmzBNDfOb1D90bo2+EvBVe1aQzXFDa3/6y95Lr4x7klL4GsV3s7zYeyfpdhU9HTLtfNIQWGiaBXTuQQEaMNZiPvoIWhXwCW/vE0aEe4ByuXIxn3NmtsceOGvD4hWIn+cnh8kWZH5oqctynwio5a0QublLTfQnvOac8IA6sie+CXf87zt1QFQgEOMRcYAn7x6cQFru83PjG1daCfIos7RqyyA==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(7416014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: a/PU2GpPGJI1UheCqrexwCqJiGDuo5cdeiOW3wP4H12jlq1ahNnaPi5T9XjIlLt6GROFr9YSzFe7fKLs9xHzP0ZSnHlvSRB2LEbAPBilXKi2NcD57PD5SIVH0hq2lc6slV5Js1haVkhJP8QyqhvPfYSGYS5NssdLRNZ9jkZ2ZnCQTZpoMaUD7JFlbeqdAZVvKYPLp85k2osYWQtlDHjGKr3HhWrEP2MyWRmzShCQ8xmd1w8qvIwsgk8bj5B4efdeSZnJT+Di8VytsRMoOvzrICkXIiUyjwy5ybxOSc3M9atg99Ysyee7ocDGEZ40k4ivVKWhyVBakxDWQDEcX7+A9f9D8Ce8B48lcGaq4lE1VSH9rw6xXUcRmiRwLnk17139IeHT7f6/pebYYkIk8SUByNFOm0VQ8EM9qfx4wzEYEshymC01cAdiJm26ERd50C7M
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 01:38:14.3830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f03db6-0f86-4afb-b7cb-08de8f8f5786
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7983
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

Add suspend and resume hooks. On suspend, save TPI mode, interrupt
enable, and audio register context (when active). On resume, detect
power loss by comparing the saved TPI value; if changed, reset the
device and restore TPI mode and interrupts. Restore audio registers
and re-enable mclk if audio was active before suspend.

Audio register values are read back during suspend rather than cached
during hw_params, as the sii902x requires a specific register write
sequence during initialization that must be preserved on resume.

Based on initial PM hooks implementation by:
  Aradhya Bhatia <a-bhatia1@ti.com>
  Jayesh Choudhary <j-choudhary@ti.com>

Signed-off-by: Sen Wang <sen@ti.com>
---
Tested on TI SK-AM62P-LP board with HDMI audio playback across multiple
suspend/resume cycles.

 drivers/gpu/drm/bridge/sii902x.c | 165 +++++++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 12497f5ce4ff..8da8ca22ac99 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -179,6 +179,8 @@ struct sii902x {
 	struct gpio_desc *reset_gpio;
 	struct i2c_mux_core *i2cmux;
 	u32 bus_width;
+	unsigned int ctx_tpi;
+	unsigned int ctx_interrupt;
 
 	/*
 	 * Mutex protects audio and video functions from interfering
@@ -189,6 +191,13 @@ struct sii902x {
 		struct platform_device *pdev;
 		struct clk *mclk;
 		u32 i2s_fifo_sequence[4];
+		bool active;
+		/* Audio register context for suspend/resume */
+		unsigned int ctx_i2s_input_config;
+		unsigned int ctx_audio_config_byte2;
+		unsigned int ctx_audio_config_byte3;
+		u8 ctx_i2s_stream_header[SII902X_TPI_I2S_STRM_HDR_SIZE];
+		u8 ctx_audio_infoframe[SII902X_TPI_MISC_INFOFRAME_SIZE];
 	} audio;
 };
 
@@ -755,6 +764,8 @@ static int sii902x_audio_hw_params(struct device *dev, void *data,
 	if (ret)
 		goto out;
 
+	sii902x->audio.active = true;
+
 	dev_dbg(dev, "%s: hdmi audio enabled\n", __func__);
 out:
 	mutex_unlock(&sii902x->mutex);
@@ -777,6 +788,8 @@ static void sii902x_audio_shutdown(struct device *dev, void *data)
 	regmap_write(sii902x->regmap, SII902X_TPI_AUDIO_CONFIG_BYTE2_REG,
 		     SII902X_TPI_AUDIO_INTERFACE_DISABLE);
 
+	sii902x->audio.active = false;
+
 	mutex_unlock(&sii902x->mutex);
 
 	clk_disable_unprepare(sii902x->audio.mclk);
@@ -1069,6 +1082,157 @@ static const struct drm_bridge_timings default_sii902x_timings = {
 		 | DRM_BUS_FLAG_DE_HIGH,
 };
 
+static int sii902x_resume(struct device *dev)
+{
+	struct sii902x *sii902x = dev_get_drvdata(dev);
+	unsigned int tpi_reg, status;
+	int ret, i;
+
+	ret = regmap_read(sii902x->regmap, SII902X_REG_TPI_RQB, &tpi_reg);
+	if (ret)
+		return ret;
+
+	if (tpi_reg != sii902x->ctx_tpi) {
+		/*
+		 * TPI register context has changed. SII902X power supply
+		 * device has been turned off and on.
+		 */
+		sii902x_reset(sii902x);
+
+		/* Configure the device to enter TPI mode. */
+		ret = regmap_write(sii902x->regmap, SII902X_REG_TPI_RQB, 0x0);
+		if (ret)
+			return ret;
+
+		/* Re-enable the interrupts */
+		regmap_write(sii902x->regmap, SII902X_INT_ENABLE,
+			     sii902x->ctx_interrupt);
+	}
+
+	/* Clear all pending interrupts */
+	regmap_read(sii902x->regmap, SII902X_INT_STATUS, &status);
+	regmap_write(sii902x->regmap, SII902X_INT_STATUS, status);
+
+	/*
+	 * Restore audio context if audio was active before suspend,
+	 * in the matching order of sii902x_audio_hw_params() initialization.
+	 */
+	if (sii902x->audio.active) {
+		ret = clk_prepare_enable(sii902x->audio.mclk);
+		if (ret) {
+			dev_err(dev, "Failed to re-enable mclk: %d\n", ret);
+			return ret;
+		}
+
+		ret = regmap_write(sii902x->regmap, SII902X_TPI_AUDIO_CONFIG_BYTE2_REG,
+				   sii902x->audio.ctx_audio_config_byte2);
+		if (ret)
+			goto err_audio_resume;
+
+		ret = regmap_write(sii902x->regmap, SII902X_TPI_I2S_INPUT_CONFIG_REG,
+				   sii902x->audio.ctx_i2s_input_config);
+		if (ret)
+			goto err_audio_resume;
+
+		for (i = 0; i < ARRAY_SIZE(sii902x->audio.i2s_fifo_sequence) &&
+		     sii902x->audio.i2s_fifo_sequence[i]; i++) {
+			ret = regmap_write(sii902x->regmap,
+					   SII902X_TPI_I2S_ENABLE_MAPPING_REG,
+					   sii902x->audio.i2s_fifo_sequence[i]);
+			if (ret)
+				goto err_audio_resume;
+		}
+
+		ret = regmap_write(sii902x->regmap, SII902X_TPI_AUDIO_CONFIG_BYTE3_REG,
+				   sii902x->audio.ctx_audio_config_byte3);
+		if (ret)
+			goto err_audio_resume;
+
+		ret = regmap_bulk_write(sii902x->regmap, SII902X_TPI_I2S_STRM_HDR_BASE,
+					sii902x->audio.ctx_i2s_stream_header,
+					SII902X_TPI_I2S_STRM_HDR_SIZE);
+		if (ret)
+			goto err_audio_resume;
+
+		ret = regmap_bulk_write(sii902x->regmap, SII902X_TPI_MISC_INFOFRAME_BASE,
+					sii902x->audio.ctx_audio_infoframe,
+					SII902X_TPI_MISC_INFOFRAME_SIZE);
+		if (ret)
+			goto err_audio_resume;
+	}
+
+	return 0;
+
+err_audio_resume:
+	clk_disable_unprepare(sii902x->audio.mclk);
+	dev_err(dev, "Failed to restore audio registers: %d\n", ret);
+	return ret;
+}
+
+static int sii902x_suspend(struct device *dev)
+{
+	struct sii902x *sii902x = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regmap_read(sii902x->regmap, SII902X_REG_TPI_RQB,
+			  &sii902x->ctx_tpi);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(sii902x->regmap, SII902X_INT_ENABLE,
+			  &sii902x->ctx_interrupt);
+	if (ret)
+		return ret;
+
+	/*
+	 * Save audio context if audio is active, in the matching order
+	 * of sii902x_audio_hw_params() initialization.
+	 */
+	if (sii902x->audio.active) {
+		ret = regmap_read(sii902x->regmap, SII902X_TPI_AUDIO_CONFIG_BYTE2_REG,
+				  &sii902x->audio.ctx_audio_config_byte2);
+		if (ret)
+			goto err_audio_suspend;
+
+		ret = regmap_read(sii902x->regmap, SII902X_TPI_I2S_INPUT_CONFIG_REG,
+				  &sii902x->audio.ctx_i2s_input_config);
+		if (ret)
+			goto err_audio_suspend;
+
+		ret = regmap_read(sii902x->regmap, SII902X_TPI_AUDIO_CONFIG_BYTE3_REG,
+				  &sii902x->audio.ctx_audio_config_byte3);
+		if (ret)
+			goto err_audio_suspend;
+
+		ret = regmap_bulk_read(sii902x->regmap, SII902X_TPI_I2S_STRM_HDR_BASE,
+				       sii902x->audio.ctx_i2s_stream_header,
+				       SII902X_TPI_I2S_STRM_HDR_SIZE);
+		if (ret)
+			goto err_audio_suspend;
+
+		ret = regmap_bulk_read(sii902x->regmap, SII902X_TPI_MISC_INFOFRAME_BASE,
+				       sii902x->audio.ctx_audio_infoframe,
+				       SII902X_TPI_MISC_INFOFRAME_SIZE);
+		if (ret)
+			goto err_audio_suspend;
+
+		/*
+		 * audio.active is kept true so that resume restores the audio
+		 * context. sii902x_audio_shutdown() clears it when the stream
+		 * is explicitly closed.
+		 */
+		clk_disable_unprepare(sii902x->audio.mclk);
+	}
+
+	return 0;
+
+err_audio_suspend:
+	dev_err(dev, "Failed to save audio context: %d\n", ret);
+	return ret;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(sii902x_pm_ops, sii902x_suspend, sii902x_resume);
+
 static int sii902x_init(struct sii902x *sii902x)
 {
 	struct device *dev = &sii902x->i2c->dev;
@@ -1247,6 +1411,7 @@ static struct i2c_driver sii902x_driver = {
 	.remove = sii902x_remove,
 	.driver = {
 		.name = "sii902x",
+		.pm = pm_sleep_ptr(&sii902x_pm_ops),
 		.of_match_table = sii902x_dt_ids,
 	},
 	.id_table = sii902x_i2c_ids,
-- 
2.43.0

