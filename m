Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4227E606A9BA
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Na88gDIu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D9CC10F736;
	Tue, 10 Nov 2026 14:28:44 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013059.outbound.protection.outlook.com [40.107.159.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F14510ED0F
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 14:28:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqwXcJ7BqnISEFuSRFSRcCnPDj/rStPSW7EU8qKYuY3ibPZ3yTObl8aubNGVGLOtzQZdDap6OayREFmaPpJCr0Q8nAWfMJjh/C5rVD6TKjlw0FzZ4x1kM1PPZJbNZQrNfMTYv/8ayZuyIWlgOukfeDb4mnwnplG+IVoEkHwqIgrdU81OKQqZu0i3GKQ0vTtpGdqu4NJQIkqsbVmutQuAf1Pztde/XFk76vRgGseSdNNOkNlWeawPvqj1wpYhDoTlCMtPNEVmQoDj/kL9ihwfgopvdxTJwD7Od1EZAPa37U1RCArIEQKgRhWZOHE4Q5ryfiKVcEjGIyKF71vMW460Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSglcDRJ42GxzKSw6r+Ob3exfUtuKW8ac9W4NAh5M5A=;
 b=FmmJ5Z2BS1oFujbFmMhfagkYEKZ07IQs0mxCsCNAcbSAMJ3slRkQ9a/A2ldCXSrZnwzq+WZvXsiUU0+ZBoL8Q0oIHvBYdWcYSSLbB57U7IGrRmUuIUluvElTuzRpGG9LkxyRDal6CJ+LRq0H4b5LwPgnivxA76wbrL+qS7uGAv/EDOtu18jLIOM4AXIO7mNTl7TZoeQAPph+UZ81tXfuFNnOMUUsiFiho7Ms5fkHnPzUAaYonidN5o5n3F9FwoKzPcRbI19AiDlpT1SOwATc+PMnBDC2aoVOsO9l2rYbywLvAdY5IYcIPoXK5SAbw0vNb8szM59bI8WRR4Km6NQjGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSglcDRJ42GxzKSw6r+Ob3exfUtuKW8ac9W4NAh5M5A=;
 b=Na88gDIuI6p7JFGElANBNue4hib6Bwuglz1MEm4rDIFGw5QWaon1O7S6O0yF+RxOntKCHBlhgTvayqTAXCRMSAV9GpBW28aVaWPauAVaJKk0f5T18S5n92bl4cf3oSLJ0alK37csIAY4VUwN6ntHr+6uxz5cqzBP0pKGUdYpkzDWyk8LCh5vtiZ5cmp8G9GUMX5CXiXuEyFLE0yzjLYSf7icr+f0zJpq4OIypBm0vfDzh6oMId3ReMpx/1LWuFA1v5JOVRmTXxtSpS09U7Qx0gBg3JOlVSAndjR/NqhJR2Av+wc2GE8+r0rOkxELmA+fSna+o01QW9rYGTaTXfz0Pg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by VI2PR04MB11196.eurprd04.prod.outlook.com
 (2603:10a6:800:291::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 14:28:22 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 14:28:22 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, linux-clk@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v11 6/7] arm64: dts: imx94: Add display pipeline nodes
Date: Tue, 10 Nov 2026 14:27:46 +0000
Message-ID: <20261110-dcif-upstreaming-v11-6-9e13c85ae0d8@oss.nxp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110-dcif-upstreaming-v11-0-9e13c85ae0d8@oss.nxp.com>
References: <20261110-dcif-upstreaming-v11-0-9e13c85ae0d8@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0115.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::12) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|VI2PR04MB11196:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eb803a2-f406-44c3-683f-08df3f36de77
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|366016|19092799006|10067099003|11063799006|56012099006|261021121427099003|261009223027099003|261102123227099003|261026140227099003|261026121527099003|261022105027099003|261028144727099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: aMAruRZ4UZ+j2R1jJpwBGAZ6LMoeLvYee34TYJgRwU8owr1OjFNbRnzRTpVyQnNk0Z/V8UG2ZQi7I1OpzL3Ula90NhbT5ICiANfiioo1Sju6n0tS6X2P+cHAigmaTyznDtgqhpqlLC8nhj5hO6DsI3dZOSxflUWo2TN9YHqBW8Y/xbwewuxNiakWElR4zkasqV1o/y7uaXTSk8hJYkJkwH7C75K9GiXGn6MfSS3IsXqNAXDxD4uCDLaAByLEhYxrIG+BSRFVYwcci9hDQkRxOWIt40Eysg3oJZSssRs2sNFK5fzkWd1yyN/zz7VuUZLPhm9jnXZVzmQODYeUvmmXwAwleS1ofRL4iZNRVeVKy9b+OecZRIE6xPeJ90LvDqoJxPUNklBZh5d0ReYZArxxaMQgLdwJfAav2OpPy5ABNESTVmZfHA03j7we8LTmnMPtXXaqo+jY9kTvbNz4PCzYR0JiFK3vK5ZRMILj3oD/ztjDYpFsttzGBjFOUun3lInsYpsiDBGGWZp3sVmbCRhrDC+xWCAFuAPsxNv2y5+t9DVgnmCSfL4+Bvj8L22dCU0IZVv7e7LVXn0DJWlPiT2jY+JVZeOwmioSIo5WUBhB7ERA1orN0UUlOElTQcjIZ92QOpGLMjlZM7FCHh1v360zeSuswUWWP/t07QR4eoQ4caY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(19092799006)(10067099003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261102123227099003)(261026140227099003)(261026121527099003)(261022105027099003)(261028144727099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZktXdFpzUnU1MGZYeTg4TWpNeTdQUGhsSUZEKzZvdHI3NVl5cXdDMVZVVHJ1?=
 =?utf-8?B?ZWpUWXU0VzlXK3VrZEFHYmhpYkpjcmk1ZzhEUlo1aU9YYnJCMUJRL0FWSkND?=
 =?utf-8?B?UmxyenFSaFB1TlExa0tBUTB5Vnc3Y1Z6RkQ4U3d2VjNZSFZZaTNqdkJHcTQy?=
 =?utf-8?B?WW12YTVUNjlpMWZsMEtPZ2Y5RkNZdVZjYVJXRFRBK3ArQVJSZWkrOHNsTjRx?=
 =?utf-8?B?NXVwRGpyUTJCWkF5d2p4dnp5bmJzTTEvMU4zd25tQXhlRkFWbmVtU3hWcFA5?=
 =?utf-8?B?MGpwcFFHeXVJM1hzQmV3T0VlbGVsMnpzbG9vWGxNNmFHNlBKcm1XdFNaY3Rj?=
 =?utf-8?B?aHk0UzIxQVpid2tJU1ZxZTNhcW9NUXlQK2V4bHh3NngwekdlQm1YTHA5L0t4?=
 =?utf-8?B?MUdwb25ZT0UzSjIvb2x0WUIyNUk5ejhjS203aGx1V2xhcmozS1JyaVVvQmM3?=
 =?utf-8?B?ZTNFcDFETHlGc0lyNWdLelVPRkR0dGRFbkI0VlZOL0w5aldRSEdRL3ludmpT?=
 =?utf-8?B?VXd4SmY3dXhvc2hhaG5BejdUamJTb2ZMT2tvc3NmT3RENVR5RXU2UG5XV0RK?=
 =?utf-8?B?NGo3M3AvWXRFTjhvQ1NzdCtYMlJvL21DMHhCQk02c1c5MGhCSHJ2a1orYllw?=
 =?utf-8?B?dlNGRW5WZ3k2d3FkV3J4WEVmZHNMMDhkUW9vSDdkR2lBSFpWQ3c0alA1cStI?=
 =?utf-8?B?dm5tNDRpMVA1eklhSEJFUENMTXJKK2xyRXNGVVJwRXp6S2hnOTlkWlNIcHdO?=
 =?utf-8?B?bzVxT1JhWnh4ZFJ0S2IrOXB5MUlNMHpEMzhrTU9LS3UybWZrSUg3L1RFdzQ0?=
 =?utf-8?B?QTd1bWVIQUtycUNnaGVoYjJWV3NJcnV6dEhkbmxLbEgwYnRQSytVV08zNzFD?=
 =?utf-8?B?V0F4SGk5TklTRThRcjk4N3UweldQdG9hNGRXYXg1djM4ZDc0Y2YrWXU1cWNO?=
 =?utf-8?B?OVh2RU12dVBzazFXajhXdmVPd2EwRWFqZFNQKzl4TXpNM1hSUngwR2VHME1z?=
 =?utf-8?B?MklFZjB4S1RDRkhZWlRxbFdpZHBiNlZTL2lYTGl1d294UFc4dGZyL280SmZV?=
 =?utf-8?B?VnJxYkViTHFvc1hPdG1IeWJFOWVrM2RMd21zK1JVTEtEeWlYR01GdDlRemFD?=
 =?utf-8?B?ZGV3Rlp6clpWMmJqb08wbW9CUU85ZzkxVXdQQVVmdjZpdDhYN1VSWXEwaUhk?=
 =?utf-8?B?NHhVc0ZkODF1TFJQek53N1RNQS9LL3IwZ2U2Z3NSZnp5WnJkdUtDMWxDUDBi?=
 =?utf-8?B?MllnVFJBU3FyQzRrWTdnRFNwVjJoQmZpcEQvSHJxbzhnbEdNSmpVM0lHRmZH?=
 =?utf-8?B?NlN5VjFUdEVoenJyWVI2cWVVUGxPbXhRclFCQnlUUjBzQytyT1NzcW12bUg5?=
 =?utf-8?B?Z2M4LzY5V0d0YjQwK2FzT1pSM2l2bmV4WlRBU3ZZUFRXd0NQNlRMN0VZYldY?=
 =?utf-8?B?Y0t5cWdsSWo2cGhpYWlMNEMySVIzRm9BRTcydGJSVFdwaERQMEQxeHNsVWVu?=
 =?utf-8?B?Ly85NmlpajZsSDlXZXo5U2FlQTU1dFRaa2NzWVFoZDJXR3owTnYyWkJ1ZjJN?=
 =?utf-8?B?L1dwYUJLYkZZOFFSTzVXTjExUDhxT09KTUVxYmplRWZFVE5LV016Qk50MmV4?=
 =?utf-8?B?L05mVTBJU3Bsd0VhRzd2S2d5OEFWRnRaa1hOQVJna0lQejA4UUhZZVhhS2dH?=
 =?utf-8?B?aUtYWVNDRjU2dVpIOU9sOWRMbndSWHJQN1NsaW9zbU5UNEMzVW5Qbzlhckg1?=
 =?utf-8?B?NG9ydEl2cFBQK0xlWlBhWVRuRG80a0hlMWJQamlBVFNLZFUzWmJ0MEFNWEMw?=
 =?utf-8?B?VmZrTjlaVUFMM1RIY0ZiaHRTLzFuRm43bjJPQ3d3aUJ4d21tZlpvVjJkQkd5?=
 =?utf-8?B?WlJWaE5xb1ZEc1RSV25BWkNKcTVpUzhGbENVRFI4ekJKTG5BcVNUY3l2bVBq?=
 =?utf-8?B?NnI0bGRzcXM4aHVPTlNFVCs0UHFVRHdhZnVjOFl3RldMYUJSZ2s0QjNPZ1Vp?=
 =?utf-8?B?WFpoT1JXSlg3ekxPSCtrb2UydGtpRVhEaHBSdDJwRmRCNTZhUGpiNnd4TDVE?=
 =?utf-8?B?a2ZSTHFCc0FRRHRTQjkrQWV2aEkya29xRjNIbnA3STZNM3owUENvS3kzYVBa?=
 =?utf-8?B?UzExbGZua1htOWtzdElkTHlBMnZQUjNnWUlRdlFHZFpFZDFEcEpsakUvcDUy?=
 =?utf-8?B?bFJsVVcyZVh6ajhPaDA1OVhSNlhzbFVoVVdkUHNydkFmQ2hxU1FzSytvekVJ?=
 =?utf-8?B?ekN5MmkxSVRKUjg1MzFtNEE0b01DbXJEYzduZGkxWStZVGZjcnNjb2lJVm80?=
 =?utf-8?B?ZjAzQ09uMVMrOUxheHVGeEliU1d6NXlZY29KV1dBV0pGZzF3WFh6by9DNFlu?=
 =?utf-8?Q?J0heZJpFvp3KVhEs=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb803a2-f406-44c3-683f-08df3f36de77
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 14:28:20.4198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: stc7cSV3aY4wPvwAfRAbBzEKtWTiNsNfFXDKyFQpTjLThRcW908DeHTKKeqRBlXtcfA6ekdsACNlxYyvVJtaYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11196
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the nodes necessary for the display pipeline on i.MX94:
 * LVDS/DISPLAY CSR;
 * clock-ldb-pll-div7 needed by DCIF and LDB;
 * Display controller interface (DCIF);
 * LVDS display bridge (LDB);

Co-developed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/imx94.dtsi | 82 ++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx94.dtsi b/arch/arm64/boot/dts/freescale/imx94.dtsi
index 020aa1da33150..74d9685404dfc 100644
--- a/arch/arm64/boot/dts/freescale/imx94.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx94.dtsi
@@ -3,6 +3,7 @@
  * Copyright 2024-2025 NXP
  */
 
+#include <dt-bindings/clock/nxp,imx94-clock.h>
 #include <dt-bindings/dma/fsl-edma.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
@@ -39,6 +40,15 @@ clk_ext1: clock-ext1 {
 		clock-output-names = "clk_ext1";
 	};
 
+	clk_ldb_pll_div7: clock-ldb-pll-div7 {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&scmi_clk IMX94_CLK_LDBPLL>;
+		clock-div = <7>;
+		clock-mult = <1>;
+		clock-output-names = "ldb_pll_div7";
+	};
+
 	sai1_mclk: clock-sai1-mclk1 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -1312,6 +1322,78 @@ wdog4: watchdog@49230000 {
 			};
 		};
 
