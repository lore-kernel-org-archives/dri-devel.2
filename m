Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE5B606A33D
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 19:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=QI58yiWV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36CD010E484;
	Thu, 22 Oct 2026 19:37:40 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013003.outbound.protection.outlook.com
 [52.101.83.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6714010E484
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 19:37:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVVJRvklULa/BQx9koT/aMScXaSylkHzK9XIFBI0o7bLXNX1l/Hb8dDYMPhyp1m96Mm8A0MBcGyhwDi2kqF7wlk/Oq/IVf1rbDj3We0XzJEZ2n6SgllLU6lMEESt7kC7Ysm1+/8OVRKbXMPENGU+/v5F7ztlYeDGc5gUhHjb5SSnTkVjySTw3tQ1bf57vD0lj1EYWz+54VCKXGqkucRhe117XLVCnm87nhjE3X/Dd/6yajk9IddbG6rh3b0dbuC8k8nIZEr+bFrFh2HkQX2mtudn7/l+KUVP8+ihCeDGdTd0gyEToFtPD1c2XekZHfbOz64HE6RZ+7L5GCB6HXq+NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uSE3PIasmRmcsSz3TdF7eGvKdirpZ4KvtL5LyRQoTo=;
 b=YKFGYftjkOPObr9xnGGsg3o00sSUwPyBU9v5AGzI5rkoPrrBVxyvFIuAnYp+e1R9jkZGiNDRaV6FgNnlogHLj3d5QEg6mZunNRwz33M89wVr3r6k0wSXsPIkkv4VIT1eJXs8vZEA4xnT+PANQjDb8c25eO98A/nZcXFwlTP5Oo6uPJnLA6lVN8lVPGj5rZqdlTXoFFn74Ztye4wf27gAwrVQZsJ7LR85sGEQNZeWwg81W9TCHF0hOkk5/4MxuTPzkl6DdxTgQKhEVm9eT7oZv2UWrE+EZ4rPp97MoKiqublD1zxr/l+X7QgEQZQbKNRN1T/672u4Z5jv506q23ilzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uSE3PIasmRmcsSz3TdF7eGvKdirpZ4KvtL5LyRQoTo=;
 b=QI58yiWVKSdDPkh9Wvmt8PCRbf5YWpahCD6P0sNqKmpQeXtcdml60kmR27zGAUgUGqXX0uer1ZZjGq9NyXKs5sz7bphGmEtLo2iAix0gW6ELQCtXUzmfnfSCjHgvZsFcrC9jsk0izKDUs3yQPPD8HuiXHQ+sgxbq9c6PxOqkv9a0M7Yf2sDNWbWNRGYC/HhEXvmj9mvwG2eADWwofgoSvdeGBChSRRS3PoE0NGuYtzXOStL6Q2Ovk0D0Xhv4VxuXAiMtr3BpwBakg4lUmGPi31mC7j+y79aBY5BTIpirHmIhKVAycw/qvGA4yAi1cYHgj2h/wH7KEtzx2bM//R/2Tw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU2PR04MB8679.eurprd04.prod.outlook.com (2603:10a6:10:2de::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 19:37:28 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 19:37:28 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 22 Oct 2026 15:37:06 -0400
Subject: [PATCH v2 3/8] arm64: dts: s32n79: add @addr for *-bus node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-cleanup_dtb_warning-v2-3-e9502fafec59@nxp.com>
References: <20261022-cleanup_dtb_warning-v2-0-e9502fafec59@nxp.com>
In-Reply-To: <20261022-cleanup_dtb_warning-v2-0-e9502fafec59@nxp.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Guido_G=C3=BAnther?= <agx@sigxcpu.org>, 
 Robert Chiras <robert.chiras@nxp.com>, Tim Harvey <tharvey@gateworks.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792697827; l=1254;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=nB7faaEbs5kmM9kgbX8hNbBBTX3zCIZUqlHBBHvU2WA=;
 b=iCZY3nmWashIcJlCWCherdEoJZo7B9KTodQBumWuEYjV5LWe2k+Ypm/97L1+7JVqx+DKNCLyc
 CE55CWzdV44BE24Ij+K+jgus38jPfu1Qmg8JuWphgpZ2dfdCN6UetOa
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8PR21CA0004.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::11) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU2PR04MB8679:EE_
X-MS-Office365-Filtering-Correlation-Id: a25c62b4-0ec4-46fa-ebcf-08df3073e850
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|1800799024|376014|19092799006|366016|921020|261021121427099003|56012099006|261009223027099003|11063799006|10067099003|261021123027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: gdpT7lTmqexywwJSR11Vme/oclK1spBY2+mToo2FwiGrj8rMdMcUFXAX0J8LQ1BRWrhMILtqT6isOUPEieVtli4F5fXUWOrU5kKRwXJi3bnvJO0buO3zO9m/6nFQdMoUUR3XxP46PmAbU7EhT4suBxolNO8aZA1gnr48ipwJY08ncDzi6m4NC2SSrU01whTIdXtD89THsChTwzzAhAf3516ztR+JJOGNwe7+IrFJQwWFYZ/PZO6abu08li+pztGoHjubRbTL0ZjyjOI1GIlvzXCdWYU1nDzCw6609UkUs8TlU5KPAMdPU7BknfHUlhtDkZwRE1uBAtl61EE6RWvCESY/C5eO1Jer0xDgTfv/YxorqixapRltIkqfzG+izF4oXS81XjRFcJxLOssdegWsa6aRbjDeJSZoC2jjv904qMxPge/pxD35veGiEEct8yOsx4BhVn8oKq2MFGs6kUhrjvawd0o0AOk8jm/De2d/ileuQniF8EXFN1/5cqoxFhlMrjHaeU9zDkuM/knRDgD7hLkxEUXoUFOOQCGca/PagHsUjWzA6nS4O9/zV71s9M0QxbOR1xl3Udb6d8OQbl5+cDNzlR/FH4iaFMp38ozFFPc8LjaMY2Hr+UClAyqDut4pz3HX2swFqhMUtg3bea0C0PnMdQg5KUhfqIHv8nZnthA0fRZXeolfID7RKut9XjfjeOEqoXGgBKXTqMw6EPbd4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(19092799006)(366016)(921020)(261021121427099003)(56012099006)(261009223027099003)(11063799006)(10067099003)(261021123027099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVd4NjNtRk9rdVo4QUxkNWVjZnZnOWJYVzRMTmF6RGJGdTRtN0FKTkVyMmpw?=
 =?utf-8?B?MXBLME9FOEN2TXR6andDUEV2dVJVSTZMY2Y5U0F6K2JGVUFDZ0lzdDNxUXBY?=
 =?utf-8?B?dEcyUEV5RDc3L1VXajVyTTl6djk3dmlWRG96czMyQ1lVWG5iOWt0eExERFZJ?=
 =?utf-8?B?YlBwWW9zOGt4SXMvRUU0NVQ0ZGNoNCt6YmdNdFg2d1NnRnFkbXFJOU9Xcm9m?=
 =?utf-8?B?NWFNdm9FekVLdjdOZk4yczF1R1lITlhDbnpFQ3RMUDk5dktFQXRXM3NUQUVi?=
 =?utf-8?B?RnUyZEl6aXAydmVnbnpvTkZONWd3dTNtc1EyTFRRVll3M05GVjZtdTMwTzBk?=
 =?utf-8?B?T0g4WmdSZGVRblhzdTdBc0lrZjBYWUZ3M1B6YSt4TWJyMm1MRXNXMXIwd21h?=
 =?utf-8?B?UGwwU1lEWFc3RGU2TUdETWpOWHhiMXRKMzZ6REVXYTVXcjJWS202THhSdVpy?=
 =?utf-8?B?bS9maXBnUGRRZ1pESFBUMG1YdVZ4TUlFMXc3d1FmMHVKZU5USVZMMUNVdnQ5?=
 =?utf-8?B?UWRSaVR5NnBxa1paM0M4TGNBT3FKbnJTSXJ0UWtPVDRaUzR0YUtSeUVwaFFP?=
 =?utf-8?B?c1ozaWhBcjRaemhRSUdIQlg5bTlvYmJyZm05RDJXdjA4UmZmZGhNT0NMS3J4?=
 =?utf-8?B?U2NDU0FZTVZoQ2Vja2ZUUXptZ0tXdmR3dE9tWTRSc3VvbmJRR0I0cmtKdEhH?=
 =?utf-8?B?S0luM2pRcmVCUElrZUZacE83eWc0L05LOXJNZk9PR0g1OTZ1Vzd4V3NhbnRo?=
 =?utf-8?B?M0FLTkRQdmR3YTJKMDhveHlUY1pkWmNmRUtWeFFVM1AvME5RZU41Q1JuMWpJ?=
 =?utf-8?B?TTJld2dxOVR1UUhXMHNONHJ6UjlJYlBYQTZKN3l0YU1zelUxdHY1dmNmQ3p5?=
 =?utf-8?B?MUdJK0o4bVljRGRxUUhMWXVaRWsrK2wzSERDcDVrQXpZK1RUY2Q4THp1eDJq?=
 =?utf-8?B?ajB2RkhzclRmSjlkSjVjWFdWTndkbm01MFJqWWN5ckpIb3FGWmV0RnQxNnJi?=
 =?utf-8?B?VmxiaHNnaXB2QUFhYktLOGswWFpaNUFWSVhWVVAwZHBKV29SS2NDNjN6dDk4?=
 =?utf-8?B?RzZNb1p4c05tWWxkMEkvcW1USk1zZVZ2cFkwR213S1dhQ1dvN3ZPN3YxeXl1?=
 =?utf-8?B?OEd2ZXhtNTF0N3FOdDB1aXNFbi81aW5kK0dVME1LR3dLTDlJbjdKY0QybWJP?=
 =?utf-8?B?SFB6clZ6QUtlR1EyTDY4TkhwMFMvYlJXQ0NxbUlCeXBFaXR6Y1kzdXdQR1VV?=
 =?utf-8?B?U3VPcitMbGIyT2hhNXg0aVFvcWNTek9NUVdLbWZNVzhBaURraHcxMXA0RUN3?=
 =?utf-8?B?VHpoaVpSeityRXNTK3lDNjZubktwY2lPK0JodWsycUpGcFFLNG9mTDFVMVNp?=
 =?utf-8?B?R2xlaWNSWERVb1pDa3hLVFBqVWpZUTR6SlV4Mzk2SEtrcmk4QjU4aDhoRmNn?=
 =?utf-8?B?VHlPcTg1dktGVndGbmYwbHVVNnhhakh4dExzYnpqaGhnVG1LbXF2LzhpTnNa?=
 =?utf-8?B?RjFZb3JSblZDOVhuZkVCeDFaWG1HUENzUkdaZUNMK1dwTWltbTJQQmlhWWFz?=
 =?utf-8?B?aFVQcERLNDk4RU43MXdXRmVpSmo0MzB4ZnpvL2JRbHE5N29JSDVpN2hLOG5F?=
 =?utf-8?B?Z1BmMi9OVjVTbnY0SGE0aEx6UU9pWldWWmpyZldoTmx1QmVGd3VybkJSeWM5?=
 =?utf-8?B?cldJbWtCR1M4ZTQwMEFoWXhGU09xWWlyenJ1Yjk1RGwyNzhVRm4xR1QyT0J6?=
 =?utf-8?B?eGlOeVpLUlVndzVkc3BsN1NjUmlPMm5UM2dpQUtPR3dtRzF3eXNoSmdjQjVx?=
 =?utf-8?B?UFNETFEvOGtENWY5R1pjcE1oUlJBTysyT1o1OENDWG1SUlZVT0dOSlJya0NB?=
 =?utf-8?B?aElsKzlMTGdUYmF6dkZyWjRzQmFUTUZVZ2lrL0x2Rk5pWFRtV2t6OFhKS25Z?=
 =?utf-8?B?TU5XejJ5a2hMTGR6cG90WkZlN1lqU3JLOVpmNHJualE5dFVkSmF2c3Y2Q0pF?=
 =?utf-8?B?QldmYXZ6b3pqK0ZOdnQzMEFYN3NuNHZHNmN3YVJkUmttcWdnZ2ZOUjVzTEU1?=
 =?utf-8?B?VGV6cHlFa1RZQ0NGUGpjRnRMRXpzQ1JleXJ0Q0RJR3hyWVNxN0I5Sk5TQ3Z2?=
 =?utf-8?B?enQ5K2YyQ1l6S200VmhIZDlkSHVhZHlqbk5zVCtNK28vMk5IRDkrT2RCeEpK?=
 =?utf-8?B?bHViUlhiRG5rTFBUUHNkWGxoTUtuYi93YXNTTDZRZFk4cEdPWStVV25GUnJH?=
 =?utf-8?B?dVJnQWU4K0M3bzJXZXJ1NE5LVXd2RTExSDhKRE96T2hRRTNtcGtSc2RudW5Y?=
 =?utf-8?B?dDVJVm95di9hUWlYNnJhU1JZRys2RDVBeG9iYS8yUkNyRVJXTnR3Q2l6UmFG?=
 =?utf-8?Q?BuE4upSzvnsitOpVd/zV9729yWL80xurBvCNK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a25c62b4-0ec4-46fa-ebcf-08df3073e850
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 19:37:28.7520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KEVklHVQmIZ6qbNb5pUzzG+SnBiySx1a4vVisvptHyDIm4cg6OiELkwjcXZRLH7tvfCUfQaRPQpgkqh+Mu3xiwr3e+ecCuP0x0pG51tkRr8ud6w2ZZXyeQ066QRKTJcA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8679
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

Add address suffix for bus node to fix warning (W=1)
  arch/arm64/boot/dts/freescale/s32n79.dtsi:15.10-54.4: Warning (unit_address_vs_reg): /cis-bus: node has a reg or ranges property, but no unit name

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/s32n79.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/s32n79.dtsi b/arch/arm64/boot/dts/freescale/s32n79.dtsi
index 94ab58783fdc8..cbb43df8e1bc5 100644
--- a/arch/arm64/boot/dts/freescale/s32n79.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32n79.dtsi
@@ -12,7 +12,7 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	cis-bus {
+	cis-bus@4f200000 {
 		compatible = "simple-bus";
 		ranges = <0x4f200000 0x0 0x4f200000 0xc00000>;
 		#address-cells = <1>;
@@ -53,7 +53,7 @@ smmu: iommu@4fc00000 {
 		};
 	};
 
-	coss-bus {
+	coss-bus@4a000000 {
 		compatible = "simple-bus";
 		ranges = <0x4a000000 0x0 0x4a000000 0xff0000>,
 			 <0x4e000000 0x0 0x4e000000 0x1000000>;
@@ -330,7 +330,7 @@ clks: protocol@14 {
 		};
 	};
 
-	fss-bus {
+	fss-bus@5b490000 {
 		compatible = "simple-bus";
 		ranges = <0x5b490000 0x0 0x5b490000 0x1000>;
 		#address-cells = <1>;

-- 
2.43.0

