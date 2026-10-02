Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E5ACA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 20:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E231810E6A2;
	Fri,  2 Oct 2026 20:06:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KZflapuM";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012014.outbound.protection.outlook.com [52.101.66.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54DA410FA15
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 20:06:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNEN3vg6JwvH1o8IXR/g+5PVBHWv/McpTGymt8vs/4+R6XArSQ1JcechSDLiePsIWTJIZWoFNJNegpJLCPr0PZaCpoczd7Zx3DOr7xFOBn9yi+Q3HNyDUlLm5Z3zk7pZpjAWhCZws4alDyOorA9eOI9h4Nwt69AgqoQN8R59xkhAKBQhI18rBuR+1gVRgBGzMw7IznvxQ3GxOhzMU+aO3eQPgwMJicm2t3yJTvimhLVDVqdHkVZVlT/ix98r3TSm2iRBalKKc78E6KNGnRBsCqKeH0w4FqybyOIC5jz2eNs7ZdUw66XTZ/zsaCwVFc9UTej6EqANe8lqsUv56n9rOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QI/fjNFVRyEZWaDWgR9PfSYQ/D1IK9NlKozO8HjetlQ=;
 b=na9iD7XcoTpiRX4hl8FPmG5hsSM3afCYnSLxehI4ePO8HYjWueMVnfYsEJLQr+fShLdzUEGsqOcekby3ZPqejcZxOugH1Qj2l2UM8WOesW0d8grWUdta5UcnfgOAAK/TEiM14Je0Vam5vKKQJjvaWrSKbAd+0aL0uMshEZAkO8aogu6V1dWW0mVHtsdmf+8qrT69zmNbuDPe4vHNWRrAVQ8hGJh/2aHBxR/k7YfLWXSthqU8D9/TKOpX/wuB+zaITc2XXSi88dF5DUQbPJRrU1p83jm4YsURpwcWZgI3njfXCYe6wA7bxYG/izQMqlQtGtyqvxYpvEM8prNTnduxnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QI/fjNFVRyEZWaDWgR9PfSYQ/D1IK9NlKozO8HjetlQ=;
 b=KZflapuMBVyPqTyM1ulO1aUXLxK19OMVmCVDGBwshDtP0+Wdf2d6L0fxieMnhgI4WWA35lS/7O2swBoHQba1aDTcK+dZ5PabmF/7e9thT+GXWpirFBZahLjzP2bDcBiMG7xdDf/50dpTwEMMhnINcHqZZaC1a+9cQCkc53X9ZPWg7JYxfxcDSgnPtyS9idbjLQOfIt+EOgmYMMOCpS4KX1IOZ5XKYVcIqTUop+oVVDzwX/J65yxMIXKKnxxt6GluCgrSI0UJ0XJhaYKPxZiTX019KpDpvlNfFTJ945sjsMuMFIq98IJAbULOx7oX/i5PNUOLD2XhiYPtHo+7VqGR9A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by VI0PR04MB11548.eurprd04.prod.outlook.com (2603:10a6:800:2fb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 20:06:40 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%4]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 20:06:40 +0000
From: Frank.Li@oss.nxp.com
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR TI OMAP),
 linux-kernel@vger.kernel.org (open list)
Cc: vkoul@kernel.org,
	imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 1/1] drm: use dmaengine API instead of raw function pointers
