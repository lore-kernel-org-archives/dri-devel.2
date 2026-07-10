Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E04EC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:12:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD1AE10E82A;
	Mon, 13 Jul 2026 07:11:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="FW6COT+0";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013058.outbound.protection.outlook.com
 [52.101.83.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CBAE10E14F
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 08:26:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBPvrTs0xRRUW1T2lfQYlMnUA+7yxE+gpcDq55dXBsMpQCZOOx5U54KVus+0/JUW+RhcLnagsCusztATTLmGaDe5uOQNHfvu50VXRTw3kx66khsd95mKJAoHeYbhGCQnh7nb9JZZTcxI/kbpGXtsufMlKS6wQc4GIMZCe/QKGJkIAj+QpEhUVBH38v4U+AnZU+AUV/gvRnA0VyvVHDujyGuCi/oCJCLvkmk9QBRV5iW3Pnf7R4A3B2O7GtA8ol0gK1eIgpW+Vc4MBtLGqa/N3UIXj5xR/1zzNNT7FYRD6PQjzKCMQrNEbEbRjfo61i5ijBxp359m7r29IvF74whdjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ps2pIAtsOlZ15mUfBLrNW3OT8Vmhj5ogRt2NgPNrbys=;
 b=Aa2Y6SLIFia8MlAgc/r7oTQs+Bx5ZZ1eRMusQ7rpNsqME0BDNCQldDhi8hglG3sbzdkAz7CK6cKolHw4FetbLN+RRkHAg+w0soBKAHHFoZ+NiQYlzR/Ff+3jPQIUsfTuPSr8Ot/980jXAW7iaIHX9iFHZDgSjGB7kQ3DvjuqQ3b+2V8kFGOo0jlIvuQ1ax3pvwWketCsrNKfgYb3o0mTyZfSl2Jp5IBhx3ROolBfDaXVT3n1Yvsj52+iVX2HMYTbwESxOo+d7iHIi2ocz4XpJ0o81k23Dhmag9/jQdIHPohRZ9fYCOFL1a9RI7cDKbakwQIGx9ddBRHcQjF3H7So6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ps2pIAtsOlZ15mUfBLrNW3OT8Vmhj5ogRt2NgPNrbys=;
 b=FW6COT+0OZEIaCfDDnUndiOZkOjvgZg0KeuD/UCYc44lUr+kfsykhAzGdQPtnNqL1C3Bvv1Mn/lZ3ykE/gW/OQGOTGQePWimhS10KXkNWMap19HM2mZSXFvv2ES+WIFVU3Fd6P+tq4yNiWJEzjAMnKuypJOIY3sq7q2ebZGy/TagR2jbkBDX6lX+aMDSNKwTrNNxWrFSHJqNmvSfrjBDHfSHw3FSJLNU1o/6FLEaEqwIeD5MQm6eboOjukNM8DyRm77f+HScft05wjKtO3p9sno9ma5FuBajSlw0qNIDa4yDZXan8P558yeCcSWD8pf6gllHG5MlzER8Rm43l5h3ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by DU0PR03MB9731.eurprd03.prod.outlook.com (2603:10a6:10:44d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 08:26:44 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 08:26:44 +0000
From: Wojciech Dubowik <wojciech.dubowik@mt.com>
To: linux-kernel@vger.kernel.org
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/2] drm/bridge: ti-sn65dsi83: Add reversed lvds lanes
 support
Date: Fri, 10 Jul 2026 10:26:28 +0200
Message-ID: <20260710082630.394040-3-wojciech.dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710082630.394040-1-wojciech.dubowik@mt.com>
References: <20260710082630.394040-1-wojciech.dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0028.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::15) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|DU0PR03MB9731:EE_
X-MS-Office365-Filtering-Correlation-Id: 10efb1de-672b-4228-b4c6-08dede5cf9dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|19092799006|1800799024|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EmB8l5ndddyRgL9jau3xOoGKcLYbhnHci3kIPmX87xIRDpSl6CjXy6XJCU5YcRN6gxZ/liwCkvxtfMUy9adPLIRiKYwZdulrMqlic+QkwQUncI+3gBu96Kf+oY4GDjlEkC8u3G7en2Ak/+5AaTIrGPJoK4SotIPdNQjVSWeIUudM0z5UiS7GzJiNH8LdRqA1IUhAOl/A1W2cn1kzIc59Mp6F0VNmmNuME9RmmViBdrl2x8fjr97A4A7st8RAoEFjpHSMTSg7RM9/fFN7+nwoqMt7M2qZNHmvIEwKVIBUUjSFlImnmIMYt+J1iZUCQZFdGocD9SAlKj0+2tYQ5rWSg/OgmJSyQC7CYNMpjXpQKFhhLKxyhT3qV9psIxY5wOmaK3h8wrlFkJwZ0uj3CVkdoQEPNwm+MDn4JvSdVfgVwRm/THPM0b8ZCXwV8Cb5n3lpOte4UFDbo8AMVyend90L7JgIzq65YTRxQ6HDa13UBcuo+8+/aIDrr3iwWiGe033sF5imFcaakhclqb8M9iYKsLtrJDpBVybCSjG+9grBQ9XR0PbFJCPVu+ArG1zdV2oUxwH3v8BuxQFqOpgz3eS6FFuFgF5mhsa2Qho5t5PjCVaPEHVy1bCQl2b8jaQVdsX4P7QwQUNABwcnY7fEMo+XwxadWbE6TtdnG5GaqOEmPds=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(19092799006)(1800799024)(56012099006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eKmxi943B8wiDHbAUIgCn+Z8TVU/CCBvXAThen71nx9W7JJ6K+QS/LiMgXgP?=
 =?us-ascii?Q?uLN3bgY03JukM+NHmtTyF0bd2lzK4ytny3E7IBxl/9G5jOTRctZGVPIfX2BP?=
 =?us-ascii?Q?DtV6ihqC2dDX/ABo9eyN0Dcvhm1fNoETS6Z9yZnsafKxXTzwRXZaQBNNh79z?=
 =?us-ascii?Q?z8JCPr52JhIR9WxHd9ta38vkGnWAJAipkigH/3Xy8OboXF7p0OC/bBmhUPL3?=
 =?us-ascii?Q?Pb4QBb51ew/AP5xPGHIQV9y5yvIvQTsxkYiGPn47DbYetIjaJ4i/WlEd/nvL?=
 =?us-ascii?Q?pmQH8EVoF3T3C6pD4XVP0pC9quV7MILhg1HARtcObZLXVaLyeKTBjvvJkWPf?=
 =?us-ascii?Q?oPaFYWcqV5JFa214ptsMPCu/pLUEbIN8kK3tpmU6R1Vh7xVPTxd440NwshHP?=
 =?us-ascii?Q?FfYiL01xuuAOiX+fp+LQUhVEo7/QpvLzXcAUNqM4KJpwe6afHYbOXqiZNiZu?=
 =?us-ascii?Q?qlZxNUmpj/O9NxnOGRVSnDvHdMyxmJ4WH1Grgi0gsTAcBBhrWEqV5dAMzDMn?=
 =?us-ascii?Q?VYYSwQ/qmAW7miyD1AMfxEPvvqKD+Ypz+CiOCkM7Pr6ogLIo65kGImBS55Y6?=
 =?us-ascii?Q?pBMPBEzilmuT++d4lQhc+WUgXp4qmJjqTJbmB1COqHXAZ0xSGPnRMXM6v+eV?=
 =?us-ascii?Q?u6VtlMMbvEO8dwIfTiGNi3DTwCyKhxbFqqCvQfr9skRIB9i0ng+LS9QKJuEw?=
 =?us-ascii?Q?AVTJ1nqXM647LAUSuDHN8XXjjSSuRF/XC5Q7uWQDc42epl7SQcs+c3tQuY14?=
 =?us-ascii?Q?1IYYvhiiTIrxFcYkwsxiI5oMPwXDXZzpTx7D+O5v0KWIrOkhxQDDjWmXqX4e?=
 =?us-ascii?Q?k+7mqaJgef23McieQAadfxq2OH7p05knvo8PdLhF1vuT2NXT89PBAXDt3V7C?=
 =?us-ascii?Q?NirS86kp66y5zT+QTydDsv5VLh3REW294ev4JvqSV8qm2SBok+QvEDKXfMzW?=
 =?us-ascii?Q?crDWFF39kyjXndQr137SLNI5lR8lJ7hLS8556OQ8cA+AwCwboP/AzD0MWBEt?=
 =?us-ascii?Q?xcg/ZoDLsiJ4QxnSNefXiFhD88BPFO2f9QM9rw7Ax+EyFs3PbB4aTKF6loZP?=
 =?us-ascii?Q?30NIHevo9iVTc7ltots/gdXnKyDOERRy87r3SWb/uoNYdlTBUXST9BVuS76+?=
 =?us-ascii?Q?gEqfSU4CbLEgZ2HKXpEPugnwkH9OErI11Sp0aUs+iKQRI0/VymiYhdnNP24n?=
 =?us-ascii?Q?qpWI4nCmpRbY/hv7Ilo7oL3BMT3GORl/GH/03PDsgEUSeq79CLGtbr94hp9k?=
 =?us-ascii?Q?8SGpYjxRvAc8YDObSR397hsEx6jKOPvMLKWjNbIRStsNgj52LwFWAqA16MiH?=
 =?us-ascii?Q?7ADXQA+dk5LVr1F0Okr9K/vpKt/N7mzjJOPNYeUexfhZ6DO+TSlZpefc+02Q?=
 =?us-ascii?Q?oi3mHWJ1vE107/b9QZxqB2JVdARWP75RFH7NtGfHPwRnxuZU7duHys7eK0DI?=
 =?us-ascii?Q?rwQW5FrLEjekFPrraCavgRhNgwkOeb2uTxLDOAOBTYzVWh4L4IlKCDvDUVgz?=
 =?us-ascii?Q?2HBvi5LIxnLeyXoDvt8/R8uQKLQuoYYzx6I8pEd5Ip2O6jQxR/E9RkwwyXgl?=
 =?us-ascii?Q?NckIQmu2U5tdN6ylrWKf0dCoeIPilfIS5iBLKZNbhNG8xVUQwCLXrpFgTO8X?=
 =?us-ascii?Q?c3ImSBVJK4bndJpw7iliIgJ3CvHktMZaex3MpD4DuPROFDXPfEaS2d9I/+8a?=
 =?us-ascii?Q?CaS11pH9p+Uok0EyZIiJA259kl7mgmvWboQnP0WamZXcU1N1qOKSp5dMeqSp?=
 =?us-ascii?Q?NM/OuTNP7Q=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10efb1de-672b-4228-b4c6-08dede5cf9dc
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:26:44.4292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HlMv4ACzYUTf+Yr6JH0P5pOsjGQvYMHBSKa9tECuM0Yt18c+uN5+iB0kVRh5KB1hgXdtTJWxd0DTJkxIfb86yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9731
X-Mailman-Approved-At: Mon, 13 Jul 2026 07:10:39 +0000
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

From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>

The chip supports output lvds lanes in two orders, default <1 2 3 4>
and <4 3 2 1>. Add parsing of an optional output lvds data-lanes
property so we can inform chip that the lanes have been reversed.

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 50 +++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 42b451432bbb..4945d4c960c4 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -148,6 +148,18 @@ enum sn65dsi83_lvds_term {
 	OHM_200
 };
 
+enum {
+	NORMAL_LANE_MAPPING,
+	REVERSE_LANE_MAPPING,
+};
+
+#define DATA_LANES_COUNT	4
+
+static const int supported_data_lane_mapping[][DATA_LANES_COUNT] = {
+	[NORMAL_LANE_MAPPING] = { 1, 2, 3, 4 },
+	[REVERSE_LANE_MAPPING] = { 4, 3, 2, 1},
+};
+
 enum sn65dsi83_model {
 	MODEL_SN65DSI83,
 	MODEL_SN65DSI84,
@@ -163,6 +175,7 @@ struct sn65dsi83 {
 	struct regulator		*vcc;
 	bool				lvds_dual_link;
 	bool				lvds_dual_link_even_odd_swap;
+	bool				lvds_reverse_lanes_conf[2];
 	int				lvds_vod_swing_conf[2];
 	int				lvds_term_conf[2];
 	int				irq;
@@ -644,6 +657,10 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
 	regmap_write(ctx->regmap, REG_LVDS_LANE,
 		     (ctx->lvds_dual_link_even_odd_swap ?
 		      REG_LVDS_LANE_EVEN_ODD_SWAP : 0) |
+		     (ctx->lvds_reverse_lanes_conf[CHANNEL_A] ?
+		      REG_LVDS_LANE_CHA_REVERSE_LVDS : 0) |
+		     (ctx->lvds_reverse_lanes_conf[CHANNEL_B] ?
+		      REG_LVDS_LANE_CHB_REVERSE_LVDS : 0) |
 		     (ctx->lvds_term_conf[CHANNEL_A] ?
 			  REG_LVDS_LANE_CHA_LVDS_TERM : 0) |
 		     (ctx->lvds_term_conf[CHANNEL_B] ?
@@ -832,10 +849,12 @@ static int sn65dsi83_parse_lvds_endpoint(struct sn65dsi83 *ctx, int channel)
 	u32 lvds_vod_swing_clk[2] = { 0, 1000000 };
 	/* Set default near end terminataion to 200 Ohm */
 	u32 lvds_term = 200;
+	u32 data_lanes[DATA_LANES_COUNT];
 	int lvds_vod_swing_conf;
 	int ret = 0;
 	int ret_data;
 	int ret_clock;
+	int i, j;
 
 	if (channel == CHANNEL_A)
 		endpoint_reg = 2;
@@ -854,6 +873,37 @@ static int sn65dsi83_parse_lvds_endpoint(struct sn65dsi83 *ctx, int channel)
 		goto exit;
 	}
 
+	ret_data = of_property_read_u32_array(endpoint, "data-lanes", data_lanes,
+			ARRAY_SIZE(data_lanes));
+	if (ret_data != 0 && ret_data != -EINVAL) {
+		ret = ret_data;
+		goto exit;
+	}
+
+	if (!ret_data) {
+		for (i = 0; i < ARRAY_SIZE(supported_data_lane_mapping); i++) {
+			for (j = 0; j < DATA_LANES_COUNT; j++) {
+				if (data_lanes[j] != supported_data_lane_mapping[i][j])
+					break;
+			}
+
+			if (j == DATA_LANES_COUNT)
+				break;
+		}
+
+		switch (i) {
+		case NORMAL_LANE_MAPPING:
+			break;
+		case REVERSE_LANE_MAPPING:
+			ctx->lvds_reverse_lanes_conf[channel] = true;
+			break;
+		default:
+			dev_err(dev, "invalid data lanes mapping\n");
+			ret = -EINVAL;
+			goto exit;
+		}
+	}
+
 	ret_data = of_property_read_u32_array(endpoint, "ti,lvds-vod-swing-data-microvolt",
 					lvds_vod_swing_data, ARRAY_SIZE(lvds_vod_swing_data));
 	if (ret_data != 0 && ret_data != -EINVAL) {
-- 
2.47.3

