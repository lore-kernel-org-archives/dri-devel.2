Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175CCE7E345
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:59:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA7D410F432;
	Fri,  3 Apr 2026 08:59:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="SCtwBX64";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012027.outbound.protection.outlook.com [52.101.66.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C21610ECBD
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 10:11:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJLvKv/QQCEhumFVtv/zRPx+efigYaiYT9gc5fkMoGVPr+YUGr5URa+tVJ5NMibJj0CXijZ2bdbdztRG9qsjmZ71FwnLTkY4/C0BSVf2/d/PSWKiYSgm8U68rJhQL31NNKlQ62ueDX1t+wjPJFtWgz6e9bFK5+jpkXX4Yew2fKQi1k1rEvP+ZykpYtEmSO1pDstw5YUGeofsfICYz3qSYrRtiQpq/NAB5rQiDjmz8Ia6goQwEzZ7dpXH3/zqTPsyX0+XU3EE3cYOYW4w2LAGkVRnlojP0jXQkp/ySJWFXMbm5RdKSlxhM3NDuiGYWf3c2DIzRxdO1SPIZey/YCCJvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uv09LOogDlUnLNYfiEz6rhubCQw/WPx3E89sCujyr1U=;
 b=k+o2YhQIPHHDhGt1hqkW9XCgWXIQbNpaKQiyJeNRvkysBqGyAve7tS7uafP3K718auBLRf1TIUZfcXB7dKQURZnBoGiyCMKV3UIMFTv0SUWEwmotiDs7OCBl0DGwtZ3Cn7NRlmIxfhkh5YZWDGXa4isdkr+7TPxZ/wYUWmIJAbY1xzaJeCnfLNiJ66sg/45fXPwdgenxRw5FY+NxBq6oOnQYF26meUerwCxYXZcDBf7K/fN9i2AGH1uxxKf+RvdEYiW7ztXNAWvaJm4D5YpS2HdFMYWBmISMPzDVXhMFXVblv257Acdj6ylu/nJ2cDVJQjdDXo4TLAssjvhRzofEmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uv09LOogDlUnLNYfiEz6rhubCQw/WPx3E89sCujyr1U=;
 b=SCtwBX64/8IkbWN0BV4jVbPMdpepAnZ7GDYhwerqdxKNncXHDeU5n7T8hLSzTm4j9UoufeJ0T8jR8ZqTrGuNfzD86TFMRBjGcbk7R1fLKhBV8EdaWrAHMd94XNa+cPC9z26I158VhXJ7adUHtTORjObwiloXiZ6wkM/jkXQrq4UV/Aq/ymqjFaCqTLkDCbZ+1Y0BFK0q6+dVFiueg6+xzfo5m+1HdxqvrzyKls+bMZLSkW8tv+2o+f+Gr92V9l5kI0T21ew3klAVYKAtYESWb6JXwvAVwLQP/d19Sr/3EH3a+o97JP5PhNCot0EKrAyVGEIWV1V28LntP2ADFAvUxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com (2603:10a6:208:c0::29)
 by VI2PR04MB10667.eurprd04.prod.outlook.com (2603:10a6:800:278::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Wed, 1 Apr
 2026 10:10:56 +0000
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f]) by AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f%5]) with mapi id 15.20.9632.017; Wed, 1 Apr 2026
 10:10:56 +0000
From: Guangliu Ding <guangliu.ding@nxp.com>
Date: Wed, 01 Apr 2026 18:19:13 +0800
Subject: [PATCH v2 2/2] arm64: dts: imx952: Describe Mali G310 GPU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-master-v2-2-20d3fbcd19d6@nxp.com>
References: <20260401-master-v2-0-20d3fbcd19d6@nxp.com>
In-Reply-To: <20260401-master-v2-0-20d3fbcd19d6@nxp.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Guangliu Ding <guangliu.ding@nxp.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775038767; l=1884;
 i=guangliu.ding@nxp.com; s=20260331; h=from:subject:message-id;
 bh=PH4ZenNtlWX2ZR3CcBHFuiC0uHds9scqHduzLXqAiq0=;
 b=BOktLmrannBvNmv/7/Swv4y8RvdVY30ATg/c58RI/jNt24O1ZZs40bAaqKvjaLtnuVXysjbH4
 r/8EUp+kXXCB19heAcIyhG1HqzdX4i+m+hDoTWQArFmesxixFl1gG3j
