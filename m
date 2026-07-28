Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4E1C54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:00:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A37710E8E2;
	Tue, 28 Jul 2026 13:00:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="W3fOrIsJ";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010021.outbound.protection.outlook.com [52.101.69.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7482D10E450
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 12:20:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kfa7/8Y2AQbkTA18PRaT5nyaxGLdaT4YOIHcAkAZFQETJnjgBRZ81RsvIuhzrU56jIeZ6oksUs4gorl85sulIU/eJt29bMqY3V/F5HaXhhiA2ng2SIDROU0kpVFr+zBOuGgPtepaGy/bvH5insvivUbLMm3QktrB6vWB0R1O9Lm9wEGGpaZ51vRHJXbNB5/C1wLxgPVmpdT+0TFPcVAdoxxX37cAdxKUVLq8rL59EdmoaTkXcVtYFYaW+P0I41mNvr4aqpXrfOW6TIRTJDDWwh+xii0fEDuEk6ROHvlCzf0CmuYSVH+Pd8ZQxDQqbpaDZ9KVmq2NGB5zFedH6ZeHvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRJNRZsbXX/7Kv/SqN2WRY3/+fNIWM0aHUcVvAEGQEo=;
 b=Xg1CZk5mWL40tkKY4fsl7VoqSYhFaRKEuL0TgM11rs1D/PCZwTblPO3+n0JUszwbdhrsYawrRX99tH7j7Ox0VpZ5CkhMq2r0HdWdAPp+rgV+83uRk2fE9cawSPcx26ddC5wuOadGZG5eaVFZDbNQflYDmKoTyTwjySnhDa8vHGTU9v7TRG8wyL0Xl4Eww/ole8Ckzt8yJw9iJaseRzJ8+TJO1kIc3k3QMs+3jHYNz1KfoBpkcJOpRraGCl5oS9tDJ7Vb/dXeqdBuQTK7r57iITIblc2TEzeKcREbNNk4nLtg8djU/SVvDZg67RrD26JJ2J889Cq99VejNkjoZPzwAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRJNRZsbXX/7Kv/SqN2WRY3/+fNIWM0aHUcVvAEGQEo=;
 b=W3fOrIsJ9iJXBHqLcgTWzrBlE+uBHQ3Wr0MfiLd6RynCLv3Ny3EZYDWoiny/GpXp8oE6lI5eaewmxXI4zAdPYJ5BiUVe5+rmJ0B6UPd/moHZWW3oydiiNDhS6plPTr7EsYOTPgjAWw2N8C6FJZ5gOifqa2NOMQmOy3+0pmt2nMknPJ6EXe945cbMofZPsdAyG3UU47WvAhHArFMH4aJyRWO1PAfmfbpjAAGYQHch7mscXWnWtaVSDBDgquYYt10E36457LEyIWtGmW3VC0bZAxFZbw1jQ4NjMMULwhZgRkxXL2FqJ1BOmYgx73dCi0e2rqiKodAet/uXlKMsl4Oa8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by AM9PR03MB7993.eurprd03.prod.outlook.com (2603:10a6:20b:43c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 12:20:48 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 12:20:48 +0000
From: Wojciech Dubowik <wojciech.dubowik@mt.com>
To: linux-kernel@vger.kernel.org
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [PATCH v7 3/3] drm/bridge: ti-sn65dsi83: Add reversed lvds lanes
 support
Date: Tue, 28 Jul 2026 14:20:31 +0200
Message-ID: <20260728122032.692482-4-wojciech.dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728122032.692482-1-wojciech.dubowik@mt.com>
References: <20260728122032.692482-1-wojciech.dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0031.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::18) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|AM9PR03MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: dd76ad24-772e-4feb-ee61-08deeca2a80d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|23010399003|366016|376014|7416014|3023799007|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BPzxesqBPuzOrBpEsNTU4R2aQumHW4yO7iyeJuRm3vmDgL5qISNHoUKJMVaKdT0K9jJFbfh/HsCUCxLamgnfeXBQm1DDJFy3IdbKkaaXy1jpRBJ6bAFSHWKi4hmkIEyjXNrCjwQku7l24Zz7T6YUtte74VzcuxV/6+z2Bl9YxGXQFNMsxyFnKXepn3+KHu0QRQqttVNYgAsWAi56IKRIkEKb4QeJ3HGIrh1PosvA7G87nFyGDsjOi43zmjqVD0BniSybRIWk/afau2D6+PZWRrR5SL0QZYZKOFnxWcfWIO/RALdEZz3rDVOIHsvmClH7yz50V4TWcZ0feuYQ9y9k7lH24ZtXaNI8hZMhHUddS4PlXean6Rk1+WaiReZJ0Sedho5dKI/md5hBVcx1SSNwgFqCMWJEo70AhIxEk4RASIJb6yOfO3fjBkw1xT50nhwU5ZGr8CgLUvPctn17er2fcnJa9vZ+hpovDBKt7p9qlDDoWjU+Bs/xijaB+UWy3zCZNoA9nkzQYQwIWVUZlqYNAsq7ZRAkNPGxuLz1GpwEgVFW/RFl5SNFS1LrViVRMlw5SYX86ow5E1vyZRQAfowESdnoUIiEh7oVqY1+FKXW13IpRGAuwVkSutPHkjXh2rETk+6gGaFBcGCO8Qisi4Ig+eoPbln72hSADrdVaEpbIr4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(23010399003)(366016)(376014)(7416014)(3023799007)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oYgaf4A58GoqP49IzvEBevR2GPOXMHxdpUBKlIjuoJ/9KcjRYwfXEWiid10t?=
 =?us-ascii?Q?3f4NV1+/3HdbJblj6j7Q5ild2R/IIOihIvQU/KM7Z+LPdrmrBydfE+fi+lTj?=
 =?us-ascii?Q?C6v1k3KHFl8jINqOENDV4jiPnIibjusEVD8AxqvcwpIs+mR1UuZ2lGuLg3e9?=
 =?us-ascii?Q?HqFrcyUH8er/0qJB9Um3pEp+hBNHtrrJFrkLkxuvMiZ5wasgywbl6VOUlqig?=
 =?us-ascii?Q?qBoCSSzLQBOdQVtzPGUH4dsuYA5SE/hCLEACS0vC4WPfKPTw1ZyzAbYaDIjS?=
 =?us-ascii?Q?5nw0kXnd1DB/H0eT67CUW8K6HtxEr6AwlU7yksgAUWXw9JwixCWLwmho7SnZ?=
 =?us-ascii?Q?cPTAuNNJPYOD8rXQWbrLpg8kU/+55ethB6WBjszOl2g0jBbmtRwPS68RRsY2?=
 =?us-ascii?Q?gAlxs0lkJ9yNm/J7BtZrlZStWXYAL7vckup13FQyELWjiIcSjQl0Z6GJ4LdG?=
 =?us-ascii?Q?+C96KHFZN82D2rw4QYYlc0Mipu88EI03DIXNntt5BKpdFhzOy2V7Zyn/sqYC?=
 =?us-ascii?Q?wOwKVrkkLZ46gFISz7Epne3Tctaw0AFCSvlI701Y7gcHhLvSrQ2bJ+sdxyML?=
 =?us-ascii?Q?7eR3/haaBoNfcOxT3QjaUzKoJo3ykOqEprVe/dl0rW5CV6sZ7TtEqhBNurCd?=
 =?us-ascii?Q?bGLPGT1D3xUmRHCAY6at+XKA/wT/wom8Pwsg7aLNVGqIsxZ+kO1dIIobRb2i?=
 =?us-ascii?Q?DhMfoFQSgWLRPy4ctPJoxXZE3fvpG16jMbBizoCoXvJTYc8Y652MVgYGYCqB?=
 =?us-ascii?Q?RgRERMSQ+n48JB8afu47DLBsk0UoVfL53Yo+rOHBEWAvUm3ZwBwoVUQV9XE0?=
 =?us-ascii?Q?Km0apVJJL6hr+lvXdQO5O1RMmzuzy3AzItoFmvgPrGzV7zwamLE1db49LQ9Y?=
 =?us-ascii?Q?5RIByfPi4YJcgHiEvN9qcYC4eIAqDMLyUGAlJyMpAqsqnWc6ViZvl612nhfV?=
 =?us-ascii?Q?FqSk0EgMwuDdHGmp9pjEpt4YFEjMntDkNfsTv5rYehfCv8Z0qjyWVYLqyZlZ?=
 =?us-ascii?Q?Z0afYS2u17UnQMpXpVY/cnvA4P84uCdRMiqkli639+Kr6vgvHkSZZf0cM7nc?=
 =?us-ascii?Q?01fPKOG9cGQwFXLzJbiYOksG50NX4LG5eCoto0SfdZ5Cge+hilmktyNk38bs?=
 =?us-ascii?Q?YtO//xRsl1n7K8e2LgZz2QR15WJd/mpzTIqT7ZueFhYaVbWiHHPP5V8E+0wG?=
 =?us-ascii?Q?alZzTaH+tG2uD0SwClSzoOr6dUpYut1yNFO1KNCRyQVQUwguuzedd1ME6Ghe?=
 =?us-ascii?Q?ShlcT7t6yJLanATxFANuxItt54F/yptzz5gLRM8ONelfrflJtH5MHs7Cf6Tn?=
 =?us-ascii?Q?kXB0zKpjdGfq3M6AndKy8R5NzsSs8IDmzpOcpl+k1ZMTW2pohtETiSMK/AXP?=
 =?us-ascii?Q?pM/qe7VOurMVnUmyIsr6Rjt6mRcbWQtqZrOlv+M2wsEnZP8SQ+4iY2CJXq2A?=
 =?us-ascii?Q?lSy3MTjsTorud7KltDNgbhv/0TrrsBcq5TCjKWEzivPBKUewg8RUfIRBJJMm?=
 =?us-ascii?Q?vMG1bKsR6ugYHevrtJbvskXByY6Shl2QLSZdV5A2YFASM29fKrpzq2u7Py3d?=
 =?us-ascii?Q?ClHybbOvtVr/v3m9oBv8KPqnSLQwVJJREkZv6QzUBaY4Ey6mZ41JnmDCgLIC?=
 =?us-ascii?Q?VOnxPlOz1eviEiLiwLYSOGDWo8MT52zkkL9ELV5De4wQqLqq+F2b6ynvjunv?=
 =?us-ascii?Q?OuEPTXtq95XJWeAjH6+VzQFf1iricbiqnBg0lC/eK6CzQBuoO5sK7wlu/ObC?=
 =?us-ascii?Q?0fikEVRORg=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd76ad24-772e-4feb-ee61-08deeca2a80d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 12:20:48.2206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jfQf3OD1nGLRwyPI3tRAAGSitrXxv8qco61vJGLNTgd7z7o0EUhHDfTDgwrpvhfOy8Grv2VE4bOtwGTcNC6Glw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7993
X-Mailman-Approved-At: Tue, 28 Jul 2026 13:00:37 +0000
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

The chip supports output lvds lanes in two orders, the default <1 2 3 4>
and <4 3 2 1>. Add parsing of an optional output lvds data-lanes property
so we can inform chip that the lanes have been reversed.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 31 +++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index f8a786953526..182e58a0ed41 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -148,6 +148,18 @@ enum sn65dsi83_lvds_term {
 	OHM_200
 };
 
+enum {
+	LANE_MAPPING_NORMAL,
+	LANE_MAPPING_REVERSE,
+};
+
+#define DATA_LANES_COUNT	4
+
+static const u32 supported_data_lane_mapping[][DATA_LANES_COUNT] = {
+	[LANE_MAPPING_NORMAL] = { 1, 2, 3, 4 },
+	[LANE_MAPPING_REVERSE] = { 4, 3, 2, 1},
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
@@ -833,6 +850,7 @@ static int sn65dsi83_parse_lvds_endpoint(struct sn65dsi83 *ctx, int channel)
 	u32 lvds_vod_swing_clk[2] = { 0, 1000000 };
 	/* Set default near end terminataion to 200 Ohm */
 	u32 lvds_term = 200;
+	u32 data_lanes[DATA_LANES_COUNT];
 	int lvds_vod_swing_conf;
 	int ret_data;
 	int ret_clock;
@@ -845,6 +863,19 @@ static int sn65dsi83_parse_lvds_endpoint(struct sn65dsi83 *ctx, int channel)
 	else
 		return -EINVAL;
 
+	ret_data = of_property_read_u32_array(endpoint, "data-lanes", data_lanes,
+			ARRAY_SIZE(data_lanes));
+	if (!ret_data) {
+		if (memcmp(data_lanes,
+				supported_data_lane_mapping[LANE_MAPPING_REVERSE],
+				sizeof(data_lanes)) == 0)
+			ctx->lvds_reverse_lanes_conf[channel] = true;
+		else if (memcmp(data_lanes,
+			   supported_data_lane_mapping[LANE_MAPPING_NORMAL],
+			   sizeof(data_lanes)) != 0)
+			return dev_err_probe(dev, -EINVAL, "invalid data lanes mapping\n");
+	}
+
 	ret_data = of_property_read_u32_array(endpoint, "ti,lvds-vod-swing-data-microvolt",
 					lvds_vod_swing_data, ARRAY_SIZE(lvds_vod_swing_data));
 	if (ret_data != 0 && ret_data != -EINVAL)
-- 
2.47.3

