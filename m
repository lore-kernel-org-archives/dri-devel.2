Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2FCC4452B
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:16:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52A5B10E796;
	Mon, 20 Jul 2026 07:15:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="AP9bRSpv";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011011.outbound.protection.outlook.com [52.101.70.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 541F310E3E4
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 11:50:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SeOG3YbdlNpqvVeJBpXkehXUJEJTJlUzRi2zYdy5ltXTBqT9E/45x5vaoR/Uo9K1UpMrXbgR7mCsaVF6eHeeMovP4Svs+gLM0s/C8BnTAm6/gqJ3kE7zFg0cM5WWH5CdxiFojZMAQuC4Jer6MTT8ctRI7H2rIUXT5U2mE3d6h4kIpJzvKA9uR9EVLdb/YTPj6sOQ1EjQjtSQ7idVG5o7fs4Jtse+biWSarjfLpddOeNTs/+uJ7vXsUGFHkIHjQKXf4Hbij6HzzNyoQzhvhjI3yuZcP049ZGwgJM8MeJpjTmCIScqyJ1oLihZFBkybWn5bOGLxGv91jsLCldMT/DnBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8tPc4V/vwrOJYowbjT/LlgTu3EaHCYi3TA78VVpRqA=;
 b=cXhWmELjxAjHB2XXZ5dADnamXkTbsQfgbR/saQcS3hD6mnpEsNea94LYqVC6ghHsYACRqTQpl8hy9v5cGCXnfQ1cwDhGHmxWVhfi5c4yblXZIs0lFVTd13BITMjfO4qEZ8FHyd7FrRjAVM5RBAjy2cGrdjv0G9p92Os5gG0WT80A2hYKrhnWur7NvwojvKtYv/2/7RJl848LVol+SQ2bDivNzFUBvphKNDorFitaeziwQl0H+BLm/8uafNEP61axRUD6Nq+RQz6wH+5kNuc6CXjobgSVu6Pb8LB65GJ2BNoXL80OB43JTseh8xOBeuPGIwlmeZcYQ5mS09EYnNh/nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8tPc4V/vwrOJYowbjT/LlgTu3EaHCYi3TA78VVpRqA=;
 b=AP9bRSpvrl2LdJNRi4cxUXK9jP5w34qvFCIEmj2z8AQBNXYvtiI3EaPHFKne0NJmYQybPZu+t85Aebz/iCRtzVSuHQAwMxK6Mmhy1R1thTZwmrnsiTLUbimve0rHY4QvbVKthGBQMqH85rU0BPvsw4r+qK0/JSc5uf4EU7UeTK4YruVBE9tA4u6XX/Q6XTl1lfL61gcCo76AyEFQC591F9Q/LTtDHT6XqXwph9tzpJaIzf9TVsbzTICjyh1BVyXNJFUWOmvPcEefuEjYf1xrhYqvivVT9NXjhC5Q34/nl7wwTJMaT7OmyOJseTwEsLDpCZF6NWip12JGBJvFFLyGGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by GVXPR03MB8308.eurprd03.prod.outlook.com (2603:10a6:150:6e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 11:50:12 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 11:50:12 +0000
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
Subject: [PATCH v5 1/3] drm/bridge: ti-sn65dsi83: Simplify error condition
 logic
Date: Fri, 17 Jul 2026 13:49:59 +0200
Message-ID: <20260717115002.308035-2-wojciech.dubowik@mt.com>
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
X-MS-Office365-Filtering-Correlation-Id: fb753e3e-17bc-459a-858f-08dee3f98f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|19092799006|1800799024|23010399003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GTjXrkRu+qVsheLbWo0m7CuMkHRF7SY0F7VdL4W/D8Ff6ycF8dKLTOp7VNQL+WJgjMKw0KhNc19zfgu4Zi+eTp13l5r3VtqMdKF2ZfsIyYZG/q47PRrVgXXXtDInVYFNva3M/5lB8JdZEpPcAZU7L309HzU2frwJyfDgP45GN38TYhs/sBtBm+g1f3PvVvMGKnR1rgyUvnIb47XQAEwMh4NWNUAHU+IUlajZ6wvy7mKVDTNT9uB4WEXZ/ekm6TZQd/X/mSD/k6VbI1d9FfT9b1ChPG/+s3ikayt46SYGh+95LXU++ewQ4U50eX2gIyi5/mo7oNv6O+8d4cRGjkF9UBc0kmoQkVb7B5WXlffO4lUvJHsa0qHU99NGzYrv7IdHgF3miJOgBcP1P8Xgs3WyeXFdFEjr2rYgtLy5aGrAx8EEZvd7rqrGqbdytN2iM5OLlcoM0yeyPEt6C89BYPBGWFch7MlI9vPDUb/ibtXVRed1lpTjojNnbtNwhvG7N96zcJLtJrh/O5AUZagJFpk2/M3MU0r6AOQUY3b4VCcK/WQGG8SNZQ5w9AXvAS+tFKRbCIBvMYlUk5UJ+wDGLbjPXuRAo9TSXXGaZGDFZVSOVi2NtnFwDBSm0qxP4Z2+BkfUoAsF2zeUaT5VOnGlkTN/R06NDOCcBvXE5g8JzU5TYN8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(19092799006)(1800799024)(23010399003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8rGBPP4MzXsRzEU5NvsAS7fzbWaM/waE6YLRLnGZMTL5xRiT1HEaTSlXnyQN?=
 =?us-ascii?Q?cH4e/9lMx1GR3D/ODHARfBuR5n0Mok7DqGftnPVlemeyL+NAQz2guSYwdg8a?=
 =?us-ascii?Q?cWvPlXuj//ZBaonE3pM+o+c5eAImE7ffP0tT0RgDQtGl8F1lLVIqkC7XBnBz?=
 =?us-ascii?Q?451BG3F1r/9AHg8ttxEF+LPxlxiRtFHJMJpBX5Bw4D8RRMxODWWUZErmD9+k?=
 =?us-ascii?Q?rk2Pha4a8h9YRNEq4GErLkMVZZgIFN8P0NB96UQUltSYlTkEa7oNf8JqH2+1?=
 =?us-ascii?Q?uKAeFWCnWNzpb2L3zZN7htUs5u2uA3s06gx1aCYJ6U9mNtVpR8AeFJwPdzw/?=
 =?us-ascii?Q?083iTkIWemBffhZtIb5D9GcsQoR4yMI5J7ct3L6WbPJUrFrqM4QshuyIy2Eo?=
 =?us-ascii?Q?rMb7fJEWRbOLV/ED0EbXSThPX2ZoSWXomdvOS7vkimZXCs9wgF/bTG01QVa6?=
 =?us-ascii?Q?mx02iQtI2+T7w2dm8HMMrXhsm8FDJgl6FT6XltZNYI7HRgYzPj3/ajmfkRrA?=
 =?us-ascii?Q?RVKOZ61dNoQfkUyEJQDMvxX8wChfhdu2gqJbNKG03cf8MOANidNYiYZaWlkg?=
 =?us-ascii?Q?5iZ7P0/XV4rx1NNBRXcwEBC+fnbmprcqnRzqQFlis4ceFbOvntxYY3yj5c6J?=
 =?us-ascii?Q?cY/+1vlqxsTnX/3oxN0S8J6mIJZF1H0diINUfjtYK+N7KHc+iueYnvJ9ko+N?=
 =?us-ascii?Q?53lSDGTlLaCXPZr+yNhy5gcbi2mwV924ItYya1zg/FQe+VjXmFXfC7xXUmnX?=
 =?us-ascii?Q?jJ67UJUt9Wb2yGVE+UXPaGKPZpfLPSelst9mliUqXZYqwWVQlmQA3xEKsECG?=
 =?us-ascii?Q?70Kh9mcJ10SI+g7RTrEoBgwdNURxQT3insC1IaClATwDKgCf6aZwKtGv2thT?=
 =?us-ascii?Q?0PKdVYRF5M+8TUixxibWicgTpimsuuUKq/4OHT50FqfQ0lk8FaHlQn1F5+jD?=
 =?us-ascii?Q?Pfff9vuokXIPWlIPeAuQn6+uGStYZh6t9K3J/V8ePEfLn9PA06NJTvNS6FLl?=
 =?us-ascii?Q?V6LeWa/k13fF9ozFlYll/+C7rsB3Bx71/7O+0he+2mJgVeXNElcrwPeVjmR8?=
 =?us-ascii?Q?TQuUBsRHJfKSA5QuyKQvjEVCa3w6HbDdmZGHCeWV7GiDvE4Y/HCDLWySfwt8?=
 =?us-ascii?Q?fjzyuywexl5bZQuqr2gYJ1psEUQT96GKygEDtUihk4EfbdCMUXDTTtxTlp5X?=
 =?us-ascii?Q?SdYU6o68unWVmubPqX1xzwibCFLIdl9M9sMCdhhuWgV5pYaqkgIaZDoEH+yZ?=
 =?us-ascii?Q?+N5Xg1gZVMVI2OkRbqELCHFKjO1UTUg1Xzqmv8KVKeDGHAJ6kOLGYpM7dLNO?=
 =?us-ascii?Q?Td3ZpHbuofeIV+XluipWEucAw39kWTXJ18P2jONb8sSMZ474jtX90lSR83ht?=
 =?us-ascii?Q?N1po6n8V0zcCINWILebSJxmFWGptbG2H7OZ0kc1fpgWrrojLXGXY5GxwXRdY?=
 =?us-ascii?Q?ZvfHbx2Hc4voiRS7Z/Nvm5J3Q40E/e1/NaJjpyp1iErwFpetWZIiIcgHgt6U?=
 =?us-ascii?Q?GkbzDQJLrM2IIaHn8UfO2SDPXz/uRQ5vWx4WEQ/uwQp7Ws492yJXNTP4OHAT?=
 =?us-ascii?Q?xrosvVCCtbJZlXT/Mdll1UtRsRZ5TChdodqiNFwgovEagNN7GUC5DX55QLVY?=
 =?us-ascii?Q?J2ED9NfZ8L1tCD0OeYoWt3uiLmm6RNLvMv7s75oSRdiviF2urI6tg5uV+0Pb?=
 =?us-ascii?Q?lgUu+EF7018rqQcPP2qPBbL05xw9zdaKeI5LfE/5IKsb9Xh0NS+qbhu9McOS?=
 =?us-ascii?Q?Ci7srnd7lg=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb753e3e-17bc-459a-858f-08dee3f98f4e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 11:50:12.5233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+HLK6V9zYsXZ3QOwPWwuCzG/xSY0OYNGHSPxcm9noli2pgPPrMRRvIIih04N/e19zMFcK+MyT1YBPK105403Q==
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

Simplify error condition logic in lvds device tree property parsing. It
makes it easier to add extra properties without handling complex goto
entries.

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

