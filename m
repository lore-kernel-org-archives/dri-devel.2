Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA13C5DF87
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 12:26:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3820110E263;
	Fri, 21 Aug 2026 12:26:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GZtN5i6N";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013001.outbound.protection.outlook.com [40.107.159.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5904B10E263
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 12:26:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmSOGjtTc4bUDhLgL9WZlylSN4BYXxsZ/WbSz7jylcTtCUPfzuSCFWaPiPqwdL7pfXdk5SPe2mevn5kdgw9gm6MlCLiT0V9V46JfdJp9aCAQu6i2Nrd0oW0YGELFDUbMV13zi8RIHA+9DFD5bP2AhETIB+Eygsc/+ih61/TXM6vaqpeIpMwyTS1C8v9V82+rHhWGLnFT41dmRKYra3tkXF5TgXwl0+ibKeEEyXCcPB4sUik9ggtuJ1hXr1HVRqBuoRAo4ILLH09I1kUdVYgeOtICQBbaHmtMOZYsdeZjv8v+EUx53IUyQD7Udjq2wpSCKjcKI8+BdO4FQaBqtbcwxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeUTGI4sBiv/atNV7ksmJDHElcZjr1wREd3dlCZT53o=;
 b=d+4nYYjjXUQUVnptu0YJ5Mlnzjc+nh+DubkSNDDZSqqRj+vShSRzd7BSqcemNlBS1RRgD5eBgOKEkz2PJ+4d9HtDheCfEDRl1YLdOA1Eqq3eqLet8tpj6siq9E8lJfSGJ0S7CO3Hlg4hGtfJ8E7GTmpn5K5tBS4qfP7Bkz7e8M5X1djqh2w3Gua1A6Oq5gE65FKlil/9wo5m+jXRNZDoQc+pYFv+eIwSCnZXqVRDRyY9jSoS8grFPpR3QT2v40NDaVCc8JaxKxjkCo4vM5sXzOK913dpHOgKAHPqxoS3apjaWO5VgWYakRmkUL0/QTp1s9wX2Eau0i/nom1Y9fXCpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeUTGI4sBiv/atNV7ksmJDHElcZjr1wREd3dlCZT53o=;
 b=GZtN5i6NQOUbGdSC/GzpaRjDPkUMooH06MHVwoJuIZbcuR53sqisR0kAyOyqn39B4old2M76sFzpfIltd+I6CnUS/0i69HkyBHj8W5/5a58Wj08uWcQ+17bJG+gdgWGpbeOdI5B/D5iEwLT7N6sMP0JuRDOMVe9LsQlWQnBLvPI5nVtj8T3a0/iYXLa42unW73vRLE+tXLMavE+2x+pOY9e96H5fdiPu0wcgzPqo9puPD9BuItkMnlJltgyWYeV/l7lYm6yucqNjH2ByqCafZJCaOIjFAHG7KPPX6UTfrmqCJLES05FcrALchRLN8oUOCE6jd6VnPNlyA8KayJ3fdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by GV1PR04MB10427.eurprd04.prod.outlook.com
 (2603:10a6:150:1d1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 12:26:31 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0339.007; Fri, 21 Aug 2026
 12:26:30 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Ying Liu <victor.liu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Daniel Stone <daniels@collabora.com>,
 Leandro Ribeiro <leandro.ribeiro@collabora.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/imx: dcss: Silence blend mode not set boot warning
Date: Fri, 21 Aug 2026 12:26:06 +0000
Message-ID: <20260821122608.2077746-1-laurentiu.palcu@oss.nxp.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0021.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::31) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|GV1PR04MB10427:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d283c3e-eb63-443c-aa14-08deff7f6dfc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|19092799006|23010399003|18002099003|56012099006|6133799003|10067099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info: 15SWnGEpLmR9F3FtmEtCYehUADtgOFLm2SspOhylQvq4wr40DqyJyoysY9uFnBG5OqFM/ld4Rz1Q8wApAbFQUOD+QhHHsnXjKSWC3J9k+YDd+RQPaXjgCQS9nvnKKzeGFocF6fdiZrnB2tA2wNa2iK/T9BwjoTCGQmYFVWwZHoEyIamc+L9uF+FPOLdDAW5bJGG4TaCys7nJU0cw/SFrdz/SCyWQCKTwgNIjtkl72mkCoky9rtWGPWmOQIyj1lnYaiGpV2nnkUPEF8B4MNx8sx++zFA6N3sVfmy6rAuxP2YEMOIVtuZWXIbKo+fXPcfffztMwaLLqbFooDJ7mDVkMinHoOzsytTLA1t5jOP1qiE8dFLoM96KPT2lYIcMLghNPLEs+Pvr87Zx16WXw3MHpJ/RxlQy+dlLSpAxu7w1TvR8MiBhjuDDVYiyInz9xUOkyb1KZ9/PEsimUD2QocFtC1rTXnXBK9q5vG+GL7+3hVkgWzrHEHoHiVkgr2zmkH9Gh63s6kmQWGPdJsGP1r/ISCanGM+3Hg3dK4kyroCBhC2rbY3zFjCJx3d4Jdgi+ZiN9TFljcEnO0amyvoQfYQWkUKNurE/GphA8eskbagV5BZ++R06MS+x6xFTjTcb9TNHwINzrsbgLmVAoSMLVX+ESE+XCz3sgRBZhLDNH1uLekrHjcBmToWAA8XPlK2kC33BGSCfcpVnkjp+46clc8jhhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(19092799006)(23010399003)(18002099003)(56012099006)(6133799003)(10067099003)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5PP90toWNIwTEB1URQ3fRbHl+igu3Gs8pl5yoJNmRNYIodVazS+JMV6tJx1i?=
 =?us-ascii?Q?ST6CFPLaE/n2KFWWIqg3jmU6t+WddyvbKKY7fi/+Orow34IBl1586f3hF0lV?=
 =?us-ascii?Q?DMPubin5Hk2HHIDTddvXoKocAhLggLHLYWeGtloivxGNK0GrDT6TnSyjVWBi?=
 =?us-ascii?Q?59clLBkuNtJ3mrQxSowNtpRHrbWzh2umWuHWaBWwZqujf/ObipYvh6rUGeNd?=
 =?us-ascii?Q?/8hOp9WSCaFKLujxX/g7ZuRp24Lq1IAkXCOqM1nWDnJj4lLbKVNe50J2VvYq?=
 =?us-ascii?Q?4DyLJblVBBdAbv2oOpC40Ol2sBFLp09kfqXNL+0ATjuu5MO/JF1Ee0FDYVBr?=
 =?us-ascii?Q?CIxVRDfAaGIT3+o0uR1nzQ19oUEpyXKKcGWtZakj0F1DcFbLlo7gT5B/vghK?=
 =?us-ascii?Q?J7Wrnb2nQXtHMt/3i2TTCYL61Q7Q4Xxoa73ZoGL0aBfO9Fca7EP05kR2HokM?=
 =?us-ascii?Q?KvqAgpDgc7B094xwUa3xZefOJ+KBM8suY/nzDQWqNVhAPV08dOodoSgL3mGP?=
 =?us-ascii?Q?dvCG3wo4+x5CIACBlnsSFhbH+SugX7x1P6IPfZ4XKW+0k7NfMmFjK+hpqAKp?=
 =?us-ascii?Q?0tkU9e+9rDmkxXbdYujWrh/Jkmwy5vP6txM3YEZahqvz7nhaXQLzJgWq9v0y?=
 =?us-ascii?Q?LJ+mmtyOWYONfwxh6ptH+VgdOgKM0DuV7JTsJyVz1PNysjRyhfA+kjMLuimb?=
 =?us-ascii?Q?QMQ0/bJFsb7AN6xvYONarMssgEGa+iLxWo1A7YTpgU5gaRsiJ+iRFOaIS+tN?=
 =?us-ascii?Q?pk9jvzhgXzytFkh+8XMg3b9iDlJDcCWlc9L1Zxq1zDtR4Fi1KwbZkkDgMdeH?=
 =?us-ascii?Q?cHFPgEr1jJvl9iVrU+ljvjHIZFhRb44j/m4jyOh/clPSm4gBakMCmVYI2OYV?=
 =?us-ascii?Q?BulDmzOrscFM/xRR5BX0G5bR89yB/zGQpafW6vury3xbXlW/glhR+XmvHPu5?=
 =?us-ascii?Q?ZANUUsVXK0+vTc/w0ihU8wbUICavO/G/QiNq3pbBot2hEL/U44W24SwBIHZH?=
 =?us-ascii?Q?gVCaakSJeP8DKAHw+gh/PuHCq+chf/HTWIgJNok5nq3ZdltkTeG2Ozbi3R7Y?=
 =?us-ascii?Q?Ihap43/8PJaAZXqIQ8AGawtNOmHD5MZbxbB0zKBc5QNZqI+4DztWVXtiEkdt?=
 =?us-ascii?Q?r9ihAqIcnBhayVWhT3PPk16ZTH45bIFYH3maY/Lrt3L5u67+OM6NDYE9awcQ?=
 =?us-ascii?Q?oWuV0UJxSr1Zwuoe0zWO3Ugu/xxPvehtDJMX47gTgJ3fwVygfmOg4RbwmzRR?=
 =?us-ascii?Q?9S7gdoZBDL1M/WRmo8Aq12dlmhE6JovJ5ixCJzDD38E0fgQCfvVflUJxJi/k?=
 =?us-ascii?Q?e1IbrSkH+CZ5IRotiPQv1d7lIYghg9sNiw+qsnrB7vjdiA8yqb/X86jgwlso?=
 =?us-ascii?Q?Fh6sbLh6vFyqtsL1iNFR6/h3ibm9REpmZxRUQ3ud2wmC0i+wn+XGQdMJrBYP?=
 =?us-ascii?Q?sct2hDnPpIujxLOA+jt5NNtCT+sQ9vsK+coIR9YRXBayvKGkP8eu/8e2ffAI?=
 =?us-ascii?Q?zRLKd9av15Og8DVg8PXAUgxLh2UPl85urfhnLNso1IcLDKJMYWmWVE7Jy/hf?=
 =?us-ascii?Q?G+zNzTaMPBUIyNrpP4UDBFXochBRLQI+Oo/ipkJhLNKcV1pnyzYC+2FrOXBD?=
 =?us-ascii?Q?7qI0wEj28rVMEKwh7AX1QXZkaDidQhCYpEbests2SpxpxqLKlrL6x6IA7jkJ?=
 =?us-ascii?Q?+oGIE/OVbkk/rpWfkAf+3bdHCaQbiXbvte5Jb8KMgH6Ta061pml3fSdrE04C?=
 =?us-ascii?Q?3caX2PhKp91IUPNI5uS60mVcRDG7sc0=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d283c3e-eb63-443c-aa14-08deff7f6dfc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 12:26:30.7601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnL1+3rC8itDuX+n5i4OanO/OweDTF7447Tr7jxWH9YEKJvajIZ/Sb8A7BWViK9qIJfg0OVht2kmtn8C+Q4huw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10427
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

