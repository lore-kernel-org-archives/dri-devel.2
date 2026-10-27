Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFCD606A33C
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=oOEe4q5X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7147E10F616;
	Tue, 27 Oct 2026 15:01:26 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013055.outbound.protection.outlook.com
 [40.107.162.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5E5E10F616
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:01:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Atm42ad5OZzOA3VTVOWkhDIX8f9Mv3HH22T+v8lr4s+50Q0CLhk4QhzGLDmyLixBN1DyAHE0QRPz2jCJ4u83pQENeeGW2v1VaOWsjahJYyd+f0Y3iF+IW+LkalK6TzpPojDcJRAurDME9LKDZqpJiF/sJEkna8NM9dEZD5495wfy45O/HG1lQmuqJsIY1lfimyfDytf0DCMspofXK47O1aoY41MTZdECfCTvmc6QoyOp70BpQmQqRQE75Bf/KPbe8cnJ8JCySgVIwJJXYVvjRi2iMzPdg1/eKrPdDgXXqWDKwbLwJZKdXov4y3juEOjUXVbIQ0L4a1Okx6t9SgFtnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jmI74TMNFMvL5HpJo60QA1fnvGN2f5mV83xv3rEzJk=;
 b=QNHwtlREeh7q/f0wTb2CkQDZCGnfkXQkH+fWwtzJ+RmKf/nPjURbhiC8MHqnVgAZDnVJmiwOkjYISvb1nQlEypf7FjyPgH7S1MLiWyVR8eIyQetxJSwcYVZBnaywLAwF0b3gga/6Yu1mClSAiLJEJ2jgPqyR5Pywm+GsjjKWCuVWqWXgb9zOZ86/tpLHne4wAjdNCJNN6mgMQijEdeUcSwOR+lX0ZsHrwAhVM/1zZMMrB8RcIkBzkdPLEoDfOibkoamS4+uG0krC0kV5FkmVxHX00NoJf44l6SU2RQmO2tmm6Rbw7ZK6mGCxTNwcwFXNPFvyDarqRw9uhHOmO+S9QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jmI74TMNFMvL5HpJo60QA1fnvGN2f5mV83xv3rEzJk=;
 b=oOEe4q5XlPLBVvI1m9MzYv/XmIoJZrrUYVH5+XhUOCGDzVK3c6OOO7n36ebW13JzeLdRSclx+8iBN58EwyumBBWN6iIv2apepy3QrOrnY3y1ZtsENiYrdJuLhiLDUYMdqMNRN8F26SxngfxF8fihugxKwsCYdWRTGD+46WaPl0r5PkgPxIDEuEVkJhvrxItpIQj6mV4h+bVnjkBrAFMSlacTvgXt6Vyn2L1ygL1L99J2QZVS0z8h04TmJyswUigzcMTHw0vzsVRBTsXWEfz2rSsWpnA6ok2Gjm3INcyxB9c9s908/hjua5aODIJNV8t8fpuJBNNJe4lpQpYp71iX8A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU7PR04MB11162.eurprd04.prod.outlook.com (2603:10a6:10:5b3::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 15:01:11 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 15:01:11 +0000
From: Frank.Li@oss.nxp.com
Date: Tue, 27 Oct 2026 11:00:54 -0400
Subject: [PATCH v5 2/7] dt-bindings: display: simple: Add waiken,101wx001-wct
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261027-dxl_lcdif-v5-2-3a974e4b94b2@nxp.com>
References: <20261027-dxl_lcdif-v5-0-3a974e4b94b2@nxp.com>
In-Reply-To: <20261027-dxl_lcdif-v5-0-3a974e4b94b2@nxp.com>
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
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793113256; l=1899;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=WUsqNqBjRt6aPv8QXjes/MidqJ3zB3KMiNkTOAiAWz0=;
 b=Xrq/hmBsPs/ClXCjxR+STTjphf6PCqB0qr/g4qWQ43JmVz2itvMm7+chDdScjWQf8t1QArwLW
 mQ2/DFp1WJ1DX4dAcqqGLJb6Rkcp6F/eeWLKKSMpI9mmEhy7mvK6W5v
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: DS7P220CA0111.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:25d::15) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU7PR04MB11162:EE_
X-MS-Office365-Filtering-Correlation-Id: 996336a9-593b-4d3f-fa5f-08df343b234f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|366016|23010399003|7416014|261026140227099003|11063799006|921020|56012099006|261009223027099003|261022105027099003|261021121427099003|261021135927099003|261022075727099003|261022113327099003|10067099003|22082099003|18002099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: Ho3XEbSW3Jy0W/eUd049dpWQur941goXFfW2lpz7C6lUubfwPsP74qwnBccsQwdfa3eYtHkpVEW1QAA89Q0z939FwipymwvxzXLZoS0FpUuNkyAi1v1XulLpBTfVDd9AuD+H13GHjOy9/SwPxEb6tUrIX1o+ShAnu/5rmL7IQVlLy9HJO71zexDYeknh1VBQW8veaXnc25sIbygaNqOqyy9Pa+pc+pvU532Hhcif6RLXi4OfoC34sn2Ri0njl/6tYhXwraNQfGHWM05l4O17z4RjE1fzyiH18sv8C9dzTvYmeBMP1H1i9t4GnUNuTrOXdcHveoD67dShgLTF1kfNuIxeXkTBNvZc80Dz2clYL1j+62ZgotwHILEeM9S1hitu6XP11dUFuP9Z0kuIc1inRfcG7R9ZBYF/qfq3b4j55y6wZj1Q1MbDzU3MOku+qa2NPWEpaTok71KL6uUIJiHO+fWQJhHxYXgWLo36A/hqPazzSFMim0fLuLPacTsHPcNn/HNPH3E2R4gPu6sDkJGlSBd3sCEFm1T5y6Dbfr6nOxWlywfmUxUIEaqTYoJ4N32uPP8/IYZW56tQY5ypLu4DCPYmfsaoVkD4yfmzhs0oW1nsk60tAwFbTh+RDwjxKGE8cMGFLgUZQHsf1/2HdSaxE30lhiOBkwo7HSL/JtnRzNeriDjKVy+30iN4gMeXS/kwDM4M5g1X8XEQITOsCSH56Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(23010399003)(7416014)(261026140227099003)(11063799006)(921020)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003)(261021135927099003)(261022075727099003)(261022113327099003)(10067099003)(22082099003)(18002099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVhtaDNyYXBZYzFBY0RHc2JxMm81aFdPSWxsK0RoTUM2UlR0R1h5SUM2OUdS?=
 =?utf-8?B?UHZ4dkRHeG1JMFpzR0FMdC9IMFphZDNXaElmTGh4TGxqSzB2dDluVFZLekxo?=
 =?utf-8?B?Y3RWQVZQZzlLUi9KNUNnNjVuS0czb1FPelNWbzc0NCt5b3JJL3VuT3FBS2N4?=
 =?utf-8?B?SHZ3NWh2OE1lYW9NUTJsVU9qbmZGeXZZWm9NWUk5SU4wOGxCYXR2Y3YrTlV4?=
 =?utf-8?B?cUM1Y09ibW1wODExQUNJQ21BWXlsNk1Ta09OU0Eyc3NId3RDcGsyb2JTQmFv?=
 =?utf-8?B?M0xyUEh1QzA5TGhYWnZFa3BGZUw4eWwrclV6VjVlVFM2dTAybnBrUEFhaEVI?=
 =?utf-8?B?WUl4a3JBNUxzbVZqTkJhblpMSU9qTThOM2YxM0JUbmtGVzdaeWdiSTBtT0hZ?=
 =?utf-8?B?dDFLRkM0K3pLZ2pFbXdQWE5jeW5xejVabFhSdXN6Y2lsb010ekM1dkFkazE2?=
 =?utf-8?B?bW9WYnNwWmpGelZsYldSWmJMaWx5dVRvMmZSNVRTSG9hR2Z4ZnIrRjAzRGRm?=
 =?utf-8?B?LzBFbEFqTWlsWENBaU84WGt0bVVqdlJkTHhaTlcrQU1MdUFOMWdNcWxXVlM5?=
 =?utf-8?B?Snk4WnJ1anFnSXJkUHZsU1ErakFqZVp0NW82K0RnQ1lnQ3ZIRTRTaE5iNENy?=
 =?utf-8?B?RElKck16MVEwV25GWC9FUDFiUXBrSzRiWkttQ2UrbFNXajRtWTBrcnl5SzRT?=
 =?utf-8?B?MzNuNjI2SCtXQXZZNjhYR2cxbDNKZ2MyVHcraHpPcExxenB0ZTAzVldrZHNH?=
 =?utf-8?B?UVQrYVh2MVBPSFRaOThvS3NjNk1WeXUvaXdWWVFNYkNoSkY2SFNsVXVmdUNk?=
 =?utf-8?B?NXZSTUF0TjJHTzh1aGVjb2lkSGtCNThndlBsdE80ZXVVQjVhbGRyQmJXV2dk?=
 =?utf-8?B?M3hLT3JrcEJ2aEdGejhzNWRqa3NELzVRMXBZcFZZUndmbzBTRk5JN294SWVP?=
 =?utf-8?B?MzBrc2FMUmE3VHBFUTYyYTRtOFJxYkFFWDRMRHVsZHFCOFVrVkhuQUZTNmcx?=
 =?utf-8?B?R0hNL1dyZU1VWkVmTHg5a0FKL1JwSmFSQWJRR2lZWlVYSkdiMkxhOTNXOTZI?=
 =?utf-8?B?Y1NqNzNnbzdyWWtBbXp6ckkvV01DVGc2NDZDYlRlK2ZFQWhBSFRzdkIyZm5S?=
 =?utf-8?B?SzljV3d2Y3N4TnFoME9TdUh4Q3VZcHNENk1JL0JXRHJjQzVFYTR0bmJMY05Y?=
 =?utf-8?B?SHlIaVVqUWdab2ZXVm9VYTlyeTh5Ym1aa1NyODg2Z0JtOGRLY0NaQ3h4NTZK?=
 =?utf-8?B?VkdyOU5IMnRmMHpDOWRMc3Q2MzBRa0ZFMjdYZkVGMDljNU1PRm9nRVZuUGFS?=
 =?utf-8?B?Z1FrdzVNVlpJMWhpUkVDRUREbkdGU1ZXcVdsdmgzUzdpSS9QU21nZ21wY2Zm?=
 =?utf-8?B?TmN2RkxENHlhTUVnZENyaUdtS3BOOS9VV0JNOEFDY1VScUZpeTBHTzlqeGJB?=
 =?utf-8?B?UWpYUFEyMVdKK1NQZU02TG1wdUp1VzZYU21STEJpMk1aWWp2TFBkWldGWUwz?=
 =?utf-8?B?S2laTlBVY2h5MkRhemdVNDZleWhJK3BBcnJnU2FLRVo5NUE3dDFoMG5ZK28z?=
 =?utf-8?B?MWpYTk1aQ1picWlrQ3VDeXZJNzZ0SWpyMmdxdzQwUmVNeUZKTjVzbDZ4bHRB?=
 =?utf-8?B?OWxmSjZhR2hOUGZUQjVvVzBOREg5SmhXc3kxOElRVzYrQW9nWVJoanlwN0Jx?=
 =?utf-8?B?QW1wbjRxWVcyd0V1c1l2dlE4Tmh1R25ERzYxNm16RmY1a1RIazNER0xON3pV?=
 =?utf-8?B?SFBCb1ROaERaem5qT3Z2akczM2xiOHFCcXBLNDc2V1p2cTIxTWhMWWxQbzhE?=
 =?utf-8?B?M1NoWURVamRjZGNjcnBXTjl6R2FqYUNvZlZYR1lwVllxZHdpK29ZcmJoZG8z?=
 =?utf-8?B?M1NjSk9FeWpiMzJXajBRVE04WWlJb05uZ1haL1hNcEpGVU5KV1I2cFFPYXl0?=
 =?utf-8?B?U0lIMjhnL21CUFRVdFlETHFjblpHZ00rdkxpbUdCTm0zNElEZnEwczFkN2JV?=
 =?utf-8?B?bkpsMWN4MVlkd1RzeGxZT0huRndySjd1ZTlNdzlkQU9CT1ZONVoybGxlN05z?=
 =?utf-8?B?TE1KN0kxMkRTTGl3SloyWU1uKzNTSDNyU0FBaW02d1l6QmMyLzQyNmNYN2Zh?=
 =?utf-8?B?RmRKbytNYStMRm94VmFQVWx6d3liZXJ1SGRjSUNjb3lPR215OTR1R2dseXdF?=
 =?utf-8?B?Z0xmZEE5bjZHUFEySGd0ejllVjV6NkV2MFJIdSt4NGZtMXEyT2ZHUXZpTXEz?=
 =?utf-8?B?ZFltcUwxR3dLNTFFOEIxN2hLM3R1anA3dWFJNytNZjFMMG9mQ0VvUGg5T0pY?=
 =?utf-8?B?T2NHbWlGT29hRXVmdk5XUTFCREVnRU83ZXNib1IvTEFNL1c4RWx5RmRHVUlT?=
 =?utf-8?Q?7482sUnFiinqkepdesZviYAj7PCNIgmeCkpYJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 996336a9-593b-4d3f-fa5f-08df343b234f
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 15:01:11.0904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97YcB1pQk3/K4As6rJxL97kAY1x4qUaoJNBYRHBKkZyLVAE0LQZFIv6ws7GW++POToJMVsZA+HFkQA3cJqNFjE9Oge99CvhAv8x22z1yKrR1tPdp41e5wv0x2aZoAUXe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11162
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frank Li <Frank.Li@nxp.com>

Add WKS101WX001-WCT panel, which is an industrial-grade 10.1-inch IPS TFT
LCD capacitive touch screen display module.

Acked-by: Liu Ying <victor.liu@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v3
- Use Waiken Technology Limited in description
- Use 10.1" at comments
- Use waiken,101wx001-wct
---
 Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 2 ++
 Documentation/devicetree/bindings/vendor-prefixes.yaml            | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index eb49832b26c46..15f7dc0d0f6d5 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -353,6 +353,8 @@ properties:
       - vivax,tpc9150-panel
         # VXT 800x480 color TFT LCD panel
       - vxt,vl050-8048nt-c01
+        # Waiken 10.1" IPS TFT LCD panel with capacitive touch
+      - waiken,101wx001-wct
         # Waveshare 10.1" WXGA (1280x800) LCD panel
       - waveshare,10.1inch-c-panel
         # Waveshare 11.9" (320x1480) LCD panel
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 473019dd01263..97d77d1759e39 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1885,6 +1885,8 @@ patternProperties:
     description: VXT Ltd
   "^wacom,.*":
     description: Wacom
+  "^waiken,.*":
+    description: Waiken Technology Limited
   "^wanchanglong,.*":
     description: Wanchanglong Electronics Technology（SHENZHEN）Co.，Ltd.
   "^wand,.*":

-- 
2.43.0

