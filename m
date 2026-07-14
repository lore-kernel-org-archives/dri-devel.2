Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA02C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:59:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E757410ED66;
	Tue, 14 Jul 2026 13:59:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DS7kS6pI";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010036.outbound.protection.outlook.com [52.101.69.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BD5A10ED65
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 13:59:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFUpNbdUhK9Zrq/tH0Fkylwth2ic6WK4rEfgy4lpSVoRi93GIAz+PxgSOB4ujy4OFXd0jv/AMMqZLHiWvCGV5kxxcYzsW9w3BrvOz/m/AXBkr2VPHx043liAO8ziZMHDO4wHekOquaZgFKUslk4lSLyQB0vY5wxhumpRoU4NnLZABeRGGgUX0JWaTBtpEUnOJpNAkXDeaxniyuS2MCX/ykaEhDUPITZ+KX+HC2XR4c/JVf67b9Cnnd14WTuMIKnzeKCJJ8RxbTYEol27+100WcaSeSq/03y/HPt82yBh+bHXV0bJJdR69Ip2BmsGS5ILP+/Zrs3dZBNmDTj5oEiu/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y498CwEH4Hd7tEYrWzujJ+9WfTclhKUJb4zHpsucpgc=;
 b=qcj1W1+Xfp+LPY83nbPfMxRbrCplqIOVECGsiO2FI/hlfcOcYxD8QKbXjUyEDAQzW+UNy/iBaJJXiRFgZqs1InD5nB6ktj/Xa7NTA7KWb/yhnj8J3/vn//6pSDVbRqXRA479LvNKDzEk4QCaDglz2xDDOVJb+eSGlLcjnonGJzcAauDXsOHeD7qdl3ZPsWx2HsaR6DODpoW96aq3/se5keJong1ehfpdrbbMfvTaa1kQ+2f3SBtp9HBiw4fA4dDaVoo5rrSfse70IFzR325qAUnLbN+uW2UNFO6PXmtEOhLwdW4SEJJBAaEvl031KXGcTq2SfUJBB/h9iBlNrcPoTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y498CwEH4Hd7tEYrWzujJ+9WfTclhKUJb4zHpsucpgc=;
 b=DS7kS6pIIkpWQxat4Ub3OgMjGQfoYEyONOt4SOtIK/ObwgSZJ3s2JqFfNcH2JWuWtVsRNm9SLg58k7DJcYTZbNcJdJqbNGYRwI5MlCCJpVhy5BmRFGIHKAI8jqOFEYkoz/cGL5+eNin7m2r/xHhwREkuq11Y+awfKAvwBW84aMZrDm7tati4/a2vTmwlrAdT3vE4d4WxT7RtbtWq/E+IsGL9hW6kvBLqFJEY3xvlKov9MJHtQvDltx1gqw6pSwzSzLBiQbMEnFSRkCOPoMTTVgQxmd/7AXnh+Pa4lwuOv9TokgUEzuSwn9DOmr7nG7c5A33CasvfHwA/HHaHBR5JlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB10842.eurprd04.prod.outlook.com (2603:10a6:102:483::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Tue, 14 Jul
 2026 13:58:56 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 13:58:56 +0000
From: Frank.Li@oss.nxp.com
Date: Tue, 14 Jul 2026 09:58:43 -0400
Subject: [PATCH 1/6] dt-bindings: lcdif: add compatible string for i.MX8QXP
 and i.MX8DXL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-dxl_lcdif-v1-1-6761a8a6592b@nxp.com>
References: <20260714-dxl_lcdif-v1-0-6761a8a6592b@nxp.com>
In-Reply-To: <20260714-dxl_lcdif-v1-0-6761a8a6592b@nxp.com>
To: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Robert Chiras <robert.chiras@nxp.com>, 
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037527; l=1017;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=bzc4APQL10NkhC1TKZMO7HoIT3rAD16SUD6eZTa3e5s=;
 b=p+DuSMmMfGl9GlvZAzfUtdnXxRg9XO5IJiYoHT0kkeixxfPNHhNDmjp0Vnb4KrEr5dVPlIV4Z
 9MxIcZbtiznBEncAMD6kdoH9d+7+jVnnnXAmDn7U4W4tWY7Wl1ynTQw
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0032.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::13) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB10842:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b34e5a-e952-4681-d924-08dee1b00bd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|19092799006|23010399003|1800799024|18002099003|22082099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info: Ff+c6JsJILW4JAhWp3p499ecyhQEkf1b3jcq9F1PicuXpBXPE8MW8LARtNviXK274mN+gujuvZIRRuWz0N5doeKXKahUrTF7vquw2CDNjgS3YLfQwea6LkQf9210JXjwL2NhDMejodaLB4MW5yN07XFHiBof5Epfto05OdKRGLWHAf6Lsv3A0KM+dC4Z4bVsw79GTwnbjTBXdV0YUeqWHWTy9R064xAd/omNoLqoUKWK5+g8ZL+SbHVSvNsDh7b21IffqEhe7Y0av2EEwoGuaYfJ5CT1YuVJ+vkePWsk6A8O5iiNG8pxcy1hBB96HH/F68jP3ykiloERp+V4jEdihGNcSI3kTZyzsAlZUOLvfKKIouFNqhCq2/Yla+E0K1WdAFwjADBnyAQNZ14T4hlTmaFkxroVdSC385ZKbQJHa8vUhRlTadsTbshNQtcEzTVAEsOoRj/2nH3d/QBZ2upx06Cczh0L69D3vrBhj5sdUWWCl4BDIm/HtqbzQJrhih8cm3M5+znqfQaVqp+LORIDS0aJGvK2t1ohJ0lwFEkMn1EmMj0OP+Wd1eIiFQUYvvC8lSz+7gz1nbSPQbBtXJtblaQc4m9JT7FfePGhthl9Bj4CZEy1JfJzIntjSoLAtFhQODip/P/R00nBbDQSAUMWYwN7+2br0NbBv+yQovfx5FebmfZJ1vXKyXmRlYkDVradahEG5CTClYVOlsdk8S2wDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(19092799006)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWdxdUk1WFltUnNRVyszUURXZTd1SEZOR3g3amVHbEU2enZrV2NGb1gvdDU4?=
 =?utf-8?B?NVdzaEJnc0wzWFdDRjd4WHlMZXB1WVNmL0JSeThWNmFFL2lhaHVBUnpSbnBQ?=
 =?utf-8?B?bTE0NW05czZnRzk1alhJVkIzeVMrWWZoa0hVcWh5NjJGNVhyNEovZ1g0ZVJr?=
 =?utf-8?B?eVFJb05xeFF0RFh2VXF0S05nNFl4THAzQTRhMENTdEgraDFtZFRXWFdsQTdh?=
 =?utf-8?B?RWNoMmgrOXViUlRaN085cmdPWGFiWGovaEpIN2hONkRYYWxFQzFMNHBoT1ox?=
 =?utf-8?B?SkJUVlIzcnVJb080YW02cHYyL3BzdVpQV2hhRmdPSkNMWmlYNzhyM1JvUEtU?=
 =?utf-8?B?UnZYczNQN29Dc1M0UFVPTFhkdDlnN0NHTlM2WHRGdXVhR2JCSTloeXoyOXVT?=
 =?utf-8?B?NUlaaWsvcEpncUh4SmpVWFdSNWlkWFc4NTEwbWlVcU4wajB5MHl6WnJyREVv?=
 =?utf-8?B?d08vdUQwY3A3T0RZMXpnamF6NFFybTZXZ2pSMmFnUENLR3VsVVBPN2tHR1Y0?=
 =?utf-8?B?Mlg0aWR5NTRHVWk5dDQ3anQzUi9tRUpvZDFKdGdRcW5zUDZqWURxMFBkNnpn?=
 =?utf-8?B?VnlmMFdzY0dSOVlDdE5oK3cyOUlaYWRud09SRzZqbnVsT1FLS3JGTm1MMGxE?=
 =?utf-8?B?bXRXS3FHeWtVblBtTjcyTVlNWmZmcWlPUVZJclB3Sy90VzB4MHBaZG5xTHNR?=
 =?utf-8?B?UU5zZ1ZKRGJBOUZQTXF4N29pTHZQZC9zbnV6dVhoMXE0ZXEzSHRUbnBtcWhw?=
 =?utf-8?B?SjNIYmxyVzN2MHhCTnk3SlVMMzQ4Rkh2N0cwMWNITTV4ejRmVmtua2VEdDlp?=
 =?utf-8?B?Z0YzTjRTdUxZMmRWSW1GRVQ5VVRBN0FSSm43M092WU9WalY2VktTeU1rc1lw?=
 =?utf-8?B?NjNJblNjdmRZMGNuVE1adHRMT0E1MURsU1ViNjRtN1B3bno0OHFOY05lYVJh?=
 =?utf-8?B?S2xqNndHZEFOeTNhS1FnSHdBUzVsVUR2U3NIMktyR29ReVZ0V21jLzNZVmJm?=
 =?utf-8?B?cWVzSTBqajZ1cDQ1NEV6L0RQNG92eUdEWFhsUzltRmY1T1NFeWc5RkV5ekxv?=
 =?utf-8?B?MEdtTC9lQ21Xd0NhZlVWbkRiaUZRM1JmTFVvaGt1bFl1M3FRS1ZvY3RpNnAy?=
 =?utf-8?B?a1Rkckd1TEdEMXdyRHd2UzB4aEFWSUdPdzMzUDVUY3dIWjNKOHdrYnhnQWZQ?=
 =?utf-8?B?bzNobmxhZkkzbmFBUHp1RWhpSVlpRHJ6azc1T1B1c2pxR1pxQnhxMkxOVGJT?=
 =?utf-8?B?cjRsK084R0kvWHgvT2c4eFVKRFpYeFRCdkZUeDBiV0pGUWo4dkRvQ051amlh?=
 =?utf-8?B?MWRxVk0rUHBLeEwzUFdWOTNCWGhzQ1g4Z2hobHZkdnZMNURkQzUxWlJ1WC9I?=
 =?utf-8?B?UVdFbG5JVWhqaVNtT3BGRXU3SVRrSFFhblhpYlNvTHRqQ3NIWEY3dGp3Q1hj?=
 =?utf-8?B?WlA3MFMzN2tjVGFsNnRwSTcvYmVaV1dDZHprRVJaQzdmR3UvTklJa2RjRE1p?=
 =?utf-8?B?dndsMmJrdnRxcElvRFVqM1dFSEVsS1dvcFRFaENUZ0k2bTZLMnNrMVhibVJI?=
 =?utf-8?B?Zkg4cUo2dlVTU2Vwd2NPeC9SMElpUXFUMW9hR3ozYUlaT1RCbVIzaDdxUWh6?=
 =?utf-8?B?Z002M3l2QWpLekJNYXE4dUdxUEJDMnJ2SFRKeWZranNXZlYyd1RtQS8waSs2?=
 =?utf-8?B?dm8vanJMWnEvRy9kd0FESHhhR0hrempwZnd3dCtZU28zdXZnMVhwMzM3bm1K?=
 =?utf-8?B?MDQzc1VVelZaWmlqaVJSVFk5N0YxdkpsZ3JiL2tGSS8wa3ZUR0dwdVVYa1Bu?=
 =?utf-8?B?YXc2RVR5eDRNcWp2cmNLd2phT0lvdGdWRTBOY1NFQWI4VkZlTndJT0ZIM2Ri?=
 =?utf-8?B?eC90b0JzN2lCUnZNQXFmZ2htblpGSWpMUDQ2OEdhaEh1Q0VtL2F6NjYvbUxw?=
 =?utf-8?B?ZGl4R1FuR0xNam9JOUJyTVcwc2JsV3M0TDkzdlFEcmJ0aHRUWG5TNHo1MGQr?=
 =?utf-8?B?N2NLN3F0cm4za0tGUEh1cWJrMmxmNGp0T2Q2RG1CVlhuYnFTandVRzJkTXIr?=
 =?utf-8?B?ZlpjWWRFQTU3aFl3RDdBYkpYSVlDcysvZ2hReldDdFlsdEFjMW1YY05Vb09q?=
 =?utf-8?B?ZUdFY2Z2ZGxGcFdBWUgza3QyLzZFeVVMS0RkY2s1QzQ3R08zcHlPWnQxUFpP?=
 =?utf-8?B?RURrY211NzZSWjFqcG9rOFFvTTRSRUwrR3ZEUzA1Zi91N2VYc0EvcTNKVVVC?=
 =?utf-8?B?UW5RWmZUNDl5bXQ4R1VscU16NDNudFpSenVvQ09uOWtSZ3dUTWc5d1FFOVZZ?=
 =?utf-8?B?YzJWZjNaL1N1S0xVMW1BYTJlQmZQdWQrR1N0dUp6U2dxdlBJd0F2bjJDVXFj?=
 =?utf-8?Q?pwD4j3RAvp3vvgwcZloLMp0wS5ODxY9C7c+t3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b34e5a-e952-4681-d924-08dee1b00bd8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 13:58:56.5450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BOpLbmCoUQoeEvh1sKMm0N66I/rWtrdfClhGNGDr7Wbx/LDvvDTkzhG/kkCWMqg7XGYRVmUPCtQicW0/F6cpizWH9R5D05w3dElte75iAaIh+2lV53BXn65kJ9jI5O5k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10842
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

i.MX8QXP and i.MX8DXL have lcdif, which back compatible with i.MX6SX. Add
front compatible string "fsl,imx8dxl-lcdif" and "fsl,imx8qxp-lcdif", which
fallback to "fsl,imx6sx-lcdif".

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/display/fsl,lcdif.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
index 2dd0411ec6516..121c1b220e698 100644
--- a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
+++ b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
@@ -28,9 +28,11 @@ properties:
               - fsl,imx6sll-lcdif
               - fsl,imx6ul-lcdif
               - fsl,imx7d-lcdif
+              - fsl,imx8dxl-lcdif
               - fsl,imx8mm-lcdif
               - fsl,imx8mn-lcdif
               - fsl,imx8mq-lcdif
+              - fsl,imx8qxp-lcdif
           - const: fsl,imx6sx-lcdif
 
   reg:

-- 
2.43.0

