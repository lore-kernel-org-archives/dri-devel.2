Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501DCC4451B
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 14:46:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A67E710E5A7;
	Sat, 18 Jul 2026 14:46:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vn6lZ5XU";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012036.outbound.protection.outlook.com [52.101.66.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33FD510E5A7
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 14:46:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AONm7dulsi1V4dYJLU3H2khoE7fjJ4N/ZOatRC2Uf6B6KlBnWNssRLOUIhIII4lduuXuomOUt7s1/nwyQW0MOKvPCz3BBt3ZQ2KZBCWcWITmpA8p7E8qIKl0064dn9bzFP71znbJY0GsCK3rx9xzAUKp7f2nnQsagsOciOmRcxYKldgiB12TLN6BlQiX0q3LSFkc0fJcoepyagyg86Dhr5b+HR5RYcMIdYxUPFQpMH9BcE608zxsCmqhH+7Fne4QWbmOhqHD77oR3aEIdSY6wCIpZMW/j+jlvVLaUWq8oN/MJh2jfyDFnjZYMluX35EtyXnjNy3Oa6NxI+v2sQ/eZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bf17jlRzx0KwMh5VPK/nA/BbisifR+J/9RroCYMqoo=;
 b=AYGzTpSsDaq8m1QtbeQk534r548tsY4N1LOQ8+h79G383ywO7AcgVj9djNJNMSzmHlGeBnhDRkWWuBk1liyvaNgjBDeph4SW8aWD9qx3Q4UHxah1BSydwF5POwNmcPgKLSRePnVazge0/CmFQ4DBSnmQx0ctpLBDBFYK46lNxw9z6jzS8K7N/fE/l4R/335jIuWQcbwAx5OpuG6Hq6GiAJUFWXcCewuTgNnnEf3bEMcTHI8Kz0K/CLy5I+ibYGaM10cv0za9SGWf0nIQb0vnbdQObyDCrHhNjxLl3876ghMkrb7iPQ7EjtaeQIr/hlQXzv0JIcRUKwh34BhxoTrwyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bf17jlRzx0KwMh5VPK/nA/BbisifR+J/9RroCYMqoo=;
 b=vn6lZ5XUGTZMohWVRI7pTnWOCEuQxUyEb3qZCYTjAyLX+Frq/nOKNBkz0xF06vQDZj+g7TRI4WopF9vQ9FgOj1In/JdCv0OoMfneFL80rLFhx3EKcOQfungZmNXhmVTaGNLPhsOm2WCw0TfZ+RL5wkRjeCcwofUEwzDpUbuT0TAZTf3tWd4KrygYQAJ7wOoPvn9xJAv+32zyHoX6NOTF/HNtVNImg0U0RMn43herFUytxFVEL+jlgL6eB7mJkFRCFkkxL+t/K1CIS29icTfYav74Kedohnj1r4dajGAz5aeaUfHbFIquRMOpIi2szuYwOh59Ino59cyUf+/3wj4EPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU4PR04MB10481.eurprd04.prod.outlook.com (2603:10a6:10:561::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Sat, 18 Jul
 2026 14:45:56 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0223.012; Sat, 18 Jul 2026
 14:45:56 +0000
From: Frank.Li@oss.nxp.com
Date: Sat, 18 Jul 2026 10:45:33 -0400
Subject: [PATCH v2 2/4] dt-bindings: soc: imx-iomuxc-gpr: allow bridge@18
 as child node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-arm_dts_ldb-v2-2-f5669571aa2b@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784385940; l=2760;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=cblu4EP+c+/Jn8Y6Yr5qVDacpWSkKKrX0NaHE4+xEBg=;
 b=PEjcOb40rHN0XV7BW9n4WyazRu6WxAvlScmLDFes03OajR8e0R6YwTUrBK2P6Y5YSdD5H51NH
 dclDcUv6hx/CRkaexc+uEDMJnvCnk/i7gdE32/0xG3rC3zRCJbVmhbD
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P220CA0057.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::20) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU4PR04MB10481:EE_
X-MS-Office365-Filtering-Correlation-Id: 71fab95b-da22-4536-1190-08dee4db4670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|376014|7416014|366016|1800799024|18002099003|10067099003|22082099003|56012099006|11063799006|3023799007|921020;
X-Microsoft-Antispam-Message-Info: ivzkjHO+6L8PykuGuXf0JmmszTBUpgHUtxbdD34+6MHRgZJIMkjIpD4+Qs9ZeMNTpWRHkk7zS+QRkCwv9BZLyxF67xnUutYCMXihGxRCzzmRUzi8mvjnFkSsR65Tae/2Z0uLyaCUcBQwFUUNo/b9WtWaodMK2DSC3DSCraWWyVNYhrsqFi6GWqRLa5Gwgw/bYQJJmSge9TrjB/LpI87p/+El5CBnRpNzUPh67cqVTvrwHYhge2EvdIfalStHKRfipJ59mdaaCZUaLMEqz+zpbSP2Rz1T0Fh65mqBkYwiQye9ngqq0YyovRG3eubFtxzMo+jbx2LhlVzCVFakEC/6z/D3BfNveJs0bV4b6GwtW2FRWeEgtJWzFyjGM0I3N8/N0WjXhWL/fl7ERL2QIGIPdVFUZXzgCI53VVmpoLugsA4zKi7VbUU536jXuhaPWefmxHJmWLTu9WiwSQVj5TIJJNVPYPWnlFPRbiZe3fWNKorKkd3cJKpBO8HGgZ6volYbpSUyBR5qto4x5OFQ8FeRIp5IzcDx+mPCznlbAxT6xOn8e43qVwsV5yYMphksvqypA4+93WA6SmXLVjDu3sDTFU0KexWuPBoKbP4qv8lETc8zZyG23qR9h88I2Zgpwd70d84jmbU5Dje4jvyGhbY8r7u14J9xVZvA7KGO7VakCuBcpI+wwO25sj3ycRdcPEkrYEFB8Tu8YRrKIhE36Qh5yQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(376014)(7416014)(366016)(1800799024)(18002099003)(10067099003)(22082099003)(56012099006)(11063799006)(3023799007)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVJvakZLRHEzTVUvQVdXSnhpNVEvVlFnNTlTb3dYRHZSZ2t6SGhJTEo1Wklq?=
 =?utf-8?B?bW82YjZKQWZ2ak1GUnVuMDVyQklPQzB2NkczejlsalRDakJVRVlTWTVpVlFF?=
 =?utf-8?B?bWxncmMxZWlRUENDNUtVVjROMm95UGc0Y2JJNVRnMEJETjVsSDdBekFQQUpa?=
 =?utf-8?B?eHI2T2ZMc3YxVDRuWGU5S2granA4RjlYSmRualpTNGZraVBsYWhwQ2IyQ0VF?=
 =?utf-8?B?d0Z2TW1xT0hrL1U4ZUt6RU5VVHd0U1gwdURHaDZvK0N0ZmNKNWJHbWtrSmhF?=
 =?utf-8?B?eTRORmFOb2ljbGJBL0ttOENpUkJyWC95YkZVdnZ4UWVaeTg4SnQ2NENwaXpW?=
 =?utf-8?B?TzV4S0ttU2hNcTVWcDh0WnFVaHhZRUw4QUJkaDB0ZGsvZk5NZEpOblU3MXdh?=
 =?utf-8?B?VnY5ZDNyUUZlUnIyV3MvUHdERjdsRE1zWHNDbkZNc3ViQkx0VzZ3YzlRci8z?=
 =?utf-8?B?YmtldHUxaWkvblg1MkxNRU1RQkwrOGhjYXBsdy85c2lYQkYvQnk1WWg4Y2ZF?=
 =?utf-8?B?OUJnTzc3VEx1SXFhaityeHoremhoTTBtYlVqRjN0QitKUkpYMkQ1TG9EQTk5?=
 =?utf-8?B?QmJmdis5NkRIQUNzTkhjcTk2VzcweS84MWVOc1dRaVFIWUxld1FRdVYyN3Nz?=
 =?utf-8?B?K1NyQXFqTTNEQzBwdzMrNnpmRTNobEl3WUp5YzJlTTJ4empLck01REhSVEdK?=
 =?utf-8?B?VUczeGcyV2k3SFdaYW1TNWFQV1BGOUw3d05lS1Q5cnRuMVNDTFlocnNxSGdE?=
 =?utf-8?B?VVNSeTFhRkQyVjZNRzd4QWcxUGNEMG1rOFJSRDhndDBmTVBOM0labExqUW1k?=
 =?utf-8?B?cXNDYmppQnFET21DM3YxY2ZIU0hJMEw0RXdHaW5jdzBVZWF0ZE1sTjhkZWJZ?=
 =?utf-8?B?WFBTZm1DQUVCOGhyUEZEWlhPbUtPTkM2clNFZ3lUR0w1WUJydnVnTzdnRFM2?=
 =?utf-8?B?aVZjWXBnVXBCdlRxQkd4Y3pSUEdEM1NhelRNa3p3NHZGRjV3eWs5VmZXNmw4?=
 =?utf-8?B?d2FneVlEdWZHZVdUbVFSWDIxZW1WN0xRNGZJc2ppd0VkMEtkWnE0di9rS3hi?=
 =?utf-8?B?c0gwT28ySGRmNWszUVpaUXR1K3psWmZOcVhrL3lSMVJUSUpaNCthUU1CVUx3?=
 =?utf-8?B?eW1CMDRaSG10Lzc2MStJZkdpbEZ5NGl1emg5L3JOV1Q4M3Zod3ZueU4ra1VZ?=
 =?utf-8?B?dzc0MlUvbjRFUmQ5UC8vSmZRQkhkV2w0SXFDOUlGMGlYRThpcjJCWVpjcVVs?=
 =?utf-8?B?Yjg0MWNRMnBtV295V3MwMnZmdUlpc285cEM3TEE0UHhKNlNST2tSRXJwY1pN?=
 =?utf-8?B?M1M3TE9RVnRIQ3pqS2VXUzlBN1NMT09iUXY4OC80S0NhSWhyQ0dna1BMUE11?=
 =?utf-8?B?UGR0U294K2FPdko0L3Rja3M2Uld1REFPTUVpc09WUy93OU5tOWxsVEZHREx5?=
 =?utf-8?B?ekh3MjFFanN3dkMvem1QNCsyYlZHdjZ1UUNYMXRBc1BneE5yQ3NzUDB3V0JT?=
 =?utf-8?B?c1krdmovT0FSRmN4Y0djRW5kdDhGZm5rV0Q3QWhsd2o3QjAwblBHWDM3Y0NO?=
 =?utf-8?B?aVZUc2EyYWsrcldFdUJiOW12N1JVeUlWQms2TnJScTAxZU9kRDJDSEVMRmZH?=
 =?utf-8?B?NmdTSU4zOE1GZm9vOUVBV0h1N1RkcTM1SjVoeURGNWtJaDE1SkFielBoM2hw?=
 =?utf-8?B?R3hRcmVuQ1ppMW1PRmFCclNVRHhUN3pYa1ZyUWRpZmsvKzJCTUxaTm14T0t0?=
 =?utf-8?B?ZjUwSy9rMnBhZXBldmVJb2NMUjhoZ1pVQ1lIWTl3NW9OTFRLc1dCeHg2K3Fl?=
 =?utf-8?B?TTdONjRwekhiN2lOMW9KemZuNWhod3RRdTMyNTR1OEhqSG5VNlNHSzVKWjFY?=
 =?utf-8?B?RG5WWDIyaFd6VzZFaFB1NkhoSFR1Vk5URXNFMHMrZFk5KzE0eStWZ3NTMTBx?=
 =?utf-8?B?VzdzUE1zR1k1eHQ0SnJOQU9IZjZzOEJkTGZMcFk5UTZaRmkwMDB3R2kyeXRX?=
 =?utf-8?B?RHRxR2R0UEtwQkQ0UEJhY1k2WlhWK2lYTjRLcmY2aThaYUNGQk4wSFQrMVBy?=
 =?utf-8?B?QlZNdVZiRzBKamJQeExCYm81Z2IzZ3hPdmhZRGFDdVFPNUFoeDdQR1BNUGxt?=
 =?utf-8?B?Z1VUZUU0MThWeEtvSy80aHRSVTBSWVpxV0pZMU51RmZSdGpDVXp0Y3VqOExO?=
 =?utf-8?B?QlFZK2Uxd0R2V1AvM3g2SjIrZk5wM2RhRVA4THM5TnpPakQ4MWQvNEhva0VF?=
 =?utf-8?B?aWdBZkpQbTJVWTUwZVJaYjdBUXhWREdreU9GaERmdjRIRzNvckZCcjlxVUM3?=
 =?utf-8?B?MDRPZUhsMEFhbHVzRERSTnd5b2hBaEdzOE1MbHk2SSs5N0p2bytWbWtHT3ZM?=
 =?utf-8?Q?o0KZi8vc3kWEg/wHz0fjFgoCNMOZlmiHbJUZ9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71fab95b-da22-4536-1190-08dee4db4670
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 14:45:56.5423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: akrgBYC2VCDXchW/yacTWSFMXCjKYyFoc6oGkQeWuiskvc6FF+ZgSpdVOEqp8ZY1+SN9oP2K+PLBom/mChqtH3QmJ6LWKj3UWysHMSapLpi0cyVzi0jHuG4iAzc8AgJk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10481
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
changes in v2
- remote status = "disabled" in example
---
 .../bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml       | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml
index 721a67e84c137..1879638918bab 100644
--- a/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml
@@ -47,10 +47,21 @@ properties:
   reg:
     maxItems: 1
 
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
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
@@ -67,6 +78,18 @@ allOf:
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
+
 additionalProperties: false
 
 required:
@@ -87,4 +110,39 @@ examples:
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

