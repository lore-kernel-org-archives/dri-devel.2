Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4465C531CC
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 19:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DD4D10E35D;
	Thu, 23 Jul 2026 19:14:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DvOlZgix";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010063.outbound.protection.outlook.com [52.101.84.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79DAE10E40B
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 19:14:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YcwS5cpfFHLMIuUnKJSNNAWZsecXFqPTASLy/GS3Onc/nYjRwd2WuAdArpC8RAcxHA4GfvkTyhNGm1YlwKyIqLhh5IxHLm7h/wcrCS3M0hFlHh9XBsPUA0F4jygHt8nZd9K0OFiYA9El/OMkAx9i29ZzUD28G5srSmBXUtik0I/AfRT4sQu2Y6sz8SA44N6VIdiAxtfHU7e2vF/2tD6mK1hYtn3w32HPVI5/I9UlFWlJolMCz/TPB/73qeUQjkCg+a889U/dwbdyB4k9mQLIreAxdgYrDuSJBMIeqNtaBTqQuBPtC6NYdHQcxVQ3HKYmH61dUxQZnWWsDn3xaWQy4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOxZ0WN32xPCAaKqxghWqwZ4xVRw2rWr8HaYUb3aCA8=;
 b=b0bMp/ELKn+NSf0PVUODivLQ6SiUd8TzqxWZQ3WmV3H9ayeBUj+g97bMwDqgc0y6eh6SgjcHehXyCLwrRuBgZ0siwsbsfopL42ARsuz9QwIYWr/oSJt9l78qxsWBE5b1DoK0QD+fcl9n+seZT8s5NOZbuAEhBPzeUVdeFXFWN3ZBzmm2e5U9ZEhvZZS0FBn9JR9E+XkdLOsRaTRYavaoMhJFTHcqYM1NBClqyAAsXHakvUWyTbuRVUF0iSVtyPCSW542vWCooAB7RrAuMHNDVxKeGXFPuY7iw1Pn0FO6qbwL1Ro0UIcEXGbwPKow8+Y+LHZccgYEbMp7WSBudUISDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOxZ0WN32xPCAaKqxghWqwZ4xVRw2rWr8HaYUb3aCA8=;
 b=DvOlZgixG4b4x1Ul2HjxXUmpS3yrJn8rpQQhsONF+QLAolCS+2pp3rzkTcmKr3eyHGCTGbSACafWoQA+O17itGti7TnfKspU3EvfnvTSy/luz7TntVxM6him1ZXPGm/QL2yA4x8v7eZwBNrpb1Iouhc28//929Qe/pHlb5AS0IeJI9UzbzJmqeelC1f/DHEcdfVHHLwk876IU1P9NAC7SFYVl3tj7hxC+OHxsZbwS9uz2Tdbv14TAOpBWWEtCWPhDnVbQKpQaXeyiUPwHARZAkqrjjsORN9FrpMU8yviMj9ZYTsOEFYSnKkfzCrnhJBDiD2VUL0kUuMnyiIzIrs4QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM0PR04MB6818.eurprd04.prod.outlook.com (2603:10a6:208:186::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 19:14:28 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 19:14:28 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 23 Jul 2026 15:14:15 -0400
