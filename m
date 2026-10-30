Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1997B60A2604
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=JbhXk8Ge
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DD4A1126D9;
	Fri, 30 Oct 2026 09:53:42 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013026.outbound.protection.outlook.com [52.101.72.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 054CF10E8A9
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 09:53:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHkd3GUIqWaKNcsyEIyp38QGy5FcaP6DCSyivaCJa49E2bGa28sremh4dBIAyVqhM03S+VjRo9RtiDeaTI8x7wN+7nhdPKExKcUvG73vlX+YFltVN2GeW5bAzjtdHMv9A8qSUVvJsrtBe4d7aYSBOjc8s5YmkouCrNPuGAGq3zoDg+CfSYjm2FkSnb4D5icMrEnJEpCfM2mc3p8HcpuOXG2b+P0IF4Ia7AZDiodklCQHonobn+bIMv+/H2x9PUwfOSO6XEaRl7Qt0dLQcGSMHC9W9eIoOGwrURw7UVsMdDsJU0tqhGkFKarHpIA4Vx5AkkWhs/IEqMvfa6U/PGt1nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QK00wpL+s/9on0teOdV/Ilw79Pv648qkw3TA9zscgCY=;
 b=rG/A7RUrIFsL1Z2VY77a1aBes99N98INhzllV5tt7KaHA3Pedz6dwvz4JK3jE+xMurIl8yTAYrkLlvLr0epnjOjwJPrVPeb36X7UmxSP6HMmSnj7Rx3JvLZWcDpfrp0oFJRvDxb6KDDOWwVnk2BDnr1KTr775icv8SSl4RgxI/Fy61jFJuTS8tniPHjZZX3WSXSgvmq9rIpn5lxug2eXZAY5C44v7JgwCOzNe3wQsXdPoKMh4nV0fZEY4I5dUFqUu9Ozgk3jPv+vPSVAyShx7sBKD4FXAEWOYxTQSwJ/FHV7u7QArN11I8hQ6syd4tQL9E13fI3O9z0dwm+2cwdI1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QK00wpL+s/9on0teOdV/Ilw79Pv648qkw3TA9zscgCY=;
 b=JbhXk8Ge8zJNwMSO4ArfL2XRqjt8AD8x8+pQGuVFPPQywbAGWYrlSTwx1yLcLLbyHlxQa16M1bH4jx8FOfATT5fHKbqKvUMTsmAHh/6vVDUsRDVRUdoWfUH70C0svCMv6o2LqVLZfrV+QIogpXx9YKOJchLdkI7NZ5MPHk3jeru74kpQoTsg5KIVobR21yNub6bJt8BaJq/McC1zCQbYKfwGlC+J7pRGQGLCDxqKed5Z1jqqVskd1FYeCkxFU3/gU6g6i1cBBa/zSY5Eq1sJvRtvQHfy6c7P/Fh8vwoqNeXPrEtt9VD9NoLaQqAgEJZT5gIVLq9Ryxx6nYYQzQTnUQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by MA9PR04MB839208.eurprd04.prod.outlook.com (2603:10a6:250:103::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 09:53:32 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 09:53:32 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Fri, 30 Oct 2026 17:54:30 +0800
Subject: [PATCH v8 06/15] drm/imx: dc-crtc: Disable at boot
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-imx8-dc-prefetch-v8-6-c4f81afd4533@nxp.com>
References: <20261030-imx8-dc-prefetch-v8-0-c4f81afd4533@nxp.com>
In-Reply-To: <20261030-imx8-dc-prefetch-v8-0-c4f81afd4533@nxp.com>
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
X-ClientProxiedBy: SI1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::10) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|MA9PR04MB839208:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c28283-1fe5-4a82-9357-08df366ba823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|7416014|366016|1800799024|10067099003|18002099003|22082099003|921020|56012099006|11063799006|261028144727099003|261026140227099003|261026121527099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261009221727099003|261009220027099003|261009221227099003|261009223327099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: TIh3HXRazHMj7Tu4ybPP9Iis1Wkfy7HIixLsEczB+fZJ2/qO93qENs554LF+446SrEnNQQtqEiceKNUV2+W5AtluPV1Z7Z4Vk8VhZar+N5zRIkQNnLVYLkAM0iScd8NxfyrjF1C5i3vE6XDNg/HGkN9DRYTCgpKkC7f/mGx/L3S2yyf/HhBf8bOrQ5pyqnmx2ls8nDEiPnM39bpO/lioaQ3kFxCm5l+IcW35b5utTH49OcLy/GYn0QdemA4Och3Q3G0Gt/uysm7cG1kU8RxL91zoW6CR0g73y3Cn1LYYAOqPuyWS1Qp6Di02zcGd9d4+Xg0ZQ8nIAUusXXGy6UKJRMRtxnW6cGy0lPKXJpLWPFtahAU3oz98hOnQSaBxFeAeTeUukCawzK3c+Tn7sXhQnbtp6X0MbA5PezlX3Y6ssd171qCz8bQa7gnvHnThYlUFo1qLvPzOV5L89lRd5DOhUaRN6FG/0KfeyvmhWU3303wl4oOYvNQqwwW3Zvvn8dxy01JFHqFNeGrT1jCfKl69xuL9cWH24dz9TxZPUA7DIpXlyLrgqjj8UMhT7YUFc9qZNWl7ZE0QjaB+rUmvni1F1VQx/e0fNa1DUZyNldjtuf05ltLdhiiV/RahyRxq1RTPCcRKcapQFQJt9RgraloF/uaoFAMHNBeGINZArFK9nBOXajMyPHBSzv8wW8JgNA23Qqn2+z0rGHl1wHHjwHKprg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(921020)(56012099006)(11063799006)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261009221727099003)(261009220027099003)(261009221227099003)(261009223327099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmJkSktnaXErbjVhc1JQRnU2T2NvUStFUWtsd3JPejAvRE9zeVkxNnRwUUF1?=
 =?utf-8?B?WWVPdFVHSE91UE91dSsyNVU4dlVObGNTaTVZOVpnUEhPWTkyemx6ejNCdkJS?=
 =?utf-8?B?UmZGNmZ0Z3RVbjJrMnFoUkVWdmI4SWd0NUc5bDRxcjNKSHlWanZ6ZEhtcTc5?=
 =?utf-8?B?cnB6WktvbFFRajBHMXJuUzRYQkhOSllzdUtQNkY5d0h0ZWpraUlFaGRZbzdv?=
 =?utf-8?B?bHR4YVJEZ1JWUVVXWkdLT0FVNitacDBaSW5lK3ZMcUxYMmh4L3VZQ2svTit5?=
 =?utf-8?B?SVFabWR0WUh2K1VTQjVkZDBmbFJueTJzL3dSRktqU2pNN3hja3JtRWdvVjQx?=
 =?utf-8?B?SkxoSi9zRW9RNFdta2hVUTBRcVY1Wkw4MFp2d3Qrdkgrbi8ybjMrckIwclVx?=
 =?utf-8?B?amVGNCtsVDIwZUErcjdnQTlocjZ2UFV0dXQ0cWRnNkZWa2UyV0xVMkhqRFVn?=
 =?utf-8?B?L25YakJIWUxhN2FvVjZQb2JWRm01Qk9NVW80blhHWWlMaUZlVnRSVGZFTldH?=
 =?utf-8?B?SGE3dFptZUpXZkE1cHAxbitMcEN4NFZWeGNNVTMrYXRpdzh6S1FwZm0vcDFU?=
 =?utf-8?B?RGhWYkNUYUhKaTRRSitXQTl1cmx6RUg4L0dnU3lPMkVKRGVsYTN2S1NaOWJH?=
 =?utf-8?B?azYxbGNWOHMrWXF4R3crVEFaS1h4SUVFRGU3N3BGUExkSjY4NFNDU2hZekJB?=
 =?utf-8?B?U28vLy9CZlZTeVprTjhSS0IzemQ4Y21HWXo1REtzTjd5ZkRqaW1vb3FWaU5m?=
 =?utf-8?B?dHMvN1Jkb1V0dUZudk40L1RDNFJnb3BoeGdLWG1rY3h1VmFQbEJVOHR6bVla?=
 =?utf-8?B?b3pMVmo4Y3Zncnlua0xGMStVYkdkQlY3NFBuLzdWUHprQTU0MzBqekRkMjZw?=
 =?utf-8?B?MGx0ZHB0cHhZY1lRbHVnZG5LcklQclIwMTRoUVkrVnM4dTZzb3MzOHpxMTZT?=
 =?utf-8?B?dXNxMDRab0lNWFZhb2JJZG9FSUpFUDV4cDNXV1JOc0dhVW5TbkNZWDVnbEpK?=
 =?utf-8?B?S016ZEZKZnhoc3VqZGkvSEV1eEhQU3ZyellIYUhsa2FBaXRHcmowdmtNRnZ1?=
 =?utf-8?B?STFncm5mNEFDaG5CUVlicWVDVXR6WXQ4cUhvMlk5OHIyZXF2Y2NMSzZXbndU?=
 =?utf-8?B?VFpTSEFHdWx4aVVGbEpaZkJyUC9yZ3BVK1BrcjZmdjhkNC9kUDBzRjlJZ1Bz?=
 =?utf-8?B?ekM4SE9hSGhlQTJmK0x3eFBTK1I2cmVRTEVsZnU0ZWQ0ZkpGOWhUeEJRTnBJ?=
 =?utf-8?B?NFN3YkdjdWprS0hsVGJCTGpTNUxpTk5vUVNBSVBZZmE3UHp1aWx3VVpLamxG?=
 =?utf-8?B?NktGUHVLUVU2WDVXZFpUanJKMjY3bkl2UTB3SGxxeUwzRjgzcmRTQXEzWC8v?=
 =?utf-8?B?NFRETHdMam8zMHhaNkZJQlFFdzMxVUlKSmgrYUc0N3kyWW5UcEFwRzlDQjhv?=
 =?utf-8?B?aXd6MUhpUjJxVEhpR3hhYXBMSFVmdkd4ejhrQ3RhVlc2aHAra1YvL2hiRFBm?=
 =?utf-8?B?THBuT0ZadDVVbnhLaGdPYThUMHBVMXo4QTVhYU5aMW1xcC82d3FDcytZSU9t?=
 =?utf-8?B?UkhCU1p3d2tkVUYxQnhzankxMUFkbElGajJXeGdkTnhaL2RrM2JXVmVBZnRO?=
 =?utf-8?B?RFVwOHpWaExlY21HcWEzdDJ4Tzdac00rczg0WTFwU3BRelBqdnFMTXc3SU4z?=
 =?utf-8?B?YTE2ZWxIMU9weVJxUzlCSTJqTVVBdGVGR1g4OGEzcnJpQkl5QWNnZUdUYk9X?=
 =?utf-8?B?SW9ibUlWaGZPdCtFbmhtSHJUb3JIUnBzdzMvejEzU09MOXRYNnlKZ0I2eVBq?=
 =?utf-8?B?dmRVdjRnck5NR0U0ODZhL2dLL1cyajVLTGFMOVVOU3VNNUNjbGs5U3JiME1K?=
 =?utf-8?B?djY4NkpzRHB4dldSR3FkZXl1eXdNb0xRU08zL0cwZTFCNG03TVBXenFvYnUz?=
 =?utf-8?B?RmZZSWpJZGdNNDFEVlc3OUFlblpjNFJsekVjWERFOTVOaGQ4aU0ydkN1REF0?=
 =?utf-8?B?aHRUOGtSaHBrQi9TeGRqenV2SkN4WE1xck1MWHM0bEJOTWUwZjNiOGF5UVRq?=
 =?utf-8?B?ak5NUWg1MldZa1JXSy9OWnJ0SnZQakNGV3pyS2FmUjUvYWlqRDdEL2NZVTZj?=
 =?utf-8?B?cTZaZzRRbVZuMjViQTc3VC9EVDhIMHBYQlBzOWxjMUsyazZrTXdhb0hWNUhp?=
 =?utf-8?B?bXFrVVpNMTBwRW9OOTBqMDhiN3NqeTRwRUloTUpHb0l0a1VzeERPRmsxLzFJ?=
 =?utf-8?B?aG1LTXk5NFVESlorZ2kzV0tlYXdhTUxLZWYrOEVCY2p2eWEvbE5sM1ExRGxu?=
 =?utf-8?B?SXllSFJkNU9SQUtDN2xBdjdWbmt2STVsOTQ5dEs1dzlTMG9YeklXZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c28283-1fe5-4a82-9357-08df366ba823
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:53:32.1432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zMRvtoYJTdPyg6C9+o/ZYQHqoz98fVxY50mvKWuqTpI2bgVeYDaOm5U7fnjn4pBFeuqPJVEmUkkYx2QTJFjuXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR04MB839208
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

CRTC(s) could still be running after the DRM device is unplugged by
calling drm_dev_unplug(), because the CRTC disablement logic is
protected and bypassed by the drm_dev_enter()/drm_dev_exit() pair.
Hence, Pixel Engine's AXI clock use count(managed by Pixel Engine
driver's runtime PM) and pixel clock use count could be inbalanced
after removing and re-installing the driver module.  To fix this,
add a helper dc_crtc_disable_at_boot() and call it to properly
disable all CRTCs before advertising DRM device to user-space by
calling drm_dev_register().

Fixes: 711a3b878366 ("drm/imx: Add i.MX8qxp Display Controller KMS")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v8:
- Call dc_drv_set_crtc_disable() in dc_crtc_disable_at_boot() after CRTC
  is disabled.  (Sashiko AI bot)
- Make dc_crtc_disable_at_boot() return an integer instead of void.
  (Laurentiu)
- Postpone Pixel Engine AXI clock disablement at boot to the time point
  where CRTC1(with index == 1) is being disabled at boot.

v7:
- Check CRTC status to ensure that clocks were enabled by a previous boot
  before disabling them in dc_crtc_disable_at_boot().  (Sashiko AI bot)
- Modify debug message in dc_crtc_disable_at_boot().

v6:
- Rebase onto the latest drm-misc-next and resolve conflicts.

v3:
- Collect Frank's R-b tag.
---
 drivers/gpu/drm/imx/dc/dc-crtc.c | 72 ++++++++++++++++++++++++++++++++++------
 drivers/gpu/drm/imx/dc/dc-drv.c  | 11 ++++++
 drivers/gpu/drm/imx/dc/dc-drv.h  |  3 ++
 3 files changed, 76 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-crtc.c b/drivers/gpu/drm/imx/dc/dc-crtc.c
index 0d64186a9901..5bc952d6883e 100644
--- a/drivers/gpu/drm/imx/dc/dc-crtc.c
+++ b/drivers/gpu/drm/imx/dc/dc-crtc.c
@@ -227,6 +227,7 @@ dc_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 	struct drm_crtc_state *new_crtc_state =
 				drm_atomic_get_new_crtc_state(state, crtc);
 	struct drm_display_mode *adj = &new_crtc_state->adjusted_mode;
+	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
 	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
 	enum dc_link_id cf_link;
 	int idx, ret;
@@ -287,29 +288,37 @@ dc_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 
 	DC_CRTC_CHECK_FRAMEGEN_FIFO(dc_crtc->fg);
 
+	dc_drv_set_crtc_enable(dc_drm, drm_crtc_index(crtc));
+
 	drm_dev_exit(idx);
 
 out:
 	dc_crtc_queue_state_event(new_crtc_state);
 }
 
