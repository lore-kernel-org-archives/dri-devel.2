Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0954606A327
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=Z9btVpLB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F02FB10E6B1;
	Fri, 23 Oct 2026 16:50:20 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010037.outbound.protection.outlook.com [52.101.228.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FC3410E6DE
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:49:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sx6MSHimkgs5Mm3TzX8eLJ0Vk5PcjNSPCyibX9uYPzbPBu5Klg5lYlfvbEiJkqyTOmwYBKyRKBHvhNskxEiRX11Ws/Dyc0IOiOWlO7JtRyhcCEfkiuQcX4NuQ8fAhZ+9TJfry5NTk9e1KGTh7M0wCHShJOlpEV26WAZYodBVLsxj8TF+fkVfJfZpmVaAdIVnj79yw7nrEAFojz8keD95jtm/bV+1iZ3xLQzqu+R+xPOxnSPgAfX2l7a3wluMOVR/0qgzC0tn6XHYteZmo2QweH3gQFApUDCImXudU+Eti97TB5wdB4iQqYfxWyHvm0SIcRp2PnshI+DnhVnpvAohgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lL2e9yB2Wv1CSKTWANwOy9hCtXGG7GsIMOA3c3krRs=;
 b=g+LZIKK8K5IcAJHtimv4OhqR/D+A17oYo04PgyKXNBPIc7trKwfhyj11ID29z7UDXiu9BTk8CnVtFGRfxW/WoChi7UFV/dBkwX6IAML/WfN6aXmRn1W65tdm14pRJ8OCuejoxngQOijkHRONrBDG9gWY7ONTEhBQ142vtVWXEqfmu6fyE+g+gfofTpCVteXVywqkW+Qvd52X7N0MknKqbcmx/pxyYg1SEmX2I6lN2ksvfDpxSvkAv8KFEs2NXNe6qXFP7sKjNpvCxaGAWLiT8XEfBeMTpTooeTS4jCX7GwmFQ6geDBnKgYrZP7CnI0H75S9m88YJ8KdNuZ/0NqXEeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lL2e9yB2Wv1CSKTWANwOy9hCtXGG7GsIMOA3c3krRs=;
 b=Z9btVpLBsjCSPxOvIUNMRmmLAAjzJq1ZseZKR+uc7Yn94H4kXTj918caETZ08ex9yflJx8Fw1pyvyQj2j8ru/en2jN7hIehMsslTev4ypAwNdLBa5X5Rme2t/ItpyU+aAXpn9kXYW21/k54h3FlH56Dk7Yf8W0Clnx7K2fkjOtw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by OS3PR01MB9415.jpnprd01.prod.outlook.com (2603:1096:604:1c6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 16:49:40 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 16:49:40 +0000
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
Subject: [PATCH v9 10/10] arm64: dts: renesas: r9a09g047: Add DU{0,
 1} and display subsystem nodes
Date: Fri, 23 Oct 2026 18:47:43 +0200
Message-ID: <4bc427630fb9c4a359016ef7609111e804c8356d.1792770965.git.tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1792770965.git.tommaso.merciai.xr@bp.renesas.com>
References: <cover.1792770965.git.tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::15) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|OS3PR01MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d41fc2a-e82b-4255-d400-08df3125a075
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|23010399003|1800799024|261009223027099003|261021121427099003|261022105027099003|261022075727099003|10067099003|56012099006|18002099003|22082099003|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info: XneFqHeSCgv4BqeWR3sMWjgQjYjZYwD1zOsDQ3Okpn93Bc6KD9+43BPWR3VT5CNOOZSx2WpIy7dam4Fbl8ImpxGVCkS38bKqhahFoCk+e5XeNlMt5yrsYRVoOU8Ay5BNanJpwRT8ing2PxTdzi9BNt0WES2YuXRP8U+tNytwjuH4VyYcgnhpW+AEXrLhFJ1Q3cjD3AAjxtwz60n00WiBlf+a6bJkCaLm3On7vmiEWUuMV/G5TWzkmzY9VXRsxMJ+oznr/xGgK36GTCHugideQjLQ0My4HTz075sVIWz5nYz1w8kAS7c0AI+e7bVWO5zHWGNp5wULj9pKKL2mNax76YH0TSlEI/8ET+ALmLmg/yS66r86CU7tkA4vt/vzSv8SvfW1cZJdMcgnovPFjNh4XIKapiKRhRT3RsnRwBoIyBBUS/xaxx9Siq+8a7fYA2X0BETJTFvPBHsx9I4J4vb2HA9UXqxCRonXmfha2BYjwhnkhaV0fjOu0PioywGMkaLW68qHRXHq3gie21xskk9rfPv2zO4H6ju5DUihRs82Zbax84Zvu1BaOepSACmVF9/BF4Ep2eqxolaXHIdUqOvh5IF/9f5PweWz+f92Kt3e//t1Dti9P/lUbBq3wy9uXkkHk6dc7i5RGZ7PixSF2+PF1n7elBRXVH2IrFMxD3xm2EseYpu9bK3TKR1pOORscVFwGS129/mCVmPw6N5DFTF/YqIfCkrVMDoTRIk1FdJci/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(23010399003)(1800799024)(261009223027099003)(261021121427099003)(261022105027099003)(261022075727099003)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ej9oOQfLRpPG5A3LrgiTTJg53yq5yyQuZ9mQRLcqcEbFJYO/ljsCWtGhGTcx?=
 =?us-ascii?Q?U4CRujoeWaTogima6qhgOHKzS3xWOr3QYQDhP4Q9frG+N0MM52WxhNYCgTUt?=
 =?us-ascii?Q?BycWCKoXFlSY8HebmxGlzQsySfifr7qwtdM8TKKRvHD0xVrp8PCYGgOCmAZg?=
 =?us-ascii?Q?V8Vq7LTnDDQ8BklPWQtiXbfd8gpYYFenKfk0+ArGPWQoNrBR5VwaE3FtI0Lh?=
 =?us-ascii?Q?70o8pj0rj65fylDq746xjQlOjd2D1jduS0CokAHU2RVODEDkH3/SoPiAR8vf?=
 =?us-ascii?Q?H8/BsDIxQUvnqu9OT1axSPRUZ3YJS4jTKE+NKZFay8roPRzhh5hx3mFqPYkb?=
 =?us-ascii?Q?WCkVtdxWwy6JZkUwA81u+C12DOjdRPTA0coFWrBNku9d4Gulp+Wka9YbTGMH?=
 =?us-ascii?Q?4iDYOulT+Vi5OVcXFqtkNRd9PRGJuYbPvn35luiGqvo0+54UWu3TkAC0s+4l?=
 =?us-ascii?Q?arhX5lBp0fzltNZ1W0Xmg2OOnMVupAaY1hXZgLAcmT7d8IwXm9uydK6lLjqM?=
 =?us-ascii?Q?c5GArF1+GTfHb8sGxViv12SvPEMADaVMHr+xXJks33GugppFpG8rQxM9hFAm?=
 =?us-ascii?Q?NWT2ENWE3z4Ypdzf4cCJ4MdTz9lLWwA0R5NdGX9VzSUqleAgxoaf20mZ6Pn4?=
 =?us-ascii?Q?pTdh7p0XG1BjrwNxArjLykiwVFyccYA+pHca5mzi0mXAtCS+7sStj+9Qz6G2?=
 =?us-ascii?Q?8ucAdqbjg47UItHbYhuFEZqRyKs/NGmUXSC1u3pfNg0b0M0FSf8iTu1oZtLc?=
 =?us-ascii?Q?ldKBJA86i3Hh25cjgfj/A3xeWrZowNkC5uNSkqdq8E8tTToRDFyyKzu6Pt4D?=
 =?us-ascii?Q?5JDvJBzkKbQw3Gp2u/2ZdSVw6bUGWZWXDts/swMHgUpj0xmbd8tWBFvItCsR?=
 =?us-ascii?Q?aBnJ2T+Frw+7x8ZBe3F3eFS2Q/SrIgcUgUHRBb6Wn7PDElTuJXapHwSobMjr?=
 =?us-ascii?Q?K3Rs/IsCfLtEt+h4lK3obyuyA6Ww8KiREFXAqOVVtnwImDSQTz+szJ/YfrBD?=
 =?us-ascii?Q?C1r72pv4fvkEZVb4n3xnVZ12A+HshJWoDvlRSbbdneQfkhZCII+GlOpCZxYE?=
 =?us-ascii?Q?zvpYUTGO/svFtou0UVLQgR7ZXB3zD336EU4u3wTnSkzCfGegAKQrcXOpqt3Y?=
 =?us-ascii?Q?zXqSWr8c+e9QnfLGTwyWo6pyq5VLw/gJJ4Ll0TD+aMWODBVwNj2MWM6gnSo3?=
 =?us-ascii?Q?DGUlBR3fzl6lZxRdXMOs2cuWI5xqYWh3+pZsEEgPQYUXJEnjW+KMNMUbXgYK?=
 =?us-ascii?Q?0Mtj0S7QZYFKGlt5EClJ5fWYqngsYBTVw3urzxJh1e/W9Fy2EIMsil8MoJeR?=
 =?us-ascii?Q?lNxPyq5LEXoen3+yJOXd0gC6nKmOyr89x75/hz/M+bhrEM6IjSn53tMEiTvL?=
 =?us-ascii?Q?1ehM+arxSsdxXLSuKsYkcEam9aCCSaIWZBs+nRtO/wSY8CpMTfsAFj2ffJ+B?=
 =?us-ascii?Q?6Tjllv6kGxRygtQZZ72bC1hEnWn0gPBCqrGIC0ktpdnoHt6VOBesAeKPqY/e?=
 =?us-ascii?Q?4igOSUyQ8k+1ISPKsmO0PbPufjfLPHjrWqnm/iMrtvBWKZ5yMj3Npi6YZtkq?=
 =?us-ascii?Q?rCjSlL6+kwr18d0RfAeXDol407BS2G3qszAcw99UyJqhj5kblSyKS7T/eci+?=
 =?us-ascii?Q?+5gVyzInikXg316Ox698n+CcR0DKHpS4Tdxiktc+qeayc5crkkUupodr4Hx7?=
 =?us-ascii?Q?YN/tvQfP0winCvlLGizt+GPvGePIMf1LSc4fqF+InWaeeVMCHh0LmTipL7Mv?=
 =?us-ascii?Q?L+VG0OzOU8o1tUxHPzf/l6kMreVFtyFCaXz/fAJTUQnSP4DSIKqg?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d41fc2a-e82b-4255-d400-08df3125a075
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 16:49:38.8568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dre0wDBg4Typ8xP1nK+SAypgbDbFoH4P1Lpm+W9esbTNfeCR+syx+XhaskDh0cSRk52lNhGkcRy9Ob4h3oDcbnr54pGs1RvU7mNCzIsYSbz1+rDBKoryr9hwm+0tEcin
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9415
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add DU{0,1} and the display subsystem nodes to RZ/G3E SoC DTSI.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v8->v9:
 - Split du into du0 and du1 node and added newly display_subsystem node.

v7->v8
 - New patch

 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 80 ++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
index 737bf1c60451..0d03121a37e1 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -153,6 +153,12 @@ opp-19687500 {
 		};
 	};
 
