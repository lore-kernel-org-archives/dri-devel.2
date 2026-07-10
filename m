Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7EFC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF30210E7F5;
	Mon, 13 Jul 2026 07:10:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="prBqacXb";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013058.outbound.protection.outlook.com
 [52.101.83.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78B0B10E14F
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 08:26:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnqHzgs5M3oeOGwzGmUFkxSkdJJnc3MYr4mgCIZtW7e2lhMwGPhenZTacYX5G+DqOLi0z1G7Q0II/X2NpEJI42d7qDD8+zpvO6pQCirLDnw1fQ1CbGQou1DPjPcvoVj7gb+35Zk4PakkGNb29xx1mAnxaDo5nBhCYpT5RwBvio7fc0JiMm4yAkOmlZNgff695eK7f3gOQE7QfkRTHJGWdr7A/QqZ4g6VjMvBGDbboX3aov9xdxd4QPtG1mRNyt0kXCv9WWcAfyvGtwdsAxnDQRGtmRk46XJSw9F0eMU9UZhVPdqJN+KKEqssOX+ADkd0CkZvxblc1L/VFB8tgV+P8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXCZexwMMh6Ir/LSRmykd59PQpEf3pr9BCcsxsbQyQw=;
 b=H0CNzpGTen9G7Vob4ODbBMhFAAoZM+Gvujv88IKZsEocbwoYEEGK0+Dzh/tkYCT/ZTAu/49Q65UC8wp8/tBCzwik9Ls/7L+bxa1L8gq4Nk4odo0hfo0e3GnxukpLf1YxnqA0nrRYGddKt1w3j1eMJkRxOtvUw9azpo4S49AlW9tOohRrAvHxuxCMmzbMljJ9+HXOWQKRYShW+NAYEPzL1TKZSTQI+fZxmXxKHS3XvCMkOCQqrIb6qWvltYpuKiF9gH7qDlQl6bj6o/Cn431hqOgmuu67dEG+S5FpbxKnfgg08kFexAuck7sedpeWAx1UmuAzOlVLSrwCHNJhn0jg4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXCZexwMMh6Ir/LSRmykd59PQpEf3pr9BCcsxsbQyQw=;
 b=prBqacXbQpuFdjT1h4VCPhHr117D8rINRdiLsqsJGlVDENM+rAPZf5TxQLE/rNr8dgF+gG2KbkYY21FWDpinIWjQapcpYhOX8SPuveTiMY80K0ND6kNr/0KQiI7rmrPa4jLJ82GEASBLd2eCtB0CWepMWYuSztUsMbOPfzrZ4It/DUvYva8PiOV/nevyOT3ynYdcYY54qJ5y6qo277StwLdjCTvpFMsryv+G/6qBXG5/ObLQffzjjORfCttYdnvftgFpaKC81+1pM8yhjb6hcW1bTjuaR5l2BoPLDT2rW4e+4P/UFy557X3WO2FRJMRbsYhZdWAmEhHN+n4useWK4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by DU0PR03MB9731.eurprd03.prod.outlook.com (2603:10a6:10:44d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 08:26:45 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 08:26:45 +0000
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
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/2] dt-bindings: display: sn65dsi83: Add output data-lanes
Date: Fri, 10 Jul 2026 10:26:29 +0200
Message-ID: <20260710082630.394040-4-wojciech.dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710082630.394040-1-wojciech.dubowik@mt.com>
References: <20260710082630.394040-1-wojciech.dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0028.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::15) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|DU0PR03MB9731:EE_
X-MS-Office365-Filtering-Correlation-Id: f680c878-6d98-4386-f8c0-08dede5cfaa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|19092799006|1800799024|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sZ0GWgBQ9f4sp7PJ8rp3bWy3xqygi7SbLd04t/uOjBpPZSefCO/gxkaV8i2tPHcAe+DsSeuEhnwY1dus8+7WZi+5KC3M82B6XZE7nf4fwKVQQZNOH3juT14WZzDvfp/HYW43riFdLvZ55EMvvGkIBKCIAO+zjAcIAHp3QMjtC0aNKXgx/9Opr+j3H+TcROW1uJJXHJiknfyVSPdGUsbEsnpRT6hJubtTobAew/RQY7n+QTz5rB/WvFRVAu67wPP+A7O3GOUw5dr76BIY+EhrDks0x/rUXEez0spccwmZ7vGEW2DWIfx4Ln2nZKait5wSaOrKIBbrWVVCsA+EfHNs/S3mFVBckIruTmJ7TTu2jWxy/1xroRJkQRma2lg9PatBGtbpHZ+aMu26qEkNWzOK3Ur+PlniBzWktUGBBS+FuCG0XcWYVeFIOf+lcmoIlvYJ8Hpsqf0mimC4Wtl6Pw2XtQTsxJ/LIJAJTq08GuNOEEo5h1XHNdthnMjntAe15HK2r/0Unjuye4BRmiFrapJ6sF53dYiEjeIPVtuOm3vKVckt07e+hgCN0esf/L9opFAfMW8czMdUHOxp8mzBTgQI5L7T3v6WlWA0BKRF1nNpkvjkrJjrIjdtcaBuJ1W5UqsiO8EV4oaQyDsiage24u+hRSlDoDMHT912WE5Q/g+cxRc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(19092799006)(1800799024)(56012099006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nyLm56JHVZEceuZ61Pcm8kdbgCMcIJiT3LDFnTYJ7+9qtIOddLU94Umvy3qW?=
 =?us-ascii?Q?TSQ/zUHxEB9JuBjUU4PE7g7vAEdlVu7iHFfH4I5tNTwzZr0jZjcHCZ1c02PB?=
 =?us-ascii?Q?OsBeFR+CORwqVtVpAULxYU8mmSmbH6ENb1hfe/2DGUbPAkUpQgLxWO43qrpq?=
 =?us-ascii?Q?eC+F2ha/ZMjuAmdB92eDnB+MjesWdk2omKMD4yNDv5DGIsg5ANU9XTqNHipg?=
 =?us-ascii?Q?tqfWLANufnMpCI/lEyYg/Yj67A6nD3gNQLkU4ZJeCdJjRKwxamJGiENwxpnn?=
 =?us-ascii?Q?1heKZqA8d9C4Pg47ZkGhoMetFm01se6FHFIs9bN1gb5Heou+vxUI35O5uGIW?=
 =?us-ascii?Q?24lp5XKczceqAP4GEBBKX2MDmTOxHFaDH+pmg/1396Qu7uG4VHXgx6EzbkP2?=
 =?us-ascii?Q?HPCfC9cJ8GGleFXoDpZK+J7bQ7jIzc8tGa6jdlWLf9pvzKhxU9waixH+yHIN?=
 =?us-ascii?Q?5FgwaBAfkldc9f+Rp3DGDqk5QMGETXMLdzM75/QnI2khqY10niydTCdeYee/?=
 =?us-ascii?Q?cpbI5NksotsqV5ZsH7/DuQOnkDupo3JP2MvB3ApLa4uESNxNeMChQ+9t0ggZ?=
 =?us-ascii?Q?+ZRsZHgh/MC1YIDjnmVC/vRMZoLE17D586UYiQNJpk+RJ4DOlTUKYNYTI7yQ?=
 =?us-ascii?Q?Euvjm6axjjrm53N8k/uOr28NZhVj7hZYY6r8DgHohYYXkJdlHUVamkkb6DvR?=
 =?us-ascii?Q?3jzuNmS29SDxO9ho5YG8l9UE81aaaZ6ixnWM0bpnW+CqGXHbrbijlGBJzyYT?=
 =?us-ascii?Q?aTNGcDQleDJqF6xwMfSPRMxEMbIhYDeOQN07FQsDIBPqPsFGv0yQQBuFNDLF?=
 =?us-ascii?Q?oZS7JW38Bs2Hya2xj5RVscBZ1kQgUHW0BbBxOSWu2/ZET9Pp37RBtIyubt3i?=
 =?us-ascii?Q?RwB2u8mZ/zWnEtQW+et+ESLMGFWDpmc+XR7bRO3fkPUHl9r/7jzgWyhxGMUF?=
 =?us-ascii?Q?6n7bfABfwK57o2SWt46v9EHlbEgr8ugwsTneKsl9OtRqor2Rd2a9sgIts5Xk?=
 =?us-ascii?Q?308R4ygNJzp81gMqq1nmF6tEMb3FmguHwYxZDbyEYieFQK+B5RDOscVj8NoK?=
 =?us-ascii?Q?X4j1czeFXbr6dHpLEMhhorOurBKiNS4ifTSu5sslcSDW1rxuljdEuYZW9N9P?=
 =?us-ascii?Q?CphdiMkae3ZRvS3uZ4qgpGc6HCCKBIb2SkaPWMsDpSS5CFdS6GtpElLQEwNK?=
 =?us-ascii?Q?VW32U6TDm5srrF3z1cv9E0xoQ7CBidXURlo6TyiwOg4imAEa7ZDwMistM6lT?=
 =?us-ascii?Q?aPqS02sWTC2/dpVb+zj3i7nhkSHY82D8WsMkErsSFYZw9Mqc5v/JSqIclM6E?=
 =?us-ascii?Q?KrKWHDHLEdJVH9S2YAo4cyBCoQhF/YjosCjo1e3J+zUFXJc8jgoPVTs7gOP4?=
 =?us-ascii?Q?tfFeDJEvbpPiSpHQcrh+yZqW3tbjmnrvRL8AKxdgXUYdCoXR2LTWawTJxZuK?=
 =?us-ascii?Q?pMo79ajxD7Fp4hPBVkHVs0EgBioBmCM57xlpgpzpOQbQVjgV6DUz2xE+JQVe?=
 =?us-ascii?Q?+r4WQIoeYxtv0+ZYKrLjDmaCb0WcZa9QiKfVVv91HY2DRcCzFT/s8mJItve4?=
 =?us-ascii?Q?5ljVcjJwh4DNFDwgriC1X9JIO1H7EvbSPKfSIi+O7TaYNa3nBeHdKaBI2bKO?=
 =?us-ascii?Q?TFpQRNdtBruEzfQOSXkcxHLBpPbEhFnPZ1KB/fCDbz9mJ0082+uE250biMgf?=
 =?us-ascii?Q?0a6TOuRWkCbLGAWMA+c84KIKzxw0MfHJ4ZL10gikByDle5N8xx0BweE4PQax?=
 =?us-ascii?Q?bVPkYUjn3w=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f680c878-6d98-4386-f8c0-08dede5cfaa6
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:26:45.7630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9ZjsTQsH3uPg8h0rEtCnBRQycg59aDXxWA+3wCwdzc4JBX8dyG2x8u+o6E8s4DfSAZD6pN58GQudQVaJxS8BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9731
X-Mailman-Approved-At: Mon, 13 Jul 2026 07:10:39 +0000
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

Add an optional output lvds data lanes property with
two allowed values. The array <1 2 3 4> for standard
layout and <4 3 2 1> for reversed lvds output lanes.
The latter informs the driver that reverse lvds config
option has to be set in config register for the respective
output channel.

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
 .../bindings/display/bridge/ti,sn65dsi83.yaml | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
index e69b6343a8eb..4431f113bb9c 100644
--- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
@@ -86,10 +86,52 @@ properties:
         description: Video port for LVDS Channel-A output (panel or bridge).
         $ref: '#/$defs/lvds-port'
 
+        properties:
+          data-lanes:
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            description: |
+              Array of physical LVDS data lane indexes
+            oneOf:
+              - items:
+                  - const: 1
+                  - const: 2
+                  - const: 3
+                  - const: 4
+                description: |
+                  This is the default layout
+              - items:
+                  - const: 4
+                  - const: 3
+                  - const: 2
+                  - const: 1
+                description: |
+                  This is the reversed layout
+
       port@3:
         description: Video port for LVDS Channel-B output (panel or bridge).
         $ref: '#/$defs/lvds-port'
 
+        properties:
+          data-lanes:
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            description: |
+              Array of physical LVDS data lane indexes
+            oneOf:
+              - items:
+                  - const: 1
+                  - const: 2
+                  - const: 3
+                  - const: 4
+                description: |
+                  This is the default layout
+              - items:
+                  - const: 4
+                  - const: 3
+                  - const: 2
+                  - const: 1
+                description: |
+                  This is the reversed layout
+
     required:
       - port@0
       - port@2
-- 
2.47.3