This addresses the following warning that appears at boot time:

--snip--
[PLANE:39:plane-0] pixel format with alpha exposed but blend mode not setup
WARNING: drivers/gpu/drm/drm_mode_config.c:872 at drm_mode_config_validate+0x36c/0x520 [drm]
--snip--

The warning started appearing after the commit mentioned below was
introduced. Add the alpha and blending properties to the primary plane.

Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 drivers/gpu/drm/imx/dcss/dcss-crtc.c  |  6 ++++++
 drivers/gpu/drm/imx/dcss/dcss-dev.h   |  3 ++-
 drivers/gpu/drm/imx/dcss/dcss-dtg.c   | 12 ++++++++----
 drivers/gpu/drm/imx/dcss/dcss-plane.c | 11 ++++++++++-
 4 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/imx/dcss/dcss-crtc.c b/drivers/gpu/drm/imx/dcss/dcss-crtc.c
index ab41759a9f52d..8358219c94c0d 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-crtc.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-crtc.c
@@ -5,6 +5,7 @@
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_blend.h>
 #include <drm/drm_vblank.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -202,6 +203,11 @@ int dcss_crtc_init(struct dcss_crtc *crtc, struct drm_device *drm)
 		return ret;
 	}
 
+	drm_plane_create_alpha_property(&crtc->plane[0]->base);
+	drm_plane_create_blend_mode_property(&crtc->plane[0]->base,
+					     BIT(DRM_MODE_BLEND_PIXEL_NONE) |
+					     BIT(DRM_MODE_BLEND_COVERAGE));
+
 	crtc->irq = platform_get_irq_byname(pdev, "vblank");
 	if (crtc->irq < 0)
 		return crtc->irq;
