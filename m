Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AC0C5B572
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 02:06:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC3D010E48D;
	Tue, 18 Aug 2026 02:06:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=analogixsemi.com header.i=@analogixsemi.com header.b="jFA6K/8j";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11022104.outbound.protection.outlook.com
 [40.107.200.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEBA810E48D
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 02:06:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rj1X6guqwUiUgIiXMN177b6RpAQU0lMkS3wHnAgS20PvEgy38PhjS590vf21BGtGzqWLU2RBTGMevn1ywK/vpZb3UosnIQB+gyXh00mWRn0niRvLWiD9EuhqyZUH7n6+qkC2a4JXf0Hv/jZW4Lh5rR4hjiDYkBTERmsBxKar79RjLrXroNnuZLx2zXZ8DgKEOpI07Zd3HDQO5G1yujWdQXjw6tIqGuTHQGbzS919mymiV+IndnYS7Ej5yDEI+JLKqalFUdXBb52L9y86yXRMcmFCOv0PrrEh1ZAHxa87Fmpq03wbKbNY3/nf3/CgRTaIx8pzz9bF0M7z8kCXmtkCeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8IiN5xIsKa9+38jC/GehE7cOe4lwGbMkNecP/Z9+Ig=;
 b=rDLM3QFG47uZ84ibaEDwINUNtC2ljKqYu34SQ8Nc5lHvr21cRPZHloCY9PBYwBux3t/BZDjHZLJjoHJM/AeYzTzdZoRb2fN8Rj/K9lh5xix2u8b4Agbt7GzTPnzxwVAtf8/0dZuM2BuqFMGzyuWWVaGpWzgHEPNlHYhs7YHwYvgLVbAVDnd410h+jC0qDhTIZp3mZCBWSbpg00+NXoawjR3c2OAidPYSG6VNPoCG5TW9e+Q6AZE0I2kE9i5lImWa5yk5TiMXMx1sbmxtAIkj1oD374/Dtna6L/h67Cpax6W5fb5Kr8nGzxI7vVqVTUdrJPfFq+LV+QxNTvnEaSDEYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analogixsemi.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8IiN5xIsKa9+38jC/GehE7cOe4lwGbMkNecP/Z9+Ig=;
 b=jFA6K/8jYpZ2z40QnG6wzbXDJ892IMrN1zp7UkKGX/ECFZNtSV7fbky8bzw3PqWPHA7gbuxb1wA9b1NTDwsh2actEkIp+O6MXI+oXjYAVD9cOXKwKKHz6gjgh9ExevwcN23seOzgQQDIrasoI1CZEBKLEya6icBWnTUg41dGAVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from DM6PR04MB6970.namprd04.prod.outlook.com (2603:10b6:5:244::15)
 by MN6PR04MB9681.namprd04.prod.outlook.com (2603:10b6:208:4f1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 02:06:52 +0000
Received: from DM6PR04MB6970.namprd04.prod.outlook.com
 ([fe80::c85b:1156:a070:b01c]) by DM6PR04MB6970.namprd04.prod.outlook.com
 ([fe80::c85b:1156:a070:b01c%4]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 02:06:52 +0000
From: Xin Ji <xji@analogixsemi.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: r.mereu@arduino.cc, bliang@analogixsemi.com, jhuang@analogixsemi.com,
 Xin Ji <xji@analogixsemi.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm: anx7625: add I2S input stream right justified control
Date: Tue, 18 Aug 2026 10:05:58 +0800
Message-Id: <20260818020559.961335-2-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260818020559.961335-1-xji@analogixsemi.com>
References: <20260818020559.961335-1-xji@analogixsemi.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0047.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::13) To DM6PR04MB6970.namprd04.prod.outlook.com
 (2603:10b6:5:244::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR04MB6970:EE_|MN6PR04MB9681:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e83ec3e-1f28-4234-0721-08defccd5ef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|23010399003|366016|1800799024|376014|921020|38350700014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zP0gvwcmQts34m9Ay3HmHzsAycHDy4xaj3rpZw/yuo2km8gxs3i8seQjwY3HJ7F7/oYRSBBzm5JlWpJ7425TVpRDBuPleQOvvrLXzR0puaEqT6h6MmaMrtBIT+P067rNE7FeWwJp2/ExWuFyVAJS1bULFTXHGbRvSkxMgJ7zEhZAVI8whL5MkvXsJK9luX6ahnoPxAnZK15NhM4+JDm5W4mVBQNoDBMcLW2evXCdJiVjYxJcTwYpT+WQqcB5wzczJdsUdDopQeqKiqkjaTpqD4GbIpBlFq18h1fjQJYd1CSvQeXl21NEHCMZoadrZ4ev50KTHJ/udFlsL6YK517YOLanU7DksVzYreAGziZ8EdYVcx/y8xSVh84wHKYdQACqWjWAao6eLUrUmyGNww9R9nvTIqYfZOn8kvUh2mlhVYL+EqqncZ7M/ljYo9iXFGrW5hCjB4fIz+Ww0QsnHAtJ2C1NI1PtBklJ+64IeTuEIXZSK36unDNKc1BzKXxa6ixsRf8UnFk+08/qEAbXwiDh9f+ymKbJlYOor4opAZaSyBcPFcpuz4XkWGPqZ5LMx4RfJ6CNeEmbr5DGtLjU2CsLiQaw3g99M5VZLUXUE3QkURchwcbLPWx9Y3qkhQ8xSrgkHuMKIiNoVKZTQ/8cfL5DvqAy+7R6EHCmtMvO55AmJXj+A4EE4TtZ4hhgLdqWii42ojQ5gCYLHj7s3nFG2pgyba5GgfeasgOYGM97lRmC+Rl/6qkfy5YZD5N/tkE6eiI1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6970.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(23010399003)(366016)(1800799024)(376014)(921020)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8eJIxnSB+Nn9bb+XHGMQL+l1zP5M5om/vMhgPa1DVsTgwHts24kX1iAFIaHB?=
 =?us-ascii?Q?NdkrCqbfXAGevkaFGlTJR41YZgfocbBjLMZ98SUPNu+MfmrTrIxIRgoQSUZ4?=
 =?us-ascii?Q?TfeYAcoy+5g1+9vExt4JlxCGX+23Kn/mXTeoxgfW/qhyxoWiJwYazT0w7K+r?=
 =?us-ascii?Q?ZX7fyq5/UZvzb/3fLQIQefQdkLK5MZgzmUTbUZiCFTs4UXtmtJ4XNZyDPCSc?=
 =?us-ascii?Q?2TBm0LTcyJ2Q5G09B62PY0+LS0o3mvW0lUnNzG34kzzxSAudDitPEb6i29dc?=
 =?us-ascii?Q?O5ZIbwOm9P9j4poD3qlWmO1umi0S1HCDI7wdZsZoUCMYSmftaa2HhwMPPm/h?=
 =?us-ascii?Q?ocLVM8bG1Jpyx1PwqcmQDwAQWl3P2hTTuqbVDRHTpkhho0AKe4uc5RrKAE9/?=
 =?us-ascii?Q?PbaJ1jeDm8V9R85toOiQa7dpOE5MZBEHg7nt5eGlxNIxf/FIe2TeI5Y1ktb1?=
 =?us-ascii?Q?ziRxNPinqbshCYp2JxVwpPCgH25nWK2HrKk72SmGjRvvQsBtV4SiIm8QtJWN?=
 =?us-ascii?Q?5M6qAnoWs6zK0s1R5jobw8dWXsrcEv/L2T1D2F/owiFHZbUgYeF8LQzHgbxA?=
 =?us-ascii?Q?8BYlbgA2C/JkJ/ymO4/8ufO+t4uiA7gifNm3RS4KiaByJf50vD4MxlzTO5qI?=
 =?us-ascii?Q?jJFRORRuEv/4Mx36m24Ul4C2bdwAWfkPvj7/X3Tde6mPC6L4mJLI1oDVdEAy?=
 =?us-ascii?Q?Aqi0EEuDcKfF6l4/jwxPUHIoc6Bmn4sw7PwR2azoSlzH6M8WVkATyDsCUhJr?=
 =?us-ascii?Q?Efsvpa2DAzgIeea+2iD5324JxV/TVHAEYjo5a9mitoOoM+UhsJFUyXvBx/VD?=
 =?us-ascii?Q?SY/LrkzwfKD0W5OKPGMaMJ4vslISC3dXR9IDiG6gqEiPE2em+MAcBU0OtD/1?=
 =?us-ascii?Q?L4odhiJtZXZxyqDSg54EhOppgFnATnVmmZgklJfnF8TMHIo5l5kk4QqhQ0iI?=
 =?us-ascii?Q?cBqhfNqVZ/t93cwJFcpVtXWUvl7B5U3772J4402Ayl5poV99NrqjGhRJF87p?=
 =?us-ascii?Q?+7bOuk1NsjPIDYX11XkUq2J2bYDAjPWol6Ee36er/9lXFqSnKFmCRCcNJnGN?=
 =?us-ascii?Q?zhq5HQPghLoLlzWVklwcdy/ZmFpMGi9R0FTDoiMy2igWA2/Cc7ZBfFlRsTkt?=
 =?us-ascii?Q?Wapqdsev5DRZDXYb8dq/jEjN+8nXOiHNITxdIBGynrUPDPnLMY1NoFrEWWly?=
 =?us-ascii?Q?dYyxMvnk9QxkAZ97VlAT+cB79xkUjVZavf5R6FfQ1ISuO5149Sr9O3m5Wjl5?=
 =?us-ascii?Q?ABgRS778ZLmQRwukOUy3zqHbyWYACbr0A1qQ1F1VLi7EC4e9O5x4ZEbeq2Hz?=
 =?us-ascii?Q?SuADtDUicQqDCKJs3vS8ABPNhnPfIs7UauWK8Z+N9JmH4V7w12qLfHV2Swr5?=
 =?us-ascii?Q?M0zdb1eI6BZ0D6TNUpugcyU/cyvJPaYJ45vDL+WT78SgnMEq8p/vTz+IeoWI?=
 =?us-ascii?Q?63s/HQiGpYgNqnirwqkmFqzBOXrgB4ZnwKavDd4HKXbrOumb/CplWzuk4Gr9?=
 =?us-ascii?Q?xTpFA0CHLPvWuttGUZ0qZ5BHQHIAD0JZgOb3Iv+pvZbIE4pbPRSVUnp7d6Wh?=
 =?us-ascii?Q?nZlXTSyVw5wd/g50K4x4+WD4KamGZrGGEcmuJm/KYshdsUhLjAy5yxxOJUd0?=
 =?us-ascii?Q?qCKQSQzFxXnVyUtotsEorS80MyobL2AKzBs+1fqjxvEaoTDG+Jlmj2MQpYXs?=
 =?us-ascii?Q?9WJaeuEUWXdJUHM2zX/4Ogq3d6HwPcdC7jLcEdYS2yQuGzzoXZXrXcgc94/v?=
 =?us-ascii?Q?6zOh7XcaFA=3D=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e83ec3e-1f28-4234-0721-08defccd5ef1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6970.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 02:06:52.5863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lVdmJD1TIuIQ8ca+07fT1yfCBG+YNhud7Oe8FjVTY52mkk0WQWIvaH9hMbU+zNqNuylzisnC2aNoaItzhsJeaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9681
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

The default audio data stream is left justify. When the
property "analogix,audio-right-justify-enable" is detected,
the code enables right justify.

Signed-off-by: Xin Ji <xji@analogixsemi.com>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 9 +++++++++
 drivers/gpu/drm/bridge/analogix/anx7625.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index c3af88e14f8b..f4bce0000676 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1883,6 +1883,9 @@ static int anx7625_parse_dt(struct device *dev,
 	if (of_property_read_bool(np, "analogix,audio-enable"))
 		pdata->audio_en = 1;
 
+	if (of_property_read_bool(np, "analogix,audio-right-justify-enable"))
+		pdata->audio_right_justify = 1;
+
 	return 0;
 }
 
@@ -2083,6 +2086,12 @@ static int anx7625_audio_hw_params(struct device *dev, void *data,
 		ret |= anx7625_write_and(ctx, ctx->i2c.tx_p2_client,
 				AUDIO_CHANNEL_STATUS_6, ~AUDIO_LAYOUT);
 
+	/* Right justified */
+	if (ctx->pdata.audio_right_justify)
+		ret |= anx7625_write_or(ctx, ctx->i2c.tx_p2_client,
+					AUDIO_CONTROL_REGISTER,
+					RIGHT_JUSTIFY_CTRL);
+
 	/* FS */
 	switch (params->sample_rate) {
 	case 32000:
diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.h b/drivers/gpu/drm/bridge/analogix/anx7625.h
index 957d234ec07c..9dd9970d2172 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.h
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.h
@@ -154,6 +154,8 @@
 #define HPD_TIME               54000
 
 #define AUDIO_CONTROL_REGISTER 0xe6
+#define RIGHT_JUSTIFY_CTRL     BIT(0)
+
 #define TDM_TIMING_MODE 0x08
 
 #define I2C_ADDR_72_DPTX              0x72
@@ -444,6 +446,7 @@ struct anx7625_platform_data {
 	int is_dpi;
 	int mipi_lanes;
 	int audio_en;
+	int audio_right_justify;
 	int dp_lane0_swing_reg_cnt;
 	u8 lane0_reg_data[DP_TX_SWING_REG_CNT];
 	int dp_lane1_swing_reg_cnt;
-- 
2.25.1

