Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812DCC44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 18:35:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB96210F105;
	Wed, 15 Jul 2026 18:35:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HFtyMxGN";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013011.outbound.protection.outlook.com
 [52.101.83.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DA1210F105
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 18:35:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ni/DcMWrTFZxjd3py0FDTzbiwjOl2CZzhh2nPBuszNeyxKGCk6VAYuQ2ITb1QFUSK3r68haQKsSZ0q2NQOlcIqcm9ZRvHdlHep0SOlRfGcBParj/7ANgFXNEC0JXfszmoOnRUdk9bRbJCBd9kDCmM9oy/s+I0UqytU3Colyzap3sQx8oLpQXV2EiOxwp12vgVYsXel7JTwAdc37IvwCEvc0oiIaBU/TOFe487vmFHGJnrxOp+8IVHRpJuqjnn23RAL/hhdUXhDFrhcaSpZOE1ONImJvDF0Mm0R9WvVfdNsib7PzqoW4/BljC/7fk8lJju6gN0RyF80iQuPnZWgGRxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqsQu4D8ARZUUPlV+hivL9SWLh5PN2zkxqcPPjvGbjs=;
 b=KWBaboei5lZz1fBpXGtf9urQvUmtwUrXMhAKGgEJ+kJ1gcSwWTjv6R366nSAOV095Wi/jdHfAf5z8JOEFY5AdgMf2j934UHLDDiG5b4qnV5FilDEQHt0CrSFPx9zRm9Xo/F1vhf/i0mEpAV5hY1hbsIHA6jWmhZkLdqDqonxINS3hlMHRv4UPnpjSYXgMsPK7erl8ii+Wc74RmQF+v+MoiNIoHGFkq9gOmQrH2QR6qu9Jxf4ADu72mPrTKwETibfujXFtCIq95FHayidp4fDcCOORFmKvopqm2P5u7BYe7wXokugvgXEU589V+kI+16Vmj5y+YH9OkMUJy0Znvg0Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqsQu4D8ARZUUPlV+hivL9SWLh5PN2zkxqcPPjvGbjs=;
 b=HFtyMxGNrxsr65P2Q72mHEpsSiYu7J1MwEapsjaaH8m52+N21dKItbPB0JLsWG1GrgCEPgnRxQOLKJFGkvjGqCa3FYgrBP6LeXS7QE39dQhV5FtJs7jfHN5ZkV6YeKtBvtBZKmTE3S3usxgq2tHTV0Rw9Y77PoPzl+uOVda8D2KNgLETAcY6rXXJnTr09BT2evhO1KE1Fusww1lxvEriiyctaBkOJp8pywsqIZN4VIUbH8G/V6cbLwTE8ZuNr5G5hvWNsx+wmXC0bC/w4YB2SiSUQUxhPHX9JlUfoSBw//qeE8RGOVXu4O+kwmxZWVPsXleFcBjz+dk0E/DMR8AdoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by AS8PR04MB8359.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 18:35:05 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%5]) with mapi id 15.21.0202.018; Wed, 15 Jul 2026
 18:35:04 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 15 Jul 2026 14:34:47 -0400
Subject: [PATCH v2 2/7] dt-bindings: display: simple: Add waiken,101wx001
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260715-dxl_lcdif-v2-2-da797562636e@nxp.com>
References: <20260715-dxl_lcdif-v2-0-da797562636e@nxp.com>
In-Reply-To: <20260715-dxl_lcdif-v2-0-da797562636e@nxp.com>
To: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Robert Chiras <robert.chiras@nxp.com>, 
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784140492; l=1665;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=sP53lVYPOMnQbWKcGkGP8VAV1edtwxOeLzkYThF+zUI=;
 b=BbIivrYokDu7rxdIgEmeExiFstv+yJk8v0npWc6ZV2jC/grXQkeYxDwMWaGwVjFKFZjZq2o5G
 zP/mA96y5HzDloLVdriNdxOe0JxclzteTRK13dr91YGbXsXQM/spJom
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::25) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|AS8PR04MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 183f5cd3-a626-4d63-3b44-08dee29fc9e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|19092799006|1800799024|23010399003|366016|56012099006|11063799006|18002099003|22082099003|10067099003|921020;
X-Microsoft-Antispam-Message-Info: 0ygSzayrWJ6D9xeWA0mimbMgnqqpgaHVahkkjcgm6p7dp9WV35h/uLwOuCmNfHvQKLV3WtDjHw87Sr60Lf4QpIWb8sPvVk9O1jnrdKUklC74jqIBu++WOr6itvZL3PgXwwu027Lu7GHIvQN04XU9nedawrm0de5hSLcBAwJZ6pgGcwV12UzK0kTlMIYnyOsb3/PqkORIixTx2F2VBYr+AF3SskkLF+NgHaXqjxqKQqeme9/+j9zFHeSagqmSwKEf1st5ml5DniB/mUE0inl8Yd3YNwqFZF6wRf4jQ0nXbQxslrRqFYAlCinGRLMuE/UwoAQfqVd4WYQRZS9NFaTCdRyRMupSH3ys2P6T4clLmKK0EiyLB5vVeAXdM66USGxwb6breb79J/Zn5j8gCSo6Uzfu5ocX59WcRynHN+m2064zCWtDiC83cV21Z67OfJqwUkMGbxcyqXp+aHBkyYZMWcDZi84cnuYtDFTkO+gO+xIGyvCGqErcGezXLSs9YbzkSy9pUWa6ZP9rTiYmWlR+tCPTLuDWjZ4UFyjOUsGad9d2uD6dMgHDVfzfdHnql1rg0c/c6Bd18iUKo8mA+RS2ClVayEf0Fx+EHtTlMH0v0ojyUoyN63DtxdPXaXlViYki/Q5iGn4+pt/sku4hVqFE6B3iSUg2I0E2jBOWeNRwxvr8nw+S5LPn7M23kfIfBi/SeI+7UwI5b8H3ESYE/kSaHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU4PR04MB11791.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(23010399003)(366016)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVAxQUl4djRxdC9GdWNCd3lTRXVlVS9jeG9JZTFQRmltenNIOVFmdFAydHA0?=
 =?utf-8?B?K3hraXZkbURCUlNQSDFUZExrSVdHSzN6K0M4bG9hUHptN2NKZmhkN1lPbzUx?=
 =?utf-8?B?NmFsa3c1T3ZBY2hYWk9ITHFsalBVeWxxdW1lblVOeFlSVkQ5ZDB1OEJESHNk?=
 =?utf-8?B?MEJNSGhseWx1WVFtSmREQWE5RXV6SFFGYUI0MXY4Y1NjQlRuQitkUUM2VGwv?=
 =?utf-8?B?OVI1SjRYWnI3SXZNVHlVYXNZRkdQWHR1ZUF4VEo5aFFWRU5ybWVEUUoweHY4?=
 =?utf-8?B?RUpMSDkzWllaZUNPMXJsd29aU3RjYUxvOTFZbis3TUF6anlCOVZrd1FkZ3Bh?=
 =?utf-8?B?VVB1OVJWK3FLUHI1Z21sQmdNZEQ0N1ZSK0cyd3FQeE9aMVl5WmI2VnUzZm1Z?=
 =?utf-8?B?bjBuQi9wQTFlU1d6MkE0NmpXZU45bzFtRHVGaDM5ZStsZ0RWajFEMWNQSEJq?=
 =?utf-8?B?T1lPRmNuUWl1aUhsckJ0YXY2RVFES3dLaExabUtGd1gyR25EZkpkZm43WGZL?=
 =?utf-8?B?V2JZbkZrUlpOM0pmTHdHU013UGI3akJ5dzR4R2JSeUQ5TnBSaW1keEh6UHV4?=
 =?utf-8?B?aHU1b3dVdC81YVJyVUZ3UUxjcW1FRHFRaWwwbi9YM0pUQlF5RmdoY25FbC9a?=
 =?utf-8?B?blZDZXBRaFp6WWh6Z1ExMlR3TEEycnBiMkdncGVSa3JCUjdEenJ0Y3V2ejFV?=
 =?utf-8?B?MDdROVVxeXA5YThubDFqTFFWRFlrZG9PaGpTeEdvN095aHJVSDk0bWRLbGpJ?=
 =?utf-8?B?Zi9aNmJkcXZjM0lLSmlJcDZ5SzlNaCtjNlRaMTVvN0tab0Jyc2JnNU8ycTZj?=
 =?utf-8?B?UzdSMWpyQjd0M2phN0xvZEFUNnhTcC9sZFRIYjhURmVHaVFobStOVmJveVRt?=
 =?utf-8?B?bmI2K0NXdDQ0Um9FMUp0VlhyS3FlU0RsODRBNFBxa3FQV3pEUnVwK3Ntazho?=
 =?utf-8?B?L2NYdlUxejNNNjJuKzdrbXEvSmdNY2ZsOWlqbXErYWZ4WWdCTDBReko3UHB5?=
 =?utf-8?B?Z3Vlck45enJrYUpTZWtaK0R6cVhwbnJkOEJTK2QxQ3ZPSWVrNHZNZ3FWejZF?=
 =?utf-8?B?MHdRWlpnMDgrZGxyLzhXTmhseGd4YnArdVpYSEFEZyt5VDNyNmxZb1hZbU1v?=
 =?utf-8?B?ajdybnhTWkwvZVBCM2RVVzlqZnVxczBNdmJEb1lpckRabVNyLzNVK3BSYUJI?=
 =?utf-8?B?aG5xbmFOMHdGQVRReXd3MXhZUHY5TDNkSEtPV3FqS3doNGloOUlBdjd3YW9a?=
 =?utf-8?B?RXpmYVFCWUJaV0VWMnZDWEJsYWZaTmpPNlViOFh3c0ZFdTRjSXBrelFTOXY0?=
 =?utf-8?B?TjZmaWJhZGtIb1c4OE9ySFB6V05FZ2N0akp0bmYrcDI4ZHhGVUJSdGhSdDFO?=
 =?utf-8?B?UE1LSWZNTDRuT2tCdjhKczIrdEJoeTVaUFFpQUVFWUwxemJrUVBCanFFbEZI?=
 =?utf-8?B?RlRncDNYbDRPSm9PeE5mbFNqZ1lnZ3BsR0gzU0xFNXhQUkxUUXhjM2RSUFR0?=
 =?utf-8?B?bmRJcmNGd1RVWmQyeTNlOHFkTGhpN3Rjc2s1dTdFWDVuMmtVNm9aWWE1dnA3?=
 =?utf-8?B?Y2ptd3kyZ3JzNDdSLy9LcmtRclAzOElOSjhXWkhrNW8xUVE0eUd6c1JUSm5U?=
 =?utf-8?B?akdPaGFuSktsUmFta2VPRXNRbWRpOUZ4YjhjY29zdnA2ZVN1MWtCelE4ZXI2?=
 =?utf-8?B?cis2MHkrYjlOcHZpYXZpN0JIdStrYittTHNFYjZpY2p1TkRid3RKbzcydFQx?=
 =?utf-8?B?T2RPeGYxbFg5QWpIT1JRam1sc3c3YzhkVlJYWDc5NC9JTkFZR2hWL2xjeGg3?=
 =?utf-8?B?MHhUbDE2c00zZ3BSVVJmRkIxd1R0aEFyWWQ2VWx0ZzYvWW9xaVFGT3FINFQy?=
 =?utf-8?B?TWFuNzEzMHFzTEJTYVZoWEE1cnZFYjRjQlNJOGRBY0NWY0wzcjlrL0FPWUp2?=
 =?utf-8?B?YXpEQk5EZjZmU0xCdURnakdLVEt2WUhLQlFpUEsxR1ZudUNnd09MVDBabTdy?=
 =?utf-8?B?cVQra25YeHQ1d0Q2R0txRTVDdXFXQ1dFbzlPNVVUaWFobXdSb3pBK3lwcHRh?=
 =?utf-8?B?NnQ4WnY3WUpvQmEyQXdnb09qbCt5WkJoZEV0Yk9lTEFwY0MvTWNlTnVQTU0x?=
 =?utf-8?B?ZVQvVm94Y2Z2bGs3SDhXMjFQVXd4eFZlZHNYbldzaXBBUVU1dkdhbWk1UG5N?=
 =?utf-8?B?dEFPV2kxWkMrWGVwVytpSG5oUjY3aERGOGtoNjVob3JJRUxCTUdpdlRTY2RG?=
 =?utf-8?B?cG16UEVMZWI0T3ZpeGlNdGlHai9NKzhnQXBVZGpWTWJXZlRqVm1CQjdGYzRu?=
 =?utf-8?B?YzVuUWh4dTNvYVZRYTNtUEFqZ2g1S01BdlBRRmhpQUNxTFNxYkdWM05JUUZK?=
 =?utf-8?Q?qm65CkUvap8buIHnVu8iXi9Ig5IX9VMFgM/Zk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 183f5cd3-a626-4d63-3b44-08dee29fc9e7
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 18:35:04.9257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVNev2KreYw2g9m7nFgY6P/ZmYloKYCeIDfKZFJqSLBXhK6a9rGI7l21Sa87QAlF4cW651Gq60RWxvlNO3ZXQysBwB2LaSm1nb+b+PxBDY+YwitePGxbutiDG6RU4wL9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8359
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

From: Frank Li <Frank.Li@nxp.com>

Add WKS101WX001-WCT panel, which is an industrial-grade 10.1-inch IPS TFT
LCD capacitive touch screen display module.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 2 ++
 Documentation/devicetree/bindings/vendor-prefixes.yaml            | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 21453f0d7ce22..01da44ed3e20a 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -349,6 +349,8 @@ properties:
       - vivax,tpc9150-panel
         # VXT 800x480 color TFT LCD panel
       - vxt,vl050-8048nt-c01
+        # waiken 10.1-inch IPS TFT LCD panel with capacitive touch
+      - waiken,101wx001
         # Waveshare 10.1" WXGA (1280x800) LCD panel
       - waveshare,10.1inch-c-panel
         # Waveshare 11.9" (320x1480) LCD panel
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 396044f368e7c..38d6765ed62ed 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1833,6 +1833,8 @@ patternProperties:
     description: VXT Ltd
   "^wacom,.*":
     description: Wacom
+  "^waiken,.*":
+    description: Waiken Technology Co.
   "^wanchanglong,.*":
     description: Wanchanglong Electronics Technology（SHENZHEN）Co.，Ltd.
   "^wand,.*":

-- 
2.43.0

