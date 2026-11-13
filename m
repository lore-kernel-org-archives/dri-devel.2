Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60792606A323
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 12:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=bTxmiFgI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A97410E034;
	Fri, 13 Nov 2026 12:20:56 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011027.outbound.protection.outlook.com [40.107.74.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E842910E034
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:20:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJV2ldyZFsmKhcu9I7hCveC9pL09rJsp2EHVWM1X71u2cVQxHg70r9bW3GuPSu8jdY6HMtSv+OyWfmy4dCw8jUH8EZAaHQIPr4tE0oiD1pVmILQ2nIIxbXL2GBvtEYkHfR8zdSYR0McvvQF10wrUF3rLfWdl9/ZMjHjOiLdjW7E/zknKLlkDRBhUV0cKj1Pn89fm9FiUaxTIjGIrrHDcFB7SpQKdzc9sog8uF66RDzCHyTl7K0bs60/0tsb6oDp+i8mlqO/O8napux/FPB3/AHiNOfVQJ92Yqu9vHLv+0+x8xDfmFiFLJ8twhoRi/oB0EN/5vDCgFkzbQbHA62JU9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56RYGt6xqm0e7kPo1jgT/9bW0CuSOnehzHsgSusStXI=;
 b=m62KuLeYCJThD0jsahYlX1O9Pb4ZQkgHczHksGiZ9jpNYgM7zCkdVSwf7l1WHyjpv/DgkEPJKT5YSvxceA+XRcOQL6rTdD+vdmrq3nkupYKcnfjtQJFIaAkeN59uOYuALd1T67du8w1Sf3pVEHO5t5O6ie8bQJVP3yZ15TOl4wferH8/XSHCse3aSR2qX207UQtRiItZ4YDHusb5FPFPGeCeF671G1dcXKV73RVT4VxMgw3KJJAh78pEGXdxF6CqMP1/a93Sx7Opv7ZMvzbpo76GzsZ8c7FzuULVVbhpm7p9TV1Ap85kb1USxnIwmtLjjbSH/BVVu16l1d6V/EruIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56RYGt6xqm0e7kPo1jgT/9bW0CuSOnehzHsgSusStXI=;
 b=bTxmiFgItjUF+RLXdcCckBu3FH/jzfQfZqhxQEZU4oiNTbWcjBoK0W4/5y+apfM87yOmFo8R0DxxV4x3cU6Zb/IWLerUxQde/5daSTR4xFFjtNnshN8CTUJ9iQfV+650tUuw1NaLc0k5tBvHg3PEJv1FNOIAZNHHiPFeGBNGvQg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY4PR01MB14799.jpnprd01.prod.outlook.com
 (2603:1096:405:25e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 12:20:39 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 12:20:39 +0000
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
Subject: [PATCH v10 00/12] drm: renesas: rz-du: Add RZ/G3E support
Date: Fri, 13 Nov 2026 13:19:56 +0100
Message-ID: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0038.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::21) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TY4PR01MB14799:EE_
X-MS-Office365-Filtering-Correlation-Id: da3aa65e-8269-4624-b487-08df41808739
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|52116014|366016|23010399003|18002099003|6133799003|261009223027099003|3023799007|11063799006|260925022911599003|260925021311599003|56012099006|260925021911599003|5023799004|10067099003|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261022075727099003|261021121427099003|261026121527099003|261021123027099003|38350700014;
X-Microsoft-Antispam-Message-Info: vSKHgq2Qg4VfqWLWhTGE6VgxfOtLVHJKrG0rTFgyi8dQVzyZyLQlTyuLVUlvMK4kbW0d1eLfm+tHziacZFdrAj1LpyEg7qrKYB89YXSnUrw+PtVr5rFZ9dgV119zZjFlqBEvqCccYekePEvRJ5QbXDYfj9BFQ46kweU7nsuVgbiq2wc9mHXp1qkC0K8IiTFpaWG7lyEMvpyFDyFpOCm4qv7Eo5sKCmAQjC5/oBPyWg7yH5zp+EHg6UR6d9w30PS4aiq9bqpt361LTSlpfEXxxEdwPITd0ve5PTrrQKOkp+B+MjR1QTF2Oop2BCzRHIauxsjauKImHYQy02rSClPY+lkQ5OauAuqoACgH4A5xpzjJBYpvbMhG4Bb5Fzare1GrMMU72xNxsIX3utzpCfPoHEfcSlwam5sVvncYK0h4Bgdvb68Y5M0p4WxzMAZYB0xRuZV8NAVjixrSOzJLXde+cMo6JVKU7lVkIrWjPWPLn9m/xO3kz/TRfutSuTlVxTAl3uuv6gNr6jw/IjTwH4sriJepjg4ToHn7Ow2mmE6/au+28gXxYkVhSLkDkG2GxfB2rWTCd5HM8wdV/B/XiII8EufTPT6ijU14nEIPkUtWlieBILXPHtf6XcrHUNySHTGlIcBNwUKQjx4JPVfjvxO4JaDL0wquta9/gTTn8DC3Z44=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSOPR01MB295138.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(23010399003)(18002099003)(6133799003)(261009223027099003)(3023799007)(11063799006)(260925022911599003)(260925021311599003)(56012099006)(260925021911599003)(5023799004)(10067099003)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261022075727099003)(261021121427099003)(261026121527099003)(261021123027099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eNCYP4YAIbju24TPZyIBNeVBxX2hZbS/po9BTf6mzb3vcdVnSMvhD7Hi9qgB?=
 =?us-ascii?Q?tE7t0yKEYGvgrYIvBz92CTBoGXYjNT4HlmbkAk/aCD8fzhPl72+LDziKlQYN?=
 =?us-ascii?Q?jBq0ZgfdqdTpkXnEqgXfvCB9JRtZJ73Dvs30CYpx7ivTtOPjLsBT5EYpxhux?=
 =?us-ascii?Q?sHVz4NjA2mQggvA9lozZ7SE7p+nLWXeBHNIxwH0acBCuCUglzdqxVyGNA6dR?=
 =?us-ascii?Q?zwYGgg+jKk4zpmecuUhhaCL6CrToezgQTByu78dRiRbzaqkOSPJcosc9c0XP?=
 =?us-ascii?Q?4NisXCxPxkNHgLEzF8Cl/FMoAWW1tI3L5kpVV64JqzaEI7sWQU9rgxP9VbPM?=
 =?us-ascii?Q?dcSK+ZqvASEjecUviwSrf1fmmGzgsmMpWKe/PM8ohxX/Z0L3ePMmSi3oE2uj?=
 =?us-ascii?Q?LDbulNsVp30qGAft6i0IG/alXoP2mwJucz2+8YzooqM9A32jSP0mu5bIj7qS?=
 =?us-ascii?Q?8UtjqO1VD1ThoQ4wk7c0yUhu23021iHenz42R90iZb9k1qbnvWUlMLC30UJh?=
 =?us-ascii?Q?CXD6s/XY6pp1zYopdREAZHalgz4deoev3YvLPsBzY1o+9OzfuYdogiPy6KiN?=
 =?us-ascii?Q?sUGpKj9JxWJgMI8egkKnbJi1KzoIvtq3aEaUdcapg2yKEmnClLOhXjhrR0MZ?=
 =?us-ascii?Q?6xpNYZ5FMJu/rQOAPR0oMNuyL93/nzre7Lf4qxQXM2lD3LPCLNYq1ml2ID+z?=
 =?us-ascii?Q?Yxtqm0izHoeHVxGw59ZhQ3riZGY9RnSPn0YGMBOVrUrJ7zz8NKfJ84syksxc?=
 =?us-ascii?Q?N5sCKghwsjSXITKCJJuYhAF0wqqGVXlDiChib114TEPyX87/gfzDR25Jy9bz?=
 =?us-ascii?Q?aMiD8GibPaT+1jFWOcx9KT4d5SnI/EsY2qDlII2Zsr+hLLPfrTqWzOxuFys6?=
 =?us-ascii?Q?djUHSMdS6EU9WRxrdDg3Da0Kbt/y8rCDtJU9WT8x9SwBnd6X3Bq/XFYZHO5x?=
 =?us-ascii?Q?bwIDQx55iTsBtMJtsPBcevhFykMXCbwY2gvqVIGP0drAdwsN8Dkw2XgcdbVm?=
 =?us-ascii?Q?npqCCOq+4PUF0sxz26uJK6ykzOJll2/3IF30QpMBJCWw8i1EAQtAl3rQAEUu?=
 =?us-ascii?Q?t3/8PBX4QL/IXarsifVGwSCAcWywU54SEnZU3y3ciXmqENuhJxUPwEpkLn4A?=
 =?us-ascii?Q?dkB6mhYPj/pizYU7BAAA7sluSPlTumi9uvjU/IPn60Pl6P4S2PdeRLNrqosT?=
 =?us-ascii?Q?Ec1FYT8DBq16Abwhy6sCF7t3FUQznIFWYQSSSKz9g1FmYkMiqob2TkjBw1U/?=
 =?us-ascii?Q?I6Yd4s0eVVeH0+a0f3XNNGLg82pxVMCa8lbuP1IIejIT11gbN9dlkWRlKMve?=
 =?us-ascii?Q?DCHA+0nIQoa8bvwK2Z+2DI9O9SaihoQ3BCowzTz7nDo0XpGlVGafQTiFwLg8?=
 =?us-ascii?Q?7c3viOriEe2whonJcXadXqszKR3EbLJ4bXAEQ1rYs5Nm0C2OpxIhYmfDBPFV?=
 =?us-ascii?Q?2AwGtYhz9O8S9dXF9EKRAeYjB+7No/uVqguinshGiNurCOEQd3zvdRQaX0uu?=
 =?us-ascii?Q?7Q1DWgtR6ig5oknl+32mHPPhN0QQstXhsbjFjmbhTZl1ds7ltdDCjtjc7EPL?=
 =?us-ascii?Q?c8mhOk6LIE6IXZ6Q7DYPNtw6GUGx6D2UWjdvLR7fH18XimtHGHjBTIHmV/du?=
 =?us-ascii?Q?xeJLUkre1DfkwJKY1eY+7Z9+ReWgHwGcc5wWGk32Vmbkm3Y98XTSHGZmFg55?=
 =?us-ascii?Q?UssCTOlcZGTjHLmsRnBwUBBIn/BbpKSEjbRbjEFbbTr1cKeoyYMeAWVnDys0?=
 =?us-ascii?Q?tqwIEQR/uQ3kwe8jJUqcAYx9/Jfw5xur4daN2SGUMKOYaS16WyRi?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da3aa65e-8269-4624-b487-08df41808739
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 12:20:39.3358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YsR8ZU+XJ4zEhrsdeaLuRkqinBxi9XuUqwnrcki0hpnIYBh7+PbuwTGCWg7J1aR5Xh/SszGjUnsfaarlhHjjliQJtOTLFZ30rdnQUd+aYZ+icd6Iyu+EW11kRDsifXH2
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Dear All,

This patch series adds DU/DRM support for the 2 Display Units (DUs) interface
found on the Renesas RZ/G3E SoC.

RZ/G3E SoC has 2 LCD controller (LCDC0 and LCDC1), both are composed
of Frame Compression Processor (FCPVD), Video Signal Processor (VSPD),
and Display Unit (DU).

LCDC0 is connected to LVDS (single or dual channel) and DSI.
LCDC1 is connected to LVDS (single ch), DSI, and GPIO (Parallel I/F).

RZ/G3E has two DU instances, described as separate DT nodes. To expose
them as a single DRM device (one CRTC per DU, as R-Car DU does), the
driver uses the component framework without a virtual master node.

The first available DU instance is the master and creates the DRM
device, the others bind to it as components. If only one DU instance
is available, it creates the DRM device directly at probe time, as on
single-DU SoCs, which are unaffected.

This avoids adding a virtual master node "display-subsystem" node to the DT.

Series apply on top of [1].

[1] https://lore.kernel.org/all/20261112-b4-tm-pm-du-v1-1-507474331137@bp.renesas.com/

Kind regards,
Tommaso

v9->v10:
 - Rebased on top of next-20261112 + [1].
 - Dropped the "renesas,r9a09g047-display-subsystem" virtual node and its
   bindings. The first available DU instance now acts as component master
   and creates the DRM device.
 - PATCH 01/12: Collected KKozlowski tag.
 - PATCH 03/12: Rebased on top of [1]. Kept rzg2l_du_device as platform
   drvdata.
 - PATCH 05/12: Dropped rzg2l_du_modeset_init(), call the helpers from probe.
 - PATCH 08/12, 09/12, 10/12: New patches.
 - PATCH 11/12: Dropped rzg2l_du_subsystem.c and the separate DU instance
   platform driver. Reworked commit body.
 - PATCH 12/12: Removed display-subsystem node and du*_ports labels.
 - Improved cover letter.

v8->v9:
 - Rebased on top of next-20261022
 - PATCH 1/10: Step back to v5 -> 2 du model du0 and du1. + added refusal of
   port3 for others SoCs and adjusted order and ports description.
   v5: https://lore.kernel.org/all/ca022fdbba5236c36e0cb3095db4c31e8e0cb1b8.1770996493.git.tommaso.merciai.xr@bp.renesas.com/
 - PATCH 3/10: Dropped the vsp_pipe bounds check in rzg2l_du_crtc_create() and the
   now unused num_planes field, aligning with rcar_du_crtc_create().
 - PATCH 9/10: Added newly architetture support creating an ad hoc component
   driver for RZ/G3E display subsystem that embed the 2 du instances
   into single drm device.
 - PATCH 10/10: Split du into du0 and du1 node and added newly
   display_subsystem node.
 - Improved cover letter.

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

Tommaso Merciai (12):
  dt-bindings: display: renesas,rzg2l-du: Add support for RZ/G3E SoC
  drm: renesas: rz-du: vsp: Keep the planes in the VSP
  drm: renesas: rz-du: Reference the DRM device by pointer
  drm: renesas: rz-du: Count all registered encoders for the possible
    clones
  drm: renesas: rz-du: Split the mode setting initialization
  drm: renesas: rz-du: Make the CRTC index relative to the DRM device
  drm: renesas: rz-du: Share the encoder of an output driven by several
    DUs
  drm: renesas: rz-du: Separate the DU instance from the DRM device
  drm: renesas: rz-du: Move the DRM device initialization to helpers
  drm: renesas: rz-du: Support several DU instances in one DRM device
  drm: renesas: rz-du: Add RZ/G3E (R9A09G047) DU support
  arm64: dts: renesas: r9a09g047: Add DU{0,1} nodes

 .../bindings/display/renesas,rzg2l-du.yaml    |  28 +-
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  74 +++++
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c |   6 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  | 297 +++++++++++++++---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  |  13 +-
 .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.c  |  23 +-
 .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.h  |   1 +
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c  |  45 ++-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.h  |   4 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c  |  23 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h  |  10 +-
 11 files changed, 415 insertions(+), 109 deletions(-)

-- 
2.54.0

