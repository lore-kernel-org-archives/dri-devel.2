Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C151073C8B
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 10:38:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 212C110E5C9;
	Wed,  8 Apr 2026 10:38:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="dFp0T9X3";
	dkim-atps=neutral
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010002.outbound.protection.outlook.com [52.101.229.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4DB810E5C9
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 10:38:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qtIJeJaD4X3pgiGJokyyWYfX4RotjNmcDA9rKcnt/ayZhr1BK8A8sbpM6sUJ2/h5t4Ny1WWJDmZe2B6doaP8PeiTs/Fdg1/ID8uRWwxEun/F6eIClKv2yH2EgAcxdsa0/qopkKG6AMQwS5/oXLXWOaTAMmX2zPV+QzvdKYIr+IkrZCswJ7GmtP6juCxZX5i4hSj7oP9hrm5/10kLRgFwBoHiC1LjtosjfkVyIBXntpHlSM0DPY4mwTOMQgC5skUXjHhJvT1kqaG69MqP+R0P7EmJktWR1e/w7YD3BavwmH9ZZbLahP1tfqPPqtD/KfeBFf8KDZZSW9nKSPxICVm7CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/N0t6KOa4wdEF5RdYU5p9a2d+Jn4draVGn4ltqA4V8=;
 b=Ri4C1iprKP3qkndIFfFfJjua3KSLMC38uTGNZTRq+5DTHlw3dqoxYvkouQ7e5WYSa3VVpcMu1MlXm+RBGz+L7H4FZUQ3oXwi+ggFTVJbSWGO1DR1PlPjZpj3CVVCRomYCc9SFmxYvoil2k9df+2pY/l9QYRz9McDGz9QWTQerZRvPqqXBkqps8oQc5OT0JBu6RgBOXhuZVXvzuu0YUGOdPXlKYxcikm018MjbLltenMM0mIJfD/bLqZxaMdoolY64wkU+DWe1gC7qMQ4qY0VhgLCI/uP2qxKjgyUZuzFCxy/CKe7k6VKTAkBtsn2Z0/2KnsaYkQr7cjOZIb+S7WeBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/N0t6KOa4wdEF5RdYU5p9a2d+Jn4draVGn4ltqA4V8=;
 b=dFp0T9X30sQNSFdWAxZ4YQw+Wr4aTdaAjrbNgUNFN7upNYz3sOiJ1O2RrBCJVdmCGOiZu1xAfk6kSygagjuNLhhnX50CpyeO0DyvkQGj4GClMGbRh1UdjrpRY5h3a8elYnLvA1J2QrOvb4PUZHxUA/JnnoISzzP4Fi4r7VvaJLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS7PR01MB13668.jpnprd01.prod.outlook.com (2603:1096:604:35d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Wed, 8 Apr
 2026 10:38:45 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9769.017; Wed, 8 Apr 2026
 10:38:45 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com, geert@linux-m68k.org,
 laurent.pinchart@ideasonboard.com
Cc: linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v6 07/21] clk: renesas: r9a09g047: Add support for DSI clocks
 and resets
Date: Wed,  8 Apr 2026 12:36:52 +0200
Message-ID: <21ac6da825e8fad0b0a9d37d6daa955b0d23ce07.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
References: <cover.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::8) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OS7PR01MB13668:EE_
X-MS-Office365-Filtering-Correlation-Id: e276a3c5-8955-4bec-f367-08de955b0248
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|52116014|376014|18002099003|38350700014|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: Idg0JZ1BdlrFsnzzppQ7JCvZsfDI4nVgQ22r/Hju+Gfg3+eYDoQec5JFm6hJ3Y28/X9oBpTsn4cTnGQW/G739y50Xs3div46uOWH+tv2GgiyO//RXm0E1QHI7MSEB+9MpyE1A0rMIRLNFiWx89M7zI+VGjb1Q9jAYHaHL4eGmpBfbou6JW3VHbjdTt08da4QnudkaZGUkWFlZ6DVK2xVaGpTXt1Iz7aQWgBYOrFvOC3+y0lgp3YBF5vgT7OotYofToZgoP4zzo0E8NZKMe0Z4MTEaG8ic2MVe+pHdM+plS+5ljctNFU2z56q03n3+EH3vClgGSXtu3CoU1SlqYuXJIEKLndHYBy1Rz77+Y1WSEpOzCT2tkCC5nWhFzH9f6rEQ6zENP5A6T3qp47nvwI2hCE/yukfOPo70y/nONpRr/vioiP8jUSpupeFDJk8UYxC3VjFsqFmdNGCZ+D2KXQ/R3/OCgQUqafRmYxg5PUfCUK1SiRy3LIEcYKcUBVXv0NHtfaf5snCKiPMybBNUqm8sS4DhzLFxw4+7F+NjmtrDPTKHr+hvNWwokO1xYB1MGhhvCM6tP4G+Zk2tgucXagoqYZkDoMfgVnrDw2O250Qj8efvftdNd6GQilUZlFK9zj2DtTmNxYlWL3ncWEoL3A8yIEE8DKeqEdNUX/k4ELMTp+A2q7wpsHtFxzRXadpNS+tjD2z/caHjOjB1giLiR2b56DX3dI5YSnpjRBVLPMZpJPVBZMdgIwjhs+rXH6e/2UkVONaPqwjj8L8GsEetbsvAxSKTe8RN6kbNHlMfGV1wPU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB11947.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(18002099003)(38350700014)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m2Xw8QSFun3JXLB7EPZh6xtIfeV7rt0BrLM5nCAwssln2qEC0RtXqKT3cQyO?=
 =?us-ascii?Q?Ei1us9IXevtYPJOz9JA/lYEFNnRX3KGuJ5HZ6S5Y9oIRT7omLVB+H/XBK/Zl?=
 =?us-ascii?Q?LjlauxDMGzz4yhhCUCqtt/9wmtHkgdaCP/x2lL/U1Z2xg0dLc0TCSTq9DHjj?=
 =?us-ascii?Q?nTbx5VsRm+Fc+lRc/5Oy423VQmGAdlBR8EzaR6xymMzSqhBuQZNCgH4oAo6M?=
 =?us-ascii?Q?6MXkfAa8Sx0ryZ+nRdHNL6j1GmJXXqV8/GKGbuQ8kZmJC/Xv6rP612cwUpxJ?=
 =?us-ascii?Q?8gvXDsaLa1IXO4mpPlu6YQrI6Prm+/imwOetC+QWdbNnsGV5+U8HIZKdelrp?=
 =?us-ascii?Q?og7EAGjK0QSla58GMaR5EUmg8qIKi5/85pHMl36xP3RHy1wUARQ3p8/DFK1W?=
 =?us-ascii?Q?o/6ysBiwrWbEs7/hGK7m/9s4NBp9mX3I0TKNjuKN5/5jIbo9HaU5flS6D0Pt?=
 =?us-ascii?Q?itaegsHW8U9A+RZ9jEp4m338dRVgWy4EC+XQyXbHMmv6H62trqF7Ja1rdDhq?=
 =?us-ascii?Q?DKCl+RZp2CbReFbIsrAopNE5VdSCMnYf8JT5UYCSSoD6rm1HBIYftEpojAH5?=
 =?us-ascii?Q?a9XyvFvg8qDIZcWP0KqWYIvFuUEPUyV1QkesIp9Xru5k/9zJBpfIYaJf8ZDr?=
 =?us-ascii?Q?gv8qQ6mO3b8qTd9l8oTPgtAP0STeHK6bwqqFv5jTeqAvU21NxExr5QuMG5T9?=
 =?us-ascii?Q?NmuX7REqubiXUlOqLjKqTDxCT1GQJHHawBLK/XYSLz1vJUBAmP1fvstsc8sU?=
 =?us-ascii?Q?3Aaicsn7vsqLtAxeNxSW5SP2tt2irRMz3is2RA8UmVrtP2eYxako+KTwhIMr?=
 =?us-ascii?Q?5MXgQRo+t/K/iKL6xzuGYHuKYLpP4EzAOenlzkPCeKkrj2UeBy7eUoTobTY1?=
 =?us-ascii?Q?6doHWopDt0nMP+B1maQA/cif6lAb/sDbrbzCxFiFafTw2iJdKbptDBUZ5g6J?=
 =?us-ascii?Q?3WGDyDXAdNTkhazughOF20REeeFEBZpU8xKy7Jmv24LFpOh2zqO1g1H3Ec55?=
 =?us-ascii?Q?+rdZgPjF/PEq2mP+MTXA20mg/xyBF7pQXqvzsya8nughTTobS4ygs8PZ8IVA?=
 =?us-ascii?Q?vnFXSdJoJTdLryjGnlwBAl1x85OnFuzHrcwHYj3/su754FMWZumfQox/bQb8?=
 =?us-ascii?Q?CU4zc2IBp146xcqGYENzgeG6OynDidCJ/umUUa7uVV9dLEAPQIufdcptNZih?=
 =?us-ascii?Q?sS1FScowf256/c+mmq/QmuUs/+i3RIdiW907UljbGi8HyZbvawcBIkNgSeaQ?=
 =?us-ascii?Q?73tkLFPyAazwOVBoAap8WxBhcSR5LiPdQX5+CnakGV7p3gCXaW2mDvMNFris?=
 =?us-ascii?Q?mz2amh0EMWeR9MNd+tC6FdC8k4ePE2rWzYY28YJXFftdcmhdJhb/qgS9cuzg?=
 =?us-ascii?Q?7nj6zjxrX4Pu+REGk8HF1R4jmgTZjx7Wr70cG/6yE/83w0IAda4vxM03BqSv?=
 =?us-ascii?Q?MYH01g9aZmrjBGF+35jfKcsN6ssZvPqmkO5rtPQ8rVV+pH+Lffk1dLfsJSH0?=
 =?us-ascii?Q?CubyDRYM4pyjxVatbqgvR/abs0IU9QCQ0/eQBe8aTeRGdB0ebWAJzRnjuQMA?=
 =?us-ascii?Q?f+iUurQiqMWzPrWJZ3SHoDyzfysTeUNSCkC7T1uSQAwVmZZIQbKHi/AN+Ifm?=
 =?us-ascii?Q?8NYe1HcoAFu4n638SO6dxswsHEx+yZTXsQMbRtNWtGkLZQ6WicPFXPOm6Xty?=
 =?us-ascii?Q?wMA1eiJoSozsI32iLVZJDsM98khUi5QlmH4AT3edXs9Vd//D9qYrr6pSsH+g?=
 =?us-ascii?Q?AYRgVclCJiK6xniQsXevr1c904ViThOAxIv3UJMIOJLoARKqDaEf?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e276a3c5-8955-4bec-f367-08de955b0248
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 10:38:44.9804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dX4Q4GnZ1rSaUb29sUE7mv1ksVS70mv/GH+tfG1bkS6FK/eZeyAXvrw8GFbKyXx0aFuiDERK3bo28ra7c8Yx1oEC328l4GU4JAXzu4IXfwfKrzndp8lkr/yXS91goVrN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB13668
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

