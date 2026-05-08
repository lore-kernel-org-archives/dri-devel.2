Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64666CD342F
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 21:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4B0710E0DB;
	Fri,  8 May 2026 21:45:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="NPjdJAaP";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013071.outbound.protection.outlook.com [40.107.159.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F70010E0DB
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 21:45:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgdLYf2fb6BQDV7ywiajGR7Yy3cvIO3MNKuYkwUWDp4xWPx0Mi4eESJsknM7eFZ0BOoIbZbYBsS24fI9OhGRxnTSvvH5jMzAkarlRimatLRqzRkOXxRD2QOwuYPmXw7wtopyNCGEQR4NS2OKWY6u8IJf0rTo1QCAmZ8uF4D/Xx9N2GXekcpmsVEgKS72f4JThNnGDRCjr3gFcsln7jTNX8+aBDsu8sD3lYAm9nq/Lo0kjQoKjSIvGxTO+hegsDx2hqLrmkH911OcDWkJUxlLaK6CqqYrCPmaR+e9VMLDVLxLh+Xot+sFSJsY5ZLxTu+LwCaE19BGQf8g/OMRuVba8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVACnrToIGhivLMV3gbW5OwMHK6BeqkexDyzN2P8dfs=;
 b=c2EOwC/6BYmXFPgdq/mzGs+8WEHw+5/wDJFYDZ3YVCwM58J5CwcdL+SV0ZQH99RnRDM1yQbriPNkCNjQQxnzwgANTFgk/hg7cJlGeH4nWeTaZiHE/6k2M7cBI4xmH/QcZxgjwrPnYyoaBH6ykpz11DlLu1qO2myK/5mk66bDFRhC1aIO1quPjJ0Mb2k0ozr+jO9E85qJPzLEh2Uy52iogxiPnj5s1Nr2ZOibfQTgbzUadgKjhqqysenNVWTbKnJdaLl8P7WnP/vkEebn+FC9te/lfPumbPIrnmELJUgtKRtwe/xWFaRwAtN0MZ1vn1VfV/yS6R+2FZL3fj1UCAo3eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVACnrToIGhivLMV3gbW5OwMHK6BeqkexDyzN2P8dfs=;
 b=NPjdJAaPPn9KPN/ABe0UPDoWdoA0wgFcPOmGxqUsHBOgs56NJsAReUnONmJWp9y0g4QVH0uHXg72hd6GbnU07lqsPO7WptLmuD9PBVtiUGk55aNyDCkoDXAbmi8ZAjfF/xAPDGqdOcFZTilSapCXbSPBCDPvoczv4a9MUKYDXDHxx6IYC1wd2NgO4lafI4/U4Kt/KEhdEE0rpwqsU4mqZNq6wl4rataGNjel494ioZ5gKugLot5hb9GDdjlCA/Y4WngcaVIk3mJBf6rgg/K63e4Yps8kqFUIti7j6g/KNb5dg8EbCLg7QpqxcCb1dS1FFNEPA60/NDvuTcrP95hORQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA2PR04MB10514.eurprd04.prod.outlook.com (2603:10a6:102:41e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 21:45:18 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 21:45:18 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
 BINDINGS), linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 1/1] dt-bindings: display/lvds-codec: add ti,sn75lvds93