Date: Fri,  2 Oct 2026 16:06:19 -0400
Message-ID: <20261002200620.230735-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYZPR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:930:8c::26) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|VI0PR04MB11548:EE_
X-MS-Office365-Filtering-Correlation-Id: a89f122f-148c-4814-25c7-08df20c0a598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|19092799006|921020|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3EyuvsnINZehH0Pqsv3KLVjFZHLtmJxSlEOEXfMtVaDwrcBbmu9O/ZwMFLCMZQSozZLuDhpZBFVgBNv1SLxLq+/KvSU5D9lAC3KAnAotDT0U8uo3vNRiDwyOnkvCl4VThRtzC53DYlSfBhFiQegZvIr81uMHqcsszBFcT9ySJ7n7otlrflqIQyN+AhGp92qgFiGXKwr4PayHnuGFlr9hHs1qHDPAwxdig4MNrDkK1Ak2WZtGzWZJ0PvpFmw9V3WxkxEMf7miEPlaa7eDTA+QvHMGTd9JGdhoJ+01U4LJps2h5DRDF+BUscfdggRfgbhABjyPyxekdlS+vp3jsqGUOrY2ISITARbujp2dsL0+Ewmpt21nf33mQlCvfu5MVnao7tdcaChFf9Y4NDLA9TpeEKMs3YfBri2aCnnzACudPbrDRoFll7u1YfglZbIhfNwg+2oRWJ2Q9k+0aXNzW8dxZLT5/L9qRt8bkqnS+Oqog3EqaxPxlDo/Ks88cx3mNgMD5VnVVORodPkIpqCwp1Z0FHTRk4RYgP6l+ClZgEHYDkLtTsx12TtHzpWoB4uA1+ldCDnDnuxD6+cVT1WG+sEVBvLZV9LFtQ8uV5BO9Nh7L1GZGA3y/vryR9630lJJmWyZwp54nga0sCtbwfujHp4dunWg9IoWv1NNflq3pmISnqcs/GvuPhRk7dXzxgjpiNgslUqEKmHaTyQ5oGTBc2ah+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU4PR04MB11791.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(19092799006)(921020)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?luiDZhg8cUEdyhDr5DYjgrx9+9zsjEIcTp9BBNL3KJIkvqEr37XNiyTck61G?=
 =?us-ascii?Q?PHZsD0CMeW9e7FQZF+tu7oUp0uFrLzwkkErzy+PEwERwXGK1W4AvBUIoAZul?=
 =?us-ascii?Q?hPMo7l5TiDIVeAeqcw/UtwIz9gwC+7SB7G/SCNeL+6XNaUVPlTlS8V9pY+tv?=
 =?us-ascii?Q?3nBTKGrgAKBzq37S/JpBoOCNd57nz4rvw8uSuaEwiyVBwYeWypLFtCcp8FDX?=
 =?us-ascii?Q?i9SZBCpCfidC/vApkWrfiTUugNRNt+iWVaRfKJHsixvR9SF4ARfmN3cscMn2?=
 =?us-ascii?Q?mGLx8eJC/eNjs8/C5w1eob0PhO6vz4oPRCfjadzhOFy8xK2YWPDq9/cS6A5Z?=
 =?us-ascii?Q?O/nh6oYOa2zwo19cG9IK1T3VyE9G0XrOcew6zp/lglwzfhdh+aP75E/vo2LS?=
 =?us-ascii?Q?YzJQ3Z3b1qKEL0TAG8OKIoPE+Vomi3qGeViD/OlRBrzMhvs2OM23KWSrRbZu?=
 =?us-ascii?Q?wLedA4bkpDpJhH6umietk8KETNlA1/X3jy3PJX13CBv8CCFvl0MbcxSP5klp?=
 =?us-ascii?Q?0ALaLcGZjLjqn8k79P12MwW30moOgu3VINgMszOxBgf/W+YserqKEG3ZNQve?=
 =?us-ascii?Q?1ufOMvfSqRROMMTyRahkmJE1ciBQi7LvZaIkqyKSff1PcFTHxpPMShLpe/wf?=
 =?us-ascii?Q?AuEgAniNNRV39dt2VOF/+Zmqjc6MnowqbB3k2c5AmlKBOJcdYB0Y4KwavZuq?=
 =?us-ascii?Q?AlvQRcxVijT7rMetJYxnzTDSoEkriG51GChAlgblc6+2XYZw0dmTqJFXCx76?=
 =?us-ascii?Q?0d6N5LR2EkVKC8u5OglPKHRlqrYGJKmKPfJ8woqIdDeSlRZMMksLK6wcJIoT?=
 =?us-ascii?Q?N68J7xLefu3r9CeU1jKRKLGIkHCyz8Mv1Ul/AhRs2k3r7dZS5QPvcWww4frr?=
 =?us-ascii?Q?N+yp1hqyRTNqzxhChhhaKMBE3NobUeyQj7kbZ23ZQ3naXZbv3QSB1eHBq7Lh?=
 =?us-ascii?Q?3JNVdW6pUzHnZeN6DHlV3rLiAh1XCea/4g462YdDKqyeF0fH/f566KZrCWqm?=
 =?us-ascii?Q?u6Q5XIN3ccVV3s+Xd0zv5Mlu3rDClt/913FlHTNtsfo0zyEn9RDI7KMo45cU?=
 =?us-ascii?Q?NH6d5Vp1OQxdSy+tCnSWEO7xL6cMtJNWgPEVG62+mA34A/I4SdaVSEkToJvY?=
 =?us-ascii?Q?VqeN/7e/dEauNJCUenEfTWCQRMVBaoe2lWGabv/s+S73l5bDnbx2tVHT9PpZ?=
 =?us-ascii?Q?oyx/LGcG1qbGJxBfxOPKvXM8Vmmm784XJc/JLdpqVVqJy9tuDnRQ9W1Fx0Ce?=
 =?us-ascii?Q?Z3E2NSu3yU7Iufx2DatHb1J5S08yrjDKX3wOy4FWNsb/+gbJ/Ck53O/nmxU/?=
 =?us-ascii?Q?3mhJ+rAT2au2VdRxmj/kHdgRSeO1bvkVsEqIH3UST9OrkpKfn0uQU+bADCD/?=
 =?us-ascii?Q?DXINXQ0z6SYXlKd9KGTWqEGUl/QP8o6OhOUvsGeprYkX0TEfKV4refQrxkrK?=
 =?us-ascii?Q?rQpamdDkkSuCBNpsMiQzNr7g6AueL9STbafPBBJpV9N+++QFrfHi2WLPiSwn?=
 =?us-ascii?Q?Yz+lSTaTDLy2eHnRn7sSpX5yr9xq14k1Q2P6ag4dvQKdrnUdAY4TAPI4D6i7?=
 =?us-ascii?Q?VJUsmn2LG+GKSUV+2AtdVUu+Avief3D/99mVHAm8YqXWM1WOUc3Eac5kmfRT?=
 =?us-ascii?Q?6WHA/y6LfU1vzTot8Y2uH+1i4fv5NQ1dh53EzABneaK6JASmouAi06yQmg0T?=
 =?us-ascii?Q?kgyNjExtvMSLXQbDGDunVQKSBxjDAziPFyb9FnmTd9nNuvvO5nBaYN0xByVa?=
 =?us-ascii?Q?h3KZ2OKdHWcGKMse2vxJY+syhBAJdW3x3hvv7CippcBGo0tTJjXf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a89f122f-148c-4814-25c7-08df20c0a598
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 20:06:40.1774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qPw9BxqUgcfbMxxhnSP7TNSiFgsVAFwQ+foEBqnsaHw6+MsvTefwUu4QNB52gO3oaank+pMV5wXpl9lX/M1z4hi4d4Oo4zdYYkV9en8NKi57H+0SH+xiuuTUXgfkGyPD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11548
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

