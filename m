Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A89C531D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 19:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6154010E5D9;
	Thu, 23 Jul 2026 19:14:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PGJfu3fS";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013034.outbound.protection.outlook.com [52.101.72.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E279910E40B
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 19:14:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rWmIjo832Vs9bEFbWKR3FpBUIZqRjTyBlz7l+CpVlePBTY1RwncRCoZYal9f+Cm/XkubPBY1O2I/vstAcWBsV/18sxBrSl1JxH2+xD8O/6h6EoVCu4iXF/oyZpZXsl52rgl0mXVEFusAe2R7ES6xJe63MbDQMPVmhC6PveJh9OZM1Z5J3iJ7FHk4/AT7tvxyGfAiY3JpdmebdhE567USxZx7dDt/FSqXlnHrhMFVe0kOx8LEU4a/IjlQV4tfppk4I9pFIz5j216vxINE1Yp2EVXNnfIslJ+sMtZxl/B8fI3CktEzmvRJs2Y3IDeU+HzT5i0cHzBvYyKE5dHGylr/Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZtyncExhy/lY+d677yRllLofyGcXffAl+uYDjhy25c=;
 b=Usrd3FLlyMp1G83EwToM0kvXu87A2GvpiUj70SXyjIj7ne9GNeWPjPTVtaefteJZYKgrsDry/wdCqhdLMqIpTPzk+OM0DDG3zSNHAgm6ZvjdusoaPsTxI0U0apTfNi7umVaOzLmKd5QKePEpwRigDW6UnrHPJVcatWWXL9D9OCyRAR68P6t2tAXBtxE1XxnIP+/+B9N/DrGOdBvjx+ZJfe3FRjUAdNOiMW7usZ64hIEU3F8RQQLbm//6eON7kOANXH6iIBEHnlrv99Mxb5jH7wFfPa96nJeKyTG4yCN0bGVv/R+HXOfKvprf9Bsx3czniVc6wDPDY6mHyAQIFCh1LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZtyncExhy/lY+d677yRllLofyGcXffAl+uYDjhy25c=;
 b=PGJfu3fS9hKHQv5tK1yAuTIbU5TZNQh+ePJZmTLPfeoPC0bfBYG7PJx4cTMHgFjTzdZ1LNMnZ6j7J2xKXOBwGBTNQ4pSzx97/W/TJJxyhPxJidJq0JRVlNJytoVhlW3KM6BCtJD4MbolY3wYC9/SRKleyR9hqfPayut796lJIVC7xzKt0Nh6aKmMqm7JQONtbXY/YAXDnvKPv26FUkoGPZDPxS8MOa9AeCxycrW9gt2qK8WfAWrbcxcMz2hJpcWM8MrUhBXE6g5bh1WIZ3ioM91I4RNaIbmsr3qt2VzNwbkdD95/3qAUWuEBmcKyFIgOB/YLENY+zSuBZ13ORyI6Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM0PR04MB6818.eurprd04.prod.outlook.com (2603:10a6:208:186::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 19:14:37 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 19:14:37 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 23 Jul 2026 15:14:17 -0400
Subject: [PATCH v3 3/4] dt-bindings: display: lcdif: Allow display0 child
 node for i.MX6UL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-arm_dts_ldb-v3-3-96c784b2b84f@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784834058; l=1432;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=y6g0p5Wi9O4J+Puwx686uIBGO0fla7UUU1AGO6Uf4ug=;
 b=u08we1viA1gb+xFApBUsR2YqYTxnCcAkTEE5/co2MWjWQAD96wNrvcM3R2nX9hFvR82UimF4O
 FrLakDHeOTAAPqRFlEdFFESgIuXjU3b7K7ZTuE1S4yVDvmETY1OPM2I
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:806:20::22) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM0PR04MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: 100b0c04-0e51-4c5f-e350-08dee8eea347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|23010399003|376014|7416014|56012099006|10067099003|11063799006|3023799007|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: VFaDaf7dMZfzFmFddXhplEoUc51YCP8P7sTLW0OnwwJWAI7zLpT/uCIOjyBgr1QZvmyaymZGvRTIluIG8v0Esg7OYgrraQ5JbYF5mooX2H+u5/ejaV+dVY9HyCwwn2noWdtXkciSAojrDdB3UnUh9kevP21i77M8Zv8Bm2AIM1yNXNHv+ABUPIbunhLgMW2RRk83ADmatfGC3XRUOkX2uDb7iokUNPFCvETcuCvalhV56fhv5bg5ydZekAYJMhK2RVM2R15mVKiV8VHesuERQXmTRDfP+mZPbsXXS7r9QCLfdMrWLHo6kJH/UqTCl9V7KvV36aL03Lvd+IMZtPMK4X3gY+dtLeEDuUjJapdMvd7jGGdnpVzpZJh3SPc4jv1Glt7+KdnqE22h7twMZ4lVCHMr5lYXi103z1zpSGWJx6kngL/vzhw1tNxBbpHcPzSDLZq/R7HOQbALJbE5nh7opSWl6LuSnN4IId4CDtelJUuvMA92KLMLDhnMDAyMxO2vL8phHaZX6gRO/VjsRmGsrVF6Y8uNswXQum/CbGFEV1xj43MaSI2O/Q7ceJlgGmSi9a0Is2kDJ8g3K7Ka1kCYsmq1flyEYtVTyGp9CVuFA5YRr/rXU04s5Oz5gjtDatoZC9YXIKGVq/Gk+32JU+106HMUa1b3nFKNEMePCaa0Yom66yRpzP9J/A/cnOtaxkoNGwqdx+hNJgqR1R+wvBdDwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(23010399003)(376014)(7416014)(56012099006)(10067099003)(11063799006)(3023799007)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVFScFJYUW1WRktaQ0NTNE90SE9JaFhGeVp4clpCR3U4N3FrUGZaR3VFanMr?=
 =?utf-8?B?NzBYK2EvbStQM0x0M1ExSDg0Q1plRTh3RjlrNEk4RHJBL1VyK3dENTJFcjhM?=
 =?utf-8?B?Z2pSVFd5NWdPQ1NTTFM2ajQ2ZTFnTktwVHlGbDhseXZqQXplVEtTTWIydDAw?=
 =?utf-8?B?THdxUTRpZVYxVkErU054UHZwUFZMY2Eyakc1V1lvTk1FQ1FhZVhreGZ2bXJl?=
 =?utf-8?B?cDVIbEoyREhPd2tMNjNXUVBnTXhJd3QrU09MU2dDSXJIVFljQmlKYmxjM21h?=
 =?utf-8?B?UUp0MzNBOWk3TkZrM3VWL09qd2Nnc0dtSUZpUG9XUXJlc2ZCTTczbHJ5MStS?=
 =?utf-8?B?QlZQY2dTMDNBOHY2cWs5U21HMkI2by9FK1d2NVdFaDlpRGxqODE0ZXRrbzkw?=
 =?utf-8?B?alJXN1dTbG5KWHZmTDk3dWZMeUZwOWEzZzhpZmdodmgxSkRMYUI1S2N4WXFp?=
 =?utf-8?B?KzFVLzdwV3R1SVBHNGhUT3dneDZCRXJYNXJ0dTdwem5oakxUWGgzRzBMSFJ0?=
 =?utf-8?B?dnhIM2U4WThVZmZLWDBSRGJ6OWNHdnVBMlZIUFBpWXZ3eUN1Y3BPTXFSLzl2?=
 =?utf-8?B?MFNxOHU5dW5Ic0ZUeXl6OUppdWppb0dYdXJQSFRSK2NOZ2FyelNYZWxaZnRq?=
 =?utf-8?B?WXdzV1JLNHVCOFpYUzVlMmM0b1JETGdrdFppOCtBd2h4eGdKVDZncUQ1bGtE?=
 =?utf-8?B?OW0zaHAwM3NWOWErcFZ1cytaaHRZWk5vYytiYXd0Y2ppMUtUWktlazZvQ0dz?=
 =?utf-8?B?ZDJPcVVkY20wb3Y1aVhpWEtFZXRDUjlKb2lPR0J6MERaRGNUTVdXNDZlWDg5?=
 =?utf-8?B?OC9pZFFCY3BDUGJhWWZhck00SEE0TEdVb0sxSDlsbXQzbDdEM1BZeDJzSmFW?=
 =?utf-8?B?MitJT1l1MVl1NFpKbnYvekdLMnMwcjA0bXc4MjQ0VzZoU3dScjFrUUVwRTg0?=
 =?utf-8?B?Q2JTSngyNnNzYXJVU0phK1FwdEFVSjdNNWU5TWxaVGpPQllxOUtGaXNBKzNR?=
 =?utf-8?B?UzZpNXJvQlpNYmdZMmVieDJHeWJqc01EV25wSE1ZYUdvM1R4UlhqZ1FoUTRk?=
 =?utf-8?B?SDVNUndQeXFPa3ZzWTlwRUNBRm82RGwwUURsbFJYK1dCYVZPMnZNRnMvV2N0?=
 =?utf-8?B?VXo2RmgwSmJmMnFxdkxCZmQ4Q0NCVTY4RHZZeUpWaEx1cmRyS1B3U3hhSGVV?=
 =?utf-8?B?aTVDMStoeHlVTSt3d09RR01qNFhhd05RNEQzNTlQZVV1MHZhWXJzMzA5MmhV?=
 =?utf-8?B?aFVTK3VoM0dxTHRUYy9NT3lCZVpTbDlQc2pHWWNZbTQ3NGZXazl5VU5XbnQr?=
 =?utf-8?B?Rzhjd0YxdkZFZWRoZGhNMi9WZCs3Tm0vUlFuM2ZRV2dhK2xISW9sUDZGYjc1?=
 =?utf-8?B?VTVlN2ZDbzljZXZ4NXNjT0k3RzRGREJmS3IzOEFqMkpRdTZXYmVHdDE3ZkR3?=
 =?utf-8?B?TTBWaXZLUDRnVlhKVlBqUUR3QUxFcVhlQVFTc2JMR3QvS2liWjNDaGxxZkVR?=
 =?utf-8?B?YjZtUHk4ZkZKd1NBSW9LZXkwdkN6QWprOXRsYkd6TjBzSVJPMjdCbUZoaXVR?=
 =?utf-8?B?TlZQSU9mYXVXa0ZhVE8xMktMcE1QTWdOWEt2V0cySk5ObW9xdHlaa1dLaTZY?=
 =?utf-8?B?QTYrazdiSlMzUzZpMmo4TCtDaXlPZDBkQk8xcGRDWmpoekt5T1hQalhjWDFr?=
 =?utf-8?B?Y0Rpb0o4WVJEWmNJaHgzUWNmOEpCK21JRlpCZ0pYcHd3a3g2bWtOZFBIRnY1?=
 =?utf-8?B?RTVMaDhRM3YvSTNSYVdlWHZVTWl6Q3Iyc2VxRFkvQUNQT2NMSlVHMHpSSHk5?=
 =?utf-8?B?VWN0MkRQNEhuN3NBOU9WaEdXQWIvT1piek9HbUppMzhueXhSM0V6WnBrTTFS?=
 =?utf-8?B?eUx1S29tMjJvV2Y3bzBuVVZnUzhHZ29RMzkyMkRHWVRleitGWk5HbjVPVnRW?=
 =?utf-8?B?b0hZdDdqbENPS1NBVU90S2I1bHZ5Q3lidWVyemhTZXhSZE1udW4zTVhacm1Q?=
 =?utf-8?B?WHlFL3JUR2tZa0Jqb0liVXlEZEpyZGdlUXpud2p0U2ZuRmhaRGs2UW9Ga0s0?=
 =?utf-8?B?OFNTMkkyYXlVdk5jZDVCMjQ4a2RJbG1USzBFK08xd1JNSDRUK0JTVDR3SVN0?=
 =?utf-8?B?bWcwK094S0VLNnVxanVTb1NZeXVpaWZET1lrbWJrZVVQeGF1Nm9tVWI4UW9H?=
 =?utf-8?B?aTB0TFdpK2k3c09UWG9BU2ZHb3hQTk0xcXN1TlhlZHdzdktMNnZ2dGlWeFk1?=
 =?utf-8?B?bUpDU3lYMnBTZ0Z4SnlyYzdqd0Z4VWNnRTlFYzNKQXZNUXFWTTdYZzFtMkVk?=
 =?utf-8?B?dnFyeEZtVVFkRVhGNFlhNjJ5YVM2RGJHL29OcjRqS1JoczNkT0xETHpVbVc5?=
 =?utf-8?Q?W4c2UoF9aWm3k3auuFQGoa5XeeByv7Rupajnb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 100b0c04-0e51-4c5f-e350-08dee8eea347
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 19:14:37.4321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qYaVFkCBleem7fnSKdS5TaPcA1CfB7tMaGXvUhGMMgN4VTDIcyky1OEYbTvR7EaPe/3+r71+th+pbBYQGOUthiiFjw+RryYxVuOhP5dw4+nrv17/0BVm7mdEbMBjcmBc
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

The legacy i.MX6UL LCDIF binding uses a display0 child node to describe
the attached display. Update the binding schema to allow this child node
for fsl,imx6ul-lcdif.

Fixes the following CHECK_DTBS warning:
  arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul-0010.dtb: lcdif@21c8000 (fsl,imx6ul-lcdif): 'disp0' does not match any of the regexes: '^pinctrl-[0-9]+$'

A follow-up patch renames the child node from disp0 to display0 to match
the updated binding.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
sashiko report problem and allow dma/dma-names for i.MX6ul. which should
be fine for this kinds of old platform.

Ideally it should use port. but platform is too old to avoid break back
compatiblity and leave as it. Needn't complex if-else branch.
---
 Documentation/devicetree/bindings/display/fsl,lcdif.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
index 2dd0411ec6516..2b123ddf06841 100644
--- a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
+++ b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
@@ -182,6 +182,7 @@ allOf:
             contains:
               enum:
                 - fsl,imx28-lcdif
+                - fsl,imx6ul-lcdif
     then:
       properties:
         dmas: false

-- 
2.43.0