Subject: [PATCH v3 1/4] dt-bindings: display: bridge: ldb: allow a single
 reg for fsl,imx6sx-ldb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-arm_dts_ldb-v3-1-96c784b2b84f@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784834058; l=2253;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=TZNLpXNlSs1vPzYFIpD49zey/I5tfaLXDljUkp2mUqc=;
 b=ksi9JY3xyJ5t/7y2RpC8Q3cTlNo1ERXUt0+Ku2HrFzKNfQskKncvljlY6zPpIr27j0VKMcR5D
 sVP2NGxGsg/D8WJTX4A/pOhIww7pUSItnzmSzoOHTiFtslgYeqGzQNO
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA0PR11CA0161.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::16) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM0PR04MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: 07534b39-7910-4b30-64e9-08dee8ee9db5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|23010399003|376014|7416014|56012099006|10067099003|11063799006|3023799007|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: a9MUngiAXMk/GCCSgZxXTF/EwRPfwd7lxY62EVqnimtznsai2BG5c2MCG9GHLfGcAlki+ENXQjK5ZNVF6lMCoghCn49fwwY7f2WsV5UyRqj7mKbnx4yeGxIsrlxXPOi/AcNxXP596Dvf9FAYyaiWLndrQLvwZXF9VKLcqiEGWdfClio/lh6yoCJIljFH4Z/nrlR1lnWtwobKqINkjP8WQ8YH7OORe+PNXQHgbWeoZwalzv0+y57/dP9P2tnKRflDyz8WrW504EX9xOuihN2OgnOubxRl5h/JtJsfsgLTg5Yw2Fg3sW8p+hGCuXQbMeaxP8tXpUx96ORXR6jVfJCJdowr8rbCFWLfbLUznJ8WwsMecyr6wLISot7N24b3k2tjVoFX32HTCgdiSF7MQDXVPIP+eK5sNQf7U8y2pLXKe14oe7XrvvoNtWZmN8ZQNZcVLwudfsDTc9FRwFvCkcety5QRmKKSpF2BJcn9zTvC5xyLpql638VuYJRLKPRnD0hq8TWJIFy9bbTmWRMoxc980U9H1HSVHE5NI8VFPN7AaIbDerVSVbaPOUhs8IlQgctS8hTiHWUwa6KwweqZ25nb4DYiXwiKOAMLFUXNCuPD6k0+nY84VNd75IH1I7GKL6IepoRdxNu/b+l2fDAO+VMf2hE3TA1zkOofMaONkRP6Lr3EthDxACdD2NZOz8aGO8reE2VoF0tx84dFmWsOdPlgZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(23010399003)(376014)(7416014)(56012099006)(10067099003)(11063799006)(3023799007)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d20waHVYaUsyN2tBS1lsdjZvTzFONWJQR3ZPMUtjZm9TMlB6NXFpeHdOd28x?=
 =?utf-8?B?OFJnT1BzUGl3Kzd0Mm1WMTVQb1I1TlNrdVduek5oNEluRjkwSGkvS3BsWXdK?=
 =?utf-8?B?N0JFbFdvKzEwQ3ZRZVhsR0tzR1JhTmtFakV3WlRiMk0yejRESzRUNis3UStY?=
 =?utf-8?B?VzgrWUEzNXhLL0dNdE04OWpaMmlsREZOUUkrNS9DeVN0S2ZJMkwrQkFJS2p1?=
 =?utf-8?B?aDdJVk1XQzRxZFQ3YmU1c3V2VzFxY0RHUzVUWWkwWWhNTzM4QldLS0RXMFhX?=
 =?utf-8?B?S0c2ZG9QMkdnQVZMTXlockZMeVpNS1d1N3BsSHQrUElOKzd4WFcrczYzdzNO?=
 =?utf-8?B?YjVuRy95QVNvTm1tenhvNCtKb01DS3M5Ynl1MXBGZW4zRHYyUzFBcExOaWJy?=
 =?utf-8?B?NU8yU2doRWhJWG1rN1JhRXR5RDJwalFzb2FhcVhTSjc2VEJUYXFuMWpuT2xZ?=
 =?utf-8?B?ckJaa3pZd21GY1BidWRUYjBLa2pnbVNmazAxME4wSkdyZEM0OHhibXhVVG1K?=
 =?utf-8?B?Z0M5YmYzY1RlVWRQRnMvMTlZWW5lSm1SS3N2OU5yN1R5OXhWTElPS21wOGdX?=
 =?utf-8?B?ZVRXMzczeG5mZWg2NU9aVjV2VE1yR0xCVVlpRkpaa3oySkFuRW10UEh4dGNU?=
 =?utf-8?B?amJudWNJR05TNllISzZaZ0RZc0N1N0JMNzByclVtUUpNVjJjZFl4dVZBTWxV?=
 =?utf-8?B?WnFVTkZpd1BnWW8vUUxHRnVOU0JsSUVwckQ4b3ZuM2hJY3hHajZWekdTekds?=
 =?utf-8?B?ZlR0WEFlbEY0MUJPNmxUWEVqUWhQM3ZuOEpMdmFUeDZFT2p1RHBvYmpNdkkz?=
 =?utf-8?B?eExxeVMzcnRuK25jNnZaMDNSNDJhTmlESlNUYVRXSlhaSzZxUTl2TkppSkZV?=
 =?utf-8?B?V09aSEZJcGYrdVFaSXg1VHpMUkZjTEI0RndxSjZEazNFZlA5VTZVejVCckFm?=
 =?utf-8?B?SnorcTRTQWo1VWpYT29IczVDMXdFeTZoRWRoL3ZZZXVMbk1UUFc3ZUNMeXY2?=
 =?utf-8?B?SkFaVW0wTDR4ejU2UGFoRTFUdXk3NkpDT09rbDVlRjQwWVlTY2NtK3VsOTRL?=
 =?utf-8?B?am42YTNkZlQ0anRTOHhaaG5mNEh2U2xoNjhIcGlhNWpXbHlHTVZrZVFlek9D?=
 =?utf-8?B?LzJ4a292UzN1Z21Td2lwMkhvWWpPK3ZBWGF5WU1QMGxyV2JicHd4a0Q1cCtC?=
 =?utf-8?B?bFYxaFhJMkxHWXpuRTZ4eFlHZVNUV0lPZitLOEFMYXBNOE1EZHpUUDhZUUpV?=
 =?utf-8?B?U1B4aTVtdlRnalNQK0M2aGlscStVWm9MTGNQUnpBS2U3OFViZmIvcW1NVlhK?=
 =?utf-8?B?QkdHSlNiSFYxWjNiMnRrV0ZWWUEzS1FTWlRmZ1p5d2NnYmxYZFFNS0c3WDVI?=
 =?utf-8?B?dzVMUngwREdiVHFyb25jRWV0WE05UDgwOGNSRjJpVXlIbkU2UTNRdmFxYkNM?=
 =?utf-8?B?RlcvQ3hGUXlFNjJqMzlGZnF3QzUrUFVMck9sSkwvd3ViVVk2VUpqaHJPWmFx?=
 =?utf-8?B?VEt4NTV6MUpjN0RQSmdxOW1MTlVWdzBZR2w5cG94YUZuTFIxazJBZmpNQlMz?=
 =?utf-8?B?OHFRbDF5U2VxdUVCc21BNEdDZmNuMXNxMEZtSE9xME51bjFmeHdOSHZvMlAr?=
 =?utf-8?B?WWJEWlFMWWVRbEVmSGJkTTkyQ3NhdGt4bEpvdmQ5Q1JobnVneHFUcjBrQVdR?=
 =?utf-8?B?TjJPT2swNXBzK1NwN0lXSW9DYlBYck9zbEZsMFYrSm1WdW9XMXIyTjZPZitS?=
 =?utf-8?B?ek1mU01HVGxJREE3N2VwY3RYOCsvNXB0SWYxUHc5WWVtdCt0aU5PRlAvTnJt?=
 =?utf-8?B?YSs1R3p0WGl0MUNYcTVXNWdrckwvUXRFc3g3NTFQS3BjejNRVUtBbW1GMk9G?=
 =?utf-8?B?WFNBOWlNWDlTVlF6Nnk5VG1RbVBXdEJkSmpFTUV6ZStkMnJJV2hTd2FGTkV3?=
 =?utf-8?B?NklVME5teHpuclgwSnJyaE8rd0NpZnNWNnd0aTVXVTcvOXRlM3JpelJaZFFl?=
 =?utf-8?B?Z0dpQ2hvdzBZaVlKMDNJb25qWlRpQnFGenBFKzhtdXlSNThQM1JIYlBKdXB6?=
 =?utf-8?B?SVBUUmJpUGxLT2EySUhqaGg2VURSLy95QUdVWjBWWWRqTmtpeUNiU0NiQVFt?=
 =?utf-8?B?R3V5NmgwZ3lRY2JlM1VoU2JvbGdQYTZHVlNPS0w4blk1VkZNMEZQcjZKenFD?=
 =?utf-8?B?K3N6QUtVMWFSSlJBbkEvWTRsUHROUVdnVUxiZjRrUlBkZzBwbVhSYXhaVHpX?=
 =?utf-8?B?emV4Sjh1WXpJdXdvclMyVzRJRGpvbFNjZ1FwdkE1UWkyeDBSN0lNeG1EenI4?=
 =?utf-8?B?RFRIaHE4alpqQy93K1RScVRYUWZWOVhqNHVYSDFwa0lhTURvRlZzYmFUaGpj?=
 =?utf-8?Q?NwM+eRJf8cxY0qMbfiWhPlV20LIObtPx6X37o?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07534b39-7910-4b30-64e9-08dee8ee9db5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 19:14:28.0762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wiS15A5nlbuK+lGD70Z56nhqNAwXFzK3+iqduWC1L9kemFJrg8WlG2kIqf8F2ixqywi6L6STeCLQ/J8K52zq+C9n2ZWz2Xy/IjbIkfzbkW3IWooMvPbheX1TEVc0ncGk
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

