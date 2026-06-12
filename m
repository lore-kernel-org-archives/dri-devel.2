Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52D9CD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 11:59:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20EBE10F43B;
	Fri, 12 Jun 2026 11:59:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OWNFif3z";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013053.outbound.protection.outlook.com
 [52.101.83.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 925BE10F476
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 11:59:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r30p2NVv1ICJXvp+X0TvYSdUEY7AAEIbqiqtxu08yj5pXAF+bkCu8q4jvhXs1tWd9nrmDf2W6SNx8tPY13thsamw2nBB/dAD427yfDPsQj2r4EBH3u2As6+QC9ORrsAuurUYjQqEhPZjxMB9KxySQfs7ohfUZhNXvrRZu3TpM+86//Qw+ESgfy9Ef8vkVcEApGGcDGW2aqMzJTQIiCVms+sLLTccA+8+saS9ugTmgE/fRftEY+idm+G8jZkZOdMFhvp5YhfxFiLHq97ssrHJcjdA8DG/uCs9+xD/3OiZemc/xsenYR9eToyu0V9695DaOt0JoPkW3mIYHWqwYM6v5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjhs6+4aHpmWHwKW7uk/H3ZWC2xLvfNxtDaaOea8wP8=;
 b=M9Ex3hUkN17sra8vG4pY/umWypxP9RoUl1wyTkIXaSeeaGABI2DRYtbh9Mue7lEpISIz/MTPggmpvP84eyY9Jzibk9CaJfhxf9Fj38odDtJ7n3MAyXxoP+8AiiS+ZEFsAuLmfnOtbIvziGXyD4+xZV/Y9t6liP1s9rNmjciHs/gGP+RVkdYE4wlPjmTVupllWCSJZ25eubTTA4fN555e0uJeg8cY96pxROgV5OceSvpS3h0glGWUdyYwh/MLiEo0s1THl9Pzgy5h52rvmwZETe4KG3psH6dB3y+1tmEc3FF7I4aikdBYU0Y4R0xijY+3W7KtUPtUx+9IDqK4mczdJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjhs6+4aHpmWHwKW7uk/H3ZWC2xLvfNxtDaaOea8wP8=;
 b=OWNFif3zn8kI7yqPDsOBYlw7Wae7YPkIZOi4QC6ouQJUYJl00V4iDBW96gTPING5K2WwuxppCeFFZGPgaMqIVS7ya2Wo1DoQXIt6VjDGuh2GnFMAlIhD/+8ORn6mGYVCmduSfWIj1NXkFGdmsiIwn/0/B1ZmORf2iarc/Fddrp6t1tElesHBj4AWMezgDZC8dxlLPdgD7u6EYJ4pSLAyS1ycyD8MDPyDkHNCmocm8OGaI3QUrIXF//wp3K/MSrU5oETlsdFDzM8UP+iyWEcAnHE/B/NbhyQnUv8Rs2rmbFVsqASgEW63uytJ2p/OZ3Ng/TiZcYq2ew8IQylPdL6A+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by GV2PR04MB11710.eurprd04.prod.outlook.com
 (2603:10a6:150:2d5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 11:59:09 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%5]) with mapi id 15.21.0092.010; Fri, 12 Jun 2026
 11:59:09 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Ying Liu <victor.liu@nxp.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, linux-clk@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v9 6/9] dt-bindings: clock: nxp,
 imx95-blk-ctl: Add ldb child node
