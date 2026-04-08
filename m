Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D81BFD5F79
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 10:39:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2F4010E5FC;
	Wed,  8 Apr 2026 10:39:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="UanaMhDJ";
	dkim-atps=neutral
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010062.outbound.protection.outlook.com [52.101.228.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1446510E604
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 10:39:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDpHcW5tN+QjMEV8GsKvI4SSAhmuP/pFKY7JfzBSKBa0rky10gOYpO07r3d+Wx5cdGebH2UR6RW0T7BqS63ceEAQ5Pj/jN8v9ZleUQ0DUHoem/y9rTm6Dy7Ok0Bj5IgIc9QJYsuT0hESz3Onr+HEGidAwxyhUP6kxeMJhMPSuX99IbC1Wlnhd/xuBoKtQ2K23nj/37iJ6kNOAet0aNXoWTcGn/AOY0VWcIztzoInEPC4C/3X8r50WFtl3u6Tfg4QT96fn3o0gQbS/x3P2/5nqq9si4CiZeNbNDaggZjWfnY029kdBgo30lJrzrym6mipz0eVTyJgLfe0qMAWLEkg7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNAc0gPQjoahvCdpD5ze6DQq7KTcjPF7sE0oP7A3XBA=;
 b=fgnLVTN+Y80mwMPVWgh1j0AZfw7Tb3GUHfxrVg9mM518k0jhd8YSgpI+mfpNROaq54pzIZ/QfmbkH918l85LrUD6G7rCZa7HrCdJSi67NiFrYxjkMWXRGW4Vz7RmhL68q2IBtKwrHHL/DmBEDWVUImbruqeRdTVhg6IO5PuYF3zJlOL9MZxQH7wkNncHzsu/YB9Iud8o9UmzdIFpKmjzx3bC+gHKJgnfxpHktSB5pLts1pf1fU5OKcflnZggVz5rDWYWDDDJ6AuMapkc7A2Gcl+YaYjc7FGWI/eF5nASBrBc8EptFR/H2Obp+1ktEHb6TkqYvwY7rwTGDeXEDVECeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNAc0gPQjoahvCdpD5ze6DQq7KTcjPF7sE0oP7A3XBA=;
 b=UanaMhDJAdOluMk2+pVghVmSGN0St4ppQTqVWBkdZWvhy+LM7NfNGnbtgrGyIc+Mq9bkaMioziyGsov0Q2nS80fsUUYrxY3O/8SIHZDMcr8RXSM3KYtWWIh1hUM6OPsj8PWKRivrH52u19nFIfvn9y9Z9mBpKVqMCBfviNZJT3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYVPR01MB11293.jpnprd01.prod.outlook.com (2603:1096:400:367::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Wed, 8 Apr
 2026 10:39:25 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9769.017; Wed, 8 Apr 2026
 10:39:25 +0000
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
Subject: [PATCH v6 12/21] drm: renesas: rz-du: mipi_dsi: Add out_port to OF
 data
Date: Wed,  8 Apr 2026 12:36:57 +0200
Message-ID: <d4d1d75183944f17d392256d9123523a6bd1a3c0.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYVPR01MB11293:EE_
X-MS-Office365-Filtering-Correlation-Id: 2293e441-a4df-44cb-3266-08de955b1a95
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fX0J2aRwDrBwmDEpTNx6eyaRnNGXnaNHFOcvVeWoqEUJYrRBsaZb++xUglRIlTHq3s2cWFRQ1E/xH8oNrcVfGgSf4QEhRfwkPfRTf5KBRSvkU23cTZFx6h9Hy8D+RsApmI+2Ms1c/sAw/3/RuU8Wiv0JhANs8LpOiX7yqF6nvuoWjhmLgFZ82nJyoNk3C0AQ3ZWS1Q6U6IuOsDnNLqE1eO4txsUGsFmymByajoWI0xxe/Yp4GWbo23hHHU8XdQmXJfaWBqcktwzajjSi8Ndd7X71QWfQGbNY2pHUlyJsOWEFB1DKiLdBJBdP8e9BHxSa5D/0EuSnZplDCjsIzta3vPi4c3ds8ba1yt5Vd08toRLECHFZQFyoTgKqz+fnAMbq/y1bNwQqnsgC3E/1uLETuaM16YhOijPl7wLuH15xAi3UjMupCUxafFYBNnwzcnns+2MGCWZBtvtdGcZby24Oh2baZ1q5yeTqKHPtAF6mADSJg93ukgnc9V7B1BAkswRWWPo5y87aUjtFhRt7WlOirMXj9bXcTrrH8+psP69fu55uHp+eLDnUJLCLzxfHhoXIuDjMBMI3AMmXFRydDdH7rFkgsiYDAgG0rcCuZk2GE8pTzAHaERWj9sOonnsBuPJwXM4CaQ8GhV3k1yqI3V4eG/fKvs2MUUCdfA3W30bG4Nnd9813bPX0fw3nD3Z1Gy4MclabvNcOO6yRc0odtDEp08LXEwoTjXsiMxW+5bW0lcJRkVXyknKn22E0DnLzlYjWsAlb/MQvm8ui0n/Q1nZG4KjfxXEGFApD0QhN8jf+C2o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB11947.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uo0Hs8/xyOkjZVCx3+C2XiZ0jN+3dbyiEKoGV1Dzdl1g5LDkVbnjOq8e+uuc?=
 =?us-ascii?Q?NyB2bua4QKeAbkDqoDWdFok6DFpd7kll/erN9PgiuGKpDM2aOv/fl7JaVM5F?=
 =?us-ascii?Q?Owl9fjLCeHxuoUdorBsxFvKSKmC/6h/tjYooAS6x9ZwcYItQiYebsz5ID1xN?=
 =?us-ascii?Q?pDUI/l4sdIJ3C9e+xxTzxZed2Zl9sK7d2wIvb03owxHaTeg31z8rC4Yzp+mu?=
 =?us-ascii?Q?OoXvPrQaI5eky9WP45SXISFD4m4hG2JtPBnL20h4QjNdMDQoRSHUo/W31Q/G?=
 =?us-ascii?Q?Irp0OMrtkOPhbzrWAxDMs1RGs+DiDQsxBJV/AGf3WeXa4IjNUVCaqJhnxR7e?=
 =?us-ascii?Q?7DDTLFSoFySYBTI2BWDHww+8a2AFpQk15Uxrh4sfNN2F/lPbbzTCIGGQg+wj?=
 =?us-ascii?Q?wHbWL2lTN+0Snyki63x8TPdKYKwQ+CWvKLr8GCN2k88LaTig3GgvV25RctBu?=
 =?us-ascii?Q?QtpbsvrKYJeqN/NP4raOXSjYAIo8SxKkAn/+5i/B/2nFgb/pI+fTuvnsv1L8?=
 =?us-ascii?Q?cO8H4swF6UQBN1Y44Jobco9hKiQw1ECYGslkMbBel8cfqcRX1LlTC5dyIhhi?=
 =?us-ascii?Q?egpz/q0btXeOY+rjDBliLUmULxfccj1c4hMjZ4tBE3smO3/Sg3tQeEEESRtS?=
 =?us-ascii?Q?hRWR9vXmGw1XN9YuaZz1KHVso/+bdIxn79wnyoRnG4zwUazTiitYsh1iddaw?=
 =?us-ascii?Q?Ey8PyNVCvTSaEYFjFKNeKxdjEfviEenVZ+Ska4yZNLLMLrY36BWNo81rXyJx?=
 =?us-ascii?Q?HohVZW1QMU9dFi8/AA2z8Y/KCkmnHjPxzm7rTjfT/dglyAXDGxIZlI1sTeEO?=
 =?us-ascii?Q?BlQXnfsR85PevZEnVSkIteitVgMIxAs34MtRm+nbe86uV41Tv1ceI80kiBBp?=
 =?us-ascii?Q?+RVekVOFfsnxqpoeYjUVQFC23j2cc0gN7L3Bew/lHShllpfLJttWuSRmKcIA?=
 =?us-ascii?Q?99DIYIOuUFCq+9FOpxIXK//Cn4peDcrxnoqae1XU4Ix7mOskDORADt1n/Dh1?=
 =?us-ascii?Q?ID/nQsUtdQamCQKaGSj19SgHc6wtpSG7zBmTdzJ3lfravI81Gxr/fGAl+Qzk?=
 =?us-ascii?Q?U+zYmzoe9+61GKsyZw1bW967oWHHLKmL/d64NOQDkuAJo71e+vxwyBiWUTUb?=
 =?us-ascii?Q?wLwuy4TqQSKc9GWn9A6zGeYyrc7GVnBOQWULu5e6q1YbFec6srJdj7P5IKM1?=
 =?us-ascii?Q?VMOBL05yp/ZzSg4A6kn8D77791LjwBe8JvqdWYMkF5M7NMZvMOvK7A0DkEC+?=
 =?us-ascii?Q?e168BchWtJqnTzY2L4i13IW2kz9bXLNTMEfOvGQnRWe21CoZ4gaKSE5YviPC?=
 =?us-ascii?Q?+tBj2FktnKNs8m8+dWqO04kdjwrleb+Oz+ahXZeouB16UsY8g+XfXOb6UUbK?=
 =?us-ascii?Q?+4Ow2LW+NhA3e5BOsAp8oJoGnI2sxV2UXpdJDvJuU6HmRa0AN7b+PwyPfzBf?=
 =?us-ascii?Q?2NkdlkuHtBhlX6g9hQCchiDeSqcwvj0Kj0siQyHB73vRTvAMLDR/F36q0UNC?=
 =?us-ascii?Q?drIQXoYV4IOsJsA3EghAVfs6ME/qB42HMzFWkDwSn4Hs4CUWGkCFcAtvxzOf?=
 =?us-ascii?Q?7WQQSUa2kUlzHRx7wCHHX2T9JXMMV8oZMG2JLUX2Eue/4/oKmBUNrJzxLAUu?=
 =?us-ascii?Q?dmjFH1crM/AaG0g+VAGYv1bVC70rpxdgOuAHB2Qgw4a6RSwxfSTdDBxAc6Nf?=
 =?us-ascii?Q?ge+o1MqlTe4ltXzYRv5AxedjWlFXOOTk83KC50B8A5ABmJ7mlOeQAMJZaM0V?=
 =?us-ascii?Q?Agmk9/BF5A1x/rKPfJUdw6aufgM2RLHqh6sJJeMGwWK5DzfHUzBN?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2293e441-a4df-44cb-3266-08de955b1a95
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 10:39:25.7438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chcor1iMSPHQhdk3ozBOEmFedcN8zK/pyQY+egibxoUgUjMUi2X+11IEWJ3nxBvmcpTveujIOze15jP7JN59qTaiiWFsAuMYRpiGP6gopXe8nmwEtVlboa0uBqtgLruD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11293
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

Add `out_port` field to the `rzg2l_mipi_dsi_hw_info` structure to store
the DSI output port index. RZ/G2L and RZ/V2H(P) use port 1 for DSI
output, while RZ/G3E uses port 2.

Update `rzg2l_mipi_dsi_host_attach()` and `rzg2l_mipi_dsi_probe()` to
use this `out_port` from the OF data, facilitating future support for
RZ/G3E SoC.

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
 - No changes.

 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 715872130780..be6dbf19a24e 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -58,6 +58,7 @@ struct rzg2l_mipi_dsi_hw_info {
 	u32 link_reg_offset;
 	unsigned long min_dclk;
 	unsigned long max_dclk;
+	u8 out_port;
 	u8 features;
 };
 
@@ -1158,7 +1159,7 @@ static int rzg2l_mipi_dsi_host_attach(struct mipi_dsi_host *host,
 	dsi->mode_flags = device->mode_flags;
 
 	dsi->next_bridge = devm_drm_of_get_bridge(dsi->dev, dsi->dev->of_node,
-						  1, 0);
+						  dsi->info->out_port, 0);
 	if (IS_ERR(dsi->next_bridge)) {
 		ret = PTR_ERR(dsi->next_bridge);
 		dev_err(dsi->dev, "failed to get next bridge: %d\n", ret);
@@ -1411,7 +1412,9 @@ static int rzg2l_mipi_dsi_probe(struct platform_device *pdev)
 
 	dsi->info = of_device_get_match_data(&pdev->dev);
 
-	ret = drm_of_get_data_lanes_count_ep(dsi->dev->of_node, 1, 0, 1, 4);
+	ret = drm_of_get_data_lanes_count_ep(dsi->dev->of_node,
+					     dsi->info->out_port,
+					     0, 1, 4);
 	if (ret < 0)
 		return dev_err_probe(dsi->dev, ret,
 				     "missing or invalid data-lanes property\n");
@@ -1525,6 +1528,7 @@ static const struct rzg2l_mipi_dsi_hw_info rzv2h_mipi_dsi_info = {
 	.link_reg_offset = 0,
 	.min_dclk = 5440,
 	.max_dclk = 187500,
+	.out_port = 1,
 	.features = RZ_MIPI_DSI_FEATURE_16BPP,
 };
 
@@ -1535,6 +1539,7 @@ static const struct rzg2l_mipi_dsi_hw_info rzg2l_mipi_dsi_info = {
 	.link_reg_offset = 0x10000,
 	.min_dclk = 5803,
 	.max_dclk = 148500,
+	.out_port = 1,
 };
 
 static const struct of_device_id rzg2l_mipi_dsi_of_table[] = {
-- 
2.43.0