From: Frank Li <Frank.Li@nxp.com>

Replace direct calls through dma_async_tx_descriptor and
dma_device function pointers with the proper dmaengine API
wrappers in vc4_dsi and omap_dmm_tiler.

Assisted-by: LLM
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c | 2 +-
 drivers/gpu/drm/vc4/vc4_dsi.c            | 8 +++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
index a2c702b831a7c..c5dd350f937f4 100644
--- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
@@ -87,7 +87,7 @@ static int dmm_dma_copy(struct dmm *dmm, dma_addr_t src, dma_addr_t dst)
 		return -EIO;
 	}
 
-	cookie = tx->tx_submit(tx);
+	cookie = dmaengine_submit(tx);
 	if (dma_submit_error(cookie)) {
 		dev_err(dmm->dev, "Failed to do DMA tx_submit\n");
 		return -EIO;
diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index 0148f2befed14..b1626c2d3a582 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -628,16 +628,14 @@ dsi_dma_workaround_write(struct vc4_dsi *dsi, u32 offset, u32 val)
 
 	*dsi->reg_dma_mem = val;
 
-	tx = chan->device->device_prep_dma_memcpy(chan,
-						  dsi->reg_paddr + offset,
-						  dsi->reg_dma_paddr,
-						  4, 0);
+	tx = dmaengine_prep_dma_memcpy(chan, dsi->reg_paddr + offset,
+				       dsi->reg_dma_paddr, 4, 0);
 	if (!tx) {
 		drm_err(drm, "Failed to set up DMA register write\n");
 		return;
 	}
 
-	cookie = tx->tx_submit(tx);
+	cookie = dmaengine_submit(tx);
 	ret = dma_submit_error(cookie);
 	if (ret) {
 		drm_err(drm, "Failed to submit DMA: %d\n", ret);
-- 
2.43.0

