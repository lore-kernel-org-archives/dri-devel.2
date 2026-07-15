Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D101EC44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 18:35:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FBE810EF62;
	Wed, 15 Jul 2026 18:35:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kIE1Rj5Q";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013000.outbound.protection.outlook.com
 [52.101.83.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC6C810EF62
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 18:35:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gj/AHM6gia39qaCw5B4wAqnOR+pqu4dSMbGoKZulxwBVWH3lpy9PyBlCMRW8Hn0KnWlgFjpjxfzdKGAIS/PrAZumjYBGCYqlk11Ro8SFED5Ny9hDPcubDhLo6GWloyYIns4STxU/zAI6jj2XIuo5e/43B/ncQQlrUCh93V0rurTOqNZTzbgp2IhCRjbuP7pMYcYBvWO6mGWbKyu4iMeOE+vObbTn4eaUiHyrKytSrAt5ftN0dLg3felt7G3IHLSXECyxlkb0bNzHPG32nN8z+ecY/Wkk4UH/GegTRWK2nZu5dE9nqK/pIIkr6euVyE5u/3RJu/nE1jRsy4t5/pnBdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYppSXENci0udx0qB+ey/PVs/tDC4pjQsQ/7wmuKP1Q=;
 b=TmSktdY/1NfnXo0dBcrBvCyoZJVbWD439vuZeEDyCOCHUzQgsw1Z9mEPDRgd1yOrFh/RptmgVAw69WcwXzfUIUW21GLvAGFm6mSGluJ//khSkSJNGM5jY2Au+w5824tSgFZF2NSaGxjyAb4lUP2nhkFQVhGzTD5RkjQjFuHBhvFEu+OfZhx8UUsCeCtEmDhUXqLMBjh9XvWaDwwTKLXK7qp+FDEyUrD6KXPeuNbV4gjYXEHRoMEC+llbx5H/TlV0vukLpt5T2srvBpI9KEUHzH3BB497b5NB80smAuS65OLtCnNxnIsZ7jsK7wWa2ExfE5nn6r8pRde5QDa9vFP4ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYppSXENci0udx0qB+ey/PVs/tDC4pjQsQ/7wmuKP1Q=;
 b=kIE1Rj5QfdlAPFJZPVtCp6gtn/C68CBpRCaEIbjtXz49uUhGP8MIc/mFmIUDIdJn6X8gUxCTKsui3mfb3RhNF9pfWKfMMLAgSenxXpdSeBHQSrhAc6Vj0KYtTjzebpqvn6OllHpAueNX11aSVLJT/tF+VIe0cBf28DW2zEl3fjOGA6cHeq4oGsFpgwqYCIQtLCiqHqRoJhhY2z6cSr3VjYhUhmC2BZ/t1+mLThWThXXutgX9iOT6HU16+b6v3/s1Mtsa4imfN/PITi16gw+TmW9Yj6Z8ZhMNoHPCnteaQaGpWbTgzftXYkFYGP1I7xX316JACNLhrpoYkzGB6S0Buw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by AS8PR04MB8359.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 18:34:57 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%5]) with mapi id 15.21.0202.018; Wed, 15 Jul 2026
 18:34:57 +0000
From: Frank.Li@oss.nxp.com
Subject: [PATCH v2 0/7] display: lcdif: imx: add display support for
 imx8dxl and imx8qxp
