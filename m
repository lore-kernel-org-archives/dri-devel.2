Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37390606A332
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=FWUiULRn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DBB010F390;
	Tue,  3 Nov 2026 06:21:07 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011056.outbound.protection.outlook.com
 [40.107.130.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CB6610F38F
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 06:21:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9UD9vnK1NqbPp7z8U39ItTVsDuLsw8oS4DivaLngOZf1b2cZ+qlR77VirQf6/eJyBlpfwy83Ro1EGCijoTFDC+vCxrAWPjTAafcIMl0O2Z/kdrzYzDUlDsrSu6tX1hANvIvJvCn3N561f3kogVYKhmNvZlgT0V+Ny/4bHYYmsIgm9y3gBhE6GJKJwDbasSCAn0k0l8hhUudvCmoaFa//JZQE4eCVx5ZvXa//GGuBJWAHn1euo7cGkKqGb59yAhF/1h8qR2tRMcZ7leYswLuwQx50X+617O3sl0xxsfWyc/bFRqMWgH3EOjnbaHNwqEPZNWLCQHxeq0lrbvq/yw2UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Bqv1R8GmGKcasUcemz8w8yZIbvgHQVHBwtx+4sBYNs=;
 b=NFd0pK1ppnV8Ow+HAlBkJrr/fSt9qzz16qnkyUa/y3xvjOjR0M1z9pM7tnjrdtVGmPElKfUd7rQBfkruZ6ydSVmiuLQDv9L0My9sr3tn+NNMGAHzCI6Zx4YfdDjPBQ01NgdSZDb6NCOAsd0OPnPOW/8/JZADRK9emIjb5weH/8Cpa3izszRq/In/ANOJkU/DJLZFHgOKle8u2REsg83aYzZj5U4HbQdxqgGNlm77VTRi4QCI9lGuD1anWlHHDKtBJXoZS82eHKVZ0JqY2jl3itzQswslYk4NtIuiy5cFikqinHnJdy4n72rca/L6/+5YOI7Nsj1NKMlf43YiCEejdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Bqv1R8GmGKcasUcemz8w8yZIbvgHQVHBwtx+4sBYNs=;
 b=FWUiULRnXU3I8rKVmG1lcHqnLzMRmBQAYkThVGHqj1HVP0L2jgGxM7V5Ty3vu0IarpDTgqHE41t3z6GugDgVRAZopFX0BPMJOkCX2I5HNwKzG3uc57MKSzwxL4jsIYQcn7QBGYWS4oyUMxpsiMuzhbVbHjmULbfiKI7McSkl4mX4deXAAo0risDn32eiihlSyNwZdoh5zfPtJC7olw9jvGOQ2dph1WyxXmY/iTgBKJ3ZHjcH7L5n5sykupiZWgrDs3L+Ba0r8SeE7VAQrZv1b+Z79a3ZTEq/7l8ljRM9PJYkhuWmq11tLyuAoGhKbDkFezv36ABEjz0S/dGXGSsMuw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by AS1PR04MB9698.eurprd04.prod.outlook.com (2603:10a6:20b:481::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 06:20:57 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 06:20:56 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Tue, 03 Nov 2026 14:22:01 +0800
Subject: [PATCH v9 05/16] drm/imx: dc-fu: Fix dimensions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-imx8-dc-prefetch-v9-5-3b985e7636e2@nxp.com>
References: <20261103-imx8-dc-prefetch-v9-0-3b985e7636e2@nxp.com>
In-Reply-To: <20261103-imx8-dc-prefetch-v9-0-3b985e7636e2@nxp.com>
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
X-ClientProxiedBy: MA5P287CA0185.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b6::6) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|AS1PR04MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: 58050c9c-2919-4f34-81d7-08df39729f13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|7416014|23010399003|376014|1800799024|10067099003|22082099003|261102123227099003|18002099003|921020|56012099006|11063799006|261021121427099003|261021123027099003|261009223027099003|261021135927099003;
X-Microsoft-Antispam-Message-Info: XnvvD/2a0ysbtvNgRnao9xm0l9Fk0Tbxk7S32eKw+tTKcpyqhSBQUHpl/v+AE5HvHpq+v5JUKzNpjk0Oadlus/rMYBAIlSVz2FI5dfRjvlkpciF3ZyUFYmQXAaW6fXnYiWj++sivQCnqArQQjH3fkWbeoAjS6G4YDk6xvCjZbge32apYea5fAqepYb1YmlAimF//EwVnecMbJVRDgqCRJhlcS5W9UvxO7AFIUdg5Kdn6lc8czN/0jUF+gUpjnzkeZW2MpySm93xz7VV5ZOOTD/TXBIYzgVTV2HijIEHYOwKqOZrD8ofcqo6SaVMLW9e66RrDZiZdj4JotkhVgFRBxCoGScXc9pdkAa5OezbGmPyUfaSIUL7RI+fXI/laTchyZ7vMeaEmmG+W+yrktg6wy62RZKmcz+jK4MAy4AS4SA8ZG13Fblt2epFkrgtQX8ugBh1S+B8CVCJQOl7rZQDVKqiwQA9uh2V2Rp6o9B438CrSkpYCvjT1RsQUbP3PvoCWid5XdquQ8N9JHGkhgA3n7qZ6OTuEKnWqFYQtBAO+3uXBEoUAt6I1TpUK7VegB7/XhOQphQ7C+Ccz1Bjj75dfmMMrFPrYAXNJzu+Ckd72dr0wwbteXlkhGkCRKLoy4AqCIZXixlc1jpeuqK96zLuJ4CsDkm9ajfQJNKQ4IiEG1lchqD/+urw0md+yc7U4kBgxiBwq7gyBfdu5vCYTk60glA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(7416014)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(261102123227099003)(18002099003)(921020)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(261009223027099003)(261021135927099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0xGZXpEaWVXa0dpN1psdHE3Rno2Ri9oY1VEK3dIR1k3WVBGNDhFbmpMczM2?=
 =?utf-8?B?cEN1YVZYTEt6M0U4czBWaXAycjIvWXZMaHAzNkRUSjZNUzRwL3RvY0dFRlpz?=
 =?utf-8?B?akpWZUhkbWwyUGs0dVRHZkRkbDcwOXN3L3NFUk1RR0tkYm1LUzNIL2NUOUUy?=
 =?utf-8?B?ZmhVeSsrdFEvQkVBcXNyZ3pOQjhheDJqRGIxUTVycjBUVUl6VWtBMDRyRG42?=
 =?utf-8?B?dVo0cjQ2cFZFdUU2M1h4MDh0VHZqcXFmYTdnd1BQRkZIazY5MWpickc1YXFD?=
 =?utf-8?B?bVVSWG9xSmcrUUVJVm9zdU1DY0JMelVpS2k0N0RrSlE5OXpWVFZ3OW5rWmlk?=
 =?utf-8?B?dGVUMnl3TTFaSkkyZWQyb2U0ZGFCK3p2Nk9QbDVjbkw5VER0bm9rZy9leWVG?=
 =?utf-8?B?cnNkQ29TOEZUNGRLc0NhbmtKZ0F6OWJNZmRYRTVXeXdTVnIrSS9MeDlmNmQ4?=
 =?utf-8?B?T1dHeWRmUVVCNERmanZWb1hycThoeXM4Sk94dnlTZXQxd1dxeml3d3dQaHU3?=
 =?utf-8?B?Q1JQb2JMYnpXUXo3T1ZNWUQrNFNqQ3pHRk95blFmTGRUOENaOGxWQU0vSm44?=
 =?utf-8?B?MkxjM3BuWmlMTTdPb0xEQnNyN0dlNnQvWE1hYWUyaUhlWmRqS3JZZXFlcjB2?=
 =?utf-8?B?dE81Zm5CU3JRaWp2LzE3MGRDUXMwL0UrcGZJNC9DN3NRbE9ub2xwbWtQNzdO?=
 =?utf-8?B?NTZwNzRxR1p3RmxlWkV4Rm4wcUFUWXhJR3NSZ1FtVXRnMjRFK28wVmQzaGg4?=
 =?utf-8?B?QitncTRXdHNYQ0kreU5ramtKdG9ZS3Vuckt4TnA0b1VvNG4reDROdXc3dk5C?=
 =?utf-8?B?eFlqRXQ3RTZtVjFCbE40MFNQTEtxQ1pFYTlSM24xTm9Pa3pFRllqOCt0MkF2?=
 =?utf-8?B?OEQ0SWVSNWJtd2NZdlE0UHYzNEs1dVMzd0QyaldZNnNyOUVUd2pVa3BJS0gz?=
 =?utf-8?B?OVRQNDd6OXJhalBqWW9XbGNTUUJzdDhMTE5kOElPR3VQTmw5VGRXYjZSelVa?=
 =?utf-8?B?SmJ4ckx6dVZEUEJOQjZFMjY5eTJzMnFXTHlzZVJLVDhjZngvd3NzTTFlN0Ns?=
 =?utf-8?B?bzBEUG1DRTRLdVlDOW81b00wWnZhYnI2ZDFxVDZEODBlTTlEK3NxZVBWNXRu?=
 =?utf-8?B?emhmU2pNWGZWM29rdXV6RG9ocmx3RWxvL0Mrb0w0MjVKaGRGRVlaa1RIbWYv?=
 =?utf-8?B?aEtaU2VQWHRUQmRibDl4TkltZWRkbFJCVEdwVlkwaVowU1Q4UmhnS3NhZTB0?=
 =?utf-8?B?U2dUYWozUksxUzZRZDZzb3NtcE1TT1U2VmFiWWJTOStFdzY1aXoxd3hnS0ox?=
 =?utf-8?B?Q3QySHhEYk0vbGxrTE5Hd25mczlUbFB0NEY0ZW9wVXVKd3J2dWUySERYcVlC?=
 =?utf-8?B?SmlkdUtaWC9aZ1VONENtMjhaUHpDSmpuZTZKU3h5bEFLUHA5Zk1JM08wRGZJ?=
 =?utf-8?B?RVVCK2cwa2UxcjkrQlRqWWgyL1BNYjluMk1YVGN3UWtCbUQzaTdabUYyR1BX?=
 =?utf-8?B?MVNsbEd6Vk5HQjV2alFmTDJOSldadlNQbGtDUFJOU0g2U1R2emM4SXhMbE1X?=
 =?utf-8?B?TVpuci9ZbFdXdUt6SEtxaTN2dUJWQ05OcjBidktZQ3dWR0k2dWl3VkR3MCtY?=
 =?utf-8?B?aVVialIxMWNaVlpaR3AycXZpQ3pjSXV5N0ZjWlU2Y2lsZkdLeGx4anNUS2hv?=
 =?utf-8?B?WitGL3orNnlDWEJZVXJtUTl2UFhXcndETzRrVlcwcVJHTjhDdklhK2k4WkFu?=
 =?utf-8?B?OC9NVjU2SDlZNzlPaDd6aGhNb0N1bGVibk1DTHFtcDFpOTM3Z0xJazhqSXFJ?=
 =?utf-8?B?M244TkZqUG9uV0xPSExVc1Y3WWZlakhtdVA4bkwyWFMrVDZuOG52RVFUSEpZ?=
 =?utf-8?B?VkRScG8zZy92NWtnRXBiWno4ejIyOStCaFh4WHBjN1V4eDkvckZGSTU4eThE?=
 =?utf-8?B?QnpNNjArZ2l1ZFFZODhGaGk1c3JkVzdnNFlyMjROVWR6NzEwYVZmWnpjQjZM?=
 =?utf-8?B?cFNGMkFhZ0pvdzhPZU5weWVKME9SNmpIam5qT2U2YWtUTFM1V28xSCs4SFRJ?=
 =?utf-8?B?S0JDYWMzK1BsOWVFRlFpcEVIekFSWmxOS1QyaWYvc2ZQbUFMSVo4U1VjY2tX?=
 =?utf-8?B?b1IyM1VwcVdTM2ZjVU9ld1YrSkhGaEtPNW8wWkl1cVR1TUw4M25ZejRsZGE5?=
 =?utf-8?B?cTlYRXNVSE8vdmZJTFF0VE5sSXo4RFBpb3FLckVQUmZudVdtUjl1VHZzZ3BV?=
 =?utf-8?B?WVdZMENqVi9yUjB4L1o0OWhxclAvd3ltd0ZteTcyY2xoSldrQlUxUUptdy9w?=
 =?utf-8?B?a0dtS1BjZXEwdWVWOS9ISUNPaHBqMU5qMzNpRldyZmdjMC9YMGQ2Zz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58050c9c-2919-4f34-81d7-08df39729f13
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 06:20:56.8499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3J91lLOMj3JhHoUaHi7emAhIRfhHGg2H39MGUh8IvbnSAKZvRr4DBmDs7o0tzLgAMPCdGeriXXQZxm1mCeCGkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9698
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

