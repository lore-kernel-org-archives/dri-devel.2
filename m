Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F88CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 11:59:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E446B10F45B;
	Fri, 12 Jun 2026 11:59:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="w4op48/z";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011023.outbound.protection.outlook.com
 [40.107.130.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC4F110EA1B
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 11:58:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wE39NFqUbVfxuohF6cwU0JxwgElaWUTre4+AIUqFxd0MVF9BFSeamfsNuxcgccN+cDI7TYaXxJn6I5Qzo7QMnrSATmEhYu4vVNc5+0L81M5YCucO4Jv/ElcuvXWqHxD/xWJXJEQ3RispTUagwxZukd+2OIkReovGeF/+OrQOs2OZJxRNv2bi99rYIJ/pExpoolVUV9RQT6NwXELbHjGVLqRBkt6SthH/b1LReWCMXg/G0Ic7i6++hbE4QRsWhaz+kZD6T2KYKZUIrX8rjmaXhGgf2Mz1XkbtITDnAezpgRAPOlLTN+wi2b3HSjFP2h0oy7jKzSNeV7+t172PWKsaJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaaWcbZ/67o8w8elnb4q1GWHdADROOHKCjbaDP9WJwU=;
 b=UQbBYH2XYhYMRcX3UNXgwLJ5WnT9HWVMqgAyuQRTnIlCURPA4kuWdyh+EelbX6zWoE9k6Q1CwIe8EQtuHc2C1Ymsvv8fuvNevbttfJ0/pyTpkfDlSK3hzmBX4FIAUSOzw50G3C00qKpdDDK9DjHz5KYCwyDZD9bGwjgoM+PbAEhT8BYwI3J8vYQAM9Unnvw/+1pTS8GPl2GTBOfrubSLhtDssc89TsPVbjvnjYZlhP5lY5taT5tBDw5eG0ENiQVaL25gVDAabmqqnSMfqW2YN3UGBet4AOsl/zEBq/2FNynQ1XRYKF2wgaMoDYljk2f89cgEh8qnxnIfibO3i7T0Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaaWcbZ/67o8w8elnb4q1GWHdADROOHKCjbaDP9WJwU=;
 b=w4op48/zUnUxuqWqgTez2ROFl9TsZaA8Mi5h7PiVu+0lM3at4oErm+xOPkT0lXGNHwM2zj9sQPJjEI+rtPB9mQyZMGQ0EiLz+jZknb5EAeN4TIZbczoDpTehW7JR6tWznN69swstfu/fOwbZAqcln3cFjes5xCEhzcdSHN5O3RQQIssa5YZoypufP3Vj+Oj+RFkGdL3sFxE9cwE2gnh64qqpGrn2vo+Dyh1tWQWODMgUN9GZIZmnECdHzTw97Y2e+Q5cHj8gT0Xh2XScM6qDhkudo94XlOP1G7oS8S2jaRW+SAEwc2jSnqlOujv5MrB1o5BAPn4zJWq3UutL7RRorw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by GV2PR04MB11710.eurprd04.prod.outlook.com
 (2603:10a6:150:2d5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 11:58:54 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%5]) with mapi id 15.21.0092.010; Fri, 12 Jun 2026
 11:58:54 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Ying Liu <victor.liu@nxp.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
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
Subject: [PATCH v9 2/9] drm/bridge: fsl-ldb: Get the next non-panel bridge
Date: Fri, 12 Jun 2026 14:58:33 +0300
Message-Id: <20260612-dcif-upstreaming-v9-2-8d0ff89aa3c5@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612-dcif-upstreaming-v9-0-8d0ff89aa3c5@oss.nxp.com>
References: <20260612-dcif-upstreaming-v9-0-8d0ff89aa3c5@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P192CA0032.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::15) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|GV2PR04MB11710:EE_
X-MS-Office365-Filtering-Correlation-Id: c60f3e92-cc04-4619-3da6-08dec879f9fc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|23010399003|7416014|1800799024|376014|921020|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: TohJrzni/Y1XxhMp5XmnxJeKQ/JyFARjIuULj1n2V+LVYmus8asgvWLoW70jVcMBitxq4ckRUZxiZI0UBJyrkB7+0tCPH7IbMLBPzUan1j/ZdoDxpMDShSmmTRxTNiRsh64q1QqUEYXnVkLa3zgqI6TP8BmMFrvMPmFF8iZupLiRmOMG0t1RlcMdpPz6nCMnj+scBZ839r+cqYRDO+XHcLk6tLdE1BF6VbBIDPM9mG8UnVo7hUnVp7W7BP2i54myTBypphRMDPYwuQR+cI9goJrg1vRjQMiu4Foe7zH8RGpH2kvar3ZS981YOSFBRYAf3xgCPT92U41cyFmksWiyOoheL0n9Zr5VeNjGLepJaydsaYVzWVM20hjLNQHNwnelUbCt5l1jPbJtBIngJuUkoQCLig1Q/nd0h99nD8iZol0QqvlkvicNmQhlaTVU6UIiQF/vflPK9kZV47V3ee+pBz7DVRzAlw+k6KlTCOzHPEQ+RvT0m7M9/LIzSYPNfP3UyAdpFojZM/AfgkGFkF3GlHlyPs72zRYF2uGaJkC/RyfrGRefNHtxD8qKLq+EX0NR+UjDPWohzB7YKkyz0N48p4m7+5ooy/NPOrGw50KtgxO4cfZeXkQ58JDCIglOWMCxAh114Ytj88H1x1/1zrFDu4tzEqNpk7WBoZksVmSg7b/etj5JyvP206cJ6xKVPcFIJ/HacrtCkg09JxWvAfz4zUZ9/tPV7xe3KwRUh/H2jEw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(23010399003)(7416014)(1800799024)(376014)(921020)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnplMjRxZ1ZPVFNrckoydkRPY3JYNzN6d3FHaUYvTzk4MnF1d2h6dDNpc2JT?=
 =?utf-8?B?WUdLQmNmZGEvQ09VQ01URjcrR1ZaQWhFZnh4RG1RRjVJRGFzUW9qcVBvcWw5?=
 =?utf-8?B?WUw3V0l1Y1FGcE51dk04YlFEckVmRGlyS2VyYU9HVkxRL0xqWHNPaVI5bk83?=
 =?utf-8?B?cEVWaisyK3VYOWFCczBUZG81YzNBcW5Ib0NKaEkvYlVwK3RaTGU1Rm5SdG9N?=
 =?utf-8?B?VzhLdlJrUHhtOVVRU2ZLcW5nTkRYOGpSUFl5TG85c1ZXQ0tzdWwrT2NPeGZq?=
 =?utf-8?B?OUpUOFZiQmdUTzFEdmJjd2pnTVhCZDZGUUFDajFsQk9SUGJUN1IrclNjYW1M?=
 =?utf-8?B?dGsvb0owWUJlTndKeUUzUFYyNE9DcDBCYXdzODM0YXBVTWErYWdmWmh0V3Z4?=
 =?utf-8?B?M0ZwNEVKWVF0OTA4NlM2UWlSOTErN1pBYncydmRUZHBVV29odFA2QlNMMEdE?=
 =?utf-8?B?eDdTcER0bkQ4TXNZbnYzRjBscmNaaFM2aVF0SXVuZWticyszUTJ5bVVZL1Jl?=
 =?utf-8?B?K2g5ZnBjWEV1U3AzZWF6R0tQcHZMVTJyYkpqUlJVSnhQN0I5YjZWaEU2VDB0?=
 =?utf-8?B?WThaWmprNHV4RFh2ZXBZbk9hUHZWMVVBaC9sczFlcys0a1RhQUJjcy9lOFA2?=
 =?utf-8?B?dFBBQk1BcDcwdk9uRkwrUitjb3lrbHQ1elBNK2g2TnBiWEVROVBTZjRGK3gy?=
 =?utf-8?B?TXVsM1hFRXRXUEp1eDRZVWVaNG1TRnRwS2V5STBQcWhMS1phMHN6VEFtNnox?=
 =?utf-8?B?NkZSWjk1U0cwSFRKa1VCTFZtLyswNUVudkRXUUt3dVRvRmQ0ZkJmVXQyZml6?=
 =?utf-8?B?c3hNT0FYV1VBd0t2UW9LZ1RTWUxxdHlnd2huUEUrcDhvdlIyMkZGUDJJeEdk?=
 =?utf-8?B?OTdzMTZnUkw5MWZvcXJDZ1JSSDlrekUyVHovY1EzS2J0ejFIUWNkOFJSc293?=
 =?utf-8?B?UXRvUUtyQnB1ZFdrTCsvR2tMdnRIQ0Z5eG1XbEhCbHpnaHhwc2JCY3BmVVFN?=
 =?utf-8?B?RzlwNTRyQUJaSzdpSlBDRFp3aWZOaGUvZG9rUjhnLzFhUTY5MWJQaTV4Wkxa?=
 =?utf-8?B?YUpMZ2p2QnVmSW01RllWTWk3dmZRaXRtYysxYU11TzRMQS9ZcU10RW40RDJZ?=
 =?utf-8?B?ZDhtWUFCaVlFeDFhYTdwb0R2eW5Ca1JnaGRSeFAwOVhsclRmT3JhcjlPeHR4?=
 =?utf-8?B?eDYvYi9MSElZSHFRVnBWaGpJcFZGdlFrK3EwWWpFV3RXSzJxVXQ2SnlXWnds?=
 =?utf-8?B?cnVpQVR1disxWDVxVEFMSFZ2L0J2RXVxUG1oRWhXVVFuK2t6ZFdDblBMVmhq?=
 =?utf-8?B?Qi9aeWRSZFQ5M3VBSnVHb2NpdnA3bEl1dDlmYWdIRGl4VDNtVHM0cEdRWDFE?=
 =?utf-8?B?ZENMYWgzSU00Rm1kbTg4aWdQUmMxS1hKR0FyRHV5TTRJNjZrbkdvVFB2Nkl3?=
 =?utf-8?B?TUhwTmtCL0VQd0VYT21yR0xlYVpPeWIrUzJjVFZ2dHFLeEFadEpLNjljNUE0?=
 =?utf-8?B?WHJncTZzVkV5RjRiMVYyTXJHK3YxbThqb1FjTGJoQTB4TE9VTWxGZDE0b2pa?=
 =?utf-8?B?SllUUFRlRDI0czI0a3RsU214Um9SaW9GeEpvOWpnU3lxMklGR2FQSXlmL0FT?=
 =?utf-8?B?VlpDNDB2Q3RwWW5rMnJISXQ4NjE2VGJ4RTZzS2FGOGEySm1VQmhEY3ZuWGsz?=
 =?utf-8?B?RkxoKzNsU25EVVJ0VnpCTHpkRFpMQldBcENYOXZMOGJnd0lEYW00UjJXUndX?=
 =?utf-8?B?RS82eThiZDZiUVdGNUdIZUQrU0lMVHFReDVEYmhWMjZhOUVDWXRIYUlwVWph?=
 =?utf-8?B?ZmczalllQzZaM2cwV01sN1ZrWFBtaWhqL09rNDRERGRsMGJaRnEwVW1DbjNN?=
 =?utf-8?B?b0IrbkRROGR3eFJmRGdOdHNkMEVGZ29kVWgxQS9pWTE2TGRUMEJEWGlhbHFT?=
 =?utf-8?B?c0hyZWpLRkFHYm5ZWUFhSFA3ako5cFNyZDRSTGpTNFYvUFFXSXJJVzVibmlx?=
 =?utf-8?B?cVlHeStMQ09UWXE2ckFoTlkzM2VCcEdBSmRSbWcxRy9WQnc4N1ZDaWtXU0pP?=
 =?utf-8?B?OXVxd1pMcW4xVDdkbG12M2NVcWJWWjZmeHYyejFHakltd0g5dnJWb2hXeThJ?=
 =?utf-8?B?dzBzL1ZTVUYreXp3eTYvSitCcXpEc3V1QS90UUZuQUNmaE1QWllCUXRsTGxT?=
 =?utf-8?B?QThJYlVnZjVxb0RJR01kRlozUG10R2NOdEJTeUx0d2w4cHdDUG14YmF0Z0t6?=
 =?utf-8?B?ZXBxYnRoWWxIRzByTmF4ZnlyUjF3aHFpNUVsWkpab0JSK0ZnV2hNOVhYWmJO?=
 =?utf-8?B?aVZaZjN5c2hMdFpmYVlFdVA1ZEIybDhMaDhUT2RxM2xrMDJxWG5mclpBTDhq?=
 =?utf-8?Q?HvLEFFBdq4VX/Ty0=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c60f3e92-cc04-4619-3da6-08dec879f9fc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:58:54.5732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HbTKNGlTUrUM76qD8SzFab/WyYqI8wpO9bW8dA2kgcWKiC+eIKbQQAYGW/kCynVWi61OdbbuJTqryrj6+KjTKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11710
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
 drivers/gpu/drm/bridge/fsl-ldb.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
