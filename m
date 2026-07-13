Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F59C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7F8610EB4E;
	Mon, 13 Jul 2026 22:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="Q8ZE5fbg";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011066.outbound.protection.outlook.com [52.101.65.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC58C10E396
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 08:27:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMsqH9cIIFX5wTnY+ReuxQDdLvvv4vfHtsK+iH8CG5KT/73k21gy52ifnrWATRVvmI2xgMxQDepuQ6gN9jEMgCahM1XZaBMkQfA+dQvLz33A0A+fDm9xCW9M0tOViHhFeeYYnp4G8ehnhHpXnf77woi+phTjTzK2mA1sJZQy80Z9Uy5wf9phHITRNQcs672rX8BzbpoCuSf6HjPouC5/f/UTU0o7piLasx6exqggX7FjDh1Ok/+sU0/9zRz1zS3HX4RB5uq31Wzjpio+sa3yZ9H+D0k8qwFOB4lSvgz5y1HWjUv4sYzSd422HUaV0hA3AHJBA/SEzrryB4T1HDg2Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ps2pIAtsOlZ15mUfBLrNW3OT8Vmhj5ogRt2NgPNrbys=;
 b=bfzg5NB1Uh6jMLOp8WKWbpwdoSMqCCLrWDFdXjhiJNYT7xB2Jv3mVkYoEQH+ySjxgZw7XVosWjPkZWJfZI1IAfd2i0eM911jbV3nND15YCyAo9jJ9taZ4BD0tU2vYCljEvGKvHlNSjafZM/DSPM7oIrIIncOwaVg4uif398G/q+HAiS6tgJWw7vjQjQdqZ8vEqpdHhRijQMM7hbPWbJ6SItp+YgmyOiNx5pnm3NyJWo7eGO1WtMB0nd/ld973f+zBEx5xkJ5ImvK1bgaqThQqgkjccNN346qH0Ut/jU1amVj5QTg3rB0lVs5RKwo6bR0QaNB5k0vX2d213KF2YpzmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ps2pIAtsOlZ15mUfBLrNW3OT8Vmhj5ogRt2NgPNrbys=;
 b=Q8ZE5fbgH1Wc3S8aQdbiTEJN8bdiPkE5/aorvmV878GiTdztA9Phs+nP8Xtr2l1Id63hKMXu91BawvK51OaFKWmi4o/ux6iY6RXFlXKAPN/ZxOKKrnECkd8usn9zVKP6RT2CVwmrvz9QJ7N9wYZWc1JZyeRxt7Srzww6J2WlJAQ8C06Hyq0ftKsCUl6oY5h2MW4c+rEq9IOgS8Ynj2sUAVn64wWZNkSZ98DlDJcY3ek3/zW6m5aB01LRdvqHIxYDyTyjRQvPbgpZA/I4paGjBp0nM/1JhMeWkWXpmWYfJ1TZiSrWIViWiNervUhv9LEGCmZoPBmAS2cjHHLAvz2Tug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by GV1PR03MB8613.eurprd03.prod.outlook.com (2603:10a6:150:97::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 08:26:56 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 08:26:56 +0000
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
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/2] drm/bridge: ti-sn65dsi83: Add reversed lvds lanes
 support
Date: Mon, 13 Jul 2026 10:26:20 +0200
Message-ID: <20260713082622.52985-3-wojciech.dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260713082622.52985-1-wojciech.dubowik@mt.com>
References: <20260713082622.52985-1-wojciech.dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7P220CA0077.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:259::8)
 To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|GV1PR03MB8613:EE_
