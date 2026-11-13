Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E95606A898
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 12:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=T271CeCk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A977511232C;
	Fri, 13 Nov 2026 12:22:04 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010004.outbound.protection.outlook.com [52.101.229.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1BB51123CE
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:21:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EsDCwLoDLdn1tdrWvIkAYD88AqSEucQh8Uq9Dn9SQDUzY2KTUDUKvt4sf004G0Lkx1Rq3zq9weiJLBhreZCVxig5KGlGlMh89cEddoeO8rYGGB6zeJEEaazycDDGiKVi4iorC1pxSdyMx9fcja+l98y3s/3CZ6i3tHgj1poaHICp9ErghGB3mPqrPdHYOiviwgiHl+ODOiRJDszCTB+IgC71vFscaf5H9ntIkRaGUqp7wZDwgCGCryfi6bEByczKoZ5jLx4fJZ79sdhNZKM2JNuqossdzbpO0hOQHvSFMEZrxO/pY8r9EesJjjdhEhpAeaN51xGZ6joF7P1Qoq5ULw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9FiFHDvCIcGjFT5PTZErNbLItcrWR1xxpNJnefAYxg=;
 b=AJrUmNH5Z7WeHk88PvNEeGvh2FuWlyjddTzBuhZGQXsZ7NWz+zEWDSWFtl+1IHWeBEb7QbzrAmUc7Pq9X8NRxgMLLkafdR8kd/TOtNcL25w3H2Sq2dlaDLdX5vasfOu8CvMmYvlrCWlnNr9bphCwouauBE63AqA6JuqCquxHgPpj2+ncpJPI2+oB/YQfdDfyN1oFNnfnU3CMLsN7ySoBP4UvblrOHesRMf9W5RI97s1lzMIBGkD+avsArE2PYycDX7LJBHhVqsOG5keZce2I6IBIcES4nt248yC4yfqPrJ2dAoL0OIfZBQn8FbkTUaKPjdgBcVmjYvE9nhvBMuNC6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9FiFHDvCIcGjFT5PTZErNbLItcrWR1xxpNJnefAYxg=;
 b=T271CeCkjtNiC2eUmrkgP3gWbPzdv6nAvbLm9L56QnDwyBKlIVPIrXDNry4VxsUdavuM/uX1C9n40n6WnaAbkaPTigBxqKtgZsBwKQylwyRvT/a/hDyoRp6vjsX2iy1M5xuvW1ttNirwfZYmIKGZHjZ4EhAC89N+23PwPT8HqO4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY4PR01MB14799.jpnprd01.prod.outlook.com
 (2603:1096:405:25e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 12:21:56 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 12:21:56 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
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
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v10 11/12] drm: renesas: rz-du: Add RZ/G3E (R9A09G047) DU
 support
Date: Fri, 13 Nov 2026 13:20:07 +0100
Message-ID: <6d8398d85bea5f9489a0d5e63f9faf4b60e7c294.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
References: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0038.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::21) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TY4PR01MB14799:EE_
X-MS-Office365-Filtering-Correlation-Id: a44e015d-b6b3-4592-97aa-08df4180b514
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|52116014|366016|23010399003|18002099003|22082099003|6133799003|261009223027099003|3023799007|11063799006|56012099006|5023799004|10067099003|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261022075727099003|261021121427099003|261026121527099003|261021123027099003|38350700014;
X-Microsoft-Antispam-Message-Info: kPBOtDrCto5W+jwXY3VOsM/3UixfP4LjqcQRh0+MDZHi2tJzKv+GRI/P3dfWyotyEWrjSUeKmnZgxmB0fqXKZqKFYDiXjCgWTii7MRIUWdTZ8YcuOX0x02da7XEfGxL+NLaV2xuGeHPGXMuN9AJv+qLv6wWke4xetnZi06sMjJszWZ6f167NZja0gtvxoQVuyhfcx5qri3mlij0MgfLWUUOwAwIvKw7tGjaAqa2pTUGNkKE72jSjBnMnyN3X+LrGao3R2qcD/uv8G2CJcEVfU++soeFzcdX9H24km1ByvkBmdq34kpV4PYhEqHxPnF7bsOSKa1AOScIXBvbAvbXetfiJQXAzdUAccFHg4K5wpdoLuhpEgbK3c4HQwF3WnyYVfGwvwK/c7UF9s4UaET+4htdssy0dJ6sfP6KsZC4E2A4DlBrmNDFGDa/xOZk3pBiC+EmwUUQ+cjewfqRrMp2utS8kEKFjQGwAO6xOjqikdFrKaIkKEavQGbQIv5poH/krzY3PVTeerKeXHvT/tSgKn3KBCozOxKfpocT0iFWC8QEZm82bMECNiBftQ5hhcanIVLCLpqCcYNOIQ0RY+TKuUulbunhJY2nO/tLqRaeMbdcSpNEScywa7KyPatwWjS1BWWFgLJW3dcol/zzb/GEXuvXOWf+wopK2mNeFX6DKhDQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSOPR01MB295138.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(23010399003)(18002099003)(22082099003)(6133799003)(261009223027099003)(3023799007)(11063799006)(56012099006)(5023799004)(10067099003)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261022075727099003)(261021121427099003)(261026121527099003)(261021123027099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EH4IL5exVurZBVjLaJYKY0u/858TNYrlZH0GhaQQ555KRx7eM/sEq3Jf9Ymu?=
 =?us-ascii?Q?kjRjXq6Db9I1R5X3AXn7ni/oUvAl/JTVlLOTFd/yxdvmAUb/vpzG9C42FbuK?=
 =?us-ascii?Q?XcHJs6KhVbk5xBAFotzjx0ERzLbDAdo/bKuBtNmlMGapCmSRT6+gmqSOvK1K?=
 =?us-ascii?Q?42lL23hxmh21ARilf9fEkSiWXp6mjFxLHcJrL0r3GWutDfYxbUwrifib7JOT?=
 =?us-ascii?Q?NYBFBe/V6AljlR1M+nuKHbtJ4JgAf+y0IUz9FbVwvfBtqezNBA5b/vCcsKJX?=
 =?us-ascii?Q?MSL35JD4ou9B7IeWRkPH/6U09vBqRwoA8O8NFOr4MyTd8LnNZj3VqvJJ3C8b?=
 =?us-ascii?Q?FNZFPIme4RqWT7lxiXxmmNWfZs/8tyGJHJgUjDzqKQIGBWaVBOCDD2yIinMr?=
 =?us-ascii?Q?oOqq9FBHOcewmUNcin2WzzQtSw5pgvwg7A+o7wO7C4028go/JhrOQkmIKW3R?=
 =?us-ascii?Q?m1odzMJtuqYQ92q/VXcLeNyYSBriXL37FjdXHdqDzlzyHmfTDvpkhT3oYG9C?=
 =?us-ascii?Q?Bz7xRBsJmURqj3qOLBoNcDcPaR10geUUY8yHNJfjRsI0BiAsrTti0F+ojrR4?=
 =?us-ascii?Q?pjlULLON2U4PXckIEyjXQ4c514zcyzJ/dTye4OlUgltGK7NJsFUlAyzO27dw?=
 =?us-ascii?Q?sn8GYSa95OvsKTiUTl7IAcU1WGnU0J0iA2EDnkhDBtqOLsetGw8OlgSYKyeG?=
 =?us-ascii?Q?fAT1Di1fGSlqwaL6lmkmwWOSrxDBp2jxlluiiSbY8oMN7ENmQsAdc/IHqaOu?=
 =?us-ascii?Q?J4SAFjxHnsPKHMp4ZXExDOCvag3sSS+qg8TXtGuOKDq29oChul5wjV669/0V?=
 =?us-ascii?Q?rv4Jy1yrMYDSKC/ILnrE3oQjL6IF8uOUdrJ5CaP332Rs7NNJc2BNYD4ibUT7?=
 =?us-ascii?Q?K2UqYWsF3H2k5PbcVnKBgg9KVWGK/jtlUro9U2VGuhjnse42AhBBFGowW5XU?=
 =?us-ascii?Q?8unYi+d51YaTBoO+JCqUInzl7v3I0WEW2BqWwglaFKFSXxNrBxWabSiasci4?=
 =?us-ascii?Q?Q5Hng1veeTUYn/fausZTTdrmsn+Bp8UkDOM4r1ITHEBohFAqyxiT1Uh/Fp5z?=
 =?us-ascii?Q?SRKkPlwud+wDkxYFM2JHCdOVT+92jyM1JX309C3EVBB9enrfjdF1i0G/idyY?=
 =?us-ascii?Q?M0ZtLeeDZA+55IfnuojOWdQss/QamSdGlfETjtTIDXnezfex7MB8PVBem4Ae?=
 =?us-ascii?Q?jZVovnzTsuimT44MGUpSXm48rHIYNX2ezfgkzN+uwUiAPhtkH+zGe37TrK2F?=
 =?us-ascii?Q?38vUw/sCAULrrICyaX5Z2fWkq4gzjL2qMaW9SfjC7875lK3Z0i6rBbwN/qZg?=
 =?us-ascii?Q?SbXG6dMqN2P/zBdAMBEXEN824ZXLqqSlfJdvF+DeGQWDibs3SJ9SCV1KxIOH?=
 =?us-ascii?Q?1TLBS6Wi5G8XFoLWAgB5hPWqEpJiNon2LZxeWyWxGLHP/ldsZTD8zY0Vj5JW?=
 =?us-ascii?Q?UYYav4bjCYKYfdbUUREI2qErKcWT0DNrj1fF29q6TtRDROKM4QOBMQsfojzF?=
 =?us-ascii?Q?NfPsg/i7/uj1jDM07Kp1+w176YubUB8G+c7BL0fM453xLxHtGrJmPpeS2a7U?=
 =?us-ascii?Q?HxfI1P4ACYZmp96rdqwRKGu4Mbxi74OXBgI5mog1f7pn81AsDIDZ/ECbyTxH?=
 =?us-ascii?Q?+fBHSQ2sGnKbfvPBNlHVuZnjmBN4dHiLC1GIS3fKSrhPAMu8j+u2TVrXdOEo?=
 =?us-ascii?Q?h7DmZhrRFSCZr6G9mUGLvDGkYKZsaiAtL1oJe4Pr6m/xfDD3ajd+LiccXma1?=
 =?us-ascii?Q?ZFmePRc9HCjNIFBKhNQVPKUH/RjCP6qn6QoqLkNll0qBqZvYoEuG?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a44e015d-b6b3-4592-97aa-08df4180b514
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 12:21:56.2701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IrUImqSzS1jFPOmPBHG3EMNuDS9MHaD42VbpmQl8Bha2JuKm6c6B90f/NgLCHEvdPCOU+0A2QjZKG7aShdlOYcIQU3SbXIBOxIgyXPH3+hMA7TL4IvhhNxftiMho742q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14799
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

The RZ/G3E (R9A09G047) has two DU instances which can both drive the
DSI encoder and channel 1 of the LVDS encoder. Expose them through a
single DRM device.

Request the LVDS duty cycle for the new LVDS channel 1 output as well.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v9->v10:
 - Dropped rzg2l_du_subsystem.c and the separate DU instance platform
   driver. All SoCs now go through the same probe path and the first
   available RZ/G3E DU instance acts as component master.
 - Split the driver preparation into separate patches.
 - Reworked commit body.

v8->v9:
 - Added newly architetture support creating an ad hoc component
   driver for RZ/G3E display subsystem that embed the 2 du instances
   into single drm device.

v7->v8:
 - Modelled using ports/port instead of port/ep.
 - Rebased on top of RZ/G3L du support [1]
   [1] https://lore.kernel.org/all/20260826174854.199139-1-biju.das.jz@bp.renesas.com/
 - Added mode_clock_min, mode_clock_max for parallel output.
 - Improved commit msg and commit body.

v6->v7:
 - Removed feature flag usage, rebased on top of T2H/N2H LCDC series [1]
   [1] https://patchwork.global.renesas.com/project/spl2-reviews/list/?series=694&state=%2A&archive=both
 - Reworked commit body as now outputs routing is based on endpoint id
   instead of port number.
 - Fixed rzg2l_du_r9a09g047_info instead of rzg2l_du_r9a09g047_du_info.
 - Added bump of RZG2L_DU_MAX_CRTCS and RZG2L_DU_MAX_VSPS to 2.

v5->v6:
 - Aligned ports numbering with the bindings changes.

v4->v5:
 - Fixed RG2L_DU_FEATURE_SMUX2_DSI_CLK to RZG2L_DU_FEATURE_SMUX2_DSI_CLK,
   update commit body accordingly.
 - Added features field documentation.

v3->v4:
 - No changes.

v2->v3:
 - No changes.

v1->v2:
 - Instead of using clk-provider API to select the right parent clock,
   based on the outputs. Just set the correct duty cycle based on the
   output, this reflects at CPG lvl to select the right parent.
 - Updated commit message accordingly.

 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  | 29 ++++++++++++++++++-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  |  3 +-
 .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.c  |  3 +-
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
index 873586f2ef28..bd8f4c9f1f29 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
@@ -79,6 +79,31 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a08g046_info = {
 	.mode_clock_max = 87000,
 };
 
+static const struct rzg2l_du_device_info rzg2l_du_r9a09g047_info = {
+	.channels_mask = BIT(0),
+	.routes = {
+		[RZG2L_DU_OUTPUT_DSI0] = {
+			.possible_outputs = BIT(0),
+			.port = 0,
+		},
+		[RZG2L_DU_OUTPUT_DPAD0] = {
+			.possible_outputs = BIT(0),
+			.port = 1,
+		},
+		[RZG2L_DU_OUTPUT_LVDS0] = {
+			.possible_outputs = BIT(0),
+			.port = 2,
+		},
+		[RZG2L_DU_OUTPUT_LVDS1] = {
+			.possible_outputs = BIT(0),
+			.port = 3,
+		},
+	},
+	.features = RZG2L_DU_FEATURE_COMPONENT,
+	.mode_clock_min = 5400,
+	.mode_clock_max = 87000,
+};
+
 static const struct rzg2l_du_device_info rzg2l_du_r9a09g057_info = {
 	.channels_mask = BIT(0),
 	.routes = {
@@ -106,6 +131,7 @@ static const struct of_device_id rzg2l_du_of_table[] = {
 	{ .compatible = "renesas,r9a07g043u-du", .data = &rzg2l_du_r9a07g043u_info },
 	{ .compatible = "renesas,r9a07g044-du", .data = &rzg2l_du_r9a07g044_info },
 	{ .compatible = "renesas,r9a08g046-du", .data = &rzg2l_du_r9a08g046_info },
+	{ .compatible = "renesas,r9a09g047-du", .data = &rzg2l_du_r9a09g047_info },
 	{ .compatible = "renesas,r9a09g057-du", .data = &rzg2l_du_r9a09g057_info },
 	{ .compatible = "renesas,r9a09g077-du", .data = &rzg2l_du_r9a09g077_info },
 	{ /* sentinel */ }
@@ -118,7 +144,8 @@ const char *rzg2l_du_output_name(enum rzg2l_du_output output)
 	static const char * const names[] = {
 		[RZG2L_DU_OUTPUT_DSI0] = "DSI0",
 		[RZG2L_DU_OUTPUT_DPAD0] = "DPAD0",
-		[RZG2L_DU_OUTPUT_LVDS0] = "LVDS0"
+		[RZG2L_DU_OUTPUT_LVDS0] = "LVDS0",
+		[RZG2L_DU_OUTPUT_LVDS1] = "LVDS1"
 	};
 
 	if (output >= ARRAY_SIZE(names))
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
index 4c2e12206d83..2a5bd00e692e 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
@@ -27,6 +27,7 @@ enum rzg2l_du_output {
 	RZG2L_DU_OUTPUT_DSI0,
 	RZG2L_DU_OUTPUT_DPAD0,
 	RZG2L_DU_OUTPUT_LVDS0,
+	RZG2L_DU_OUTPUT_LVDS1,
 	RZG2L_DU_OUTPUT_MAX,
 };
 
@@ -35,7 +36,7 @@ enum rzg2l_du_output {
  * @possible_outputs: bitmask of possible outputs
  * @port: device tree port number corresponding to this output route
  *
- * The DU has 3 possible outputs (DPAD0, DSI0, LVDS0). Output routing data
+ * The DU has 4 possible outputs (DPAD0, DSI0, LVDS0/1). Output routing data
  * specify the valid SoC outputs, which CRTC can drive the output, and the type
  * of in-SoC encoder for the output.
  */
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
index 45f980ea3c20..60709e0fc601 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
@@ -80,7 +80,8 @@ static void rzg2l_du_encoder_atomic_mode_set(struct drm_encoder *encoder,
 	 * - LVDS path has DUTY H/L=4/3, 4/7 duty cycle.
 	 * - DSI/RGB path has symmetric 50% duty cycle.
 	 */
-	if (renc->output == RZG2L_DU_OUTPUT_LVDS0)
+	if (renc->output == RZG2L_DU_OUTPUT_LVDS0 ||
+	    renc->output == RZG2L_DU_OUTPUT_LVDS1)
 		clk_set_duty_cycle(clk_parent, 4, 7);
 	else
 		clk_set_duty_cycle(clk_parent, 1, 2);
-- 
2.54.0

