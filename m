Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE38CA5FFC
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 12:23:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D624010E33D;
	Tue,  6 Oct 2026 12:23:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lZ5dhQFT";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012019.outbound.protection.outlook.com [52.101.66.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D478610E347
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 12:23:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOk0UiyKb/oTkvRCFSEUJE84EjljT5fK3pEImKYmhubCLbDs4UFKiSWtKjSKh2IZBdTj11VKVWqW9TOGpwpvJ3jqCKunt1XCt3XB170JtpZDiHtP7mOjfwXzxZfNfVHUMNfvJcqMiHTXBjR8qAwt6olZ2J2wXwT4XhLLVvV1J3wmCe2ziGJym1aPp6TYyrVistjRP+jDTxiDSuBlcgiGGFDGv2IGCP1glTuFr9l/KfMPx5b2farFgPgF9gT0yVQWdHKSiqW/8q7fY0tc5VKgBGv25jRkTP/WAgAoyzZmy8MyjXAafPbjR2q2cfI0WCs9pEtVNLevNzXr6/We+GfNcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mV5NQ5UOaWdvcNwy7cwc3lVj7HXZGcMAGwtPodyKOs0=;
 b=CImr9nneafWv27wBcnyCNrshvG2zcCDgO38nktpFfaBGCh0SMCYNTI5GPFYe1ab8A1ATgJtypzKbuuYawErNOaAalW/57QnCdGlFXgCgmMW6B50rJfmLeLyE2bdIZdTTgFJlGcuzEgZi8lzpC2/UfdqBddKD3LC3ltsEibDuVizXHYOLugoGZkzOM8KtpKZTZSdvwozr5e++nudG3SCegPz3HUj4YG6nzgvwM5OnzhSGydzi4nOQKxbuGwG8zLgmEYd6zUtlbfN9Pl3XZlg63y+cDkVN7b5bq0mx2qmbFosSRwKQHuERpqJLLeLeZ9Gh3GYxasP/n8yl6/VVF8TSoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mV5NQ5UOaWdvcNwy7cwc3lVj7HXZGcMAGwtPodyKOs0=;
 b=lZ5dhQFTB8IfVa67R0C374rHGDoE0swDA+Wk9QhAORLbfCbty5WbLvNfcy7Os68zpleaSFJnwOQeULktj9Px449EgOFNEaDosbgLNMg+YfCsutSf33L0BuZdW7m0jwc0sT7QDBb299p98vs6tIq6HpoUwlI86OkG0HiwY2U8WYCbICWFv4bqlvStJH0AN2cA/9S5U8I0YbXFmjTjxhb5wDxDa4gMm3NhxSstboar7oesTCVW7X/p+kHG6qrm22mSIi/RieJk+YmMFr79wdmfQNTQdEXbz0x8PK6lx+Mxw+C92hTG78DEuSHW0qsh+ZX/5CMmErgcRI7dkETvJmlBFg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by DU4PR04MB10742.eurprd04.prod.outlook.com
 (2603:10a6:10:58c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 12:23:14 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 12:23:14 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Ying Liu <victor.liu@nxp.com>, Frank Li <frank.li@oss.nxp.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, linux-clk@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v10 2/9] drm/bridge: fsl-ldb: Get the next non-panel bridge
