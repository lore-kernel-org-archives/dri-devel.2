Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB22C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:22:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A218910E4A4;
	Fri, 28 Aug 2026 12:22:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Nkwq46ya";
	dkim-atps=neutral
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010069.outbound.protection.outlook.com [52.101.228.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D86910E4A4
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 12:22:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvfoRiuPezUqp+T593NLgfnsE+ZJGnArEBrpHe+jgVwvrg3omzdY/0GPIXihWr/1UsM2zahdbRwc1r+Qix5zRRR/tD028dUQVILeWsCjHdvz8N9DAeVjlsLe3onN0/XyPkRotgBDISiGep8nRBYUI+wmsyB/8PLgaoA3BIsiL3Pop5tqqGopfzxSQYcqvfLLJQLkp/ZGYmvAD1vXsXg2A2HiW9Kl1fUOtpvgDsKEEQ73fXGk05jawSJdHZrEN1wdDe3FwsBEL2SGaQbq0AL47XIQO7KLFlQ2SPJycHXYlicjd4PMb4K5xcEt3UbC0fjpk7nrTzl9t8lYfYf/c8xeBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIM/vncSEdDh5Xn+pWgw8p1MTeaxT9/w7TBHe8DQH3M=;
 b=oEi28ew+rdbs+nJ/QCrKQZomXq9eI61ar8mtrjLnRverbLVLRZGpGLrIaO2PvcXfCCPLSN2EjEULUWyh+Qb5TW/O7dblWbOl4C7Xvp6OxLqe0HG13o8UuPz9M9/3dFVVEj7fjHJPa09NFyUYDH4H18uHvCRv/xpww3uWBJuXzoEs7zGxROOx87kjch8fJh9NHH2O/4qVYp0RAENDpXpbH/vt0+qViGtWIYL6FneHdcfXeD5O+p1mc5/IeBLgcIonuYTHuG77/2LmT+brh75w1kFuRA3oKuDx3ia2C4u+wXf2qv+aYEp2csIcaXwyH5kVKkJ2h9RGo532bV/TCKSTeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIM/vncSEdDh5Xn+pWgw8p1MTeaxT9/w7TBHe8DQH3M=;
 b=Nkwq46ya2sxnThuzoOibWCoWPfzOd3xbfauEfjr7eDL75vzsHmEQJDpi1y6Pcrl9EWa4/7AosFomcY1VM4X5XQUznuW+eOf9+TgBxRC8Odw5dVoHDYIiWaZldMy2kqZ/7FcFvksMqB8pa1ifcLfiYqT5W5bD+7Ys31vMdGOff6Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TY6PR01MB17444.jpnprd01.prod.outlook.com (2603:1096:405:360::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 12:22:51 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 12:22:51 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com
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
 Philipp Zabel <p.zabel@pengutronix.de>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v8 9/9] arm64: dts: renesas: r9a09g047: Add DU node
Date: Fri, 28 Aug 2026 14:21:12 +0200
Message-ID: <20260828122113.1426778-10-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260828122113.1426778-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260828122113.1426778-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0311.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::16) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TY6PR01MB17444:EE_
X-MS-Office365-Filtering-Correlation-Id: d14458d7-ca62-4154-8ff5-08df04ff144c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|52116014|376014|1800799024|366016|22082099003|18002099003|56012099006|11063799006|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info: khraZvscBRF2akmPJbZq3+jhurItzUJYq3SqmujEpupwyXFUYcEvdRaDdrzV7LVyhniyp/2heok9gqvDTt0vHC9wZKOUE153knd36GXbe5LRXCmpv7PKKKzsC2HtEaTP7SFPY+OuWZmsTJkRqdC3mzGdFU9guM4PnCbSZyW/q+bSdnVc31RyCElkxs8h9TTRMXtaqPn3xXSNKxN7k2jhk8EMb9uHGNf+LfVhXpzho/t8tqDAebKbjxp87BeEThJbrWC8svZyS5YCUdrvlYa3o4Eg5WqqJkXoJFdHtlMm/ahZn3WYLsQcYLOZmenJLctbeATUGEZaU072Me4KNyc6PDKqE4VRhnEnSbtwJgT0FhysUN8z4nLzq+tD38u07N2QLA4arSqTEPGZbuajoKgpiqSEQrT2MJ6h+qTBoLKHaOLJ9vzQxQCCmUMy7x1Pb/zscR+bfCxYuwxVrkr5y8qmEPWXc2MRcMLBWdfeUURx3PRMqZl+HUFG7/7cGLEsytoKau/yhAD8Nl+sjlUVnP2/wu2/nLfi0v4pfN7rr1iP9pMf2BlIYH7UojimCoQor7ukVIwgBH3Q9A1PF6e3tuQUnFidA91OU/g5Bo/ih6aguUKBtk55QsXcBWChkWBzop54Xg8Lv9/AJrM17CD+aO1CwG+kVCmDhqHLjrqCGrqA/CnWl2K8gYrVSzWKi0WpNe94xm8FgT501FJwa/U+5/SbTFNTvID5O/IyZCvpXqRXnRQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(52116014)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0eYP8o/BmCZGpU1WOWiVbXe8pqGnjUrSoMDyapT00hmzSFyj/J2yBSQt4SpJ?=
 =?us-ascii?Q?Q9MSIFlCbZ3t2qzSTbOT4fJ70UWLQdVsnEoTUOG55kTzFHMlcWh9ODQLBA4o?=
 =?us-ascii?Q?lS9608SO7nLEjZ4ILC6mKUXJuUl0ikM/jhgOnUbDpsDhNUdP3b3ivP7nNE7z?=
 =?us-ascii?Q?rTJNE6kdxqxidAgKiB9Rx22ZphoHE3F7Coex4CSE3MsqV1jkWDSJLVuEKHuw?=
 =?us-ascii?Q?WPunJmtvr8c15pM1e+Ttpz0pOtPMjyiCnG8llxEkKBBujnKsZF4Na6ea3be1?=
 =?us-ascii?Q?APFTqVFL68PwFp5VWemZDuEnehunrwcvI+5gWPN+r5bHqvrFs2iSbB9dxH0U?=
 =?us-ascii?Q?RIaui5iXEWXrbZiDSRLg6fnnLfhfFQWK4pLSV+U4wOvMCBlCECF2fMWL0e3C?=
 =?us-ascii?Q?EDHHzkFFUj6kHmpv7Tydqmt8Omr3uJXQVjouaygV89PdfcN2HHMUOLMjmDh9?=
 =?us-ascii?Q?SSlqYmvufg36pykoroIceoPjt78RoeF9zvpq/AQfFZQpcsYuMOB1ad1P1yF9?=
 =?us-ascii?Q?EHXL3AHgH6MHlU/2Dx+EWcv+W+vZzWwr7saAgX405+UtyS2dkmq7xKHMhpXM?=
 =?us-ascii?Q?msO70iXImzEEBCci1kBF7HxgMkhZowr1tZf1I/5hDM7ohGe6ZEplYRStH0ae?=
 =?us-ascii?Q?8q6hnGCUXiB2fsVqzFm6B1kekIn9HCkKSb6E1IqBsiOb8y/FSY41dTuWQfoW?=
 =?us-ascii?Q?nygi2vG6bgKBDhvH551uLqX8OgyAzT7Pd83qBclGBDN3FZtXEKz+gn5bHOxq?=
 =?us-ascii?Q?azfnuafgVIAdwtLn5ch5o4fOxdhllorcrXeO1G6Io34dOOmj5Irtcz1DrdGJ?=
 =?us-ascii?Q?vsrnvJEtDy7JczfznwxHoU9pYnjxKUes82me4QbnynBt0rVbyyCqErNwI/Is?=
 =?us-ascii?Q?ZceTFvWhwsb5aVGdAg1GZlofXUwl+P7/ORky1x0Ot2DRL5DiFB/3VuD9v2A9?=
 =?us-ascii?Q?ye+/RaQ5vtdV6Y2Q4TsoKz0D9iDKHSnjoFNQmtoDGYjp8kEGm1Po3OWH2jX0?=
 =?us-ascii?Q?XN0sCHtt+oqF4cPbtUxSu1xjBj5wmq+97kuI0ox9JYOgv/p+vVnUCpKFbQX+?=
 =?us-ascii?Q?uO0g8YWWdZwmT9zcQsJIvkr8Setf6rX3RBTf7Gg1z6pIkadkhM/71yMyMVmr?=
 =?us-ascii?Q?uwxu/YdYfvsE2I4sGwdAYplyKud6oxnJ68Fy9OTSoyydNh6OmkTBV/dEwwDm?=
 =?us-ascii?Q?/qYRBpWQl7x3q48dV450/YkwXcZ8/SpriJzAaa9RFBBvvVveRphYVO+5yOcd?=
 =?us-ascii?Q?d1d5/94jsBWAbehJRCXGXJHjj5tkqtprS/HeoJWZNTVW6M49r96vZR4/ivAN?=
 =?us-ascii?Q?Gd0iN/1dn4vogBQEHcIIBE49iTCCgFr59DqXirPYrNOCO6YuP/Z7CKEIxrGG?=
 =?us-ascii?Q?2VfHTy73fVIbr+KPl0jC/B5xMbJFgM9jOczANzPFi2+vsB7RhiB/a101YfzG?=
 =?us-ascii?Q?fgPY/HUDR+mugjHwLx/FLAlxjowqeoZaYR4lUK6OBoKAk2buExokckyhdCRG?=
 =?us-ascii?Q?7yD4/2Ql6NUKCwd9p6IJk4w9+O+YrhGSst9NKSbh5CoaAXGNU4qt6ByBBobo?=
 =?us-ascii?Q?LZ/TEMGAlhQhmQPTzUnn/zNrrCPsbqz70fwYtWINs9V4RhrD5heZh6evhWtv?=
 =?us-ascii?Q?Lu7suGhEKNST0bGIkJ6xfQTpsMq8FKr1tU9Dxb3BBsb+afFw1v7fNDXnzXGt?=
 =?us-ascii?Q?N/NhsNnSVCFwZq2vlUgLH6optVvx+UYf6vEB20gTnex0iN8kSK+2vRrhsKTJ?=
 =?us-ascii?Q?KkNP3Mk1CmWNvYEe8Mnl5SJoUk6t77NKEZyI794g7o4MqF+93ghl?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d14458d7-ca62-4154-8ff5-08df04ff144c
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 12:22:51.6822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0XF+FPVmsGtZmeGisWzg/mDdmokDc+RCZP/KthFmJDGDAToOASoWgu+WTSoSjJpSXyRy0BmCa88c3yI6TZxkQo+sd7eovPs1U+yksHAumjkyLgghl4wqdgy0CaRAy4H+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6PR01MB17444
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

