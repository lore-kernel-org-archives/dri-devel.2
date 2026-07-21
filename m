Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC88AC4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 07:21:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D667E10E6A9;
	Tue, 21 Jul 2026 07:21:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="rnYCayEJ";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013070.outbound.protection.outlook.com
 [40.107.162.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C164C10E033
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 07:13:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0yymKv+fPDFTLOxOKsxsdaRMeByAinhkqSZ1VSqymkmiCoC84u1tgTRgwDkAc6FMx2HK61yXDp3a1pSr34VNN7nOVZSEBHuRVNE0X2jq6npFqwJ3/b+/68gjadTl2RbcJB87XLFZ1gT2PrstuhtLzI0nPP+fRbEsBmpjINeNDfA/XWgwc/zzZtAf/tzDo947cyhYdI1E9VcLtdvPFSSZeWoklZtpX7WKqAe9FmV8Jy67pev5ZT7+pDavAoDxH7lL4dlgc8aMIoUWatwLWUxsHNRPeu2nwJB6kQi/uCN7MUuB0+oD3tGFlBiGiBOebrTCmsoPsuh6QQAngluqevSmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRJNRZsbXX/7Kv/SqN2WRY3/+fNIWM0aHUcVvAEGQEo=;
 b=XnHgbJcU0f4zWSBrUjL5eIv33s8U2rnfH4nAOlb8Do2Xs7bYlK52Ei/jchfe1I+s2WttmvOAAvdHW06uRK3NIsP11n/7pJKiJK4XrijuyPtyHGF+Bem0Je+LHM21GEP8OW0MU0m25hUHMW1GZ6Kl5tTva23WRuM2J5WFCUN3CY0XPIhoTyWn3MvFVKLgxDFvY+zp/JJenKZoqT+NQRnZy1VkiGf1BwgfUe5O4Dd0W0MRU2eFk/n4rZ1yjokKgistchFI5KJo6niqDy/PLrTnfpeO0ZERmeN1dWyB1v+1yYuj0oFgKmt9jMlUh4tE+YA4GGQXsixQDdYvPN7tmOTWfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRJNRZsbXX/7Kv/SqN2WRY3/+fNIWM0aHUcVvAEGQEo=;
 b=rnYCayEJVP1L4Mgpr2MZw+COW3FfJBM7hD+r+JNEof3jPDlyBfC+jAbtozaKj/ZV7T96K3M2/aoasDPIzoUi+9fbkABaAEhrREkvNAAl92aamv5xQXeOfxCqeFGB0dgZcGyooVKqG2egArxRiZOB3nOKFlV0mgwb2rjT8VDi8uZbRZ41bW3l+B+W0ZziCxI1K7x0NKUt66d2McdQ4SvL2MWN5X+etmTtzbJmv4gGlScQtt1OOY8VdSgKBpX2zS5Fbh7Mwec3xRN2brZ3/oAzEaJvoq8ZYWgXdp+8IDarCewTX1cVshA14PcTgwcae45OQvmlpz7Nsm1sw8ihhnLGAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by GV2PR03MB11523.eurprd03.prod.outlook.com (2603:10a6:150:320::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 07:13:12 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 07:13:12 +0000
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
Subject: [PATCH v6 3/3] drm/bridge: ti-sn65dsi83: Add reversed lvds lanes
 support
Date: Tue, 21 Jul 2026 09:12:50 +0200
Message-ID: <20260721071253.1098652-4-wojciech.dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260721071253.1098652-1-wojciech.dubowik@mt.com>
References: <20260721071253.1098652-1-wojciech.dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0047.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::12) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|GV2PR03MB11523:EE_
X-MS-Office365-Filtering-Correlation-Id: dd490dd1-afa5-4dbc-de92-08dee6f78663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|19092799006|23010399003|18002099003|22082099003|56012099006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: RWWTu4erA7klqgax8J+CUjnzyvwyk8t8l2Po8QAyGHHseLa00WD0WxkL3Af69fFPy3TXuqbFqT5ZTFDfsAats3a6o6w8qPt9I0xRwM9qwVbPuLiAXLPDx9dnZfeT0t5BDdCmyxe3DBdHGNEq8UsNVBdHwlYC/1s/BkY2XWaZKICbXTVspEeqVuwN84gQxgm9p6G8sqn2Wfb7GhAgM54rg0T3f3+XBDe85m7Unqmo10tSHmOOlmcFo8WIQi99bj+kQmxipJpq0Zl+Lum+G5cVgEijvR7+PDfFPTl8gM87edn0w/CyX5NXb96lggm1t8l/HHY+q2M8MY354bgjMlKnHbhqFTeWmraGk08s4xLMcgXGyUkm3AYsWoZT3VbA9gETEyJCQPrz78w+JBCX+Z4pfN3SYcIzjKFvJYr0xKfOcHAIhsQ8gLPb/RYXcIlaUzgVqT3yOGPnjABn4TmE/5cDvrm0EhHmW/2APGtY9sXPoHWUSPp/+bW7ZWpK9yMKT2VGTgdZvPiBNrBIIyMVZnRZYINojgKSIbLJtsp7DT+MUchJcNTWhB3dDk3RoQ8bU4H5XrwA0LuOhQrNWCQey2jRaBN9oUxcHuSl7KmLTwpFah4FWgqTe67EvDHd1PbK1pjqe7zwrh2VP1be5S4Y3v9uLbonZhw23xJlA3uszZFP1JM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(19092799006)(23010399003)(18002099003)(22082099003)(56012099006)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KbtCbvfJAKHQ/6azQc/z1YNebnMbd5Hw9wr0y+DtoBLD05OR7ntjDeCGyOsp?=
 =?us-ascii?Q?bLoARYqWTG/nPzFQz+UOkFNB2Fuc/cTYQO2NNLG+UiZNZFejtXdOu2FGmykf?=
 =?us-ascii?Q?x9ObgLmWtCFBWpKJXP+SwLveloOVMIzJUpJyE0cajyGWaCRhjRrkSymCkTyU?=
 =?us-ascii?Q?Fljvc1ojW9xoZHy99w/T0tnVW1Nsa1vX3aiJPz0YIt8CYkjUtPdlSkdFDHts?=
 =?us-ascii?Q?UyJwr22oX4R/cjixnE4jttCj8ZrqVRMa4LryDApw9qmiz6yprYBFC9UB7SpN?=
 =?us-ascii?Q?aFYte9zczM5TBW6AIb2NbZl7qwGRjblU7uzO1iG6O65S6A56HutWjqQ/5qvR?=
 =?us-ascii?Q?dheYdkmiRNN6g9ALczS/npIUqZPtcD5DrfV9oPAZ6gUXSwZ7USGEtTcQbQab?=
 =?us-ascii?Q?isiELGji3hEgEqQVbHb9uMOq6ij2UahbBsBZ550vqUf2LdFpfsU5zRc4FL+z?=
 =?us-ascii?Q?vkrf7E3fPGm7RdIF6WPe+aFKxhycJWaZgsYsp4kAULOnlPJv1H9Tul6gnY71?=
 =?us-ascii?Q?uUUUAx6rvjX7wt9A3BwINqyQIUNvwrskHwKI5x1nuOkNlVJb4wad4kBSCZ9v?=
 =?us-ascii?Q?F64z28lnYwNHhsbvD6/KNpQZhp4KUMtVWvy6OihmUyWR2w1ZcM48NqGWPXn8?=
 =?us-ascii?Q?03x0HQnmvEZ0RUn1vRs5IASKsMM9BSmtLBgzMUqbzum+3VCuvVzliB9ccyd/?=
 =?us-ascii?Q?pTEDEPhD6FuBjcFvy3MJqChyWw242aVeiA5V4lDDTTltUdIcNodxX0EZkBCd?=
 =?us-ascii?Q?zuMZVLFhCLaksc+yIAY7mgE8DqXRzERjr2Y8DPaqzM64xObbwVnO6w+tSpVE?=
 =?us-ascii?Q?kwSwKRAXVlWJwIWvmlhKqKWv6i6jUZpLRqunHpi8dVV1sX6kjed6pNkrhsAT?=
 =?us-ascii?Q?nHW/7NcqS1U58U/+4yF+z3I3Df7VpYpBHjkddcf89DYeKOSZSrhH/gM+a6Jb?=
 =?us-ascii?Q?QjwdJy7k6BxV2A2z58oUsaoH+td4/Uf4oQpo+qlWXGzZaM7Hg9JvEMo1lSDv?=
 =?us-ascii?Q?tTK+tcNTfN9OePkP9cyziyvFy9JgIyW2BEnJfXrIS2eJsVtczhNVojwv3umP?=
 =?us-ascii?Q?9sM8e4M27++hLLDfx0Q5NH81td/x+nS8CTy/RXzdBcqur69AbZr8FWY+1uoB?=
 =?us-ascii?Q?7oex94xn+r1WmiF67/t0c9yiWWfpAep4tgTSfW+nQb5BYY8l+CXZkYxS37s3?=
 =?us-ascii?Q?qPE3D4BwoMl+s/cwQgpkaumTFuvsmora8trQi9uUzQzdHY5DX+S+qrYLwf7F?=
 =?us-ascii?Q?awAIIvl/SclFNAAkpblX7gJiqF44Q3R0wkUOWcFS5w+AW1plZDHXOQ44RXW3?=
 =?us-ascii?Q?u+Kiw6vQGNlMzfYKBT+6TPwMhaDddxbZRWLHb/OOKP/rJ64dax4dkSV69VbI?=
 =?us-ascii?Q?3cZM5KPKPIPaEkglkbd/1c73RkO2RhoewWkdAFV0FonQ7XUfhRtYLYwbc6ux?=
 =?us-ascii?Q?+d37TGJaLdE/BV/n6XtkexqvgDK8waUeqw5swlJQXYOgWNgEp7yAUs342ObC?=
 =?us-ascii?Q?f+DoekJQyQ6N8zH4sqIP6/2vo+WfHeAmNhBX6CJOYPm06TmGoNTr5wXunExT?=
 =?us-ascii?Q?s9/6S5pA+1Go19sCnRGr+AdCfXXhtVaJ6Ci0QPYVpHNW9ccR4KPXsr4m6+QS?=
 =?us-ascii?Q?o2/chnEyrWpFNH782ON1EYxY4FJELQP+LjdI0XR0PSVaN3O4JDkEpLbNvKyc?=
 =?us-ascii?Q?HXhKfph32QKSses24wxdxXSUXJp8KfrhppMbEI5gQJQ4gTekhbeqMArL//HU?=
 =?us-ascii?Q?nl0j1OiR1A=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd490dd1-afa5-4dbc-de92-08dee6f78663
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 07:13:12.0167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOMwr65J/KGGzwcufbRyV31HBhVkvjlAkLDa/yz4aooCYdqy6dZszQC2nnJ/yQO7lQ7rRTxI+dYNv49sLUT2fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB11523
X-Mailman-Approved-At: Tue, 21 Jul 2026 07:21:13 +0000
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

