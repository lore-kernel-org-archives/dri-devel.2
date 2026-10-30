Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEA460A2608
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=gAlvZAuQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29F9F10E865;
	Fri, 30 Oct 2026 09:53:29 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010054.outbound.protection.outlook.com [52.101.84.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A19C10E865
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 09:53:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MX9KUxAUZK0DJ7BYtnTqG+aF5fBH9nL9zoYIZq6+qX5TUZpvEkhEGHdD/eluu3cUxUE5V+EfFp02GFQyIkQDfhOHkU/sVlspcIjheZKOshQmldh0cIz3oBcNKPC7DarVA4ne5Y4/37zei7QYbr7BrkpYfp1Q6Y3+A/hqnYlLg5mfVg98fQJpKvrTEGOVsoF8bRCLK33mqNg5tpRF7/bueFsuv42YEWvR79yM3dQuLyZAJLReQR7NwyTsmg9L0YY30FFLhIxm84vFuUNfR0eLkjeYjuBV+Y8uuNJoSTRp0qb6Y5bW037IYwE7nJ+plIgjsKHR8mH5XE0XReL5xxFQrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Bqv1R8GmGKcasUcemz8w8yZIbvgHQVHBwtx+4sBYNs=;
 b=dJRKvC0CnZIXPts2w7Vn5ejr5+QvjoIY8CgxUYkO6XEqz02o4VT0hcXSexbZ0iO/kYEnvLsjWFRmfnCmTXzgbburysKFJPWf0W7aEmtfSSItcv/cg23b1e0G5/q+4cwrmeRpyxEV05lxxjuKosmrQtjkFUZzK2oGCoH44QT34aF9AyZ5IuK09PP1F7azhiV9yGKVPCQ6QAdJvdy9WcdgiKKubiIEPnCEtIJfJHjMa9nXrMvJ5rwZX6CUQYB+qTUhAQHJDFSNn1cMTT8wskXGoD/4k8L2KD9LydVBrDCwdLgAuAk7YxErXq1Gwae2C5qa9XZsk7JNZtwMgAOQ2UquXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Bqv1R8GmGKcasUcemz8w8yZIbvgHQVHBwtx+4sBYNs=;
 b=gAlvZAuQYdde8VL7wOFW3CIbSlhk2g/pckggtelgFoKcFINi3Slgb849KXnUw1ocuC+iAJGckDY2LZU4tAMib44CnhRWmwGY44A7bP/uihKYyttxidQ32aKuWsogut56RwCD/n+E/V3N7ZH2K0VOocBnH8ZY1cBHo5gEYnJUYlGaPIADX+Cog7PkgtB8xmiLXD2nuzgg08GLuOWzySUT+Bj8ewWcyZLF9GZZU5U5AZQ8Md94y8kF8equq+CjaeR8DG+TaA4BH7ogNbmM/kmpec13dUHLcgtlu+MUintwZJ7eTsI296EDXGrvMTfjeWliKKQsAj5EpvuYqZMwMA/5wg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by MA9PR04MB839208.eurprd04.prod.outlook.com (2603:10a6:250:103::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 09:53:19 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 09:53:19 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Fri, 30 Oct 2026 17:54:28 +0800
Subject: [PATCH v8 04/15] drm/imx: dc-fu: Fix dimensions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-imx8-dc-prefetch-v8-4-c4f81afd4533@nxp.com>
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
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|MA9PR04MB839208:EE_
X-MS-Office365-Filtering-Correlation-Id: a450f8e2-4778-4239-c11d-08df366ba036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|7416014|366016|1800799024|10067099003|18002099003|22082099003|921020|56012099006|11063799006|261021135927099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: ukkjKLiCELzrs1lhRojjFhuXznIF4ZrfrqCw3VPBvndJUyJJRYIfRVsjYzChF3MkuPy0cCmWiJ1AU3vcxADUyvjue3QdcVR/yYng1BixKxm94+v75XKlsOOXCu8TUhj/cT56LyFHSwsZve0XSrspI/7vzxq6f6PSkXuBM6BML7/OtIGd3rQydmFHCSjxgCI2NJ0gaV8XuLyQahf7g/Us4BxdMGDrU/9d+tBRFh4t0EQl5vlWWIIjSfvl7TNb7tZykuAp2CLKmHSfYaRUlTr960v6TA90oJHHU/u/NuTI0CxmjQOCVijgH0QCqmQmdHgGa/HZIVQUC3jipr8QhBScsizSBvwy+20AChmg6/6pWuLYESjM3zkC5gsqf8gIotS4QvzYpNPzzYyoRhhVKMi5zOZDQ2Mro+jX/eyXG7kEFrCVlibRd/6e6jH7s5+RvpcSwauyHJqQhLDjENkDsEfa8eCLALQl/m9H/C3BbpClo98CY7FUQoWc+iHqtsm3eDSzqpC47ajFJDiY/y5TVMim5W/UOwzwd5rk6ZeIqWXGcbfd/mZTyTiSoMG5TIM7NhbTs9pX3YrBZz1ckCCKZH+2QA0nB47IifQ2+pEKkTJHNN43BUKPuVM8LtI/+u6wAXS3tPBsKRh+y4QuwXE98cvn4QsHriIxj/wUuad2TCQLQJchO2D7kdZ58yrnq38QiQA6ARyt19YlgWguaSy8TPlRTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(921020)(56012099006)(11063799006)(261021135927099003)(261021123027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXA0c3VWR29IQ21Ed2tVcHFRSTl0cHZsc1kydlI0ZXh2U1E2WVFpckZWa3ZU?=
 =?utf-8?B?MXc2VVNlV2FYdzk5VkZMUXRGZFZQczI0cm1NTVN0cjlOSTgvWTZHVW9Cb1pJ?=
 =?utf-8?B?UHdiVHNCR0VwbHE5U2xwdlRBa2pzQnBPenlPSzI4VWJWb2dvSC93Y01laXJi?=
 =?utf-8?B?TVFBRGUvRGdOUkoxeGkzSHhKTThqYnJqeW5EaTFpSXhKOHhoTVNqMXNUQjkr?=
 =?utf-8?B?MDhZWmgraGtCUWJndERmVC9xbDNDUDR3NDVOY1Rob0M0ZEFKWWtDb3U5YTgw?=
 =?utf-8?B?dHJ4Z0Y3UnhFOUtJeStuUms0Y2dSK3VJUytDMVZIRGhlYXJMbHlSd1RyWG5r?=
 =?utf-8?B?Mml3QmhvUHk0dzFDanNXRnIwTWgxci93WG5tRjVsY2JGRXppelNVUy84WjNI?=
 =?utf-8?B?VXlocHBwSWFSQnBWLzhSV2xqWkdLeGV5TmJOVUR2eUYrQUhsc1VNQnJtcEh3?=
 =?utf-8?B?b0J6ZTQ5L3p1Snp1VElSTXhLdXA1Q0dHNENxUms3V1JjMGw2Sm1ibDZrT2xM?=
 =?utf-8?B?RjhsUGNNZ2x2MjRCNjFsS1N0V1A5clo4SlMycWJTdFNwM0VJTzluU1c0R2V5?=
 =?utf-8?B?alBucDhlWEhvOGN2WThwZ0g0MHBuMHp1cGdUSzJ0UjQyMmtZeVVyR2JWajVX?=
 =?utf-8?B?amYwUGhMQlVxMjdJbFowZzdSWHhuNmplaVBNSTQvYzF2bnJEWThUVnRCUW94?=
 =?utf-8?B?djdrK21QeHFQSmVMR2x3SW5WbytIK1o1NXZ3RWVGUGw4WGpqVFIrWWpWMGMw?=
 =?utf-8?B?a0Y1RExIeG03N1dNRzdVVFZHQTE0WmR6elZkekNjdmdpL0VRK002cDlTdEtz?=
 =?utf-8?B?M3l4NENqekNORm9qbFhyZGRxdmlyekhZVTAxNGhra1VWMG9UbitMY3NOVWNY?=
 =?utf-8?B?blJlRG9rakNxUHA5Q3JFcTJXSzM1dGphVzNuYW9RUVlNckJZbmh4T3l4cFlC?=
 =?utf-8?B?cHpOTXozYkg3alNGQkJSV1lDay93QlloTXhoTmJRZC9wVENxckVLY25yQzdU?=
 =?utf-8?B?RCtYd21pdlB6YTVFaFczUXlTSWdjcS9nMzRIWVFGZ2d3ZXI3Y21Qd3dEUmgv?=
 =?utf-8?B?L0h0MVpkazAvbER2alBRWGZiWG1ENlRiMU4weUNFSytWL3BWbWR2TmhRZTJD?=
 =?utf-8?B?T2VVa0lFUEU3QkZLYzdCU3kya043N0Y1bmZhNmxjdTc2MnhOdW1QRjU3cCt4?=
 =?utf-8?B?VTlWajh0MWo1a2RpUFhoRjRqamJORXZMSmZaU2xiSElqTHppaDNzKzBoYWJo?=
 =?utf-8?B?eGtVOGdRQ1NRdEl4VkVVSXBvTkl5dFFuaE1oWlFxcUlCUmNCKzBqN1k4d1Nq?=
 =?utf-8?B?aGdIUzNWN3YyaEJIOFlVZWFNSlQzbjZhcHRGV2dDNld2T2EvM2ZwL2pKRUtU?=
 =?utf-8?B?Y3EvRGUrQVd5YTBQa0NoRzh6SkxoNXN5U0Z3R2I0aW12K0NRNHR0SlVNMCtE?=
 =?utf-8?B?SnpNOW5uSkxnVVBka0FnUm9CbmNIc09LK3NuUFVLLzZ1ckRudTk2TVpINFB6?=
 =?utf-8?B?NVE5SE9vcnVFVHErRU9Sb09TWDlsZ0lWZnhtQVlZYU9TY0FTWDV0N2xFblJt?=
 =?utf-8?B?WnorN1hnM1NwdmxHN3ZwRVpURlpCN3gxY3Z1alFLOHhKbmZKRURtQVJWc3pD?=
 =?utf-8?B?YUpiVjBqMHB6NW15bFdlMTFKaWtIcVpaTjN6Umw3S1VCZVlpZTlRVVM3V0hw?=
 =?utf-8?B?djF0ZHVKU1hIZ201UUN2VXRHT1FGOTNMVkVQeUw5Z2VKaFFXcHlKVlN3am1r?=
 =?utf-8?B?c0dhdHBlRmY4NUFBUmpRZVUxK3RPLytvTWludERjWHlFcWNRVGJCWFFobEZw?=
 =?utf-8?B?Tk1Rc3Y3bE9nZ0hadi94cGJ1V3Vua0ZMbmVXakxwUHowWW84QStDTFh4WlN0?=
 =?utf-8?B?dncweXRNWXBkT0tDaU0wMmFSNzc0MW5GMW0vMjU5M3RSZ0Vpc3BGN0dvU1pZ?=
 =?utf-8?B?SUJWYkZlYkVHblFkTDBjZzExMkp3eFcycVlrWXhKMnIyc2tQUjNLVmFOYVF5?=
 =?utf-8?B?R3VxVkVXMVNIc1NvRUhiNDlXZWc2dHY3ekJUN3YwT3k0ckpmQVJtQitzMGNY?=
 =?utf-8?B?UjFrNTA0VHFnUXpocEo2ZHE0Y0FUWVU1NjlRS3R6a1FRMWxSb3BMV24zTHpX?=
 =?utf-8?B?YUhYN1lkUWdjeHVWSXhNMlYzWVNiU29wVTFQbjJKSU9zOTRDNE5KaE05UXlI?=
 =?utf-8?B?MDd5Q0N2NHFEWWo2cVpzMEdFcDFHR21VbnlLRVYwK3l0b2NpaEhybU44QjBI?=
 =?utf-8?B?ZXF1eUQ2Z2NlczQva1lUWlhZWjl2d1NCQjZ6RTZGL0J6cHdDZkpnd1ZWQlpJ?=
 =?utf-8?B?N0xncHhxazdCY0RCOTB6cnVEQ1ptVSs1bnYzcWNRcTBVY0dzNW5BZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a450f8e2-4778-4239-c11d-08df366ba036
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:53:19.0153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pc4CX+OdwZjn5KCECgGPQqiFKwzDt1uQf5WsqvrbO8UPHhEDRkZPEXOlLs/Vddg4UHAPGI6OQMyws31+qWnmCQ==
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

Fix off-by-one issue in LINEWIDTH, LINECOUNT, FRAMEWIDTH and FRAMEHEIGHT
macro definitions.  The first two macros are used to set a fetchunit's
source buffer dimension and the other two are used to set a fetchunit's
frame dimension.  It appears that display controller itself works ok
without this fix, however, it enters panic mode when prefetch engine(DPRC
and PRGs) attaches to it without this fix.

Fixes: 0e177d5ce01c ("drm/imx: Add i.MX8qxp Display Controller pixel engine")
Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v4:
- Rebase onto the latest drm-misc-next and resolve conflicts.

v2:
- Collect Alexander's and Frank's R-b tags.
---
 drivers/gpu/drm/imx/dc/dc-fu.c | 4 ++--
 drivers/gpu/drm/imx/dc/dc-fu.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-fu.c b/drivers/gpu/drm/imx/dc/dc-fu.c
index 1d8f74babef8..2e197b3344bd 100644
--- a/drivers/gpu/drm/imx/dc/dc-fu.c
+++ b/drivers/gpu/drm/imx/dc/dc-fu.c
@@ -31,8 +31,8 @@
 #define STRIDE(x)			FIELD_PREP(STRIDE_MASK, (x) - 1)
 
 /* SOURCEBUFFERDIMENSION */
-#define LINECOUNT(x)			FIELD_PREP(GENMASK(29, 16), (x))
-#define LINEWIDTH(x)			FIELD_PREP(GENMASK(13, 0), (x))
+#define LINECOUNT(x)			FIELD_PREP(GENMASK(29, 16), (x) - 1)
+#define LINEWIDTH(x)			FIELD_PREP(GENMASK(13, 0), (x) - 1)
 
 /* LAYEROFFSET */
 #define LAYERYOFFSET(x)			FIELD_PREP(GENMASK(30, 16), (x))
diff --git a/drivers/gpu/drm/imx/dc/dc-fu.h b/drivers/gpu/drm/imx/dc/dc-fu.h
index f678de3ca8c0..cc93317e3001 100644
--- a/drivers/gpu/drm/imx/dc/dc-fu.h
+++ b/drivers/gpu/drm/imx/dc/dc-fu.h
@@ -38,8 +38,8 @@
 #define YUVCONVERSIONMODE(x)		FIELD_PREP(YUVCONVERSIONMODE_MASK, (x))
 
 /* FRAMEDIMENSIONS */
-#define FRAMEHEIGHT(x)			FIELD_PREP(GENMASK(29, 16), (x))
-#define FRAMEWIDTH(x)			FIELD_PREP(GENMASK(13, 0), (x))
+#define FRAMEHEIGHT(x)			FIELD_PREP(GENMASK(29, 16), (x) - 1)
+#define FRAMEWIDTH(x)			FIELD_PREP(GENMASK(13, 0), (x) - 1)
 
 /* CONTROL */
 #define INPUTSELECT_MASK		GENMASK(4, 3)

-- 
2.43.0

