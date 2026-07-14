Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CFCC43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56A7C10E6D7;
	Tue, 14 Jul 2026 13:58:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Vtjgs2Ku";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012064.outbound.protection.outlook.com [52.101.66.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D27BB10E6D7
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 13:58:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXGLwV5euJcTZx5D4ind3O6nMfJ96FigNhxO7CT+aw2TG4khc8GP6MZg0PbVLjEAfL6/wdfbFfwtfwYxuff0wPOMqC48j5KM6AN9lcZeT3p2ipeVmpPihxaCofHGSEtYDbXQFukuGNGq1JrJN2lUWss804f5hoR4GVOxZw9eC010vCan045xcGhxDQYgpwaZj2ywGmtdg8KiJhnJWTlNnHiNEwLGFle+WrvlzCLfMYBbbJNUE3F+TbxFvQ8qDdDjBJVelzBknBAj0cNO84I6KAzuQzrIJjX8whhbLNKGssxm7cyai5x6Dtj9O9cdfSkGZwupHvPFHjDkqD91KKy8nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aYMgx8PBsoCBESXYNUbJr6BHbqJS9oiEFR3VUA17Jc=;
 b=EM+DyD1IUXaWR8f6QQCXfDYiJmdXO9b6kUosnpEYDeR/J1Uoud6bTuXiX9ur2NYYx51mvHp2Eo4z1fvCvIMl5rmDQUioI1O2sOEJeJqkXrH+Qppg0qFCgwpYIoSwGOowkMy/hFAEN4yOCpNPs7//szTpVtU/J23Mer+WI0qCT2ptg2zZGaL88SOqnFo5ioAv8/6W3AqVNUK/8BPZ0me6HzQgSHv7jS39JtRkQqvae5YxHv3eRlY3yZwIo3cVC2JaNsgC+wBHnmfWS3R62kj35MM3i42PMARvdzA1WNhyzwDgMfL/1UfGlYbeUZdP8BN0iNbZ3LX3tKIkzAnx+SLhAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aYMgx8PBsoCBESXYNUbJr6BHbqJS9oiEFR3VUA17Jc=;
 b=Vtjgs2KuxAnUhTUpN4m/UoXgjrPDfu3DhWwFyeE4loNLUwHPnDGImmNrg0/df4iCo3CS6HZRE7OMoxnuFBa6aVwW3aWB68uiFQ+vRZcR/7Q+69lSv46zjzgOzCN2tqDo7PtHTofumC13zyZX7QQ/0mxZXW1ERDFAmpytELq5eh411guzLWeGkSjXePeSKtH2LLqJ0DHXPwUM6YTem1KDSRZXBbvnpUdyHRrm+sPyGv+fdXqXMsvHFEylt0yHtGieuj7pYJ7VWt15PaMbB5cDkOBAgjBCo/Wq2+jA1VI4GSQ2TFVPs2lq68cIoREdOb7zh6KaUNvX1zca7d1kmcy7nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB10842.eurprd04.prod.outlook.com (2603:10a6:102:483::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Tue, 14 Jul
 2026 13:58:51 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 13:58:51 +0000
From: Frank.Li@oss.nxp.com
Subject: [PATCH 0/6] display: lcdif: imx: add display support for imx8dxl
 and imx8qxp
Date: Tue, 14 Jul 2026 09:58:42 -0400
Message-Id: <20260714-dxl_lcdif-v1-0-6761a8a6592b@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJJAVmoC/yXM0QpAQBBA0V/RPNta+0D8iiQ7M8tIaBcp+XeLx
 1O3e0FgLxygSi7wfEiQZY7I0gRw6OaelVA0GG1yXehS0Tm1E5I4RTlash2WxlmI/erZyfm96uZ
 32O3IuL0DuO8HewVv120AAAA=
X-Change-ID: 20260709-dxl_lcdif-d6cbdbac92fb
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037527; l=1681;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=v9sAuGJs+AsrhAzyqEtNkOIXJX9sZtdtSfjr35Mw5pQ=;
 b=DtnDr1Yyu01qL4D8WGpA+wB8vccxRTOMqkCL49CX9mlR0KMktrtaBdiwtGDnXJrvxWoOVXDbM
 j6IyoeLwsPoAZ/B7OI5arLs98tL2vHog6Qlvm6w3rmuKiWB+ME84OxL
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:806:20::6) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB10842:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d60bc92-ae50-46ec-d0b1-08dee1b008fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|19092799006|23010399003|1800799024|18002099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info: 453QlmpOlgkQZLbwy6sKzPpdpq45BznCI/WALqodvL400rQ6Xn4X/nY0swHtxr3ihpZiAT9SLHqNloEBqTdzC5GlBkvb6SSW9Vo9MWC3Ra1N6Z1IHWaRr/wJqSz1MJCO+NjXJrYMrsVkaNrEFBQOkZ1W5pZqYhcoj1bX1ncTHqZ30zDxqX0C62tTRLoQ2v+BdDhEMrRznvSgbSp2TqCmIjM9QwW/Dhen9Boo5cx/QRB19r7Wu1yfBUfu2HG8mds4tQIMkIJn99WN79s8Yd6kPcc8XhUNOik8IfdnPmmmSZpuqxE+i/MvGYzJno80rJNLjD7PtLzeBEAlcJzy7h1R76BwykK6JTU9d1Y6Pbs8AeezhvTAsMOIr8g1N9zLuTdB53t4Th7i6MyJifuOptEF9zst4/MgGX3iu8G1lxuexOfQ45kpRML1qI4XAio4R1BBo7Qt2/rwJlYQdos40LVOKi+DWQjCMjUyLkTNVvTcfQ+L4rbYVSNaccrY/K59BcLPGdgxFYoaaBmaoYIOkL6hmY5WzWOO/TWLVMXins0mnl9NCLzcwyaLUc4gPveEyxRQSF6007CpRKYnW4s4M677XVjimAVYz9YB/WSjqAEgxsg9Zn5qf8WkXNtsZvfV/YB2D1YSafMcyhV1h4SvXeGmMRWlqgnvI/v94r8O0GlqJzU5+Zmsz4tExAz7p2CrDpOt7chuZVqqcvs5nmA+WSgBcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(19092799006)(23010399003)(1800799024)(18002099003)(56012099006)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGpMNjdFS3E1aXdoejlyM1g0MFlVSjBEK0x5RGVONmQ3bEJwb1JiMlN5VGNU?=
 =?utf-8?B?cCtJbDArb042UVdkU0FtcU5RUDA1MWJCdDViU0JmSGgxYUVKT1o1U0hsZ3VV?=
 =?utf-8?B?UFVGMEJwQXAyelFWWEs3MHJjN3VPMzBHTFIvWVkzU2NLTUN1bFpDV3JZZzIw?=
 =?utf-8?B?KzJ5WmJuOXVFa0dlK0NoMkpPKys0NTFudWFaYm43bkVVOU9yd1VqckxCWDV6?=
 =?utf-8?B?WE1UN0s2Y3Q0ZFRWUUVYMkNZaHdhK1NRdnRZcEh0WWZLWEhoZHVvTENpQXdw?=
 =?utf-8?B?TkFmVHZJTVE0Tkt5K3lVdzZGbFJlaW5lS3ZkUWY4UHRmSnVXMmZkZG1tNDJU?=
 =?utf-8?B?b2I5UjhORlkwWVEvcEF6RVVVTGRZL2NZNWl6dkNYbXJvdVY1MFpmNGNGVVJB?=
 =?utf-8?B?ZVVLOFdadStIOGxFKzFtMmk4RjRwOWpUVFNQTEpMcUVPa01XQXFFZi9rMjZN?=
 =?utf-8?B?aWh2NkZZWGZ1clhTemZMcG94R0kwZ3MzUExSOHE4RlZXaWNnWElLNjRLbnN2?=
 =?utf-8?B?eVp3UEc1MkxJdGtCQWJ6OTFZWkhVL052QjJMOVVnMWFSY1NWQURZMFF4Vkxs?=
 =?utf-8?B?OTZTTGNPVVlVMWRoekI3SFRZbXVqVG9qYmVTQ3poZG4vWktybjBBcUxjaXRG?=
 =?utf-8?B?OGsyekE5M2owWGUrcTJjWjV4UmYyRUkyeURpOXk2UDBrK1FKZk1sY2hmaHNn?=
 =?utf-8?B?d2VOeEJ3b2o0N2xydXdKczNJdmtOY0tUQWxoR3NNNm9UQVRNL3hIRHVLVDZ4?=
 =?utf-8?B?cEZhZWxscUJMWHhSMElDam12UThFcWRJcVB3dG5vcHJMYktVUEd1aEk2Tmlm?=
 =?utf-8?B?cXVIQTV6QjFIVkpDODF0TFBmd0ZyZnA1NEhJZ2pKTnplUjBoL2l4TXlJOTVI?=
 =?utf-8?B?aWJ3eU94K3g4NGN1QmRFRmRPSDZ0MTRGVDFEMEQ5TWgveXJOQnlaWTdGaHpX?=
 =?utf-8?B?ZjdCUkZVL0IrcXFMVFFPTkVBUzVTQTQ4QWlVM28vTHZvT0JxakxvemZMbitU?=
 =?utf-8?B?eTZ3SXN3bVRhSHRpOE01V29ZNjZlVW41VkgvM2lwSEtaMmpWeVZWM2Fkb2NN?=
 =?utf-8?B?UFduSWNwbmJFbDZDRUI1QnA4UzJvQTMydVZuY0s4RVprYkxEM21kMjEwdEIw?=
 =?utf-8?B?TDNSS1dFTlVjZUhjdFN1Snd3SXdjSVB1YUs4ZGRPT2M3V09ENGxtUUQ3SUJt?=
 =?utf-8?B?ODQxWG5kMXl6T0lzZ0xVUW14dlBPVFNOSlpmd3c5SG93eXpaSWVNb1U0aXVh?=
 =?utf-8?B?TVhmQnl1ZmhYbitwNVVSUDhPYVBUekMrVW5vbnltNk5MNGZVdVYrdlcyUFYx?=
 =?utf-8?B?SWxPWlhmY2pGY1dCaFY2Z1BoemFJQlVZUlZVUXJEU1EzWHE3YnpVK2VRWjYx?=
 =?utf-8?B?RFgzRGgvRFQ2bzF1SlhHbmdEYkNjYzZicGJhcUFSVFY4WHo0L2czWDdDbzZE?=
 =?utf-8?B?MFZwaDhlaDRQOThpSG1zSnRxai9zYlo1MS8xblRnT24xbUJJaHFIa0FucUI2?=
 =?utf-8?B?N1hZdGx4L1BqcjArKys3NWRDY25NKy9OVHFlNnNIbjYwSkhpOHpVRDY5d0FX?=
 =?utf-8?B?bWJzdkcvTURhYkJ3Q1E4MHVIbERZeGNTT3N4RTY4RVBjNWJ2TFhScmtDdElQ?=
 =?utf-8?B?b3FCTzNuTEt0Q3M0dnFsaDBXZ2V4SklmVXN4RHRCM09FajNERWpDNklWMmlq?=
 =?utf-8?B?MENWT2Vlb0g5bUxjN0hYdUducVlMY2hHemUzZ1FUTzJQVllaOW1IUnlJYjIy?=
 =?utf-8?B?czdscXlZdVYzL2pqekMwazFHeWVhbTR4TERua2NWdU9HR0VDUlFZQU4wYkJa?=
 =?utf-8?B?Y1dyRWM1a1BNT1JkcGQ4UGR6WUFtdnhCQ29sK01LTnptWTFFalZualBjdlN4?=
 =?utf-8?B?aVFqQ2JTUDI3M2xRczYxaTNBcXZySkVSYmVhQllHbS9rdXRQN2J2VDgxTU9T?=
 =?utf-8?B?RmtBV2RldjJTVGxCdlcrc1hOZ042VWloVExIR2NFUlM1QWcxOGJVZUplZHJK?=
 =?utf-8?B?aTFqMDArVFNTVWVKK3dsdFZSenVpUC9pSXhDZDZkNGtjc2VlcGlTamlYemhq?=
 =?utf-8?B?K1pjNTJJZ3QwUkYwYk8vVmZ6b1ZxdXZGSWlwNmtsNWQ4bFE0WVRlUFg2K0tT?=
 =?utf-8?B?bzE2eWNjNUpoTnpaRGo2dHU4Nk4xbTdJOHI2U0FDRCtnMXRNMjNlalVFbGJZ?=
 =?utf-8?B?RTlzUUk3M3pPYkM1YUFFYzZIQTV0YUVoREdaT1JZRTdNODQ3M0N3U0dPVXJY?=
 =?utf-8?B?cnl5Qnh6cnFJYVdtRlc2OHlFODF0L0Vra0QxRGQwdTdvNVZ5TjhmNlZWc0dp?=
 =?utf-8?B?bDM3Q0FlVk1wRWVmUGJ5NXpZaFNDWkJ0QVhFeVVQSzJPSzVFaDR0MXpMMlcx?=
 =?utf-8?Q?qEAn/X5xlF7w0Fm1PbrmES6VhYLwvx/m8U0JF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d60bc92-ae50-46ec-d0b1-08dee1b008fa
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 13:58:51.5855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: liQ9M5rdbR6HVOwWEZA6XtHxsRqpvmt3/IwCwvglsz1twg6AV4XkeFZfjB9kUpPAfIFZZ0ORwdHqelLGB4/JOzigCSczZ8e47T1wLVVjGWev0EUGLMSwyZ8IODZrsCyx
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

