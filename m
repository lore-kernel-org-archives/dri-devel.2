Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D11C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 20:29:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B94010F298;
	Wed,  8 Jul 2026 20:29:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CN7A1OtS";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013052.outbound.protection.outlook.com
 [40.107.162.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA89410F298
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 20:29:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=he6fieFsOCLdsWB0bkHAfDofwRwSBr4U3cfgPHTnvOlhoLoUxffvTYahUZc3UmIAmxRitmmLADlUdkRhm2kyY0NLKxoQIYeU6N04QQjE9ojS5mX1vsheV85RvvjHhux4DEEUgq7so+DQAKtc5bwdE2nDd7lttYUK6Z5tOsxfI1nKIyrMsOb7SRAblh6lohbqSo/sjBSp2rJEqi3E36BbqK4YBupiMI/otNA07xSf4Awri70in5oRxbLfsEfjn32oEq6Nr6RAs3fYFU/ZkUQ2bpc3lSaBpXxwxrDY7bqzKmIHfeJdEuV3RCjkfSIwAT+gWuMM/s2A0CjxcgtSBUWRDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35xm3DfZsloCTYQ0ZYlWXy2e9C+ek2cAfY14Ny21+Hk=;
 b=aF1fagogjGg5Qde5svMYjJjJuw1I9ZW1hsnhYI88hsaUSjOipGXu0y0CtNPU5jRR9WBFRlplCzfK0jIZ8K4FUaUTtHev5QPECvf6wfcnqHO7nhB2XNFTuiGdjoLFPrDlXhXlrGRKmVxMrQf10XhdtuNevvM1qZMKdmeIWcB5LrrAI4o6YLkjZCRmaZGfKWCepDMwzYy7pNnWPOnWZ5j6iiQ0D5ehUYrkpaGzAdrm6LlL7C7E0BMdM88sYlZVYOsWJaZa408nw7eakeOyvmMLs+Xl/XiVxQP9iZxM+m6JGixecCVU0JuAL6SfdY3aXyAJjHqdZg1OxxZ7TJsjLwuraQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35xm3DfZsloCTYQ0ZYlWXy2e9C+ek2cAfY14Ny21+Hk=;
 b=CN7A1OtSM5ijdWGmawAnv0+DB3xkZdd9wRau9mwWkha8d9HFEn0DKG4nvvnknNa8nPwPXEZ+gkH0za5/V9M12mF24RUdymc6lLb+qtfSK9lOyRyJibCzFjmaf+qdcb5FQN69B9fqaqdwHnbyLtvcNvhBtbm5df/3uQ0iaibW0nTGErLFf+xbYXDpjdPCcdn48HaXAhCLCbxjUGmOxn462LPhmvIu0APojL6GuBggxDzqmJfXAYF9TTmRs/ao/x+31WCcXxevYTs9yt+a5s8CJWdHKT40elF3a6xymkL7QfM9JIbqkHKnV9iDbh2z3wrNqYo3BQS3VnzUnfK6Tua8Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV2PR04MB12605.eurprd04.prod.outlook.com (2603:10a6:150:36f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 20:29:28 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Wed, 8 Jul 2026
 20:29:28 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 08 Jul 2026 16:29:03 -0400
Subject: [PATCH 2/4] dt-bindings: soc: imx-iomuxc-gpr: allow bridge@18 as
 child node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-arm_dts_ldb-v1-2-4f5579b85797@nxp.com>
References: <20260708-arm_dts_ldb-v1-0-4f5579b85797@nxp.com>
In-Reply-To: <20260708-arm_dts_ldb-v1-0-4f5579b85797@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783542553; l=2734;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=qMVumFn9edIzMmTPMT6ngpzxrC/o35cyhHoUwsPReqs=;
 b=8PPETS125xjJmP6jPVPnX9kCCR87kuglHRuHy/dblFWcNnoiqa80/77zcZt9N8wXKg6um+Nt3
 UG/yT2soBTpANdx/W+O5OjpYn89p2HM55YVJVELDvjTZjs6WtGDCOGl
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SN7PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:806:f2::24) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV2PR04MB12605:EE_
X-MS-Office365-Filtering-Correlation-Id: 80b2f5fc-5bd8-4ec1-1c51-08dedd2f9c00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|366016|7416014|376014|1800799024|921020|22082099003|3023799007|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: JIzJ4whg1OZC+qtYsz37EGUgrK02d46Q2ItX16iwy/I57FN4eOf6+z4VvPjIju5L5rf3lHDsj46Y13v8VISCiQyypZZ56rxDkgLi9vQX0wHipIwTp4n4y0G88aCBZrINS8dlBThtkGk4rKp7FsF8ODRDZ1cTNEpjm8bhmmnqOqU2EuexPQM61sx1KPnRQ5nsb57dAV6eyje1MZNK1p3LK2S+AoBKRWFNaEgWZQp+YP71F+NL0Ab7Z1YS1+bd24hAoaFjzfM/I4iUUjROdUKBPbseoxAg/JuTuG2PEDfXsjSfUGf5abKTDuQ2YJJQwkQGhR1vaEwyRivojgTINKPTrtuyzIXC2EiNuJVUhgRjr5ZyJlTztz4gxvU0HS1B44yjsTmmukPkGvPQo4b4cDpFEGqVOlhD3ggV9mbrIXGSCC9CAyDvH4kiOaFIFVXvTgM3V9HG1hjZojYLtsqDCuEblW5RvQMpaI4fURCOlt5Mmf7eVhTPjMVV09VnukcbmIs5JOzPLLAQ4tHLitOltw4pDqqq8S6WcJKtG/cnY5vrrd2JsPGWoG4a4HJoLYE/dNIGwoYqGSMkE3I0HW5pYgzoxN+QxD9O+wp7uFltVDR0j5xg1KkdERkwJY35fJgPggRu0Kge2SRH1iFyDCwVbl/hD//lZHaXcVGjCRm/yDRjZz1JlgzqCRPRhuaUf16y17H6ZGPnv02YvzuG7D/7Bm7hXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(366016)(7416014)(376014)(1800799024)(921020)(22082099003)(3023799007)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEJXMm9vUlhBWGxEVHI2WWp0cXNXRDRqWG1qdWJ5ZzRQbFU0MW85TUNXMlNt?=
 =?utf-8?B?eExCMThFQTBkSWFOdW0vUFVPSHJBeU1zc0hINDlFVzM1ZlNFbXVwNFU1RlVX?=
 =?utf-8?B?Qlh3YzNCY1NJK0NVMmZia2VwTm1JM21MRnd1eS9QbElDdmtCWXRFcXJuUGtw?=
 =?utf-8?B?MnJPOTlNNlZpeDlIRFZiZDFGdS9hUjllT2w2SWtiR0FjRWtZRW8wUkFkUU45?=
 =?utf-8?B?ZncrZC8wUFM3eUNKeWJmVHJkM3hvNFZxNzk4TWdSakt5cnpmeDdYNnR5bHli?=
 =?utf-8?B?NzNRajR6dVBRWDJiVWZLVWRLR1NCblhqKytTc3Q4YkhZM2IvMnRxbmdBV20y?=
 =?utf-8?B?RlJZTjV3aDVKTDllTlp6azhQdUx3bzVwWkNCVU1vKzJoNjJaalc2b1ZmeTFM?=
 =?utf-8?B?eXVMeHFsdHczQ1hHaURXOEllWG5XM0tsWGE5Yk96eGtOTjByam9KSks5czl1?=
 =?utf-8?B?eGIvUzJyeTdTRDJqcVZZZVFDRkxER0hMaTQzLy92SlR5UlArZmgrY2RiYk1a?=
 =?utf-8?B?V1ZiQklCNlk5T0dTc3VSYTRpaUhIczhzOG5rQnlJL01UMkx3allJM29YOW1s?=
 =?utf-8?B?SkIrVHRsM2RVYXVVZ3hIWFVNZnkwSm81OWVuajFrWkZJNldkSnV6aGJXTklD?=
 =?utf-8?B?VDEwaUloNmI3bDg3ZjNhblMzSDQxZDhaNm5wWDgwTVpMZnd6RWZSZkRlTklX?=
 =?utf-8?B?N3J1ek90T0E3RkdlWDBFY3RPM0dZTjFqRWxqWkx0eW8yTlVqWE5UUHNJK3lv?=
 =?utf-8?B?UVBwVGQ3NEpsMFVBdXRPMm9sckFYMklLbUNYWXJqNWRkNGVsTzNCdEpPNDZt?=
 =?utf-8?B?c2gzdHB5dzB4Y2wzWHRteGQzRkZGakE4SkZhYnZwOGNLN290YjFmYTVnUlQw?=
 =?utf-8?B?Qjc3VFV2anJOS0RMRHVYUG9yeDFSSC9oZmNSazdLbE16VGgwNmk2Qm9NczNy?=
 =?utf-8?B?bDVFb29LY2R2MkNvMFY0SmN5Y1JadXJ3SGNqZjgxVkVJb09jVlhlelNWdkVZ?=
 =?utf-8?B?aURPa1g0cVpiQW5xUXZCdUFLVXFyNFFZTytLWHZpSUUyRGlqaDEyTzRwL1I1?=
 =?utf-8?B?WXRkOUpIcVp2SVB3S2psSmFZcFU2WGI2eDkzZ1oyYTd0dDhNR0E1VnZDSnMz?=
 =?utf-8?B?VVYyL0d6WGFyczVRb1BNT3JOK2UwNWhzcnlFeVpPUS9jM0s4NFMvS0ttdEQx?=
 =?utf-8?B?U3YrUUNuWlg0OHl5alEyVzdxRndrcldkZ1RqZFVJYkFHUGozanpqUFdubGlG?=
 =?utf-8?B?QUtFRjQzc3hKSU1NbUNEcnRESlRwN2JlcklMOG1UT3BMZ21qNlVsSEFzZjBS?=
 =?utf-8?B?VU91cnZ5NTluQjRmaHVHVlIyekZqYlVyNG96MVowUFZieEdEUGJMN082TDh1?=
 =?utf-8?B?TGJxL2JqOW03aWRReTJqTWwvd2R5bXBaSndzRm5sRnU3VUZGQ0dsRGxtZExl?=
 =?utf-8?B?SzdNelJaaEFUdWlqclU4c0RLc3VKRDBLV1B0elJHcHZjaGhheU9aL0xiOVRH?=
 =?utf-8?B?UmtleDJobTJFaFZURUtObGZUQmhtaC9XRGRZeFpDVVdwSEVoRHY0UzJNaHdz?=
 =?utf-8?B?SEtxWnZIcWwrcVQxd1dlQUY5WmZidnF5VFppL0tzRnhrNlI4QXo3SkVXNkRK?=
 =?utf-8?B?elZURDhkZHNYS1cxRU9vOGZLejZhNTZmbnJNVkpHY0RMMG9VdDNnUUd3dUlp?=
 =?utf-8?B?ZlZYTUVPWHF2SE5CcjFjZXRwM0hUaVNlR0tNTjFKdUgwWGZ2Yk4xM1FLQloz?=
 =?utf-8?B?MmZFTzQ0eVFKaXJudFNHQjNJdWRmaEx5blFDTHlFbXNWTlJlOWo2ME5kUG5v?=
 =?utf-8?B?ZVdYaGxxYnBwQS9uclZJRk9PUG9kdE5pNDV2ZkYxb2oxNjJ3MHUvcHVCRjQx?=
 =?utf-8?B?V3ZydWVOQ3ZBZ2VzYXhOWmZQUHJIVWc5Y1ZXVUM4Y2haUUVqSE9YSmduSk93?=
 =?utf-8?B?a3dPYjd0WGR3WTZDTHlFNXBqQ1kxS3BwTk5oVDQxN2kxMkxkVWxTMEx2cjZw?=
 =?utf-8?B?T3N4cWJKTFRST1ZUcENtSUQrMFNibzhCcm1ReVlKL0tvcVB6dWpINnpIYmkz?=
 =?utf-8?B?a0kwbVdoRFI1NVpLT0RRakFmMU42YkNLZVJwckdpSVFkTFY0dFI5eUZaODJP?=
 =?utf-8?B?aUp6Zy9USTQ3c25mZkZ0R1RqbTI1cTZKWThZeXhTZkV3ZjRqTW9yQzhMUEFX?=
 =?utf-8?B?OS9OTWJ1dlEra0FqbENXeXlRLzNpWWlrWFdaOXh3ZnVPd3EwS2RzamFPK3c4?=
 =?utf-8?B?dzJ4ZExOdGkrbkNFVTluYkJXS2szb1o2TERLSmxCQk9sdzQ1SEt0NmlUZUdU?=
 =?utf-8?B?dDYrMU4xYzM2ZnZSeFAvS21OL3dNODJmbE8rOWlDUU9PWGVGamxNaDR3SWth?=
 =?utf-8?Q?LHGJeNwvE2sb38DxaDCdn5gneKgC68E43X9Lj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b2f5fc-5bd8-4ec1-1c51-08dedd2f9c00
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 20:29:28.5417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0HMKsDZsmJFWzuDc3P7/hK7Dl+Ozto+LBR0Np+2+y/WCL9y6VEkI5CMNhDxOlH+XBKuEbjdYUCAErLbI7zICH84aUXaVRit1FicxNihZ4bS0MfRt7/F9Xzi8WWkRXdT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12605
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
 .../bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml       | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml
index 721a67e84c137..c3b942bbcd6da 100644
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
@@ -87,4 +110,40 @@ examples:
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
+            status = "disabled";
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

