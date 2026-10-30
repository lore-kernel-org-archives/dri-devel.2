Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D595D60A2634
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=UsENqfwm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B6C81126D4;
	Fri, 30 Oct 2026 09:53:37 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013026.outbound.protection.outlook.com [52.101.72.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D46110E8A9
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 09:53:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcaSMRWrIEvHLK+exnLzPcbuOc+3XQoXOy1nZN4UIZTg1ghmwk9k3tFEIfnfXhrFKmXJh8IuptVv0T2dkdyliXSoOy9jnJBtzxOKiXqHjwq6mNI9EyYrv+OChPTVJeV1TmlbnU976DVVnrXRsdDgpPitdbqjwWqMH0NDAtGg9Rkt63Ya9A+6q6MP3PI9R6CtvSjcsxX8T0+d9Sg1JEONMhYihS8Ly5BY9uKNFZJVxqE1jeXMuCPRJJlBvPOSjeq/QNWrk0HJkMFC8K3W6w0p12Lxw0B/LtufSMm3VCiT4GknVZBeQ7mrujvf506WGycOnFPm/7CGZn1OHKXGOjJy6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XModjSTqwOkKGTVosnbTiWoKR34ttQvJWVrUBD0UH9I=;
 b=duwg2zN5bVpW3kCEQUxLr/VSV/4pBWBc+NmT+ZcdxwMoAxJJHaZVpmYKz9hiZT91kXmjlMMSOs9i8RCl+MHZHczC/MN6K3+3ggvRuxoUIiS5qSFhRFtddBPs2ZfNhjXfKfJi0LCthN7Bi206rgNtA56c8oJrzi5W2QSfXuTSaSFokuKm3fSxiyQuSAYAC5ZzYOrvGZ3u2JUoCE4rga03jOTqmOkBY4C9yGp93iFr9yEgv3hgdVI3ME9SPvm85QqvXUfmcNbZiGzJvVcDb4rFpuWOpl4ppi8FyWsj5Q8GrPeGbMBRp1mUAD+pWNTDvYbBGAJZb9W4ucteoCl48V8Rnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XModjSTqwOkKGTVosnbTiWoKR34ttQvJWVrUBD0UH9I=;
 b=UsENqfwmBPmxzzhFfHMBJBiu3EjeG6sXv64N6+fkdBJ4EFqRx4X9KS8Rg9PysqgQiQGK5LiFfc1CKzrQDHC1BnemHNbJY0FG54OgcBH0icw9hjMwqKbwJberX/7CrSNbWpf6DH8E0mnKs1PtG6MQ4MGos0wwaM8z4P+SOzcoy3FodGww79QzqF/K/GWv8UM+2Pl2L1bfurLv1L3jDFmagxjSno9yIhHZ0QEnZiR/ag5EvC2Cxlx37cbGsCHyiXokmDQGX3d/XDbg9YznJoEPU9IREgdNGEP+rWBgHBzuYIlQt3i4H0EAByfXSjCo7nmzRxoA22mmV71U7fCcj05ZBw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by MA9PR04MB839208.eurprd04.prod.outlook.com (2603:10a6:250:103::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 09:53:26 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 09:53:26 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Fri, 30 Oct 2026 17:54:29 +0800
Subject: [PATCH v8 05/15] drm/imx: dc: Flag CRTC status in GERNERALPURPOSE
 register
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-imx8-dc-prefetch-v8-5-c4f81afd4533@nxp.com>
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
 Liu Ying <victor.liu@nxp.com>, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|MA9PR04MB839208:EE_
X-MS-Office365-Filtering-Correlation-Id: c48ee4ba-7196-494c-2700-08df366ba4dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|7416014|366016|1800799024|10067099003|18002099003|22082099003|921020|56012099006|11063799006|261028144727099003|261026140227099003|261026121527099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261009221727099003|261009220027099003|261009221227099003|261009223327099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: foprWdHkMRcNtzcghL/fruhDIGs0Kps3bGGSlqv04dP6Cums0OtGU+CaeSYRcOWHa78tg8TmUlxvlKEqoYFmcDB7ZHzURYH/SiLd6H1UMcnfLeWyDG+PY6PqES20PqFxdQ8MHYiBbl7w/9WZKxurbG025lKRquNy+LRUx17nVsKrhXvZHQC3wtXo5lgaBnDjWym4KrDbLz5F0HU4gsrIVUbxJp/unriAZOyTnWxikLbi9Zvre1ylYg9YPt0FcOsUEOdzjbCM52lSDnJUEvnye0gs0uH1kP4gbUeo07Jazn7VAeEdNkzd05G326ZzhDAnLqXdcQ7TJFJvpJH/zs/yIjHjxIwZDBDxcAqipoIM99ncmc6hjSwDC8EZPvTb1nX4W4WGP/TqR5zIlVv2FknVKIqkBArnwJqQ0BUpvoxXG8jF6x9xSRIZirtIZ0+1WeSXzbeQM8ckn2AMko7m8LzXgU0O5Ho23wx+KX3N0aSpwsR6cRBEYND3AJ0lIm30fwCn1CQDm3EtLt14s/ky34iMfP4cstb3SBypebbZCkIYoy3x861O1UJY/JknMHH4AbI9o6ELosen5/7k2SSoW/JRW/Xb4uM92lC9hvoiBzirwllBmwQztJolCYbxq/eJyW9FUTJh77n+tAnRrudTddj/Re8wbWmbOTAjUeteQYM7+Ur/53HcoHcf6P7YvOurFnebbE22f8vRvNrVrlzeknBPFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(921020)(56012099006)(11063799006)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261009221727099003)(261009220027099003)(261009221227099003)(261009223327099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0lZb3JvYmUzODRhTEZBdzBuUkt5bjNLcDRXcFdIQ0JWNnU3bktlYmcxM28v?=
 =?utf-8?B?Rk8wdmJNWlBsdmJYRVprK0c5NnJTR2xhL3hkeUdxZDh3b1Q3emxLNHA5RGow?=
 =?utf-8?B?NC9SSWYwRS9vUkdteFFZRXJKTjJJdWhtNDQySElIaU54cFpHcVFRU1psMGxX?=
 =?utf-8?B?YjUyQzVMejRpVEpmM2RNaWUwRkJJNWs5YXoyMUh1WGNvZFdHdjQxK0s2cEx2?=
 =?utf-8?B?Y3V2bTJlLzZIR01nc09JTGRDVE9QWjVxSEtFM293SGNLcTY2UnMxQ2o3N09H?=
 =?utf-8?B?Ui9SbEFnVWtRWHJFUzRETVBSK3NxUklUbkkzVDVsV1FOVTRaVGxpMmRwRDZF?=
 =?utf-8?B?V0lUUUppaWo4MUE5R0RRUkR4VE9FbGI0Q1NmalRGTmZnaTlsb3o5cUc3SU5l?=
 =?utf-8?B?UFREclpyMzUzcDdKMEJkUlRjMFZ0OTRGdVJ2RkNsYVMvdWJKUThmZFpUenRQ?=
 =?utf-8?B?UTRHSmlUREQyY0pWaTVIRW10Ulo2a0VvU2RnWlZhY3B6WmpVRXExV2dzOWkz?=
 =?utf-8?B?aE9iMG5Ga0ZvejVCK3ZJRlNXV0RJUjR2aisrc21iRUQxVHdoT3FTaHhmSW4r?=
 =?utf-8?B?UGgreDhHVUZzYjRBRzlROEhoUWFaRzZhVTFXalZaci9jMUN3cTRERGhRVmdx?=
 =?utf-8?B?SEo2di9XL0V4d2s0QWlCckFsMkczdERUTlFBMWdhSlpvSmg2REd0bGQ0ZFEy?=
 =?utf-8?B?WVNuTEdmaGg0cmx3NnhhZGNQWHo5V1RxNFJpaUVXelhIZURFQ3V0ZzdkK1Rn?=
 =?utf-8?B?c2w1OTFZeWVSaEJtQXVLM2RkQzY3UDUyMjFva3F3LzIwVlBFdE9zaHYwTEJt?=
 =?utf-8?B?aDZTL3dkOHRHUEZ0NjJtbmwrb25CTzQyMm5pcFFpR2EzQjFGb0ZBOUtYNWdw?=
 =?utf-8?B?ZnkvdTJOYkRpdXEvcnRQbWE3NDhtayt2a1BxdDRtQTQyKzBPdFBZTnJhRE9E?=
 =?utf-8?B?S3BHY1Qxb3lnUjIzVHFDQU1oWDlYdTdkTm1iT0ZOS0Jqdmw2N2ZTOEx1WjUr?=
 =?utf-8?B?K0JzKzlYd0Y0UW9IdGIyK1Rra2Zjc1JQV3U3YWhKRHdKb1lxOVBmbDZnNHRK?=
 =?utf-8?B?QkNRZHA5dVNHampkOWh1ZTFQUjZmSWJQb0NOU0VEMlJZb3lsM09Fb2ozc3RI?=
 =?utf-8?B?b21xSmN2NVdRL0JDZTlsd25NSVBpcE1weTFiQUVwUVoxdGs5SDdmcWZJTG5x?=
 =?utf-8?B?dk1vdDNYU3JpK0pucU9WNkU3ZDl2c0t4MGo2MlY5c29CbWVxdHJOVW5zNFN3?=
 =?utf-8?B?RWJmYWwzNzc4eXFBUE5qck9JSEl4UUJ3eUVZYjRyS2pDM3FoUGRCbmpIUVRk?=
 =?utf-8?B?M0pTS0M1cFI5N0ExNUxzUVQwZG9YV1kvM1hjY3kxZXo5NWxIcURHODNNdjZ0?=
 =?utf-8?B?VGN0MVIvaWNlNkMzMWxXYU9MZld6bDc3Mkl5S2ovT2FmOCtvTW9GTm91SGJm?=
 =?utf-8?B?c2hUSDNoMXMvaDQwTWRCYzkwaWRBU3FqbkQwRjJ4MVRGbFRueFdGOTArWU93?=
 =?utf-8?B?L0dqb0svUmFNbWZFeEFJUTk4OVU2KzdhQThNYlpWUVdUYTFCRXduMVQ4SDVz?=
 =?utf-8?B?WUhZdzNZdU9QcDk2MnJoQ1YwQ1FMNFVld3dBQlRqanZLaFhFc0VLVEFhbm9M?=
 =?utf-8?B?Ty8xUjloSTF6MmRtUlJtTEM1THBLUVc5V2V4WmxFYlhCdktyWjJSRWZTR3ZJ?=
 =?utf-8?B?TkRtS1I0d0NhTEJMTEFsd1pVVjgwZzZJZW9yT2pBa3pyZnU2ZEdXdWFVYUhu?=
 =?utf-8?B?ejhUZUlQc0J1ano4SVIvR0s4MG5aOGlmbUk0eXUxclVtL3JjZWEvM25PR1V2?=
 =?utf-8?B?MklKamc4dXJjdGYwdzNwQm1KdHptbTh5a09NWklrUy9XcmgzdWphc2ZLTHZ6?=
 =?utf-8?B?cmMyTUViSzk5K1Q2Rnp6RWU1Vkh1RWcyaTd6MitNbjNuRHZlQU5Fd0kwQ2FM?=
 =?utf-8?B?L0tHQ0pKS2IyWXFsSDY4Q3JHWG5iL29ETU9iOUx5dGlNNkpsbHJDcDNrR2RS?=
 =?utf-8?B?VXFIbzNTMWgyVEFObUxSeU1LYlhoOG96WmR0QnZsT2NWSGFveEVGb2RzZUt5?=
 =?utf-8?B?WmdKVVdQRXMzeUtzSDU4U1FydXdZeTh6MnVtSVpCYk4rM3Z6ekRUV2ZTbzhL?=
 =?utf-8?B?b2pQdkc0MnhFejZ1L21ITGpZM0lPZlB5RUd3UGhoaWtldGpjaktIL0FQL3RD?=
 =?utf-8?B?TTMwNTRTVnAvR2h5clFXR3d6c1ZlQjYwcnQvTklKdWFpT2REK29rbFdCa09W?=
 =?utf-8?B?MkRac056ZjA5eG5RNmNNNjh3dDU5bEJZODc1V2RPcEVuSXBFZjkxUW9mQUlm?=
 =?utf-8?B?dmk3b0xkWEY4VHJUSlVOWDhKYjR0VnQ5Z3loSk1hcTdEb2F1bFVmUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c48ee4ba-7196-494c-2700-08df366ba4dc
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:53:26.5825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IbCUdLChkjBGc/6cHdFge4tc6eEY3DdFM1Sbpze1kU0Vdfim6Gn8OZt83I/fdXSqGtbm/Y/J7JmUK0Nx4Jp5sw==
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

Map Display Controller's register GERNERALPURPOSE at offset 0x100 and
create an MMIO regmap to access the register.  Create helpers
dc_drv_flag_crtc_{enable,disable}() with the 2 LSB bits in the register
to flag the CRTC enablement/disablement status.  Also, create a helper
dc_drv_crtc_was_enabled() so that the CRTC driver can use it to check
if the CRTC was enabled by a previous boot or not.  This is a preparation
for an upcoming patch to disable display controller at boot if the CRTC
was enabled by the driver during a previous boot instead of a bootloader.

Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v8:
- Rename dc_drv_crtc_was_enabled() to dc_drv_crtc_is_enabled().  (Laurentiu)
- Use dev_err_probe() to handle errors returned from several function calls.
  (Laurentiu)
- Collect Laurentiu's R-b tag.

v7:
- Newly introduced in v7 as a preparation for fixing Sashiko AI bot's
  comment on an upcoming patch.  (Sashiko AI bot)
---
 drivers/gpu/drm/imx/dc/dc-drv.c | 75 +++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/imx/dc/dc-drv.h |  7 ++++
 2 files changed, 82 insertions(+)

diff --git a/drivers/gpu/drm/imx/dc/dc-drv.c b/drivers/gpu/drm/imx/dc/dc-drv.c
index 13795a2ad735..9629beaed43c 100644
--- a/drivers/gpu/drm/imx/dc/dc-drv.c
+++ b/drivers/gpu/drm/imx/dc/dc-drv.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
+#include <linux/regmap.h>
 
 #include <drm/clients/drm_client_setup.h>
 #include <drm/drm_atomic_helper.h>
@@ -28,9 +29,21 @@
 #include "dc-drv.h"
 #include "dc-pe.h"
 
+/* General Purpose register offset used to flag driver usage. */
+#define GENERALPURPOSE		0x100
+#define  CRTC_ENABLED(x)	BIT(x)
+
 struct dc_priv {
 	struct drm_device *drm;
 	struct clk *clk_cfg;
+	struct regmap *gp_regmap;
+};
+
+static const struct regmap_config dc_gp_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0,
 };
 
 DEFINE_DRM_GEM_DMA_FOPS(dc_drm_driver_fops);
@@ -156,6 +169,8 @@ static int dc_probe(struct platform_device *pdev)
 {
 	struct component_match *match = NULL;
 	struct dc_priv *priv;
+	struct resource *r;
+	void __iomem *base;
 	int ret;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -167,6 +182,27 @@ static int dc_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk_cfg),
 				     "failed to get cfg clock\n");
 
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "failed to get MEM IO resource\n");
+
+	if (!devm_request_mem_region(&pdev->dev, r->start + GENERALPURPOSE, 4,
+				     dev_name(&pdev->dev)))
+		return dev_err_probe(&pdev->dev, -EBUSY,
+				     "failed to request memory region\n");
+
+	base = devm_ioremap(&pdev->dev, r->start + GENERALPURPOSE, 4);
+	if (!base)
+		return dev_err_probe(&pdev->dev, -ENOMEM,
+				     "failed to do ioremap\n");
+
+	priv->gp_regmap = devm_regmap_init_mmio(&pdev->dev, base,
+						&dc_gp_regmap_config);
+	if (IS_ERR(priv->gp_regmap))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->gp_regmap),
+				     "failed to init General Purpose regmap\n");
+
 	dev_set_drvdata(&pdev->dev, priv);
 
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
@@ -196,6 +232,45 @@ static void dc_remove(struct platform_device *pdev)
 	component_master_del(&pdev->dev, &dc_drm_ops);
 }
 