-static void
-dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
+static inline void __dc_crtc_disable_fg(struct drm_crtc *crtc)
 {
-	struct drm_crtc_state *new_crtc_state =
-				drm_atomic_get_new_crtc_state(state, crtc);
-	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
 	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
-	int idx;
-
-	if (!drm_dev_enter(crtc->dev, &idx))
-		goto out;
 
 	enable_irq(dc_crtc->irq_dec_seqcomplete);
 	dc_fg_disable(dc_crtc->fg);
 	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(dec_seqcomplete_done);
 	disable_irq(dc_crtc->irq_dec_seqcomplete);
+}
 
+static void
+dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
+{
+	struct drm_crtc_state *new_crtc_state =
+				drm_atomic_get_new_crtc_state(state, crtc);
+	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
+	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
+	int idx;
+
+	if (!drm_dev_enter(crtc->dev, &idx))
+		goto out;
+
+	__dc_crtc_disable_fg(crtc);
 	dc_fg_disable_clock(dc_crtc->fg);
 
 	/* request pixel engine power-off as plane is off too */
@@ -318,8 +327,9 @@ dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 	/* request display engine power-off when CRTC is disabled */
 	pm_runtime_put(dc_crtc->de->dev);
 
-	drm_dev_exit(idx);
+	dc_drv_set_crtc_disable(dc_drm, drm_crtc_index(crtc));
 
+	drm_dev_exit(idx);
 out:
 	drm_crtc_vblank_off(crtc);
 
@@ -331,6 +341,48 @@ dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 	spin_unlock_irq(&crtc->dev->event_lock);
 }
 
