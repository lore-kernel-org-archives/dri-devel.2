Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17AAC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 20:29:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C0E610F2A3;
	Wed,  8 Jul 2026 20:29:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kz7msvUt";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013063.outbound.protection.outlook.com [40.107.159.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF3CE10F2A5
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 20:29:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XvBsk+wkkTUOEAK/aYsoG6WugpIMB5ZnRtHl+CfEMy9rjRvT+7++WQDT/7bYHBv9tur53Le5V5R1iXkC3zhkJsEnhmiwvkzW0//sKpNAyxAZ4VX2qdmTL1x4lypZn1DFXjoCuaksjdFEctjZOGWwwxIDOd8zAmImwa4AqpdzAWOK2+cNedW24qMaCWJZXtJJLuZ2+PeNFPRYcAvzjKV5AsjMMdK/Oi46TAUsoKmlGo8s8jq5DBlMD9D+4m0r5DM8GSZ0Ftrh7VDIypie37mNqfYY6cKTzmeEgmmZu//tXDA+h4VZZiwkUJprnGCAMHy9Rq6P1oSblchE36WiwUXKzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUVYH9uEL5DXWt48DDPFD8TsQQBWoj+phAQtF1koKGk=;
 b=Maix/nR+6qPzVhFZDthEM/D4FJsKY7wuHmVw1Gmvk8wNZxUlSWfJR3X/ui8LAS+lTZJjv3OxZSZC6YOxRKYS8EV9KX/fcP7kB5+YdSSLm8bUrlXfA9Oh6+qZpJjpdRVd2gih9zw+rrA4bWMR/L1D5770c7KQprhMSfJtE91oL+SeUMAN9Q6UBWal2en1ZgxnQ2VvTfUxkhm+bUdvX2xheqnsP7IZtRoSyJujYlBDqa+nHtE24/tgnryOoGAGwvKvaOXxvfXZPkavJg+2SwaQySWCXQtRuqA3dbSafWcP1GyRZ2UHlN31NSQU+PcJAjJperDhHl3q6XUw232IdR7HEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUVYH9uEL5DXWt48DDPFD8TsQQBWoj+phAQtF1koKGk=;
 b=kz7msvUtX3VhfNBWzAk6hp0tH/bgd7d2UX4YYuHuUuPEuUuTrhbL6zY47SsEDuuOkHeCRK+3kqyc4bWK1x8jFir/WxJ0YERszFFLdB2qsKSm5Sbl/DG7U09ufMUdVDd7ShRpcLzJCJTK95S0rBno7sBPut7CeINw7yMd3b3sSR1W+UudLbio/UjMwfqaEWXXyUY2Wd+USFK21EaGJr8gKE7fzAnNER11fjOD5irhR/acU/hRz+cI1TwYbV7vxKpEbh2Lnhld9dAT29/8hx5LbmdNaNaozHIAiUv+wu0DC+VuHSKO1wR2dO36+d5QgVkl/hygGeg0D0WYbDyHk2oc+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV2PR04MB12605.eurprd04.prod.outlook.com (2603:10a6:150:36f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 20:29:25 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Wed, 8 Jul 2026
 20:29:24 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 08 Jul 2026 16:29:02 -0400
Subject: [PATCH 1/4] dt-bindings: display: bridge: ldb: allow a single reg
 for fsl,imx6sx-ldb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-arm_dts_ldb-v1-1-4f5579b85797@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783542553; l=2206;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=lDA94fyrOZFFG9GA2LWVAs56cqWufRa/6OKF+nHiQuk=;
 b=YYmyEd9gxjvOz5MGV157dlDg2JNd6YawMpZj8x+3vnzPIc0ddezq+NM++sjjrzLeGAqUTkgIf
 s5NsnljyqTjDet/Ia7NZ78SafRmM7y2i8TDIvh0bmJ7y0QlJBXL2ogq
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0171.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::8) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV2PR04MB12605:EE_
X-MS-Office365-Filtering-Correlation-Id: cf769fdc-5e04-4a35-2891-08dedd2f9932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|366016|7416014|376014|1800799024|921020|22082099003|3023799007|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ZvvMVJ9Bk9HMSnRGWIgWRobTL8LcwIGuwsGtLiTnF2DJnvirl7s6oaBHA14DCskE4tWwN52xi3OUi2y1De9JzFJg5iOHZ4SVfYgWEz84cSMBsjZXLnQAtoh4emG8s1mUlq++Fadv963tF6N2jQkQ3TKKj318Up9ZhfD+B1cQ4yxJnASn1rs3Ani6YU2AYdKHJfVqFjWralOozck1Bq9QVayia/SUQbCOy8MiB55RDTULLk9xZLcg1GcFLpzB9xR7/h+KOs548VdkZXtLScGzk/4ZtIBx4JKH/SWTqdS4NQsvWEa2TUhxSX7EJrhFvhZZpm0POIEEH1EQe1sqnzytlc4DvJAXNEYa4DEmKvUa4pm2gmS59vEqPWc5pwILvNJhvhiyUY0oq8NsPU9aJYmPsa6TZRYno9+nBVMvJ7zmQ0REjLaq31AaD0TtZ0PJ7svBR+QP+D71oX//XLj544gpiWeSdY/k3liN2WTmmzq21cvl9qlQOpGxcwcgdSwP5XfmAkoEqkkq79C1TJFOXsPozGpp2c7WihNHXe0tOwLQcMOYPAS77rMGpyj+6y1kLCPjF+3Olgsy8e83x7IQqn/PfJtWnl35tLOiG1xR+I1rWTbTUV5t8xnKj0b86tcgjD6oHk9vKOYJb/3d6DLsuVLZVELGemkhjFIyLnMXf/uoYbvIMRWe+Y1Vdk/qLsZwF8Tjx8SGtrNG+yipL/ONOI9rAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(366016)(7416014)(376014)(1800799024)(921020)(22082099003)(3023799007)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akR0MGUwY1JUUW01b05vczRtRzdub29CQUQzWHZqbzlDNEUyeG9MRmdnSnoz?=
 =?utf-8?B?OGE5K0NBVlFuN2dPa0N5cnVqN1JIRXVmazRHeUdTYVpObW1XbVo5eTdtVk9X?=
 =?utf-8?B?RWE1Q2d5L0ppa3d0ai9HdkFuYlovRmgwelppbDFsYmF1UWxvUXNWdjdYaHl4?=
 =?utf-8?B?V3JLSW5PRXFiYjNvdUtjUDJGNURJMERDS1BtYkRSMVBLQ3JiRnVETU9zR2tI?=
 =?utf-8?B?bzVPVDR3ZXNwRi82SW5qRmszTkpvL2ZDSElFQU13SlArZlRuclZKTmFBQ1c2?=
 =?utf-8?B?emZqRk1UelZqMXVEUGR6UlVlajhiekdzQUJhMWRlNDA3SWQzQk5wTERsS0Yy?=
 =?utf-8?B?MUhVMWpHbHptSURtZlA1MmhQd2crUUxoVlpXQWdLOGlWUWRkWXVKNVd3YnBi?=
 =?utf-8?B?ZGpncEErQWdteG1wakVENW1WcjRMWHBia05wOHhMemNRNk9Id3dkdGhnV2J3?=
 =?utf-8?B?YWhSUnl1UDArM3pkVU83ZE5mNk9DMGdhYVVlM204Nmd0elQ1ZWFkUmRTZDlv?=
 =?utf-8?B?RVVnMks1K0dwM1RncEtVbkhnQzlKWjlFWncrakZVWXg0WStMeXR0YjZuR2ZE?=
 =?utf-8?B?eGorVlNjdFh4Y0RZbmJwa3FLZ1h0VUthQTA5T242cDRMSWprM0FGaHA1bm5C?=
 =?utf-8?B?b1BlTDE5VUw5VUQ1ZjMxdWFYcWl4MndVUjBraFpiZ3J3RGpid20xSFVpZGZo?=
 =?utf-8?B?RUwzZkw0K1N4eWNQb1M5NE5id0t5d1RHQTh5TXk3LzdJOFVudUlMQzIzNWZ6?=
 =?utf-8?B?Z00rT3FmZEc0bDVjc3hqT3loeVA4aktncmdzYWFidWt2NnRsbmpOd1RGSkhR?=
 =?utf-8?B?UUxVY3JLTlBGZ2RHTC9SOTkzRVhyOE1wNFZuaWJSdnlaZGRlMEFKdzk2TDVJ?=
 =?utf-8?B?ZUQ1WFJVUUZmZHJ5dytBZksyYlpieE4vWmVpQld6MVFZV1BaMDE1R3ZwdTVl?=
 =?utf-8?B?RFhKLzBsZDhKakJDRFBRb0E5YUdvanRmOW10WXhwVXgzeXNneFpZa282UkJz?=
 =?utf-8?B?QzJ2eG5rS2o0amlTYS9GRWx2aWdNSUFqRDhYQU5uNklGd3QzRDdlSHFMRThy?=
 =?utf-8?B?VDNzTzkwVXA1cmwrNWxSOTR1SFdGdkd0cGlRRnkrRzVaNk9uSDVzZzhSN1pq?=
 =?utf-8?B?eitRWVBFK0pmOXIwRmxBK3pQbFVkRUZNTFQ4VEFJT1doMWR6S1o3UlhvRVUr?=
 =?utf-8?B?UFpURHg4ejdhN2d2S0xFMXNqQUlxeFc2ZTI5S0tzVXBTTXhLMHdzbVFiQ2Zz?=
 =?utf-8?B?MU16cm9Ud2RDUjhyYTU3UDBvQXZpekMzSU1LK0FGTXp3YnZ3blNOMGpEdERK?=
 =?utf-8?B?ZTg3cHVOUmY2SEZ4U1BETmd2RDgvSFhVOUZJQklCRnZhRGttdXJ2OS8zTVZU?=
 =?utf-8?B?RjZmRk5JZWxzY3BzS1ptK05YODd1SnZMbUp3TU9pRkNsd2lGS2o2ZEhJZVJ0?=
 =?utf-8?B?QjdTMis5VFhtaFdzRVNmcmtzRmJZN0NtdmlnYWJ0cXd2OThJb0wxQlJ0dEd4?=
 =?utf-8?B?Sjc3QldxMjI4Qmc5SW8wOUZqa1ZnSkprMFA3UnFLN0dmRFR0SXUvZDRTYVdV?=
 =?utf-8?B?SnNtRjlmdkp3UjM2cy9BZWZSV3A1RjFoS1JCUmZPbDVNRmhiakxqUWxqaUph?=
 =?utf-8?B?aHNUeGRzV2hJMXJCUEVxWmpySTFSZ3JaUUsveS9Vb1FJejVWMlJRNlQ1TUFk?=
 =?utf-8?B?RlNEMzkxS0ZPNEV3UXVJVE41V0FSRHBaL3JFMGR3cThqU3ZHVWZMWmhOYVhC?=
 =?utf-8?B?dTZTOFowbzk5SFFIVnBMKzE2M25yempNZTUyYnorZ0loWGRrdENHMnQxdUx0?=
 =?utf-8?B?UE1Ca3VlaVhrRFM5bDFuU1VrdjJsU0J4QnN0Z0dOazdkT0hJZzFGV2xSQjNJ?=
 =?utf-8?B?K1VZNFJubG9FdlZXQVpmUEJnVDlIeEJWYlBqZUpQR3MwSjV2ekg4M1dCb3hB?=
 =?utf-8?B?MS82NnZCNmFFRlpyVW44RHhjOHhYVWtzUGI2MTNELzcwRDI0S2crNnRBV0s3?=
 =?utf-8?B?amMxZzVYeHB1aS9ndHFpaFF5czZBRFlveVpZdlJaakF4U3pyOWdhVzdCYXpn?=
 =?utf-8?B?V3hXUVhiTjFlRTF5bXdTeTZaRktpUDZLeGtVMllQa2lzUUxzUVcwR28zajlY?=
 =?utf-8?B?bzU2SmRFV293ckloUUpqQ0NtNCtIbU5pNXlQYWVTYW9LVzRBK3N5SHB2Mm9V?=
 =?utf-8?B?THc5Ylh2eTRWbGRRRDJWWVdyVE91dDJwM3JacWZ3Unh1L2JkVW93aC9EYlIr?=
 =?utf-8?B?MzBqbHJGbTBiOVpxUFl2UzlrMEt6QU5nVmpWV2RKOWtuOENBOGRXa1owUm56?=
 =?utf-8?B?OGYrbDNMaVZnVStzdm80d01kdFM1cGtaNUJDNzB6dFIrVEdpV0VPZ3ZQU1ZO?=
 =?utf-8?Q?72gjCGHKc+xUEQQaPFOwkJSylWOeXxpkswABW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf769fdc-5e04-4a35-2891-08dedd2f9932
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 20:29:23.9079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 432MgvGRdd1Nw4z2XBc5IN9tucJ/1c7/0ioOj3Q8ZP6pb1QsDgZjP/1dQQ9Huj3FSsfSkwd9xEhCyE5sp85QKRsEdvTxKV03kEwZcxT2Ackgg0inTBXMr+OewObPVepV
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

The i.MX6SX LDB only provides a single register region for the LDB block,
while other supported LDB variants require two register regions.

Update the binding schema to allow a single reg entry for
fsl,imx6sx-ldb while keeping the existing constraints unchanged for the
other compatible strings.

Fix below DTB_CHECK warings:
  arch/arm/boot/dts/nxp/imx/imx6sx-nitrogen6sx.dtb: bridge@18 (fsl,imx6sx-ldb): reg: [[24, 4]] is too short

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