Date: Wed, 15 Jul 2026 14:34:45 -0400
Message-Id: <20260715-dxl_lcdif-v2-0-da797562636e@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMXSV2oC/02NSwrCMBQAr1Le2kgSNLWuvIcUydc+qUlJaqiU3
 N22unA5MMzMkGxEm+BczRBtxoTBL8B3FehO+rslaBYGTrmgNW2Imfpbrw06YoRWRkndcKdg8Yd
 oHU5b69p+Ob3Uw+pxDaxGh2kM8b3NMlu9X5cd/rqZEUpELZg8SXFsuLr4adjr8IS2lPIBjBF8R
 bIAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784140492; l=2027;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=C52/GGxRXQhNJ9zFB2eQ9xfh9U3coodwYTO1XiU+TWw=;
 b=6KxQ5gx9VHK2y+mXwx97oc/PNUti0zgpz+erQ6mgq/Id3GH7AMykCDK6hGjh3kvv5ZOG7mTur
 y3EprdcJypeBrEA+I8RPAyYNKmDZPikk1enXPOuHw7c2YFLsJtvujoA
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA0PR11CA0028.namprd11.prod.outlook.com
 (2603:10b6:806:d3::33) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|AS8PR04MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: c3ab03c6-c35c-4f78-d4ee-08dee29fc516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|19092799006|1800799024|23010399003|366016|56012099006|11063799006|3023799007|18002099003|10067099003|921020;