+		dispmix_csr: syscon@4b010000 {
+			compatible = "nxp,imx94-display-csr", "syscon";
+			reg = <0x0 0x4b010000 0x0 0x10000>;
+			clocks = <&scmi_clk IMX94_CLK_DISPAPB>;
+			#clock-cells = <1>;
+			power-domains = <&scmi_devpd IMX94_PD_DISPLAY>;
+			assigned-clocks = <&scmi_clk IMX94_CLK_DISPAXI>,
+					  <&scmi_clk IMX94_CLK_DISPAPB>;
+			assigned-clock-parents = <&scmi_clk IMX94_CLK_SYSPLL1_PFD1>,
+						 <&scmi_clk IMX94_CLK_SYSPLL1_PFD1_DIV2>;
+			assigned-clock-rates = <400000000>,  <133333333>;
+		};
+
+		lvds_csr: syscon@4b0c0000 {
+			compatible = "nxp,imx94-lvds-csr", "syscon";
+			reg = <0x0 0x4b0c0000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&scmi_clk IMX94_CLK_DISPAPB>;
+			#clock-cells = <1>;
+			power-domains = <&scmi_devpd IMX94_PD_DISPLAY>;
+
+			ldb: bridge@4 {
+				compatible = "fsl,imx94-ldb";
+				reg = <0x4 0x4>, <0x8 0x4>;
+				reg-names = "ldb", "lvds";
+				clocks = <&lvds_csr IMX94_CLK_DISPMIX_LVDS_CLK_GATE>;
+				clock-names = "ldb";
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						lvds_in: endpoint {
+							remote-endpoint = <&dcif_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+					};
+				};
+			};
+		};
+
+		dcif: display-controller@4b120000 {
+			compatible = "nxp,imx94-dcif";
+			reg = <0x0 0x4b120000 0x0 0x300000>;
+			interrupts = <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "common", "bg_layer", "fg_layer";
+			clocks = <&scmi_clk IMX94_CLK_DISPAPB>,
+				 <&scmi_clk IMX94_CLK_DISPAXI>,
+				 <&dispmix_csr IMX94_CLK_DISPMIX_CLK_SEL>;
+			clock-names = "apb", "axi", "pix";
+			assigned-clocks = <&dispmix_csr IMX94_CLK_DISPMIX_CLK_SEL>;
+			assigned-clock-parents = <&clk_ldb_pll_div7>;
+			power-domains = <&scmi_devpd IMX94_PD_DISPLAY>;
+			status = "disabled";
+
+			port {
+				dcif_out: endpoint {
+					remote-endpoint = <&lvds_in>;
+				};
+			};
+		};
+
 		hsio_blk_ctl: syscon@4c0100c0 {
 			compatible = "nxp,imx95-hsio-blk-ctl", "syscon";
 			reg = <0x0 0x4c0100c0 0x0 0x1>;

-- 
2.53.0