X-Developer-Key: i=guangliu.ding@nxp.com; a=ed25519;
 pk=Ozo8o/sk09NyO6URvn0eD0v0uVHduT/yJzVGTAJ9gxw=
X-ClientProxiedBy: MA5PR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::16) To AM0PR04MB4707.eurprd04.prod.outlook.com
 (2603:10a6:208:c0::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4707:EE_|VI2PR04MB10667:EE_
X-MS-Office365-Filtering-Correlation-Id: 563f7f0d-9baf-4421-6d72-08de8fd6f6e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|52116014|376014|7416014|366016|56012099003|22082099003|18002099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info: W73v8mSrIFO4BX3vOBXLPAp2fBoAkiacra8V90jaCgw6UKqwal5IgoXc+yUiohxWXSBup2XmZ4H7cv+3CTLQNjKWprRX6/UQV94cDvDdAVNeYZWd43MdWc82qAY2epPhc9Y7NpxFDD/CIGAH+YWmAc1b7KTrEhIOB/+/cVCcQmV7V655xO0Kq8pV4ZT3wweasYNq7i00FNuiQXCw58MVDRjbPzRQdhFCa6H3Mj0JOWXXm0xNSe8kxl0oGYFFMIEn3Nei+LpYwrGN10mgrMex9dgZQEpVKY8NQFV9LxASfZMb2W6Qxsoj81pbWvlX/HHDWZiPtcuNqb/wy9uot0uediz1jOLYlIECcEBjYQpFx1cRANFWpmzeyuWYYKlIGgWCyUckxvwcn4+UqPELy7XJX6DE8JFYF5gzW+5dXZhpE2R0oj6w0SGr3flZ5WE6tSfEPcIK3qPXR2wm+gOWGOpda3g2fH/mwDCZVJxfZj5B0cDm474pVPZDAaluJT6dSOquOgfEztRK3XDkG8BAGZ/rX/a6aDX0BJrA1d9YO6eZgOSb7McoFbYhtFsHg0MiZj2+TsTffxc3QGD+0uQKolTWHwLOfXmERBAQygvwN4Fp4E6/KM0mKHHhYTlAlYjM7sKPXAOWUtj082WOOJhPYbrkdz8WL04pGkdY6aRY6MPE3MskFcmatH3OU+y4D8pgvXlM+CCv3+bR+/cgvkz/+OW17bAH/jILUePgYdxqSNLM19MWfTnysWXBwOyxZfIDQkJ0y6BotSP0hjScsvpuxLNox4Q7nBD9GzhDzN6Cp/3AD9TWDPNqoK5JUyWNvaXzUJ7G
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4707.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(7416014)(366016)(56012099003)(22082099003)(18002099003)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1lVYXFoMGw1QVJ3NDRmME1Ncm1SNWdCWDkyblJiWnNwdzltSk5BMWZ5dldL?=
 =?utf-8?B?Qm1JZjZJS0FXUmw1OHhJYm9pVUYrSC8vS3MrMnBmMWVudXVWSVlmOHN1VnhE?=
 =?utf-8?B?bldYTFVYMm9sVWlsYXE0b3BUUDgvWlV4cEtJRmM4eGdQVjh1a0RramN0UW8r?=
 =?utf-8?B?UTdGcjM3N2d1UVBPRFlNQXhHRDlsMlQ3VGVwMDY3SXQ1TlVGUHViQTlkcEU3?=
 =?utf-8?B?dmZEZVdWVFBmekt4V1J4STFLckRSZnZsVFlNUXZ5YmEyNVFUb01JNDI1djN4?=
 =?utf-8?B?MXVBV2NCU2k4SjByQjJrR0gwYUxnT1k5R1pGOGRmSWNUQlA5dmF0MXp0UHNy?=
 =?utf-8?B?eXRtbzNaSUdoaTZxUFU3a25vZDFEWGljQmw4UnVFR3B6cEZVbE1zdzJySktq?=
 =?utf-8?B?ZTNNb3BCMUJOSTMzN1ZLRGdCa2tyNGdvc0lvQzkyK1FuN2x3Z1RSWkVnSnRx?=
 =?utf-8?B?VUliSStSczhOVlg1bWdwRmo0bmxaZzA1K1d1bE9XVDFadlJyZDRYWjlFbWRV?=
 =?utf-8?B?OE1obHhqajlvU09QZ3VzQWhPeWlCcko3Nm9NL1FzWEJOdlFLZk5zTElPa01u?=
 =?utf-8?B?aUJLc21PRnRJcnJhY3pMR0pVZThDZGU0SnFja0RWaFVwT1puOTE1TnliKzRv?=
 =?utf-8?B?aENDVzBCdGpza1RiOW9GMEQyWHNKWWlwVEFGUnBYMldneTY2T29xWUQyVXN6?=
 =?utf-8?B?SXAyNFExcEVoUEoyNTYwM2wvN3ZtV2tBNHFCc0dScWVsS0Z5RFVxZTJpcFFa?=
 =?utf-8?B?c0Q5TEJMZGNzTVB5bk9DS3hRcGlJbkVJM1JBUlNORVQrQWFBTGxLcWtBR05C?=
 =?utf-8?B?M0g4OTRhZWRUelFjVG5OMWc1VHBSbjVFNUxHcTdDdVJCUklSQ3lWZDVzRlVk?=
 =?utf-8?B?dm9Ob2pmQkF1T1lSSTBCMGxna2tYbXdLcnZDNlA3Um1rQUZWODlEODl6aVlJ?=
 =?utf-8?B?aC8wNEdpNjJtZkV1aGJtd2FwdURxUzR5aHdFTXRjSno1d2V0VXVmZFgyV2Fz?=
 =?utf-8?B?LzlNWTRnMTRMS3gwTWl0dzN4UXdxQ3FlYUEwQVl4MVNIMTl3YlBmdmRjK3p6?=
 =?utf-8?B?TVR4aENEbVl1UjF2M0wvWkQzSVZlRFpsQVlTUXppSDJKaWlOR2tIYnM3OUdK?=
 =?utf-8?B?aWIxcjRhTHAvZEFKeG1lem1ac2JkNnoybU5ocEI0QXNZcmVpWUlGb2NLVE1j?=
 =?utf-8?B?RnVnNWxtanZ5QlBEQyt2VStvd3JHQXRVQmFrUHFQbmtxMmZWV2dpbm5FWlZZ?=
 =?utf-8?B?MWdPSmlMdDZFR1NqYzM1MW40NFVoZjhTNWRlemc0bU10WWJ2L2pjM21keDY0?=
 =?utf-8?B?K2Yzc29TeVVHTUtJeGpXSVlkTUx2VjdpalFackQ2TmxIOHRyYXp5WEJHUWE0?=
 =?utf-8?B?ZVB6aWlxSFFPRWhtWDBJVmlrVldWSjdLSStBN2crdHZ1UFNFZXR5eUhrMGRy?=
 =?utf-8?B?S1o0LzR0cmY0bi9FSVhJR3RBTGJZck5mR0YyWk1DdFBZWk8yWExQNTl1dTNx?=
 =?utf-8?B?Mm5HRFpDQTYxVHdmRVdzQ0I1RmlsSmVNcW1xZkdiVmZoU2E0NEZ5UzBtaVFq?=
 =?utf-8?B?V2RzSWJIY2hQelZudDhmdGxzZC93TDZKaXNQTE9ObGx4and0ZWRsQ0VqempO?=
 =?utf-8?B?Z1VyamV3blVwUE1yS1RNM3g1OXZGWk9NUXJtUStaNEJqVWFDR2hqT0UwQ3R4?=
 =?utf-8?B?VHFlaW40M3hhY01EeUNIYUVQOWtFa1J5bVZTOUhRK2s1dTRiSXluVVVRcVp0?=
 =?utf-8?B?cFhjR3RjYXBRVGpWV3oyb0p6S3FVNlhOWWVhYVZWZ3hXcURMNSs1QzN2Q1lr?=
 =?utf-8?B?TFVwVVZCNVNLc1gyVkw5UVhnR1FEWE55aWkrc1pXT3pqcG1HTmpKTCtPaE13?=
 =?utf-8?B?RkZlUXhhbnJTbm0zV2pGeENZaWJVbDBtTnNoaXlUV2VtZjQ4R0pSY3VXNHJo?=
 =?utf-8?B?aHg1akEwR1JqSE00allibDBuZ3d5TzhDVWtUbStXMkxsK3d5S3IwUUNTR09B?=
 =?utf-8?B?TlZ2cjFleDY3djRPcGdyN1RoTW9senJEWWdHVUlDVlE5RnMzaUd2dmdTZzBy?=
 =?utf-8?B?WkVwUHpZOVZtLzhwY0RNM3pYbXZxbGVQNzR4NkVSZVA5MkZZbEdzSnlxM2tJ?=
 =?utf-8?B?bmI4RTNhcFdxWXF3MVd6cjNqd0ttV3RxVWw2OTRhbi9vR3ZWTHI4U2lFUVhQ?=
 =?utf-8?B?V0RlZXVRbVQ1VVk5Lzd0V1pnckp1VE1aVXlDSWd6MGsvSWM5THNnWjFWRjNT?=
 =?utf-8?B?TU91RFl6SmYwT2FzQkk5OEN3S2NVS2RIMnhXUEhwSHJVNHlmZ3pwL1AwR1E5?=
 =?utf-8?B?Q1p1allHMzM5YUJQWld2ZW9QSlNWZy8rMFErRTZ1MFk1Q0w3MnZSdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 563f7f0d-9baf-4421-6d72-08de8fd6f6e0
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4707.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 10:10:56.2715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPq90exEqC7YLBRPMCpBvUplA/N4kZQ2KFmQ7+PVL1OR3QW6cxTqfm9EzAFWIzcVcYfpiEAZlMFN/kzELHXs3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10667
X-Mailman-Approved-At: Fri, 03 Apr 2026 08:59:17 +0000
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

Support Mali G310 GPU on i.MX952 board. Describe this GPU in the DT.
Include dummy GPU voltage regulator and OPP tables.

Signed-off-by: Guangliu Ding <guangliu.ding@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx952.dtsi | 36 +++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx952.dtsi b/arch/arm64/boot/dts/freescale/imx952.dtsi
index 91fe4916ac04..0bd3e7fc0674 100644
--- a/arch/arm64/boot/dts/freescale/imx952.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx952.dtsi
@@ -318,6 +318,28 @@ usbphynop2: usbphynop2 {
 		clock-names = "main_clk";
 	};
 
+	gpu_opp_table: opp-table {
+		compatible = "operating-points-v2";
+
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-hz-real = /bits/ 64 <500000000>;
+			opp-microvolt = <920000>;
+		};
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-hz-real = /bits/ 64 <800000000>;
+			opp-microvolt = <920000>;
+		};
+
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-hz-real = /bits/ 64 <1000000000>;
+			opp-microvolt = <920000>;
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
@@ -1262,5 +1284,19 @@ usbmisc2: usbmisc@4c200200 {
 			reg = <0x0 0x4c200200 0x0 0x200>,
 			      <0x0 0x4c010014 0x0 0x4>;
 		};
+
+		gpu: gpu@4d900000 {
+			compatible = "nxp,imx952-mali", "arm,mali-valhall-csf";
+			reg = <0 0x4d900000 0 0x480000>;
+			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 289 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "gpu", "job", "mmu";
+			clocks = <&scmi_clk IMX952_CLK_GPU>;
+			clock-names = "core";
+			power-domains = <&scmi_devpd IMX952_PD_GPU>;
+			operating-points-v2 = <&gpu_opp_table>;
+			dynamic-power-coefficient = <1013>;
+		};
 	};
 };

-- 
2.34.1

