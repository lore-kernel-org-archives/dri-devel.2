Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ADC606A31B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 19:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=vj2WtdAg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3949C10E6EC;
	Fri, 23 Oct 2026 19:46:05 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010015.outbound.protection.outlook.com [52.101.69.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DB6A112D02
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 19:45:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ptGRQmtwCsQLdl7eFvGNt88aSetG+/isIFaPL4uqal3V5qNfAGtdyFaSLXD7k8kq9W+Gdm7fE4ABoTQELA+xDu3eJ5kFPitRX2hpo9fxU04n75mn/LKFx5jSyeWQMpn8jrNca0D8hScXCgECS6mJ4bSh1uICMdUaebFyOl8IVGEw54ZYnw8SpJ9ZsA8qNF1TQBvVmU4/KP/ViUMWJZpaOvl75fZdUBAidxhQgHJkYSlyGxQcI3c+C3ZXvqfJyYsfysf/j/xmml/AZBcZARIb/fNWfv1ZNbzrEPeeiRwTeNUa2yJ2srNCaLZQknH3ryISz2Qn0mq6L3+qfDFxhqqQIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kysnL/15gvVbTr0oQVSARe5TPxGIPhOFfFCvtZzcj2o=;
 b=ZdoOv2cbbGhulDUQ3dv7k1Yqure57VcbjlUvJtfvPmp1NK3fpgaHp+TTaMdzxRdoeNbDyVufT9gkKtEF710jcf2pKHkJLQTL1PKkTWSHyePupQmao9j5xGdSxnQ+2FGv1KEmakXi+bN4T56fl92QBaIePrsQHJ3qqs1GBhQZ8GXCrW3ulnbbbD6DXUa5qpxMPOeprBGOIIXwWhjVyb0K4UsVP+FqAd/gRTgEZQsvdKJXSSefk9Vie4ArTYasC5m/OzQ19f0k9vEWmVPlSu2kMtOW9rf5BG+hhgsLAjvbLwhYVGJa3qzkjWC/dKmbCor+zGP6yi5FGYgGabdQFrMUAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kysnL/15gvVbTr0oQVSARe5TPxGIPhOFfFCvtZzcj2o=;
 b=vj2WtdAg/LOjYfpYgKBt938Brz2n9X0U5+OuM6ElBIN2Rw1xtyMQgpo770ju5iTVFJ6OnBTtwYjw2EU9vSr9PF83MFEC8yfI3kmtsxKzetBAIUqjrTeNZ/I4Y1JBmzDhJiwOCy3wbF+NHiGKQTYiTpU9lgZDX95yqnz4GLJ6zd9BXTZDqNwUzasPGKe996yMT6743E22aPb+doS5hUCxNKd7qLVPmJm2JljPMhtSY8fq3TR/D0rN+gi+eTHMeVUIWxc/vGMZ6yXJqeTLoxYxFilV4uNx9QeNxvhjfcDemHTdiKPwb43YHU8QdfXormhOPklZohvWNl3wmI/Hm6wrFg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM9PR04MB8570.eurprd04.prod.outlook.com (2603:10a6:20b:435::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 19:45:52 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 19:45:51 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 23 Oct 2026 15:45:15 -0400
Subject: [PATCH v4 7/7] arm64: dts: imx8dxl-evk: add lcdif overlay
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-dxl_lcdif-v4-7-4ae8395a4b23@nxp.com>
References: <20261023-dxl_lcdif-v4-0-4ae8395a4b23@nxp.com>
In-Reply-To: <20261023-dxl_lcdif-v4-0-4ae8395a4b23@nxp.com>
To: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Robert Chiras <robert.chiras@nxp.com>, 
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792784713; l=4378;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=cznw0+gvX2eBglvDDWmnGej0Yi3JXP5ffGghoqsMvqI=;
 b=ZUYyAymB+ieGRMwZhuAxpg2SiPLKCdc4/ZJSeaaj7aGzRwajEymQnvUY30Rf9QmYgjLJzIsUU
 gKJun1V10p7CyRx0mVfo/PymXuMEEfn1sp7jjvJe3CXXg0GvcZBwypQ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: DSZP220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:5:281::13) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM9PR04MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: eb27149d-e5fe-4ea6-c93a-08df313e3e36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|19092799006|23010399003|921020|11063799006|56012099006|261009223027099003|261021121427099003|261022105027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OpMdwxEXp8WUWm5k56FoRcqyIT3APbHV6PY4JyFqax9MsRIt+C7wjpzn/CSkZlRFW1K7lFGe8rDB0jWTXRqo2nrY5wSieKmJWePtsegai8nvECs/99Ab3pWwFqcKv+BuADiU3mXJ1GVBLL1Z/uBj0/TsieEpeWLM2K+yjR9JqN4kdIotzTmIY5B1SROVyMzJw3iFLEdK8oYBZl21MSrRNvWcowNsCx2vQjVEs8aQKrbmK7S4smHJCNauVzzFgBm0VOLA1Lx24RoZVfQIMmbr7JC5PxZvSE9rXpx+gWAa2vzdAImFwKf6hKCJvh2sNT7goZvVVjZAu1m3VLsKMWX3Q0gOruae/F+MJHy1Njwd8s1nLtBHfP5VaPo0TmxQGyrwYCejm8pGsMC4zLLn/NA9Ro7HV8cID/iephLGZ/glHNH3Ah8KTAdfIf0khAXKO6Zz7AuPg6WCtr8WdOABsV+rq+i3N2eRYH4qJVj5rZA+mg0IKoSivrMmYERA91OuZtg2KZX8hxThpDBkV36D/3LlIgH/Th28WFMpBRPF3PYZQqtklNjb3HSbm7mzE08YQtOtlTPhr1TT9PZjx3XLRA+/qBbDRCFNBVas1Qwx+andLw07mS4v/cDWxVboABnrhzu94WPJBiBRNUBsQqEkkAkwzyFilC1TKwGNFWwhvJPoUrRUpJSwYX77mSL5H71nknLmd61dGTxoQvt/Dx0PFdeSYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(19092799006)(23010399003)(921020)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(261022105027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjVKQlNIZEQ1Mm14ZERGRFJKTStHQjBxUzdGUFhFd3JiZHM4ZHNyaDRCMVJQ?=
 =?utf-8?B?NXV0VlQyZnIwQllmbEZzcGVoZzhORjB6WTB5dUYvMml0NlVqNXl1TktMSkRF?=
 =?utf-8?B?Y0ljaXBlaFNYM1lmOURsN0NMZmtadW9YWGN1RXhBWG9kd1ZheE1BWEd5dnFv?=
 =?utf-8?B?aU9adzlQR1FiUjZzUEhWS0NUeHdrMzVWZ3BXelJab2JpNWRzWXNoQ0VnbXFM?=
 =?utf-8?B?NUdqeE1JTHNEUkNaVGcwT2xCaTFkbjVKL0lvTGtLdnpRT0p6N3N0YllHdG1B?=
 =?utf-8?B?bDVXTjR0Qk02Y1NsaEFZQTd1N0I2c0xmZ3VSSUJ5VFNWVWF6Wis4WlZEclZN?=
 =?utf-8?B?cCs0ZUJTZlhFWDFoUkdibGxvL25YV1A4MTc2NXVITVFCa3grVlpGUUlXb2hX?=
 =?utf-8?B?QndoTXVvNm0rZEgwZmJ0YldJUWRsMG5wck51ZXlaVlhpRTMvQmRvUnVucTNq?=
 =?utf-8?B?UUV4TmwrajNqMG1vUXhXY3RKMlErZ0pnMDdTeEZLL1NvQTIvbjgzc3plM3dt?=
 =?utf-8?B?ek5RU1IvWHdXUVBHM0FOaFNKb2R1L2pRZFJkcFhDcVhDT3dML3lDZWh3QUJL?=
 =?utf-8?B?YlBYK2duL01ZMXFGTndtcmxVZUJVUElwQ015eUluTFFRSzB6b3dzR21tdi91?=
 =?utf-8?B?emZZbG9RcUp6dnF6STNIVllWRkZHd3RpN01OUERZb2huVWduK0srMWVKRklN?=
 =?utf-8?B?REhob0ViSm5nM0ZhaWF3VjhUckwxMzF6UmVjNW83MGQ3YmdzMkI5elNvQlhU?=
 =?utf-8?B?ak9nSERLNnBoL3YvQk8yeVFwUlFhajM1d1JQWHFmMjIzK1Y0bGwwRXo1ajhR?=
 =?utf-8?B?ck52bWpHKzRNZGZ3aWc1Zk4xcVd4eUNKT0tSNm5mMDVmaEp2WVd4TFMvc2x1?=
 =?utf-8?B?ZW5Ua25UWU53d2RVSUp5RVhuQkpwQ2czNlQ0aENjdG01UmREY1VrOVA0Z21o?=
 =?utf-8?B?dzVWanZvckY4UkFoeXdVMUduR0lFZ3BlL3hyR0VDTFRLeFVEeEthT0IydUhm?=
 =?utf-8?B?WTE1aTVSUGZtaUVlMkh5RUZkL1RKMElCVk90ZTc2R0JhWkNXMkhEZkRSYjE5?=
 =?utf-8?B?MHd0N00rZnJ2NGhWeWNxU0NUUUdpYzlDSmpGMmU1am5nclp6MFhjTStzWUFY?=
 =?utf-8?B?VVhGa00wZ2F1UTZqZGVWRTJlOW1HSVJvQlN3SGVWVUNPUlNHOHhKMFpQWmcy?=
 =?utf-8?B?eUtoV2NTbTB3OTFtZ3ZsMStjNEF4cDhQUm5YKzNVSEZlRytwcmxONTlEbmRm?=
 =?utf-8?B?a2FsZWV5SjBxYTdDTlhkTjlpMXpiOXRUUHFFaTc3Q2FhOWszNVM2UlZOeko0?=
 =?utf-8?B?VG5NaGtFWmoxZUU3elNBazdjUWdVUkI4UUw1cmdhRmY2L0tTb3hoYk1kNHhI?=
 =?utf-8?B?eUg2K0wyVmVZdG9WY1EwL3Z2djdrWEpwMklMMVQrVklGSEpFZURiaDFWbUh1?=
 =?utf-8?B?YlA0ZUE5WTZnbXVqNzA1K203c2tjMlZ4OThRMjJkUjVvUXJ5K0lJTDJxMzRy?=
 =?utf-8?B?UWkyRytkWkhqL2ZVYlNOTGtlb1QwMENzZ3ZPNDhSYUlqV2RVMTg3cVJyZXZK?=
 =?utf-8?B?WTFPQi9TaE8rTXFHNEFTZ3VtRFl3ODdhZVFMcFpENjNHWSthaTFsN3IvMTRY?=
 =?utf-8?B?M0tUQUVKMHpiR2FqL2k5MFRzeTlILzN4VUY2aUdHTTIrNlNYQ1pvS2ZnK00x?=
 =?utf-8?B?S2pRWkVsNUxoYVVQS3VwWDVBNldHSlJlTkUyZllsbjlBbTIyVlNya0ZhbFlM?=
 =?utf-8?B?RTdWRENZZEVramhkVWRLN3pDUS83SXQxNldWa1IrNFkwUW9iOGdJYnZhVnVR?=
 =?utf-8?B?VlQvdERSNHFTTVlOMHp5WFp3WHdoT3hBZTh3MFVURmpWOFYzUkIzU2JXUzVn?=
 =?utf-8?B?dnRvVm9nTndWK1FCdHBXcEJ0cTZienFDZTExNXd0R2g3ZEpyWWZlRWVKcUxZ?=
 =?utf-8?B?dmdHSk1OWHBLV21RY3NFRlFXR0JHcHN2ejZnVjQvZjc1V0g0Y2FBUklUc2FB?=
 =?utf-8?B?SERvZGkzVlNPK1lvdENjUFBUTUJERFU1ZGpzRElHaUR4SEozaEJEbHVWSmhm?=
 =?utf-8?B?ZjBhUk1ndW1EWG5YMHN6eGxIa09VOGRkTkxGR2ViZUxMbjk3U3NCRUZjTFU4?=
 =?utf-8?B?RU50UkRkUWkvcnVqQzBqb2k2aSswQkx6V2oyT1BXV3EyM0UzYVFHK1g2T0g5?=
 =?utf-8?B?ZThEUmk0dVAraWVhUFdpMVFzb1Q3RlUvbi9PTE5yMGlIUnVpVEhrSFMzeklH?=
 =?utf-8?B?QkVKalF5WWw0QmRQZitlM0d2VS9CdHptdEJmaUFqQ0Z3bFFtMU1wajN5bEU2?=
 =?utf-8?B?NVJacDRoUURxUGFGQkdlZ09NdkxXZFBkZ1Q1MjUzeHFiRzZ2Um9JUno5cVdk?=
 =?utf-8?Q?JzayH0vSEHipkPKSVEtcWAdbVtC6hyZoAYAO9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb27149d-e5fe-4ea6-c93a-08df313e3e36
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 19:45:51.2159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vbI8qKEyk0diLyWxc39uKmTnh1/ybVVsUgCmDEMGNJOlZDGz+r3vjdRSfGACbhp9e6nd0DOrSnHNuwNXk1LbX17dsQ5go04yNXIiLzATqm21mkYfyA9UzZXu34ibrcO5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8570
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

From: Frank Li <Frank.Li@nxp.com>

Add lcd panel (waiken,101wx001-wct) support. This panel is only used at
imx8dxl evk boards. And evk board only supports one panel.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change in v4
- use full name 10wx001_wct

Change in v3
- add panel info at overlay file.
- add bus-width = <18>, which only connect 18 lines.
- rename to waiken,101wx001-wct

change in v2
- remove iomux hog (sashiko)
- add power-supply
---
 arch/arm64/boot/dts/freescale/Makefile             |   3 +
 .../freescale/imx8dxl-evk-lcdif-101wx001-wct.dtso  | 119 +++++++++++++++++++++
 2 files changed, 122 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index a80cccf34eb56..a722484e2378a 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -113,6 +113,9 @@ dtb-$(CONFIG_ARCH_MXC) += imx8dx-colibri-iris-v2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8dx-colibri-iris.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8dxl-evk.dtb
 
+imx8dxl-evk-lcdif-101wx001-wct-dtbs += imx8dxl-evk.dtb imx8dxl-evk-lcdif-101wx001-wct.dtbo
+dtb-$(CONFIG_ARCH_MXC) += imx8dxl-evk-lcdif-101wx001-wct.dtb
+
 imx8dxl-evk-pcie-ep-dtbs += imx8dxl-evk.dtb imx-pcie0-ep.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx8dxl-evk-pcie-ep.dtb
 DTC_FLAGS_imx8dxl-hummingboard-telematics := -@
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk-lcdif-101wx001-wct.dtso b/arch/arm64/boot/dts/freescale/imx8dxl-evk-lcdif-101wx001-wct.dtso
new file mode 100644
index 0000000000000..39abf9b3884ea
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk-lcdif-101wx001-wct.dtso
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2026 NXP.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/pads-imx8dxl.h>
+
+&{/} {
+	lcd_backlight: backlight {
+		compatible = "gpio-backlight";
+		gpios = <&pca6416_1 5 GPIO_ACTIVE_HIGH>;
+	};
+
+	lcd-panel {
+		compatible = "waiken,101wx001-wct";
+		backlight = <&lcd_backlight>;
+		power-supply = <&reg_lcd_3v3>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&lcdif_out>;
+			};
+		};
+	};
+
+	reg_lcd_3v3: regulator-lcd-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
+
+&acm {
+	status = "disabled";
+};
+
+&adma_lcdif {
+	pinctrl-0 = <&pinctrl_lcdif>, <&lcd_0_fun>, <&lcd_1_fun>, <&lcd_2_fun>, <&lcd_3_fun>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	port {
+		lcdif_out: endpoint {
+			bus-width = <18>;
+			remote-endpoint = <&panel_in>;
+		};
+	};
+};
+
+&cm40_lpuart {
+	status = "disabled";
+};
+
+&eqos {
+	status = "disabled";
+};
+
+&iomuxc {
+	pinctrl_lcdif: lcdifgrp {
+		fsl,pins = <
+			IMX8DXL_SPI3_SCK_ADMA_LCDIF_D00			0xe8000023
+			IMX8DXL_SPI3_SDO_ADMA_LCDIF_D01			0xe8000023
+			IMX8DXL_SPI3_SDI_ADMA_LCDIF_D02			0xe8000023
+			IMX8DXL_ENET1_RGMII_TXD3_ADMA_LCDIF_D03		0xd0000023
+			IMX8DXL_UART1_TX_ADMA_LCDIF_D04			0xe8000023
+			IMX8DXL_UART1_RX_ADMA_LCDIF_D05			0xe8000023
+			IMX8DXL_UART1_RTS_B_ADMA_LCDIF_D06		0xe8000023
+			IMX8DXL_UART1_CTS_B_ADMA_LCDIF_D07		0xe8000023
+			IMX8DXL_SPI0_SCK_ADMA_LCDIF_D08			0xe8000023
+			IMX8DXL_SPI0_SDI_ADMA_LCDIF_D09			0xe8000023
+			IMX8DXL_SPI0_SDO_ADMA_LCDIF_D10			0xe8000023
+			IMX8DXL_SPI0_CS1_ADMA_LCDIF_D11			0xe8000023
+			IMX8DXL_SPI0_CS0_ADMA_LCDIF_D12			0xe8000023
+			IMX8DXL_ADC_IN1_ADMA_LCDIF_D13			0xe8200003
+			IMX8DXL_ADC_IN0_ADMA_LCDIF_D14			0xe8200003
+			IMX8DXL_ADC_IN3_ADMA_LCDIF_D15			0xe8200003
+			IMX8DXL_ADC_IN2_ADMA_LCDIF_D16			0xe8200003
+			IMX8DXL_ADC_IN5_ADMA_LCDIF_D17			0xe8200003
+			IMX8DXL_SPI3_CS0_ADMA_LCDIF_HSYNC		0xd0000023
+			IMX8DXL_SPI3_CS1_ADMA_LCDIF_RESET		0xd0000023
+			IMX8DXL_MCLK_IN1_ADMA_LCDIF_EN			0xd0000023
+			IMX8DXL_MCLK_IN0_ADMA_LCDIF_VSYNC		0xd0000023
+			IMX8DXL_MCLK_OUT0_ADMA_LCDIF_CLK		0xd0000023
+		>;
+	};
+};
+
+&lpspi3 {
+	status = "disabled";
+};
+
+&lpuart1 {
+	status = "disabled";
+};
+
+&sai0 {
+	status = "disabled";
+};
+
+&sai1 {
+	status = "disabled";
+};
+
+&wm8960_1 {
+	status = "disabled";
+};
+
+&wm8960_2 {
+	status = "disabled";
+};
+
+&wm8960_3 {
+	status = "disabled";
+};

-- 
2.43.0

