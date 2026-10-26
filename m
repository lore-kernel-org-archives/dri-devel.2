Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29697606A322
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=hxicDsrx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81AD510ED8A;
	Mon, 26 Oct 2026 10:04:53 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011071.outbound.protection.outlook.com [52.101.70.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C608A10ED86
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:04:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBZis1rmhFlUvAf9dTRh73Wva/eOTEbuoGVeb1LLXgZLFdIUZY2SqYA3DGFOEJpfw4U8MA6aUnX55yzpy2ymX1wvqEqn6x/S88ed7pBy3rQDDQIdMk57aQHhSVyDh96xlA2jMWUetjKOZlbpzbO74ASje+2wFS2SFStHa2U0oaVwEqizm8eav8DZXk1RQEYlHL9w3K4RBLCConw3zh6KqpiBSqLWJvTAEMAaWYyITfJ+vdK+7++P+9+vF3/7T32JwVkfMATFYs5/rsO+UckYYzvb3geTpaEEP3NuHw1p+X0i1b7IHaRpg0pChTQUfscdn1fvuw97n/5NsniWHbGjzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t76sSFOCvYx8Eec8sJLj+OgkuaWS6vqcBh3ZTbnX4sw=;
 b=jqXWvpfIPCRcrI2kyPZgH38bPvDwhCE5FfzG8neI4awaJAO0DNNq6App6BDbBwj5kcsSpIW48rUpr8aOLOlTv439amXm9gzOMTKc9NfPXPNkcDsRJ4po2gK8TkyT65Wfg8vNhcZ9P/JBdi9JEF+JZSCFTQ4BJQwCMjMReu0UXQZqmFkDFcvGBr48iIkSoel8dYDR5lGp7ruMx4g/7TqHV40ga3zZLUT+02reclo0Z1B5cnIie6nvh+zt/UPYqbXAp/DlMcL3awkolWB3MfavEwxRLvt2UqjzFIBb4aTxOjIHJvQDw4jA5lFIPFN2Tp1A7jr2TBQ/5vRdyHMA8aAKiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t76sSFOCvYx8Eec8sJLj+OgkuaWS6vqcBh3ZTbnX4sw=;
 b=hxicDsrx2+a0cqPQ5fvdvRyxve+ltkhJiEoCUooFS/Egu9D/UAKNDVWGSHXj7rrJP8mrbw4/c7Z7rYn472ZzXDdQ1AxO6i+bl39ev9P/tkcJgFAvMPj2itylXiBWAIjdgW1gmlJ7xDgHRWODntvu0n4fyRpuHUu1eMNma0jk5lX7iLUFxnedvm5N+SNJ5KCSXJ3+nd6HG4r0Nlq+5UR9BlJLz51tM8zwsdKRYGXiLUDE5vXxBz6jFOaz5N8fdKpkPYkcILDEfFGH6+Ee0V2MXQLLP/lUbPQkNE6ITEnJHhLoFy9Qj7VRQlEQo5V0ThukyZBDsrIp3cKP/Ree27TuXw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by GVXPR04MB11500.eurprd04.prod.outlook.com (2603:10a6:150:288::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 10:04:23 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 10:04:16 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Mon, 26 Oct 2026 18:05:12 +0800
Subject: [PATCH v7 07/15] drm/imx: dc: Add PRG support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-imx8-dc-prefetch-v7-7-a0b50cc4fc65@nxp.com>
References: <20261026-imx8-dc-prefetch-v7-0-a0b50cc4fc65@nxp.com>
In-Reply-To: <20261026-imx8-dc-prefetch-v7-0-a0b50cc4fc65@nxp.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@mailbox.org>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|GVXPR04MB11500:EE_
X-MS-Office365-Filtering-Correlation-Id: 8da4a8bd-d77b-4c3b-6f4a-08df33487e74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|19092799006|366016|23010399003|1800799024|921020|11063799006|56012099006|261021121427099003|261022105027099003|261022075727099003|261021123027099003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BXcP3KETJV9UgbsRODB9jDvXHaKfaj+mCnTl1EPfZpG9e45Qo8TBDMo+MHvXyosEs/1T2zM9uQGTcgpiQPF5ZfwIm8LjdNJGnPf3s9ch2PxDjvYIicXAv03LB025xOKsqn5quYsjbgjrogefdK4FhRL/tPCWfZdUsazcIuldV9RZjUOW2LHHNHyXxpnhXadsxnSUNwDyamfD18Bi7udWHIjdw109PX0AjwcccysFu58zIgW2AB88KJAuDkDwJEhcIV7HEH7qR/CErO+hhBhSaxvy4a83p4bN2r2mpkadTD8Yl51m9c55RJEGJUcY5Flhh/waBeneCtwK1H+cWZ9BKxURgSIC+Kdv7zxFzMqeR2Fn3TiQ5PxTiQmoHHv2Ot/q/22L8HRfoRRSmM25lI1Spwlqnp5grNWKCLFYV+Cj7+yM/Xa0V4MkZOaSuLhZlg/4H0NuDss57bmd0NtiCki/29dWVGd/1MsX9VxoqHdUPv8PF+RsEIx2W8gn5qzPwGXbjQlB9MdtSZRLL8xFXhgrPup3GGHMMDtYDBW3E7yrx4/U28QHnybnKxGpYqfhJJ0zUxFTS9VEmfm8+RZegFkpSyNDOuLUNPoCg58SX1sGo7XV9xN1PfF/LnUumup1lgbBVQdUCpnIMhmKeIxEWxnHChE6NH84p2EZzXupj+KTC0yCBtGG9s75fG2g/qd9W51l/r+GR/AyOFSbgIYF+jcW1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(19092799006)(366016)(23010399003)(1800799024)(921020)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261022075727099003)(261021123027099003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXVHaDVRMkd2SWZyK20zejJNK29NNUZCUEJKQVo5R2NPTEkrZ3ZWYU01TEx0?=
 =?utf-8?B?Tm1OVnhDa2NQNFRWQjF4QzVYWVVrakRNTDJOUGxPdjllNXp2QnAwd1NBbnpq?=
 =?utf-8?B?QmV5cjRYWm9NUUJkaFg0Z1ROZUh0V01vWGU3VWVoQ3U2L204ellUdjUyRGcx?=
 =?utf-8?B?Z0d5SVNLVXJSNURIL2RBVFNsWkdXUXR4M1pkVUlxNThoNWRPYTR0bHlHMDJ0?=
 =?utf-8?B?VG1OTzNoY3VmQnY1UXlCbGtMMEJUNjRmeTZmQ1h4LzViUHVFVU1XZ0VPbXVr?=
 =?utf-8?B?R0JDYWpxRGxLYVY5N01UR2JoOHUrK3lpY2dCaHlGTHNTNGdkdHZoWm5EdHZN?=
 =?utf-8?B?eVIrSjhIdUkyN1RCc09XUzZtdFY2djVRNzV2eWMxUXB0em9LUzkrYmJiS2tz?=
 =?utf-8?B?K1pnd3dNbWlKeHpKWWxCOWFsVTV5UDF0RDJpZE4zditxUGVqeWw4TmFOUndy?=
 =?utf-8?B?bjF1V3huakhWUEFCRElma0JYZ1lrSll4S2dveHZ1dmMzYStqL01oVjRiZGdo?=
 =?utf-8?B?OXdOWmNMdFRtS2tvMmNhTjFCWHJBeWFIeFNFTGFWck10T1lXWTRCWGZ6NWJE?=
 =?utf-8?B?anowN0FUSSsveE9uaE9xbkptZlVsbkIvWnBJZGlJMnFuRWRrbm1PQjQ1VllF?=
 =?utf-8?B?UjIzTWowZmthVndkN0JvRHQ0aEZKdUJTbkRNdU1TMExkUjM1MlBlTWF6eVFn?=
 =?utf-8?B?dlNMUWNGdlQzZ2pVSlltQ0xGc0NvOTZTbjRVWXZDeHFFYW5UQS9QaEVOVnZI?=
 =?utf-8?B?R1JjaVJiUUNMOTFvQkJFb1R4eGVYdE9nMjB1VXVkcWM4NFVzemJDdkc5VXRl?=
 =?utf-8?B?NDdXTWFKZTgzMXpaTnlyZ1loU1VDQVQwdklpcm50dXRSUlBQemQxcWFMaG9a?=
 =?utf-8?B?cE1PTUZYWWNSUlpES1R4VXcvbk1FN3ZyUGNrS3pqaWE4MWpKYVFKRjF0Qmk1?=
 =?utf-8?B?NmxMQjMrMk1iNXRvc0JoWU5NbTJIcTFqSGkxQ2pySUpkWVVjUVlsL0hMQkN1?=
 =?utf-8?B?WUo2dUNLbVY4RjBtTXRHNlhGSEE0TTF2bllEdnBwMEpyRWZBWXB0V1BSKzd6?=
 =?utf-8?B?ejVLU2IrdElHWUVIbnVTa0x1M2hsUTVsblVpZEM4MEs0MnhaZ01MKzJJMjE5?=
 =?utf-8?B?eDN6L1F3Um0xUXRYdXdYZnVQaC9GQko2eXR3ZzErYkJhdC9FTnRvVzhtcytE?=
 =?utf-8?B?bkJTSkxNMlhBZXZkTXpWbmJDTHNhQS9OTGVaejNFcTdyenkrby9zcjRvTmto?=
 =?utf-8?B?Ly9jNmJBRUhvS1RIMjIzRTVhSVZjSUIvQWtxMXpwWk9EWUR2ZFlVQTZKQUcw?=
 =?utf-8?B?VW1iRjFmMm04cEFHRHFJUkVMUlBKZXBFYm1HL2FIcnMxTlEzODRKcTFwVW1M?=
 =?utf-8?B?RGoxNGhJSlpLTno1OVBIbk1oanluMkpUSnBqVzFjaThTUStTVG1FMzJvWWtT?=
 =?utf-8?B?NWVBKzhKSk13bjVsTHg3eHJpOUs1TFFHRFk1QzZGL3ltRmhuZVE3Wk10Y0tp?=
 =?utf-8?B?UWlOMStMbU4yVThIVzhGelA1Z2RDdllueS84WW1MMUQxZDFLZWpHWGcrMUEy?=
 =?utf-8?B?aWVhbHplUUlNdUFqbDJaYVpsa2VianUrSjZyQ3BHWDZwNjBIYjk3ZlprYXZa?=
 =?utf-8?B?aFpTKzlFVTBxVGxuL1pxQVZQZ21qRDZnSUw2Y1VvZWxNejkvK1NsYm1jWFVL?=
 =?utf-8?B?cEJDWkprOWI5am9NRDc1NnQyM1BXUk16blpRVjJjVW5PTHFRcjV3U1N5R0Vh?=
 =?utf-8?B?N3FmTmdldWpGdGlaN1FVS2NLZFBmaWwxWTVhZWpENWkyalNJMG9ZcUZ0Zks1?=
 =?utf-8?B?RmR0OEZ0MjZwSTZQR3JKdnJGMFB0VHJYckp5T3Zad0ZUTHI2MnRsSTBGbnlv?=
 =?utf-8?B?UlRReVl3emR6UGc5VHo0UmlZRFhtNWRkcCtycnJPOFgwNGVCTUlUK2tNYm9l?=
 =?utf-8?B?MnVLbXhTNVBKaFpEV0VBbVBzaDhsTnd4aGlGTWcxT1ZQVk1UQWx0QWFxbDhV?=
 =?utf-8?B?YXFpMnkzOXZ3ZlJSdVRlNjdLMmNnK01xSXRaa2dZcGt5RGZ5MWhkMFZXcDVW?=
 =?utf-8?B?bWN6YkxFUlJTYXNIendoK0pRMVdkVjM4UWxDaW5yRjYvRk5rNHdTdnhXZFlJ?=
 =?utf-8?B?TmtGOVVqbXI4WHcwS0xzN0pxdmMwRkczdm1nUGxxMmI3b3ZRTHBONWY0a1px?=
 =?utf-8?B?S2dZTXR2TUE5S01jSHY5TmpoWXlLUFFqclNNTDkxdnZMcVVlVFJhV2E0ODlB?=
 =?utf-8?B?Y3VLb2VPcEw2b3VsZUlpUnZFLzFtRnI3WGE2d3ZSQUZjS2tkWXVXRzhqMzZk?=
 =?utf-8?B?b0JBK0ZmNm1wajZDSytoM1orRUo3eGo1RDNSRElwcjh2SWsvRFhWQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da4a8bd-d77b-4c3b-6f4a-08df33487e74
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 10:04:16.3275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/lYyqm/qzwYGnG1I0uIraE92ZYz3Zl0yOxrzzxrYgnhd0hgx82ujtFhGFd/OdE4WxT2N7WNbTzOfJxd7yOWTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11500
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Display Prefetch Resolve Gasket(PRG) is a part of a FetchUnit's
prefetch engine.  It sits between a Display Prefetch Resolve
Channel(DPRC) and a FetchUnit.  Add a platform driver to support
the PRG.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v7:
- Collect Maxime's A-b tag.
- Return 128B burst size from dc_prg_burst_size_fixup() when baddr == 0.
  This avoids undefined behavior of __ffs(0).  (Sashiko AI bot)
- Initialize and declare prg_node at the same time.  (Sashiko AI bot)
- Add device link between PRG's consumer and PRG.  (Sashiko AI bot)

v6:
- Include "dc-drv.h" to avoid build warning with C=1.
- Fix PRG BYPASS programming.

v4:
- Sort bits and bitfields in descending order for register PRG_CTRL.

v2:
- Manage clocks with bulk interfaces.  (Frank)
- Collect Frank's R-b tag.
---
 drivers/gpu/drm/imx/dc/Makefile |   2 +-
 drivers/gpu/drm/imx/dc/dc-drv.c |   1 +
 drivers/gpu/drm/imx/dc/dc-drv.h |   1 +
 drivers/gpu/drm/imx/dc/dc-prg.c | 314 ++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/imx/dc/dc-prg.h |  35 +++++
 5 files changed, 352 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/dc/Makefile b/drivers/gpu/drm/imx/dc/Makefile
index b9d33c074984..e3a06ee3ce1a 100644
--- a/drivers/gpu/drm/imx/dc/Makefile
+++ b/drivers/gpu/drm/imx/dc/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 imx8-dc-drm-objs := dc-cf.o dc-crtc.o dc-de.o dc-drv.o dc-ed.o dc-fg.o dc-fl.o \
-		    dc-fu.o dc-fw.o dc-ic.o dc-kms.o dc-lb.o dc-pe.o \
+		    dc-fu.o dc-fw.o dc-ic.o dc-kms.o dc-lb.o dc-pe.o dc-prg.o  \
 		    dc-plane.o dc-tc.o
 
 obj-$(CONFIG_DRM_IMX8_DC) += imx8-dc-drm.o
diff --git a/drivers/gpu/drm/imx/dc/dc-drv.c b/drivers/gpu/drm/imx/dc/dc-drv.c
index 09387d62cc0b..1d01f896e427 100644
--- a/drivers/gpu/drm/imx/dc/dc-drv.c
+++ b/drivers/gpu/drm/imx/dc/dc-drv.c
@@ -351,6 +351,7 @@ static struct platform_driver * const dc_drivers[] = {
 	&dc_ic_driver,
 	&dc_lb_driver,
 	&dc_pe_driver,
+	&dc_prg_driver,
 	&dc_tc_driver,
 	&dc_driver,
 };
diff --git a/drivers/gpu/drm/imx/dc/dc-drv.h b/drivers/gpu/drm/imx/dc/dc-drv.h
index 1ec9304329eb..27ef2c552549 100644
--- a/drivers/gpu/drm/imx/dc/dc-drv.h
+++ b/drivers/gpu/drm/imx/dc/dc-drv.h
@@ -81,6 +81,7 @@ extern struct platform_driver dc_fw_driver;
 extern struct platform_driver dc_ic_driver;
 extern struct platform_driver dc_lb_driver;
 extern struct platform_driver dc_pe_driver;
+extern struct platform_driver dc_prg_driver;
 extern struct platform_driver dc_tc_driver;
 
 static inline int dc_subdev_get_id(const struct dc_subdev_info *info,
diff --git a/drivers/gpu/drm/imx/dc/dc-prg.c b/drivers/gpu/drm/imx/dc/dc-prg.c
new file mode 100644
index 000000000000..43df5683b24d
--- /dev/null
+++ b/drivers/gpu/drm/imx/dc/dc-prg.c
@@ -0,0 +1,314 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#include "dc-drv.h"
+#include "dc-prg.h"
+
+#define SET			0x4
+#define CLR			0x8
+#define TOG			0xc
+
+#define PRG_CTRL		0x00
+#define  SHADOW_EN		BIT(31)
+#define  SOFTRST		BIT(30)
+#define  DES_DATA_TYPE_MASK	GENMASK(17, 16)
+#define  DES_DATA_TYPE_32BPP	FIELD_PREP(DES_DATA_TYPE_MASK, 0)
+#define  DES_DATA_TYPE_24BPP	FIELD_PREP(DES_DATA_TYPE_MASK, 1)
+#define  DES_DATA_TYPE_16BPP	FIELD_PREP(DES_DATA_TYPE_MASK, 2)
+#define  DES_DATA_TYPE_8BPP	FIELD_PREP(DES_DATA_TYPE_MASK, 3)
+#define  SHADOW_LOAD_MODE	BIT(5)
+#define  HANDSHAKE_MODE_4LINES	0
+#define  SC_DATA_TYPE_8BIT	0
+#define  BYPASS			BIT(0)
+
+#define PRG_STATUS		0x10
+
+#define PRG_REG_UPDATE		0x20
+#define  REG_UPDATE		BIT(0)
+
+#define PRG_STRIDE		0x30
+#define  STRIDE(n)		FIELD_PREP(GENMASK(15, 0), (n) - 1)
+
+#define PRG_HEIGHT		0x40
+#define  HEIGHT(n)		FIELD_PREP(GENMASK(15, 0), (n) - 1)
+
+#define PRG_BADDR		0x50
+#define PRG_OFFSET		0x60
+
+#define PRG_WIDTH		0x70
+#define  WIDTH(n)		FIELD_PREP(GENMASK(15, 0), (n) - 1)
+
+#define DPU_PRG_MAX_STRIDE	0x10000
+
+struct dc_prg {
+	struct device *dev;
+	struct regmap *reg;
+	struct list_head list;
+	struct clk_bulk_data *clks;
+	int num_clks;
+};
+
+static DEFINE_MUTEX(dc_prg_list_mutex);
+static LIST_HEAD(dc_prg_list);
+
+static const struct regmap_config dc_prg_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.fast_io = true,
+	.max_register = PRG_WIDTH + TOG,
+};
+
+static void dc_prg_reset(struct dc_prg *prg)
+{
+	regmap_write(prg->reg, PRG_CTRL + SET, SOFTRST);
+	fsleep(10);
+	regmap_write(prg->reg, PRG_CTRL + CLR, SOFTRST);
+	fsleep(10);
+}
+
+void dc_prg_enable(struct dc_prg *prg)
+{
+	regmap_write(prg->reg, PRG_CTRL + CLR, BYPASS);
+}
+
+void dc_prg_disable(struct dc_prg *prg)
+{
+	regmap_write(prg->reg, PRG_CTRL, BYPASS);
+
+	pm_runtime_put(prg->dev);
+}
+
+void dc_prg_disable_at_boot(struct dc_prg *prg)
+{
+	regmap_write(prg->reg, PRG_CTRL, BYPASS);
+
+	clk_bulk_disable_unprepare(prg->num_clks, prg->clks);
+}
+
+static unsigned int dc_prg_burst_size_fixup(dma_addr_t baddr)
+{
+	unsigned int burst_size;
+
+	if (baddr == 0)
+		return 128U;
+
+	burst_size = 1 << __ffs(baddr);
+	burst_size = round_up(burst_size, 8);
+	burst_size = min(burst_size, 128U);
+
+	return burst_size;
+}
+
+static unsigned int
+dc_prg_stride_fixup(unsigned int stride, unsigned int burst_size)
+{
+	return round_up(stride, burst_size);
+}
+
+void dc_prg_configure(struct dc_prg *prg,
+		      unsigned int width, unsigned int height,
+		      unsigned int stride, unsigned int bits_per_pixel,
+		      dma_addr_t baddr, bool start)
+{
+	struct device *dev = prg->dev;
+	unsigned int burst_size;
+	u32 val;
+	int ret;
+
+	if (start) {
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret < 0) {
+			dev_err(dev, "failed to get RPM: %d\n", ret);
+			return;
+		}
+	}
+
+	burst_size = dc_prg_burst_size_fixup(baddr);
+
+	stride = dc_prg_stride_fixup(stride, burst_size);
+
+	regmap_write(prg->reg, PRG_STRIDE, STRIDE(stride));
+	regmap_write(prg->reg, PRG_WIDTH, WIDTH(width));
+	regmap_write(prg->reg, PRG_HEIGHT, HEIGHT(height));
+	regmap_write(prg->reg, PRG_OFFSET, 0);
+	regmap_write(prg->reg, PRG_BADDR, baddr);
+
+	val = SHADOW_LOAD_MODE | SC_DATA_TYPE_8BIT | HANDSHAKE_MODE_4LINES;
+
+	switch (bits_per_pixel) {
+	case 32:
+		val |= DES_DATA_TYPE_32BPP;
+		break;
+	case 24:
+		val |= DES_DATA_TYPE_24BPP;
+		break;
+	case 16:
+		val |= DES_DATA_TYPE_16BPP;
+		break;
+	case 8:
+		val |= DES_DATA_TYPE_8BPP;
+		break;
+	}
+
+	/* no shadow for the first frame */
+	val |= start ? BYPASS : SHADOW_EN;
+
+	regmap_write(prg->reg, PRG_CTRL, val);
+}
+
+void dc_prg_reg_update(struct dc_prg *prg)
+{
+	regmap_write(prg->reg, PRG_REG_UPDATE, REG_UPDATE);
+}
+
+void dc_prg_shadow_enable(struct dc_prg *prg)
+{
+	regmap_write(prg->reg, PRG_CTRL + SET, SHADOW_EN);
+}
+
+bool dc_prg_stride_supported(struct dc_prg *prg,
+			     unsigned int stride, dma_addr_t baddr)
+{
+	unsigned int burst_size;
+
+	burst_size = dc_prg_burst_size_fixup(baddr);
+
+	stride = dc_prg_stride_fixup(stride, burst_size);
+
+	if (stride > DPU_PRG_MAX_STRIDE)
+		return false;
+
+	return true;
+}
+
+struct dc_prg *
+dc_prg_lookup_by_phandle(struct device *dev, const char *name, int index)
+{
+	struct device_node *prg_node __free(device_node) =
+				of_parse_phandle(dev->of_node, name, index);
+	struct dc_prg *prg;
+
+	if (!prg_node)
+		return NULL;
+
+	guard(mutex)(&dc_prg_list_mutex);
+	list_for_each_entry(prg, &dc_prg_list, list) {
+		if (prg_node == prg->dev->of_node) {
+			device_link_add(dev, prg->dev,
+					DL_FLAG_AUTOREMOVE_CONSUMER);
+			return prg;
+		}
+	}
+
+	return NULL;
+}
+
+static int dc_prg_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	void __iomem *base;
+	struct dc_prg *prg;
+	int ret;
+
+	prg = devm_kzalloc(dev, sizeof(*prg), GFP_KERNEL);
+	if (!prg)
+		return -ENOMEM;
+
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	prg->reg = devm_regmap_init_mmio(dev, base, &dc_prg_regmap_config);
+	if (IS_ERR(prg->reg))
+		return PTR_ERR(prg->reg);
+
+	prg->num_clks = devm_clk_bulk_get_all(dev, &prg->clks);
+	if (prg->num_clks < 0)
+		return dev_err_probe(dev, prg->num_clks, "failed to get clocks\n");
+
+	dev_set_drvdata(dev, prg);
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable PM runtime\n");
+
+	prg->dev = dev;
+
+	guard(mutex)(&dc_prg_list_mutex);
+	list_add(&prg->list, &dc_prg_list);
+
+	return 0;
+}
+
+static void dc_prg_remove(struct platform_device *pdev)
+{
+	struct dc_prg *prg = dev_get_drvdata(&pdev->dev);
+
+	guard(mutex)(&dc_prg_list_mutex);
+	list_del(&prg->list);
+}
+
+static int dc_prg_runtime_suspend(struct device *dev)
+{
+	struct dc_prg *prg = dev_get_drvdata(dev);
+
+	clk_bulk_disable_unprepare(prg->num_clks, prg->clks);
+
+	return 0;
+}
+
+static int dc_prg_runtime_resume(struct device *dev)
+{
+	struct dc_prg *prg = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_bulk_prepare_enable(prg->num_clks, prg->clks);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks: %d\n", ret);
+		return ret;
+	}
+
+	dc_prg_reset(prg);
+
+	return 0;
+}
+
+static const struct dev_pm_ops dc_prg_pm_ops = {
+	RUNTIME_PM_OPS(dc_prg_runtime_suspend, dc_prg_runtime_resume, NULL)
+};
+
+static const struct of_device_id dc_prg_dt_ids[] = {
+	{ .compatible = "fsl,imx8qxp-prg", },
+	{ /* sentinel */ }
+};
+
+struct platform_driver dc_prg_driver = {
+	.probe = dc_prg_probe,
+	.remove = dc_prg_remove,
+	.driver = {
+		.name = "imx8-dc-prg",
+		.suppress_bind_attrs = true,
+		.of_match_table = dc_prg_dt_ids,
+		.pm = pm_ptr(&dc_prg_pm_ops),
+	},
+};
diff --git a/drivers/gpu/drm/imx/dc/dc-prg.h b/drivers/gpu/drm/imx/dc/dc-prg.h
new file mode 100644
index 000000000000..6fd9b050bfa1
--- /dev/null
+++ b/drivers/gpu/drm/imx/dc/dc-prg.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef __DC_PRG_H__
+#define __DC_PRG_H__
+
+#include <linux/device.h>
+#include <linux/types.h>
+
+struct dc_prg;
+
+void dc_prg_enable(struct dc_prg *prg);
+
+void dc_prg_disable(struct dc_prg *prg);
+
+void dc_prg_disable_at_boot(struct dc_prg *prg);
+
+void dc_prg_configure(struct dc_prg *prg,
+		      unsigned int width, unsigned int height,
+		      unsigned int stride, unsigned int bits_per_pixel,
+		      dma_addr_t baddr, bool start);
+
+void dc_prg_reg_update(struct dc_prg *prg);
+
+void dc_prg_shadow_enable(struct dc_prg *prg);
+
+bool dc_prg_stride_supported(struct dc_prg *prg,
+			     unsigned int stride, dma_addr_t baddr);
+
+struct dc_prg *
+dc_prg_lookup_by_phandle(struct device *dev, const char *name, int index);
+
+#endif

-- 
2.43.0