X-Microsoft-Antispam-Message-Info: jnEOnNCpr8lsjdN69nGS1/mijHxMXFeXbiNkkbTK5Nwjf0fKy5kTqvFzngnxHEJQJVZqHzEzGf/2f+vHLh7xNrP2DORyMK0hj+bn3fENJKmDBZthH3JxOQMzkggFrOAul7iGdPO72kieUy3TnSuaFZSqmFfLfN1F6WSbDGfQzktQIAcJitxo0YdHhulamPw8sOvuu71rkO4mpG4dGPUBfATC1r6ujYi1TmLQR7uFFBbDHcv1GlmOwdsjqiwoe52rBCReF47Q/Bry1H2NXVv7BobRgOEmBmE5K9QVec0fbGKzkomaRYOkkl7XodcPxKpXme6GV2KSZOWmcF0Jf5Imi+3Gpl0ORZVLwicmM7Mptd/88I//OiZ0SuDS8d75Ww/UcaGkG4elF3wtnsmG62VLWEuORvv3z/4dLLryEhxkpYOSOhtUWg7nB2O9CB9wBqn99ZJxM1MAxUgDL8wyn8RrrTjVAmNVxNotyma4za9VKcbbpPf23oKcQ34by2vo51YePMQtVHZQHi0AQNMzdVp5lLwmMsOHLSyl+iL4PYXwiKQadOnC/vwhDSWdqLlYIEX67yL4mml/FAhFSMH9n7Cnxpsg+vG5NojP/ooh8DLsShKH4t4v6Yb6gMOysltwa2f//MkoH3DOptNB3OarKz03ULKsxtVHi/yppGVBx69pgZE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU4PR04MB11791.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(23010399003)(366016)(56012099006)(11063799006)(3023799007)(18002099003)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amJmWjgrUEFyWnpVNkhMVEthNmQ3eGdNeXRLeE15TEl5WUZWdkpPcHlhNTgx?=
 =?utf-8?B?MkZqeWFuUmRsN2p1SWRMeFdXOHJSVXAvZE5oNEsrb3B2WUJYZEVmOWhWL0U1?=
 =?utf-8?B?QTNXTzBybTNWWkRtMHpWbXY1em00czg4RFJ0cmE4aG5VMUtPK2M4WFd6RW0w?=
 =?utf-8?B?THhCUFYwU3pCdk5tUEpSb0cvbnRTeFE0TXZ4TFJzN1pZbkUwbVIvU3Y1RjB0?=
 =?utf-8?B?R3E1MWtsSmdLenlpRlJYYkFRZ1VYNnRPSFJqcC9YWDhEWUtKM3ljVGJreXBN?=
 =?utf-8?B?OHBWMXlGVkZoZ25wcmtlNzZyWXdaUTJLS3puQlRHWFBmK3UyYjRodk45enps?=
 =?utf-8?B?NFRZUkJyS0FnY1NnSzczbTl1eVFzck1hYXN6NXVSanB2TWljMC9IeVEzWGtN?=
 =?utf-8?B?S0VVL1RIcWRVVnhOVTkrQnVIVmlVTTlzZWNralJGc1FiaEtyMlFRdTZZNGhi?=
 =?utf-8?B?OFcwY0I1b1luSHRxM3pQT05lWUZYZXQrQkZqbDBVUS9wNHJGaGJjNUVuYWRt?=
 =?utf-8?B?T2dXSVMrY3lCZ21qMlJ6aGtZQzdXeE0zN0ZCUTc3TFhDQzQvSGZMNGNQbFgw?=
 =?utf-8?B?czVlV0pSMEdRY1lSQkFKSDJQcFkvd1o4OVBYNEF4SDYzOUl0eUZEK0dqZmpT?=
 =?utf-8?B?ZTkzQ3FKKzBMMSthN0VNQS95bGhDZUNwalVUZUlrL1crSWViVFN6TmEvSTUx?=
 =?utf-8?B?dnNBYkZ1aFJUbWtOZGE1ekIwV2RhQVhwQXdCYTJmL3VDYkN0dWhGK2VjK3ZX?=
 =?utf-8?B?Y2t5Z3V6Q3NRVnVlTkkvYkszTFFDMExKT0xvVm9VQ2RpUFJDeHVvdk52anQ4?=
 =?utf-8?B?U2tZTVlRVHl4Q0tFZTFaQ2NNN1BCMjNWaGpFenI1cjBtV0dYMm92TkJscjJD?=
 =?utf-8?B?WHdSMVNZRlpHc0lVbDRjV1hpSmRzdUd6VFpsYy9JeTBNSW9VekF2L0FBSGFE?=
 =?utf-8?B?eFFmWEtGa2NGVFNRQktkaHZHdTY1UndqMmJXdWUvcDVUR2ZOazd4T3pmeGpM?=
 =?utf-8?B?NHEvWVVPOEtFbmFYS2lWc0JzSjhBdzhDZXJ0TUxhOGJMYXFsTkE5UG9MTGJM?=
 =?utf-8?B?aVNtL1FEcUQyWExhaHFuc21hQ0lMazlyU1NDNjJBazdYMGlKcStJTGVicVE4?=
 =?utf-8?B?em1aTURGOWsydDE5c3E1V2gxem03V2FhQlh5K05ZYXVHSHRUb0JDeXI0Qmwy?=
 =?utf-8?B?ZGxOSnNOcjZqbit1R0YrSG8xRm9rRWc3LzRTQnJMbmhqNTlWRnRWQ0I2aHU5?=
 =?utf-8?B?TUhNb21SVWMzUXFaZW5DRTgzdFk5T21uOGhyTGF4WHpFdkRJZXNCU1NPU2lE?=
 =?utf-8?B?ZS9KU1hZSkZCVDd1Y3F0QmRCOU5CeXBCbCs3YlVlQzNhNCtHYXU2TmtrcFo4?=
 =?utf-8?B?c2FOWFpZTGpnKzFkTUJCdGxQZkdrZXY2ZGJlWVJwb0pNU1c3SjgraEkyMUlj?=
 =?utf-8?B?MStsOVE2R3BYVFlFQXlHTU9xQW5HR1hqTU9KVGpZL3dkN3NYQ1RnU3RydFZK?=
 =?utf-8?B?VnJ5UFhwZVVVSnhBSWtURlhMZi9JUW54ay82MlpVcitJRXh6cmVTekx4Y3d2?=
 =?utf-8?B?R3MycUdiL1ZUZGNGSmVjN21reGRGZHZHYWNlV3FVRmtRMWpmNDY4TnFkakhU?=
 =?utf-8?B?NWFNbDNWN29vL2FRVzN2RU90L3VjeU8xRzNOZVJDZ0Y2QVdFSjVrRFgwZVNY?=
 =?utf-8?B?UExtUzhOYkhiYXdpbmxBdU9ZL1lHUzNtZUUyUnZXMVdxaHgrWXFIVTZKdnp1?=
 =?utf-8?B?OUUrbStwUmRGa2lndVpQZWE5NnpuVEJhOTR2UUZjYS90bit5MUd0ckYvNklN?=
 =?utf-8?B?d1hTaXZGWkFkU2FyRWI1ZmpNTVZVcmhGbXNoMmxBa2syZElSa3ltYWx6emlr?=
 =?utf-8?B?QUpMQkhERWFmZ2VqSHBWQTVhaHhvazZjaDBWR2ZWSjd0VnJZdWJoMVlJSThr?=
 =?utf-8?B?dTUrNm1iUHJNWnV4eG5XQ2U0aktLVEZQOFBUcGx0cUd6YWswY2FYQytFS2kr?=
 =?utf-8?B?NHM1UjhTdkQ4ZEMrS2tYSmVhMkFmOXhxR2FQU1NHTVVhK0xQKzBRVjRKSVJi?=
 =?utf-8?B?eHRtSG4rZjk1L09TZUlCOUxyRHJnYWsrRVRBVEdrTnd4dTJueG56NHU0cEhQ?=
 =?utf-8?B?NXlBOVQ0MGllY21Ca2p4QXFSaHVvc0Y5RTZHczJ0Q0JwSXdkQmRZeUV0RVpV?=
 =?utf-8?B?eUw1dmU1amUyalEyR3BTZnVGdmxnRld0M2FpL1Z3dHlXRHVyYTU1WGc4bm02?=
 =?utf-8?B?R0d6MjVCeDhuMThGemw0MXdpY2Z0N3ErNzlrMnA0Mi9sbVNLQm9qMndiNkxB?=
 =?utf-8?B?anVyVXNWcnVQZDgyY05hMHB3cGwxSkU0T29aSGwxL2h3N0lRVDV6ZlcyN3lV?=
 =?utf-8?Q?IODLG+WxMRFSeMsojdcTGd8UEOKBpGQNlMHNO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ab03c6-c35c-4f78-d4ee-08dee29fc516
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 18:34:57.1037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MAKZQI6FcaDmyOUlSplkmb+6f7ip1cxr5kU0VpUoneuHzkAIHIJNP9UlM0fHmdlo84IMdFQ6P7e2qMi8H2NaOa0GecZ52b0Y2DsNLn65iVwBFb/X7XfDBCproCfS7FC6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8359
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
Changes in v2 (fix sashiko reported problem):
- add power domain required for binding
- fix 136 height
- add acm patch to cleam MCL clock output pin
- remove iomux hog in overlay file
- Link to v1: https://patch.msgid.link/20260714-dxl_lcdif-v1-0-6761a8a6592b@nxp.com

