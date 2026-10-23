Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D318D606A32E
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 19:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DUQ0oT2y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35075112CD9;
	Fri, 23 Oct 2026 19:45:54 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010033.outbound.protection.outlook.com [52.101.84.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC372112D11
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 19:45:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NOPHJzeVKs3F50d8cUgnw3cVlznmHxdiuMCO+0ae72M1os+a33iD4R7x/XUTsBbHZ6QouYkSTS9c5ovXtZMGNh+VuwbltwYBrelYT299O+1WknhYq6JuawXoQsRGSlFFRJCfjF79xDLzLQNvvt/N4bq1ETHSdNyPXYZfbJ4DQA/tvmpdl2gV40aoPYsO/HjC7yefXdlS7m4DDdEm2QIjh30b4ynWmGAsGh8qbS4O8Mox9lwylKS26bpu6TeGy9VpbhPM/zZA6ySb43708APxJ7stGewTkas+M1Tz2cjHc4iyndtJCrYYrqBBPqfsvnO3kue2XGAkHGSEL5pfnQMqBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0g8Bcj18zlI58vEZwJSPF+R7x8gDnbHp1lnY5DKTFew=;
 b=mL6j31+5DgXnJb2FvQk8WbsmvtI7cpx3RK9/K05GqBl2Ko2BQRh3ZUT7lsXCoLg7OSLdX+K+ueqeKoRSPNxVmQVwmthsPc6Bj1LHpNDmEqE12/qmTwfwLks+UzfgBxZCEzOV4v3d8DC3B1RyUvtxn7gUSoNa4mpeDce2o8G8A/MHhFC9WH3EkjZj4CyzcOGTh9XkjYxtt4VaEtV61QNMdjJgPe+VgX/gAYhesx0mfLcldBVKgbGGrfQRIeivedb3pnArHzQzWcX+WqoiFsDmSK9LYBPX7lk32szdoOMsIPw/mBpNLmXwhtgH17F7pq4uDoxRhMKMGnlnMqKQwg+7Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0g8Bcj18zlI58vEZwJSPF+R7x8gDnbHp1lnY5DKTFew=;
 b=DUQ0oT2yid9kfbWUDrgutNrPS8oFQMDMQKZCYP3rctyqcoI/AodpjfNIoEWgC81/4HkMi0YXhk8J73KPdUWhHwJgfMnT5HggNA/NMaOFcJMdaYXdRdOZtILJEzwmOgsbos6ZlVEe7y8UIqgdKPWc3nN4OEbUO8zb6el6e7r4pMJSXXqE1OaveCUHs0pm/0V76yXy94RxB/tAxCzztUzB6yKJwp3ir5COSWHgpj++xra17VsVX3/MDfjDwPEH6/QX6ExlJt9/v11Vj8lwDdEOEsI/guOLgVd53J/GuP0Brmcwme7jMascJgvhshvB/u3omsw1JjVH47DDCq4+jZQJ2g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU4PR04MB10597.eurprd04.prod.outlook.com (2603:10a6:10:581::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 19:45:41 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 19:45:41 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 23 Oct 2026 15:45:13 -0400
Subject: [PATCH v4 5/7] arm64: dts: imx8dxl-evk: Add onboard GPIO mux
 controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-dxl_lcdif-v4-5-4ae8395a4b23@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792784713; l=3938;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=U1cJbnWybUl096dQp+JhQ6XBKsomk3UldC4uV4i5qVc=;
 b=3dslaa6LBSW+HF4wxhTf4xQHeMCMHy9TGJVV8CH0bi7VYknUEYAulqgQrfn+m046wRapAqnl9
 Ah0VHHLcMDQBEA+dMYJa3y0RE6yukQgLZ26O2kA9Mz1OXsQd69Axarr
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: DS7PR03CA0309.namprd03.prod.outlook.com (2603:10b6:8:2b::7)
 To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU4PR04MB10597:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c84d34a-4944-485f-b932-08df313e382f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|23010399003|376014|19092799006|366016|261021121427099003|56012099006|921020|261009223027099003|11063799006|18002099003|22082099003|10067099003|261021123027099003|6133799003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: PuUMTHqvPdRirAx/vJSSv9TSLqkVB4yz7pQ3MTMs+vxv3iS5E2VM9j0ZI1U45ZVhR0s9PyqiiJvvLvajVJT3XOkgXpi9jQyMflDjA1k3PPvlayQpqqb/D+lqD7i7mzp9YLIpajFXrVRGq6Ea+4abUhhy4LaNixwqUbA+KHf7MDxVGl59EdN6Hf2NgJeoVvtMQdSfyJbDSe4PoMLURk38Kg+TclsXgEMFDcv3gB/IrTwRgZI85pz4mhRbmKbdiJmkcWMYboTu2g5vE9PvkE4BDPL8mQpMVSVWeixrVUpiLSOKG75QUN2fp+sXVAFXyav39P++RmBVOtZC+hjaT2xLbznUtaQAsCGMORLLZUF3wzgqaTguvL/Fz69QJ5cvlLIPLybCQX+iTrXtouILtX5LI48sGIqs0Y5vERbS2g6SsJgWFq8mLhsAuEPjWZmkTxf2GAv2jOHcvi1GMNSmqm5u7UkMvnSlZdYmAOVd9SZOj+pmxiqw/THjgAQfGaJjIagKnpgTplNqTNtsmWxNhVirsWjYx6VpTLop0/+9Mo/Ys2Z2CxVNhv/jIWW/3Wl7SkSvMb3uXbR0MhhFCaXT3jdzr9lFAo762xz67q8VAAA3px/u0KE4v2rdc+ZEWl5dXjuYZasM2h2csn0Pxj5hxoIVhxQ4IkYoTyjCQRbrKKVX/tN7qxYaK7ecd9VKAXDgBUbdP8G/18ykfQ9xAzQA2AQyMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(23010399003)(376014)(19092799006)(366016)(261021121427099003)(56012099006)(921020)(261009223027099003)(11063799006)(18002099003)(22082099003)(10067099003)(261021123027099003)(6133799003)(261022105027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1ZncEdXUDdCejNRcVNDRG8yY1pXMU05azNhK29UQ3VLNTg5YWx3VDdJS2E2?=
 =?utf-8?B?d1NueHFrNmFxT3BNRVdZdkdVQmc5bTFNU21WaUhOMUJxK0pBTkJWTEljNWx3?=
 =?utf-8?B?YkRiNXYyV0tsc1NsWmRtU2lORkF6VWlyQUcva1MzMk0rYlo4QU9OV2R6MHVs?=
 =?utf-8?B?OHhMb0hCd2JFNHhybE8zNCtFZjhzSXgySTlPT3RPK2tyTlFwdzZZOVIvbG1B?=
 =?utf-8?B?aUhuWW16U0NTMWxSL0diR3dNOFVNQnpwMmNjdktrM0xpYS9SMDNMRHpoNlVm?=
 =?utf-8?B?VHA2anRpWXc5cm5kM1NsenJOMzNTdzNqUFROYkJaSkFBNDRuOUhZVVZRZzBl?=
 =?utf-8?B?Uk9rV0JVSTV5QjlKOGxYcXJzWmdoVDZwWFdqYTkyQUN5WVhnaHVnVTlKVnNH?=
 =?utf-8?B?bXhJYVNHV0hYZExaWEFhcVMvd0ZMaENweHViYlVwVENaQllWam5ZblZEV0lG?=
 =?utf-8?B?a1FsOXdaZlYzVmc0emMxeXFtSFR0WVZnT25temtDM1ZTUStIVWpHeE0vRzJm?=
 =?utf-8?B?VXNFRTdmakc3d0YrOW40Q0w3NUVaeDVuWmRRNDF1NTM0a1ZaeW44ajQyS0dG?=
 =?utf-8?B?aUxpa3Jrc0h2bitRbDZPY3JxaTFjVnJnWDBVZ0pvWUQ1NERTY0NKaVhqRkZ0?=
 =?utf-8?B?UC9YTDQ1dkp2bVVmOTJldlZvUVZpVmYxcENSOExVK0xoQUZXeDltcnlWRGZT?=
 =?utf-8?B?eFFYMWQyUmY0cnBYOFNhMStjZDFmUVFBaDE2eVBzSm9NUHA2SFVKOTlXcWQw?=
 =?utf-8?B?NUdYSzREVmt4MUdnOUgzRVdCWERIaXdORkJnUE10Si93eWppUmlJcTVhTXpr?=
 =?utf-8?B?a1Y0dlRSOC94eWJuK2lmWFhIVm1OTnF3ZUNiQmVkclVFditESTR2YkxhTEwv?=
 =?utf-8?B?VUtmdlBWd1d1c1ZNQ2lxaGZDV2w4YWhZS3dwTUpnekliUzhJL1lWS2VTbWoz?=
 =?utf-8?B?Z2tHMHoxN3NhaSs4UGtFN0dsTzhYcjZBeGhyOERCWUhKaVZESjc5S0RiNHJZ?=
 =?utf-8?B?SFdZVUc3RUxRSi9vbjB0citZVnAzMTBRdklhTWRWaDFvUXhueHNyMUF4MU1t?=
 =?utf-8?B?U0NQelF1Y3d3WFVCZUxFK05BaFlLVTByd1Y1N1IvUk80bTFMVTl2VWdpOU9z?=
 =?utf-8?B?S1Vnckl1YVpnUk5DNTNuUVprbjArWGxuaFViZSt4TlhDRDc2ZitEUmdwazNz?=
 =?utf-8?B?aTYzR29QbGE0VlQ3SWRkc0xRVmVGcElnT1dnU3Q4Y1kwbkRZbUNJZTErd2RI?=
 =?utf-8?B?MWhaeDdOK013UFBaby9GQkNzK3V3Qy9tWVdLRU5yQlpaWkhVaWdSQy9VdzI0?=
 =?utf-8?B?Ykx1aVJtM2Fpa3ZwN0ZkYjAyL3RHS3NEeEZTNkliYTU2dUI4N1hTenVpOGFG?=
 =?utf-8?B?OGhkNExYRTg0V2JtbUh0VW1DV3Jtd2dOQkVFRkhwUTcraFRZYk9PY0N0RDRP?=
 =?utf-8?B?MjI3aVZkWHV4UDJLUmpEa3JZbkVoZ0d2dkIzMVZJaUQ4OE9XWnRnQVNkekpm?=
 =?utf-8?B?dEQ0MVE0RzA5VnNtM1lZZFQvdSt5V2FTbmFHL3VUOU5IcXp1STN3OWpZNUpC?=
 =?utf-8?B?aDZHM29SdEgvMkNiL0hNdzJ6VnlkSDl4SGw0NFJCRSt3ZzVpUndzZXNjY2xp?=
 =?utf-8?B?eDdUb09OM01VOS9WYjZpcFk3dzBkSHJPbkxIWVZsT3pxdC9ZZ3hJWFB1d2w5?=
 =?utf-8?B?Y3B3TGNtN3NHUEhMYmZid0FnNURxY0hRYXA0WCtIdk96ZmFWOFN3ODhhamFF?=
 =?utf-8?B?alc2RHpQN0JLZno3REE3UUExbS9VK2Rwc1IzdU05YVFKNHBQLytzc1FvOWRG?=
 =?utf-8?B?RjJWWnlDMVFZWStCSHB5bDV6Ri9QWWJoRy9MdkhrV2t5SE05eUpFOVJTOUhj?=
 =?utf-8?B?NVI2QVdoWklWZStWeDVKWkx1RVJLM25qOFNPUktrdWdES1kxeGxiZnY0UkVk?=
 =?utf-8?B?MHo1RXNLYnhiTUpBeGFtelVjemIxV0Z2NDAzZ09pbE5yb216aWNVaCs4RENn?=
 =?utf-8?B?RzBvYmpiOTY2RTQ4dktSeUNYVWt3VTlnN2ZVaVg2d1RPaTUvQWs4L0NBNEwr?=
 =?utf-8?B?Z0Uza1pWT1N4ZVFSTnVUUGlPMHBsRlM1MHdUSE4xOVd2WHdzTWRaRmZQaDkr?=
 =?utf-8?B?L3lObWkyQVE2b0dZdTFVNDU1WWxJNUdsdU1aeGYyalZRbWM2ZzRZczFKUXpS?=
 =?utf-8?B?NXhWc1ZwWVpvVCtyQlYwWU9qeExvR3hka3NDeVdxZUNIYkhuMEZoWmcvMVFO?=
 =?utf-8?B?bW8wV2FHSzZNRElON2FmdTk3bkJjalRMNXkzN0Vyd2F3Y3Z1SHdsVmp2SGNU?=
 =?utf-8?B?eWx1OXlwbzNKcWsrOFEwK0Vnc1JyMC85U0UyNEZnNmlIeTJxckRJWHlRc2J1?=
 =?utf-8?Q?SjAOz+HAXVRKeIcbwH5/2JD9fDd8pAn6xS0fq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c84d34a-4944-485f-b932-08df313e382f
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 19:45:41.1044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utizyNOKXd67BJeVKaHY0bu3sVRPjkJ441aOw00a5QOhNkO0nNK8yGL9Cu+ZqlfQ2yWyHcdBW9cCarRa0VFFT3XeFHrCxHZJ8uTV4EWgduQ7466i+oq646u0+DmNXC7H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10597
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

Add a GPIO mux controller to describe the onboard signal multiplexer.
Previously, the device tree relied on the hardware reset defaults to
select the mux state. Now that the kernel supports the pinctrl-multiplexer
framework, describe the onboard mux explicitly and let the kernel configure
the required routing.

Prepare for additional device tree overlays that require different mux
configurations.

Remove the regulator-m2uart1sel node, which incorrectly modeled the board
mux as a regulator.

There are no backward compatibility concerns, as the affected functions
(lpuart1 for Bluetooth, spi3, and m4_lpuart) are not used by existing other
users such as U-Boot.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- add idle-state = <1> (sashiko AI)
- ref to spi0_fun for sai0
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 80 +++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 71eff3efa6d32..f21ac208bf00e 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -97,14 +97,70 @@ vdev0buffer: vdev0buffer@90400000 {
 		};
 	};
 
-	m2_uart1_sel: regulator-m2uart1sel {
-		compatible = "regulator-fixed";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-name = "m2_uart1_sel";
-		gpio = <&pca6416_1 6 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		regulator-always-on;
+	m4_debug_mux: mux-controller-0 {
+		compatible = "gpio-mux";
+		#mux-control-cells = <0>;
+		#mux-state-cells = <1>;
+		idle-state = <1>;
+		mux-gpios = <&pca6416_1 3 GPIO_ACTIVE_HIGH>;
+	};
+
+	spi3_mux: mux-controller-1 {
+		compatible = "gpio-mux";
+		#mux-control-cells = <0>;
+		#mux-state-cells = <1>;
+		idle-state = <1>;
+		mux-gpios = <&pca6416_1 4 GPIO_ACTIVE_HIGH>;
+	};
+
+	uart1_mux: mux-controller-2 {
+		compatible = "gpio-mux";
+		#mux-control-cells = <0>;
+		#mux-state-cells = <1>;
+		mux-gpios = <&pca6416_1 6 GPIO_ACTIVE_HIGH>;
+	};
+
+	spi0_mux: mux-controller-3 {
+		compatible = "gpio-mux";
+		#mux-control-cells = <0>;
+		#mux-state-cells = <1>;
+		mux-gpios = <&pca6416_1 7 GPIO_ACTIVE_HIGH>;
+	};
+
+	pinctrl-gpiomux {
+		compatible = "pinctrl-multiplexer";
+
+		m4_debug_fun: cm4-uart-grp {
+			mux-states = <&m4_debug_mux 1>;
+		};
+
+		spi0_fun: spi0-grp {
+			mux-states = <&spi0_mux 1>;
+		};
+
+		spi3_fun: spi3-grp {
+			mux-states = <&spi3_mux 1>;
+		};
+
+		uart1_fun: uart1-grp {
+			mux-states = <&uart1_mux 1>;
+		};
+
+		lcd_0_fun: lcd0-grp {
+			mux-states = <&spi0_mux 0>;
+		};
+
+		lcd_1_fun: lcd1-grp {
+			mux-states = <&spi3_mux 0>;
+		};
+
+		lcd_2_fun: lcd2-grp {
+			mux-states = <&uart1_mux 0>;
+		};
+
+		lcd_3_fun: lcd3-grp {
+			mux-states = <&m4_debug_mux 0>;
+		};
 	};
 
 	mux3_en: regulator-0 {
@@ -620,7 +676,7 @@ &lpuart0 {
 
 &lpuart1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_lpuart1>;
+	pinctrl-0 = <&pinctrl_lpuart1>, <&uart1_fun>;
 	status = "okay";
 
 	bluetooth {
@@ -658,7 +714,7 @@ &cm40_intmux {
 
 &cm40_lpuart {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_cm40_lpuart>;
+	pinctrl-0 = <&pinctrl_cm40_lpuart>, <&m4_debug_fun>;
 	status = "disabled";
 };
 
@@ -699,7 +755,7 @@ &pcieb_port0 {
 
 &sai0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_sai0>;
+	pinctrl-0 = <&pinctrl_sai0>, <&spi0_fun>;
 	#sound-dai-cells = <0>;
 	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
 			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
@@ -879,7 +935,7 @@ &usdhc2 {
 &lpspi3 {
 	fsl,spi-only-use-cs1-sel;
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_lpspi3>;
+	pinctrl-0 = <&pinctrl_lpspi3>, <&spi3_fun>;
 	status = "okay";
 };
 

-- 
2.43.0