Date: Fri,  8 May 2026 17:44:43 -0400
Message-ID: <20260508214444.255992-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::15) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA2PR04MB10514:EE_
X-MS-Office365-Filtering-Correlation-Id: a81dabcb-4749-4331-ea52-08dead4b187a
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|376014|19092799006|1800799024|18002099003|56012099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info: iwhUoD+n6/X8oWJX8jb34CR8RB++9u/Nttly3ONvR8GqWYWi6LBbHILTZYsm77oTnoKHkI9YawtWNgeb6F0YnYayk4ybQlmvnelDFEF4QbCtJrlzQ1ZfD/+WqVwLTJn11gZ2u0p3SRZPiQTbC1mNES3B/tdToydsuZK5QJo+ViHZecvOlAJJy1mNU45QsdYhrcaLCcZUGWM0jQNpad3u2jJicWb6RNhrPr7K4Ma3DANIzrMs8QfYVBaVkNL19w5nyLxNBX652DXrgOaq803a0FV/HAPK2w3mLOfRVM6/1mbcHCtl2BZS9mjZdPyWLCNZ7+DDCt1wOA/MpxPm5qZNmOz8Bkpz0A55x2f41RCAf0fqTMZGGZQeBsM/HmSbAFmlBmbVr3FRlkCGHEPRmY342OOr5J69bv3u3l3JkWTTpvT5dJvtGCVGllpgHJOTHs3UApBsbPF25X8mlnZq14S2ATLASeMLQyI8GMfdmvcRBh8c9qjlm8gm9zeSnF7+fiK4PPaxEk/D1BBYLPwialIlpk6if2lkit+OgRqBnwxsa5Fsi0H41/azxL3RiFtgSrgukMNZ80k6j/lvvI93Txl7nTOm+HZhdfqQhfrsbCrQXyYTAVi4tsbXjYDCQDOMUAClpI/FCKWb1TqtBq7vGo/vNp49QRNJsX+EKxyGEgVWfpqbZmels2apU/yW8qwfeukGbBFgmdJgjE3VmfLVb8kGZ4twGUtUhCC6GYNkDTfNGNSGQX+ZbJc+4LQ8x3ZgJNif1DDDZHIqisbv3c3DDdGVkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB9366.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(376014)(19092799006)(1800799024)(18002099003)(56012099003)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r8oct+0pZeaHq/6YYgerMT5/zeAz+zrXnFoRZB3Kzn1EMJy7jQ3BM6vls/NH?=
 =?us-ascii?Q?NQ38+DsJ+HUukeBrRIy6rnRBVghjDKKzFF+izLd0EUufbDDsay2dJb+srgqc?=
 =?us-ascii?Q?imMJudXx1085xmRnWOd9TMS0dKLISH6k7mNbE5hPJcm3a7NeOtjWL6FxhFDp?=
 =?us-ascii?Q?x5T9MJaKh5zKuvJzTi9+Lvny8p4E1R0UIY0Pw9Ugc8JUNvSTNgFqNzT3lbcf?=
 =?us-ascii?Q?yYbDAQ3qPXG45o/EZdnv94P/OMwX3JHnldIGphivryCBquydNsWghYlrdtcR?=
 =?us-ascii?Q?4OhhhIvwiZDz3R+AdHlcMLqn5SG4WtkFcshdoea/KasurWcPL2DTROyoX8GE?=
 =?us-ascii?Q?npf7eGlLn9WkH9gaB6hbwBJTFHQuGcNaqmJ0aPQIk/ClHYOR2KYLunrSaxaE?=
 =?us-ascii?Q?aURuhB/JSYmmTRhrOg/lA3wQEPJ7rj1ev4/QMU/XKwl7hGxINdL3Wa3IFvaG?=
 =?us-ascii?Q?isGQOmrCe1zO2LFhOhaO8AXRpGJhIc1x4Bf3O6SkFcj1Pv/p0gApprcpYbZb?=
 =?us-ascii?Q?EOPtDUUgIAd4rK0oljg8ZNGhC0U8VnQIVJBezUbNIz7L/npY/OcdYcMgRbp5?=
 =?us-ascii?Q?nlB1zpDikTcP00Fe23sBvFTG8pqM0Uk2/hUxBXlLyLUeW2fj7PSoIZRJE2xT?=
 =?us-ascii?Q?/4PgggvRir1E016xGGtsYEDO5K1v8uvclgTAMuabQLkqFKVBck7KGKqLxG6J?=
 =?us-ascii?Q?31IrmTzALOzbTIUD5xt1WEtYsT9C4kjNn8Pg2yOznwm3IqZ8XM4Y3V/nwL8m?=
 =?us-ascii?Q?LwdbruNvfTSrVABFkZubcfHr51nwlgPXyKwvVJBzj+KeK4v2oAu9b3bkjfHU?=
 =?us-ascii?Q?Dh8FyWygO5BFDUyqr3DN0XT3LaaevUXFZeGmh50TYocNcVHRMKSlH3b1tq3D?=
 =?us-ascii?Q?NZVIn+7O0cunh72pEi1qmvX2WcCtIS3SQbgw3n9qQX47ZNmJL3339YlMVP7g?=
 =?us-ascii?Q?V173GBvziJ0WFwUWsf28y7EKFBh/4PInV9SsNiIVdz4B4rNaGPCo6xt3oUxS?=
 =?us-ascii?Q?ULd2B4a0IkRzbGEIa9c+HI1YYsIomrkMlsuNQXzysI4dXolRgyL259y9mFAb?=
 =?us-ascii?Q?e2aIAtem7MwqjSHxW/W2+EnqmruaIXx6sbWmoKTf6HEPAB2e3ENoAN+yv5cF?=
 =?us-ascii?Q?0vMJFRrXX6mw7YGTySXz2XJ6R4UH4k+h0qjx1fvr1bFFJLAiCzMaxg1FZzE6?=
 =?us-ascii?Q?ORT4rKRMX6VqGUZBqR3nAFv/gZV0rm4BaEaby9GayjRi+jRHoYhCbEqksSga?=
 =?us-ascii?Q?ZGcGfDnxExq9AB8/CxL97n+FPRS0AX4rAf/DmNkaXtQc9WTK/0T9LUHwxi83?=
 =?us-ascii?Q?UtGeE7FDYYo3xLMAEVL7JksNS6XMD/5Z7GMS6NLHBpQ/rPRcKPEtykuK4QX1?=
 =?us-ascii?Q?UVSikYhsMyA0J+E9PHGVjXT4X/Hd+rbCcrkk1FgBfkL6E3fz/AdMkVamaPg0?=
 =?us-ascii?Q?/EnCAbPHV26/62m1padjjmKIbDKKFnO9vo/VUe6SQTmykexXOAUM8NfNB2ss?=
 =?us-ascii?Q?Snze3o3fRZT65dkHDrI5bruxIlORrgya6mhSnagXVWqOe/rUFd9m+lG2MN/a?=
 =?us-ascii?Q?aaRe7iBu6IeTzxKMfAN2u4rEzgW5D7F16snvXYE672OxWKSx+4IYPrxlkDy4?=
 =?us-ascii?Q?ybiqtVO59ADjA7fiKSbK1uEpBFRoOZCixoB1vkn8/qq50tSs9eZUHKRseA+q?=
 =?us-ascii?Q?BHEJlaQpKc1GghzVKOqln+05iquELiTP3u/Y2Mfuy6TKjTvL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a81dabcb-4749-4331-ea52-08dead4b187a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 21:45:18.1077 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wt4t69wGGohn6wDftyVRmhT2GR5iwvmGZ+CqAGHf+YABQhPpkyvQ2WCGEFJmDjj65/QzEecCOHZZQRLC3u37DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10514
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

Add compatible strings for TI SN75LVDS93, a FlatLink LVDS transmitter to
fix below CHECK_DTBS warnings:
arm/boot/dts/nxp/imx/imx6ul-var-som-concerto.dtb: lvds-encoder (ti,sn75lvds93): compatible: 'oneOf' conditional failed, one must be fixed:
	['ti,sn75lvds93', 'lvds-encoder'] is too long

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml b/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
index 0363201f0e619..3c727e4d1096a 100644
--- a/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
@@ -39,6 +39,7 @@ properties:
               - ti,ds90c185   # For the TI DS90C185 FPD-Link Serializer
               - ti,ds90c187   # For the TI DS90C187 FPD-Link Serializer
               - ti,sn75lvds83 # For the TI SN75LVDS83 FlatLink transmitter
+              - ti,sn75lvds93 # For the TI SN75LVDS93 FlatLink transmitter
           - const: lvds-encoder # Generic LVDS encoder compatible fallback
       - items:
           - enum:
-- 
2.43.0

