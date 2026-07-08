Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D49EC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 19:40:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8755010F25C;
	Wed,  8 Jul 2026 19:40:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GsSInZnB";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011007.outbound.protection.outlook.com [40.107.130.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53A3A10F25C
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 19:40:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTc23XtL8b9/2/aARCbcQ59v/TyjTpWBI0UJuWJJpXEFIOdOaXGkQNM3CbtRAm0uZND7KikiW0egU0pDdsVdwl6mCdg2F7LApV2O/rL+SZHWCmqz2ZUWNwvIVn+1xD5o63LDlUDQ9IJpHjV8cdceNDxJumjzqUgE61pG3qt0adpeG/6jdTTm5YifXb+zRYnILC/5XUgudCrCwC3sp0sv/cIdR5fpDcLJb+JFNXHn74nfFzSeY2DN9Mt+bCPOgMeZ9brMqe+BkiofKENTZOqWS+cdyzrHPL8jTNg8AbIPWmQDIzxCbRt+IP91JnnxAZqQffQlaYaCZlL3BXln2Qs4kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChDaDJfTxgsIAGW5PK8wvhS5UikY2qPfWAD2f5+5/84=;
 b=aE2BM1V7kXIAIsbkAp/j1S/R+rLZw+lpak0UAe9QiLonb3crue2KMTzqQg2L5EnRX4zZIKODjsj4saisMUU6ZAuGU83RX9LQr3LIRCZJfHsN8//Blrn1KorNG5kZe+Tv0IHO+SvtvHzrzN95XTL71XYySSqUQKsK3V36KJEDsy5wfuqZg6+2ilQGGFO8HYtwTSOXmXx/voag9w7tSoeL4n/klXi05V9GRENaIddereZMd1iZyECpv81UoZ8ApnqqR+qmIO34q8GmRl7+/GDsnae9bA+310t6XPmaDphviA7jCzbbOoNyIeczEhI63D98p78leMUkKH4LLs4sj1BcxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChDaDJfTxgsIAGW5PK8wvhS5UikY2qPfWAD2f5+5/84=;
 b=GsSInZnBSLTheIOU72W7/GxxIdHqg6FNUiI7+4Eu7uOgJ7irz6wViQxMGJtldnjVZw02W8wiPQKG7vPxQwdDIvseNnBYvNQ/dKJCgQqJqI8NWHJ5tBxoJlzXs0pku6q0oxXB6VR8Djtbknwo59zVT3eCnPQW1XBv8K6K/wjX8X2RNFyoZBN972TBw6VRV5EUdeoZOxZ9R8a+q7obxj3jPQ7X0RwGSuGKeWKbd7IY35z4MxqoRrNs0UMHeSEBUB4JM5deJhlzcQIgR1XY+q0wAFT042+2AmvjbpsJ71In6retlp5sEe2Wl0ReVsACIVToZGXO63tMK24F6xual1ol2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS5PR04MB11465.eurprd04.prod.outlook.com (2603:10a6:20b:6c2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 19:40:03 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Wed, 8 Jul 2026
 19:40:03 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 08 Jul 2026 15:39:51 -0400
Subject: [PATCH 1/2] dt-bindings: display: imx: Add deprecated property
 display and display0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-ls-dts-display-v1-1-1986b2611895@nxp.com>
References: <20260708-ls-dts-display-v1-0-1986b2611895@nxp.com>
In-Reply-To: <20260708-ls-dts-display-v1-0-1986b2611895@nxp.com>
To: Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, vladimir.oltean@nxp.com, ioana.ciornei@nxp.com, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783539593; l=1741;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=yfbl55Xn+o5XjH63Svzvu1sacU9mqV/cxvj7ae8Sq5Q=;
 b=dv7Fg0tzki5lldVA26kNOPraZObxGacJCPiUsagqx7n86efa/m+RKgsQLQ40eMW48TrpdxUVM
 RwzZpq0AS1pD1Y6bcaZS7e1qk4L9e85JObhiBPpyd4V7THfMD/cqRgn
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:806:21::24) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS5PR04MB11465:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e724de-67d6-4cc9-9b5a-08dedd28b478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|19092799006|23010399003|1800799024|366016|921020|18002099003|22082099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: FHFAMlNe5+1IoCv9s0OcS1WswSeU6gr3NDgO297WaGRau9bM3Bn42/QnavKZ6CsSGS5na66+eG02wonKHOKus8ZjJe7RkQ5rY9dx6Rvbq1RRI5XQGi9BHjmpL5Wc60mpSVbZ1z/61H5rvCfo5HcDroQgDnQTvZzjdgHJkAyMqYhMkSyWuGwKpUpQ10nUOEemnHIPgDimZBDN3ZZEXILzaWQvW6EMbQ3YLZ/wzuV8JYfc3z8jQtvA9SloAWmR/PKd6HZETjBBqKKLfJAiNRWCllJ/6MOPfLoqmE0fFEmXUiXJkhF+zUE1eiI0LcqSFzFRnHPIVeh+MmT/fO0g7hqnWDX7DCj5KIrT9g+dQxaPWbnZ+2ebP3tlJfJE9l5JwfTaMkAnLiBA2vBBEgjZuTJyjJDPetSk9cwsgvfNUioKMWAiu9wdqjexviV9Y0kv9+BIiReO5rz/P/qATqBFgam4BMrkGbNMly+1qjzdreb1LjCFK8xfM/a3kY2Ci1Q0+4X1Fe2Rd2TaeVO1zoYQctqTiP2B47vUXNDANTqT6kbE5dsQd/bN67lerYuyRrInsl2bp9b2dqMPcbkgFzUkixWxhhmom2UWp/MuWYMlx/DkdBMdulnNYdom/ksVjzOqjv0yMWxsQYaj5/dPmbCZl8Y2Z/IOB7iI7Y7CNg5zDoAFl1TW+6kGae+QlgF2WyzPYuoenEGpX8yZP+iThdcsQRMfDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(19092799006)(23010399003)(1800799024)(366016)(921020)(18002099003)(22082099003)(11063799006)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0RIQlZITlYxSkpZSFRTU3VzTG83ZnRYZUtpbndwWjk1THhrNnAveVNqQXpr?=
 =?utf-8?B?NjE4TzEzT0FZQVNrbHRDSjltdDRlY2JkSkQ4c3AzV1NUcEEvZVN0Z2Z2U1Ja?=
 =?utf-8?B?ay9RWmJ0ZmJzY01CT2xaeUNTSzhlUnFVK3dHMC9zcS96N1JsM2hzbkt3dWQ4?=
 =?utf-8?B?ZUplRXV2bmx1ZHRzd2hvRklvOEk0VnZQS2oxemNISjRMUGRGdndOcTU2UDdM?=
 =?utf-8?B?dzFHUTErMGpDeFB5K0JHbkkrbW5pdDY2U2dPQ01EbWpiK3hNOWo2U1U5VUhK?=
 =?utf-8?B?SFQ3SCtEUENwWmlmL21yc1Z6bk5pWGFibGgzUFBJVmJvNEU0TERaMGtKOWRu?=
 =?utf-8?B?bzZTc0tHak85eEJKbE5xbGxyeFhxR2RSOFg2THpxSnpFWnRMbUo5ejdoQk1q?=
 =?utf-8?B?dDR5bFhwalI3WUUrMDNRWm4zb3FpdzAvZmU4TkxpcjBlZ1p1dGV6cVRFMEhQ?=
 =?utf-8?B?bWlDSkQvS3ZRM0ZndnVtTjQwV3ZzUWRScGR5YTBKNUllUy9aMkxnSWRnUHpz?=
 =?utf-8?B?MWgzaU1aSmFCd3N6SkJ6azdidUlkNDdDVXUrZEZhSVAvb3VmWHZjVGV2NmVi?=
 =?utf-8?B?UzVYVlRid3dDZW1oQkVXRHBUb28wYjNWTWtjWS80N0NRZlMvV3JrN0tYUnZQ?=
 =?utf-8?B?ZUtBM2hRRTQ2d25qSEttbnRaUWlIamYyZHJJeE83NE1KR2pCeUFOdGFjKytD?=
 =?utf-8?B?c1kzOVRvdU9BWUUvaFUvMkZyZTdQajU0Vk5UN3RwbjNLdmhrMlJ0KzBxZG94?=
 =?utf-8?B?dmdjSXlnYkgwVnBtZk5MY2VDeTBwbGQzc2xEWkQ3QjgvOEhPUlVtaFBnZUVs?=
 =?utf-8?B?U3VCSEdTd1lpMWk0YmhWQmxpS2FHVkhKTm9SVjRFYlJKcll1MXV0TE9rR3lq?=
 =?utf-8?B?V0JpZFVlbHNqWUNHbk1INXIwcGp3Tnd3Mkp1bzVVbUZIcFVaTHd3OVJmQk51?=
 =?utf-8?B?ZnBTMDg2dEl6TUZoR0JhTjIrZ0M1d2tNUHVEVVhIWjNMVXFlTmlQbHljMTAy?=
 =?utf-8?B?czNOQ0gxclVQSGZiQ0R6SHZUajVjaUZ5TVJqaUprZE1yMkxEYzdrSyt4VTFH?=
 =?utf-8?B?bGFsS2lwUUxzd3U2Nk9McHNocC9DRjdYKzlyWHZZVVZacGlBRjZJMGhJZ0x2?=
 =?utf-8?B?UGVaelVVNUZxbzNMUFdKZ0hKdXNYSnJzMFljLytiakFTSnUzVnZYekp0NWtR?=
 =?utf-8?B?dVM2alVHSXgwdFpUamdyQlNlVmV6V0N0RlArWkhDaTNKN2ovMFlVRktwK2Ft?=
 =?utf-8?B?dlhUM1pzQWlFdHIwc2dPQllrSUVKMm85T3dHVUpxY0pocS81cXp2S1laUmhL?=
 =?utf-8?B?RHQzNDdzUUI5VHdhOFhFQVp5b3hIOFhhcW8zRkh0YjB1U3RVT0FoTU8zVFk0?=
 =?utf-8?B?YWViekg4RHU5Ums0Y2lEejVla25mNHBGc0pQQktmNW5rMEc5TlpRaHUyZTJR?=
 =?utf-8?B?c2tPMmZBMEVsVkcvWVBXMmd2YU9OSkNDWUx5TUp6dTRjUmFXeDJXOHhmcEF2?=
 =?utf-8?B?NkFLcmJlSXc3Ym9aUjhwd3RxSzQza2VNV21BSTFvNnZpeUZXZE9XSTFKNUkx?=
 =?utf-8?B?VkVsMkxkNEdta2dTZWgxeXpEaFRCTCtKelN3WkRUc0hGK1hVMXpKbEFkSm1F?=
 =?utf-8?B?a3VEbUVhYWJabGk2UlU5MHdVWEJzUVVsSEsxSWlwZHJBNzR3aUxidUZiUVBK?=
 =?utf-8?B?V2RXN2FSSTZrWkRBTUNVUUVqekFpYkVMamNZc0tTbzEwaFh2cWZTZEVXYkta?=
 =?utf-8?B?d29CUjk3T3p3TXFVbVdITVFzNHNVWS80UjlvQVRDOE93c1U4VlVTa2oxNlZH?=
 =?utf-8?B?VnpnTGFuQis1Qk0yd3Yrd2FoSXJOVHIyY25WYTJQeEF1cUhFRDFzMFQ4d0lJ?=
 =?utf-8?B?MCtWVzloY2ovQ2RhU1V0QWYzcDBlM0ZSZDRaMmZGQ0FxRzJqTHY0MXk4endi?=
 =?utf-8?B?NHI5WEluV055d3pYWG9sSlVnVWZMK09GU1huOElTcWhOOW5mVHZiTmZKV0ky?=
 =?utf-8?B?bjRudW51aU4vRThZc21KZ1dObk9mWVFINlB4ZEJKaXNZY0Iwb1A0dVVyRGl0?=
 =?utf-8?B?elgrRExaOWt3ejYxbHdpV0hIV1FMSGNHaE5ZMTF0UlcvY0hqNUd6ZitJWUR3?=
 =?utf-8?B?ekZ4VlJTZVBsN1diM3drejVaQ1J5RVBjOHBrWmtYcTU1VXFySEZOQ1RjWXJK?=
 =?utf-8?B?bFU5REM5NHd6anV3Q1BucUdqZUtseS91RmxpT2FnUUhGRlJhYTJnQWtmNGRW?=
 =?utf-8?B?M0E3N1RJSG1kOVVtZHBXb0dlb04wK2lJL2lNQnFDSHp1MnJxcCs0c3lnY2pR?=
 =?utf-8?B?Z2t5S0pTSDI0YTdRZWJ0YWZYL0xwSmdiZ2M0WTNmUTJaZVF4ZFFnZDFXaEIv?=
 =?utf-8?Q?nOVSao8GO6zGOH1hNUsfpBKqTwytfj9DdOJ4N?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e724de-67d6-4cc9-9b5a-08dedd28b478
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 19:40:03.3019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8JupDTaQ1n5U+WrjL3RKc3/YTHigFLC1mafLw7JDJQMn0RItvJATl/dCxrFn0YLh4hVJiESN6hBy5bwjRtHCfeeVKRPN3U2vMxJrlKLXVPC5yfC75ejrb6sh/pz+fF0J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11465
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