---
Frank Li (7):
      dt-bindings: lcdif: add compatible string for i.MX8QXP and i.MX8DXL
      dt-bindings: display: simple: Add waiken,101wx001
      drm/panel: simple: Add waiken WKS101WX001-WCT support
      arm64: dts: imx8-ss-dma: Add lcdif support for i.MX8QXP and i.MX8DXL
      arm64: dts: imx8dxl-evk: Add onboard GPIO mux controller
      arm64: dts: imx8dxl-evk: Move ACM MCLK pin to ACM pinctrl
      arm64: dts: imx8dxl-evk: add lcdif overlay

 .../devicetree/bindings/display/fsl,lcdif.yaml     |   4 +
 .../bindings/display/panel/panel-simple.yaml       |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/arm64/boot/dts/freescale/Makefile             |   3 +
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi     |  29 +++++
 .../boot/dts/freescale/imx8dxl-evk-lcdif.dtso      | 118 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts      |  88 ++++++++++++---
 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi |  11 ++
 drivers/gpu/drm/panel/panel-simple.c               |  31 ++++++
 9 files changed, 276 insertions(+), 12 deletions(-)
---
base-commit: 31bd73273b9bf03a3fe32227b417f00d4a94c6ac
change-id: 20260709-dxl_lcdif-d6cbdbac92fb

Best regards,
--  
Frank Li <Frank.Li@nxp.com>

