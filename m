Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23326C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:01:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BF6410E8E5;
	Tue, 28 Jul 2026 13:01:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="eJYPUA/l";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010021.outbound.protection.outlook.com [52.101.69.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCC3510E450
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 12:20:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwKwhFajr9YKRq5BCOjQak42LToALCoAwmUwZCnUAsy7FSv+eY6DBBAATEcjeKH95GJBLDZRq++xxS+r5OfRK58/YYV9P9YGSVNJQZzSOBSj+gQuauYUvZDpo2hVM829S+qSiFnobFKYpHwftGPOGbrKBZGcxHVei/Zex1rev8eBq7xtF1frBZOZLptNXfY6i42kdxCXJl5ZDwo36FRjNCreYhM8M+66bqf6EKhD52NP7LR5oTj0ToPzaZL4xuty3cFSMQ02TYcHc0kAw0VJQWG+HpyOxuCPh2pXJvAOLOywkdWEDFqxNE+sCnBa8NZdW9WZ0Nhbusybl4Kapw+6tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bGwy71TT0ErkKstC5Ym1MV7/PkBEOByBqIg/zMZyGk=;
 b=cpspF8EFwR/mwrRGDivsLWFT9NAbFNZhhoAM5XhdF/H5vcojdO+KIvlCqQeNUq+PJ0Mz4ySCfRp1rjMXyoAbGQDo3L2kpSxkJM8eHotYyJvdHGKTGltKZZSr0+fQOoXzqgTfuFKka7fQHl1Z7P5bNwwRlzsutn9oZRBnBSlKtW/LGZO/9A2zfhk6afZz6x0mHWHogOl4k+v+dD6WW5YoMLvn8Y+PP2H5cmeBZueNnKA/avDjjFTd5Id65mYfge1riztP/iyYQUSVMyRBnLDyJ24OheuRgJgLe+SqmOIDZtCC4VpAMN6/lhoz13uZKTog9hKyfQdhWvnoJcbpLSZUdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bGwy71TT0ErkKstC5Ym1MV7/PkBEOByBqIg/zMZyGk=;
 b=eJYPUA/l0fbzyfbsFETVigf1XNO9iEpW7JsItAHbnNN1Cihc7wc3knnl5cLz+uZLEkgGNzJfiqN0oEkuOShCx6pxXtDJYbdNQ+NHRmLuHPUKLjpRe+DnzUO96XC+hCpZlmEh2lSTS2daxM5vo9KU3J+90PA+UxvvRbtbcW5rszkjjMmlw0oqbU44rN+5d3XtFSDC/QXZzGVOR5J1N7WZ798FLDU1VpvfLN391vzqwVt0HufDUoCH3XQSl4+XrgB4RAYaPk6ztc3Ukq9o/RrdRh1v5U0mfEmZspuaLoYUAPoIUumvh3diwhOy84AHPdjPcI1q5OucysQicidoDURMBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by AM9PR03MB7993.eurprd03.prod.outlook.com (2603:10a6:20b:43c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 12:20:47 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 12:20:47 +0000
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
Subject: [PATCH v7 1/3] drm/bridge: ti-sn65dsi83: Simplify error condition
 logic
Date: Tue, 28 Jul 2026 14:20:29 +0200
Message-ID: <20260728122032.692482-2-wojciech.dubowik@mt.com>
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
X-MS-Office365-Filtering-Correlation-Id: e5857434-4396-4eef-f982-08deeca2a6e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|23010399003|366016|376014|7416014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NKX49+5LR/ZzF1dbz7A9RKHcwdb3QX0nj1sVt7IHXLkFbyuiKE722Bz18/fBqAlGOPs8v/HwgWMswys9c5UTR9M7yi7qqqb2u+b2Rgjhbryl7v6fDGHuMWEAaA2jAien/m0Gd1tzVtl0LKMJxtM8uR+jIzzLBNuxjK1hSNGRum6hTWTX7X7HreieOhlte0YfsK8cTsDxbmtzstuIcEmWLR6aPIE/B/c9yeLNZJ3h496E1cFF1PCyq32asDMTyWq2dJTYXqR6u6FTJRcXXGmXBc/SEVXeSWy5JXAmUoz3ZXA+4BIumSkzZdNfqJgfEyCMeEB+QbVK1xqMxydP7C/QhVzZIfCefhOtMVXGNMv7sI8ySV37Sg3PKMqFn7mFhBcnbzF+SPoFl1+6yY8kf9zWKa2Ok9kHrCWpp2IuHKXaGElLlbtAUNS1xpCVVVGRaPuH4bfBpo2QOAxRYBf2+PfSRokZjTA8zZQA0VqJdubZH82hXLG2yJpsa//scguo/oIeSd+EghETym+opho3PiGSzP68H2MEPNfNaFTRzW5ICpXxzPc7m/WiS08ZhWD/RqIGC/jQwMrwGty0V9I8EBLTq6klJKe2ggiXo6aJzcVT/2QsKleMQunjuRZnH1a5t1ANhJLTOZn8ibfZSDvqdm9mHG8zpwf8oPJ9973TyOQEU+Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(23010399003)(366016)(376014)(7416014)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GVOOMv46bWyB/QKb3bCwCJv02/aYay669Pym1u2A90eWcO9HboGwDTI7056e?=
 =?us-ascii?Q?sW/qS2NwnkJHCph4txjwll8322lrWQaD+lkQuOAvBEAirFh9hZ/OHyZ3iKNJ?=
 =?us-ascii?Q?iiD2TFax3ZGFZ/k5V5CqwgOJ/TmVQCBzv2ozt+CsvazprLFK1aYV+yRrS9rT?=
 =?us-ascii?Q?HJdT3eAqWpVytwJt9elhn0a5674/WfdvP/mmGVjkD28RjnenU0SxymUhj33D?=
 =?us-ascii?Q?6L21w3zwuqAvxouaB5hEL3DDcb3Ncc36rbkIH/jbtxBUseGyTsEHhcHKn4nT?=
 =?us-ascii?Q?eQaiA2Wal14SXUXfgcdxAOyO8cd7i/bgablrqrUa0NUoPvHApGhBGWE8DnmC?=
 =?us-ascii?Q?oY8c/FHLaZ9aGqw/5FCOgbolnhra4MECXKLhh2KKG/xQg/5TGeNS/JxbP+hx?=
 =?us-ascii?Q?1xve2UN/SgyPOSBKnM6wei0paMAd0SGgmO0JiGg36cbyO1n0dXKteOd80C59?=
 =?us-ascii?Q?YdunJt648rsQa6gqtemM0SdmKr5VwNQaYJ+rf/vSCXinctWCl2wiB3xTdYM0?=
 =?us-ascii?Q?KPKAB3o52S8seyfnQdSYuYMUDNuLNi/4DpgXTBcSJsCTMlKaOYB59zoVO8me?=
 =?us-ascii?Q?pmGUgqiT0uHkX2Y+xS4cXgp5QLvcm1idVygBfX6GKCWJVfNGrmGOHvUszwqM?=
 =?us-ascii?Q?TN1BCYk/gHf58cKUrt+bIhgyVG1yAcYh6TcuOE+uKt4OsoBwtAvPwOiLK4+G?=
 =?us-ascii?Q?6Zd6fcz1PaCI29rkIUNdRNbSDPo0Op2+n/MPO+A37i/MQXIpg6+lD5fUnjZS?=
 =?us-ascii?Q?ZC9Lcr/gzVXynQvqO5uuzf8MWznsH+In8JVoL8MXyhSfvm03OSu2auBgfCDm?=
 =?us-ascii?Q?HNyVwqEklcJkYEoPRk4PbJs4J0cWapgK+MRC8e4y5ehmNj164hPj3rQ6b2q/?=
 =?us-ascii?Q?CE2lQ7laVrsHAlOL68HRRGeRbPLCWtUyQgvJlbhnEhM/+oqGE9Xg6X4row+e?=
 =?us-ascii?Q?GjLGj9HWdIOpoELVv30CseO61EuUt0S2x2vTRnZVymxFiycAWUJDbxYFEVR/?=
 =?us-ascii?Q?BRQIzxoS69NOZmPUQhHyR0e+slN4XQdJJie/2gDdnx0EFGhl9ROScj9mSTAa?=
 =?us-ascii?Q?c27phb5RQUstzJRX7DhBIGHgEouC/v41iyFLKOj/Q2x1dj67/ivT3k6a8+da?=
 =?us-ascii?Q?tyN2YHP2KoAZRzAj6Hv/B3umYFrfKdGtKyOi+Rb0yZBhLvGgdSgh/khhr9EB?=
 =?us-ascii?Q?Cziq1Z2dqkCEhZIRT6UOGo5WQla32pMl5pvdh6ivp9IgJ86aBa/Rk3j3/8R3?=
 =?us-ascii?Q?gwMBMLG3A7uDaHtXL7C3/qD7AyUUtM3iEovgNhy7TlxQRrUdUoD7lGyIV60G?=
 =?us-ascii?Q?X7au5S3QEfthrxpCIaPAwp4gZ95M37K1t+Qa3gjHrcQnd06zhLzDl5l+D1J3?=
 =?us-ascii?Q?Ryakhz3zMaQPWNpvqx0uVR+LrBYugSfQtLyP8vR1MZUn0VnaD9fTRUwpiVjJ?=
 =?us-ascii?Q?WIGf/zI0WI1E6GDSay/wuNYi1uVUKMgyqo98A/2Lx1GgDlZLbvo884zhcQkb?=
 =?us-ascii?Q?B8jMG+rvTTR+wwn0hB+d8aU7wmos+xPqOhcWsUXsJuptF/L+vyBfHfOWih3U?=
 =?us-ascii?Q?IQmGwcry/Dlntvct6QgleTqYwPJNsh8wcB9lkQe9w/EVn7LKpnTnPs0Fs4uO?=
 =?us-ascii?Q?sOKY9CPFXAwkIHusEjdUds28MGtFjntP4X5LPSPHN+ghJuHiCpEX1Y9c0O1v?=
 =?us-ascii?Q?NS/kpeiub8GdCoXvgduFjFfhzs0f0QFJYExWC1zyB37VCzer45Bxwz5jYea/?=
 =?us-ascii?Q?0m7DoQo1bA=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5857434-4396-4eef-f982-08deeca2a6e1
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 12:20:46.2627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iUGbgpu/Q2NPQ0PSm6Mpb9Ok6UbL9Cu3yGswYjFgwD6BJxWSH2T2qnZ+LpSFFjaHfQtTYLJ377Qoz1hOae97VA==
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

Simplify error condition logic in lvds device tree property parsing. It
makes it easier to add extra properties without handling complex goto
entries.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 43 ++++++++-------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 42b451432bbb..f8a786953526 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -825,48 +825,35 @@ static int sn65dsi83_select_lvds_vod_swing(struct device *dev,
 static int sn65dsi83_parse_lvds_endpoint(struct sn65dsi83 *ctx, int channel)
 {
 	struct device *dev = ctx->dev;
-	struct device_node *endpoint;
-	int endpoint_reg;
+	int endpoint_reg = (channel == CHANNEL_A) ? 2 : 3;
+	struct device_node *endpoint __free(device_node) =
+		of_graph_get_endpoint_by_regs(dev->of_node, endpoint_reg, -1);
 	/* Set so the property can be freely selected if not defined */
 	u32 lvds_vod_swing_data[2] = { 0, 1000000 };
 	u32 lvds_vod_swing_clk[2] = { 0, 1000000 };
 	/* Set default near end terminataion to 200 Ohm */
 	u32 lvds_term = 200;
 	int lvds_vod_swing_conf;
-	int ret = 0;
 	int ret_data;
 	int ret_clock;
 
-	if (channel == CHANNEL_A)
-		endpoint_reg = 2;
-	else
-		endpoint_reg = 3;
-
-	endpoint = of_graph_get_endpoint_by_regs(dev->of_node, endpoint_reg, -1);
-
 	of_property_read_u32(endpoint, "ti,lvds-termination-ohms", &lvds_term);
 	if (lvds_term == 100)
 		ctx->lvds_term_conf[channel] = OHM_100;
 	else if (lvds_term == 200)
 		ctx->lvds_term_conf[channel] = OHM_200;
-	else {
-		ret = -EINVAL;
-		goto exit;
-	}
+	else
+		return -EINVAL;
 
 	ret_data = of_property_read_u32_array(endpoint, "ti,lvds-vod-swing-data-microvolt",
 					lvds_vod_swing_data, ARRAY_SIZE(lvds_vod_swing_data));
-	if (ret_data != 0 && ret_data != -EINVAL) {
-		ret = ret_data;
-		goto exit;
-	}
+	if (ret_data != 0 && ret_data != -EINVAL)
+		return ret_data;
 
 	ret_clock = of_property_read_u32_array(endpoint, "ti,lvds-vod-swing-clock-microvolt",
 					lvds_vod_swing_clk, ARRAY_SIZE(lvds_vod_swing_clk));
-	if (ret_clock != 0 && ret_clock != -EINVAL) {
-		ret = ret_clock;
-		goto exit;
-	}
+	if (ret_clock != 0 && ret_clock != -EINVAL)
+		return ret_clock;
 
 	/* Use default value if both properties are NOT defined. */
 	if (ret_data == -EINVAL && ret_clock == -EINVAL)
@@ -876,17 +863,13 @@ static int sn65dsi83_parse_lvds_endpoint(struct sn65dsi83 *ctx, int channel)
 	if (!ret_data || !ret_clock) {
 		lvds_vod_swing_conf = sn65dsi83_select_lvds_vod_swing(dev, lvds_vod_swing_data,
 						lvds_vod_swing_clk, ctx->lvds_term_conf[channel]);
-		if (lvds_vod_swing_conf < 0) {
-			ret = lvds_vod_swing_conf;
-			goto exit;
-		}
+		if (lvds_vod_swing_conf < 0)
+			return lvds_vod_swing_conf;
 	}
 
 	ctx->lvds_vod_swing_conf[channel] = lvds_vod_swing_conf;
-	ret = 0;
-exit:
-	of_node_put(endpoint);
-	return ret;
+
+	return 0;
 }
 
 static int sn65dsi83_parse_dt(struct sn65dsi83 *ctx, enum sn65dsi83_model model)
-- 
2.47.3