+int dc_crtc_disable_at_boot(struct drm_crtc *crtc)
+{
+	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
+	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dc_crtc->de->dev);
+	if (ret < 0) {
+		dc_crtc_err(crtc, "failed to get DC display engine RPM: %d\n",
+			    ret);
+		goto out1;
+	}
+
+	if (!dc_fg_wait_for_frame_index_moving(dc_crtc->fg)) {
+		dc_crtc_dbg(crtc, "FrameGen frame index isn't moving\n");
+		goto out2;
+	}
+
+	dc_crtc_dbg(crtc, "disabling FrameGen at boot\n");
+	__dc_crtc_disable_fg(crtc);
+
+	if (!dc_drv_crtc_is_enabled(dc_drm, drm_crtc_index(crtc)))
+		goto out2;
+
+	dc_crtc_dbg(crtc, "disabling clocks at boot\n");
+
+	dc_fg_disable_clock(dc_crtc->fg);
+
+	dc_drm->pe_clk_axi_needs_disable = true;
+
+	dc_drv_set_crtc_disable(dc_drm, drm_crtc_index(crtc));
+
+out2:
+	pm_runtime_put(dc_crtc->de->dev);
+out1:
+	/* Let CRTC(with index == 1) disablement path disable AXI clock. */
+	if (dc_drm->pe_clk_axi_needs_disable && drm_crtc_index(crtc) == 1)
+		clk_disable_unprepare(dc_drm->pe->clk_axi);
+
+	return ret;
+}
+
 static bool dc_crtc_get_scanout_position(struct drm_crtc *crtc,
 					 bool in_vblank_irq,
 					 int *vpos, int *hpos,
diff --git a/drivers/gpu/drm/imx/dc/dc-drv.c b/drivers/gpu/drm/imx/dc/dc-drv.c
index 9629beaed43c..393f7e07df7b 100644
--- a/drivers/gpu/drm/imx/dc/dc-drv.c
+++ b/drivers/gpu/drm/imx/dc/dc-drv.c
@@ -17,6 +17,7 @@
 
 #include <drm/clients/drm_client_setup.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_fbdev_dma.h>
 #include <drm/drm_fourcc.h>
@@ -108,6 +109,7 @@ static int dc_drm_bind(struct device *dev)
 	struct dc_priv *priv = dev_get_drvdata(dev);
 	struct dc_drm_device *dc_drm;
 	struct drm_device *drm;
+	struct drm_crtc *crtc;
 	int ret;
 
 	dc_drm = devm_drm_dev_alloc(dev, &dc_drm_driver, struct dc_drm_device,
@@ -130,6 +132,15 @@ static int dc_drm_bind(struct device *dev)
 	if (ret)
 		return ret;
 
+	drm_for_each_crtc(crtc, drm) {
+		ret = dc_crtc_disable_at_boot(crtc);
+		if (ret) {
+			dev_err(dev, "failed to disable CRTC%u at boot: %d\n",
+				drm_crtc_index(crtc), ret);
+			goto err;
+		}
+	}
+
 	ret = drm_dev_register(drm, 0);
 	if (ret) {
 		dev_err(dev, "failed to register drm device: %d\n", ret);
diff --git a/drivers/gpu/drm/imx/dc/dc-drv.h b/drivers/gpu/drm/imx/dc/dc-drv.h
index 8283795f3c76..1f0af7af5749 100644
--- a/drivers/gpu/drm/imx/dc/dc-drv.h
+++ b/drivers/gpu/drm/imx/dc/dc-drv.h
@@ -50,6 +50,8 @@ struct dc_drm_device {
 	struct dc_pe *pe;
 	/** @tc: tcon list */
 	struct dc_tc *tc[DC_DISPLAYS];
+	/** @pe_clk_axi_needs_disable: disablement flag at boot */
+	bool pe_clk_axi_needs_disable;
 };
 
 struct dc_subdev_info {
@@ -96,6 +98,7 @@ static inline int dc_subdev_get_id(const struct dc_subdev_info *info,
 	return -EINVAL;
 }
 
+int dc_crtc_disable_at_boot(struct drm_crtc *crtc);
 void dc_de_post_bind(struct dc_drm_device *dc_drm);
 void dc_pe_post_bind(struct dc_drm_device *dc_drm);
 

-- 
2.43.0

