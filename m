Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214F3106ACE2
	for <dri-devel@archiver.kernel.org>; Thu, 12 Mar 2026 19:34:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82BBD10EA99;
	Thu, 12 Mar 2026 19:34:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pmbTLwt1";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011004.outbound.protection.outlook.com [52.101.62.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D7B010EA99
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Mar 2026 19:34:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzmZopmOqsG+959/QqY505dM9lyGyI80shDxpqxgXwb27dfrlywbSiMzwej4h1JPtHHW4Iqs9ZTtOyGbaDPg1nPkhYARQs+zf8+d3tRMvi5gpWVo7jaCJCF1lifbGshD2hjMBHeEwl3OHn1xEhPT9AV9jo/OYawXv5Pr9NViIwhFIq131bUQlrURVuWa+T8qEdFRd/UIiCYx1Xnb9T4l8mbNWOxfKd8s3/l1I9Yhd5kiwPQAWqXoX1dvc+DH0mNt81yYTt6C4c+h+AyiSKU5y//Fln6QEOdXLFimicdsi5oa31O8asCXE+Ki1894lxulyv8zOEeuetPG49kIMRfz5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+G7FiEMQky/RHawzouVc7CrycPmwB5hop2NvbivRVk=;
 b=mOr5JoqT58+DYBLpEMfaNgRmgTIeDei6Yy4Gba19mjXEHmdH+jEzcebrUOgDwgZIyz3AVsTyzUFFpywwYADsl3d2QSZkiGvAOj4ArddXUVwopjMI24Iyv12/xZn3WJEoFWpQSSId5PDpy1tVf80WEoD4V3COlnB/rDWOWg4sCXdtrdp4FX5L8r1chQRjseq2+tJfBWWxQbYVHfGfv0RPg6tQXJmK1QGD1Eet2FoFVBk6xWTqwuPSk0vaKO5ZVnygTyQT3X9uTPLuB8ARFvAgR46EdG4U/kGu0U3WVMqPhgOi0tT/nfK7qC4MlmGYy0x7aEA6JtqUmiA7BRnNFH+GBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+G7FiEMQky/RHawzouVc7CrycPmwB5hop2NvbivRVk=;
 b=pmbTLwt1NMAMUIAPwuzje45ymCekencb5EGPXw0X23pxF164/6rLTcXYXHrW6/c4mRhlBq0f9zKcPesXxoK0b5DiJxnqP4rqJgqCo+bR3ptzhnRbg6bwSMe/XqlJoZae94XaFEq3jWJJN28poT/8cVoT1ZY5tLESioFp12F4gU0=
