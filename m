Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD18C4451C
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 14:45:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9727B10E5A4;
	Sat, 18 Jul 2026 14:45:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Z0xjqB1x";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010071.outbound.protection.outlook.com [52.101.69.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF00010E5A4
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 14:45:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NtnksAGk2xdcS0025/X/ozBbsUEPjyUn1chkkVzkJEJCUtAYkIJJRHfbaaeucGrhp4POY8O5ABv82eaqZuYlVyxj0kCItGG6MVVzJb+pZPQoGnqI95O6fPsT/xkxr4jgfcbx1j/ztp1ZeAFgi3UpLKOFpzWlWmNaQ1X0zx7+EmL7INyDtFS2ZILQwzVbq3uhAhys70lurSvXTJ/qMl0GgEQcabiFPVlAZUwTJ/OXgtjQRawBxWuU9+PCyPN4f1IEXc1jT6yrCzfdIXpe4H0myi+f648taitSAnrShy+PrEd4GwWp0nJ7Rs7vdY0UH3ryHcYHid9vso4nJ7VD/6RcOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOxZ0WN32xPCAaKqxghWqwZ4xVRw2rWr8HaYUb3aCA8=;
 b=j6IBfSt+y1fvWeCpzY04Mgegi3QYuJO1ToaY8VYsyTss6RUTJ1zPmRUweRAeW54Sx3CGK2i1l03QW5RMhtOnkqjb92SDrtkXdsyR83yfJjGV9qY/eSiCUDwJK2CS5CtIwLVA6qqeMSdWAClPWIeIuxV1Pf+I9icpfSNVW9Opsu5Sbxuz0AQOJv4tEkqAqLuYoomh+PfOl+AyfUXECg9GJXagDPX6fpGRbbPEgmBMiKmmZcr8RUX+kv7m+9xWi4QG7yf9JA9uueht2S197kuWrIKt1siz7jWeFgJkWFFWpfvjrUOtZf2vw6HYnGyxy+G3mG0+SF+XaE0MrZEO/b93WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOxZ0WN32xPCAaKqxghWqwZ4xVRw2rWr8HaYUb3aCA8=;
 b=Z0xjqB1xwPpkt3jSZG5NReenZDrla00wzcZn8++2zfg5E36pnodYhTap0Zpjya/2xK/oV/3zNEJ7hPk/xTI8RGe0lx1VQ7COtmWa9qJerfNpHMIKDXNvWpFiKN+HkdYjgRGydhUJB6L6KYDeqH5+7GXhgWKNQqSn5CfNAG06dmvc17U8ktdllUHLNJbmQaJ9V8hBesv17HfKVvlY66exBQPBIlY3DhOcdDZuFhN/8Qy+fZnQLtyE7+VJeFiLeH+Ypx/DWlh9azBayxrr/eDZzumJ0fMf8X1D+F+Zcog/q7Ta6jh2d7wfwuxIZ/5jsHCkngrksgkKF5TNgOQmpk9IKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA2PR04MB10258.eurprd04.prod.outlook.com (2603:10a6:102:404::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Sat, 18 Jul
 2026 14:45:51 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0223.012; Sat, 18 Jul 2026
 14:45:51 +0000
From: Frank.Li@oss.nxp.com
Date: Sat, 18 Jul 2026 10:45:32 -0400
Subject: [PATCH v2 1/4] dt-bindings: display: bridge: ldb: allow a single
 reg for fsl,imx6sx-ldb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-arm_dts_ldb-v2-1-f5669571aa2b@nxp.com>
References: <20260718-arm_dts_ldb-v2-0-f5669571aa2b@nxp.com>
In-Reply-To: <20260718-arm_dts_ldb-v2-0-f5669571aa2b@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784385940; l=2253;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=TZNLpXNlSs1vPzYFIpD49zey/I5tfaLXDljUkp2mUqc=;
 b=5STVNKe+3NSs0rP+KJqpHJhJTwUPevA9JjQuYoPddC9pB+6n/MvDH3faWlVUaizhtDZfa+JDR
 +Jy6+scYZDcDsAB46Vg332j93pnUmTdciibyySD4+VnpCO8K5c6DyVg
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P220CA0058.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::9) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA2PR04MB10258:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b481a79-eee9-4d85-662b-08dee4db436b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|23010399003|7416014|10067099003|11063799006|56012099006|22082099003|18002099003|3023799007|921020;
X-Microsoft-Antispam-Message-Info: QQSVYwce0wr0ueq8mULlJ2GNjndE1CkO5tIJaRSg8hCgrqu7P5p3dp6jxx7h9AboC+3WW3Q/XqFlgYpBi1HEsnVZL4+IwjRnh7LIHFIvIN12ey7B5ApdeBFFsA0O4SXZA3hpumA+Vu7rASNFKB5s1nNCSD3TZ6zqMokQiPKF2dtpVu0cKcpTXL/KIX0tOVF2k1uGDgLhPWodNXWvTSZOj1Vc5hNZWIqr3ZQk8QYshPXI7ACr4+vISCrc6/RIf6SB+PYBA6ZZNuZI0oPEOk8X7WLpQ6FoZKsd2bCq3CPN6KeNXCTzN55LNwIAmgqlQvFHKnIfcbF6tHAVuRMU/OnqmI54NKQ+dUu1wA9bPjyz9g8N229xS/n7vhaF/aIzj9gGXbdxPNWSSgRbWIeoR0lh6jBBZ/frsfwC8UhaLDx0wfQ+Px+lLAebiDvMaIXHqnBfDt7p0Pq8uV0Vi0GVD3TsahMUwVPJtHfo90V40/Bt9NjhlDkzxp74nMjuk2MbEFdXnQnueADwNbYPgXeMG23Abg3xaIH0tykb8uP6fmV8IRi9dF4NuIKNQgX4k1Wv8CqeqBbJCfmj0IDP8FZJanUEBDhBwwZbbZQMnd2MBLxngzDOL7BgXKCTNe3ugqxctQGMYmgLJPrV2fxaKQlhc17LrAx4eP9qmVVyPReIF7ENdNmSLcLitBtB8lR0EdsIgK4Ovq3eD0CtYfqLnJJ5I8puCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(23010399003)(7416014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eldNaWNMWUp4aGlxdDZNTVlrbUYzWk50MjkyWEdFTE5RblBZc2huOWVwRFVF?=
 =?utf-8?B?bWhpOGJoc3E1OUZ4ckRnS3NiT1JKQyt5bnhYclQxUkc0bUFndnBkaGJNSmRh?=
 =?utf-8?B?QkkvZkd0cVFQL2lFTWhCSy9ZVkNGT1kzVzY5bjA1M3RNNE1OUHVxa1V3M2R2?=
 =?utf-8?B?d2V4Yks3MklIWmxuT0k1M3I2SEFXWS84QS9waXdZK2dWKzRYZzM3RXpSMlFB?=
 =?utf-8?B?Tkg4UWMrMWFVNk5Udm9jNVFNcVQ2dEZWeXF4MU5VZG82dWZQTkVNZmRPVjl0?=
 =?utf-8?B?NlJkajVNUUJQQzFPTG5xMlBiQ2ZSMGcrWEFRUndPQVVsd0QwMVlQMjBGNTJv?=
 =?utf-8?B?UjNBNmZGaE9WVHZTbW9NbnRKUm8ya1krQWRRaUVrUUptNXkyTjk3Q0RXRVdO?=
 =?utf-8?B?OFF0ZzhCb3g0Q2pyOTEyTEU1L2F5VHpNSkpERlhvOXNQczdLamp5M05JUXcr?=
 =?utf-8?B?bWY4SHJFRE8xaWdhcUozV1Q2aHN2dFNXc3ZHNWgxZVFRcGpJb2g4Vmo1dFZs?=
 =?utf-8?B?ZUtOMXV6R2lpRU1aMGI2cWJCdEJURGJkNmE2YnpGUS9Ocmg2THRVSjdZdFll?=
 =?utf-8?B?dWlVMGpnS1grV3A0MnQvdG45djdXNWMza0JORFFlakV1NXZiendERkJpR2I4?=
 =?utf-8?B?TS9IZURTd2duNiszeFVPY2oraThsaUxJaGE2MEVCenhCb3BKcXA0cXIyOFBq?=
 =?utf-8?B?QnNHUm5JV0FRMS9EMWNweFRlbEZRZ1EvMXY2VjgrVHlXTkZlN2txSWtwWjdU?=
 =?utf-8?B?cTZBK1lwY01PUkR4R1Awd3h2RWRRQWg4alVKSmNUeEhxbUVFcUE1QTdJaHJm?=
 =?utf-8?B?Zzh0VjVWc3l4NEk1Q3k0SHlpTUFwMWsvNDlBUUdWRUcyYm9LTVM3NnJ5Z21K?=
 =?utf-8?B?UWtWUXN2b0t1QncxSGpVV0o0RFRXR0lORG1ISU5LRW1SMEZnNXRiU3RQN3lU?=
 =?utf-8?B?Q0kzOVYyY082UlloSEloeGkxRzU4Y2ROZmtBd0hiK3hUS1FtOGRxdlkvQnl4?=
 =?utf-8?B?UWFvUDlYdXdyU2JXYUJGTDdtMmRqNHpjZU00U0xzODVUcE5YK1NpemY1elc0?=
 =?utf-8?B?T2xiOHN6NGhtY1VVdnVFMytIemVCOFExVEpJSy9mTVpZeHREWDA4YnloT0xG?=
 =?utf-8?B?WHJZVjdrWlJRVkhtU1dxa01MNDYvNzBNN2o1cFJoNE8xdmVrNzBEQ1ZOaGps?=
 =?utf-8?B?U2pjd3lBMDhiVE1rdXNKMFY5ZVpXYUhldDlyY3R4bm0wNGFNczVIMXBlS1dp?=
 =?utf-8?B?ZmhjWW5GeDZVWllRUU1Vb2dCdEVtSkVKSXZrZndmTXF3aU84d0c4YnZ3emZ3?=
 =?utf-8?B?SUh6VEQ4N1djQlRLckRnblIxSElyU1NPaWVHUVREZTJkZWZYZmxLU21DTVBH?=
 =?utf-8?B?V2lDK3JUekg1TFA4ZmltVXRiWnc4R2p0RFhiNFp1bUxyTEEyTXBUaFBwT0Vw?=
 =?utf-8?B?VkJ3YUpJQ0FuOUkwbm8zMmpldVl5cEozUjQ0ZFBhQVJueXBid3oyVmhZQVB0?=
 =?utf-8?B?akJYVlFwQ1d4Uk1ZYnV3OEhxQjkzUW5NR0EwUXVmUDVQdFVDaklodHN0bW1y?=
 =?utf-8?B?eU50QXplRGtkZnRwY1JnSHhBK0VBblZNcXh3YnRKRUlFVVN4Q25DeWdLTjN4?=
 =?utf-8?B?RWNzVXBQYW9kWloxWUt2Q3d6SUp2ZjRpSlN3SXV1czRROFFRTjF5K2R2TU4v?=
 =?utf-8?B?MDNTdFdFalZwOE1NZUMxQ2JBTVJjM0hyRkJZNmUxZ3k3bXYwTGhlcFJ4UVpG?=
 =?utf-8?B?T0hIR2JGTmVGN0ZCQWsrWmtkSGpLNGk0Wm91UngyN2QvamFINVNiK2srOHlP?=
 =?utf-8?B?bWpsRjNPcDZVd1d6NHVnUjBjK250K2xyVzN1L3JPUG5NREdzNFA4MEdOTHlS?=
 =?utf-8?B?alcrTDB6SjFDRU5wMnE0UWl3dVpvczFsTHFpZFdMdFd6ZDIzUW9YUHhOYTIr?=
 =?utf-8?B?aXJ0NTlmZmwySEh0WmFOQlQwYkl2djMxM3NlMzFUWi9PQjV3dkJjQUJSSWtL?=
 =?utf-8?B?ai80QzB4TzU5ZEVWU0FyNkpwckg4QUVqbkRSSFZQL2RPclNkbUhMQktmRldJ?=
 =?utf-8?B?L013UWwvWFliRU05U2RRMlZtOVByeWh0THNPUEYrZHd0YkkyVTdmUlk5bUYw?=
 =?utf-8?B?ZkJ4R0tGNGFsNUoxSE8zcnBLZEJwdnR2LzNjM05qQW1Odmp5WDg1Y1FQQXV5?=
 =?utf-8?B?NDJKR3lScDR1RldtVnpPUlBCT0lSVjI2a0hJSzlpaWJlcWRYNldLTXpzRGk1?=
 =?utf-8?B?b2lDZ094YWlhWGR4MkRqWm8vOFMzUHNSMzViaFN6SFZsRG1NdkdYaWFSNm5E?=
 =?utf-8?B?SmhKZXVxSi9GUm5lcmFwQzBsVE5XNjNVRHVtMWlPM0h6NGFSMU1ITTJwSENq?=
 =?utf-8?Q?Z1hVKqZANaARbJze6iSIU78aoMHvuUOzQ9cy1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b481a79-eee9-4d85-662b-08dee4db436b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 14:45:51.4408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+rFHW82khxIbm3/SDo62MyHmeOZcwlmlPU2LmtJNQ2owFZFQ7MBkWxglEO2VLwebZuUoo3wxhyYyZuoAYRW2dlWUzYCz5WOzhsG2+FKihm8jD0ow26A/Iao1dzBQPrG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10258
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

The i.MX6SX LDB only provides a single register region for the LDB block,
while other supported LDB variants require two register regions.

Update the binding schema to allow a single reg entry for
fsl,imx6sx-ldb while keeping the existing constraints unchanged for the
other compatible strings.

Fix below DTB_CHECK warings:
  arch/arm/boot/dts/nxp/imx/imx6sx-nitrogen6sx.dtb: bridge@18 (fsl,imx6sx-ldb): reg: [[24, 4]] is too short

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Related two theads:
- https://lore.kernel.org/imx/178154922879.1630652.11500293336634076421.robh@kernel.org/

Mixing the addressable and non-addressable child nodes is allowed according to discussion [1].

Link: https://lore.kernel.org/all/n6akxiayi3g6gxcqhreb4iaohmeokoalnqup6h5r2fwdt4zijt@u2wyps55ayqm/ [1]
---
 .../bindings/display/bridge/fsl,ldb.yaml           | 23 +++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml b/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
index 7f380879fffdf..e5a8870bb76a6 100644
--- a/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
@@ -28,9 +28,11 @@ properties:
     const: ldb
 
   reg:
+    minItems: 1
     maxItems: 2
 
   reg-names:
+    minItems: 1
     items:
       - const: ldb
       - const: lvds
@@ -83,15 +85,6 @@ allOf:
         ports:
           properties:
             port@2: false
-  - if:
-      not:
-        properties:
-          compatible:
-            contains:
-              const: fsl,imx6sx-ldb
-    then:
-      required:
-        - reg-names
 
   - if:
       properties:
@@ -100,7 +93,19 @@ allOf:
             const: fsl,imx6sx-ldb
     then:
       properties:
+        reg:
+          maxItems: 1
+        reg-names:
+          maxItems: 1
         nxp,enable-termination-resistor: false
+    else:
+      required:
+        - reg-names
+      properties:
+        reg:
+          minItems: 2
+        reg-names:
+          minItems: 2
 
 additionalProperties: false
 

-- 
2.43.0