index 9bfaa3f933709..bd03c36ee696c 100644
--- a/drivers/gpu/drm/bridge/fsl-ldb.c
+++ b/drivers/gpu/drm/bridge/fsl-ldb.c
@@ -15,7 +15,6 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_of.h>
-#include <drm/drm_panel.h>
 
 #define LDB_CTRL_CH0_ENABLE			BIT(0)
 #define LDB_CTRL_CH0_DI_SELECT			BIT(1)
@@ -86,7 +85,6 @@ static const struct fsl_ldb_devdata fsl_ldb_devdata[] = {
 struct fsl_ldb {
 	struct device *dev;
 	struct drm_bridge bridge;
-	struct drm_bridge *panel_bridge;
 	struct clk *clk;
 	struct regmap *regmap;
 	const struct fsl_ldb_devdata *devdata;
@@ -119,7 +117,7 @@ static int fsl_ldb_attach(struct drm_bridge *bridge,
 {
 	struct fsl_ldb *fsl_ldb = to_fsl_ldb(bridge);
 
-	return drm_bridge_attach(encoder, fsl_ldb->panel_bridge,
+	return drm_bridge_attach(encoder, fsl_ldb->bridge.next_bridge,
 				 bridge, flags);
 }
 
@@ -296,9 +294,8 @@ static const struct drm_bridge_funcs funcs = {
 static int fsl_ldb_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *panel_node;
 	struct device_node *remote1, *remote2;
-	struct drm_panel *panel;
+	struct drm_bridge *next_bridge;
 	struct fsl_ldb *fsl_ldb;
 	int dual_link;
 
@@ -321,36 +318,32 @@ static int fsl_ldb_probe(struct platform_device *pdev)
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
 		fsl_ldb->ch0_enabled ? "channel 0" : "channel 1");
 
-	panel = of_drm_find_panel(panel_node);
-	of_node_put(panel_node);
-	if (IS_ERR(panel))
-		return PTR_ERR(panel);
-
 	if (of_property_present(dev->of_node, "nxp,enable-termination-resistor"))
 		fsl_ldb->use_termination_resistor = true;
 
-	fsl_ldb->panel_bridge = devm_drm_panel_bridge_add(dev, panel);
-	if (IS_ERR(fsl_ldb->panel_bridge))
-		return PTR_ERR(fsl_ldb->panel_bridge);
+	next_bridge = devm_drm_of_get_bridge(dev, dev->of_node,
+					     fsl_ldb->ch0_enabled ? 1 : 2,
+					     0);
+	if (IS_ERR(next_bridge))
+		return dev_err_probe(dev, PTR_ERR(next_bridge),
+				     "failed to get next bridge\n");
 
+	fsl_ldb->bridge.next_bridge = drm_bridge_get(next_bridge);
 
 	if (fsl_ldb_is_dual(fsl_ldb)) {
 		struct device_node *port1, *port2;

-- 
2.51.0
