Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF75C61DD7
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:22:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CB9810E4E8;
	Fri, 28 Aug 2026 12:22:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="FnCWKVuu";
	dkim-atps=neutral
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011059.outbound.protection.outlook.com [40.107.74.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C98010E4E3
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 12:21:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGk1/+yQaplu2wQLTdLjWD5W6t6zmkFdoZWaPJ8Vk3xw/zHfRTAavnXo/dRvKuFqVVI8RRD5rbaYipzaLqOFNzSWOli7IWvZv0L1mmoToBtcxlW/ZFo8WJ8gJMceX7q9TLmkoF9JcJHbtkcYlKhuqcl32JvGBH1pD8wHfAgDaqVJlnUnznrwScceTpywBq8i1mUysmEFw9987Sc8O2zuNuV2T8euyHtdVHGMIKD6oNiRBidmhKvpROowS6vU+Vhb9YTsFMhnKdMmY1Cat5PkFLCeL8qrzf9Qmq9+ryWY6as0bkB7ZZxRxZFgtOaXXsk3TnjGBpcydQFt3GcAH44cFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckV11bm08cfH+9rkLpX5R8njGBxQJA0ed2iuzsS1OL8=;
 b=nWmDHW8iSympqaahHV5AkwNDnOhRFD6oWKmpLDs61Phbq6W6AXym11zFu3ELhVWzy6QfpddrTThcRs0zzDEFexn11BLw15RvZiD5dpQlt9++sbok8Zc9X0rJPHlIe99BHalB4VjpU9x6iFLKvi35GgXQR475caofp8KHLI1UMKX/wkngm7qfaIym4BnecViZuDCsZILrH71X4I60HI7yq+j5bVCr/hxiC9kGAQwF8tPpFpDVdtmYi8gMVEmBNegbz7ehio+8oyY6j3FyAbicSyLnOgLTKn9tc2X1xW7c4gOqgNB1f4+EqHSejTnH1dZYDygUOtsdmk9kP5Kg+6n35A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckV11bm08cfH+9rkLpX5R8njGBxQJA0ed2iuzsS1OL8=;
 b=FnCWKVuurOTVsM7nbM9r2dk87i/JIyVTzc/DkQ4GMu9hmlwhYDfEeFjhrMaXTuxFixx9PdRLI3nXJInNjUkWTlxehFGrp2NKDoQufNV8qIzo/JwzahGCWAvrwj6Al4urGUzQD9850A4SYfOeY0YK1wiyYeiFmMmEPdwqDyjEk7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TY6PR01MB17444.jpnprd01.prod.outlook.com (2603:1096:405:360::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 12:21:54 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 12:21:51 +0000
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
Subject: [PATCH v8 0/9] drm: renesas: rz-du: Add RZ/G3E support
Date: Fri, 28 Aug 2026 14:21:03 +0200
Message-ID: <20260828122113.1426778-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0311.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::16) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TY6PR01MB17444:EE_
X-MS-Office365-Filtering-Correlation-Id: e900d074-602e-4989-9c0c-08df04fef08d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|52116014|376014|1800799024|366016|18002099003|5023799004|56012099006|11063799006|3023799007|6133799003|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info: 9WLJ5i8a3lHRReAu/V1r48wHLRrVqgc3z/dTJ5JbyATE2sdnCAOeYXkca8/Ben5JTBaxZxIiYy5JGujnF74kso1/XtoGQR00zOCtfGXJnIEyC6PZ15Lea2Y9qvNtJYo8klCLjAhvvB2I1qbsSJOf+SgUGnDuGePafolWx5zrgfVU/HCyaLX7fuKwTprX91GYj9THGU8s7sP683ndFrt4avv+u8/2mly+p/IRsHgUbxDAjuOoiJ2CH1wjfY6n28yb4X7IEL06JYOR9Ax87NSgfmNjOwNRqDoCojcxnyGjrOeaHX0iNWavHaK/CqjhqJuF/pb6cO+emEqSEGLevWy9KNo0pnbadnAsTpZKDhkXgxzhtnn7LPMTeaw6s6ofz0GaYD+PXBKM1cY+kI/90K2XDHh6zBoWxpm3Yk9m6OSWRina6I8Tem4OP4oFtkc9+GcY+bwZXEdLnxG0AFmGiAKSBAFt11fF5HZRdZ7xZpk6C9yeKw/R/X5+DafOWDWbHT6NIfAHUTB6TGR0WT8Br4Qc/UrLeLJi+rQoo43Y3s2xcbR4jyhOlXg+wEn15K+RkIe+REA7Jj4eNB7/o2OT8cZe4NMxTX4dVFQsyzG4z8alqlErbQn2QmApwgalbSOceu/mfMi317H7tWse7IvXOZXbkNlFWLqF3Q/yx6kKaHpEZusXveKeGXbVAlgmNAXLREEQKep50MlGKylwRSiXHIgMbNW1b1/wOaTy3oCYvS9Lkl8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(52116014)(376014)(1800799024)(366016)(18002099003)(5023799004)(56012099006)(11063799006)(3023799007)(6133799003)(10067099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VuaOLt/WUwJ4bEPQPqPntJp9GVG3SDX5Ui3UgvS3h2WomLdsB8r9m1tH2n2r?=
 =?us-ascii?Q?AX0LRvc1Ph3KlInZBQt5upwd9r5pur8eeUW7SDxafU6CVd6LnM3MsyZDpk9n?=
 =?us-ascii?Q?DmIXllvxqNK1/Xoa53WvmKgjTC7ndsVvh+8MXl/42Q6Vln0XkgqE0WAPT8mW?=
 =?us-ascii?Q?29DkuSj5X3DDoBMIAW4i+azi1vRK4k5pREBN+BiiuRWfYRPce/PtYtgyLKxm?=
 =?us-ascii?Q?6iZwczumBye3pFrw0IGgqmMXtc43InchXL+bQCkMJPjAoQHgcQjxv7A/mHRq?=
 =?us-ascii?Q?xUaIyqjH+BpISwC5jWJl8MLUp2BVUtX1octv56k6Jk31MaLGSPd+i15GLiIn?=
 =?us-ascii?Q?EOCJTl+m79VurgtRoOcgAaVulQGJLn0R5aX1PpgWi8XpU7vKTKO73yULn0Wm?=
 =?us-ascii?Q?SxP14cLU4PaJdWZyfStrMdEaivEUO6+Bn/fpN1Ql0eZh9UJZbBHWvHe5acwk?=
 =?us-ascii?Q?JHChEAIhSdrKPzAtgZz2KnNeu59sP6XORNnRSJfNyFxlIMPUK6sdXXXFri0b?=
 =?us-ascii?Q?MRjjn/iR9dk+pGTasOJRSQ8Ql4/l5uLGQVZ+sVeaM8onBgCNhZWrYfikOuxr?=
 =?us-ascii?Q?5Or7yR4NZkid2/qXvncxLrkYytDU8wr4QmrsiwVAR7s5n9wl6v0qiQmdiGzj?=
 =?us-ascii?Q?cUyx3T1O96QDa2k1kd7W5crBE4bsUUT+bcySCQG2EoN/SQXbST8295zQwNDu?=
 =?us-ascii?Q?cIUf5vJO2AmaIZG5jNSpVISX2Zh9/xifB+ARguWi3gGX9LY1HbGKWIP3NFeT?=
 =?us-ascii?Q?GJOLJaw3GFKx2vY6O1bydHq/MN1eiyiltqTac1zGasIyA4iafyntAQ8vgO0b?=
 =?us-ascii?Q?UOqd4ghsPJgP3P+DoMqQiYl1nq6rGto5ae5O/9XwTximrBtJHCGcW2IX/eo4?=
 =?us-ascii?Q?4UrZPihTcIBXmtVDfWCjGfB68hNikG9P445RwyqoLoZ2RQGVU0UqRV73KCF7?=
 =?us-ascii?Q?Q3NUQ2inFZSUVUQlRNhero5hWp2tg436UWu+OuLs9ioAxjCMGHKbjkSqfkbR?=
 =?us-ascii?Q?mYql0M5A5tFRCp6OvUU6PpueEkfAxLtBXmiLxok9bDpeudJeXUC/yMnSHGen?=
 =?us-ascii?Q?eqitnFGJ65dQREUM1K8MRp67Fb9g8gvu7MpBOrDVRw7CbxAEJKALI5qIA1Vs?=
 =?us-ascii?Q?DcmH5H38Umm5ta5ha7dslXzUqI4h2pFOw6cpWf6gBHIsBuqHC3xnPkcwMqti?=
 =?us-ascii?Q?rgGySoViIjoHes7sKr43SrIFbrKWdJr/rv+OHCBURbycEq9b1VvbwMONEBRf?=
 =?us-ascii?Q?DES8h9EpbuTlZgbnrZLtIhwfKLPN6vZ5SIhdf6usmlCuSQP8b5wtNOYNCLn+?=
 =?us-ascii?Q?5GDX/49gHu+hbVoFZGQpuUPZ0oSbYGe93tTgYF1elma88Q1BG18X5V4DZGhj?=
 =?us-ascii?Q?0LcukOECmzg4MyGzqdiDfLMniFoV2uy7z32fC9Zawd1c3juDoBagE56k1XDw?=
 =?us-ascii?Q?T6F1fww2515F5BqU58pX7tG2FE9y+UKSS5i9eHlU7eH4FNpn7XFoUT2ecUoW?=
 =?us-ascii?Q?Z9xiVi2+3mMsR980e/RYpA/YBIpVeHKbGRA0YWaqNB7PdelKXL6FOnvz9Heb?=
 =?us-ascii?Q?i2hw9yjno/qOXtLBNg3652ZtrEeAFbdJVaiDosSPLiFDyGwObfk1FuQ4UoIP?=
 =?us-ascii?Q?Wz21iH5eJ24mNEHhhduSscoAlt7qpQLZ34skp6hE6CJ2MlIR/aMB9ZrNKRAT?=
 =?us-ascii?Q?ctfS64PIhfHSFVYhAky7XOK+WFzlMBQNln4TW+H0SHnY4wrp+DWEHvfnF8gL?=
 =?us-ascii?Q?KD7/GVq8TTSzOaa6iW1Wv8mTDpz7pmC4d9nMVhgBb/cJWrFevu5C?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e900d074-602e-4989-9c0c-08df04fef08d
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 12:21:51.8462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jNiHkjqkCQoKN4OeUVE4Bv4gCM+9RR7ts2lp244BQbSIc9Pmrb/A8ZL8nyjCnFoL3bOdN1H1vFU+2xFC3W3NljT9DG64o33/Ko/JZxcA4IbTev6kSIaf7Qr98L/WzPDS
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

Dear All,

This patch series adds DU/DRM support for the 2 Display Units (DUs) interface
found on the Renesas RZ/G3E SoC.

RZ/G3E SoC has 2 LCD controller (LCDC0 and LCDC1), both are composed
of Frame Compression Processor (FCPVD), Video Signal Processor (VSPD),
and Display Unit (DU).

LCDC0 is connected to LVDS (single or dual channel) and DSI.
LCDC1 is connected to LVDS (single ch), DSI, and GPIO (Parallel I/F).

The first patches prepare the driver for SoCs with more than one DU
channel: the registers, clocks and resets become per channel, and the
CRTCs are created from the channels_mask of the SoC information.
The RZ/G3E support and the DU node follow.

This series apply on top of RZ/G3L du support [1]

[1] https://lore.kernel.org/all/20260826174854.199139-1-biju.das.jz@bp.renesas.com/

Kind regards,
Tommaso

v7->v8:
 - Rebased on top of next-20260827 + [1].
 - Improved cover letter.
 - Modelled using ports/port instead of port/ep.
 - PATCH 01/9: Add RZ/G3E support on top of [1] using R-Car like architecture,
   improved commit msg and commit body.
 - PATCH 08/9: Use R-Car like architecture for RZ/G3E and added
   mode_clock_min, mode_clock_max for parallel output, improved commit msg
   and commit body.

v6->v7:
 - Rebased on top of next-20260605
 - Splitted the original series into smaller chunks for easy review and easy
   merging. The original series is available here:
   http://lore.kernel.org/all/cover.1775636898.git.tommaso.merciai.xr@bp.renesas.com/
 - PATCH 01/13: Collected LPinchart tag. Removed wrong fixes tag.
 - PATCH 02/13: Rebased on top of [1]. Use single DRM device aggregating
   both DU instances (1 DU dt node), modelling single port for each DU0,
   DU1 and multiple endpoints for outputs.
 - PATCH 12/13: Removed feature flag usage, rebased on top of T2H/N2H LCDC series [1]
   Reworked commit body as now outputs routing is based on endpoint id
   instead of port number. Fixed rzg2l_du_r9a09g047_info instead of
   rzg2l_du_r9a09g047_du_info.
   Added bump of RZG2L_DU_MAX_CRTCS and RZG2L_DU_MAX_VSPS to 2.

v5->v6:
 - Rebased on top of next-20260406
 - PATCH 1: Fixed rzv2h_cpg_plldsi_smux_clk_register() removed u8 width, mask
   variables and replaced with direct use of smux.width and clk_div_mask(smux.width).
 - PATCH 9: New patch.
 - PATCH 10: Extend patternProperties from "^port@[0-1]$" to "^port@[0-3]$" and
   explicitly disable port@2 and port@3 for existing SoCs that do not expose
   them. Reworked ports numbering + improved/fixed ports descriptions in the
   bindings documentation. Improved commit body.
 - PATCH 15: Aligned ports numbering with the bindings changes.
 - PATCH 20: Update ports numbering accordingly to the latest DT bindings.

v4->v5:
 - Rebased on top of next-20260211
 - PATCH 9: Dropped renesas,id property.
 - PATCH 10: Collected tag.
 - PATCH 14: Fixed RG2L_DU_FEATURE_SMUX2_DSI_CLK to RZG2L_DU_FEATURE_SMUX2_DSI_CLK
             Added features field documentation.
 - PATCH 19: Rename du0_out_dsi0 into du0_out_dsi.
             Rename du1_out_dsi0 into du1_out_dsi.
             Drop renesas,id entry from DU nodes.
 - PATCH 20: Use DU0 -> DSI instead of DU1 -> DSI.

v3->v4:
 - Rebased on top of next-20260130
 - PATCH 1: Fixed build error: https://lore.kernel.org/oe-kbuild-all/202601311423.gWtJuxiU-lkp@intel.com/

v2->v3:
 - PATCH 1: Added missing defines for duty num/den.

v1->v2:
 - Rebased on top of next-20260129.
 - PATCH 1: Added rzv2h_cpg_plldsi_smux_{get,set}_duty_cycle clock
   operations to allow the DRM driver to query and configure the
   appropriate clock path based on the required output duty cycle.
   Updated commit message accordingly.
 - PATCH 2-5: Collected tags.
 - PATCH 6: Moved clk_ids to match enum order.
 - PATCH 7: Collected GUytterhoeven tag. Fixed "dsi_0_vclk2" position
   to match order.
 - PATCH 8: Collected GUytterhoeven tag.
 - PATCH 9: Use single compatible string instead of multiple compatible
   strings for the two DU instances, leveraging a 'renesas,id' property
   to differentiate between DU0 and DU1. Updated commit message.
 - PATCH 10: Removed oneOf from clocks property, which is not sufficient
   to differentiate between RZ/G3E, RZ/V2H(P) and RZ/G2L. Use the already
   existing vclk instead of vclk1 for RZ/G3E DSI bindings. Updated allOf.
 - PATCH 14: Instead of using clk-provider API to select the right parent
   clock, just set the correct duty cycle based on the output. Updated
   commit message accordingly.
 - PATCH 15-16: Collected tags.
 - PATCH 17: Squashed fcpvd0 and fcpvd1 patches into a single patch.
   Collected tags.
 - PATCH 18: Squashed vspd0 and vspd1 patches into a single patch.
   Collected tags.
 - PATCH 19: Reworked DU nodes to use single compatible. Use vclk instead
   of vclk1 for DSI Node and set to the right position.
 - PATCH 20: Fixed: dsi, du and adv7535 are part of the R9A09G047E57
   SMARC SoM board then add entries in the rzg3e-smarc-som.dtsi instead
   of using the r9a09g047e57-smarc-du1-adv7535.dtsi.

Tommaso Merciai (9):
  dt-bindings: display: renesas,rzg2l-du: Document RZ/G3E SoC
  drm: renesas: rz-du: Move mmio from rzg2l_du_device to rzg2l_du_crtc
  drm: renesas: rz-du: crtc: Parameterize rzg2l_du_crtc_create()
  drm: renesas: rz-du: vsp: Keep the planes in the VSP
  drm: renesas: rz-du: kms: Enable multi CRTC creation
  drm: renesas: rz-du: crtc: Support per-channel named resources
  drm: renesas: rz-du: Rename possible_outputs to possible_crtcs
  drm: renesas: rz-du: Add RZ/G3E (R9A09G047) DU support
  arm64: dts: renesas: r9a09g047: Add DU node

 .../bindings/display/renesas,rzg2l-du.yaml    | 95 ++++++++++++++++++-
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    | 52 ++++++++++
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c | 88 ++++++++++++-----
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.h |  5 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  | 50 +++++++---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  | 14 +--
 .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.c  |  3 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c  | 18 +++-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c  | 21 +---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h  | 11 +--
 10 files changed, 279 insertions(+), 78 deletions(-)

-- 
2.54.0