Date: Tue,  6 Oct 2026 12:21:57 +0000
Message-ID: <20261006-dcif-upstreaming-v10-2-bcfb28de0aae@oss.nxp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006-dcif-upstreaming-v10-0-bcfb28de0aae@oss.nxp.com>
References: <20261006-dcif-upstreaming-v10-0-bcfb28de0aae@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::12) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|DU4PR04MB10742:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ec293b-92e3-40ce-ecb2-08df23a49805
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|19092799006|366016|7416014|376014|18002099003|22082099003|921020|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: YZLfhXX0Tx6M+73ZnLBbedECgutDiecZs6XMV82o4uidE4LTdjlPNHUZMHyNqsF3m8DQpLNeJLsFSCLd1miMQkhig8L65GKlq37+dXftJTk/4W5ilo6dDMQWIF1lndK6Nw0kIMW4mXt1849zdrQNpslxPXEhejUkV0j/bcO1EgF0tfuj4ZbBZtbQL6KIKS0I1U2Ku5r42BvOhAq32xycka8dSyBOizFrTy24Sxj41JJmnmk/R3QuNfJG3tn29P9KzgH4lB2uRLy26DkE4eVar6lu4LgCT6v7mVU0imE40k84eVI7D8+cyVVMywny+qE99WVQqSLfwdRmcgIrXISx1SfBTlu8mXQAcZBfT/BjnPCqZjQ7hZPlKOq00QKgfa3PqzMZzytvwQJm8jzR4wWQbZyBFxWha6ZgPDX0DbdkSXjLh9hi1XZofLC3zvxxJG/EpkVywUANj+G2mdShn3SoxCc5cK70hytVbXWxXQEpU1MST9cnicSo3YhMEehhMOg3dtuTA6BTotIrqibCfnvJzcBzvrdiAntw/14GcVe/zXarZKCIeCSGbsNlLoPdR8+K+S/D7dudxe38Md17zijXl5pInhsRvSow60TkrBK2e2+YyD2BfBakEQcMN6mv6CGrtvr0HIs88ztkD03i/ykpJnpBCAJRxhEXGuJe/HLtEAqkU0PSqqMNYUkprCWqX2xwkVfCbnFAxiB12ikmxje7ZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(19092799006)(366016)(7416014)(376014)(18002099003)(22082099003)(921020)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFFqZFloeXZYZlhpQ092aVRuSjU0eEtoRlF1aWNJSDNOc1h1YkMzNlR1dnBn?=
 =?utf-8?B?UzVFZ2syY25PQTlETDFxeE90dnI2L3puM0JwWk1UYUtKUkJUeHArTVUzT1lQ?=
 =?utf-8?B?M0FJZ0pjMU9ocE4zcTdTYnBtOWc5TDBSdzNpSEdsNUM3dm5ZdU12ZG1jc0V3?=
 =?utf-8?B?VHd0bnpsbWNxM3ppN3hhVElndmFRMS96Mnd0SkVCUWpJVjhBNHNqWFRXRnlu?=
 =?utf-8?B?dG9GbTExd0pKVVEvQ2xySDlNSlhIbkhXbVNXODdXdzBNVXYxVWNUYzYrNHl6?=
 =?utf-8?B?WmlZR1NhK3VvV0ZSVnl4YjEvUWRzNFpKcklwMkZCSDFVc3JCdHBJRk5yMUZD?=
 =?utf-8?B?a21WMy9KVHArbEI1YzB6b05zaFVBZUtKZWVWVlZOZFNzakRYN0JpdWVUeE5K?=
 =?utf-8?B?dEhUYXUwTzdpcEJZR0l1djZ5K2FBLzFnbHIvbW1xR2ZiVTdFUGg1bU9YdjRj?=
 =?utf-8?B?NzAwUVR1WWx2R1ZVVndpNnpaemJ0T1BoRmwyRlNPeTZwUzFibWNuSDB4a1ZJ?=
 =?utf-8?B?c3F3VXRDOVJUQ3RXK1QrY2Vjb2xLLzhONjl4NHFwZ0RUbE1QUWZqSVFOUmtJ?=
 =?utf-8?B?QmhtaWc1T3RWZnNSUGNQek1QWDllczUrNWVIQXZRbTNBTjl1c0d3eEFCaDBy?=
 =?utf-8?B?L3k1NHdKa2N6TXhKQXc0WERCWHowMnY0bWpONUlaRmFTdWdNa2dwOHpUeEtp?=
 =?utf-8?B?c1BhejQ3Wis1M00rcUpNV1FEQlNkQWhCbDdVQnA4TXlHQXVGcHhzS2ZmR3cx?=
 =?utf-8?B?YTMyN29jb0ZkR3R1NDFEUkZDazVRaktjOGxHYzdqQmtZM3dXeklKcTFsSVY1?=
 =?utf-8?B?anllZ05sdllnbllDa0FJSGJSQUJZOFg2Z25EbWY2ZUNoSXBKNklwRTYwVzlY?=
 =?utf-8?B?d2Q1NjVKemxtNVExWGhFdktManhqUkszenVjVlZGVFh2UzVBUGhlNjg3ZExI?=
 =?utf-8?B?QzNZb3ZwRFZnNEJ5TTRTRUV2RVViemVsOGdkMHV0TmtUN2kwWXgxb3B1U2Jp?=
 =?utf-8?B?TzlyZXVnWUs3c1N3TmJ3YTBCUm5CQUlrNkZTMGVxMUxzbHc5VTJTYXJRTDNq?=
 =?utf-8?B?eVhZdDNMYkpXL3ozV2RlVFdHTHBuUlA3Q2hrR1UrOTJOblZHZXpzclN3YWFi?=
 =?utf-8?B?OUJhNmc1SHRtdTJ2aU0vTUx2UzQzM0VDbldvb3RIYUYxUEpqeTk1eXlCS1NG?=
 =?utf-8?B?WEFTTFdSdk5yZUhaRXl6NjF1SWIyZi82ZUdGSzBweUJsalZjNWlpcXRNS0pB?=
 =?utf-8?B?TEI1N2Jzd2xPMWw1aFJzQk5JbUpjLzJVeWRjci9DanFGMGpxdVRqYk43N1U0?=
 =?utf-8?B?Y1JXQUI5YWVYZ0R0QXZEcFBIeVF1QTRKMFRubGI5OU41blBWUzM0Z0xvVlJ3?=
 =?utf-8?B?M0R1TXIweFVPYk1rZjZJbE94d3hDL3RTeHI3U3hCTzV5TlQ0Nlhkc0pzWGY3?=
 =?utf-8?B?ZGgrcldtM085SHgyUHRUNEl6bjgyUUdxQmV5ZzlOT3pmYXVtdWJhcS9FdkV3?=
 =?utf-8?B?cFVNQVpTK0lVTlhZYm9aZjEvUHhJM0loTzJ6SGlFbHpEVG5MdittNzBsY2cr?=
 =?utf-8?B?KzhLbld5UXhnU24xSlFMdzZwU2V2dktiQUViOEw3UmJKaEM5RmE3djk3WWxK?=
 =?utf-8?B?SDUyZEtyc3VTVWZMU0d6dGEvQXR1VWNyTkZzaUxzRFFUTVJqTUEybXNpclNl?=
 =?utf-8?B?YnRncXFQRml0czUrRzdnZnNwMG5zSThpQnE0Ry8vU1VTQ2pXNkhmWTRFNTVa?=
 =?utf-8?B?SHMrMm0vbHd5SmMxYm5pd01jL0Q2ekw2a1RqM3IvbTBvY0U3a0pCRndKWDkr?=
 =?utf-8?B?cThROW9uNGtUYUdpL2xxc2Fma1BielBxVm0ra3RQa0VmMnRwcUdRMHREd3Bn?=
 =?utf-8?B?Y1o0TTRkQjR4NDZZQVh2dTY3VGt2UEU5b1V3VjJsOUdOclhQNXZ0TUdDcGJo?=
 =?utf-8?B?UFRZYk10NmZLdXF4OFR2YnRsTldiRm5RS1hrZDE1aGJpbjNvelAzZ1VPNWk4?=
 =?utf-8?B?QjdPV01TYUM0V044b2lYSVA3NzdUbitBMVB2K1JqbUx0dFA2Z2NVcEtFdVVw?=
 =?utf-8?B?YjQyT0w5S1JZeHVrbEdxSGR2MGlaZE5LKzRmc1FBTElYMXVocXd0NjMyZzFZ?=
 =?utf-8?B?QlhqMkpuU25NZzZxbTEyU3FhSmV2S3NVNldkR1N2VFRjUFhkVzFXWWtoTmh0?=
 =?utf-8?B?MSttOEVuS0dzTUpweHQ4Q3dWWmVMSzdvTTFDcVMvSG5hM1laS3luSURMcEk3?=
 =?utf-8?B?NTMrSlFpUVAvTVdHM1pFSkZJY1VROTd0NXFveUpjVk5JK1JibVBzN09nVG9O?=
 =?utf-8?B?SmVqaWdlQi9WWi83QWtjUWpuSUFtVlltT0ZlL3EwRWcvWGl0R2JMOUFzYlp4?=
 =?utf-8?Q?NzcW+3A2L7Axf95A=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ec293b-92e3-40ce-ecb2-08df23a49805
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 12:23:14.3672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZi1GXo1RfkncALwm9vTxdwpwsnH2jfc+FyzKGte6f8Tny8oBEa+jXotEWMp/KY6LjD8iMuI/EOGc6XflDkJ2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10742
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