Date: Fri, 12 Jun 2026 14:58:37 +0300
Message-Id: <20260612-dcif-upstreaming-v9-6-8d0ff89aa3c5@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612-dcif-upstreaming-v9-0-8d0ff89aa3c5@oss.nxp.com>
References: <20260612-dcif-upstreaming-v9-0-8d0ff89aa3c5@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::33) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|GV2PR04MB11710:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e484a1b-2bc5-48e6-e307-08dec87a030d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|23010399003|7416014|1800799024|376014|921020|22082099003|18002099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 1+LeqrT23covACUtxEw02EpmcovX7aGGZKtkTcplohgSt0EflwzqJxEyiEhm4eAduhZDrKWM1hAmFtU7qrID9MdX8utjF4X/0vDLaK9e+B323wryJ7tteGutqxLFPaQvl7/hQJxTA2x/mSdgDJpse7TJigc1+riqadfA+020M4WldTcReltY6OamxyoEO+ISYXdy5eFrDVzi7wuXagelOhKefdPh50vjFoAaBGhAM4TCnGW/V5/xM0gyodYcnQKm9/voxoU3BBD2hBRx6L68GqVyAiXxxYSAnx0YYOkAOzAD7OsGV83npO00mOKwb1zi/69VBqS/KTtkuIENvtttGVmPNbD5guo4dkbyaWhb8HxgnW9B+EXQWkCvhfhb9RKhteU/DO+RyKmNGoB7k46Pc9Qnk3WJxRkzVotxKmI+IjcvackptWADkZQ27YAAW1oz+tOwX/fArHuf72oA9jR+kHLrmaHHSpfEHlaEQZMcSpJB03HOCLnfB4s2iPG4wnDA8ZMFNMdOaioj9Z6KdXbcn9Lhq4PqjlZhH1d3Qd01TSKz1h0Mg92mrp4lqSrQUvd3aOXLBuo6aua8dLCdckk30Sn/qqxMehWBkJWXTWMHmIDk3Cm/3Yen2dU8qgA+dumCLqtKr1hGnLrGlKyIoEVK2EPqA/J+4Z0aU5W4vnTjQnHCN+euN6GEcwi12HZseUCEQE3ho5h/khxQ20urQ6V1ZmNcwUlg5ZcINQjSOABHPpE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(23010399003)(7416014)(1800799024)(376014)(921020)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGgwYlYxRDFnZjJYTjR6QjljZ0NIOEV2ZmJkSHkxV2hZZFpzRk9EdkRxZEll?=
 =?utf-8?B?YjU1UGtob05xSTFWK1dFNW9BcUpzWThpL0tMNXNyV3F5RzAySkV2U0JzY0w2?=
 =?utf-8?B?YVVXTTNCclBYMnI3ckRYS3Y3aXBsODUvYS9oTmZadkhzTGJkeGRxYmxpSGJi?=
 =?utf-8?B?WjJxWURvZFFIc095aXlmYjcvQUtmcUo5YjZQTVphTmd3Z2hzcXBHKyt5VTE0?=
 =?utf-8?B?QmlBeTlEUEEvdTFSbzlzeU1JOE5vK3pUZW02c0FUZXlIaUpiKzFhTGphS1ht?=
 =?utf-8?B?aEs1NVJZUEVCbU05U3pHWUU3T0wvYkkva1R6OHhUVnBLdUc0WXpYQnREVVhv?=
 =?utf-8?B?UzBycjNkdWM2RGRjd3hjUnB0Y2xVTnFnS3ZQSDZ0RWk5MmFMb2NyOVdXdmRs?=
 =?utf-8?B?ZFZhS1IwZkNwRVpKOFZ4RzU0a3VGbHJWZFk4dzJIckl2YkdhaFgxVDJ4U0Yv?=
 =?utf-8?B?UkV4c0tXNDdRcVlkTXFmb1hyeFhOY1hzT3JuSjJxaVQ3ejU5VDZnZk9hcnRW?=
 =?utf-8?B?WWFWcDFXRklTeFR0M0wvWklTZHc1WS9VYitEaThjTW1iZWFoSHM1anpJSVB5?=
 =?utf-8?B?VG90b0pWbDJEYm5pUkVOZ3lkS3Q0aFQ2QmpaVm44azh4V0k3Qlc5bXdOdzJP?=
 =?utf-8?B?alNIdXZ5UHlkUUwwUUNtL1BHMXB4QlpZWXVobWtBbDZaZE90WkhVMHhJUDU2?=
 =?utf-8?B?YjlIaGFOTDBxc0VTRVFlQkpoSzU4TndLVXozSThpV1l0VHp5S0FpREJxMjVk?=
 =?utf-8?B?M0JGN1h6SE9kZ0JYWkhkTVU1OUY1eWxFaTQrOXpBcjEvRnE3RWg1VDIyK05j?=
 =?utf-8?B?YzZxVXJoenljRVNKUm1yTWF1YzVlZGRKSmxnTDRFRWJFMjBUOW9mSXhIeHF0?=
 =?utf-8?B?ZnRBL3VjZllha2Q5UG9KaTZWSVJkUjQvZW9HNUtwOTYrbW1MbmgwVW5RWHNn?=
 =?utf-8?B?Zzd3b2V5YkpQbWZ6ZU12SlJtdnhYaVpPRGQySDUzQk9SZVlURzkrTTdJbHBH?=
 =?utf-8?B?UFlsMnZaLzRkWUxpM3g3NHJsRGkrYitVWDg3K1dXT1pkZ29JZ1Rna2liUExP?=
 =?utf-8?B?Tzk1d3hxMHV0aDQrTG1LN01XZmk3KzdGV2d6SkVocGgzKzZMTTJRUjkzTE9T?=
 =?utf-8?B?MVNWYTgyY2U5RldnSVR5U2dCU3I3Zi9QVjZjUFJlR2crclROR1JCMFBWU01u?=
 =?utf-8?B?TjNwUGY1THRjZlBSenhocmpyY1dvM0I2d3lnU0p5U1RDRzJUZVVMbVJoblla?=
 =?utf-8?B?RkI2SXZJNE5CNWY3RitzdTYyNmxxNVNvYUsvcm5GN1NZVEdFRWc4Myt5V2l2?=
 =?utf-8?B?dEFUbmxUUkIvbzIvTGRhQTFVWS9HbFRxQzRLaG9HMWh2WXdkUHJzZjhiVVhG?=
 =?utf-8?B?TzNUbDQ2OWNpNnRJdUpxZ0tXSG83cG9QWWY1WStXOVdKbDJsSFBBOWdNQXRX?=
 =?utf-8?B?YmpwTldjTnFROW1EK3FCanZoZnlFaDczaGZVZGZGWW02Y1hRWVZxY2dVbmdy?=
 =?utf-8?B?TzZpUEdZNWZ3R281SzNjVS9tMi9WandBTEUvMExHVVRpZXRZVjQ1RFAwUVlE?=
 =?utf-8?B?MmNKN1lkTTgzU2dZVmpXbktvTDNQSE1NckZ6ZVpXbExETmExQVhsV0h4dDdX?=
 =?utf-8?B?dFdrbWNIaXRPa0MyMG54NGkzSUd6K0FYMjZDa3ZEQklSSFNIQlZ5UmRQMTdr?=
 =?utf-8?B?eFViSVQzbXloZi9sU0V6VWxWZU1scm9MQU5YdlVIZzhzbjcrUXlyd1FXeXZq?=
 =?utf-8?B?RGZtUHRReEk0REtyQ1gwdVpZcWh6NTFSRVhSL1BUK1BaN1p6YU5BNXJ0cm1k?=
 =?utf-8?B?TDRKeTJXTU5NMkpKM1dveEhxbWJWRHp5TldRNDc0aVlDc3FNdjc0MFhaQVUv?=
 =?utf-8?B?Zko5ZmJyUSs4SDBadlI5Ym5kb2JvcE9IczRDOTBFTkhnc0xQMWRSR2Rvdkcy?=
 =?utf-8?B?ckRFbHJuazUrSDd6bVpjOVZjWjBDdzFlVFp6OWpDRlhqZERFdyttL3dXOG9F?=
 =?utf-8?B?NHlCM3FjT2tsY3V5Vk1UcXFSeWxTNVJDMkpPMTRDRzJwSGRGZFpsemYxR2tC?=
 =?utf-8?B?L3Jhc3pVTnhuNGN0ajZZckRWYVJFdU9TS3JVa1o1UDM0cXMvTytyRTNQbnFq?=
 =?utf-8?B?Z0UzVHEzRWYvL0xyRzR3cXhtZTVCK1BsenU2eVlzNFdOOGJqYW1jVXl3R2ZL?=
 =?utf-8?B?TG0wUlJhekRrYjF0SjlJcTRoNzNvWVE3Zlg4WkdMRXVndkNiWXU0Vm52bzN4?=
 =?utf-8?B?aHlKVE5IOVV2RHVMT3UxQXF3elN4eW9IU2RVUGdZaUwwVEI1czFlU1dGNStl?=
 =?utf-8?B?MXF0R0pHMXhhR3NDeHUrTXdIek5kUEI2WFBSRmQyQ2dNYkl3ajg2ekg3WThN?=
 =?utf-8?Q?katuUs1pqXCY1I3U=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e484a1b-2bc5-48e6-e307-08dec87a030d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:59:09.7769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YL7d6fAySXsl6HfZ1INZQa4VPbcY2SxG0l8qaKtyJgELO3O2xqpVncA02oGtvFVIfBSBd+qhQ/pGgMMxpyD6tg==
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

Since the BLK CTL registers, like the LVDS CSR, can be used to control the
LVDS Display Bridge controllers, add 'ldb' child node to handle
these use cases.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 .../bindings/clock/nxp,imx95-blk-ctl.yaml          | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
index 27403b4c52d62..2b3c762aba1e0 100644
--- a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
+++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
@@ -26,6 +26,12 @@ properties:
   reg:
     maxItems: 1
 
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
   power-domains:
     maxItems: 1
 
@@ -39,6 +45,11 @@ properties:
       ID in its "clocks" phandle cell. See
       include/dt-bindings/clock/nxp,imx95-clock.h
 
+patternProperties:
+  '^ldb@[0-9a-f]+$':
+    type: object
+    $ref: /schemas/display/bridge/fsl,ldb.yaml#
+
 required:
   - compatible
   - reg
@@ -46,6 +57,21 @@ required:
   - power-domains
   - clocks
 
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: nxp,imx94-lvds-csr
+    then:
+      patternProperties:
+        "^ldb@[0-9a-f]+$": false
+    else:
+      required:
+        - '#address-cells'
+        - '#size-cells'
+
 additionalProperties: false
 
 examples:

-- 
2.51.0
