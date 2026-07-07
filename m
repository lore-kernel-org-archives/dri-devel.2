Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E22C44508
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:26:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1516B10F439;
	Thu,  9 Jul 2026 07:26:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="u44vtgCN";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011012.outbound.protection.outlook.com
 [40.107.130.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF2B510E45E
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:02:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEzrCmtt/DDxaAuwnoFW0L4PmvubaF7g2CD4XkB6VzJ23OQDLHgb/rdUv0nKXy8OorFTmqGpnd/aDfPLomXxdMVjtEfHhtpuwLfuPnwFO/GerKC/MPGaAOGQFHOBsL4ceW7vhVkmywbUUSpEv8SmOWvOxq9V6YI/+rYyu6Kcnr/2dQJsP+Iwg8R7S5gEzzeUUm3poBDIFa9EOAQtnPMcSgYR2LpTX5QdsD+hd4qLVo08/FWVvBcQOYQQg3GvRtTCZ9AherucrHOcRhVfg8qgUGC1OdaSchrqwBSp0l7pkpqMdlStEn6kO2o8H9HF8jTSMmCzJsVElJ+A/XIiCUvuYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFamyYujXXNaG73fiCcVJAQYm17gM7f99rmgHR+fbI4=;
 b=kUWLVnrtRBLnoY9SPfW0Z8LPTP2PKHEoyh/mKDFsRTDs+tD3CZHmxqFY2IuQOXMa5+L6YN+ZlnlkBJ2m7rPuKewcuITdW5XA1+Kda5tTZZAkOLMW4LKDM2Q7qLlWD3szk6dvVsoti4aUjiGQoXMzOXb5vRKUnGYhUyJf/9GkZ2y+ES8Hm/SIvhu51qSwTlqRMgjC4mKBvahf1+4AtEJlrIR5q7LQGq8syLj7Zpjdwajl1WiycVjqDw5VldptN3YAcqMuQw9DtTYiKNO+pFKHnz/OkXANW/k/8G05e0OFV31DOAkT9mz/JgEhHJb4HFjpI5rfMIxIa0NECtBH3QZI4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFamyYujXXNaG73fiCcVJAQYm17gM7f99rmgHR+fbI4=;
 b=u44vtgCNhtmVbl4wkAWoqLmFSmhIapdvAPtKyQyO/ZQzLCmnT/jOHmLn1PBfuGO9Ct7q+8b0G2tqnhZLmcKepCF/rvF4hQ7HZBdM/fTwU5MbpP5Xd0spKjpMB4aSOrXvq12oOGSalTn7f6IJ/ifNX0qyfohJHKeDEL/xzf++iNKUOdpzpnfWHFSWhOhceCGZuTMbMR7I4QtNUTu6uUsWtV3FepnKM3Ht1mlqeRXm9R9OVNsGGbBWNniy+mZ/kjYq5DyQdNt82DHQaWyRnUO48G+fw8ZBdL+Unh+2eVDkJ8nGPjldZFJln+IVYz4Ze14gprjKsm3nMwVV0TpUL9qJkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by PA6PR03MB10450.eurprd03.prod.outlook.com (2603:10a6:102:3d4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 07:02:52 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 07:02:52 +0000
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
Subject: [PATCH 2/2] drm/bridge: ti-sn65dsi83: Add reverse lvds lanes property
Date: Tue,  7 Jul 2026 09:02:43 +0200
Message-ID: <20260707070244.230546-3-wojciech.dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707070244.230546-1-wojciech.dubowik@mt.com>
References: <20260707070244.230546-1-wojciech.dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR1PEPF000077A7.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::435) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|PA6PR03MB10450:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a44f724-4a15-460c-5500-08dedbf5c395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|19092799006|366016|376014|7416014|23010399003|1800799024|38350700014|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AvfvV699qt9UalC/NLaDBFzXY7Pb7GezkzDVfO/G6uMX8t1k7h9JfWqqpXwqCmcEwSmati/Q0o6BJsf0zX9LhoHHppczGZVnRRjaOtCCrMhvj1ynU/1bQYtTfcfz50BRpvmb0Vsi8XEZ5QKeZrze6VlHWJU5H2/LWs4YflTMTXPiG4IlWysQuk7pGIkrddWgrJhicQ+LjaSHJbu52HFKozi2Qsm87KWAOW5hX3r7n9w8WXlPmnytbO7TIa7KHbFcUk2bGyAxqBiDXzXw1ZRwuiFfZc91lKoNzzzvq+rRI6jLWiGHLxLiU1n3bR3k2YV86uEzcGeMAwmsxxzqkv7uim165KowXylwA35oGBLo0W20LJaIdKX+qcL///mPsoCOvZiicn0emWr58n8uTXWGoKPxbuGkKega2KMswyKA0A6ztV/vhpNT0m/dinaIirmNpkCVVUecY20sqCG+iqqjlP1/IyF6vY4DwW40IK+YfZq3nU5OJMvBKDJbbgp5yyM1FZfc5n6qvOTblwEvP37h9mkXmbfhyRJ2tP5/iEKhcPf0PKeACd8CzYEX2ovaWECjsRsk8xvzJ790kz2DAuZwX1cDN5jz/ogbeJUxDK8Jh8OPqCFhGiqjMMUhciGetNq67MidmLQGsrtAhozUlTJ4TN3HLRDoYa04iY6BIW6XFBqYjBRFDwUY5Nn7pdO7uJyDq6G1tlCHpq9YpLyQSS7v/PTvc6174Mzbn7ktes3hWLI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(19092799006)(366016)(376014)(7416014)(23010399003)(1800799024)(38350700014)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qa2u3g11C1pUdoZPtAUv1E1H4fb/18RSrpJwJDNJHg86uRzWn7Z/D1jN6XKr?=
 =?us-ascii?Q?paTMlAArLR7WSJv/Xw5Khe5zfVYEYYKq4sLCUvNUE2AfXfz561y/uXaBdOEA?=
 =?us-ascii?Q?T7WG7vF3JQsMQhQCCy/eCW4Fgl30YvQ1JHMz8gZusWaZH0VioQvi+LTcWWjf?=
 =?us-ascii?Q?yignjY1X6I8jupkqdXkrpFqilRQxN3fyzrkpsxwpnkGVi7lTA4LaAonRudIn?=
 =?us-ascii?Q?N1itz5klLOPf2swQEeRUOFZvi/+C5JtXL5pe3Jev5fvaD/m4Nbu+pmx8eqmM?=
 =?us-ascii?Q?jWKS5IdsCyqX/Q7aZTc+biUNiCP+Gz8kuSHmCPRADbESYCL9/AAUM0rx2a7Z?=
 =?us-ascii?Q?jH8nW9lG1VtQ6QikZCAMcxFt6z3Xgs2CduPxQvhp16Lyzf4nvHhgCcbx9rb7?=
 =?us-ascii?Q?6j0XGkNSNQQwafCLeqSdjK3z8zYB9VvtryRGPAAAv7I96Cs36RafYPmC795i?=
 =?us-ascii?Q?za+h95VD/OgdHHRDAIJug55oSxRP4O7ijspOweJ9wVmy0St9u3eZ2dWoTlsw?=
 =?us-ascii?Q?7DLbr8/Nr8MQJUhPwh/uxbnm+xZ4ui20+mrZP2uSrIY/Y8bX7yQxkkdLs1oM?=
 =?us-ascii?Q?ENTQoeu3TLrTw/gB2V2hTybSBi/sWNAO7AF17zSAH3E2sDefiAeNYSg91XCN?=
 =?us-ascii?Q?y+uGoJhombPDZ1Lg2bpReJUmDTz9haxeYDcjn9O+4h3eZ1saZpyIfCwYrzqx?=
 =?us-ascii?Q?LGpUzzQKlxKyNLluHHk1ek/nPXHU3A9qScQuL63Bh8GkHKf/4t0xxjxsdbMP?=
 =?us-ascii?Q?5EJ18NFTmbR7KByg38t4AW8haoGuypun1wv0yEz4ToYNxM6WNJSS4O/KqZW9?=
 =?us-ascii?Q?OKLeMP/3gSm7fY/kLmZt/KlZTL/vePd6a4SJO1AwaNjnCSoDDOr1asfMrNKH?=
 =?us-ascii?Q?zfM2+6H9F7jB8cuuoMTOmq2YesWqDAf4fxa/KjjnYMmlKZyzYGM95/lIE8Aw?=
 =?us-ascii?Q?dkIqVJWWxdEQTV0XykQyRs4r4+beJKlwVz/xjB/wQbiCGLxQAtKiDF2Bzl1w?=
 =?us-ascii?Q?bLFkMJqi51zx78Nc90CqPkEteH5acFwf6qSz+9bdI2zx2ExQ43a/M5bFdWoO?=
 =?us-ascii?Q?A//k7VwXzDBP5SbwP8UH6N0LkyO5gXknvqGfNs6LL65MTj8r+k7EdcSn2A2S?=
 =?us-ascii?Q?P5bANxh450cvHfU3T19d7bQdBRzFWuxTbE2yvuWbzRe6WZdneaqSfYgPpVkk?=
 =?us-ascii?Q?SfA40lrvD4GQtzzSOe1oVl8x3qxv8xskYUUBZwZ4nTbLCc1oZKWstRJAVEWg?=
 =?us-ascii?Q?nfkBL8UbtVsIPP9ySowtQ5sHjWU9POd2dHZhf5+FLoH6gwj5sDaWmln7SHhX?=
 =?us-ascii?Q?FZtw+PkNbQcyn/M2HsUfiSvIOOaa5R+r7vPQqCUll0njnc5tVMkVQanNQI7S?=
 =?us-ascii?Q?3rwWmLM08NzqzMkohWjf8gS+WWD4ztJ9jbbHA9IsaHdt8u+58SjSito2Yy84?=
 =?us-ascii?Q?q+Y9VKliyxpvM8/bmmr2SxU+eRqwSrotHNeDDy9By+XHCBACF6IggEyV8N+v?=
 =?us-ascii?Q?khQ2gKMDi10Wau1RFOeX1eMIMRusSC3fS/JztOM1KZ0UKsrmhVXZT1/43Fj8?=
 =?us-ascii?Q?RrmrpqOmnihEXzM8lLGlJ9T/s+r57Jdtly0Jw6yDUYty4iy2MEkSK97i2ICk?=
 =?us-ascii?Q?xTbAykypFS4XprxZ2Azbm2B3whGLA+UV0yoFZCIksWgoCKl0R6dB7j3tnm0f?=
 =?us-ascii?Q?1ITDqwHVe2ueGrbaQ39Q0viiqMI0MXSOCeWZKVOsqZpA94vV37z1cT/rIKXM?=
 =?us-ascii?Q?NOMqP8HCTw=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a44f724-4a15-460c-5500-08dedbf5c395
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 07:02:52.8842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IdolaRyQYPyRSyk9fj+jj0d/WlOj17xMxdhRjDZBmRr4Scvf6n2xj/sJBklVdLGDwqV41jkFBoD5cc11BILZnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR03MB10450
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:19 +0000
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

Add parsing of lvds reverse lanes device tree property. When
set, the endpoint lvds data lanes are configured in <4 3 2 1>
order instead of default <1 2 3 4>. This is needed for layouts
where lanes have been swapped.

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 42b451432bbb..2ab2764065c4 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -163,6 +163,7 @@ struct sn65dsi83 {
 	struct regulator		*vcc;
 	bool				lvds_dual_link;
 	bool				lvds_dual_link_even_odd_swap;
+	bool				lvds_reverse_lanes_conf[2];
 	int				lvds_vod_swing_conf[2];
 	int				lvds_term_conf[2];
 	int				irq;
@@ -644,6 +645,10 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
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
@@ -854,6 +859,9 @@ static int sn65dsi83_parse_lvds_endpoint(struct sn65dsi83 *ctx, int channel)
 		goto exit;
 	}
 
+	ctx->lvds_reverse_lanes_conf[channel] =
+		of_property_read_bool(endpoint, "ti,lvds-reverse-lanes");
+
 	ret_data = of_property_read_u32_array(endpoint, "ti,lvds-vod-swing-data-microvolt",
 					lvds_vod_swing_data, ARRAY_SIZE(lvds_vod_swing_data));
 	if (ret_data != 0 && ret_data != -EINVAL) {
-- 
2.47.3

