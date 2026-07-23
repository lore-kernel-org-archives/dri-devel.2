Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E723DC531D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 19:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 574D310E40B;
	Thu, 23 Jul 2026 19:14:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="txshb2gY";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011018.outbound.protection.outlook.com
 [40.107.130.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9FC110E40B
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 19:14:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sC8dYI3p7kmaUoygyHOl70KvS8bkGwJ83lNtW8yH2BEGvLpjUrQjRlxsOt+NbxBkwD0w/El6KI5jx3T62E49Gx4iWsHNV38X+I0QonaOsyOrU5cgsf7oHU2B+Mq+LZ6RrbVSNg+DpqldBEWypqcBinsd6eBUY/BT/w/+dZ7ctgdfUfARUZH/E79lxHVGteXeQEsqmcuxuw7gVFke5+g/E4uPwikr9u/FVR4ByoL0VNXErcLsvjbMG6HZBvSaPJr/HA46cuZzbFcUzSqIXSp79vq3KPpDg5bRew1Dm5z03FM6JBrYYyx7CEbGtWIQbTR57yvS+n1StNfVpbHvtxNrgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEpVEno9DHxzCg21wDj/kvFlE0tFwnM62SutDkInFdA=;
 b=UZXRHA6vMY2kNUwib5oIJ1fXU/hOvOo7CNsb9P9GeRQdpSEypAbPvQNiFUKvkacCfHqs4rSVD8lGCjXXYR8wPBvjbnPJjWYcxITv3Cctv3pJxlJxH3PKj4KwLkArbN+TBRwQxoVvVR0VwvpyNmfURsG+ZQMQWmmeyZMsvg/2fNTOxDES2nRGX1g2bp3o8zGqhA5HJiVZT24Ialtxm5Gap3Or+6/ymOsk+c19owOVZCfgvUVhYEvGf8wMvQmZvrg2I9quWl02wfjRyg0PUpdxlrI8G6pyVrzNxfePd1tGi/2x5QKD/mwfGsj3jIqf4hg7SsjUUAZTCYpL3Nndz5ECew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEpVEno9DHxzCg21wDj/kvFlE0tFwnM62SutDkInFdA=;
 b=txshb2gYOOgtlNPMP6dZQhdzRAwpVFXZ4P+uvb9xR7c7kthcVhzmyrVL9LfiqYU4sZ8NBimJfPRdzS6C022FqyzYAAOZFL/iphkmqp4+AfOHjcaokCVreh1iesuqHGMYNm8Z7NV4xXT7gKzDFRINiEljxQ/L0HicWZVhyBfExZ8rsWY31A3xiZ2mGRV0PrN3DN6leC2lYWJ6XmACMoi0ASX3zFVO1BrZYGizBL60eVTpjexVB1QJ9Um7KVDU4zwvH0PLTKGWNV4zj1YghIq+3zM7bauCHehk+vyIzQLUW2yWU89sEtLpmcYHPPYTkJQT9c07Rmgg1TyusY5d5Kf50A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM0PR04MB6818.eurprd04.prod.outlook.com (2603:10a6:208:186::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 19:14:33 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 19:14:32 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 23 Jul 2026 15:14:16 -0400
Subject: [PATCH v3 2/4] dt-bindings: soc: imx-iomuxc-gpr: allow bridge@18
 as child node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-arm_dts_ldb-v3-2-96c784b2b84f@nxp.com>
References: <20260723-arm_dts_ldb-v3-0-96c784b2b84f@nxp.com>
In-Reply-To: <20260723-arm_dts_ldb-v3-0-96c784b2b84f@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784834058; l=2852;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=iQ7TfwPzdsdvXyhFxUm2Nhdaz3Tla0aKFsNXUHQpVLk=;
 b=EQeb78KOXyPvkqQlqsPxqI8Uw6MXUdB1KdvJN0Lgshez3oeWlY9PCoLHKROxL2HTiCS2b8pOQ
 yQvq2/G4snZD9h1zoluTvr2JVFHIrpF/3qiJ7CgGJ17ks8yPe1oj6ZC
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::13) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM0PR04MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bedf7ed-c326-401c-32eb-08dee8eea07a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|23010399003|376014|7416014|56012099006|10067099003|11063799006|3023799007|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: TRdpD50jCix0067MZP6RQjOKyu4Ads0VjqMfphEiij5BhvjzHKwPgMyv9Gzj8Z/zS29Txf2PEXVU4kZzTjmmVk5lOaguE4xB15BF/gsS4psFouOeMIknubmEOQZkLxL5uCRM0ECpss990qTW9eWrl0hqsRqv3p0jHbzbHE42fgS0W+EIzCgj+eUqIeKycJr4FE0h7B1aBNhnEPeubBiTM1ObZEU9t6rFy6CZ16GtahqpEPIVYvVdUxCnN6zX1gsFi2VvVR2K2jW/q9wbeJ0jE1dZ6i3rRHz1Agjh9Hm1frUxbHVcp6M1BhELhJDzbvO8OkZNznYL+6zqMUVvqjz16cfbLpp1B4DWnBImtYpsE089tyEN8c/b231IWJCRKI+jnb1EWmApf1peLE8gEXajnRnDF00Rzd32ydFhIMAhbICcuSMn25WWvwr7/cDeavbLBO/iTDGHUr1cEs+/22ZbbJoZYVQiaD0RGMR6M/vrGHCynKczZ/fePZldAcMBFFGPogFH7kOnovQMrJBFM1otJ845H79R6zvZul6SqT5l6wfIDvSEEmCAdeORSjgFIDhEh8NVyS2/pq/IW6xJrPHJ87IN8MhOX5OI+5Yx+H+nqKLIRW5ntjcg7fyCwvgDkbCiIj3kHLlVsIhSHEaYQAIGQSWHLvxO4YfPZc0lfN6VaQf8eKomFIafFxMvPW3uptq1W45QrJ1y2ZVPp/RkaPTMng==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(23010399003)(376014)(7416014)(56012099006)(10067099003)(11063799006)(3023799007)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkFXbUp0aGlzb1phbzVDQ084ZTJYaGZjT0gycjZ2aFpTQUF2a0s4Y1VNeEgr?=
 =?utf-8?B?UnErOGlOMlpNcGx3UTFVN09MN090RGczem9LdmdMU1ZDbTFKeE9wQ1AyVFZH?=
 =?utf-8?B?bDduT3lHTDhXeHlHRmJTQVhWdFg4UGl5UDd2bFllUG9CVFNQbHNWSVoyZDdZ?=
 =?utf-8?B?MU9PaHozUktEak5KcS9BQ3owZWJrZ1lSMzYwRW01SEIvNlFCU2p6cGhUTW9Q?=
 =?utf-8?B?VHdEZGROUFJQcEZIMllKK1l0cGxkN0tiaE44eEtDbEZIK0VmZ3lKd0VmVmpZ?=
 =?utf-8?B?YW44blRFVnYyVDhoT2p6cE9hNDdOczBLMW5mYjJXeEg4ak1LZ2RzQkV0V3hy?=
 =?utf-8?B?VWJtYXdNNmhKdldRR0lnUGZBM0RrbU9PaHhOTEYrN2ZvMjQreVMySVVDVFV4?=
 =?utf-8?B?R1h0dXFZNUtPeUNCSVBHTzhDRmZVaXk4eGJPVDFyanJ1K1FQSEdNZjB2T0Yz?=
 =?utf-8?B?UXc4ZVJPRlJINlZRVmdvODZ5QzZXVldVT0FZQWNFUExpNENIQi94aEhHalh1?=
 =?utf-8?B?WGhXRGlQdUw1andBZTlqT0ZQY1dxQW8wd1phY2tzRmlQdU5BOFlRbzEvcVJu?=
 =?utf-8?B?bVN1SldWaHJEZVorU0p5eVA4VXNjV2ZWaEU2YW05eEcyMFBCbkNQVUIyYmNJ?=
 =?utf-8?B?OXJhclVxQjVOdWxxNVkweXRvMGp4aDB0bTBhL3pKUGdrMnVFeThCWWw3TU1q?=
 =?utf-8?B?TVFVa1FjRnBmOGxyaDhVeTgxdWNtRDdqKy9sV1hrYndvR2xTNkFFZUpkZ3o0?=
 =?utf-8?B?cVZiUXZEa1gvTTUvemsxSTdJYjFmQy9ON21hdkxTWDZlTHB2TDh6UnNSaWVo?=
 =?utf-8?B?ZkJRd3oyZmtDTnVqcm1lY2ppSEFZa2N4M3ZkQmZ2cU5WTXBoajhubm95T3ly?=
 =?utf-8?B?UnFQcVF0eVNVZDZuSUxkTDVwdVhaNDNZRmhqNlZGSUEyMlh2bmJPd3hNQUhr?=
 =?utf-8?B?bGgxTlVGdU4zR3o1VUFFaFpDVHBrV21CaFpHRXp2SEFIbFhhYUhGa1hXQUN3?=
 =?utf-8?B?WlU3R01iT01RQlpWRUp0dWYvV3JCOTNnV3djOHEyUTAxNjZ3TU1IYjlWZ0pV?=
 =?utf-8?B?N2twUDJSZURWSWpJd2w1eFVxbERXeHRicWFlUkRMVlUvSGJ0bVBnWlY4NmZT?=
 =?utf-8?B?QmZOSk5TR01sazJTR1RtV0hkdFllR0JQdkdGd08va1dsdmE5QTI3aU9FaDRO?=
 =?utf-8?B?cmY0eG9FRkhtaFNpNkxYTnNNZnJVU09OUkdEU1RMbzRiUzBMamhuL2RCUzEw?=
 =?utf-8?B?OGsraEZtemJFSzg2Z2kvMG1OTVRRcFRYM2JydWZUekRpNkt6U2ZNcUY3ajFt?=
 =?utf-8?B?YTc0L0swRVBSVVlSdHhJekZld2FkdlRkYld2cXlhcitBYUtkSDlxV3RaWnd2?=
 =?utf-8?B?N05Sd0xtVXZBZERtcVMzM254bHhwQ2RRck5iNDl2UzJIQ2MvUmJ2SE9sNDZR?=
 =?utf-8?B?RjJIL0hSOUIzSmhnQjBnMTJqdlRrS2h0MzM4dzcxbDl0a00zYlNxU3ROYWxl?=
 =?utf-8?B?WGVESGQ5Mk9ETmZiRkNSRTdGNmsydTA2akNlcmhVc1J6M3RnWU1aTENSZDRS?=
 =?utf-8?B?MTVmL0RMbWt1Z1A3UG1DYzl1M0cyKzB2Mk1YczFha3F2TDY0M2ViMytod05V?=
 =?utf-8?B?aDMydTZvZmFQc0pyNVFZdm53MlJKcDI0L0RPdTEyZVF3Q3Z0aGJhZ3QzUHVm?=
 =?utf-8?B?NXlnZjJiQXlUOUI1bWc0RVFUR0pjNE9ENFlXMzFqak9tejZjdG5jbi9odlZx?=
 =?utf-8?B?RjZha0lNYUUyWmg1eW40U0w0UGRrb1FkMmhRbEFCU01IQzBRaU1ZUWZsQmcx?=
 =?utf-8?B?U1lsbzR5bDNFTUVWa2lHN3E3R1Z0WWVFQU9IVzlvQTVxS0JWejFDWm5rL3Zl?=
 =?utf-8?B?cHRkT252WW94OGo0MjNTakNjVWlTdGxVb0VxNm9HSE45QXlxazQzT0tlMUs5?=
 =?utf-8?B?M3h0d0doSVNnV2JtOUV5Qy9pSDZBR2VQSm1LMjE0NlJ6ZDVOWWxLK2g1N3BO?=
 =?utf-8?B?KzBSblUvQUtuN2NOaVRURGpGNWxIUWhlejdYNVNGMW4zNERjaGhUbzFTVGFY?=
 =?utf-8?B?TzJrYUlDajJzK3FIUlJMVHlZOEZMSGVRbjVST0hMUWlDWXZYYktjQit0bnJ3?=
 =?utf-8?B?OWxUVVR3SDVhalcrb05ZcFp0eVlwMUU3RlZYTmF5b2ZEYnZmN1lCVDZkRWpY?=
 =?utf-8?B?SDZtcUtPMGl4ckt2d3krSUFtZk9ZeWRwanJ3cXNvR1FEL2YxZHdHNnpXWXNP?=
 =?utf-8?B?STRJRHR1WmdBRVV6by9tYlNERW5aaG5XREJ5NTY1QXprbWdJVW8vVWU0VTRO?=
 =?utf-8?B?Wk5YSXJPakJMbHdxeDRWNXhyTTRlc3pwc0cvWEJTc2pqdlhZZ0x5MWQ0aDRq?=
 =?utf-8?Q?bly7IMW9NI7jsqCE+39V0rLQf355E5+iY9xsk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bedf7ed-c326-401c-32eb-08dee8eea07a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 19:14:32.8602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cb5Gb3BpjTCP2HbwBGkyJMmvvrqVHJk/TFfso/nvOMyh285/n+bcTM3YBgrikoEef4tozMQMh4eqSwcvKyCQisrxH9EpAg/5h3tAT9Fvfsq/woCUMhyZ//+4ZaijjbiN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6818
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

The legacy i.MX6SX (>15 year) SoC imx-iomuxc-gpr contains one LDB_CTRL
register. Allow the LVDS Display Bridge(LDB) child node under
imx-iomuxc-gpr.

Fix below CHECK_DTBS warnings:
  arch/arm/boot/dts/nxp/imx/imx6sx-nitrogen6sx.dtb: syscon@20e4000 (fsl,imx6sx-iomuxc-gpr): '#address-cells', '#size-cells', 'bridge@18' do not match any of the regexes: '^ipu[12]_csi[01]_mux$', '^pinctrl-[0-9]+$

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v3
- add ranges

changes in v2
- remote status = "disabled" in example
---
 .../bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml       | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml
index 721a67e84c137..49813adce71c7 100644
--- a/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml
@@ -47,10 +47,23 @@ properties:
   reg:
     maxItems: 1
 
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  ranges: true
+
   mux-controller:
     type: object
     $ref: /schemas/mux/reg-mux.yaml
 
+  bridge@18:
+    type: object
+    $ref: /schemas/display/bridge/fsl,ldb.yaml#
+    unevaluatedProperties: false
+
 patternProperties:
   "^ipu[12]_csi[01]_mux$":
     type: object
@@ -67,6 +80,19 @@ allOf:
       patternProperties:
         '^ipu[12]_csi[01]_mux$': false
 
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              const: fsl,imx6sx-iomuxc-gpr
+    then:
+      properties:
+        bridge@18: false
+        '#address-cells': false
+        '#size-cells': false
+        ranges: false
+
 additionalProperties: false
 
 required:
@@ -87,4 +113,40 @@ examples:
         };
     };
 
+  - |
+    #include <dt-bindings/clock/imx6sx-clock.h>
+
+    syscon@20e4000 {
+        compatible = "fsl,imx6sx-iomuxc-gpr", "fsl,imx6q-iomuxc-gpr", "syscon", "simple-mfd";
+        reg = <0x020e4000 0x4000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        bridge@18 {
+            compatible = "fsl,imx6sx-ldb";
+            reg = <0x18 0x4>;
+            clocks = <&clks IMX6SX_CLK_LDB_DI0>;
+            clock-names = "ldb";
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+
+                    endpoint {
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+
+                    endpoint {
+                    };
+                };
+            };
+        };
+    };
 ...

-- 
2.43.0

