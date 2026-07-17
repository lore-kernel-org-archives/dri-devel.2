Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57CEC4452D
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:16:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8E2810E79F;
	Mon, 20 Jul 2026 07:15:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="Vm9y1MnT";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011011.outbound.protection.outlook.com [52.101.70.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A55C310E3E4
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 11:50:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kauJfSoQA27/f63sKv8zG1NInOWUDTNQSq78by/sDjhLjWZLh/OtlE8KemjkchBfaj/R9vVEkxA2thEDbPtsBuimrKVpJUtdfry/PEcAaZjulaSB8Co0wKMKhxBpsKIqUUQ1FxdTY610drgAmHcYlus5tUnUSNxh5UAcCUjixpIfMx9tNqFtOomorhxYKvVEDKFd2jg0UdOCKKU8m8Esq5Mi/e7gHnrskyk01dD8wgif3JUVvIDTApURWhjwBUPi3VzzpptBEBbC3wyWx4e4IaDqp0AnQE4ON2SZ6tBKXaQZ973T7PR9iBnAPTrG+j79b/EmMDPZp8azg8NqI30ZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Ht0c7p1+lFoEgb1uX4Ax5xZ6nMI7hzflHMWLAI3D2U=;
 b=n/Nb1vk///23qJcnChS9ux4vv7dhYwbleLQsV6d16iWpioKzrPsxULCxXAMcZCJkdQo/qAfS7R5ANHzuNFEgBDwCX11Sj2woa+2Bqlr2kzRJuBiWxAZZ+Ea0xJMgtfFiSWgbZ4Y24AVd/E79jQJJWTnG9Zy8sODfckidlwLPcK4/f8MQ2DhRM+2bgzV/xIPJZxheGWS6i7WgSFnHKGAeGRfxj+8CLR87a+stcLkmL+DnB6LqJxWzaocZVM1mEua8Nwzd13X4Y//bOkSn6FQuYhSjj9iUCipiqOy1ajWEGLRy4/8xQMi5zI/qL785PoIW2BJkA8Ec1atmwJtkCykn6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ht0c7p1+lFoEgb1uX4Ax5xZ6nMI7hzflHMWLAI3D2U=;
 b=Vm9y1MnTKMYek4D59geOShlO5Cf9a/wRm5HRHkDtdueAhPJ009XTzPDIiFlnHrhN/qPhk5LslqeSAIjHZ32A+y6Pja3KtcwCP3eR1GE2udaSyY6dvkDh7cG6AVyel8IlxmM60+KQ9zGdrEVn/83rKHkRmvyKiMk+59eyK9FBkl9CclVy1T4Nsm1qITYx63/AdOClOPVt3zEcjaCbGzonZ4tRS7wN3P1Yh5J/SE/ezCCVSc3ykUSZHx1tbos4FCV+pYSS6fm0UsEudV2szimhbeWS/tI1Z5SliCl8ZGSRPCcwscP/BHcmWAr8flf60lhG7vmSxJZi+EnK913n0R8x8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by GVXPR03MB8308.eurprd03.prod.outlook.com (2603:10a6:150:6e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 11:50:14 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 11:50:14 +0000
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
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [PATCH v5 3/3] drm/bridge: ti-sn65dsi83: Add reversed lvds lanes
 support
Date: Fri, 17 Jul 2026 13:50:01 +0200
Message-ID: <20260717115002.308035-4-wojciech.dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260717115002.308035-1-wojciech.dubowik@mt.com>
References: <20260717115002.308035-1-wojciech.dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0063.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::14) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|GVXPR03MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: 91333213-1875-476a-9f9c-08dee3f99078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|19092799006|1800799024|23010399003|56012099006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: Xu3SB+CCyrV1kNfVEibiB5LkOwtURn6Y34bqyz+NMxIUXcnxXPa7s/LI41fzadG8Dcbgk4iw6XopB8CvUxHhBHGI84l/J7fVJ9oZ3iP5ptisefT5cjKEu9DLi03iaSfd86yw3djBbRVQlQBYRhp0c0SBIUv4jtKF4y7HyXL2bWabL4skvb6NbUtrZwM3Cdi3sKlQye37tgknNSPSiUOkUKiwUtgocZ3Zr3Gfe5Zu0Ta+Ew13ZjimYvNRCQOrML5Ki8Wz3CylDwJqnZm3dOdGEKCZJvX1KbOR+8ApA3IbINpAelA4mI718eV7jeyJ1GZIP2CRdT0/spnSQ24+yZF218mFwcSUGt50HVVViPJNSObtIyxEZ6IsIlQPRCmbH0xmaJwFKN23w0YMgtKBF94ut6jR2oMnxCnW1IaqyXQtYGiC3S6+4a5cVg+FxbRqgV4ibaMasuiHc6sL2UKVWqEmnFgU9Lxbjat4WvhMe5yNpO/E4hYpB7N6m29LjcYpjRaB2xziqmL+XwthEfkAnEUN7TnRU6DeKmyFGSmSXByuOQZ+musAD/II8CSxYU3TMBVIEkpLOzHjXCUmHPDqimlHNgkhAAm29iTwi1Sk4jb1lnZiOM4QvBZB8QsDmpohTbC2UZlyeM+f6HKQu20/U36ux166Q6M8dMmwaABIVJvm4Fw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(19092799006)(1800799024)(23010399003)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q1IvAvHID7kN39t8lrPF0+TxlmQ5X7MbspYvyUXoXkzeufTOzFtuti1h6aW7?=
 =?us-ascii?Q?VtmkgaCQWq809vtZK0R9lW7Bi+dm8LEmxmT/wypsD9UgIn4OEt0mzqXlWNse?=
 =?us-ascii?Q?fC26wgwlQghLHBkL7AZbMqhscRJp6HXm0MvW2pycMYtoruCbxYUE7+3O5b1B?=
 =?us-ascii?Q?HJuFaRQ49jjTv7zIJSI+wl+55HSljbHEJor3y1lT3DaX0WV5DRqAjwCGxjp6?=
 =?us-ascii?Q?RFshl2dG0Msgl3OHY7SDlhLb9PtP4DM/qkzphjBIOa/a9eyYvcLxs4oS273H?=
 =?us-ascii?Q?FUMznTi+kj0aujIzw+KT152iGbE8ELrMOVRuTlNaHwSPNoM3lTXPchIphDjV?=
 =?us-ascii?Q?SM4o9zg8X6T7obhnCZDrheHmMgVc4KYnXzCfbChAXSeHl/wAtLI2EuMtwoax?=
 =?us-ascii?Q?xy/ZbhDdmFSH+HRr8nN8VU0S+zRVt3JwqwJIvXmMasDeb0p8oB+Y7Avqu8Tz?=
 =?us-ascii?Q?AWnTuYbjMMVXagkeDBLTjDAEH44xMnN8xTzxaCeL9cnjB9+1ZHJ+lne8eYUD?=
 =?us-ascii?Q?ol4gRwBcm8SDEJY5l5gz5iHwQfMPvhwxUsR46XwqDvleDywLuDFRBu5WciGh?=
 =?us-ascii?Q?jqkm8WrJyuoaXVVkrzFBqo+0qNiD+JraBsxVj517kMAtoXQQT4us0tNtyKZd?=
 =?us-ascii?Q?ehQiVkwCg/zDD3+jAqzbpWnhJrMN/CQe+jhkQ7LA0OrMZsVXB9ACyOBhfcvt?=
 =?us-ascii?Q?3AikEwkEknlbW+ygeH+KMxeoW9vopIJji1tzGOv+RAACjZ2B9YCXrRWNgru9?=
 =?us-ascii?Q?u23x7jKn7g4QKBfx3ROBZ5Y4/i4GY/lRkFMC9XczAJB094lOMnevPzRc+Owy?=
 =?us-ascii?Q?M67K/0dKFhzzw27npo1O++6dW6cuvISpS3GlWWWqHKFy2OV8AUJ4RV3nuf12?=
 =?us-ascii?Q?QvOjUL+pqDtwIcREHAqu/BnioDYx2iCAulp5H+hqzjWPmMjvKz1HuozUGEve?=
 =?us-ascii?Q?5bipQ6DBtl1l+Xl/CKEdsyqGTzgGhpN0snxXXmGs6TRc7PkSANHpvPDXuGx/?=
 =?us-ascii?Q?Sy9tsyIOp1dYIiBPV2E6RPGHGjaoGRzHq16zjbPrut1snobPWoIUlQkz4XjQ?=
 =?us-ascii?Q?tBaNsm3eAdEwkCVqSW4et3nszCgvwb20Ao+5mh5OveNfCw8FovVd2KthyPtc?=
 =?us-ascii?Q?83VU/v/80/40vrmg8vR5x/PHYvU1ueNoNhls/P4KjWyiBcTaaVLYAVg1m9oi?=
 =?us-ascii?Q?IfcdkSPJtu31R/AD2wYdnqDj9EFFdmhHUliFOkbXkxLdQQAU9tRyvbSJ7YdT?=
 =?us-ascii?Q?rRvL+fSrdwrGj7CwcGwL8Y6s2nNHjS5bVWYJUc9F0ydWmt58rJWfS3soT4p8?=
 =?us-ascii?Q?XcWYWsJ43jTT8BkzAsJ6lpytaTHgNwJTyDMfVVmVOnbR+NJBJ0D07mz+N+3M?=
 =?us-ascii?Q?RLXFkC4RvWv1VGmhR9qpEipJ2WsVmpOK3RZot/iIaHqkEvROCrWDFCZaw6Lw?=
 =?us-ascii?Q?l7OjbK2quz21ru2W6yqhhXgHRuKoCNb4QAKwIDB4xlYHt44379Cwq9RUc9w7?=
 =?us-ascii?Q?sHZl5MZdmy2HK4tgi3wdVHD5ptWSkNqx0IcaEULW7VcPy1GC8VAYiwXoME9B?=
 =?us-ascii?Q?XHU68VhUQdgS/1rOgESA0TmEjSIvaG5fhbIhonSbnl8BuqeVxq5PjYu2F2+n?=
 =?us-ascii?Q?Wt5MtEZSrnXvCvje1RU0YA0psbUwsJCSJOo2/arqE79EwGFY8TSrojrNa37W?=
 =?us-ascii?Q?OhegBPNDzNBtNI5C1UIUdDETG70yepbCEuk3kF9ZIiGLIRHFYdXsAcop3Nmw?=
 =?us-ascii?Q?yb+vJiOYfw=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91333213-1875-476a-9f9c-08dee3f99078
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 11:50:14.3992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5bpM2MJpbRJM/UW9vP7uGzfYLb0a0AF7FAJxM7QG5e88vTDxYDNIysWQWXFp4j/lNz+3syC8Sv+zA94WDIb3yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR03MB8308
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:03 +0000
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

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 31 +++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index f8a786953526..df44df2e872a 100644
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
+				ARRAY_SIZE(data_lanes)) == 0)
+			ctx->lvds_reverse_lanes_conf[channel] = true;
+		else if (memcmp(data_lanes,
+			   supported_data_lane_mapping[LANE_MAPPING_NORMAL],
+			   ARRAY_SIZE(data_lanes)) != 0)
+			return dev_err_probe(dev, -EINVAL, "invalid data lanes mapping\n");
+	}
+
 	ret_data = of_property_read_u32_array(endpoint, "ti,lvds-vod-swing-data-microvolt",
 					lvds_vod_swing_data, ARRAY_SIZE(lvds_vod_swing_data));
 	if (ret_data != 0 && ret_data != -EINVAL)
-- 
2.47.3