From: Liu Ying <victor.liu@nxp.com>

The next bridge in bridge chain could be a panel bridge or a non-panel
bridge.  Use devm_drm_of_get_bridge() to replace the combination
function calls of of_drm_find_panel() and devm_drm_panel_bridge_add()
to get either a panel bridge or a non-panel bridge, instead of getting
a panel bridge only.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 drivers/gpu/drm/bridge/fsl-ldb.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
index 7ec84c81cd786..52ae7f5b63c7c 100644
--- a/drivers/gpu/drm/bridge/fsl-ldb.c
+++ b/drivers/gpu/drm/bridge/fsl-ldb.c
@@ -294,8 +294,8 @@ static const struct drm_bridge_funcs funcs = {
 static int fsl_ldb_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *panel_node;
 	struct device_node *remote1, *remote2;
+	struct drm_bridge *next_bridge;
 	struct fsl_ldb *fsl_ldb;
 	int dual_link;
 
@@ -318,19 +318,16 @@ static int fsl_ldb_probe(struct platform_device *pdev)
 	if (IS_ERR(fsl_ldb->regmap))
 		return PTR_ERR(fsl_ldb->regmap);
 
-	/* Locate the remote ports and the panel node */
+	/* Locate the remote ports. */
 	remote1 = of_graph_get_remote_node(dev->of_node, 1, 0);
 	remote2 = of_graph_get_remote_node(dev->of_node, 2, 0);
 	fsl_ldb->ch0_enabled = (remote1 != NULL);
 	fsl_ldb->ch1_enabled = (remote2 != NULL);
-	panel_node = of_node_get(remote1 ? remote1 : remote2);
 	of_node_put(remote1);
 	of_node_put(remote2);
 
-	if (!fsl_ldb->ch0_enabled && !fsl_ldb->ch1_enabled) {
-		of_node_put(panel_node);
-		return dev_err_probe(dev, -ENXIO, "No panel node found");
-	}
+	if (!fsl_ldb->ch0_enabled && !fsl_ldb->ch1_enabled)
+		return dev_err_probe(dev, -ENXIO, "No next bridge node found");
 
 	dev_dbg(dev, "Using %s\n",
 		fsl_ldb_is_dual(fsl_ldb) ? "dual-link mode" :
@@ -339,10 +336,14 @@ static int fsl_ldb_probe(struct platform_device *pdev)
 	if (of_property_present(dev->of_node, "nxp,enable-termination-resistor"))
 		fsl_ldb->use_termination_resistor = true;
 
-	fsl_ldb->bridge.next_bridge = of_drm_find_and_get_bridge(panel_node);
-	of_node_put(panel_node);
-	if (!fsl_ldb->bridge.next_bridge)
-		return -ENODEV;
+	next_bridge = of_drm_get_bridge_by_endpoint(dev->of_node,
+						    fsl_ldb->ch0_enabled ? 1 : 2,
+						    0);
+	if (IS_ERR(next_bridge))
+		return dev_err_probe(dev, PTR_ERR(next_bridge),
+				     "failed to get next bridge\n");
+
+	fsl_ldb->bridge.next_bridge = next_bridge;
 
 	if (fsl_ldb_is_dual(fsl_ldb)) {
 		struct device_node *port1, *port2;

-- 
2.53.0
