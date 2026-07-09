Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A3AC44508
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:06:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F32010F7B6;
	Fri, 10 Jul 2026 07:06:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="UDJSXoBf";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010032.outbound.protection.outlook.com [52.101.84.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F31910E095
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:58:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHgFGsKZ5Bpd0h31cmp/hQCadzV2f+u4UL+uwWjwAzUzZg4FzqB5e1WVWnxEMYHxnE+h5Ulhii3gKHWSzN412WFkIpe7rLEEwJbcnn/92tPVcD6Vvatemsw2QjbpDQDalVT9vKt/M+QkUO2AIG7G2J6QjHIMhhnaXQ42zTB2l6GofziuBoCCt+0f8fPWkhAXOvczPPTnWi/K1ikcfDE4Hc0mF+OCExq/XuN6DRSFMpmTBO47HImFpTl4kY2vI1LVONsoJySwr4fdanPlgsJoI+EcB3DSAQ4ZpNm1pxbGAh9ghlS7fgPEDwd2KDZLvdxYUxeBy8IjO7nGhKqpDEtEQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygu038JvHAS6a4Zw+S7iLGb03jAMlMTBzGQLIOe4zGY=;
 b=o1bJwo5MkmigyvTkuNxA6NIZQK5wiomi7vE53GIrOCax76cjk2CSVDUjuoZmUXHDzMM4T2dqUNKEaBodNciTzi8tae83NxpkcjTusjSu5W7l8SnoCwG88IjTN+IXGysrQ/bSSRv9V9R+9lQuw+33H3LuN7M+hbgAB09pNIYTJGdssyOEpzi/Mjd0y1mh2wLT/ZmfksjOUBivb+1J7cNJ+PYTiVg0FAAPLUgDeJKpWBrun/9MUMTsmr0ws/191z2hBlSGRZyNz8VzuwF32QFNittM68X1AYvPnO+dg4w9EdmIfbmx8EFMyi/mzpNp9LTjwTx8ZJZFsYuh1ipM8n290A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygu038JvHAS6a4Zw+S7iLGb03jAMlMTBzGQLIOe4zGY=;
 b=UDJSXoBf3Xz1IwUScO6vSb8jIawMZwU7v21NSZr43ITJuymzZcmanc0WJNvRDSaxm6CNP7IVOcMVzUtvF1y8g46ckeAAJgP659FFb7sWVJIx9EzqEcCGeJWpAT+XOtpQv35SnxneJwLG/Gp7FwwGdiya1hWdy69Rzp+p5LXriBYuM/E2BC8HHabHIcHWRbpXw4k//A+LbnA98NzK+F7WGnNN1iUputupaj3MGCyZXHbB10SJLlxAJ9c9CmG/s8kOz2ZcaPMVpakqOKGZfdNzPOiQ1BrLUdJuo4UA+Zmjpe87swl+2bMvPh5EvVuy1P0pkpPvmXZ6A1Dei5JRWPbwgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by VI0PR03MB10640.eurprd03.prod.outlook.com (2603:10a6:800:266::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 12:58:30 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 12:58:29 +0000
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
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/bridge: ti-sn65dsi83: Add reversed lvds lanes support
Date: Thu,  9 Jul 2026 14:58:09 +0200
Message-ID: <20260709125810.340612-1-wojciech.dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS1PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:8:457::17) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|VI0PR03MB10640:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e0309f-de0a-4705-f2e8-08deddb9c638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|7416014|376014|366016|1800799024|23010399003|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: TRxw1BN2eamOUGl5NvA2IIZ5vrSX9EGOUgUQWRxW8u5ByStVywmaLYOm91sKKxoWXInuB4W4ZzNDbMnQrdtQPptlONdubcQolrZtsPVXR62YxL5RIwzqsJDcob8KJ8+6D4HK0d9cL/+beYzGtzy4GAUFsPy/uwZFY3hKhEh4HFAfB2djMPILyaUC9ungM9o4MFVtkr7+OYThHTralW/t8lX+m5CqNuZyX4P1t7twjXidPKTIEBjlPtpoQVilgLx/YD22w1nZLuAZjz1i5wMLc2Y6V4RPnEN+8KnyQRqq2GmSDlXXg7bLTMeDSb8AgSW+RI33z80Xo85W+9tOw4Ll+lKj2X58iFd+vWnNBF++84R52zw691SnZklp3IeRBOPksx7lC/8p/Qd2Pg0Ow+JAiAseRjviJK/QKhRTziGOfvXALCkAxoFNWaxoKIoxVm8XhwT+wri2tVl2iLk/BWa4wXTpnjHPiuL+eO0mX4usirWKPfoxYrQ6094T+0sXbanEpp2h1LX4ilwNnuDGdyifl74W1BYgCt/44E/MV63rFL/tgGxd+P7nKxLav+QMB99fobqjIhvLsy5saaJgRtvvUd0aSYMRvspY0C0IVn9InfqkSUYFB+vkPjexbyPXuSElNwey4r6Mg/SpPJG7OZKrWJCKFIzqbzPYJ5mDxYJv+lw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yAiIoQLWBxI2kjy33GPHBUmScCO5quJS4e2KJuOKmk7MwMCaW64bgOhytKMJ?=
 =?us-ascii?Q?txDA+EfZWM4pJQNyHtrCyX13cHNuDzPPlcyfcJuWzb734M4p1SWvocgpJZnW?=
 =?us-ascii?Q?AAgYqo804vLPWqQRDov4qj5cTjYorM/7Gta0DOn7pcX6kTfQwcGMYcpKJ6ji?=
 =?us-ascii?Q?O93xhmTEBoWgANgGGfZ7+ivwadsEUfCMiLzSUrx0FPIGDwW/w471QED8FWTT?=
 =?us-ascii?Q?sPbSxX9LAHf4wp7D+foxcsPApsXwFOgeiXHlsJt8FeFqG6dA456JBUjS1nft?=
 =?us-ascii?Q?oCJBIU1Km+TKk/zvaP3Ma1f6oiWRzMYYCdIvOx+AE086IA293+T26PxoYoxh?=
 =?us-ascii?Q?f1UWFBc1hspYXsQH5//8tsl0V/awQo9IyR7h1PwtCvUYKreC4OkUzId2V9CY?=
 =?us-ascii?Q?75dxqDhmXQSC9/8T3kHT3RI+eCqt8v+/MU8gbM9NSTuvVk26xgOt1eUhI8vx?=
 =?us-ascii?Q?mrlYszsDgQz/DVDnI3Nph/wmHSAhN4lv7rFUyABysz5u2s4HRZ52lUNJyFOG?=
 =?us-ascii?Q?hUslBI/xcVUTBLVpKgDlOyW0oqPkfOxj06XL6PC9bs1oB4Ib/cdh0vhq2xSI?=
 =?us-ascii?Q?OtJhoiDXjzZwkYLgZg8HIYfurXxuEnDzdNej8c502timCTI0r91ME7P0qCFW?=
 =?us-ascii?Q?sx6zUJz//4Nu7QQhMh9Vh8/CygETe55T+Q5DvKDnscygOzhtxSpVEP2UID18?=
 =?us-ascii?Q?9E6HEJOSZLkoHF9r3oas0sIvLYuYjNunQiTiX8GThl7GhSUtrJVDTjzfjsGi?=
 =?us-ascii?Q?r24ieGN8da0g6lliPcTseMxXX9bcigqntpGaS/FarRT1ntTB3kMvJ3BS0GZO?=
 =?us-ascii?Q?M4d10dRKmwzKjV8joKaKpE2ix0oBt4DQhwjfaVziT6R40o36OSUJanQXaP7z?=
 =?us-ascii?Q?4l7YThhX7zIiYWAE9xMuEMVerps9Y/7jA5gEQ4zC8UrdZfnPzWTLSy8RRZwM?=
 =?us-ascii?Q?Ke/ttLKWeVCoLoJH1WbGQdHXWK0sNM7kc7KejeNKQe7ushaihsRQ7Ns9DhCC?=
 =?us-ascii?Q?4q8O1M1/SmTD/N/gYCzMT5egKJMv+hE/JAUN5UKV0/qHxL/aWehwloGbWHVO?=
 =?us-ascii?Q?NdDU0iw4XqIraGH4yDg3/whiwmqymYW+EJN93tXuVVHWeq1h6VAVJin5OLVz?=
 =?us-ascii?Q?Wxv0muKOipiQwhNkLn0vvsYDHzJHQIewW1GxaOiCF0JyHHFPY3ySeG0kHla5?=
 =?us-ascii?Q?4EW5D/Rz5nfbuAVRd/k90siDxVrI8SHzO4ZLkzo+23cf8V4g0xe0RJUUjssu?=
 =?us-ascii?Q?xlV8IDi6v7IiSQcozixPGwJqsnfSUTVGuk7xtIrVpR65lyqPbiAe8lTQZfSc?=
 =?us-ascii?Q?9wY6zIGTllI/LCX5e/PevWK3HUcH7vBRpnP+pVi0b0J+EkKigZH5XZxBqwet?=
 =?us-ascii?Q?+uh2E+huovSBECk844AlMOvhQuX86r+yfXGyAgmDwx6A5TxQZRjeincmKsUY?=
 =?us-ascii?Q?kyzrgADSsM8NYk0TJcQIuso5M0h9+e9qTwGNC7GoGregkh8QuYuHbeokwOyX?=
 =?us-ascii?Q?wHH6vnU7uZWA5V3DXMXlNDxyObdo2DBy9LIkdtXvDLXBX8XBUTATsLxmTV2j?=
 =?us-ascii?Q?jVl4Poalzk76r9333zNYUfhRoJ5QtU2kB54Z2FqQMp7DRrmlkw/8e8aqdRNc?=
 =?us-ascii?Q?zn2+eFLXCeEtplSWqbNSy93K6jXLhHSordbaicemZ9fL962NtkJidEmI5f3F?=
 =?us-ascii?Q?AecH4J1N1GsHXVm8ZRFI9oRsEWF6Z7+LZ4WazG/eu1PrpeOzTM0op9iehqvR?=
 =?us-ascii?Q?NBLwLsRY7Q=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e0309f-de0a-4705-f2e8-08deddb9c638
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 12:58:29.9441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3e8uPS5Jld3n9GfKVSVPx4d4dE5nQ9Vyz3u2yU9syq7qSDrAx0bAxklngVyW8nRqd0S27RG4Pn9U9PWQjwALyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR03MB10640
X-Mailman-Approved-At: Fri, 10 Jul 2026 07:06:09 +0000
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
Changes in v2:
- Parse existing data-lanes property instead of ading new DT
  bindings
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