diff --git a/drivers/gpu/drm/imx/dcss/dcss-dev.h b/drivers/gpu/drm/imx/dcss/dcss-dev.h
index b032e873d227c..9b3bd2f3a7ef1 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-dev.h
+++ b/drivers/gpu/drm/imx/dcss/dcss-dev.h
@@ -147,7 +147,8 @@ bool dcss_dtg_is_enabled(struct dcss_dtg *dtg);
 void dcss_dtg_ctxld_kick_irq_enable(struct dcss_dtg *dtg, bool en);
 bool dcss_dtg_global_alpha_changed(struct dcss_dtg *dtg, int ch_num, int alpha);
 void dcss_dtg_plane_alpha_set(struct dcss_dtg *dtg, int ch_num,
-			      const struct drm_format_info *format, int alpha);
+			      const struct drm_format_info *format, int alpha,
+			      unsigned int blend_mode);
 void dcss_dtg_plane_pos_set(struct dcss_dtg *dtg, int ch_num,
 			    int px, int py, int pw, int ph);
 void dcss_dtg_ch_enable(struct dcss_dtg *dtg, int ch_num, bool en);
diff --git a/drivers/gpu/drm/imx/dcss/dcss-dtg.c b/drivers/gpu/drm/imx/dcss/dcss-dtg.c
index 6bbfd9aa27aca..21da9d3cce4cb 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-dtg.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-dtg.c
@@ -3,6 +3,7 @@
  * Copyright 2019 NXP.
  */
 
