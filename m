Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F20F1073C8B
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 10:38:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ADFF10E5E2;
	Wed,  8 Apr 2026 10:38:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="J5Az9TnW";
	dkim-atps=neutral
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010057.outbound.protection.outlook.com [52.101.228.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC55B10E44D
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 10:38:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qdfj+CQGHsAkbFplgSl4zFiXK8tjbLjPBuhA7Z4BvYyhRiPtQhPAeCWWGpiETcGQCOSM3n+90bEmVfWI7cwzWIU6lEu5hY6DTwdnK+2PhBsagMrrCEVw0mzeA0iyC2NfUF8KyuHlCTWyeCf0oGLn8YyURmD8cQhRPd9TQutZm5gd9BxY1Mph2clIQiHqaq0wRRl/4JElQSRxnhNqr2tCwjS0ZvUjcNwFydv4NQyhtRe+hZBtvXt0jhmm2keJcoeef7/a9FJQTtkYzvfOaVsQzro4wQYQG44iiymMgdnZR0iMb8u/N0MKpxytj6EMHknWy+/vDGtkrVai2bDVwMrvWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9as/1H4WYXdYTtNqKElklpCauQOPgoZ82kQsuopQIc8=;
 b=uiEtzkh6+rBgH8HLw84IcuIgYkkXjJyutAs2pG9RaP9mN/Vj42Fvrf6khvX3xLZXOMuLU3UP4b0JfD48tYv0yLtETSHtsRbc/xMLIqBEUfvKOwNJuk4BTeZl1oukPIAFsHBkvbGiNgj+XJLQCDPo6HGquYSyvNQ8ozCQOMWpNn8Z7BIsgIfk0KJPvCCb8jyE4FEem9sWXtL/tTXkIGXa4tv1slplu7oxc74lFnL2UDHEZQAycilxQUGKX2AGolEW4c/+WJlF6/2G7hvytu+41CEG5cKZs3Ccbj2Z2gg1/vG8DcL2FQiadOKhvPrPgB1DGgo2xioPgPKXLB+2Og0v9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9as/1H4WYXdYTtNqKElklpCauQOPgoZ82kQsuopQIc8=;
 b=J5Az9TnWRI51ca2By9nQeHpZ2YS+tIj1Uus1qIJEwDnQERwhh2SnvxtL34UvJdyKXxheYmSYu7zVwg2qEl12JPVwjDNeC6U1tzq+fBuoDIuWEcIRnbF51FmX2vfHQGEk+d1fxA0T27ttYHD35+CYUhzcHC0Ck1tj85Jop159MN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS7PR01MB13668.jpnprd01.prod.outlook.com (2603:1096:604:35d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Wed, 8 Apr
 2026 10:38:20 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9769.017; Wed, 8 Apr 2026
 10:38:20 +0000
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
Subject: [PATCH v6 04/21] clk: renesas: r9a09g047: Add CLK_PLLDSI{0,
 1}_DIV7 clocks
Date: Wed,  8 Apr 2026 12:36:49 +0200
Message-ID: <e50c1721e1dc160e8b4518e8c5172f10cba4b58b.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: fb712401-c56f-4791-7005-08de955af3ea
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|52116014|376014|18002099003|38350700014|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4JhzQxf6CcoMzsJP2cF1sqiGomayCjanje+SyKIZzuWgrLCnzaRquRzUcgj+p0A6V5ngZSxcU72n7tbuCoBaKIYh1ipQ4AwDtjZdbPUxR74XdyZDIonIYWHXNsi8H9S5VlM8gp3IMn1hkkGuPiEauy55ICElzyGvlUt4PwtL//gbEV+aO5PqkV/ubY9vnyxp1spE3tXi3udre+m7zTOYgjWomfUMVFtOdyq2qCJ0r8yF7uOckZTBQXU1/RNN7uEIm4go/PzKmcS0ivusVURErfpaWhihpu6IdZ+9VRBy4QaMixJrtViKQNucQ0y4/V1uLsPey0Lj9ihNxsk0fIiD3ce+nLA1btclOgJZQvIHwqOUqmvjFFoTTj8QVuUepmB9BAJ0K2UyODHbd9nTVP4lysvLDQ3+LnUmejTv5soadi7EWV1EpDvzrNiYQbLjiuWesC0X6nvxu7e5ROLGnn/JGIIlxNLXaJVyAkraiC4/w71vBGL1rsxSHnkoEN36CO6v0TomnFowRO47L8ouJKmkAQZ0KIIuSncSmFS+m21RM9lsJLfOeDsIPdi/kpPHv52Qx+C7pYCJLIDpqBEZElXIcfhNynugp4l7aBgR3BQE8m6i8PqG8980i9Rtk9ESyuqa0dvIaqdt1WlisevPCM0aY+iZz59H+suCWPaWjptP/cocfZmIICRbscgVom+XVXF3fSvZmZU/jmqRI0cfA/e/Mqh1xpsNhktYJZwDM5u4Poay6h6NhbFW2V3vsu79MJ8etTO4QECMMaZqtrP+H7JCKHg2ZF3dvN1IlEdJnJZjMYQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB11947.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(18002099003)(38350700014)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tvgMisEQmLbKG7Yc2pB6sZ/gpV0oeY8GkqAldSfOoDjz/s+H982j1hzZIxgx?=
 =?us-ascii?Q?98riZsda7YO9iujz7fnojt1gdNvygAubdrTyRbcqFSCkFmxeiVlExXwnG9Ae?=
 =?us-ascii?Q?dHslABXd0vU8lJee8Y9Z/hglKWDCTv3kihq7TMjR0SzLfP9NEakKksB6gNla?=
 =?us-ascii?Q?2Cnc3vauqWkrMBR6dsallk95ICSjcLzoRXHAqbzziszawutAUWe9BcQCfvXd?=
 =?us-ascii?Q?heBoZa+8r+s/+4Cb7YW6+2eGbJnezVmgzrNkkDO7gRrVdU/hFDsOSxPKfg2q?=
 =?us-ascii?Q?HFgacen6IIEWQA8ItRBbOVuFzETpzDXSojCv2U8NnxiF701FD6RKEPkK6SIu?=
 =?us-ascii?Q?NEHu6oE5/bC5hy3Nf1qUymoHvorh1abQC2ZKJG0FbRNNV5Ej1zZIN5gFuVKE?=
 =?us-ascii?Q?OfUbSfIGzATNx/KehmoluuXZtNIX3F2LAw0RuzQg/Qa2QWvRl2TlIaHRpuL1?=
 =?us-ascii?Q?tZnbE3gjz+YuMiFr523wGtMmYjO5elIbiZ70ZsxlTlEJOzBi+y5d+tG+tLQZ?=
 =?us-ascii?Q?kR5IQBRPWeTZT140TlEDGcdmqDGxhH9Arswkd812IzF9XE1C5qLXzTLrhre/?=
 =?us-ascii?Q?457fbquWDR9JIrTmCw6yf8bX34ktQdk4C2681be/II3rNlzJL4rPCun2QIb2?=
 =?us-ascii?Q?vUj7O0QxigwC/rZ66jjZkFxFjR9V5CZ6v1u+8tG3xtyFJpA6LABg6OpNnop2?=
 =?us-ascii?Q?M5Vsx8+hAfewnX61gjAKlQ8wxsgB7/WNVt61Msp0l7+SvniXH+mYO+K8S5Tb?=
 =?us-ascii?Q?cDfQyVO15sOn5IS4FtCoT+AckFdFNX6aPNHskiM4JE2hPUwbG0wvLgJzAYzZ?=
 =?us-ascii?Q?7w5J2UVCSAHQ5KP0sGABU0uJMIZisNgHfM30iL+qkLWCfDp1CBKEpHQatnPK?=
 =?us-ascii?Q?dijMPVGCylY4I2z3gFuw2c14dl3YodAXoYbhkGQS9DMe8RUUViVHZuvSrbdV?=
 =?us-ascii?Q?iOlBx2ZSdpokWpExIcCWnDrmvoHqZVzdVr0KbouxNDItjkoeC9IKsgmhv/+4?=
 =?us-ascii?Q?y3LZGFKF3dqBUH8NwFixeM/BwuCrKfYJjQ2JBtEjF4dfhpGXF97lGX9fw3cb?=
 =?us-ascii?Q?ThnZM1R/asyPPoegRjy1osYDfYsaJfstLdb4ae/zemQmomS+U1BfxseS47j0?=
 =?us-ascii?Q?FWOvYG/4aQtvhO/8YcShMAnstPEXD4CO982bAaWKCYs7k0imlhnhnsrShKjV?=
 =?us-ascii?Q?FOpglTBANO0BithY6mlqdCIgWpR8L0DQRodkpWyDsT1BSLBBsY9edcuSV1fP?=
 =?us-ascii?Q?nHKbFNgDPGqs5MmM5RsU4tELWIij0CydoghePIuPn5lqHTHrjCKYZbZ6Lxij?=
 =?us-ascii?Q?Ai/GkfYbb9NHYKX8cpSCD2nnG4Qb8v2Ly/JCv4EFGZo84/dtnyAzMgdaBDOn?=
 =?us-ascii?Q?rx4o0nj4FNKMXNQ9R/iTPVqVuJeLjV2zYIvnlKieCaXSHB2Fh7esMymoN1uS?=
 =?us-ascii?Q?/Oawketb6cv6hx+4L+idp3ECI8g6P48bTRxlc+BPdPtfygsEaq7wOgnelUK3?=
 =?us-ascii?Q?GXfNWPXrlbq3R8cEoLmnojE+xgxRFgWXgw9gCwe7OpdErpdkoWt+mt5AkrIj?=
 =?us-ascii?Q?KjMnaZcXJo/xnaWSySDhoJJPvrn9qihGRivhdINjaP3rk8pglU8Q4NUUFaEy?=
 =?us-ascii?Q?a2ONmL+6ezMIy1DangFdemXBA6hEUhk97QmBD7pCld9lyDN1Z7HHMyqrwkfz?=
 =?us-ascii?Q?mpLGoFFfJmpuUdSddYB9Js03DzIdZN9j1own0GWTz8Y4DlV4wXNzfIsJiloD?=
 =?us-ascii?Q?HY73caDbLJDHL8ypttVFOUuIRa6PrX+lAokYYEqRau1tca7WZb/U?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb712401-c56f-4791-7005-08de955af3ea
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 10:38:20.6917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVJiytO4w4qoCdjc7GeGXstkrovzpU5msnjknM9JfKptGT4ymsYcWVMwW8DLT0NCpyHdDptqxdxqzFIIlWuWRWz7oXDPW6+z6e2o/s8HhfrFQ0hqRosnC5mRnGx3WhWH
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

Add the CLK_PLLDSI0_DIV7 and CLK_PLLDSI1_DIV7 fixed-factor clocks to
the r9a09g047 SoC clock driver.

These clocks are required to enable LVDS0 and LVDS1 output support.

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

 drivers/clk/renesas/r9a09g047-cpg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a09g047-cpg.c
index 87d5924f7e79..fd9b49c39dac 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -69,6 +69,8 @@ enum clk_ids {
 	CLK_PLLVDO_GPU,
 	CLK_PLLETH_DIV4_LPCLK,
 	CLK_PLLETH_LPCLK,
+	CLK_PLLDSI0_DIV7,
+	CLK_PLLDSI1_DIV7,
 
 	/* Module Clocks */
 	MOD_CLK_BASE,
@@ -196,6 +198,9 @@ static const struct cpg_core_clk r9a09g047_core_clks[] __initconst = {
 	DEF_CSDIV(".plleth_lpclk", CLK_PLLETH_LPCLK, CLK_PLLETH_DIV4_LPCLK,
 		  CSDIV0_DIVCTL2, dtable_16_128),
 
+	DEF_FIXED(".plldsi0_div7", CLK_PLLDSI0_DIV7, CLK_PLLDSI0, 1, 7),
+	DEF_FIXED(".plldsi1_div7", CLK_PLLDSI1_DIV7, CLK_PLLDSI1, 1, 7),
+
 	/* Core Clocks */
 	DEF_FIXED("sys_0_pclk", R9A09G047_SYS_0_PCLK, CLK_QEXTAL, 1, 1),
 	DEF_DDIV("ca55_0_coreclk0", R9A09G047_CA55_0_CORECLK0, CLK_PLLCA55,
-- 
2.43.0