Add definitions for DSI clocks and resets on the R9A09G047 cpg driver
to enable proper initialization and control of the DSI hardware.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v5->v6:
 - No changes.

v4->v5:
 - No changes.

v3->v4:
 - No changes.

v2->v3:
 - No changes.

v1->v2:
 - Collected GUytterhoeven tag.
 - Fixed "dsi_0_vclk2" position to match order.

 drivers/clk/renesas/r9a09g047-cpg.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a09g047-cpg.c
index de0b9c071e0e..9e7bb65acea6 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -508,6 +508,16 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[] __initconst = {
 						BUS_MSTOP(9, BIT(4))),
 	DEF_MOD("cru_0_pclk",			CLK_PLLDTY_DIV16, 13, 4, 6, 20,
 						BUS_MSTOP(9, BIT(4))),
+	DEF_MOD("dsi_0_pclk",			CLK_PLLDTY_DIV16, 14, 8, 7, 8,
+						BUS_MSTOP(9, BIT(15) | BIT(14))),
+	DEF_MOD("dsi_0_aclk",			CLK_PLLDTY_ACPU_DIV2, 14, 9, 7, 9,
+						BUS_MSTOP(9, BIT(15) | BIT(14))),
+	DEF_MOD("dsi_0_vclk1",			CLK_SMUX2_DSI0_CLK, 14, 10, 7, 10,
+						BUS_MSTOP(9, BIT(15) | BIT(14))),
+	DEF_MOD("dsi_0_lpclk",			CLK_PLLETH_LPCLK, 14, 11, 7, 11,
+						BUS_MSTOP(9, BIT(15) | BIT(14))),
+	DEF_MOD("dsi_0_pllref_clk",		CLK_QEXTAL, 14, 12, 7, 12,
+						BUS_MSTOP(9, BIT(15) | BIT(14))),
 	DEF_MOD("ge3d_clk",			CLK_PLLVDO_GPU, 15, 0, 7, 16,
 						BUS_MSTOP(3, BIT(4))),
 	DEF_MOD("ge3d_axi_clk",			CLK_PLLDTY_ACPU_DIV2, 15, 1, 7, 17,
@@ -516,6 +526,8 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[] __initconst = {
 						BUS_MSTOP(3, BIT(4))),
 	DEF_MOD("tsu_1_pclk",			CLK_QEXTAL, 16, 10, 8, 10,
 						BUS_MSTOP(2, BIT(15))),
+	DEF_MOD("dsi_0_vclk2",			CLK_SMUX2_DSI1_CLK, 25, 0, 10, 21,
+						BUS_MSTOP(9, BIT(15) | BIT(14))),
 };
 
 static const struct rzv2h_reset r9a09g047_resets[] __initconst = {
@@ -591,6 +603,8 @@ static const struct rzv2h_reset r9a09g047_resets[] __initconst = {
 	DEF_RST(12, 5, 5, 22),		/* CRU_0_PRESETN */
 	DEF_RST(12, 6, 5, 23),		/* CRU_0_ARESETN */
 	DEF_RST(12, 7, 5, 24),		/* CRU_0_S_RESETN */
+	DEF_RST(13, 7, 6, 8),		/* DSI_0_PRESETN */
+	DEF_RST(13, 8, 6, 9),		/* DSI_0_ARESETN */
 	DEF_RST(13, 13, 6, 14),		/* GE3D_RESETN */
 	DEF_RST(13, 14, 6, 15),		/* GE3D_AXI_RESETN */
 	DEF_RST(13, 15, 6, 16),		/* GE3D_ACE_RESETN */
-- 
2.43.0

