Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2975606A330
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 19:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=FKQ9/uJK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 123D210E478;
	Thu, 22 Oct 2026 19:37:25 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013003.outbound.protection.outlook.com
 [52.101.83.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2385810E02B
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 19:37:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AieMCb+LLTsg/BMFQeYK45+cmZf1cwpG5lBvr7ZERqV4JZpFuR0aILkgmDpCAnC5U1rx5HVCERYwBG20PvOqOXedO6WK5Af740IrLMm7B4ZTYxtlNpXAsQPgikHjgsp7H3QGvu6Yx2Gqro4dGeaUI679DcXwG6j0cr3/uAAvgMLrzjPYnSBKOQEmfn5UyRYG1UBpCl7Bp/M9llkLyqtONBPNtmx5/Afz5qzjI4s2N1MdjMk5M1sGBub16bNNxt9zwiYdmN9f/DGTeMNXd7SeILop+f0DiRwnL+XdkwHtaKAbOpev/CKMs9QWnkFbqTqUS9B3GcGted+n+5TQW0LVGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zw9YBq07k2QhH0YExmgQOp/XHgybep/qUigWwEHBOhc=;
 b=R8DHgswsi3l9JKuor3wqNsYTzHL54uQArXOPqJ13ZzVrjTcQhIC/t9xn72Yj+0TyPL0o+MV7GdEaInl7EGLRDQhMghaQlPGuptk4dYN0JhIA0JHMTfaltUFokWKKcUbed5BPYv8HajKLHsyPbaxA/KAOecYdHqdz+xulm0KL+nQWbashjdllOTn0QRrPHOIUKtLQ6Yz52uiAp9L/8UVSo5OeezAYulZGOyi3Rxh/Wvwyf7It4pQWI0Dp7CF53aaEvFNNNv1m0jCYBaOrFcuSbqpxz3WP4F823Mf0HuBM4KilMGatODXueKyBcUW9ulNfp9p06lcrHjpOZnDQD5luKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zw9YBq07k2QhH0YExmgQOp/XHgybep/qUigWwEHBOhc=;
 b=FKQ9/uJKfR+i8q0cji361lKqiyAIuITBWqXhJMj4Eawo3McYmdULckClojuq/SpyMr6tuoFycprWYXaTUshZdHkTNhcWoLuXXAgWIZpX8/etcehsup2pqKbGUIsqziX1clE3Y8J02sZSjJVE8XCk/TEmW21zhEuKKtAQUvNcrNWzvtlVizuV+WsF8I6Nq4wsqeN3nyf9YEFK2equOJYV9p3vSoAnDLshjPgXWscEaCuN5uSNPU5JUnK+M7nsGhYP2v5iNgASTNLvaosnHkNAWdt09bVk4s4PsQW9VpG7dDtuiP7sjsSpOU4gdaUUPKvyHRB6RXuEn3FZpm6/SgxjLw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU2PR04MB8679.eurprd04.prod.outlook.com (2603:10a6:10:2de::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 19:37:13 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 19:37:13 +0000
From: Frank.Li@oss.nxp.com
Subject: [PATCH v2 0/8] arm64: dts: imx: cleanup some warning with W=1
Date: Thu, 22 Oct 2026 15:37:03 -0400
Message-Id: <20261022-cleanup_dtb_warning-v2-0-e9502fafec59@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN9l2moC/22Nyw6CMBBFf4XM2ppShVhX/IchpI8pjNFCWkAM4
 d8FjDuXJ7n3nBkiBsII12SGgCNFav0K4pCAaZSvkZFdGQQXOZfizMwDlR+6yva6eqngydfMnjJ
 uMy1kfklhfXYBHU279VZ+OQ76jqbfVNuiodi34b1nx3Tb/QrZ38KYMs6clNIpp43KeeGn7mjaJ
 5TLsnwA9ml4RMYAAAA=
X-Change-ID: 20260924-cleanup_dtb_warning-d350d5b29681
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
 Frank Li <Frank.Li@nxp.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792697827; l=2317;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=q/pRtVjiaicExf2txzeRWtuWCpXR8XFXDWmcF32p5Ec=;
 b=CChRfyZ1cuNHHwn7JBuWtxTJp+BVqmqmCAmh3c/nub8AiSII5KEF2lxuNme7LGN8anLrMOi5g
 1TqCBldGqhEB68WN50UWiQ8vrctOXUDiHttnGMSFq5wtgO3WNyU2WSN
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P220CA0175.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::16) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU2PR04MB8679:EE_
X-MS-Office365-Filtering-Correlation-Id: 40cca290-7328-4d7a-e27d-08df3073df12
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|1800799024|376014|19092799006|366016|921020|261021121427099003|56012099006|261021135927099003|261009223027099003|11063799006|10067099003|261021123027099003|18002099003;
X-Microsoft-Antispam-Message-Info: PUAG6DgNbdVUSZL0z2e0NNjHH6CmB0TkO1zl/2K4RR4UrRTEGK5t7rFnHK5ICmHA2SzqT3u/9o0S/rBtcEyTVOM7cw/jsmbkfHn5RolROCCnOrq0sgnHzmbHAFUKUd0NMZlW00pGKbrHkEMuauavsyncfBQF9UGwyFr7xJeInKvX2qZlr0Tu3n91iy3lxivLOEHRAB6uxjLUMyLF47RV89A2dT8BTQEfLFjLxcH9fRXQbYAKvar3kAEWvHmwYhycswGgegAspjkACqfEqQDeExULBEaExNXL1e/1gy2cNQCcNeNNXbJhdjUkFcnH5Kg5DNPSt2tOcvnhpiexSE9hy/eXOf6iIIfLE52Q5QpgKDDDzlaDnMnZ5LziPYAPK4Yv0Dra5ZwcFN22r5S7p9a944tK4VQl7m6S4bPFHYERr12VKK3L2LeRn+cQ4vidG58vN+LtyCCqNJAYbOJpcU4B3In1hA+A0OdNr7JrKD7LM7uPokfIJM+iudif4qKuX5L92PZtIfj2arNHgWEjo5i0NRjcnkUm6l8Zbxpx7wp5LxMhwmOIyUOIBEm/sXT7AlacpcYyn5n8fZsIdzmxQbvSotKE6BCrx4wgow7/w2UQMCOsAoegqkBbP8b2mhO6kbgsaCkU46LkcbCcKZ0jyGcmVzBc7IFGnzvXcey5ZN8U9V8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(19092799006)(366016)(921020)(261021121427099003)(56012099006)(261021135927099003)(261009223027099003)(11063799006)(10067099003)(261021123027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlpiazcydkYvZXVNcXAybEpIdDBtV0NPQ3lBT3ZGUTZQb1l2ZnJ1ck5IalZE?=
 =?utf-8?B?ODZadHphcFpXOXFrKzdaamM3T1hRNkNvTjRCVkl2SGJ5WmdOQ1h2VnNwalB0?=
 =?utf-8?B?MXhpSEpuRjdRdURTU29ndWhhMVdXdkFvNm1kMDJGOXBRQlV3aVBNVGZnSGZI?=
 =?utf-8?B?ZTJ3UE5SNE1aYmFGcVBMOUk1NU9xcWpzbnl1d0prUXFVQUp6TkhvV1hyYS91?=
 =?utf-8?B?ZDlIU3RCMXVoMk9pMERmT3lYbWcwbmZ2UmJ5TjIzaWhoakY1K2dwR3lyN1Qr?=
 =?utf-8?B?UjJvM004NEtjSXNxYTkwalh6ODJ0ei9NY0daZDFzQUVKcDVqUG9PSHVHM0I2?=
 =?utf-8?B?ZDhyY3BRL3lDSzdDbk8raVhSS2xxUW1CbUNJeEFLTTR2NmpKYWw4WlBYN0hm?=
 =?utf-8?B?Nnh1WXpML0tJZHFNMGE2cW1QUkNqLyt3a3ZuZlF4MURtb0xjUTdadjJ4N1pE?=
 =?utf-8?B?aVJpVEhhL0RhRjQ4c3lwUStYbmsvRUNkbnBlRmJUUng1NXBrUjJBK21tVUlW?=
 =?utf-8?B?bUVtaTlGcjNSdVVyV245ZlhvMkZCVGJQcU9tYlU3S0J5KzVIV2VKY0JJTFhT?=
 =?utf-8?B?aE9RZSs4ekxzeE1BMzV3MW55NWdCN2UvUm5tRGhOUjVONDEvK2MwbDlJSGJM?=
 =?utf-8?B?OVFCeTBFM3lUNFFaN3pYa1N6WVNTNU9OR0Zrd1VSZmMxKzk2QjR1V1RxVTI0?=
 =?utf-8?B?dW5HZjg2eHAxUGVxR1hZWVJZSUtZMUE3RjZ2OWRxc0VyNVg0TTZvQlMyNkNh?=
 =?utf-8?B?WUlUUXpHQWRuRkplUVg1OVIvQkNVQVE3UkdEZHdSekJrNU5VN0RuLzF5SFBv?=
 =?utf-8?B?NTU1emtwb0xESEVpWU50MWx2SFlXR0xyNy9hdWtlb01LWnNJeHdWNUNQbmxr?=
 =?utf-8?B?dWNpQVZZR1kvSDZBcHNjVDBvaTh6Yy93ZW9WWVVtVlc2eXMzTWtHWHZERll3?=
 =?utf-8?B?blhJUldKUk8xR0dVbnAwbUFESjRtMmhPMzdCSjltT3V0ai9oUHFwSEVVNEJN?=
 =?utf-8?B?M1pVbDFUOVhLOFZHTUlsTkNxSFNtemtYVUVnZWJTL1dkQ3R6aTFtc09ZZm5Q?=
 =?utf-8?B?VjNKUXZGc1drR1duNVBxQXVyRFFhSEgyWnA2bU1UM3JrNXBCTGF3U3dvbXo4?=
 =?utf-8?B?eDJIRUVZaWVRN21NYWs0SCt2aWwzUCtlOWtuOEVZcFJWR1hnOUhDK3lYamd6?=
 =?utf-8?B?eUtkS0NBVWppYnVPRzhrdS9ZNllrV2txUUNZdFJYdlhVbEdsMWtCQ3RWYmgz?=
 =?utf-8?B?MzA1a09JQ3k1YUVpNklzVEdlQjJuOUxmbjNCbmRKT1NTUGdGTGx4OWx6MmFp?=
 =?utf-8?B?NmpRbmR4VUJPWUoxNldpSHk4MnROQzdlT2VBZjl2STFYNG9vNFhaWjNVSS9x?=
 =?utf-8?B?YU1pUW9jT2QzeG5IVHZQamlNdVFhd0dva1o5TDRwNXVYak40Yml2WHd0ZCsz?=
 =?utf-8?B?REM2ak9KcE5lRkhBdWdPeE1NNGRJNDJCRTI1bmd0c3ozOENkMiszSDJFbkww?=
 =?utf-8?B?aE9XMy9xOEF0U0RaU0VtNGltUW91Z0RmRGlBejVjd2w1c2NlQ2VsVEVQY3lB?=
 =?utf-8?B?bEk2cTg2dFBva1diQ3BuRTVIbll1Wkg3Skh1T2R4WUtuVTJ5bXlRZTBMVGRN?=
 =?utf-8?B?OU1TWHV6OTIvQXZQbk9RbXVIRlJoeURUcGpJZmNUSndkOGxhM0JDUC9GRTNn?=
 =?utf-8?B?QVV3ZzB6YW84bzFyN1JOdTNqVkpQQksxdGxPT2dGSXVhcnQxUFdtQ1hwNy8y?=
 =?utf-8?B?Q1Z6eUs3MFdIdlRsa1d4RnY5U09Ob0lyaHdxb2diR0J1aDdBM0dBbG9Fc0dH?=
 =?utf-8?B?VFU3QW9GdEZGQVNJTjVSN0ROVitZMnp2czB1OE5SQld5MlJ0eGRFYXNQQ1dD?=
 =?utf-8?B?NExTaFFUOE8zNnNEVG5XcE9kUEVSa0Z3VVQwOWl1dnc3MjlmbHVPNy90MTBu?=
 =?utf-8?B?TnFrL1hNZlAxYjFZRzYrY0ZJY2VsSmgwMGJtOHhNTG4wSy9XMnlXZHdiTE00?=
 =?utf-8?B?TjNmNTVGSXY3akh1QTY2d3ZZWVJ2eHVDQVJDeHE4SGJ1WDVNQ21SNVZjNEFH?=
 =?utf-8?B?N3l5eDlOcVM2M01DelFyMlpLc0xYNjlMa00yYkM0Szc4TW9GdlNnT0c2SjJQ?=
 =?utf-8?B?MUtjb3hGTXRnR0szcEtUbHVYNVZxZzMwcG5uM0dySEVYZEFqTUJaTEVFRi9S?=
 =?utf-8?B?MFBmZENYNlRHaGMxUVRqaEdHbDZNdjBVOTlCZ2pYcVVvamdxWDNUMzVKQTcr?=
 =?utf-8?B?VGZ5WktBNjYyVzRqcDZYLzcwZzdkMnpjWUNXME1oRlBORlVzVjZkdDB0U0JW?=
 =?utf-8?B?VWdKYXJlN29LNitlZGl1YTQyMnA1Q3NLWFM0cDdDakcyS29CZUFDZ1RnMmtF?=
 =?utf-8?Q?/SkaiOvkrcd1RPMvHUNmmoLThvj9/yf58wt8V?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40cca290-7328-4d7a-e27d-08df3073df12
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 19:37:13.2854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HnbIpAhsil+a+lYoXOWhyNEewDJL+5rfbpJZkZudQdTC1QkqOQjCbR1ktPb2qzMVDbFTjro6Gxqsl7klXUEsz2/VVSobLShNg4ybUmjN6hZ3FELyXzMvQBTZhjUlskE
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

Cleanup some warning when W=1

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- collect review-by tags
- add description about fan-controller optional descrition at commit msg.
- Link to v1: https://patch.msgid.link/20260925-cleanup_dtb_warning-v1-0-f999fafbca60@nxp.com

---
Frank Li (8):
      dt-bindings: display: remove #address-cells and #size-cells off requires
      dt-bindings: embedded-controller: remove #address-cells and #size-cells from required
      arm64: dts: s32n79: add @addr for *-bus node
      arm64: dts: imx8mq: remove #address-cells and #size-cells in dsi@30a00000
      arm64: dts: fsl-lx216x: remove #address-cells and #size-cells from pinctrl node
      arm64: dts: imx: remove unnecessary #address-cells and #size-cells
      arm64: dts: imx95: rename bus@4c100000 to hsio-bus
      arm64: dts: imx952: rename soc to soc@0

 Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml     | 2 --
 Documentation/devicetree/bindings/embedded-controller/gw,gsc.yaml | 2 --
 arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts               | 4 ----
 arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a.dtsi         | 4 ----
 arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi                     | 2 --
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts            | 2 --
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts            | 2 --
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts            | 2 --
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts            | 2 --
 arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts            | 2 --
 arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts                 | 2 --
 arch/arm64/boot/dts/freescale/imx8mq.dtsi                         | 2 --
 arch/arm64/boot/dts/freescale/imx91-11x11-frdm-s.dts              | 2 --
 arch/arm64/boot/dts/freescale/imx95.dtsi                          | 2 +-
 arch/arm64/boot/dts/freescale/imx952.dtsi                         | 2 +-
 arch/arm64/boot/dts/freescale/s32n79.dtsi                         | 6 +++---
 16 files changed, 5 insertions(+), 35 deletions(-)
---
base-commit: 3d7783543c2646af69ad65825e810060494bea21
change-id: 20260924-cleanup_dtb_warning-d350d5b29681

Best regards,
--  
Frank Li <Frank.Li@nxp.com>

