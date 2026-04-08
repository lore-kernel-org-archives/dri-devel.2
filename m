Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3ABBFD5F79
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 10:38:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FF3510E44D;
	Wed,  8 Apr 2026 10:38:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="MgSO1eOG";
	dkim-atps=neutral
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010045.outbound.protection.outlook.com [52.101.228.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0939610E44D
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 10:38:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIcCIVag0w5QbDIk/nli6lF8DftbbcK119UXZmiaiGmyWiNrDMUHQpFradnSX/pCulsTKM222qzsvya/hmRpo5AtqchDJZDVpjA8ALWJaKZ7w9/5ZqMuRZCgSB/mTXKGqvxBZcyi0nK85yTJPsz3pw+M9sHm+6KQVNWjAHnaJso1Tj9wGYTHap1Txky1SzuNKf3+BfQ3NtbJRcTu7w3PPHouC3Js12bw5v8HzlRwW00T+ozvH0AHAzo57ni7jOXP91j8DxcGOk6T8VGayyW3sEKla+fwwNkdhPrHJyHsE83FPQGG5DZVCFX1Sr+65F49bKAxwZdhLNz52dW644iagQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByPFflS3erzLGNWlNu3KyF1X687XSQP62ZovOah7adw=;
 b=DThGY3a93I0okw/J9wDmlh0OebhrdyUdzxzZEyTUp3KlEt2FDbNQ2ivwB6o2ot2LAaznOQRlBWdhPCvVDD0hHkInDPQ+hKYwM6Cfyu4qLYvFY5Mr04DSVzxPcDG+nrFt7ZmbND/PnBIvvv72/zI+x1zxmV4rBp9A8dMF9VjIkXQQ44kBhhmtNaYVUlxEC5SHfAJKEgpeptFN5Sb/k+p1uYVPZAu4da+KO1sXHHsj8aQRyvirRIgFsfukWRSR8j5tFZz4wupAVQzmVIds8T4HvCETD41yQPtvAId9gEgynffWLsIXv/Dk7eYxzP38Gr8QG6MDi0Qicjmsl5Qqq1oxNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByPFflS3erzLGNWlNu3KyF1X687XSQP62ZovOah7adw=;
 b=MgSO1eOG5AvJcGApmtf8bCBxx0DXeXdJlcVpjcmfrfxKd6+IDgf4y5WBGUoZNB/d/p+whmIGrpTWPZb6rOPV6Mv/GlAGvkl1xTeTtEs+yVqf/R0J1XT14WV0yJ7JV34mb6b0xlpbsLnkAEpqFtj7DEWPIfKz9nMHvYzooUvRhRE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS7PR01MB13668.jpnprd01.prod.outlook.com (2603:1096:604:35d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Wed, 8 Apr
 2026 10:38:29 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9769.017; Wed, 8 Apr 2026
 10:38:28 +0000
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
Subject: [PATCH v6 05/21] clk: renesas: r9a09g047: Add CLK_PLLDSI{0,
 1}_CSDIV clocks
Date: Wed,  8 Apr 2026 12:36:50 +0200
Message-ID: <4d5b4ddad89770447b3818381d5353f5065b72b5.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 748deb00-e9bf-4fe4-0503-08de955af8ab
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|52116014|376014|18002099003|38350700014|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: HkeBHOtIyxzKZvcnqCO+BQRgOy8lcousEyZ4IYKDLOfwNKc3/Fg6gf2qw009UjEGXnjLvomlakY1SFhCnU0L4Efl6+E5lTrFpZqZf9tTBzZ3IuDw4P1XkzKbFGEv95B5US1ORkAMtX/AlRKtSeaAURY/vY9ddsm/ZqTtZK+SsaWh+3Axnpg3M+LPfGT0/NIOUCIxklMlIXcSbqs+YCsEAg0rDZVo3yyB6oPw06/l9tstHGXLFMaNVwwDtqNG92p/YaAKvcvp8c9JLxISZ3Sf9f97ZZWLWbV9FwvW4LNe0lxuwfUzW4ZWUqQPwvepPD9UGLPAQ2VGfiz0Qc84J75Tft7+e/qDJklKJ3I7D10PCN4Lr8HvdAsuj6DPDncWU+ijhyw9j1wDmGBBCXgeU71gb7xqra+USkSKKx6TIj8Ykaul6LGc7wCK7FNlpzLmsIwlNeCIcX91SMLB6P6pVlKi8k0RawqJxHI+0WWF/mPh1U6PWCnm6C049Urb39ypFagzVsswz15hjQD+JShVPbqZsShHDZDe3ADVu1sSZXAFCHjGSX8YPHDZ55kO7AwBCMsoSy6A9u7VngpVStEghtuNPkcIsWL8C9Vql/C8yMIbGXjmzFAJGx18V7hCtsRB9Iz4NUrOncvYjb0pHIryx8SbB4dljmlFYNT/MJxgutAuz3V3PC0s81QuVpxWzitSTCKHn+DGBSzuLm8fILJEQ69jvDJleJgp33XGwNUZ3kXj/OOEGT95OTDSJ62ZmKHsseKKKuvT/2g0oo0eHTPcFwk4bNphJ4hJgxMdKEDT23yrTEM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB11947.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(18002099003)(38350700014)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W21O7KNar1dm3XqV9B0j+j/IqScyi3+gooHs6SQPAa5nKB8x8teFfo7vC40D?=
 =?us-ascii?Q?pEP5vioQS5UBqSxqglor2zvw7sxqoj4p6L3QhYUciBr0dwcku58tleC72DiR?=
 =?us-ascii?Q?qtZ8T2ZTipYhGj5uoJDp3fZaPrajFOJ3brAN/aNd+V5TSrlhsevnI3R0dPp7?=
 =?us-ascii?Q?ouLcVY3NSJFfpEEj1HO3OgghPVO41gmC4FJ0NLuwkqzZSEy+fMA2ncqpa60b?=
 =?us-ascii?Q?/KxvoL9kWzgFWWbItclodKhqMQVg36+N72jJ7XVl87CBJM+R17JdSiPeO6UK?=
 =?us-ascii?Q?BiFDMRuQGObRO3gVUcQZxCdzucMKfjQJr/EOrnbsH4Xo5tPs1mBEwC+lUqs9?=
 =?us-ascii?Q?8QsX3BGL9Yexats5RIPYKlBBK53vYd7yihawBUEd2LHW/TUiDXeUmCmoZ1SL?=
 =?us-ascii?Q?vQjX/38U6agayQrkbYOxiVR7KD+geNmwxtJB/5BIiPSp+Mz7Q9dbv3H0vtT1?=
 =?us-ascii?Q?lW5yj/S9ymBvZPhxAI9ZyEx+NBBNi2nG3FoJxWCmjtwQDY6t64L35b8JYrvp?=
 =?us-ascii?Q?5eTo6yb8F0KsYpnMxYw0B3A7wyO6+CczVj6oivU2gsgs3T8GB1uwSYwRa9m6?=
 =?us-ascii?Q?Ym390NNRZ0MiTSyY04EMObPLnN13Wvo1+xWE5n/6MZvmYfZ2Rw2auQgmuGu5?=
 =?us-ascii?Q?SEiKrkSelhj7M1q1gdxOlwb6Eos1ekN/Xj5mbf9Z8fI56e30KMe2FAhZdeKz?=
 =?us-ascii?Q?QqrRuZ+GfTI5fzw6OEgeQq8xBXfB/hVO0TG3ui+EdwP3MvmfDxEEBWElZHp5?=
 =?us-ascii?Q?8fXl8svVJKD2+xDSQ/zlIHcj58+M3EUFpLAd+87s1uPewhIwxZ5lOiaR5iD4?=
 =?us-ascii?Q?D+XKUi9WXttNV0Yf0bdiRJJhDRTr0A1tOwmnxN4ebB/v+eqGJ+cuf+ayu0x/?=
 =?us-ascii?Q?JsVRfgqze7vvMXyNlNoecQMgyllD/vf6mbDPz3lx7bMz7df5hy77+M58G2oJ?=
 =?us-ascii?Q?a3sFB2Tfl9QvTpRP8bvofLzjjKoScqnui3xoICTi9bsjBN5It0ix0I4dL4rf?=
 =?us-ascii?Q?2piEJpXoheC8GFnx7xsagOUXwVHySQx5msKJje33S44Q9XK8WJmpVI7TcpUK?=
 =?us-ascii?Q?ZxLldAbwVk8kOi+eC7a5g4PBOPeIJbCXBP5T1xGsPHmPvkORywGfpwOIJu+d?=
 =?us-ascii?Q?tZulu+4aakMZOa3GVvthh12vbjyBe5o86ZCVlG74HzgSDqUcQ34T4J71LXnu?=
 =?us-ascii?Q?89DoLq/gnpe/UOa42OUBHRKb+CqHylcIKcUuOuRTeALjFqoTGX2t/WZt5Tg7?=
 =?us-ascii?Q?NfngYjj47mT0wyOuTiKoF0a4ILFqr3weYztLIZQlI31ZTEtJ7hmjFxecX52L?=
 =?us-ascii?Q?ksNraTh+TrUPFT9W+j+S/MnzwHhdb8Tu14afY76xJXSZKJKFrKWoeiLkCOiA?=
 =?us-ascii?Q?6UEumpbX0X0qW4eLs2agJ6hou3xuAkTBTv+eK44PKNrSloSIiiTpah+6lMmQ?=
 =?us-ascii?Q?QqhVbpvD95xwvSt2vxsqaofK4laqXkUXemsYNXXLWVaWzELcS+f/jedVrxLG?=
 =?us-ascii?Q?XPAWpbWnlYi+BTb0zLLlwxrFMXDWY5dddbqxf7TUdhHftlmM1ySHkHiljWt2?=
 =?us-ascii?Q?IW92oQ+I1f8l6RvLCqvIspgNf0+bb3ZmbDifzRDa1ZM3w3sAQN4RrALBb/C2?=
 =?us-ascii?Q?RgLJtq06w+yklNv217HDtfnCBbEHuQyThoAWmIj4/kF8+FU9xKNgC+plzweI?=
 =?us-ascii?Q?n0NWkjA5SLJL5fsBAPBnIABx+dqNYnE5khflXLOZ8bIzYw6+wBSzNYRzJZa/?=
 =?us-ascii?Q?cC9iIP6NHWgYIylLT0yTV4gOGYerCo8pL7CGXPbseJT2LG9bxdD6?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 748deb00-e9bf-4fe4-0503-08de955af8ab
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 10:38:28.8763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjAYo4Yb/ETSBbfperMH//WON1wfSMOW+fVNwRwe9wCjnH+Sxnk9TZvBhFx0j3TCfSgXCRMvd/a0XZ1+bXWm73KDNlQhHzs3OG7cc/S9iGBTyjDulwK5PFOzNNJiHdEL
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

Add the CLK_PLLDSI0_CSDIV and CLK_PLLDSI1_CSDIV fixed-factor clocks to
the r9a09g047 SoC clock driver.

These clocks are required to enable DSI and RGB output support.

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

 drivers/clk/renesas/r9a09g047-cpg.c | 18 ++++++++++++++++++
 drivers/clk/renesas/rzv2h-cpg.h     |  1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a09g047-cpg.c
index fd9b49c39dac..82aae32d50e1 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -71,6 +71,8 @@ enum clk_ids {
 	CLK_PLLETH_LPCLK,
 	CLK_PLLDSI0_DIV7,
 	CLK_PLLDSI1_DIV7,
+	CLK_PLLDSI0_CSDIV,
+	CLK_PLLDSI1_CSDIV,
 
 	/* Module Clocks */
 	MOD_CLK_BASE,
@@ -98,6 +100,18 @@ static const struct clk_div_table dtable_2_16[] = {
 	{0, 0},
 };
 
+static const struct clk_div_table dtable_2_16_plldsi[] = {
+	{0, 2},
+	{1, 4},
+	{2, 6},
+	{3, 8},
+	{4, 10},
+	{5, 12},
+	{6, 14},
+	{7, 16},
+	{0, 0},
+};
+
 static const struct clk_div_table dtable_2_64[] = {
 	{0, 2},
 	{1, 4},
@@ -198,6 +212,10 @@ static const struct cpg_core_clk r9a09g047_core_clks[] __initconst = {
 	DEF_CSDIV(".plleth_lpclk", CLK_PLLETH_LPCLK, CLK_PLLETH_DIV4_LPCLK,
 		  CSDIV0_DIVCTL2, dtable_16_128),
 
+	DEF_PLLDSI_DIV(".plldsi0_csdiv", CLK_PLLDSI0_CSDIV, CLK_PLLDSI0,
+		       CSDIV1_DIVCTL2, dtable_2_16_plldsi),
+	DEF_PLLDSI_DIV(".plldsi1_csdiv", CLK_PLLDSI1_CSDIV, CLK_PLLDSI1,
+		       CSDIV1_DIVCTL3, dtable_2_16_plldsi),
 	DEF_FIXED(".plldsi0_div7", CLK_PLLDSI0_DIV7, CLK_PLLDSI0, 1, 7),
 	DEF_FIXED(".plldsi1_div7", CLK_PLLDSI1_DIV7, CLK_PLLDSI1, 1, 7),
 
diff --git a/drivers/clk/renesas/rzv2h-cpg.h b/drivers/clk/renesas/rzv2h-cpg.h
index 74a3824d605e..33bc3c27291c 100644
--- a/drivers/clk/renesas/rzv2h-cpg.h
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -148,6 +148,7 @@ struct fixed_mod_conf {
 #define CSDIV0_DIVCTL2	DDIV_PACK(CPG_CSDIV0, 8, 2, CSDIV_NO_MON)
 #define CSDIV0_DIVCTL3	DDIV_PACK_NO_RMW(CPG_CSDIV0, 12, 2, CSDIV_NO_MON)
 #define CSDIV1_DIVCTL2	DDIV_PACK(CPG_CSDIV1, 8, 4, CSDIV_NO_MON)
+#define CSDIV1_DIVCTL3	DDIV_PACK(CPG_CSDIV1, 12, 4, CSDIV_NO_MON)
 
 #define SSEL0_SELCTL2	SMUX_PACK(CPG_SSEL0, 8, 1)
 #define SSEL0_SELCTL3	SMUX_PACK(CPG_SSEL0, 12, 1)
-- 
2.43.0

