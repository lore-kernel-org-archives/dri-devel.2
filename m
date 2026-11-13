Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC14606A8B3
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 12:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=cpniYR7E
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56E96112401;
	Fri, 13 Nov 2026 12:22:15 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011005.outbound.protection.outlook.com [40.107.74.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84DFE112412
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:22:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4YUW8pStJag7DKvPNmh7D119f5jgKLaH7BbAI6MBqL6e2PZJdvzsjaUiUuQR7M2yLvM518Du0AKUzYBHsHfGVOY+cC1TVSAGe13DGncwLvwENOuqZhMFNKgUgfGUMhbr2TFgfHA6MRBW/WDPLzdQI0DvFBhsR8+K6YOBrFUY+Z6l0yFNMkJZjGRbmzUBLADz/B09maZ8HtL8yK4vsXI1V8/RK4/kDs35sk3kPiQz5f6bnDvIHZlFLTdMzxKyeq6YcHqqgGy6z83AC5HfDPjjzEBteiM6skOVU2v2zJJeYZL+GIPWcY3kuKZd4MRB6SaqoODRd7TcInaoJkDl93Jtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78nAysjoaDtQWbeNAJ6YC3Wc/O4N7z/owR9sdQST1SE=;
 b=GXSP79rP8h3aEWQI6BbM/+4wfBEy2LaQQevWWXKPmQEpPCHEstasKGJ/UsR59zFIaNub84rXSTlZUoDOWSuOevd+jyys1P3JhyXDuIPHW+pN+OL8kOyEDMdcODQnbEkllUME3jQx1W0WXstTsevbZuSSBJmJ9KDpw9sULdzraNhcdbBTF51nieZ9xl9iziU5ObOiNbyBL0NOlolaMndX+m+FF/dOl1XPuuCXPyChgQH3NWzt7tqYDrQx+wxbXBXO5YYlX4DgZp1NBgaB12zSxpzQFF7dkuqk9WlHePKlZgcNKPAVKVqRO0SK7MPvxzEdKlMKTqNv8uDrG6IvESdeiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78nAysjoaDtQWbeNAJ6YC3Wc/O4N7z/owR9sdQST1SE=;
 b=cpniYR7Eg1wmFfmCq6bf2JUS+y/fBn4cYuuXYLN6FHiJKwoHZUKfknEWCouterwuDiWgEg5EqS2h+hqinoSV2A45lE/2a1xySJaduNPC2gXKM1jiyQ9/+c8lWxzbF2xhM8SE23mYYlbxsk7glcnygrYsW8y08U4tIWK2gu7eV78=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY4PR01MB14799.jpnprd01.prod.outlook.com
 (2603:1096:405:25e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 12:22:03 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 12:22:03 +0000
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
Subject: [PATCH v10 12/12] arm64: dts: renesas: r9a09g047: Add DU{0,1} nodes
Date: Fri, 13 Nov 2026 13:20:08 +0100
Message-ID: <85c8a5e4be1f68ff858998b426445e4e20c8c52c.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
References: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0038.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::21) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TY4PR01MB14799:EE_
X-MS-Office365-Filtering-Correlation-Id: 933e269e-91f1-4317-e129-08df4180b939
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|52116014|366016|23010399003|18002099003|22082099003|261009223027099003|11063799006|56012099006|10067099003|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261022075727099003|261021121427099003|261026121527099003|38350700014;
X-Microsoft-Antispam-Message-Info: WLn4OIT6TQDgQ5MJKHW2xS4XkTDxvUz0vrcFZSK5w3d3SElgdY8ZmrmEBbEROCDZsFQj+Z0PJVCfEo4f/QZevilcKEnd4LUwDHqgKW1QX4FTcpOu3cJbVDAO4UM5+TBEwioVN4TCmwnzIWny6BAVwGhLqNVXRyBW2IAJ9IF3Ecy0Lf2OTfKcK4j7R1wFsBb4ga7NmUzUqBb7bk+CF2mfmmBjyrZRgVdXU9B2trfjMDDMS/e7T0AN9XQUdpVpUPz47oKkIRNQqOiOXBvMTljihQkEXiIGHr+TM1i9DRe4rz8Cb09aSDQwfm9hPlLI/RfSJX/hQgwkx+gyKEZxgo4eLJ+E/5szv5K+zjjF0N13pSZbPVHnv4bn2+y9g2C0fY8e54If/9v1xdELmfgtQYeGz9gmiB71e825+HQLwSfBFSK3ENuuG34YI4Sic7lXuVxeJRHbeDIcHFtlpaXcshxzbVsVaRUx+EEu8iNCOdMmjRPeO++s2SUTDDLF3Cm4Wt5M8scO60TbGLfKjXpW9XfM8xZq14no9uUyb5XHVHUlumnGhDAzp49I9JLUZ6qcvfUHY0DBI/UNj0+Z4CNK9c81MsqXuv5iACs6gqFv4pvOK6f2GJJA2DUjpEP3xunHG4dRyd/JXEF0Ywc/LAg72WWg+8aQSebedkIF3DKvqDHTt5kscFaMLsQKfGZCyiI8LaPRaap04MFofQrUiQap+FcuhgR9PTApetBubUBF0BQ0gB4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSOPR01MB295138.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(23010399003)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261022075727099003)(261021121427099003)(261026121527099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5ta3FY1xhEl/Nlw7RN84Fla386geyz/e8j5g6QRt/KgZYHI7U/2U27zN+ipV?=
 =?us-ascii?Q?tEWP1hEgSdg4wzsW322BYkWjDQm3lEwXKsYR9PA43DW0O1WJkYiQxEZSVe23?=
 =?us-ascii?Q?TW1LbGPRuuCPvEOzlgUREJM43ti9jY4CKz8bdlk9Pdfswzkc/XPxIVCCHdFc?=
 =?us-ascii?Q?t+uSgbfBO2XU6JiKKLDvMYRNzuZR37F7pxF0EQr3m/HThm9QgRJGWzCewJta?=
 =?us-ascii?Q?Op3Mff66hAT/B7Ryu7xHTnTp23o/m5Fp7TvOYTZ96RnuitT1QWFLLczejcnB?=
 =?us-ascii?Q?Cl7cMRWOwDuhl8TKS287EZxMeqXAcxJq9hWh8rxYzEPsf0diuSpr5rkeqFJj?=
 =?us-ascii?Q?csrtA9gsYNi8m/41n7uxIN62f5NWMNOOIQlDLXwu46VTy82bfEdAX0g7BZok?=
 =?us-ascii?Q?dTo9Yf173moX5KZ5uCdN+msiLmaphCGKfGWboH2QIVjRizT75H9+jWAoqf/p?=
 =?us-ascii?Q?zcbaae2L9AbvUmp9dbnXdvW47Llzlbl5MethSTltX6kRveXZqTFls4vEmxTM?=
 =?us-ascii?Q?jc1IiIKSxG8gwv+0pXcIAm1KP6o8hbi/NXYafgq1IEr6TYHKL0RTA+Fkq76w?=
 =?us-ascii?Q?se9YXCTA3tGSWGBjQO9aRSrtHgmaazXrupPe1A13uz1BoJfJiNgmjIoWxxcK?=
 =?us-ascii?Q?z33g8FIpENjfkyRWEKAZsZakyYqhPvbrc+13J1Jj4h0gof2n+LoGNsBvOC9E?=
 =?us-ascii?Q?joqadJZROo9f16Dp01Ayom/PtsCWjAY4XqxoUc6wovIf2j3ATq2VmfH/CdUl?=
 =?us-ascii?Q?BWC3OOdogWUaLrjWZF3wynA1jINODgceQiItj/VpCimc3bZpEV486dbrL7UZ?=
 =?us-ascii?Q?cM3c0WsCdPEMWfypYiqOtwksAHq2wFmLbTZQfZjE92KJJoyLKvXbNJjS6WHk?=
 =?us-ascii?Q?jo9gM8KOrsEzg+sZLzDBa6IHrwuEbeADmPqmTV4lJSIQTYXL9cYr9yby4Qgp?=
 =?us-ascii?Q?aftNmN9zMtzcWcWbtm5NyTCr4KG96kViMpDqiAYaeGo3R5RPkx1RmDtnsjic?=
 =?us-ascii?Q?OsjLjEJ1SsjP4kJeLzwa+VwmVyiYk7YuMGL9kCUMumGnsxTXMXmS6W01koci?=
 =?us-ascii?Q?aGr7ajeTxlPNQTuJSlLax86qL0jat+0vKk//8JQqy7wQomAraQtRCclZxTky?=
 =?us-ascii?Q?NecTUiy4T210CHrUoXGd3La99QJ7Ur70xatVf8czUWbwhvZz+fokXek87RBD?=
 =?us-ascii?Q?V0VMeYkiZRgE2tptyhi2xNjLjfiYKoqzHRPtKvXTDMcieTGbjN8bjuhq4ar4?=
 =?us-ascii?Q?93TCSt2b22QF2fQfUkwSZOggQnuJuu27M/uWR3Gn0sN0w8kxuapr/YnzsxZb?=
 =?us-ascii?Q?5Iz6GuwC+DaeqdjRhXvgaZEJpnyr75fZrB2j2n0FuDoWLEzqj8UBBH8sIAgq?=
 =?us-ascii?Q?at3QlVk8QBAdtJtME94LB6UFcLy85oGo4q9ezxG/3ER5mIhcwRpXpywBUcOa?=
 =?us-ascii?Q?vVS1QyxBsuN0JjdJGo3DC0ZNpEAfp2vOfCXp9FjZEPqcM/wpWXIjdPStBf3t?=
 =?us-ascii?Q?CsClvx/EC4J8EjNjm8LJnhT9PI8LVCiO+qn/oxVMiNZPWu0ZKuTJntA7Yric?=
 =?us-ascii?Q?HWHQtm3O784Tg5HrOfMnqkQ6Sv6GDPuUa5L07/TXMdabHdiUBTp2MHJo7Lc9?=
 =?us-ascii?Q?hM66git9LH5U82wGGKIgveiIvr0rIkWoOfP9g42pJL8RR+vxj2FlMD86FiYt?=
 =?us-ascii?Q?81wRHjjbEhGjxfhZ8JNxaaguXCtbAb12I2yNlonD8VIvRSOUAsv7BjVrMKc3?=
 =?us-ascii?Q?sLmLLIbpnwQosk5rdx2COU470aNpVo1Z5HYnaSQRy+r3NjlPXgT7?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 933e269e-91f1-4317-e129-08df4180b939
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 12:22:03.2076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJ5wMr+eYmmdoH2sqkBlHxGZa63smh45y9RJZImuhYQTqqwyQRmaozK6DjWzXf58Uagym1SA3WTjNn3NKhOJ2fNOmAtNHw8FUg4wTtv5bH+kM75zEHBLH3H5mA81K+qX
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add DU{0,1} nodes to RZ/G3E SoC DTSI.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v9->v10:
 - Removed display-subsystem node and du*_ports, updated commit body
   accordingly.

v8->v9:
 - Split du into du0 and du1 node and added newly display_subsystem node.

v7->v8
 - New patch

 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 74 ++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
index 737bf1c60451..0c9c6842e5d0 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -2239,6 +2239,80 @@ csi2cru: endpoint@0 {
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
+			ports {
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
+			ports {
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