+	display_subsystem: display-subsystem {
+		compatible = "renesas,r9a09g047-display-subsystem";
+		ports = <&du0_ports>, <&du1_ports>;
+		status = "disabled";
+	};
+
 	psci {
 		compatible = "arm,psci-1.0", "arm,psci-0.2";
 		method = "smc";
@@ -2239,6 +2245,80 @@ csi2cru: endpoint@0 {
 			};
 		};
 
+		du0: display@16460000 {
+			compatible = "renesas,r9a09g047-du";
+			reg = <0 0x16460000 0 0x10000>;
+			interrupts = <GIC_SPI 882 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 0xed>,
+				 <&cpg CPG_MOD 0xee>,
+				 <&cpg CPG_MOD 0xef>;
+			clock-names = "aclk", "pclk", "vclk";
+			power-domains = <&cpg>;
+			resets = <&cpg 0xdc>;
+			renesas,vsps = <&vspd0 0>;
+			status = "disabled";
+
+			du0_ports: ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					du0_out_dsi: endpoint {
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					du0_out_lvds0: endpoint {
+					};
+				};
+
+				port@3 {
+					reg = <3>;
+					du0_out_lvds1: endpoint {
+					};
+				};
+			};
+		};
+
+		du1: display@16490000 {
+			compatible = "renesas,r9a09g047-du";
+			reg = <0 0x16490000 0 0x10000>;
+			interrupts = <GIC_SPI 922 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 0x1a8>,
+				 <&cpg CPG_MOD 0x1a9>,
+				 <&cpg CPG_MOD 0x1aa>;
+			clock-names = "aclk", "pclk", "vclk";
+			power-domains = <&cpg>;
+			resets = <&cpg 0x11e>;
+			renesas,vsps = <&vspd1 0>;
+			status = "disabled";
+
+			du1_ports: ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					du1_out_dsi: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					du1_out_rgb: endpoint {
+					};
+				};
+
+				port@3 {
+					reg = <3>;
+					du1_out_lvds1: endpoint {
+					};
+				};
+			};
+		};
+
 		fcpvd0: fcp@16470000 {
 			compatible = "renesas,r9a09g047-fcpvd",
 				     "renesas,fcpv";
-- 
2.54.0

