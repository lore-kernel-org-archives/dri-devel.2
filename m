Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB9D60A2629
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=lP7SbQny
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 386A31126E4;
	Fri, 30 Oct 2026 09:54:32 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012036.outbound.protection.outlook.com [52.101.66.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CC0F1126D2
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 09:54:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTMxak900MbCK15ROzAvtUVpW3Cgw07/M5h80b2nqMwM5C/h0BtS3nL4GI8iMBbfrMPGBkMoymT8wVhzwJUXc9HK6BvaeuOIQKBzNUIVRpZ3IjxvIAUoI9NhxxMI0LBnR9tqdk9hpgTB7MGgWgYGueW0G34V3zu/ojmiW8u7RewL/de73/HH7CEki2rCwcGK3kCaaOf59JcwuubvX8+PANZmwFv0eyKGTGXLoU/bntUr0mjW5MupKWi++Mt7btMd9NzaQLdXzEtSrB5TJernSxbKrCXTz2PXEcLJM3PDEl2j5kSYs1wRmuC7bI2zmNIwd0oJTQV2vbn1CHM4Cxjspg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+gPCWzIAdsVPYkrizOXOeMwNsWbBjc3l8QYVxshcrI=;
 b=IX7sTrDp39U/PBz9xSA8wzb7zkwrZn79fSpYQF7yt0wogRJK2tU/EiYq05goN5W11L9UR1RYD1NSZWpcEBTHiOHTPzl6RO3RZbQr43Oi0kIjqZMm0Ub4fffkIBfxNnGCAh8b0fvDBofWbYow5cddnRWosdzAj7m8WwdEfeE9OvR7pxRl7OVOV0v9CB/iNLphyJiKzIjMJ+kmnDRaHGtzjxbnybgiPueMtNqeRpxCsrvlRSdgXQoBUlFZM5pGs3w+idHosTQ9tC/qfeb5FCT1rz3MzqKqmtySTMANgCfkDT6eObQSJ+ISRkSbt//AGfpJHSa2qI4vSmLaI4sEtL099w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+gPCWzIAdsVPYkrizOXOeMwNsWbBjc3l8QYVxshcrI=;
 b=lP7SbQnyqVyUcZJSjBRtWzwqYkYC5aZg/Ih5wPnreyoiATZ4o7tYJWUOcZyQiP1xJKYkYpNgfD4iHCZ0Q8P1U7V13RctVFLPaipad9i0XSttRz09pB8eAD43cTFR5wRNt3VJG3YV69opRrJQoYZ+34Ni0DSBJLYkdMeYzqS8y8kbpC88uXwQNUeCrmr/s4IHqWoxsUVs47VjHTW/uWN2JVfNWHlsmJXEY+A/Us/dRYUvIL+41aSnmAzpTEvAM3dVIPFzzljX/fWP23yTPEsq8Vrt3GibMq3ksoBZsu2gnQlmuNfHwE3k5rNKeyboX9vgCAFEs9Re/4k/3bVLEoIqhQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by AM9PR04MB7537.eurprd04.prod.outlook.com (2603:10a6:20b:282::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 09:54:23 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 09:54:23 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Fri, 30 Oct 2026 17:54:38 +0800
Subject: [PATCH v8 14/15] drm/imx: dc-fu: Get DPR channel
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-imx8-dc-prefetch-v8-14-c4f81afd4533@nxp.com>
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
X-ClientProxiedBy: TYCP286CA0313.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::8) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|AM9PR04MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: b00d935c-ad63-48d7-93d0-08df366bc6a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|7416014|1800799024|366016|22082099003|18002099003|921020|56012099006|11063799006|261026140227099003|261028144727099003|10067099003|261021123027099003|261021121427099003|261022105027099003|261009223027099003|260925022911599003|260925021911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info: biWw8PVhS4Ayrki+uSFzYZTNW8TTWeXAyVSCt9q46XU3BBi4zIEsi4fj59qSuhgUxa3/DFwqIYryBWhhI40iCATx/kbEKrIR5tnEw07ObjwSoSORtHbpCU6BoefFpJZKq+Jzxkdg9eV2LnXIHvLwsaEA60l6zRkAwJXADahcJVp3ASC8H6GEq6jLvxc9LURAUso+AkD3hvWyx6LkXvk3C8W53JXjG32Py1wpqtU8IrX6oeGXN7MZz2U33lcyxBZXECZaGCQbMh4otHOX09TmOGdpEEBbvD0HV/tAPhiEQNBrcaMTtKAPZkuWOzawIFLnLWRk0bVo7dZntpKUqVJmRfIzIBQMgtB4X78jKB1nqXcmIwzraoXrJsfEV0oqllegqEUwJ7SDVhUdo9eRAnEGZTtm21jdk91LN4tnAiHXwsSuoCEGPioRyrQ0/zSQ5qiG81Zf4CVQ8CLx8AarHO/TlSHsk0ze7AWuJWIJU1JpLktJHm+5Bfz2p9ZqS+TH9Sneif6DzWLGGm0yvzC6b/uBAPl6CZt8lANfO2KeQMKW4AkSuJLnKcwEeox13jUg+w411kAhZ725GxY8KdAyZBRm7ptbpqzzNw3rbqPHpGNJJ73y7i5Zb8jq21bGKsy0pqVKK3BFT0Vd+NzWotjfJZMOhBdNJvk9dr0mnrkzr+U4+lPrGRevKQEESBR58cOt8HZYf1ThEJoTTGk1EDqsOEqu3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(1800799024)(366016)(22082099003)(18002099003)(921020)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(10067099003)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(260925022911599003)(260925021911599003)(260925021311599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzNJTGVjZTRpbGVUT0M0dFdua0lrUk1xVHAweER6YWRmRkNWeTMxMW1QR0pT?=
 =?utf-8?B?ZUd4WU9kS2pCSjl1ZGJKU0x6VEd6YkNDRmd5QVc5SVd6bkV3TUpsOXdUUzdt?=
 =?utf-8?B?OVF0RW9zWUs4VjBHQkhvQjEzdHBKNVExbGVveUVxYUt1YTFqYmV4ajFuRWpx?=
 =?utf-8?B?NVc5ejNVOFI2VnV1TlNzMHBBbFUwNUducWxrVXVsNndwUzZLMFF5SElSWlMz?=
 =?utf-8?B?dmRYeHJIQktYNzcvekFmWmZ3K0ZUamh5K09CemMrTEQ4TjB3UmtHWnZPalJk?=
 =?utf-8?B?ZVZuaEhjWmxKRjRkSGVOcVA4Slk3ckpaRU8xeE1uaEk0TUg0RVVyNVg3Ry9m?=
 =?utf-8?B?eWFDMEZMT051OUJtMzNvcnIvZy9BTHJMR1gvRy8zM3ZWSzdJUFFlcGxNME0x?=
 =?utf-8?B?T0lBaVFxOEg5NkxPZGF1QWZRakwwWVhwY21TWVViamwwd2Jma0huR1pUbVdR?=
 =?utf-8?B?angzbWpMYUZ5RnlWVFhTU3ErUGFSMGltSjZ5N21abUM0TEhjRXdjby9JZTNu?=
 =?utf-8?B?YkNZd2s4TFJpQXJ6V2V1bm1EbFBvOTUxRTVqMnFhNE84V0lkQUJJOVRoUDFK?=
 =?utf-8?B?WmNPUHorRUdvazhnR1dsVkFmVXovcGMvR2ptNld5cDhMT1VaTTNtOW10ZVA5?=
 =?utf-8?B?VzRwV2pyeDRtamNtNXovdmlhNzRETndRZnhvTTJGQ2J1dGt0UUh3Q3BPUm8v?=
 =?utf-8?B?YTJMaDd1VHlLbjlQNEJUVWVwbDhrSHJEUVpjRE50VEV5eSt0UmRmS1B0bzFu?=
 =?utf-8?B?eUVhQjZ3SEZ2V01HQXdIVWdkU2RNZG1rOHA5ZXI0dGgyOXREaFFzTVNyOE1P?=
 =?utf-8?B?QS9ZSzVaWnUrZGVqTCtOSTQxZ1ZBMnJXa2MxSXVVZ0lDWTFxOFltMzd5WmxQ?=
 =?utf-8?B?NmJHRXJYTnA0ZHJOUmhZZ0RBMkFqUjBqYzE1a24rYzYrdmJrZFVseTIxSi9U?=
 =?utf-8?B?ZGtsYTM1NUQvN3BWY1ZRMFRpTEJTUlVkdEZSSVQ2bk4xN0hEdDhMWVJCQnM4?=
 =?utf-8?B?YjFNUEcvVmx0NkQvaUdsR0xCSENiSUFzeGczbFVwQm9aMGh2d1FVSmNpWXh6?=
 =?utf-8?B?L2xjOC9GeTFEMmU3RnZYUG5ySVZnR2xrdy9WSnJ2UzRhYjUwckJXVXY3djNJ?=
 =?utf-8?B?NGtyMVNseGM5SFlnMWM2YnlCT1MvY2VmK0kzejkyWEFUZlFZbXgzbGdaSVVq?=
 =?utf-8?B?TTdFSzZoZ283Yy9WTGVjUnF5V0ljcEFibzQ2b1c2VWtIVFZ0M3AwMnAyZG9x?=
 =?utf-8?B?RkJ1eEpxeldRVWNKdW5LUldiVXR6aG16S1lXamJrdWNESkVDWlRuUkRPTTR1?=
 =?utf-8?B?ZkUyNGhEQkw3azRnQWRla0gzQ2ZpMitNM3pGMC9IcDZMUFFZbytOek9kWHRt?=
 =?utf-8?B?ZjU3VVgrb0pmUi9melBiZUx2Z3JpLzBRS3JFRk1NVXNSL2dDWWUxMW54ZkJj?=
 =?utf-8?B?VU9PYVo5MDE5TlJZWjNMOUNwYzB0SkhIVlBrUWdvWXB4M2FJRUVOYlZScDYz?=
 =?utf-8?B?TlRqTmFuTkw4eHI4b3lDbk8zZEZWVnduQWtUWHBFVzhwYVhpYnpHNnR3cmlV?=
 =?utf-8?B?V1JGeW5JQStyWURNWTNnV1VpMll6ZE0yR1N2Z2ttTjFUbnU5a3RWZ1RDQzhK?=
 =?utf-8?B?bGVDTm0wTlI3QUt5V2RMOTFPS0lEVkt1VjZrKzNrV1dzMEk0K2lkdWU1WEIw?=
 =?utf-8?B?UE10UXV6bm94QmlPemE5cnRueGk3Y3lBTFU0TGlZeU1Ud2Frd3E0Y3RmRFZP?=
 =?utf-8?B?cTZCd2I5YmRPbC9wTm9jZVpCYm1qWTJJQzRaano5ZURRYXBjNUU5Tjg5Tnlu?=
 =?utf-8?B?N2hlejVPd0toc2dPUnZTODI2Qk5hWjc1Q0d0NWY0bFVSTlE2ZDNyeWJrNllq?=
 =?utf-8?B?UDZiQlkrdEdhZUNqNzdSa2J2RGhCbkFHL2JFSkxSQjltRjI3OGZQck9GL0tu?=
 =?utf-8?B?WmNOZ3RYYzNEOEliUkp6a0lQWlhwd2dlT1VlQXhJOTNTeUlldzFqakxZM2Mr?=
 =?utf-8?B?cGFBUWJTd3gxOGh1NHFMd3MvSUwzV2lXNlYvUHczaXFvV0hYOXhoTDUxaDVM?=
 =?utf-8?B?bnZhaUhSUHNYbUpWbld1ZlYxL2lwd0xRQnduT1I1cWFmVzNpcllRSzlZaE9i?=
 =?utf-8?B?T2x5UTlTd3N0RnZFM2xSTE9CUkhTZ2x0OG1DQ1dabHhoZkJKRXY3bDdWSGR4?=
 =?utf-8?B?Ym43dEJGeUxNK2RtcU1pVHpvZ05JY0EvQU9BUGg4QVlVMFBlVlFzdlNrcHh2?=
 =?utf-8?B?eUNQV0dmMWlOd0VHTTNyRWpJbzZZKzhiQmJTTkJ0bmdkZ0dTY0NKNEwzNWt3?=
 =?utf-8?B?UFFoOGFhSHNPUGFlOHBPNzdLcVhSYk0rWHJ1WnBYYjlSak1DV3lZdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b00d935c-ad63-48d7-93d0-08df366bc6a0
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:54:23.4587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DzQLqOdFevnRJtaeR9Gd+o6j/a0yanJSpaJOZXCyiMdFtn8MObKodLW+Mhc2HpXuG3aQngtggkXsTb6bHBuTEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7537
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

Add a helper dc_fu_get_dprc() to get DPR channel for FetchUnit.
And, call it from dc_{fl,fw)_bind() to get DPR channels for
FetchLayer and FetchWarp.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v7:
- Collect Maxime's A-b tag.
- Call dc_dprc_get() in dc_fu_get_dprc() to create a device link between
  consumer FetchUnit and supplier DPRC to avoid potential UAF when
  accessing fu->dprc.  (Sashiko AI bot)

v2:
- Collect Frank's R-b tag.
---
 drivers/gpu/drm/imx/dc/dc-fl.c |  7 ++++++-
 drivers/gpu/drm/imx/dc/dc-fu.c | 25 +++++++++++++++++++++++++
 drivers/gpu/drm/imx/dc/dc-fu.h |  5 +++++
 drivers/gpu/drm/imx/dc/dc-fw.c |  7 ++++++-
 4 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-fl.c b/drivers/gpu/drm/imx/dc/dc-fl.c
index 9f03df44a63a..f7b8c4909c80 100644
--- a/drivers/gpu/drm/imx/dc/dc-fl.c
+++ b/drivers/gpu/drm/imx/dc/dc-fl.c
@@ -100,13 +100,18 @@ static int dc_fl_bind(struct device *dev, struct device *master, void *data)
 	void __iomem *base_cfg;
 	struct dc_fl *fl;
 	struct dc_fu *fu;
-	int i, id;
+	int ret, i, id;
 
 	fl = devm_kzalloc(dev, sizeof(*fl), GFP_KERNEL);
 	if (!fl)
 		return -ENOMEM;
 
 	fu = &fl->fu;
+	fu->dev = dev;
+
+	ret = dc_fu_get_dprc(fu);
+	if (ret)
+		return ret;
 
 	res_pec = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
diff --git a/drivers/gpu/drm/imx/dc/dc-fu.c b/drivers/gpu/drm/imx/dc/dc-fu.c
index 2e197b3344bd..d9933218069c 100644
--- a/drivers/gpu/drm/imx/dc/dc-fu.c
+++ b/drivers/gpu/drm/imx/dc/dc-fu.c
@@ -8,8 +8,10 @@
 #include <linux/bits.h>
 #include <linux/math.h>
 
+#include "dc-dprc.h"
 #include "dc-fu.h"
 #include "dc-pe.h"
+#include "dc-prg.h"
 
 /* STATICCONTROL */
 #define SHDLDREQSTICKY_MASK		GENMASK(31, 24)
@@ -256,3 +258,26 @@ void dc_fu_common_hw_init(struct dc_fu *fu)
 		dc_fu_set_pixel_blend_mode(fu, i);
 	}
 }