Received: from BL1PR13CA0151.namprd13.prod.outlook.com (2603:10b6:208:2bd::6)
 by CH2PR10MB4182.namprd10.prod.outlook.com (2603:10b6:610:7a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Thu, 12 Mar
 2026 19:33:58 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:2bd:cafe::bd) by BL1PR13CA0151.outlook.office365.com
 (2603:10b6:208:2bd::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Thu,
 12 Mar 2026 19:33:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 19:33:58 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 14:33:56 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 14:33:56 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 12 Mar 2026 14:33:56 -0500
Received: from localhost (mz02jj9v.dhcp.ti.com [128.247.81.0])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62CJXuVY2891732;
 Thu, 12 Mar 2026 14:33:56 -0500
From: Sen Wang <sen@ti.com>
To: <ple@baylibre.com>, <neil.armstrong@linaro.org>
CC: <andrzej.hajda@intel.com>, <rfoss@kernel.org>,
 <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <devarsht@ti.com>, <s-jain1@ti.com>,
 <j-sahu@ti.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Sen Wang <sen@ti.com>
Subject: [PATCH] drm/bridge: ite-it66121: Disable HDMI audio capture stream
Date: Thu, 12 Mar 2026 14:33:55 -0500
Message-ID: <20260312193355.1348842-1-sen@ti.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|CH2PR10MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: afc69115-4056-4e84-2eba-08de806e4e63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: x75EI/+0rUHZycaD6NzeeRJggJ6fv69RAfG/ykhVxv4viHn41Z01njWP7ZJjF3Xn0Ijf5kJjy8mp8ZXL14P//r4lSqm2aoETsU8a/I9SSYjoLM6+pm3T6suQUc+rtP8LV2BFBwayMk5PTysUspiY2Skt+PQ7m6Q0icEqZgHkWUADbOGystREgifXyT5f2KjZ+DZuJ0d9BSKm115n64wVT9te2YyZkvq5Fd9oq0998ysu5rNzotl1Z83fgA5YRw+gd4nwFaBNa7K/TmkW0iTNFcrtb5O91jfTvpomTg71UzyJFHUrz/OYK0r2IK9ZPZmg0cjqN7GU+WFuECg4eZSos0Tl66ysFxMHcNddlA+Fs41dm9MDiIqiEcx2Mup2GxHLm3/fahBZHU27prvNXSgLW0mGv07w6xyCS7+k+ymMWe1syF3SwSsGP16OfVHnOUtPOnu7pKARkHTSeVU7208upV2CEN7qSgbaW7XwhKHI4PzC56lXY0PRQiVHsPED/BRw7Cr0AWA0whvrWz9vYQxlG6pwALM7/sbh6WYRFblGvO0skf20u8UQthSutBg54GsdGTmQ+V9R628xmV1UcOgJJ5yGMtK+bjd5b7AkwWEWP+Ykx5A7ytwVp1kNH2BFv9ivdi9qKWudenKEIBrq85UNAnzoJrtq5eHWcN88tUaYdNhGVDEeBExj9TMEQbS+3yYH+Hpv4tE+CSjmLd9RerWhJF+fnphsTwNNxLCK0bQMWpROq8Ms1M+50+CvQLiYE01I1lkA156uINpD2E3X3xqzmw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yRv10aeJW1NiMw+yEI76pngdUfo/fVS2jEZwoHx/IFykLU54xmtraYdel1MMi2sdS+oYMlAKse9Esm7cfR2btScAaw03mZQwLyeCGmSIHioJS/syROh4mwaVKzX1VlZ+20zKS1pKv5wjbN/2OtFz39j0sAK4E9mXs6QmtEXrePBD91jy5d9vWZt6RBiOoALT959qufSu08VgsFWx5oLZdkx+KEwJ2CrYcR93Pm37531YvAyoMtw49vIfK2fW/Z144RfKExTznLejMJBkCBhfhRt0i+bh4fbHUZh3qtRoq3a5P2PdzueTQQaRX2njTdEZ12S+9nVUvaIfPrxKo5o5t+WUUwu30Q5BlEip3wJxUri+3HA9U1XGrFp+m8CViXtZbUu3+YUdYp6TQHec92M1HDKDQTWkeYwZpNhLTnwW6saGE6EGaX0Mcfl3AjSnU5CN
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 19:33:58.1876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afc69115-4056-4e84-2eba-08de806e4e63
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4182
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

The IT66121 is an HDMI transmitter and does not support audio capture.
However, the driver registers hdmi-codec without setting no_i2s_capture,
causing the codec to advertise a non-functional capture stream. Userspace
audio servers such as PulseAudio then attempt to open this capture
device, resulting in errors.

Set no_i2s_capture and no_spdif_capture in hdmi_codec_pdata so that the
hdmi-codec driver only registers playback, matching the actual hardware
capability.

Signed-off-by: Sen Wang <sen@ti.com>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 329fa47a5701..a1b2c3d4e5f6 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -1476,6 +1476,8 @@ static int it66121_audio_codec_init(struct it66121_ctx *ctx, struct device *dev)
 		.i2s = 1, /* Only i2s support for now */
 		.spdif = 0,
 		.max_i2s_channels = 8,
+		.no_i2s_capture = 1,
+		.no_spdif_capture = 1,
 		.no_capture_mute = 1,
 	};

--
2.34.1
