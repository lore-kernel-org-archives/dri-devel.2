Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18107FD5F79
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 10:38:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CB8310E5B8;
	Wed,  8 Apr 2026 10:38:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="MBSEPD7p";
	dkim-atps=neutral
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010020.outbound.protection.outlook.com [52.101.228.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 626EA10E5B8
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 10:38:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOq7YdVcV1lV1FvzxXExWCgRtIRwrxEJutyHrcTOlcpzIKKq7Z00a+p/HI1fHkOINgqM7TiNFVqyIbMDekZAIVqnaLJFoD4Y5qnjghJNrjPBCsq2sGW3PeVjtN+YFsywOSCd1CTHsv4lae739jDr7f/WPs6ECyAklT05Hr31JtSsyyXHN8Cx9g71mqNKjiwPN39kyEcwYzxksLJYrJprQDOekALXETIa0Mw3qTfkqP63LpjU1Dq5B6EeI1utHs/vXRNJBinpH6XXW+qKLjK8TJR1yMfOyx9DbUq60rPhIjcvCcFir1NbnVZgksCH+AGMw21d/qrJmfWaeiJqCew6Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVIZSL8m/j/XQ8+Aq7y9H5Gmjpvp7EZzZMZydo1QYPM=;
 b=IE9I2AnRuD3GShkTMT96PJDX6roe3r6lbRrpU/dYr3uNH4ThbXWBPcwxLEkPqGtZ+EBy5vJxGG8kaRRPk+Ar5z8WysbZJQBZirILpT+2qlpB2icRvptBTNtYEVR3PgqD8RwVl0/uEeFcQqfx7zSu24NVnHfPEgLG8YAMWYdILHDSB/fPUBn878GQ14mJye4e2jj9P90YsxbPLiU0zo09hZiApZk68uQA3dhvC4aupYoKbJ7hk59aykk7KRJn5kWuTOUhIFIWaGMqOCst79pkMIsKBRENCOkDRHAUDnSp0LfFnXYLuei3Y2HOyJpRQb73TGyhyCFMldFseaPGm00IwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVIZSL8m/j/XQ8+Aq7y9H5Gmjpvp7EZzZMZydo1QYPM=;
 b=MBSEPD7p2rhaAbwFbJ8GSQwH36HQmaVT2Z8YIzFyaLx9JsUbqh7dMW7lUYA6kLCkIJkA7PBfi14wtWwOVpZjEHm/GlKVXfYzswWf1UO15r053BeSFyPrc4AZdkbg1vx3FrMwos9OPoXbhexVBHuwIELGL+ncYJ98Jlo1zvtUrkA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS7PR01MB13668.jpnprd01.prod.outlook.com (2603:1096:604:35d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Wed, 8 Apr
 2026 10:38:36 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9769.017; Wed, 8 Apr 2026
 10:38:36 +0000
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
Subject: [PATCH v6 06/21] clk: renesas: r9a09g047: Add support for SMUX2_DSI{0, 1}_CLK
Date: Wed,  8 Apr 2026 12:36:51 +0200
Message-ID: <9595f56ce8ab120477bfc11eaafb0f2b655d049a.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 58089e74-6b8a-4174-e617-08de955afd8f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|52116014|376014|18002099003|38350700014|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8c5TVlJx/P1S+soZxPhYTXHhu+/x0NNV0Q+mB1pxUn3q8jU9vCRqGTUu0lq7qRkb0m83JsSSIrF4j9yN3eeMDDAKLLe2oUroW5u6RxBEUycgvsUwj27W7p/YTCfJmCz3QkdN34qtEiC7N8ffg/IsUVNzNYUOV0sq0Z5LIFCE+s4yPrya34P75y3XYKUPNNpy+kAWcK3iUmuFISXMvXD5pDNPqkPpSetxn6H4qLkP1ubq/rFtps/VA0AQl13ggCeVTSaHRCHY+BuZmKYTwVAQRUvmfS8jhY+FTyYh9bJfyv/EXoUx580b/MXITw1SRDLUP8lSnaWk680RDLvFw4NNLuJK7uS1LHngH4McxHPlrdyX09h0Qd+r6bgdIttYGf0G4KzBMTB55xN1eZIZlYuSpZJz2TaT68S7HCEk/chZAjrYL+WeT2e0eulYtdkQ2/SjhPYBaGPV313zrxdg6Bd5XNLwXPxaSBe5Iwm/XbSrgCfUeQmHIaItu72rvrxawpAVlaycqUmXbrWNPPgHCLJ8jZkSVLosXHB/VqX1FHhmCvjvt4X+sT+mjApjIKuPcBn4KVEnfhAXYBZxlbUdkmoazSMoaBI6H4pIQtjgWWdOMPfnU6TCjwlvJ+ns1FmGM+fnQwSCVUVqo0NyIGrzfKQnIPzVFADYkZSr037QT3apXOh4GLNKzzvUMVcncHPDgQ6InWpqRWwosNePBHFQcMsU2/NsF6SuohhhLbiJbytyO+N6InEKqJ6+gzyhUkNUjTlFnA64QFhqJjTVQDs2PnKM0FXfY5PngvjEHOnD/LkbpGw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB11947.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(18002099003)(38350700014)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DrKDZ20C6M/3otHe/rlUJ8mvkD4ec5jGAj/iRVLlOSKPXeqUD/z96hKoZYqP?=
 =?us-ascii?Q?ldNvKc8AYEO63P9nAJ7nVLtxtUT9I3Nv2AWTrHoGdpnhtpc3eGFcPdu2RA9j?=
 =?us-ascii?Q?+3yhtReLiAq1N9M06b7PMWTH2blBGSNqHRwUAlOJv7VwQqsi2Tzhv5dV6T2w?=
 =?us-ascii?Q?oBmP3/3o2ceBrGxNLUglL0B9ejKEP1ou4UADKYmsl5B67KTy5W3LG6eLsxTH?=
 =?us-ascii?Q?9wKsxEXYlzj5b2yX8NQHRMDPRknzayNpjhzO0vNITZ35dOnJjuT4J8SzKh+V?=
 =?us-ascii?Q?FnUvalqFir5cSFYzBQLGtH/2Aj3KOneK7fIPXcKGone5ggTAQlXvdbhLSga4?=
 =?us-ascii?Q?K7bcWP30zwu1Mj5tH4Tvzj3+jkZo/dhrJW/ot6OliUJh/ad95JuarExGc6fC?=
 =?us-ascii?Q?T9/DDYijcY09vaMVlyiAHrcqS/Rxk/aUB6aM8cDpTmKtp5xG73sIUyNEH0Xt?=
 =?us-ascii?Q?VtSEInlOqES/TsPjDMt0ON93+myUWi/Z8YjzOXd6QfgmfMhcy5fPSBNyEWWe?=
 =?us-ascii?Q?i3SAfD+qtzoEFtqe6SIuouz6aa6QCek2PLRDeIi3VJdiR28OmgOFqxjAsiIi?=
 =?us-ascii?Q?L+EAfn4YRsyvr1mwNzy1lXDogMDPpssZAPlR9++ptunZXMQlvvz1y1td+7In?=
 =?us-ascii?Q?DOrPXmeUPbA8wCsY+pXRHUij7RCtphKxSYvZZ77IVdTQXLLreKoP8Fz2civG?=
 =?us-ascii?Q?YzphCSYEkLuI72Yr+3oEK6OAfTR4LWfd1KwqL9c+ulFbVyy6xvP+3WvFPuk/?=
 =?us-ascii?Q?/rOfDKtSPkLW8yi8I0fcip2WePm2EebWmR8d6EBMs2qOrjMuvDixlhZmSGhD?=
 =?us-ascii?Q?eEXcZzE/ZuCiX5Wgj+0FLXsTDzokl6VccZM8tbCJHfPEKDoeB0oDHjNRWUKR?=
 =?us-ascii?Q?r3NHemyiTQmOww10nffFUQ7FMM/Pj8tgMo7wOIDWsGR04XsTkaPHDGwRBTeS?=
 =?us-ascii?Q?mz/ZPi2qAcZiaLkGEMhf/LSXzeGemSLxOdOBWq+J2OlPpqYxKMgRt6XcTNCh?=
 =?us-ascii?Q?98U6EvokGKy8VVJW3Sntehu3TNmev7bXO5jQrkLEmT+nnlCgDjzTyeeoyYIA?=
 =?us-ascii?Q?/NIBczQy2bMWlIh+qIAQz558PZFapCyig/3REy5bAGy5bQvsA0U5SU08RXcP?=
 =?us-ascii?Q?IVR9i0omCVjNwBfW1ZAJCzotPOQw5YVNXg9GHofjApLtXTP8hxADohS/oW2j?=
 =?us-ascii?Q?Wg/NJil96bugPp/SeOHWIhEkd4UC7bIMwDc2urAlZUiMgOKAvAEhVdpGMbN0?=
 =?us-ascii?Q?H63AHA2gIQRZNIDG/MIwErhYEr86OfxuEuQQeBr5F23NQBL0ZogAYja2DBWT?=
 =?us-ascii?Q?uzTWKfUkm8RHemPIH8Pb0QBtoy7sSU7uANHyULFYawUpU9Kd/kYES+ohQjtC?=
 =?us-ascii?Q?qmvXMSq6Gog76aOgL5urcU4ibeoWqWBPfhzIGIpfPamnRBGXBj0rqLm5saAa?=
 =?us-ascii?Q?0Z+Bb3A4YeJIoGN5Me4O+z/og3+frLEiUceGgRZOsOeVE39CyF9DyOQwl49X?=
 =?us-ascii?Q?jpoodzkR2pyszol7cRTYJ0jxY9HzjPETW7km9Zbf8+RxIQURAQENT99REzPn?=
 =?us-ascii?Q?i7LTKyWc8ZvTrDrh9zAeDyjJXBofk626jPBWJ9kNZIwp8LDNCrNxsHjBNvhy?=
 =?us-ascii?Q?TnmHicOdwpomQNRCcXH3KeWGRW7KmzV9A4EiQDpaOVieMYUIvMq2KTSUaMgG?=
 =?us-ascii?Q?/r0PPjsisZJd8RP9wkKZliYhBS6UUiW7FG2+tiBgCN09cL0TFqjsSs9h/9mt?=
 =?us-ascii?Q?SUOJI0q51PhQFyuKmGMNKGkBs+wWx8seqQF+JI2ijymyVqcCgqk6?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58089e74-6b8a-4174-e617-08de955afd8f
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 10:38:36.8247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQxfgGrsHi1hj6wY53EoGHCXgB0r7JlKnBdpK0W3iJs6HKbJdAQE3DzV8XntXg9RpiWsYgsUpScZ/pCO8LEo0P2hG1gI5joGbiZQnTA7ZjaYOj4aoGowpxIwV0hnlUCd
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

Add support for the SMUX2_DSI0_CLK and SMUX2_DSI1_CLK clock muxes
present on the r9a09g047 SoC.

These muxes select between CDIV7_DSI{0,1}_CLK and CSDIV_2to16_PLLDSI{0,1}
using the CPG_SSEL3 register (SELCTL0 and SELCTL1 bits).

According to the hardware manual, when LVDS0 or LVDS1 outputs are used,
SELCTL0 or SELCTL1 must be set accordingly.

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
 - Moved clk_ids to match enum order.

 drivers/clk/renesas/r9a09g047-cpg.c | 8 ++++++++
 drivers/clk/renesas/rzv2h-cpg.h     | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a09g047-cpg.c
index 82aae32d50e1..de0b9c071e0e 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -60,6 +60,8 @@ enum clk_ids {
 	CLK_PLLETH_DIV_125_FIX,
 	CLK_CSDIV_PLLETH_GBE0,
 	CLK_CSDIV_PLLETH_GBE1,
+	CLK_SMUX2_DSI0_CLK,
+	CLK_SMUX2_DSI1_CLK,
 	CLK_SMUX2_GBE0_TXCLK,
 	CLK_SMUX2_GBE0_RXCLK,
 	CLK_SMUX2_GBE1_TXCLK,
@@ -143,6 +145,8 @@ RZG3E_CPG_PLL_DSI1_LIMITS(rzg3e_cpg_pll_dsi1_limits);
 #define PLLDSI1		PLL_PACK_LIMITS(0x160, 1, 1, &rzg3e_cpg_pll_dsi1_limits)
 
 /* Mux clock tables */
+static const char * const smux2_dsi0_clk[] = { ".plldsi0_div7", ".plldsi0_csdiv" };
+static const char * const smux2_dsi1_clk[] = { ".plldsi1_div7", ".plldsi1_csdiv" };
 static const char * const smux2_gbe0_rxclk[] = { ".plleth_gbe0", "et0_rxclk" };
 static const char * const smux2_gbe0_txclk[] = { ".plleth_gbe0", "et0_txclk" };
 static const char * const smux2_gbe1_rxclk[] = { ".plleth_gbe1", "et1_rxclk" };
@@ -218,6 +222,10 @@ static const struct cpg_core_clk r9a09g047_core_clks[] __initconst = {
 		       CSDIV1_DIVCTL3, dtable_2_16_plldsi),
 	DEF_FIXED(".plldsi0_div7", CLK_PLLDSI0_DIV7, CLK_PLLDSI0, 1, 7),
 	DEF_FIXED(".plldsi1_div7", CLK_PLLDSI1_DIV7, CLK_PLLDSI1, 1, 7),
+	DEF_PLLDSI_SMUX(".smux2_dsi0_clk", CLK_SMUX2_DSI0_CLK,
+			SSEL3_SELCTL0, smux2_dsi0_clk),
+	DEF_PLLDSI_SMUX(".smux2_dsi1_clk", CLK_SMUX2_DSI1_CLK,
+			SSEL3_SELCTL1, smux2_dsi1_clk),
 
 	/* Core Clocks */
 	DEF_FIXED("sys_0_pclk", R9A09G047_SYS_0_PCLK, CLK_QEXTAL, 1, 1),
diff --git a/drivers/clk/renesas/rzv2h-cpg.h b/drivers/clk/renesas/rzv2h-cpg.h
index 33bc3c27291c..dec0f7b621d6 100644
--- a/drivers/clk/renesas/rzv2h-cpg.h
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -121,6 +121,7 @@ struct fixed_mod_conf {
 
 #define CPG_SSEL0		(0x300)
 #define CPG_SSEL1		(0x304)
+#define CPG_SSEL3		(0x30C)
 #define CPG_CDDIV0		(0x400)
 #define CPG_CDDIV1		(0x404)
 #define CPG_CDDIV2		(0x408)
@@ -156,6 +157,8 @@ struct fixed_mod_conf {
 #define SSEL1_SELCTL1	SMUX_PACK(CPG_SSEL1, 4, 1)
 #define SSEL1_SELCTL2	SMUX_PACK(CPG_SSEL1, 8, 1)
 #define SSEL1_SELCTL3	SMUX_PACK(CPG_SSEL1, 12, 1)
+#define SSEL3_SELCTL0	SMUX_PACK(CPG_SSEL3, 0, 1)
+#define SSEL3_SELCTL1	SMUX_PACK(CPG_SSEL3, 4, 1)
 
 #define BUS_MSTOP_IDX_MASK	GENMASK(31, 16)
 #define BUS_MSTOP_BITS_MASK	GENMASK(15, 0)
-- 
2.43.0

