Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D771073C8B
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 10:40:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E089610E60B;
	Wed,  8 Apr 2026 10:40:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="GXDx8mDv";
	dkim-atps=neutral
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010042.outbound.protection.outlook.com [52.101.228.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F3A410E60B
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 10:40:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUjqVRroNlRTjQlEOs7tIuJ16my7TEBIfuvsuRFshGMC3GZJMh0TOVz4PBLeaafCxNofsITpbAYb5I9KJletpaAgrqyFhUKfX3LEXeqhYNkIDK51hW/daIT7bF7wfiDaysaYkS/ASpZd2mV/2Rt8M5mWluu3RwY4cBr5EC6w1ViyR0MUDzHKOWvA4RYlRBAjOIbkoxlbgktvTV2Kzsehud491z7ze+UMvgTLQ9TsbgQoSpDJxQdgycPtM+Ek+rXiSU6ayaHd347DqoLEhq3HLzIJEghb1OFt1mZ8XlT2/L7LILHjwBfChTXoHgtVNXm+xNuBenyba9sOTpQY99be4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hZ0N97yHXwnmfQtPoLOp1Eskh3f+tM/l9HEcYrKv1o=;
 b=XACGMIb2Bz/h/6f9APSaNJQKuENLzuflVrQrGO0EYq9kfDxSkkw6K5t7JK+bQjgw06o2ynGGs2akNBUpwYlXSUZVyOmT42lJT0k2fTwb3Git4u/uTD84LbtiLDnMn2ukCUv1h5/3I4C2dqNgTgcEN/rCiNd1di4GCAakB+QkbPHG4a3jZSa7FJFLyyEiMrAl6QbM06pQqHbtekthR+/VA1Zvxk4o5zTu2T0vEF+l/AY4MacjaH9rRowrkxE4J+PcnxwSkXcOtdXKxQtF+7M3G9AW2rF+KkpViF8iqoB4lUVP0NyrEwZ914qI9eKTSAq+DB2p9i3gyRtNGVoGys3xnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hZ0N97yHXwnmfQtPoLOp1Eskh3f+tM/l9HEcYrKv1o=;
 b=GXDx8mDvqe7YlNDInKnjlFTehvPiYiTnY1w3o1uHP4XFQM1AjxChJV2XZvRNx05XoY0bMKDHX1GUaBTi84Hbv6LROpBvXbNIn//f9R54mtz4b+dv82hg2u13yrJCDqDJTOCruw5mcqr8HYNxdxOZYVWrOnJS7SP8ApHf1ftLgFI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYVPR01MB11293.jpnprd01.prod.outlook.com (2603:1096:400:367::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Wed, 8 Apr
 2026 10:40:23 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9769.017; Wed, 8 Apr 2026
 10:40:22 +0000
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
Subject: [PATCH v6 19/21] arm64: dts: renesas: r9a09g047: Add vspd{0,1} nodes
Date: Wed,  8 Apr 2026 12:37:04 +0200
Message-ID: <46547aaff3cdb8ea6e17cf1fdec699d83a1cd71b.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: f169cbf4-c623-43ce-1f6e-08de955b3c9a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: iYV8N1wRQY12bHVsHY3mn3k8SaeMdk4ob4nHwup0igPn8T9G1td7JVw7kcloAVCXVdBpYDTI+csXxV6Mi2tSg9L4DDMzAbh/h+ICIfqSHdKIetlgkQPoK8/5BxlIN/sPNYJlxxWVIOWLxJ0V9IVphlfuMO/nyr7bQ7uH/Bj2EGIaww3YIAKI1h6KGRh6gL1h8MNwd5oLw6N18oH4ISVk4K15Zo8z1M4mnmSN9q6MIlnxKxYV4Sh1S351dc30Pm8CVP3RuvQ8lDR1BZulbRhUB4Xj6N5GQra/LlNB5/UlAyG4ZMOESXlaro38MsNmDJI+cGCPLcQnxMI13XBpioUoHZrvcx4wdNLl0thmRvPXtkLXb1MEJ+aVqvh0htYaHjB/WsqUVums3j4yXvAgosNPKV26VhRb6NngB2BZAEIt1eJssDxomv2/KSeo1l3T38WrhMGk4lTEU7bdImKY8ZsxkYacguew75KOoZxSrFcvjtwzFSRit90R2YcWpABk99605VyX87aiDQophuNqBU9stT1OViz5OfvAWctpVExuHLHGiNRESJhDV/zyKynBL14oaWnw69tFkgaEIfp79uRSgMamHjIrAgC7EWmi4guNhU1F4XAkgbom9cm8dGObwjNTSzLjM3HjvHyGycTSXyGREacFm89/PqomCIWDAygnJ8GNjQKSq10rSATi2E9osnTv+jOsLHpq58iajT8A6mD297fA+GXudADZOCp8z9Xaq3UMpfZ90uhiLbqeFB+ooR3qSaaFoO/8bzNshm3WA6WjUnb7qEipxt2KSYPn5s6aWtE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB11947.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CCnJ9Xufe7kdj/51lE/lMdO1QwNqDCIj+Mc5+C3NOj1zXwHr6WJLJJC8bOwT?=
 =?us-ascii?Q?uihHxH0ZdNUOf9hNeh0qCj5sb3NFS+AcjGd3AF9g9MVseMPgbHsNaMi0u4SQ?=
 =?us-ascii?Q?Hqt46yTWK5XYDKK/wYBm4zZMIDOLsdp5jDhW+k5S7lNlQJtLarYOMQZn7Us3?=
 =?us-ascii?Q?iIjQC4ciuaMPGFvR2Smy+s8nfTR28vqylf12kcNh0rqMiNZOoabl2imKWYN3?=
 =?us-ascii?Q?tgxahut0cm5vjAO+IA+DZrx1W5ua0RnWpEmSHHGhkNn24s5e2GWHZZVqiO+J?=
 =?us-ascii?Q?UfZaDXMwUAP3cN+wrJXEnUqF0pZyq0E+YZp/W5eewnlnZ3vfIbuOCCac0d1V?=
 =?us-ascii?Q?FGg0IweSnycoMFuPgnVASzcLMqGIQ7qswX/7fm248JRkt4c9whM969S8tTcg?=
 =?us-ascii?Q?EQZYLiM9y37F+8EHk0WdwNvGOwCwzIfplsZ2rulp+WQlN63ZtYUmbHCSjOP/?=
 =?us-ascii?Q?Ier6bsmOAqDp2BnecYkcPPnb2QOwDjzzgSQ3USXmAJlCDNOcnBc/eAQ6o+7a?=
 =?us-ascii?Q?jyD4fOBa7R54uwpY8uKI7TXErXr3fFoxEv8wcnOCvKZ8/UE5uI5ojaNNerBp?=
 =?us-ascii?Q?8IsxlwKP6kJlwv+lMjvOAauuuGGKVVB4H1rLzh/b4A/rG+8ckx3FZHewDl0l?=
 =?us-ascii?Q?iQ9viJhE/TVrJtkZT/JEXJKRNzAJvGDE5UtLeAzo4wIrFpVVSK6j8UcAVgdE?=
 =?us-ascii?Q?xcwxwlXycoBf5oGDljMmJbiSQi8hP0qCe16dFbzt4r9+D6S6iC4GYcmImXCm?=
 =?us-ascii?Q?1V0I08Ru3/Yfc37/zjYGd3+Vn7blP34P6Ip/9w70bzAqMOtJpuL8AEiijyWa?=
 =?us-ascii?Q?+0+Ho8OHpKaI1to1AcZ38mPRjRFECUWpHWkoIabIJ/cJtiS4iEHfyiaJv8AY?=
 =?us-ascii?Q?Vxg7OFN90MllgzGP00Qb4lKv6EmkWAdczFWjh0MOebe00YA1FqAFL8WypUb3?=
 =?us-ascii?Q?9gMpKfMTYeT0zdwwnrlifMzV6+ErMiLGp/7RU6JMNCfqU6ufD0t7ne8xZkER?=
 =?us-ascii?Q?KGzMPeSXFggeVzfV/RP9AcWs8pRYr5r1nIIzEPHOHFmyQZG9ErTAlE+xATVL?=
 =?us-ascii?Q?HxFg32KMbzOaE/kE92Obn9+rEO6c5RoB6OmxI6qolksBmaOmVCkHpcHM6kIG?=
 =?us-ascii?Q?7L7B49w+vAdhQTxWO9Mmc8ufMw81p6S9GAgzwVDvBT6f1XzEqw0WSAZFgxF/?=
 =?us-ascii?Q?5DSEgwGuskQy+8PNrjkgotTQqmQlVgFIHKKtFT+5ItenAyRzb5i0Gz0LnxWr?=
 =?us-ascii?Q?/GF/OwmToQS1VHm0ODDBEGngTikbIY9Bsz9iCREp7LEJJ77y97WnvTXCesUz?=
 =?us-ascii?Q?yp7+jCdhg8CT80QESzWS/6KEwFZtwaMnk5vicuzsG0g8sP3x5/3tSnDTd7Kx?=
 =?us-ascii?Q?Za9M4qXTcjsZNTD0Lb8Rdwe46OMwEQd3O8u1SWjkM5GtCDMsHQcuQBgAJ+bV?=
 =?us-ascii?Q?nNPhCDBYAwHCaInuYIPSdCArS/Ks1WmL4Jmd57kwHDEm79YNdLs3l0IjYN82?=
 =?us-ascii?Q?8Na3VkE6Y+Uybv+337DGtHLXyT225Arn4ggDIJ5HqF+yXpnbm5hbshCvh4Gu?=
 =?us-ascii?Q?2QrQCz6QHgOyiWHwBYt63aiQnW8717ZpxeQ0Cv+VtTrHEeRrDcP1ppg9YY4b?=
 =?us-ascii?Q?Do8FZAhM9PLcVpQZoNLTLXDYp63fB4svjXcuF/J4w6eVeWyQxoWZJ1N4c9NT?=
 =?us-ascii?Q?IoEW2wkAzoG9M9wvMKFqWibqHCkJ+gFDz2jJlJTJLe7XP68rj025ZYAIBmyq?=
 =?us-ascii?Q?l66k8IjLfEZ1lrqkmnK/zAViK1cL3BtEVhM7ORTvpv2iDonnF5yE?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f169cbf4-c623-43ce-1f6e-08de955b3c9a
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 10:40:22.8599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +SbHEpIGXmb090UFuRd0P4ziaSsAcX7mny1tSWc6oqhk2CUFg6QnDYzI+18cxP9GPZaENNEgFq/Rl3oatNfN+x6vV45DOcnD9iYM1Vpgp6fPqzYeG2bUNlVJpXiDW/OV
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

Add vspd{0,1} nodes to RZ/G3E SoC DTSI.

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
 - Squashed vspd0 and vspd1 patches into a single patch.
 - Collected tags.

 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
index 3115ab4b050f..f2fdaadd9d39 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -1608,6 +1608,34 @@ fcpvd1: fcp@164a0000 {
 			resets = <&cpg 0x11e>;
 			power-domains = <&cpg>;
 		};
+
+		vspd0: vsp@16480000 {
+			compatible = "renesas,r9a09g047-vsp2",
+				     "renesas,r9a07g044-vsp2";
+			reg = <0 0x16480000 0 0x10000>;
+			interrupts = <GIC_SPI 881 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 0xed>,
+				 <&cpg CPG_MOD 0xee>,
+				 <&cpg CPG_MOD 0xef>;
+			clock-names = "aclk", "pclk", "vclk";
+			resets = <&cpg 0xdc>;
+			power-domains = <&cpg>;
+			renesas,fcp = <&fcpvd0>;
+		};
+
+		vspd1: vsp@164b0000 {
+			compatible = "renesas,r9a09g047-vsp2",
+				     "renesas,r9a07g044-vsp2";
+			reg = <0 0x164b0000 0 0x10000>;
+			interrupts = <GIC_SPI 921 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 0x1a8>,
+				 <&cpg CPG_MOD 0x1a9>,
+				 <&cpg CPG_MOD 0x1aa>;
+			clock-names = "aclk", "pclk", "vclk";
+			resets = <&cpg 0x11e>;
+			power-domains = <&cpg>;
+			renesas,fcp = <&fcpvd1>;
+		};
 	};
 
 	stmmac_axi_setup: stmmac-axi-config {
-- 
2.43.0