i.MX8DXL and i.MX8QX support LCDIF, which is compatible with i.MX6SX.

- Update lcdif binding doc to support front compatible string:
fsl,imxqxp-lcdif and fsl,imx8dxl-lcdif
- Update simple pannel binding doc and driver to support waiken,101wx001
- update chip dts to support lcdif ip
- add overlay file to enable lcd panel waiken,101wx001 and lcdif
- use onboard pinmux "pinctrl-multiplexer" for on board signal switch

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (6):
      dt-bindings: lcdif: add compatible string for i.MX8QXP and i.MX8DXL
      dt-bindings: display: simple: Add waiken,101wx001
      drm/panel: simple: Add waiken WKS101WX001-WCT support
      arm64: dts: imx8-ss-dma: Add lcdif support for i.MX8QXP and i.MX8DXL
      arm64: dts: imx8dxl-evk: Add onboard GPIO mux controller
      arm64: dts: imx8dxl-evk: add lcdif overlay

 .../devicetree/bindings/display/fsl,lcdif.yaml     |   2 +
 .../bindings/display/panel/panel-simple.yaml       |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/arm64/boot/dts/freescale/Makefile             |   3 +
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi     |  29 ++++++
 .../boot/dts/freescale/imx8dxl-evk-lcdif.dtso      | 114 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts      |  76 ++++++++++++--
 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi |  11 ++
 drivers/gpu/drm/panel/panel-simple.c               |  31 ++++++
 9 files changed, 259 insertions(+), 11 deletions(-)
---
base-commit: 31bd73273b9bf03a3fe32227b417f00d4a94c6ac
change-id: 20260709-dxl_lcdif-d6cbdbac92fb

Best regards,
--  
Frank Li <Frank.Li@nxp.com>