+
+int dc_fu_get_dprc(struct dc_fu *fu)
+{
+	struct dc_dprc *dprc;
+	struct dc_prg *prg;
+
+	prg = dc_prg_lookup_by_phandle(fu->dev, "fsl,prg", 0);
+	if (!prg)
+		return dev_err_probe(fu->dev, -EPROBE_DEFER,
+				     "failed to lookup PRG\n");
+
+	dprc = dc_prg_get_dprc(prg);
+	if (!dprc)
+		return dev_err_probe(fu->dev, -EPROBE_DEFER,
+				     "failed to get DPR channel from PRG\n");
+
+	fu->dprc = dc_dprc_get(fu->dev, dprc);
+	if (!fu->dprc)
+		return dev_err_probe(fu->dev, -EPROBE_DEFER,
+				     "failed to get DPR channel\n");
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/imx/dc/dc-fu.h b/drivers/gpu/drm/imx/dc/dc-fu.h
index cc93317e3001..9fbd7aadd264 100644
--- a/drivers/gpu/drm/imx/dc/dc-fu.h
+++ b/drivers/gpu/drm/imx/dc/dc-fu.h
@@ -8,11 +8,13 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/device.h>
 #include <linux/regmap.h>
 #include <linux/types.h>
 
 #include <drm/drm_fourcc.h>
 
+#include "dc-dprc.h"
 #include "dc-pe.h"
 
 #define FRAC_OFFSET			0x28
@@ -99,6 +101,7 @@ struct dc_fu_ops {
 };
 
 struct dc_fu {
+	struct device *dev;
 	struct regmap *reg_pec;
 	struct regmap *reg_cfg;
 	char name[21];
@@ -114,6 +117,7 @@ struct dc_fu {
 	enum dc_link_id link_id;
 	struct dc_fu_ops ops;
 	struct dc_lb *lb;
+	struct dc_dprc *dprc;
 };
 
 extern const struct dc_fu_ops dc_fu_common_ops;
@@ -123,6 +127,7 @@ void dc_fu_get_pixel_format_shifts(struct dc_fu *fu, u32 format, u32 *shifts);
 void dc_fu_shdldreq_sticky(struct dc_fu *fu, u8 layer_mask);
 void dc_fu_set_src_bpp(struct dc_fu *fu, enum dc_fu_frac frac, unsigned int bpp);
 void dc_fu_common_hw_init(struct dc_fu *fu);
+int dc_fu_get_dprc(struct dc_fu *fu);
 
 const struct dc_fu_ops *dc_fu_get_ops(struct dc_fu *fu);
 
diff --git a/drivers/gpu/drm/imx/dc/dc-fw.c b/drivers/gpu/drm/imx/dc/dc-fw.c
index 14512c01ea78..030970d4f987 100644
--- a/drivers/gpu/drm/imx/dc/dc-fw.c
+++ b/drivers/gpu/drm/imx/dc/dc-fw.c
@@ -130,13 +130,18 @@ static int dc_fw_bind(struct device *dev, struct device *master, void *data)
 	void __iomem *base_cfg;
 	struct dc_fw *fw;
 	struct dc_fu *fu;
-	int i, id;
+	int ret, i, id;
 
 	fw = devm_kzalloc(dev, sizeof(*fw), GFP_KERNEL);
 	if (!fw)
 		return -ENOMEM;
 
 	fu = &fw->fu;
+	fu->dev = dev;
+
+	ret = dc_fu_get_dprc(fu);
+	if (ret)
+		return ret;
 
 	base_pec = devm_platform_get_and_ioremap_resource(pdev, 0, &res_pec);
 	if (IS_ERR(base_pec))

-- 
2.43.0

