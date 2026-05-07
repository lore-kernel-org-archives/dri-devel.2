Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28099CD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 09:23:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82AF410F13E;
	Thu,  7 May 2026 09:23:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="EpI0gzs9";
	dkim-atps=neutral
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010047.outbound.protection.outlook.com [52.101.229.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4957710F045
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 09:23:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLKkBgqDximcNfgtxQF/6Ya/TgINMn6JFRlyNSHGXAmX91kDFvkSN49sjVoDVzbatHDOyoVwt5kQfEW6/TB670CcDrL6VN0dh8RTS1d6oHFAzMLwAIMK59udvk8p1DeqSD3lbwQ77XlcfSAwEslR8L0z3RSVgw2YB8px/yBHK1uoVDjDuKG07U0cvzmKqHn5exYhjcAh3amjr9TfANfO5hvW3ZwDkkmsOjP5wMAPFf3c/0urRNP5N0N2EOd7zqFdnRLlBIum26DUlvCdpZOluNH7SWuXLeNS95CVZZaeRuyoyXOvXzu4Af88g1BPDfEb0Bp3kXLUFHOzilEdTEghIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1sRjZcH+K1TGTalzDqGsGfSTC5eYIKo0VKMa7qGj1Q=;
 b=HnI7p80CMFxUgufJeZROdsscXzdW24mVYUcFiVCYa8pM1bCSrk3zVbEj4f2L4Fb8ZqRg3cgdExU0zXl+vMn8nr0a6nHgc7RWfV3uirmrys5BONTm3ZXCAbfq68eAo9nSggqpnlvWomY1oTWHV9DMV56mZxi5pffwfQgBDwD3p3VLUFERBbRo33yWqWGyXQSwEjpOLW8kfYMeY9cxvDvmrb4YbZLII38UJgw8dVQl3El9juW33pa2VP6pmUjeWUr01KXQzztMOfokIQO/adSaVdFDtZCK08oIHQTiEVcArMxgt5gmioRQ8wvUbDKd3dwkky6LhIMRNQHS/t08bFMWmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1sRjZcH+K1TGTalzDqGsGfSTC5eYIKo0VKMa7qGj1Q=;
 b=EpI0gzs9ouzuxK9+hcmt914twxMkGaO0tY3iql9Nlow7U6fOteiYSmzVuq9YkQIFc0zj2nvIHHRoAhV4zlQLe/DoDr4D6vqNAsiHK8ENILxfpeg5yyntwZOGnD9bBjIkUs9E9evisE2gaZNBbXWEZcWDAkdXV25zuPjFB+mcHLE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYRPR01MB16094.jpnprd01.prod.outlook.com (2603:1096:405:2e4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 09:23:45 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 09:23:45 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com, geert@linux-m68k.org,
 laurent.pinchart@ideasonboard.com
Cc: linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v7 12/13] drm: renesas: rz-du: Add RZ/G3E support
Date: Thu,  7 May 2026 11:21:40 +0200
Message-ID: <b321c9c57c32aa17a294ff608b02df8746c220c6.1778141145.git.tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1778141145.git.tommaso.merciai.xr@bp.renesas.com>
References: <cover.1778141145.git.tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::6) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYRPR01MB16094:EE_
X-MS-Office365-Filtering-Correlation-Id: b4d082c9-e07b-495b-0ab3-08deac1a5663
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014|22082099003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: Vg/8sFWa+Q796+/cORaC+9izs/m2jMeSkmvoBsmuT3W6ymCz964HhGC/kWSH0h4fRzngT2BmLgajEwp2/0j0876QDvsE3LQPShYxT7HhWVtoyi9hQ4YwYN266nyWPj6ZUnZO3fl6HgklU/9V6ZTNhUdH03s80O3h0ZUbPv8ZENmMyxnZWK6sN6Q8ebaFbuQiUECeniiUNRgzX0vOilvBw/LXbb4TI/6SEKmKSjty763Bb57RZo16mK5ySQTu1lCxW2qwvNMI3GjtzO8pC/mlfyBePJqD/xrLYi3JEe2NtfNwebeq393g44/6PLQIFAz4iWFaxd4MNxnSPlVV2rXMI8b8RQM7W8rlb7FrHhW/qwVZ9hH8242s3Qm0MZeqL6xGkymFZgY4t27CuQMoCPndXuG+X5jS4FEQQ4/EJ8nI35Mn9jGA133VOA7Ctpac9AM52Mj/B1TFcbLXsvdhLWw8nYprpXdzbmavrlWZxrYPt4oExh0r082Y9PCydkBM4QFR8rstkI4tOh8okM8vqPxP4z6aIYbePog/XYiyvhajy7ZO65/p6gomWz9zvbAQTCUkDQw4WqqpK4EB+HA0CRa13IVjY6h6+bJQHlAboVMTSTxLupVbiVOstAdvoLxdn7Krtj3bRqvFMrzjCJY9lLFY/OH3oDztYD5B2DdrSoghvXu32egXYRkVpOXj3zCevi5P96BF7VjWqJlehbUzzRmEvzFPcXhiyl+sqi4Xi9vwi0uahj6ft1cwACvlDGq8pgvM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB11947.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014)(22082099003)(18002099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zGEwH/W5A0HDLPo9PQAtUckR3fxOt4EcxS/Z6JFifqS/Sd5xuQYP8D1vnnBd?=
 =?us-ascii?Q?RY+gW8DkhW4eQFLqpUwj/OeJjnl58htPeYelGWNK4xauro4SL/rru/LRFnF+?=
 =?us-ascii?Q?wO9Ztwy3VOLSDwQo+PoWqrgiNPpl7uZdovSdNwwLTlIOvnhJWkt9wfKk3zO9?=
 =?us-ascii?Q?UHpKLuZU7ZZyExZocWzQYM3ewHWMGUvBJcZkNAsSeU6hbPOqfPGjBHM1GtLi?=
 =?us-ascii?Q?t5HOujy4tKBOERbl76fhemO1clh9oLqrexFEwHml19mbiSg9KbTgk4WzgUZE?=
 =?us-ascii?Q?whxHnDRRGKMHyhuz9GsE9XHNMa9Qj8r2KzxPdYpVFloeftNF85qyZA4GJH16?=
 =?us-ascii?Q?OAHQWDom5vS22hLAtNSb1c7DKkKVVpmMc/NJhMXRt6XYmyOL3CT6jn+B5EeU?=
 =?us-ascii?Q?DhfdFEn9rmiKsW7TPPY0IqTLdl2mo8LKRAzb0x90fKIO8/TCwkfi3UUQ0Fp2?=
 =?us-ascii?Q?Y9IGw6CFZTaV1E5nxqSnWfOVzmT0xjkFWn8spScFSf9rkCxiygm90Qx/roAq?=
 =?us-ascii?Q?LkJMWiF12opD7oeUidCtVAHB1PdhlxnT+sqxJl9cw39ooTEdQuk4+qBEE/JG?=
 =?us-ascii?Q?EhHY8C96+tFaJYL+f8xlGvFc2ozP0W97ELYokR9Bk+QVAMWCZautNVAQrE2i?=
 =?us-ascii?Q?sH7SqvjZ47g9mbcjP29Y4FF/yUprqDjAb00RrrN1YgsK/jQcdS838qovSNQc?=
 =?us-ascii?Q?R5Yaa1mZQc3MQUWoimIhgFNuxCziA0GgxJtyr9A1IynyYWZUBrHqaQOZA3bW?=
 =?us-ascii?Q?Qk79k+V7GiVcEXT/SUUZFeaaDhO7aCYwckzefd7mITjgX/zzVxwKKNi3jbyE?=
 =?us-ascii?Q?58fLnWLivqV2UlJV4cYHjT/RUHBCqL+5BB1raT2DHELWiGwkVSmul2R0f6KY?=
 =?us-ascii?Q?TS+srGBhVWrqPNWFbpc/6nBovKYmLjPkuXMczd8owURaSJAJjLTCoNOuuKTr?=
 =?us-ascii?Q?TzCqC6uMaJmRxohFjN3ZtN+knauhEpXuRuZVENxJbK9vL9vEtRR6TIQspOdJ?=
 =?us-ascii?Q?8/95jCpK2POpE46rF0j88vkhCi6wDxx96OKUPRqZeAAWsaGQcBX3QrCTLlQF?=
 =?us-ascii?Q?1PBs3l/0A2BNf1kdcX/SNoba9oyh6Cx1RdUTapm6iuqrshDNdnmVQ7aJHI3b?=
 =?us-ascii?Q?zwTTQxjapY1A3y7H+/eGKbt577ge3jQNHPoz8GVmsZhPamakwIeDGdebSRPQ?=
 =?us-ascii?Q?ixBRmxDpqrMUJZLNd4RM86zL31Y0dPF7nyO3i9m/3S5OYyzE5OdD+0DHyKys?=
 =?us-ascii?Q?QjUEIbqhi7pPjiyei42RKKD6kjej0ESlPXNmzRBvplLrNzdTUvDvcGLq1xCK?=
 =?us-ascii?Q?DWGgX1b/dLwIa626x1a6RXk2hJgYfBjf4KP/kaF4nrM95GtgxI+vJjWGw5Wo?=
 =?us-ascii?Q?5PoOzveGu0TFIRJmZlBMiSHri1QU8ntFrti3emXk37kUBjG+DQMFs557uWCG?=
 =?us-ascii?Q?nZpZa+bGSDsJqFVzxMaXFE8jV+ypLeeAZ7DhiRWcnqqFl9lGTwbWrFmdROrX?=
 =?us-ascii?Q?RMwD/WJS2jSK5Fmy+/t4byy18UYCIUIA/y+W/jXnHPagAodsfI7AA0tW/7Tf?=
 =?us-ascii?Q?uu5YGcyTqN8/QBkwCGaKhgQyc/qRULGy/o/nMmnGGykIEd8zamvNiYsyB7L/?=
 =?us-ascii?Q?UnpA0k3363QY2Z6+rei57ZQ8rE4qIN5VliNOHaIJxKmZkXlQi7lNeUTKt5iI?=
 =?us-ascii?Q?1Kmr+WZM9h1PX9Z74VbfyBGFIa0X1JFWpeeMqjayq4VA/cuvknFhzBksEjB8?=
 =?us-ascii?Q?DQG4YIGeKo25htDsWA36ITeX4oXYlovPVMoQc1YVGZIwD5m7KrTT?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d082c9-e07b-495b-0ab3-08deac1a5663
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 09:23:45.5888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWkS81XKq0t4AW6z0H01gwvw8GkNFPJsG/9p09W6ii7HALlCTwmucP6QHC9fSQsschWzk023kl2589ZGqBP5rsQ920BjRULuwXXgYMUo1mMykK7gTxoos/pR2tgcQ+9x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB16094
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

The RZ/G3E SoC has 2 LCD controllers (LCDC), each containing a Frame
Compression Processor (FCPVD), a Video Signal Processor (VSPD), and a
Display Unit (DU).

LCDC0 supports DSI and LVDS (single or dual-channel) outputs.
LCDC1 supports DSI, LVDS (single-channel), and RGB outputs.

Depending on the selected output, the correct SMUX2 clock parent must be
chosen based on the requested duty cycle:

 - Index 0 for LVDS -> CDIV7_DSIx_CLK (DUTY H/L=4/3, 4/7 duty cycle)
 - Index 1 for DSI/DPAD -> CSDIV_2to16_PLLDSIx (symmetric 50% duty cycle)

To support this behavior, introduce the `RZG2L_DU_FEATURE_SMUX2_DSI_CLK`
feature flag.

Add support for the RZ/G3E SoC by introducing:
 - `rzg2l_du_r9a09g047_info` structure
 - The `renesas,r9a09g047-du` compatible string

Additionally, introduce the missing output definitions
`RZG2L_DU_OUTPUT_LVDS{0,1}`.

Introduce `rzg2l_du_crtc_atomic_check()` helper to store the routes from
the CRTC output to the DU outputs.

Bump RZG2L_DU_MAX_CRTCS and RZG2L_DU_MAX_VSPS to 2.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
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

 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c | 48 +++++++++++++++++++
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  | 28 ++++++++++-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  |  7 ++-
 3 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
index 3e8b6cca6d57..5c455391015f 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
@@ -65,10 +65,31 @@
 static void rzg2l_du_crtc_set_display_timing(struct rzg2l_du_crtc *rcrtc)
 {
 	const struct drm_display_mode *mode = &rcrtc->crtc.state->adjusted_mode;
+	struct rzg2l_du_crtc_state *rstate = to_rzg2l_crtc_state(rcrtc->crtc.state);
+	struct rzg2l_du_device *rcdu = rcrtc->dev;
 	unsigned long mode_clock = mode->clock * 1000;
 	u32 ditr0, ditr1, ditr2, ditr3, ditr4, pbcr0;
 
 	clk_prepare_enable(rcrtc->rzg2l_clocks.dclk);
+
+	if (rzg2l_du_has(rcdu, RZG2L_DU_FEATURE_SMUX2_DSI_CLK)) {
+		struct clk *clk_parent;
+
+		clk_parent = clk_get_parent(rcrtc->rzg2l_clocks.dclk);
+
+		/*
+		 * Request appropriate duty cycle to let the clock driver select
+		 * the correct parent:
+		 * - CDIV7_DSIx_CLK (LVDS path): DUTY H/L=4/3, 4/7 duty cycle
+		 * - CSDIV_2to16_PLLDSIx (DSI/RGB path): symmetric 50% duty cycle
+		 */
+		if (rstate->outputs == BIT(RZG2L_DU_OUTPUT_LVDS0) ||
+		    rstate->outputs == BIT(RZG2L_DU_OUTPUT_LVDS1))
+			clk_set_duty_cycle(clk_parent, 4, 7);
+		else
+			clk_set_duty_cycle(clk_parent, 1, 2);
+	}
+
 	clk_set_rate(rcrtc->rzg2l_clocks.dclk, mode_clock);
 
 	ditr0 = (DU_DITR0_DEMD_HIGH
@@ -252,6 +273,32 @@ static void rzg2l_du_crtc_stop(struct rzg2l_du_crtc *rcrtc)
  * CRTC Functions
  */
 
+static int rzg2l_du_crtc_atomic_check(struct drm_crtc *crtc,
+				      struct drm_atomic_commit *state)
+{
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
+									  crtc);
+	struct rzg2l_du_crtc_state *rstate = to_rzg2l_crtc_state(crtc_state);
+	struct drm_encoder *encoder;
+
+	/* Store the routes from the CRTC output to the DU outputs. */
+	rstate->outputs = 0;
+
+	drm_for_each_encoder_mask(encoder, crtc->dev,
+				  crtc_state->encoder_mask) {
+		struct rzg2l_du_encoder *renc;
+
+		/* Skip the writeback encoder. */
+		if (encoder->encoder_type == DRM_MODE_ENCODER_VIRTUAL)
+			continue;
+
+		renc = to_rzg2l_encoder(encoder);
+		rstate->outputs |= BIT(renc->output);
+	}
+
+	return 0;
+}
+
 static void rzg2l_du_crtc_atomic_enable(struct drm_crtc *crtc,
 					struct drm_atomic_commit *state)
 {
@@ -300,6 +347,7 @@ static void rzg2l_du_crtc_atomic_flush(struct drm_crtc *crtc,
 }
 
 static const struct drm_crtc_helper_funcs crtc_helper_funcs = {
+	.atomic_check = rzg2l_du_crtc_atomic_check,
 	.atomic_flush = rzg2l_du_crtc_atomic_flush,
 	.atomic_enable = rzg2l_du_crtc_atomic_enable,
 	.atomic_disable = rzg2l_du_crtc_atomic_disable,
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
index 887b840e63d2..59dd7572c730 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
@@ -53,6 +53,29 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a07g044_info = {
 	}
 };
 
+static const struct rzg2l_du_device_info rzg2l_du_r9a09g047_info = {
+	.features = RZG2L_DU_FEATURE_SMUX2_DSI_CLK,
+	.channels_mask = BIT(0) | BIT(1),
+	.routes = {
+		[RZG2L_DU_OUTPUT_DSI0] = {
+			.possible_outputs = BIT(0) | BIT(1),
+			.ep = 0,
+		},
+		[RZG2L_DU_OUTPUT_DPAD0] = {
+			.possible_outputs = BIT(0) | BIT(1),
+			.ep = 1,
+		},
+		[RZG2L_DU_OUTPUT_LVDS0] = {
+			.possible_outputs = BIT(0) | BIT(1),
+			.ep = 2,
+		},
+		[RZG2L_DU_OUTPUT_LVDS1] = {
+			.possible_outputs = BIT(0) | BIT(1),
+			.ep = 3,
+		},
+	},
+};
+
 static const struct rzg2l_du_device_info rzg2l_du_r9a09g057_info = {
 	.channels_mask = BIT(0),
 	.routes = {
@@ -79,6 +102,7 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a09g077_info = {
 static const struct of_device_id rzg2l_du_of_table[] = {
 	{ .compatible = "renesas,r9a07g043u-du", .data = &rzg2l_du_r9a07g043u_info },
 	{ .compatible = "renesas,r9a07g044-du", .data = &rzg2l_du_r9a07g044_info },
+	{ .compatible = "renesas,r9a09g047-du", .data = &rzg2l_du_r9a09g047_info },
 	{ .compatible = "renesas,r9a09g057-du", .data = &rzg2l_du_r9a09g057_info },
 	{ .compatible = "renesas,r9a09g077-du", .data = &rzg2l_du_r9a09g077_info },
 	{ /* sentinel */ }
@@ -90,7 +114,9 @@ const char *rzg2l_du_output_name(enum rzg2l_du_output output)
 {
 	static const char * const names[] = {
 		[RZG2L_DU_OUTPUT_DSI0] = "DSI0",
-		[RZG2L_DU_OUTPUT_DPAD0] = "DPAD0"
+		[RZG2L_DU_OUTPUT_DPAD0] = "DPAD0",
+		[RZG2L_DU_OUTPUT_LVDS0] = "LVDS0",
+		[RZG2L_DU_OUTPUT_LVDS1] = "LVDS1"
 	};
 
 	if (output >= ARRAY_SIZE(names))
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
index eed8e1215f08..649cd9b70223 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
@@ -21,10 +21,13 @@ struct device;
 struct drm_property;
 
 #define RZG2L_DU_FEATURE_DPIO_OE	BIT(0)	/* Has DPIO output enable control */
+#define RZG2L_DU_FEATURE_SMUX2_DSI_CLK	BIT(1)	/* Select SMUX2 clock parent via duty cycle */
 
 enum rzg2l_du_output {
 	RZG2L_DU_OUTPUT_DSI0,
 	RZG2L_DU_OUTPUT_DPAD0,
+	RZG2L_DU_OUTPUT_LVDS0,
+	RZG2L_DU_OUTPUT_LVDS1,
 	RZG2L_DU_OUTPUT_MAX,
 };
 
@@ -62,8 +65,8 @@ struct rzg2l_du_device_info {
 	unsigned int features;
 };
 
-#define RZG2L_DU_MAX_CRTCS		1
-#define RZG2L_DU_MAX_VSPS		1
+#define RZG2L_DU_MAX_CRTCS		2
+#define RZG2L_DU_MAX_VSPS		2
 #define RZG2L_DU_MAX_DSI		1
 
 struct rzg2l_du_device {
-- 
2.54.0

