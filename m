Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD52C1073C8B
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 10:38:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 296DF10E606;
	Wed,  8 Apr 2026 10:38:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="msiIKPL1";
	dkim-atps=neutral
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011043.outbound.protection.outlook.com [52.101.125.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 867A110E604
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 10:38:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNCMV4gE/obWD/UoDACSMMVQJ5FxSQX60DAiSTaMPAVBTIge8kE0+dKvJFh3cZUL1HPCYbXJT20HhYgIh0vQnQhecbNBG1RZC0VI9Wii2Lt+Vmy+9e1T9pE/0WF/Rzr1efVchg4XRxx3w8f7QuKu4TQmghASErWQpuUv8KTHnypzDgCih7GaQEwbhfAcV+N/gJFnFwmmDbrEChpNJRrhgHrJFJFH/tQdV9a+Db605/yhKqmbZekRUGnJwV99ZVwNVYK+NjWYUNh1qYJy4HV0l7cF3qSR3DY1eS33YoNUc9h5nRMTmQZpy6v7ZcSo82trqdyt5pzO0xrCqCylKss+iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9WWAn/GQKLSAF5dvgn4pAU44GzMXHo0bMOQZql6TKA=;
 b=go/Vn53N/GfXI+0TSaEdmwrD2Y5HcHYTKhiTveDEcEuh9YpMaJpBRciBi2faXYi3V5Od0bp5z+svSLJWLD6LhN6Sapdj4kvFAfwUISTb1LhZ77rkQNI6F8L3JzPHURv2bw4LqIK+H8CAYT1m2AtK67O/U8GbO+YfH4bpZQiIGQ1wJPxqBccihFvJdLoGt4AYxz1EWsn8LV7WMyENqjCuapmAyYRuLYDYqHtI+mLkny2kIAMZCXWh6KUF8eOwJM23fqFM2d05s2sE5O3YV6NtF75gB2C/EgBars3ESKi1utrnmebGkTudvl7nYcx8Jlu+gt4GJFDOYN6onNBXT+ygBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9WWAn/GQKLSAF5dvgn4pAU44GzMXHo0bMOQZql6TKA=;
 b=msiIKPL1WmhcH8+bnZA986xKky1IZdhGB79eB3o6eVlqn+A5L76ZUHPznGUHegvwDxeNvuShv6o35gmeZ13rXDgW/dmWtPFfWKdz7d0gHdwTV+HgzElup1hGxfOzQ9aMB3eJle1hSiekIE47T64LmJUZFZ9jblixuMpZiDOivsM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS7PR01MB13668.jpnprd01.prod.outlook.com (2603:1096:604:35d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Wed, 8 Apr
 2026 10:38:53 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9769.017; Wed, 8 Apr 2026
 10:38:53 +0000
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
Subject: [PATCH v6 08/21] clk: renesas: r9a09g047: Add support for LCDC{0,
 1} clocks and resets
Date: Wed,  8 Apr 2026 12:36:53 +0200
Message-ID: <c1b5afcef8068d4d074aff97e30b4d64b7c38eaf.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: d5a351af-ce2f-4ac4-b76b-08de955b0723
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|52116014|376014|18002099003|38350700014|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: kAXp1PYCfZWok54GBMuK3JY4gW5XgnKp95jkMxjm7tGZWWIkquY8ddn66S86Ww+nynvtDG6eVF5z2Zg0jQGHEh+5GCnKVIDCTa69x/kfWBhtOHU6pEzgsMBrrBuKatU8CseIEUMQtXiTCatFBxdxfWP1zGx9SZ6Yd/v5i3R7fcH3PnEINtq6b46/wdgON7nRGzaaH0Ir6IC0clmEjS7pBGFFMh2bl3EdtrGSuMnkXsjAAfriJz6gf4DN3B4TBCzVqP3qcM4P71Ucf0kkuxYQw7DY6DDTmx0U7oGjTvi17fcna5GNZ/+d35KmPw+A4CQnUyPb/NQllEEV2ibQab0Docw/yYWR56rvMQtDn8bqnF37XBtSGHZtx3Jk1Uo2mDIRCo/3A3ghuZDiDbpHEpDNW1ieRct79wIvesY6HAJewl29I4lDIskDOzdUIaytLx9KilYoiKkC/DowgwWqewcxnKs7QaMXNylSXbjN2onOj7Z14hvzFgLZI+0/zTOZBGJln2ozLpl8BULV4yH7c4oeVKCxoz5OQN+QqQstSuOCBIvjAWLyhchy1SE3QUvWHC4sklBLikKdjKhwvQq/NRDe1X69SLF2/WzZTtopvga8NC6S311ipcqu0ekNcVLSna3ZMqlncb9s2rQuA4AljuuFLZLySMJhm8vGiQ37l9MuJYHYO9KGOOIQIwvRB9sCVnMdX5cmug+3kKAS70kFr1n/qjCRvW3aDFIKJ9VgHLgfrg5fZUPjIr3tjYOfteO/L0uhIFClkwAOYuTJHSxBL/xVCPUQ5Y4HOrQxPfU+50YYSl0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB11947.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(18002099003)(38350700014)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JTbos5sIUMBw7ayxolNR0BGnk9MlaODEdwjQL4qh01vVU/YAYx3IX82eLsFK?=
 =?us-ascii?Q?0ktp0rPSG67NZJSsSx1dEsl2UvKDUnoR+zvuIDSeUW4AYfpMIT/cNvCk+Z3O?=
 =?us-ascii?Q?aE2v1KIotxkaCTrf4BrFJ5Q3MrS4iuriOrzw9QrSQITJbesB9SNBWg8eqnW7?=
 =?us-ascii?Q?K8VqzWQhPCjsniP15Op5rggTLNW3bKDtuYRkdqnO5OZwGC2m8xEPhKQv/Rz7?=
 =?us-ascii?Q?vJm0pIB3uCBt4LPWxEna4BBUKcXsMGKsSx5ogg4JQ5GTBbn73KqrWmorjznZ?=
 =?us-ascii?Q?NXmTG88GEHmFlqc05KtTFxk318isS3s/LZSxAcy6Dv2RwXqmesQe6lqPbMOH?=
 =?us-ascii?Q?k+RSm0pOlGboQWyrBfgc3iQDppGMbH5SiuE98GSxbCh3b4ynEHQS4Fu5m0GB?=
 =?us-ascii?Q?/GSMqIF3usJFt+Ew0ErSbGCfpUkouc7ENJD/eDXMeUgzD7gA4aoTQOBKQg7M?=
 =?us-ascii?Q?8D4TcB251oTtRp4mqglJxe5zNdiiwauZI/bXe0d9X9x+HFquDH3rEh7QVDif?=
 =?us-ascii?Q?4qWSyOLJQyCE/TqVnLR4Ai7ztceMW7J/XcVertJx99ervyxUo9SvlduPIWu/?=
 =?us-ascii?Q?Aj8HDZOvapQTg5Z4/ACjOS5ejLubywHtxsl4kojbFtUG6GMC47tTNBual/TV?=
 =?us-ascii?Q?PW8YvfyfegZNt1Gr9E9Zw4ybXikO5zco8ANV+NF+4YmWcYT4Lkhb3AUDCqr9?=
 =?us-ascii?Q?teeWbk6cmcht755jSSyhut7KKjxrKZo+tVBjH6bsmTGHhnzbE6KImVGavpKs?=
 =?us-ascii?Q?wf1rLxo/t3+jc8MHrSflybCY3kJvW+a8/s4ypFxg3xVii1ZBnj5QSoyEMbyc?=
 =?us-ascii?Q?AMTD0m7o0kU+A9EuQ6yOAbJ1rnSw6aXAmr43PLsWYo0/ciKTikquQ1b/1zlK?=
 =?us-ascii?Q?vlAL6PV/ELVpyNj3+41E6hvA/AhwqQpXvXSvAifVHpkljC/KaUs1We99ypMW?=
 =?us-ascii?Q?JufOM736mONDzLTRbye83/opFt1+3/o7O5rrMn2e2Hpp25ztuMBCmAIQy9KQ?=
 =?us-ascii?Q?yUFCaNzl+Ek7P/Fqopg5in3qGh4yR6gukmsgFafoeXFkLNiwROIu8/nYyK3B?=
 =?us-ascii?Q?xSSZ3TMWaRWimhkqh/pZXeUSwqJzq+H9T+i1Z8s2AJ74s8vkXTBDQwBuM4P8?=
 =?us-ascii?Q?hQ2vcuZSS4YqPKPPOBpLc/AiSsXDHI4ETr7h/xnluIPHm5BdnqpAhp3D8Dtn?=
 =?us-ascii?Q?176/JG0Rty2yEXJZx3kG4dQaeF/jQ18BcaEsvjGjWeHdCSAoOzyqPZR+KGJz?=
 =?us-ascii?Q?omDWHUQTFQwX/bqjVTp4zl7UCcIFYXmWrk5RKjO448tfPpgaWRfNlQGqRgZ7?=
 =?us-ascii?Q?LWaC9yb2KTRIQSXTLVAEyWIkkpEDAnBO2zlrMEuhSEl+3ZeCzh3lZE4m+KZO?=
 =?us-ascii?Q?PQ2/xIER8l2+sK7sPafSPFba/9/lFgsUDPWRBhmLUUHJABoEDDqJzYXV+PJb?=
 =?us-ascii?Q?ZR5eDz9zsFGy22hz082mMQgYeBA8NboO8XlDmbXahC8SbhIFMR7lBJ36+sa2?=
 =?us-ascii?Q?WK6Qj9D0rJE3YY2dcmIipX8ZhhTIXl+U5Q2Z6WvPjcIRkeKzaTVGOUNcuhH/?=
 =?us-ascii?Q?Iaky645kLt3fj93xQtdsAAcDU+2F9Zm+sOdgiQTiwv0rQC4cTLTaBPoK6C2D?=
 =?us-ascii?Q?O+eDubeA/d1gNZySFRuOa+w0BA5gzisACTLe0rly3sTYF2ZISlvgbNSFkdrb?=
 =?us-ascii?Q?LbE5PC4CdZdvrklfXvU709/B1gc/CkUeLh6NUWacmzW1Ywb+i4CDuBn3S4z1?=
 =?us-ascii?Q?5yWhrNogg0H7EeeC58DMjk0AuwG4e1Ky659WVxdzRESwxLPKvBAe?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a351af-ce2f-4ac4-b76b-08de955b0723
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 10:38:53.1247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43WxJuciBU5R3wPr+8Ptdk4RABu3YRrv2UuvvpRSj3WPWfnyfi08e9xDu6mUoJ9FtijClSEWgwE0F347VS4OXrRhbigYEi7RXODFxRnj2vNRMRM9SAwVs5UGFrfu3FdD
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

Add LCDC{0,1} clocks and resets entries to the r9a09g047 CPG driver.

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

 drivers/clk/renesas/r9a09g047-cpg.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a09g047-cpg.c
index 9e7bb65acea6..94158b6834e6 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -518,6 +518,12 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[] __initconst = {
 						BUS_MSTOP(9, BIT(15) | BIT(14))),
 	DEF_MOD("dsi_0_pllref_clk",		CLK_QEXTAL, 14, 12, 7, 12,
 						BUS_MSTOP(9, BIT(15) | BIT(14))),
+	DEF_MOD("lcdc_0_clk_a",			CLK_PLLDTY_ACPU_DIV2, 14, 13, 7, 13,
+						BUS_MSTOP(10, BIT(3) | BIT(2) | BIT(1))),
+	DEF_MOD("lcdc_0_clk_p",			CLK_PLLDTY_DIV16, 14, 14, 7, 14,
+						BUS_MSTOP(10, BIT(3) | BIT(2) | BIT(1))),
+	DEF_MOD("lcdc_0_clk_d",			CLK_SMUX2_DSI0_CLK, 14, 15, 7, 15,
+						BUS_MSTOP(10, BIT(3) | BIT(2) | BIT(1))),
 	DEF_MOD("ge3d_clk",			CLK_PLLVDO_GPU, 15, 0, 7, 16,
 						BUS_MSTOP(3, BIT(4))),
 	DEF_MOD("ge3d_axi_clk",			CLK_PLLDTY_ACPU_DIV2, 15, 1, 7, 17,
@@ -528,6 +534,12 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[] __initconst = {
 						BUS_MSTOP(2, BIT(15))),
 	DEF_MOD("dsi_0_vclk2",			CLK_SMUX2_DSI1_CLK, 25, 0, 10, 21,
 						BUS_MSTOP(9, BIT(15) | BIT(14))),
+	DEF_MOD("lcdc_1_clk_a",			CLK_PLLDTY_ACPU_DIV2, 26, 8, 10, 30,
+						BUS_MSTOP(13, BIT(5) | BIT(4) | BIT(3))),
+	DEF_MOD("lcdc_1_clk_p",			CLK_PLLDTY_DIV16, 26, 9, 10, 31,
+						BUS_MSTOP(13, BIT(5) | BIT(4) | BIT(3))),
+	DEF_MOD("lcdc_1_clk_d",			CLK_SMUX2_DSI1_CLK, 26, 10, 11, 0,
+						BUS_MSTOP(13, BIT(5) | BIT(4) | BIT(3))),
 };
 
 static const struct rzv2h_reset r9a09g047_resets[] __initconst = {
@@ -605,10 +617,12 @@ static const struct rzv2h_reset r9a09g047_resets[] __initconst = {
 	DEF_RST(12, 7, 5, 24),		/* CRU_0_S_RESETN */
 	DEF_RST(13, 7, 6, 8),		/* DSI_0_PRESETN */
 	DEF_RST(13, 8, 6, 9),		/* DSI_0_ARESETN */
+	DEF_RST(13, 12, 6, 13),		/* LCDC_0_RESET_N */
 	DEF_RST(13, 13, 6, 14),		/* GE3D_RESETN */
 	DEF_RST(13, 14, 6, 15),		/* GE3D_AXI_RESETN */
 	DEF_RST(13, 15, 6, 16),		/* GE3D_ACE_RESETN */
 	DEF_RST(15, 8, 7, 9),		/* TSU_1_PRESETN */
+	DEF_RST(17, 14, 8, 15),		/* LCDC_1_RESET_N */
 };
 
 const struct rzv2h_cpg_info r9a09g047_cpg_info __initconst = {
-- 
2.43.0

