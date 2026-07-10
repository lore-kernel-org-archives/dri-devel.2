Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD500C44507
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49E8710E7F9;
	Mon, 13 Jul 2026 07:10:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="dwMOjrz7";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013058.outbound.protection.outlook.com
 [52.101.83.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA50F10E14D
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 08:26:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7WghnR5qAe3f4nLkS1+TKTGkWtFANZocdygawvAwekSqof/NjRQ9myRKi7ax6mC7Vym5Twrc8bEVj98WmqRa48Um/o0I/zi93HJQwzR3jx0XVsP/iAAopDucN1Q9OFZxq0XKiCIGMRzBTVEf0MjTMLwX5igsXgpMMmShf3dj+D2BIQwlGKr1QY4f7oNmxhBuWJW0c6BTMU/bj4RA2jCDgL8caN0ErCXmT8awsMFAbhtfrOPkTJDtwHHtThH2/zlXv2tfIGzOmGX0UxDfL3uUqGNLD3AgnQBKSfoRc7HLJ2GYEPmIFI30as1y/BG1z33hsin0DKECWujNtZuNXV4Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygu038JvHAS6a4Zw+S7iLGb03jAMlMTBzGQLIOe4zGY=;
 b=kfSDRJgjX8d/RpRaPJoYJDddLk+WUUEvfBbS6s/Qcxa2w7Vj2X1G4KxXh5ZT+r9yvVG0yWHJh+KPq1EnoeMvqDzlBz8nraY8PDe8au0bIkE+NEeaG290HQNsSDSzVMGWLBW0faSTYxhNqDq41iOF774kxwXlQZgDjCuqPWI2nfnj6ADr8GhKz0JCrfy9Ji4naGTHjlYa7frR8q45raWxpN+e+k5I5e9X9fCSWKJln1FTUFoyUqHdxzIhGbFOgjtgaD2S9LwQ2PqdpoRktg+xe+tIODGlDBTnfXUR/K4cHlkL9kTfAmyrJBtcj0A3GxCCl5PbHcCCR5pdq+n5qG3BUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygu038JvHAS6a4Zw+S7iLGb03jAMlMTBzGQLIOe4zGY=;
 b=dwMOjrz7BKCLilWJ14mCe1Zs6FJ5KfmzgpAaaVT088bNodjIve7+Q6iPyZfJSGUKghijocD571Zwn5HUFa6ujXxLY8oWJhqChY6NSIUonzjzYXrZp+pcI7sQGbKnIjnV23SGfIMFl3YrORjOH2pVGqiYJ4KcouCDOhVsMPApT+fSitnApOHNHvne9+1mIehPwdLMjG60VEsvVzwon/ko6W9JgoQ8AIDFCRaxWVtkVQkRm7fGfBOBirY60kDkUjnCfF57CDrdV6bxnjd6ByEAJuemwHyQg/gKngmxt9hc0LvNWFtTEzhMqJ4Kr4tyWKh1HP8OoGz2tbxVmJYOIw8hjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by DU0PR03MB9731.eurprd03.prod.outlook.com (2603:10a6:10:44d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 08:26:42 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 08:26:41 +0000
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
Date: Fri, 10 Jul 2026 10:26:26 +0200
Message-ID: <20260710082630.394040-1-wojciech.dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0028.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::15) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|DU0PR03MB9731:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a1c1cb-b6b1-417b-5121-08dede5cf85e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|19092799006|1800799024|56012099006|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: HRS2brxSDjQ0q0BTXLe7xLXL4vyk9p/IOOJkM1fZaCVi56VLPbAbNu6GZRVMpPeZuP/PzuSuCoXe3V4A/iY7dSLFEo13VLubPeWq8K0l4d9n+7rTy9ZyVejYL9ue0sM8TdrH2kfQOy0rZg7m+/pKs9mjox80WbwbILzcanFIA1eSt6gvimMbYHAAqYwHEX8V1zolDLHcPgcWHBskCogj6yCWIBevRwxn2gse0pvTwu4rwWLKympWNgUydYKd1Eqwd8pWlowVh6uPb3F3tXxD9cCKyl/kPfbTZ/FOICt+y4ymqKkOoO1wbxL1XB+W2neTU6+6XdwXksxXLEx/ZKrZ/9wR+mxW9cjmzt269fW2QazwMdnrnnO067qSpsuJA0PKjkJJUllcfVhr9dQDuQxdVvwnoWdPg8JGpiYRtwMu0CWUwrvCyudf/zwV0Vt73Lxp2FiiIuRbvNsn0UgJzQC1cCbuWOv8AbgxUT5cgwmVFvXAtsDhj1bWiwb9qxMrY5EySq1sxNxlzv66mH+GceUwKuPi0AoNE+DHT+LgXBZDGhapUxv5Vmn199ss18X5/8iURJmIkkT3zH8CG9/ktxKNTEx5RWGN7smzlxfkfXLQskM98+SchTCnQqiLP7K6qIVxT2peDaG+OczNt3M2lVC/utSTxH67xee7fbYL5ZD+tMA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(19092799006)(1800799024)(56012099006)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l5+vWBXQMPwiyT4YcKD8/2EJv0Utme0LJW9fHXh3sKgSj8ETfKSqaghY+1Jt?=
 =?us-ascii?Q?Zuq+EpnJwm1HxK90IfMdwG4SpagWBYKA5Y3V5uDDiPiNyhtDE/hriJ8aLnMq?=
 =?us-ascii?Q?2L0AbT4w0esNu8DyCj6CKaKwsNoXgtNu7/5NDvvtNVWbq6AWo3SElnEGu6v+?=
 =?us-ascii?Q?pb4JBS3uUEz7dO27pkdknfYL+ZgqNPM5DYjeWE3PRo3fL5DKUet+3A1hLlpf?=
 =?us-ascii?Q?etPZ2x48JkFCPQO9CxU+o5uz2t8omGYBsNSW1EOz8HhJeCd8UR981mZ8JErG?=
 =?us-ascii?Q?ef5Kmrb1BFVsZ9cUTc5GmeMXTT9LrRKBG7IDqMY9UDPh6P98v3dPq/ReFlDa?=
 =?us-ascii?Q?aXvYJdhiFQ/Cknvdbjez4j3G0y2Ztd7yjKHAnJ3Cws4WB+nZLhupNxW5VERI?=
 =?us-ascii?Q?IKM+hiL9klUqbxQws28BkJvKM7nKLEakg0uyJ1jVJ5TPwJx9GyhbYGiTtwCV?=
 =?us-ascii?Q?prJbxlIE+2b4IWfNxmL5aYFRJ6mkxOFZWZsR9s+6cOHMjkMnL3gfXTGQVoms?=
 =?us-ascii?Q?l1apNiXQe/GJHCF80GNvSQJzmiUfchNPdJi2BTxRWQGy7Ao2cplfZEweaFOc?=
 =?us-ascii?Q?IItv+0140+PRIJ0lok198kM2N65fRwXxTJWmKHUcVN7lhk+LserHfmswYstM?=
 =?us-ascii?Q?+X9cepVURu4W0HsqmrkYfYOlqHL9ytmdChwUGuH7JTlCm1HRH3Xr2rRCluRa?=
 =?us-ascii?Q?rdqZWcE9pX0C3sOekP26OtoaJiFVvT94izNUL2A0LMYnb8bqYlBARCYP1pKh?=
 =?us-ascii?Q?6oA1pmgykXwlqP4WYmXXhVRGbRoMlPsWfl19t38VJTHTaIxkWwdwuWzqeyNY?=
 =?us-ascii?Q?AV0KlOI1buI4St8vPl46YC6A6XKRbMmOfqTnxFpVEYQJIfMqk7kJ/DxYMZVA?=
 =?us-ascii?Q?R1J+oQ7dIgQpuzFTI4RajhhnvENmr9UN0aIwqUxdSmeLhscOEZAI4Of9lYGm?=
 =?us-ascii?Q?asp5g227fcqEufjfAQe371Ky7OvXfW9akmDmc4qFHH4Y9lBETKXdRc+YB0Y+?=
 =?us-ascii?Q?DnocMIeDRcaMz7JvBnYabAzC8BzBUENlWxG89s13KMMCDH3ZPbFzArjsw5GN?=
 =?us-ascii?Q?Jze48cpEdQrLRxKjJyubnm4v0zxcSqRj+etAkutLhiHBsdU0fJQrNVmR6tQX?=
 =?us-ascii?Q?YiX94ZjETe8pBcTD8SEZf8b7oYhmFsDvIZMVZk/BDX1oA6ilpB86MT+sdiXV?=
 =?us-ascii?Q?SibgoqQoJJlcvIpl+Mpdu6fjrTl/9T8dPfhsyGVHmZhuoUix0fIjmMtQqZuR?=
 =?us-ascii?Q?O3m/IrHWJiZ3ij4q+FAYFxHaxaaPW+a05C83zFSF5JzvsuYqyyfhlDCInenA?=
 =?us-ascii?Q?9huJ5LjV2i7vWq9OV6PnM+orU+Jh+LEwdisYSg2rox81DospiIKlcb6gqbd8?=
 =?us-ascii?Q?qFti/Q6sEZEi/EYlBTzY7f0E/56P86wzr7Zk+RvhPLwFhxhhSDTu+sQhAXho?=
 =?us-ascii?Q?ncxrDRUpQX7S2lGToBbRnPVK0vl++po2J3xsjAoac5y1Fzoztl5WyNnpIE6T?=
 =?us-ascii?Q?yhbNxPWdbDT/yD+0gJNe3XjYLPcW+OiX8XB+fHyzrDBWAH1Yh6T87BAoCFIc?=
 =?us-ascii?Q?MG9e5hEvUudNYUlNYGr63hicbkjEw3kxDE+2NRqB65qtNcTQviJBY7i4clQp?=
 =?us-ascii?Q?MukyArcZKW/iGfOAX4GIg4uLyCt7iuEgP0SMjIQa1wDMvvOsLx89JDkTjU2p?=
 =?us-ascii?Q?Y4OxQIcs7M/mnPW3aegVaTg00aF26s/jeMzjSY6cd82n7moo8jWfljxlzYdS?=
 =?us-ascii?Q?IvhSzJ/kAw=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a1c1cb-b6b1-417b-5121-08dede5cf85e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:26:41.9325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7rJX/FUBmrcLK8tFuYChapf0IcPBQWklJjiTv7Oq2yPkovpPE94e+ugd93E/WIHSB641I/7ChzXEGY+Igv85hg==
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

