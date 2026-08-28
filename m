Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09758C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:22:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C77910F37D;
	Fri, 28 Aug 2026 12:22:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="CN/Lkik5";
	dkim-atps=neutral
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010063.outbound.protection.outlook.com [52.101.228.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6675810F37D
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 12:22:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ay5lygSMG/DbC4pHAaOCSrbPcWEkw5/Rmfhg833sVN1s6zUuQUuOv1r+iyGq3xw9ez+4QRmrzBk1RpudyjF2FAFyhvSql9D8+Bk8O9Co3W7hq+ykARvsUHJNCebN/rDWfrjPoZ7I+1jFdnpOUmJ0PzyjbUKFK1mrmx6bG4cd0fJ4VbyH9GAk6n8bgJuTBnw9bcvv/QcgFjlducHFyunlKtLCtaNbbiYKCv/Ph6v1Sy+c230J7bQaHF8mF2kCIuEzf9YKdNKe/dmAgZyLgxcENCIMyTo38cva9FPqAekzZ2DwF1cw0BDWIVV1cL1p0W+CoybiBDcjiK9cVjd79eTqfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haPcKhI6As3m2XhxMpo72NQMpErc+W1QJfunkACfPMU=;
 b=RV5mGZlg/PKjtz7BQtVBnNT3xHao0iw9MXRO0sztnzLSyzIfO2dPGgmREbHvZyMQ7F/KpnrdOcxDn5iW/bdTnRyj09bhWzslq7x4wNzvHy7mUA8RY+d+TJHKzNLfKnqi4q4v1E7kyzKRFzS8Go6NTpcJXCeCLSluVd3y2XA7WGv1HtH/ellvoQ4awpFJBl+AvGdKkFbE1ZdpGKjBhBZchFGtI0hIplh1rLpZcOAdOqvB0BoxEfHfFNG/hj37qvzxR5JUYyM0n2OK1PLPmi5yWRlPRBpet0NEKrsVROXEav3K458/ZWVXrXP9LpzjKHXyajrGrKbq9ZPpGzhSHRQsjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haPcKhI6As3m2XhxMpo72NQMpErc+W1QJfunkACfPMU=;
 b=CN/Lkik5LX8VWGUi71TvKJjRiBwe3ZC67PL8CQ4pj4UH8/L9fCkVmqKKX/CcCbQkomkSIRHpWhpu4YhgfzpB81af4WlmGgEH4JXiOwfx7R18roqeZmlA4GyIWYcfzbfVn282t2opL5Bh2nVGpUn4ToFbnwiUCpjaVFYPkUcyYiw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TY6PR01MB17444.jpnprd01.prod.outlook.com (2603:1096:405:360::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 12:22:38 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 12:22:38 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com
Cc: linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v8 7/9] drm: renesas: rz-du: Rename possible_outputs to
 possible_crtcs
Date: Fri, 28 Aug 2026 14:21:10 +0200
Message-ID: <20260828122113.1426778-8-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260828122113.1426778-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260828122113.1426778-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0311.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::16) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TY6PR01MB17444:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b826e72-6fe3-43b9-976b-08df04ff0c6b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|52116014|376014|1800799024|366016|22082099003|18002099003|5023799004|56012099006|11063799006|3023799007|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info: sHVMaIgwR/4dC/k7qVedF6T3pVuri5q8gZ5ywRanees6sKrrGwxSLyOZUkn6VgsAWfSQXvVYm5Ey3xV4ivjiWFgijyXZvm0R7QTjYl9hzcMMd1nsvPj0xf5cdgU09fDHrxIRJ8Zjvd/MGttuZV0e1X5kXnfeY8rjihkDrtmDFOP6ujoiwK50/S3DcgcY15NXF1hD6Tixo4zjTW/yHp6OEM6OwousHSIYyDtpqq3U5tm7mSc1CbM55V4dBO6Ely9fdJWkmGaN7lkgG0vgllrqmL14K2T/7CYOBn6OJRCouAYaMuaEHbzA3G72vpR5lN1eu27ngJgLCiH7vp5xl5k3ilk7D96MolLlgOt5PsCR/XqRDWqUathjq1jCJQULhhTBfQSl9x6hUrahSyin9SjlEF6ZhX3OZNqtw8mUK7L4iQ9bsckv7Knrujq3aidl6vcnH6SGDnL0B0GagqaLxh2uevAUJ4wgW7dwrFrl+lWZ5/oyZhngYvFMNaT2n6xiamIKZ+VgKvZ/2ZOYYM9PmZGrD4zshPHcZq1CsX0C7v6QhzA2BPSLWdAoyMyEnzPRDNL7UACD2oJKHncuIzqgXdyKjP9fBaiWSrqhpVxJT5xCaHhrlGDTeRTw6LfG4In8Eb+sH/gIQ8QrCGBhqmS2lbEWu5Qf3s6pEskK/veRcVplBkLE9UCpWTSI1GbJvtX/QtpHXe1MdaXTvQEjsAwkclJHdIangpXZQnHRLBUxO8QG0kA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(52116014)(376014)(1800799024)(366016)(22082099003)(18002099003)(5023799004)(56012099006)(11063799006)(3023799007)(10067099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sd0N6VuTB3ttyboGyv4EESyFtiS4/Tq0JTye9J40s5h0vZ/XhIru5vI0bXA6?=
 =?us-ascii?Q?fDpSR0qOHLbDae3MQL4HXMsFBJDXRw+CM4JyH2ilCSGLWIVSmCdLX6kjgRqI?=
 =?us-ascii?Q?A3GQ3RU85pmvhmhD/aIEzyJ13RHxsksXZ8B3XnKuFwhBmN1nB1uz1qSQmBDI?=
 =?us-ascii?Q?UI9B6xuLg69NbBvBB8TZJfi0QBXpRY0vdC6eMyQaBcle/h82sQ7Ip5BYSA6E?=
 =?us-ascii?Q?jRsisY1n2NomPFOARbZIP1XsAAKienuOb4mkx7O9jt6uCBuUBRP9clPsLD2i?=
 =?us-ascii?Q?+lk7adY/Ap+e3+KMNxsqDD4ubWhIZcWgPBD4KSu5zPJohUNRihaPkmwzgjcY?=
 =?us-ascii?Q?IF7J0BFJrHktQ2KRI/RznzRalnM8CdyR/YWCud+JduG8NOd+ON99AVijzna4?=
 =?us-ascii?Q?/t0D0J2KqxVcQARa5YntbMxDLsD9OptgyvttDbd31BSTdGOYylX1NUJ6sAnv?=
 =?us-ascii?Q?QFhZOcG/zhcNWMRkCTabaysv4Es94/pIsPq7cSNtJWgzdYapyInAQ9Wr6Bw5?=
 =?us-ascii?Q?WR4P3mJ09MTu0nYwLrP3hnRTZgHW6NC94yyubgJ+PS7afU6jvXDbDEw/WBCV?=
 =?us-ascii?Q?mOBPdGoptzO3Noo+I6ZbLh6YAOzLiSuD5edf2RvOZQgzc62zJ64DA2qcHSEV?=
 =?us-ascii?Q?pxCl8YQ+LfwxNt4bQfKkG35BMGSXQW07XULdlPUnMa6d+tE1ffw1WwgFGUtU?=
 =?us-ascii?Q?yhCg7liuE5xm1WXa+8ZC2TwaG/4sgHxaQQjgvnV/OahdCVdq8bmc0phtHOeY?=
 =?us-ascii?Q?j79mC3QlaOZrEw76P6AtSm402VhHlzD6ZKU87ChELlpCCtL3rGLWvaTtebu6?=
 =?us-ascii?Q?y22MYpziTVfUs/3OIL10UR85PDUh0MlBWlqQkOW8eqyj9zR1RPo6OQJqs0R9?=
 =?us-ascii?Q?kp2rPOFW4UNw7ocWXzuZN16LNtxzh9nKNVtDQsRGn1c/fzJ6VUSZu71ZkFqN?=
 =?us-ascii?Q?Zf1e0yYmG0OKBYMBHHDz21XUT877rJfrhK1cOk9zL2I5JmlFNX8VSGD3b1na?=
 =?us-ascii?Q?i+VuknuaOLltW/kFHPRPHwn1h3Auz3fhkK1e7FHRcOInWRsCpRTfkvARiTqB?=
 =?us-ascii?Q?CVmW+MpeWhFEEcQ7fJyYl9wtg7C6Y3Jm3TzAiryTDnq1KuvMCTqU8wpkxapH?=
 =?us-ascii?Q?wZ/r5ZN5XLzoyEE/uVFUjrH/bp5CYusdbbJ1bp/purjd3KBP5o1VhQPj9Hly?=
 =?us-ascii?Q?p40B9Ht+z5iaWRE8Ah5ZFb7JbdzlLTS+LlRYyNkOguhV0q021f52vX85mu2n?=
 =?us-ascii?Q?iNOHkDv3HnhT6AxtKmZeA0+P/iE8RskFxRQOgVTxhmWt9Wtu6q4CUAbNemmU?=
 =?us-ascii?Q?VewA3PedhfrztnMbbSniZHhu9rkV89TM+vAfZ/dbbQjahQgjhQQGaDtgCDAO?=
 =?us-ascii?Q?YD4JVp9RBg9MLWM4u83keDKm1LU5qDM2DvdjbTyz4Mf7GtYPqH+kLnFFgnzb?=
 =?us-ascii?Q?iRUX9ACDZLeGUUsFq0RrUZ8KD7qGPU3MgAI+aMqOiKonbSyn606AETbaggtb?=
 =?us-ascii?Q?tZwmCognpThJuiaIOYf9epvJYMCuIfbHlZSXwvrooTyMY0xUwoHfzo2TDYuQ?=
 =?us-ascii?Q?Di43u2NczDdv2tcmzdfBV5XgM775+WpG+HxNdstLgssEDPMW3Z04sn6xWP9B?=
 =?us-ascii?Q?gsIsditzjglO2wa/66bNbo10n/HmfJsxotCWf7o3bBOW/E2meU5KAxBSxPEf?=
 =?us-ascii?Q?nnY4UKsPKEM8SUlpU9WwR9Ssckp3lLqGHMoo/RnJFrA7NImj/LEpRq4lyE+U?=
 =?us-ascii?Q?FQdad6WiMTk9IxayleYiEepYM+8/jmvz7dx263fGwQ/GDHEf+PDe?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b826e72-6fe3-43b9-976b-08df04ff0c6b
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 12:22:38.4428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCoykaHTFCKro8dOzXLB3Dv15pFjPuecqBRw/a0VTSAWacT00fKcoZQrPLAseYgLhx4+/M9AwMSKKfr/I5rQl2fOYxixwXi0fZDNark5y+UlMu6nxwPTIOn7gaL//d7i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6PR01MB17444
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

The field holds the mask of the CRTCs that can drive the output, and is
assigned as-is to drm_encoder.possible_crtcs. Its name says the opposite
of what it contains. Rename it to possible_crtcs, matching the R-Car DU
field it was derived from.

No functional change.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v7->v8
 - New patch.

 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 16 ++++++++--------
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h |  4 ++--
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c |  4 ++--
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
index 3b868d4ef8bc..0c08701b1502 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
@@ -31,7 +31,7 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a07g043u_info = {
 	.channels_mask = BIT(0),
 	.routes = {
 		[RZG2L_DU_OUTPUT_DPAD0] = {
-			.possible_outputs = BIT(0),
+			.possible_crtcs = BIT(0),
 			.port = 0,
 		},
 	},
@@ -43,11 +43,11 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a07g044_info = {
 	.channels_mask = BIT(0),
 	.routes = {
 		[RZG2L_DU_OUTPUT_DSI0] = {
-			.possible_outputs = BIT(0),
+			.possible_crtcs = BIT(0),
 			.port = 0,
 		},
 		[RZG2L_DU_OUTPUT_DPAD0] = {
-			.possible_outputs = BIT(0),
+			.possible_crtcs = BIT(0),
 			.port = 1,
 		}
 	},
@@ -59,15 +59,15 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a08g046_info = {
 	.channels_mask = BIT(0),
 	.routes = {
 		[RZG2L_DU_OUTPUT_DSI0] = {
-			.possible_outputs = BIT(0),
+			.possible_crtcs = BIT(0),
 			.port = 0,
 		},
 		[RZG2L_DU_OUTPUT_DPAD0] = {
-			.possible_outputs = BIT(0),
+			.possible_crtcs = BIT(0),
 			.port = 1,
 		},
 		[RZG2L_DU_OUTPUT_LVDS0] = {
-			.possible_outputs = BIT(0),
+			.possible_crtcs = BIT(0),
 			.port = 2,
 		},
 	},
@@ -79,7 +79,7 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a09g057_info = {
 	.channels_mask = BIT(0),
 	.routes = {
 		[RZG2L_DU_OUTPUT_DSI0] = {
-			.possible_outputs = BIT(0),
+			.possible_crtcs = BIT(0),
 			.port = 0,
 		},
 	},
@@ -89,7 +89,7 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a09g077_info = {
 	.channels_mask = BIT(0),
 	.routes = {
 		[RZG2L_DU_OUTPUT_DPAD0] = {
-			.possible_outputs = BIT(0),
+			.possible_crtcs = BIT(0),
 			.port = 0,
 		},
 	},
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
index 6e1e4222d2f4..66ebcbaf0687 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
@@ -32,7 +32,7 @@ enum rzg2l_du_output {
 
 /*
  * struct rzg2l_du_output_routing - Output routing specification
- * @possible_outputs: bitmask of possible outputs
+ * @possible_crtcs: bitmask of possible CRTCs for the output
  * @port: device tree port number corresponding to this output route
  *
  * The DU has 3 possible outputs (DPAD0, DSI0, LVDS0). Output routing data
@@ -40,7 +40,7 @@ enum rzg2l_du_output {
  * of in-SoC encoder for the output.
  */
 struct rzg2l_du_output_routing {
-	unsigned int possible_outputs;
+	unsigned int possible_crtcs;
 	unsigned int port;
 };
 
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
index 04f51b9d1dd8..21e34d99b12d 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
@@ -290,7 +290,7 @@ static int rzg2l_du_encoders_init(struct rzg2l_du_device *rcdu)
 
 		/* Find the output route corresponding to the port number. */
 		for (i = 0; i < RZG2L_DU_OUTPUT_MAX; ++i) {
-			if (rcdu->info->routes[i].possible_outputs &&
+			if (rcdu->info->routes[i].possible_crtcs &&
 			    rcdu->info->routes[i].port == ep.port) {
 				output = i;
 				break;
@@ -475,7 +475,7 @@ int rzg2l_du_modeset_init(struct rzg2l_du_device *rcdu)
 		const struct rzg2l_du_output_routing *route =
 			&rcdu->info->routes[renc->output];
 
-		encoder->possible_crtcs = route->possible_outputs;
+		encoder->possible_crtcs = route->possible_crtcs;
 		encoder->possible_clones = (1 << num_encoders) - 1;
 	}
 
-- 
2.54.0