X-MS-Office365-Filtering-Correlation-Id: 1104e3fd-3467-478f-4714-08dee0b8801d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|19092799006|1800799024|3023799007|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: W7pHURrTmAY+fhmH8NYIf2k0CDJpd2eytDYwzRucXbsaOASfRdwaNGf4w7sHntPFMH+Ii9NlEm5JxDNszSkCmVoMYlqYRg0b0F9jeAYCVwdhFX8fYTVG6K2FprkpnRa69f1FuVg/XqmjN+OSmUB3ebn7HFnWpRj82ex+tNap2WW0hFIRxDAH9fhoJV2wIKwW7WTishCsCvc5T7bz3XPbXVdUfBjr686bNWUK8s2Wn+SZLX8R5yUp22fF0ffvrnhfTJlLOHfWaB67xiSmBTOtOw1zZMRvTJqBB0617w+9sr9iIDQLR5rganWwNQNmIz9L3lAlZ0MrYdHBeykt61mp9i1nE1gf2xRkrdRjwQzNJ4GEoI0IKUsV8baYxoQFyvvAkoW6aXivKjipCgpTuUX+8P50qooD7EwOYb0d8/rVlExE89oxF7EVzAgJPR1YDbR7wMyX4FxRXjEwQBLCqgCVIMH23YhFGdsD7h0fY5LSgYllcBuCGVuHpDZBFJs2n8iNflkQmuHniEJtLIoGc4YoutVaFGFW8CeaYaR79O+5pipg2g2hEu4snKz1N7eyyhThDVeeWDr4PYlahRrIZiaHLxed7dcakfTwrEsmbpy3UuFANwjsyAM1mjBhLMkdFHuEGB1BeFYqAvIR88DmhBqs3lwZWR7gAYJN9Berwu6JoBw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(19092799006)(1800799024)(3023799007)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S/IYQRH1BEjHweeQXriGwI+ikDUhzDJwPjavddGIoHPtAQ/8E+LDa9mREeL4?=
 =?us-ascii?Q?57eRlEd95e1HYMpeq9bLWiiC3kbkgCEJMEhiyPU8ddpDjvtZ309joestqA90?=
 =?us-ascii?Q?XudXKi0JOq2bH9x5sltxng9Ubv/G0vl9RFcy9Lc0pCK8CsmMMCIrs2tmfWOp?=
 =?us-ascii?Q?Sv3JoIx/lTXg7wCo1wGa9tKGbCOBSAIr9RuT3XMXpQhwjJXWh5A68TCNuzof?=
 =?us-ascii?Q?aA6iqFyqzqEtNWryU6MsiuQ7Kbd6zOYsJzkL2ZqGsVACT3Mo1GTsGCl4xK7B?=
 =?us-ascii?Q?tqe+PGND6jagcrnE927HM/AdgZyUll+iDHCnRZUFsOM6toLHjM6LDb6kZAld?=
 =?us-ascii?Q?xkn9wuZoRe29EBuK9RlC7HUen6SVgqmevwQsqZT8pNMGxhXrKScApjsAWlY+?=
 =?us-ascii?Q?icnv2waswyE0fdWVDfRoW+87EB1JbLkPhqkYGd1RdaoSj6nj9BKRykGUhfs9?=
 =?us-ascii?Q?r42+wxAlG2FGc9/KU3yWa2lnmMxVh43/QU2Y+oQGKwPp9z5mPNVtNhMRk8MX?=
 =?us-ascii?Q?pCFmF2algncwfDjZOx3T+tyigxHI+Fz2OytDLCCiVdzkAQSsRo1bxytCzgem?=
 =?us-ascii?Q?stiNeKvEmauaZBF0OetePWI/nPgZLN+96qsLG4S64b2A1WqnWe78hmnJKS/0?=
 =?us-ascii?Q?SkJYfBA26b7DL9hPWIVr2Zj3/W9dIRNpi6tqo4ANlYyrFwD5VDDFTeCBYNZt?=
 =?us-ascii?Q?FyQzCG71XE21/aMruzkNFLqsOxlaxJoSdJh41HI0+ROYBmCViXT4P+dMQCGp?=
 =?us-ascii?Q?dmbKDd6xcNrC4BCw+bUOrTfrSTHdPXm5waGwpQfee2Zs4+l5AgSfCcYEgEhp?=
 =?us-ascii?Q?7n3Ef3AVJ0f305cOGZLsukSA1m8GSQMkrjzqLrMN0ZouVYt745lDXIN6+VQd?=
 =?us-ascii?Q?6PTLmxzYKhxZY1sqUNBbuQHZEVNAsJ9ew+j94CEaQ43hPNfPLiei4RvHJv3F?=
 =?us-ascii?Q?NNSoMsOSUiA+UUiDv6UNSYur9k+s+Ph+4xjp1IM8DxKEhdknNCRGVzzKGBsp?=
 =?us-ascii?Q?4ERaJroyGeSeR4TygsCXx/fIx0QiIeB7fRrw5YyH+1LDbq9XANFR3p0Aapya?=
 =?us-ascii?Q?ehqZWK/bbMX5Gl3G1ShhvwRvtMtgK2VMdMgoxvAiviYG6K+RQ1IwkT3kZ62E?=
 =?us-ascii?Q?ItyaFwcJchWPkfUlaWkIpZVPpEBQ4E2FZGlvD6SulG6Yiy0P0ytLe3PzHMtJ?=
 =?us-ascii?Q?1gcKxhil7zxP6DqYwlJk9IQvH6fhTbGI6fxwcrCndcflw00C0DR6smycnat4?=
 =?us-ascii?Q?O72VF86syYiykX8E04rKijD1qiyHRgtJrcbuDcWoj9pNEzLrwOh0CeVJ8qGL?=
 =?us-ascii?Q?nrL0cni5iYet06BiVrTMjJpDrHmeSDDaa8YyRNdikdi81+Etp1eSZYEi+1RQ?=
 =?us-ascii?Q?bjOMkgF6BjBX3+kFZx9RXzS5OECU3fL+WIPnG/SSKwoUtu8bI2f7RAYO7UKj?=
 =?us-ascii?Q?cr8mt6fGWjnpxqjAwJr9zvGnD2frBjs84oJTwfrLJwlgAjDN7JG8RBKsK1h/?=
 =?us-ascii?Q?WxhUJIEFdvSJ6krPaAFOUQFR633xEW2r1t+R55HLIQGthQdFrx1FQzecq6ha?=
 =?us-ascii?Q?zLmCXRyt9T81wnrGE/TD8XtikRcVgw1i5/6Nbeihu7DZFzbclhEjhAXkkhOM?=
 =?us-ascii?Q?BCTgUg1DtcwgTNIGQaR4mKBnMVMlA4F9J0ZUhmOiGa2jmhUUrU4jH6mewmhK?=
 =?us-ascii?Q?st94KNDgRQPm5j5ozv38JF8f2iB9MN7EWyizUIdjd9A3+qrIDk+taM3+YFEd?=
 =?us-ascii?Q?/e6zHJulNA=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1104e3fd-3467-478f-4714-08dee0b8801d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 08:26:56.3476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KdV5pTXCZ2j10xt0R17a45Bp6YuRnNKD7AeMghCbsnexFjG1+U+5GkIfn0qqkVS8oe9T38X0oX6BeVOEDIqMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB8613
X-Mailman-Approved-At: Mon, 13 Jul 2026 22:35:59 +0000
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

