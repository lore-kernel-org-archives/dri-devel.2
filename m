Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830A3C44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 07:21:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D88A910E6AE;
	Tue, 21 Jul 2026 07:21:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="hPpTV+KR";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013070.outbound.protection.outlook.com
 [40.107.162.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0551410E033
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 07:13:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hULpAM2jup3KmyQrdcOGMgg/gG4UfCXdtoHQxMDJt0n7jyq5wTIBT8zhCnDAPlx2dtokQa6Ag328BzMMqmHS0vqVO1m9/Dkck5rMUgkDiWvY6hox9uMUQs0Oah6ZsLSfaCxYxP6crrpiaS9GcF4vjMAeBIDxo5vf/YEM34PoYzYprZPAuAwR4jZ0hVCZwu4+YGKEgGDQ+4UDnKgTqZenEKDL5x6JD32JcNBA0dVamPC4I8rCqkMeAHxQaIxynok7IJi/7P9+hRhrbgMCoSiBPKGNp6y5YrbFc/47Sd6933coBl73+JezUn/XWdIgf5mntTKEUEcTVq+iFTVdQ9NybA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bGwy71TT0ErkKstC5Ym1MV7/PkBEOByBqIg/zMZyGk=;
 b=k/5RZpYZKc1j8rZQKFK80IvHmxEF/oJsf88QueP7dzAQasdqsIKREKOA1vEjnWscu28GjHqX+wAhUJne28YnnP5Y8fVO9CcoA12Xs0vcaqrLwgOOO4k5msR+cRIn+FlvUMEdeIWpyc/R9RLRpSyHxcGgh3OaUvuyXuJCzlJv1dWd0HhRFwcri1/7kJRulTyqHcndFHFieVZMB2DumoLBT6Y2+Zh+mw4ghGoOs40tic9YGcsCQkp2uGf+t1rbWfTNYZXFT8flphE/UaIlefu3NZx9kfc9OttUEMN08nToPKwKPbYjlRkdUf/l4C8rTq21fNSWcyh4pHYn+LjtyvCF3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bGwy71TT0ErkKstC5Ym1MV7/PkBEOByBqIg/zMZyGk=;
 b=hPpTV+KRaSUP0b6WzVEAV/YbXGaLlLoLT6WsNun7KcDNL/4QtoggSa/qf732hur+rjlsqUzY1vl/w4tzoes/oVgoJ8WKxHfHblyAVgUvJtL08ulHZffYH44ITYRKAb5c6i9FkC0q4/9272diLJv2L5AgranG9rCH97wjMwDNIlghJ6yJainAMJsKR1MFMI40v11sj4YyGh8qQGcn4VRiCpCG741rZi8bTS1n7Xnpn7oC6Muz45UdZhnYv79sPoVOiwv+0zMqg57hJrn34tRk4cLwtJPL95tiE2nBectprtt4YZNkRo7OOsRb2i218PhouoxGPodcjw4RIQCtk52zMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by GV2PR03MB11523.eurprd03.prod.outlook.com (2603:10a6:150:320::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 07:13:10 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 07:13:09 +0000
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
Subject: [PATCH v6 1/3] drm/bridge: ti-sn65dsi83: Simplify error condition
 logic
Date: Tue, 21 Jul 2026 09:12:48 +0200
Message-ID: <20260721071253.1098652-2-wojciech.dubowik@mt.com>
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
X-MS-Office365-Filtering-Correlation-Id: 71d11b04-fc34-427a-a2d7-08dee6f78510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|19092799006|23010399003|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 2FedXgPFBAAJRIS1BwlxUH7Q0Y2HcLBF9BH0Rqec2k3zBHru/EBg+7y81OhCNjKfOL/MUonaj1b6Nmj6oG7d3yedFVzFPHEvcmquewdA69KBlgXzxjvujYxOPXuhnlYWYkV/lTV18n0WgNNO2a0Kv1Gsc9dI7L9Jwz7Od8x/OCT92U4MMQVVg93A4l0MSlCDUvb0r+LkCZTQSIz0olsQv6WSlAMYvOh+39/Ul/40tBHiHVSdh/KHzSjx5rdO3YfjwmFKF0HuVuCpkLIBi2KbZpgQ3au2kEq/oxtzd94xTfk5o+/lwabzzjeqKLD+LivX6/WFXzXZdjceP+wtZpMnF/XMlkLia9rRrPZQ/kRfAoaRsHDdkIlFzQ0ewCxRiEMtyej5DMsSmGF8WvXq2ocSOYD0BoqhNMF7kR7wQugpph3EuVTcQwgfKYJY23rvl1DFc0GNJqy05w7RUGk4gwL7TJNRNrI7of9QobEttGZQdzyo6Q3nsnBKHTHou6j/1MaeSJiwjnyV6Ryg3Xt/XHQa8LLMpeEY4n5WitRxG8JU5EW2L2G532GpzxhDfVcvMh2cEB5e5MtiRC18CDAXKqnspXQSEdgx2bkBqaiOwSwuixOFSg56uCryzuRQ/S8lxTX5ee8LVog+2+8sV5fJrx1yVhfXkFLq2vzr7/BBVeXIVUU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(19092799006)(23010399003)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mtwBZHgUlQnMv7+aboqnxNPwvt5MtPkVlpEzkvHxpSBI4cLWlq6npdjB4Skp?=
 =?us-ascii?Q?RSYTbMQ70Yx0y2Mfq8AeNP4nd56Uuys0DXfs7pWpX6L/6eYOFGUdwZV6hLW8?=
 =?us-ascii?Q?1xNJl4Bi4ZxfhFb/omqKo/dT/VNKQSTuMn9n14qH17ocIffHOGOZjJJ0bRsB?=
 =?us-ascii?Q?YQbhxNqA8Ua3/uKP0gwjpsNvVW8ViXhSCOwhwF+XViESAvuwZFqiauNYXVbc?=
 =?us-ascii?Q?apzP0SVVno29Mg74o3zsUreaVUTrxbExfGBaTnmOMU6CAGKk9+a0jJLdSALQ?=
 =?us-ascii?Q?hVTsqJFUG/xyCz2g6efeCCWvDo3Y+AHz7dew4If5cY1pN0EVFZz87GwUAutl?=
 =?us-ascii?Q?g+kd8dwSSjeNUdGLO15Tff1bb5w4Ix/7JjMxoyXM2Pd043SkuRaG2j6N3uf3?=
 =?us-ascii?Q?25HXwtSUqeAjCkNiKaFBluoctt76bs3r6J3zSGqcscFoKomeRxRGsOIveuiZ?=
 =?us-ascii?Q?FqEL0R7ZMumEXyNBIG+1h2P3Y7DRlYxh9xEF0sApAOC7t/nDZsP38rNrihuq?=
 =?us-ascii?Q?fp29ap7dl2iov8lg3WpKKdzfHn7UTF2maXuzW6Yg2rol9ErBRi/qaDbzmBny?=
 =?us-ascii?Q?7NXiF5Q9Ff+f3fmabODgXFZcG4C3zfVSQ34H6lvOcCoEyVZdqAMB/CLjg53q?=
 =?us-ascii?Q?U2LB9a+F9YZ1y4x/9KjuIuX0mnrZ1DKzP+vmsCRmm+nbmj5P8fe/hn3nmDyG?=
 =?us-ascii?Q?Z5F3mJCEHMvNl6+U0dZPr49MNAbei67utajoLQoomjufTO2RHHtmCTu2CKWn?=
 =?us-ascii?Q?a6e55w6HwIgyfb30UTV8lUiPWbOz0rlLOMjzftMXkXPv8Oeq3wseFwTJbZWQ?=
 =?us-ascii?Q?ZGey1Rl1Fr1Mj14bkCMOkwvU8AAHfHQKCDZ2dWhaTA+HeQVZ81GmoXd1Ho7+?=
 =?us-ascii?Q?zfkkMUjyTxumNJBCuAMkMggvzKpTWpr4oMvpBt6imagikYdGL55xCno1XXeN?=
 =?us-ascii?Q?2k0E+sf4PoH1ve3uFRKhyGx6PyO2igiPyZuOpcqrqmAAkTTnY9ZKv2Kbn7HT?=
 =?us-ascii?Q?xMD6Lcs05DltBCw+qhp+hiCs8i5MugWw/ejlDseR86/UCl5tHA6mqyUfQ4PQ?=
 =?us-ascii?Q?A6RFiJOcENSrqhHzmmb3oUZVG2iucTc7V9I5yofkM5mH1+LFecNfMIodjuzH?=
 =?us-ascii?Q?BM0OORarQpEgRLH8dDTwYgqkyBmJQ9X2LuJRqdsfOexanK3nGbNhmEPpdqI0?=
 =?us-ascii?Q?fDbW983eXYJY7DBFlXrMPSe3vyvohMKVfNMkh1EtzD/A5fsV7Fly9oFVSDRx?=
 =?us-ascii?Q?PWSSKhkQDP6BUjXkcPivsnWBrdGwcrAf/nOoV48LQNcvCq7exvlrzU2jsLTl?=
 =?us-ascii?Q?xbdF8d17oiYXPD7/fYOiB0dGFIHK4hhhs3yC56BCc9++gnxUjxAtsHrm++01?=
 =?us-ascii?Q?j5qiXy6OLmbI50niEmMmfvIIfOhSUHP+aor3Drl4pgC06KA1/o3Pz0FnykiD?=
 =?us-ascii?Q?R6tgV0ZtwzF1pTaMxLW77pjzBotSOZfWLf7bH2mvQlQfkq3gAWVorLr7B0FV?=
 =?us-ascii?Q?26grnTR1QB0XRh7bW7ytbfUNn+frVXLlNyI4OdGtQP3nZdzTCHfdIY5pOpQl?=
 =?us-ascii?Q?CTWGDmChuMmz7/vuQ23G4+obN0BplJ7OW2vwNlXTPJah3y5l/mF4Rdn5HIxl?=
 =?us-ascii?Q?jMyxrUqzvAUEC1IO8qxsqVThGWikQArzmYyPPZjc6nsib+MyHTN7ONpZ9xIX?=
 =?us-ascii?Q?1ucvCTXdv9CjNQIyjjgxis2yFA3R2MBvIu67mswBtfCDjjMrxMpzw0sdnazj?=
 =?us-ascii?Q?1Dfm7e8KEA=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d11b04-fc34-427a-a2d7-08dee6f78510
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 07:13:09.8650 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKEBaR7AuQW+bVjIfnRBSzueOL6qxlIJTPEp+KOk6UfwlJMgjbsH7+vUY/Za8jBza+RlXG/sGcrt44ju31dT0g==
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