Add DU node to RZ/G3E SoC DTSI.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v7->v8
 - New patch.

 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
index 73757e8e2197..4f95b0d7e8ab 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -2105,6 +2105,58 @@ csi2cru: endpoint@0 {
 			};
 		};
 
+		du: display@16460000 {
+			compatible = "renesas,r9a09g047-du";
+			reg = <0 0x16460000 0 0x10000>,
+			      <0 0x16490000 0 0x10000>;
+			reg-names = "du.0", "du.1";
+			interrupts = <GIC_SPI 882 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 922 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "du.0", "du.1";
+			clocks = <&cpg CPG_MOD 0xed>,
+				 <&cpg CPG_MOD 0xee>,
+				 <&cpg CPG_MOD 0xef>,
+				 <&cpg CPG_MOD 0x1a8>,
+				 <&cpg CPG_MOD 0x1a9>,
+				 <&cpg CPG_MOD 0x1aa>;
+			clock-names = "aclk", "pclk", "vclk",
+				      "aclk1", "pclk1", "vclk1";
+			resets = <&cpg 0xdc>, <&cpg 0x11e>;
+			reset-names = "resetn", "resetn1";
+			power-domains = <&cpg>;
+			renesas,vsps = <&vspd0 0>, <&vspd1 0>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					du_out_dsi: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					du_out_rgb: endpoint {
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					du_out_lvds0: endpoint {
+					};
+				};
+
+				port@3 {
+					reg = <3>;
+					du_out_lvds1: endpoint {
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