+#include <drm/drm_blend.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
@@ -268,17 +269,20 @@ bool dcss_dtg_global_alpha_changed(struct dcss_dtg *dtg, int ch_num, int alpha)
 }
 
 void dcss_dtg_plane_alpha_set(struct dcss_dtg *dtg, int ch_num,
-			      const struct drm_format_info *format, int alpha)
+			      const struct drm_format_info *format, int alpha,
+			      unsigned int blend_mode)
 {
 	/* we care about alpha only when channel 0 is concerned */
 	if (ch_num)
 		return;
 
 	/*
-	 * Use global alpha if pixel format does not have alpha channel or the
-	 * user explicitly chose to use global alpha (i.e. alpha is not OPAQUE).
+	 * DCSS supports either global alpha or per-pixel blending, following
+	 * the coverage blending formula (with global alpha set to opaque).
+	 * When the pixel blend mode is PIXEL_NONE, the per-pixel alpha is
+	 * meant to be ignored, so fall back to global alpha in that case too.
 	 */
-	if (!format->has_alpha || alpha != 255)
+	if (!format->has_alpha || blend_mode == DRM_MODE_BLEND_PIXEL_NONE)
 		dtg->alpha_cfg = (alpha << DEFAULT_FG_ALPHA_POS) & DEFAULT_FG_ALPHA_MASK;
 	else /* use per-pixel alpha otherwise */
 		dtg->alpha_cfg = CH1_ALPHA_SEL;
diff --git a/drivers/gpu/drm/imx/dcss/dcss-plane.c b/drivers/gpu/drm/imx/dcss/dcss-plane.c
index 1746dc5d4b642..06413d0612349 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-plane.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-plane.c
@@ -209,6 +209,14 @@ static int dcss_plane_atomic_check(struct drm_plane *plane,
 		return -EINVAL;
 	}
 
+	/* DCSS supports either per-pixel or global alpha. Not both. */
+	if (new_plane_state->fb->format->has_alpha &&
+	    new_plane_state->pixel_blend_mode != DRM_MODE_BLEND_PIXEL_NONE &&
+	    new_plane_state->alpha != DRM_BLEND_ALPHA_OPAQUE) {
+		DRM_DEBUG_KMS("Both per-pixel and global alpha not supported.\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -336,7 +344,8 @@ static void dcss_plane_atomic_update(struct drm_plane *plane,
 	dcss_dtg_plane_pos_set(dcss->dtg, dcss_plane->ch_num,
 			       dst.x1, dst.y1, dst_w, dst_h);
 	dcss_dtg_plane_alpha_set(dcss->dtg, dcss_plane->ch_num,
-				 fb->format, new_state->alpha >> 8);
+				 fb->format, new_state->alpha >> 8,
+				 new_state->pixel_blend_mode);
 
 	if (!dcss_plane->ch_num && (new_state->alpha >> 8) == 0)
 		enable = false;
-- 
2.53.0