Add deprecated property display and display0 to allow old platform lx1021a
(>10 years) to put display timing under dcu node.

Following patch rename display@0 to display0 and mode0 to timing0. Fix
below CHECK_DTBS warnings:
arch/arm/boot/dts/nxp/ls/ls1021a-iot.dtb: dcu@2ce0000 (fsl,ls1021a-dcu): 'display', 'display@0' do not match any of the regexes: '^pinctrl-[0-9]+$'
        from schema $id: http://devicetree.org/schemas/display/fsl,ls1021a-dcu.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/display/fsl,ls1021a-dcu.yaml          | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/fsl,ls1021a-dcu.yaml b/Documentation/devicetree/bindings/display/fsl,ls1021a-dcu.yaml
index 72d14babe993a..6ac5ababbe009 100644
--- a/Documentation/devicetree/bindings/display/fsl,ls1021a-dcu.yaml
+++ b/Documentation/devicetree/bindings/display/fsl,ls1021a-dcu.yaml
@@ -45,6 +45,15 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: The phandle to the timing controller node.
 
+  display:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to display panel
+    deprecated: true
+
+  display0:
+    $ref: panel/panel-common.yaml#
+    deprecated: true
+
 required:
   - compatible
   - reg
@@ -53,6 +62,19 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - fsl,ls1021a-dcu
+    then:
+      properties:
+        display: false
+        display0: false
+
 examples:
   - |
     display-controller@2ce0000 {

-- 
2.43.0