+void dc_drv_set_crtc_enable(struct dc_drm_device *dc_drm,
+			    unsigned int crtc_index)
+{
+	struct dc_priv *priv = dev_get_drvdata(dc_drm->base.dev);
+
+	if (WARN_ON(crtc_index > 1))
+		return;
+
+	regmap_set_bits(priv->gp_regmap, 0, CRTC_ENABLED(crtc_index));
+}
+
+void dc_drv_set_crtc_disable(struct dc_drm_device *dc_drm,
+			     unsigned int crtc_index)
+{
+	struct dc_priv *priv = dev_get_drvdata(dc_drm->base.dev);
+
+	if (WARN_ON(crtc_index > 1))
+		return;
+
+	regmap_clear_bits(priv->gp_regmap, 0, CRTC_ENABLED(crtc_index));
+}
+
+bool dc_drv_crtc_is_enabled(struct dc_drm_device *dc_drm,
+			    unsigned int crtc_index)
+{
+	struct dc_priv *priv = dev_get_drvdata(dc_drm->base.dev);
+	unsigned int val;
+	int ret;
+
+	if (WARN_ON(crtc_index > 1))
+		return false;
+
+	ret = regmap_read(priv->gp_regmap, 0, &val);
+	if (ret)
+		return false;
+
+	return !!(val & CRTC_ENABLED(crtc_index));
+}
+
 static int dc_runtime_suspend(struct device *dev)
 {
 	struct dc_priv *priv = dev_get_drvdata(dev);
diff --git a/drivers/gpu/drm/imx/dc/dc-drv.h b/drivers/gpu/drm/imx/dc/dc-drv.h
index eb61b8c76269..8283795f3c76 100644
--- a/drivers/gpu/drm/imx/dc/dc-drv.h
+++ b/drivers/gpu/drm/imx/dc/dc-drv.h
@@ -99,4 +99,11 @@ static inline int dc_subdev_get_id(const struct dc_subdev_info *info,
 void dc_de_post_bind(struct dc_drm_device *dc_drm);
 void dc_pe_post_bind(struct dc_drm_device *dc_drm);
 
+void dc_drv_set_crtc_enable(struct dc_drm_device *dc_drm,
+			    unsigned int crtc_index);
+void dc_drv_set_crtc_disable(struct dc_drm_device *dc_drm,
+			     unsigned int crtc_index);
+bool dc_drv_crtc_is_enabled(struct dc_drm_device *dc_drm,
+			    unsigned int crtc_index);
+
 #endif /* __DC_DRV_H__ */

-- 
2.43.0

