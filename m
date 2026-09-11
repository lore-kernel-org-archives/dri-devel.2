Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCC9C88E58
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:36:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05C4810F656;
	Fri, 11 Sep 2026 14:36:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sSycsoFw";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013036.outbound.protection.outlook.com
 [40.107.162.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 433C710F62D
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 14:36:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyuIDVKiiu3uJWP6advUXKw91uk0Ts2sdwhK0F3PBeUNZ/JpBPL2o2O/Of+F/ABfi+FyVzKrNFL16vBIVBH2/8S44J5eBtmWFD3TMxzb6E0EV7Rmp99SB9H2IUk+Cxaj4osU26SlzhlethfBd9qzKiabg7PiZhnhliri2pUDacERdx3bjIJtvCYoLyC9xu/JRzFPhDpGUS5hYIxeUh3gP3yR5CgrPih6u4itMFVFx2PnRxH7Bw2k7ALqTrWZGvn6REuLQetUVJzxnRtgyFHDEkc76jxS+znpeb+/y7gRx6GAH+/C2OgXBdA1e57aL9+FtcX9Z/HZnj2fy8cR3Xz1NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YitNaMqkfGDN66QtW7Iz4Re0M2oaBJ9gPiZ+9XuUQhI=;
 b=aNTbSgFBT5+vrZ/flK/brkuIsMd6m38zrqPjNhGqevDLZvNgp7JJdp9Jge7lxW8fafDYkVvzGlw+VC70bkzr4dMkB2P+nlHkAcEB/P8ELxkkfxIp5v39Uu5PotUe+lHHVUCHNtRVVXccCBamy1/hACiU5Z39eNT2vJg6y/DFksmBQI+X6hvzjcVzBaOxfmhtJDPJrN/NL7Gfvh4Ue3vOHA8eaQd1Jz6r+0DcM0EetrduYsZUKh2v4aRLfRhD++h5LVD11JBxo183jg6ngtGlawtvrMy90w6si+sDx7+xYlgtc2oAy2Ci1N1ktUYCNvlke9027Ut2usX5AFZyIs6RaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YitNaMqkfGDN66QtW7Iz4Re0M2oaBJ9gPiZ+9XuUQhI=;
 b=sSycsoFwfihLSOiPHP9CNgGiiVFmgSnMiB6PI/ZKzcSj2DlnshFXzVtd3A2b7s5vmRswNcmzDeGsOe7AMoj7Er6A9X9W7PI229UYyLO28ijSKb/YTfVMR1Uxw2jMoeUHIHr5CLK4XeWbOhWO5YMBErCUcPezEhhJD8PO7Be1crUyDiMdcRvaucMycIo8Ju2xBLcmBUeWBs46ljO+GkFBY/BIPbmAxQ5UAXUhZRrXSciWzqvW47AlV+/ZjpkwFNShI1lWmF5lAgRVeUwy6eS6fnfQnwYCtdKYl9S6zkTxxna1y0A2/4EBu5OsvFbb4B6Jn4vHmPKtw5bS8xaXC4ibZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by FRWPR04MB11200.eurprd04.prod.outlook.com
 (2603:10a6:d10:173::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 14:36:45 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 14:36:45 +0000
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
Subject: [PATCH v2] drm/imx: dcss: Silence blend mode not set boot warning
Date: Fri, 11 Sep 2026 14:36:36 +0000
Message-ID: <20260911143638.2674753-1-laurentiu.palcu@oss.nxp.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0020.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::25) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|FRWPR04MB11200:EE_
X-MS-Office365-Filtering-Correlation-Id: 5396eccb-6fdf-489d-3dcf-08df10121a4f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|376014|7416014|1800799024|366016|10067099003|6133799003|11063799006|56012099006|18002099003|921020;
X-Microsoft-Antispam-Message-Info: Bz7++HRifECbAwpumh1SHWenZNrjugliFEW9t90qJOirSz5eZtNKf8IJMQ7d31A6+a63cb8bGsi3i59k+tZTijtUAo9C7wkbcr1l/YIWvVSimdNLmD+VlchnsGP9dVSyFXXTTo6j0fUR5/AsBhoMHvigIQgjm8Ko+q7OfUoKZaQpwZk0inDu5fzXS5U/SuXZVwQda5jkhM1ik5Uq50MsucSVsnL6UE8SyvetgsB9DMZ+9ygazDzW3v1eTZXH7/x9u3Z93R+MguTp1WlD++pI+XYLBJ2l/9lNWN30g7Pr3R3K0+fF16VmkXGhIMEcuqqpQ29on+ZKRd8wvG70AY27vIILb3jSRw5TVwYin0/bFT+6N/UUC5912jSFm2pa8LiWZ1yaKh4wW1YvxzS3RezWOBYnAYFcf6/u9E7hoH8YreGjfcput6WW4wg8dCUFi6UXysrvIfRFL18bVX2O5IcLjTaeynl1BMWRoXxcSuK1q0yTtSkSNE8JWRSCaCWhgB9j2R5bc36IUW3E7JZOxuQ+SP75Eb24b89co8nVh7T4Fyd6mT6Is+JQOAv31s/ReHr7cP7bnRXq+Stc8FLHBCZXWovYX2e8nBXJL2OgsXIl8d1YzBiep3StTIs0WZVCebfpE/caOEjBQD42LLvn1GObahuALJ8tMS/G89Tpob8BlR9Z3BesOtr8NYbJsSAskMN+aSqVANwQ7lSxsXiY61SNWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(376014)(7416014)(1800799024)(366016)(10067099003)(6133799003)(11063799006)(56012099006)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k9BUOpKCeNQeFq2q/BTJsr9sPK3RERlvQpxkqonE7i6BjIC+U7pnxavIETBy?=
 =?us-ascii?Q?F8hsIL/eIOc9bhRcZalX2G8GfXwhQvqaSkutActmnVMv8C2XMyvMR9yQonY3?=
 =?us-ascii?Q?0H+xeQPIPv/Edf5qfaYzH2juP1O9wj8UbaCKBCfHjYPkKOJV3jN8JihD6yBO?=
 =?us-ascii?Q?FojdqgyuVro3dEIJ9szb+ijMP6arzUFq1qn6VLE8R9WTcMnlBWNEQ8dKctvD?=
 =?us-ascii?Q?RqLam3vxizPwf/OKfE2N9LFYE+gvIjsEsTxS8ccyZ+GvU/6yRRX0NMy4CVLY?=
 =?us-ascii?Q?39TeW8HVPW4YlJceTvzf+84dkwItvHElvzol1BBwLqyB+2prl7TAZ/tRDEK1?=
 =?us-ascii?Q?VgqVQv1ZsW4kqQujmlt9iMge8nMkPmWv/HZm4f1lF/lq5qaDqKDgOfQVtEoe?=
 =?us-ascii?Q?LXCLKsWtXK/QeNtliY4Nam4wH7DeUU0fHHBx0PM1+H5svohTqAJ2j8DcVP7s?=
 =?us-ascii?Q?pcuGdqdX6EH+U2WW9wd5RcMsS7YpqHS/8geBdhcTBLbuMVJZcBgKBEmxYn06?=
 =?us-ascii?Q?yNbpU6qIazzkN0+MhTbSH86kZZsZp2Wngs8Yx9Jb4xSISqSxvJoyIilYckg8?=
 =?us-ascii?Q?F+DdQHWTC+XrtkjP6KDVQXoIHKm1SVOwyiZon3gtni/I3ol3ucpdz+ScJfIE?=
 =?us-ascii?Q?xppgbXOSBs9t+dvQ0mI2fvY7bfVZyQcp4zkpEu3cYZm0t0cYa5drHv0NggdW?=
 =?us-ascii?Q?d+MWjWNvPHOqhFOk75zNdD45JlPcMPGBgUn3tSwZqk8z2HeH9/Wn+aRk53CI?=
 =?us-ascii?Q?q/C33IJiOYzxivDbs1KVSpQI3VtysBIW1iGMM1Hf6jjSlERmJOJedTv0nlAM?=
 =?us-ascii?Q?E9aF/s+mv5wutMRSfaEkGs7+YokuX3YxN5vKraTRmT5ecS0jiT2Qv2UrVVnA?=
 =?us-ascii?Q?AOM9H2NFaZ+aISsiX72dSQWbHFQnH0qTIv5opsjYHPH6Bk2ggWmpKNT3xFLl?=
 =?us-ascii?Q?ax4LIv0v0RIdTlb7/PaW2iMdTbE6imoN8WZWxma0eFJJGxVUTlxrXuIUPAI1?=
 =?us-ascii?Q?zHW15ySMrxsQ2T5VEBP+kXR9+8IZYsdgB4APHXPIjyl8OyoHDC0wDYx9CaLW?=
 =?us-ascii?Q?ZU2gz4lfy2ziHUE4agn8nm3J74Px3Zl9RQvM8jmIAaScFgsjoyBXYgNaZyW+?=
 =?us-ascii?Q?+IjjzSObasmg0mO+EcK9RYAc5AgNRnMw7bB2sWlWOkoPWxfQvnfHzu8Uiphi?=
 =?us-ascii?Q?7DoByIC5Iw81oTbhQYd5xxduxC6QWj19PvBogC8yduclWDSv7vsn6LneGyJN?=
 =?us-ascii?Q?T0CRZs4Tj4WoPOiAdQPx+nauc3vRRWJv4cIU4qzfojh+TXkOeuZd31Dbj2oh?=
 =?us-ascii?Q?mvpN+1HuLXUJH/l8vCNKqFA36+V7pI1MwAU6nJcosC9MNXHFqMxt7OMOj1Av?=
 =?us-ascii?Q?STvoLV4WzBR2PCjRVEUmuz/w2PjVBcdNa3G4hUBR3q0MjoV1Z472vxrrS6Xm?=
 =?us-ascii?Q?XbL8g/9OCFpu3iESQOlkSyUXilBLrEBq35/mjkyUPZkokWTb8ERRcd3WaA4a?=
 =?us-ascii?Q?H4Mgf4ZBD6wPUEMYPwCVRh7jc6Svmz1leralyvaMRMmc55Dsi856n/Pt27Mf?=
 =?us-ascii?Q?PvncbMCswBAqqaJsN7XNfVyr3dClv4R5DPYIisIlrW2L1CwynrbgreZWzWHW?=
 =?us-ascii?Q?9R10G8L085EAOdOGnQ0RVTgQjC4DWu/LfXyPXX4U8EUMHevxuAcmXk41pA30?=
 =?us-ascii?Q?xX3ngwSNirWISWK3fpKg5/HLs33/EDdfo/B/7P1kSvU7Ct+B+FREV4UrKtPi?=
 =?us-ascii?Q?emm78vpNqy3XTH74Z/vshpfOFr0hEPI=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5396eccb-6fdf-489d-3dcf-08df10121a4f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 14:36:44.9252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVullCztGECLYO6SudxMux8L/e97N1Arjs4tfxCiT4hm4s6kZNzK72wcLpISbwpM5tntfRXd5qvv9wrpZ3RrXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11200
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
Changes in v2:
- Also check alpha and pixel_blend_mode in dcss_plane_needs_setup() so that
  setting alpha is not skipped by the fast-path in dcss_plane_atomic_update(); [Sashiko]

 drivers/gpu/drm/imx/dcss/dcss-crtc.c  |  6 ++++++
 drivers/gpu/drm/imx/dcss/dcss-dev.h   |  3 ++-
 drivers/gpu/drm/imx/dcss/dcss-dtg.c   | 12 ++++++++----
 drivers/gpu/drm/imx/dcss/dcss-plane.c | 15 +++++++++++++--
 4 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/imx/dcss/dcss-crtc.c b/drivers/gpu/drm/imx/dcss/dcss-crtc.c
index 5e9ee3f09d51f..193ee688cc777 100644
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
index 303e93fd036c1..f991c35d2b993 100644
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
 
@@ -263,7 +271,9 @@ static bool dcss_plane_needs_setup(struct drm_plane_state *state,
 	       fb->format->format != old_fb->format->format ||
 	       fb->modifier  != old_fb->modifier ||
 	       state->rotation != old_state->rotation ||
-	       state->scaling_filter != old_state->scaling_filter;
+	       state->scaling_filter != old_state->scaling_filter ||
+	       state->alpha != old_state->alpha ||
+	       state->pixel_blend_mode != old_state->pixel_blend_mode;
 }
 
 static void dcss_plane_atomic_update(struct drm_plane *plane,
@@ -336,7 +346,8 @@ static void dcss_plane_atomic_update(struct drm_plane *plane,
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

