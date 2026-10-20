Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62A7606A31D
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 20:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=kd80WkHP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F1D410EBCE;
	Tue, 20 Oct 2026 20:13:56 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013026.outbound.protection.outlook.com [40.107.159.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FE8710F2FE
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:13:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbw6qh/6sOw2Hq0PCPYXgr0YoS3Eoy1rnXO3ADUxYVkBCr96lUhG35s3mJL2c1jHp1mF6wI4/4OA4J+Fkw7DGbm0ZsuxnhSzJFXPqvkKE03XE2L9/NXgjtOaoR2P/XLw0qpjJ5ksanLinSsR9oQ+VK5GfpOnaRVn0+M9JXqvfXa8NH2sgB9pmAew0KPlex7rXl/rWxUmEblkbg9OsiQbk/KEcey0mcdzfnbBEPw6rrJvjbbm/kelu1p+THIg3TeSJazGettNLeeAjYm7ebUkuzYXlVjd73dtc3HF6eIcsCdk4DuSoiqtNZZb0mIUoiJYJB26koXKerNZYCft022pIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyvNUNml3n9YSNWi/Ki5SAW5zeKDu0zB6YVezrNQkY0=;
 b=fzdnVzsZIMxysjAJS0OX+muI1oaWEwla2pmN9L4IbA9oMfsC71jgUHeeB00WDFBvV8btxy2wS2zFjumPfKlM0kVAec8TFNOZM+VPk0y+JE4gBNI9SHbXN620T1NcNqGUP1i8S1z6I0+S9xCyuaHuRCuqABJol4UUlOQqdbltujZfk/lVqR0/4km8aMZXMJs0RvlNBHyv1B91XwZtMJuLi/6QuWHFFr6uIVHFnWO1JATi8cTXR+u7FA0m++CXdBUDjofku0rnE2jLUxHVlhZQ79snNBLRZq9nz1it30p8+/qGAEE0FU+j+jjkAyc6OnsGm8vvq68UinGYLpU16ChuWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyvNUNml3n9YSNWi/Ki5SAW5zeKDu0zB6YVezrNQkY0=;
 b=kd80WkHPfSmrOGQzp9WucIRVS1f8htmaOZ/BLeeCklRnc0VmxwnjCq+4MDPDqahOAiMwU4HfdJTB0mcE3eUvzjXxzzQlFB77eCGT1ucX/efCpDzvGJxZA394g9B7rBwgftpIrHt+Vrv8+Hmrh4sXNGoPrraPtCAuYQZ+GlCukq2Uug75OvNNqwSgYx1UfY9q4dBuWROnhZCE0gi05wvAw0fqKxVeV6YiEr7rjnibT0DF65sFihaz7r0iyHPoMaBBsi6hPkL2Mhx/b1KrZyuzCT+WbqrI+qS3LO2Y5QsX9O7mepdb/hNnZ7DWVvlWsazzNAlZPBuRKxCyUG1m1AR8bg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AMBPR04MB12445.eurprd04.prod.outlook.com
 (2603:10a6:20b:75e::21) by DU4PR04MB11030.eurprd04.prod.outlook.com
 (2603:10a6:10:593::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 20:13:45 +0000
Received: from AMBPR04MB12445.eurprd04.prod.outlook.com
 ([fe80::ba23:1fa4:ce58:ff06]) by AMBPR04MB12445.eurprd04.prod.outlook.com
 ([fe80::ba23:1fa4:ce58:ff06%3]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 20:13:45 +0000
From: Frank.Li@oss.nxp.com
Date: Tue, 20 Oct 2026 16:12:57 -0400
Subject: [PATCH v3 7/7] arm64: dts: imx8dxl-evk: add lcdif overlay
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-dxl_lcdif-v3-7-adc944659e14@nxp.com>
References: <20261020-dxl_lcdif-v3-0-adc944659e14@nxp.com>
In-Reply-To: <20261020-dxl_lcdif-v3-0-adc944659e14@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792527183; l=4309;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=eaBjH0brETsAs/eXclCagbPDxlEKMi8P4WUt2W1Iio8=;
 b=eK7SooBTW9ehi2faYKPinRFdqWMUqTnwhqK8b1rna/emGJa1y5son7oH+yCCIWxj7QJOIoLd9
 xSajqXQGCChCLcgdkZDKfvp8TnsM2SMVozfHcI3+lKuvUDPMCPkOMd4
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P220CA0123.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::26) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR04MB12445:EE_|DU4PR04MB11030:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b25a9a6-6637-46f4-8599-08df2ee6a4d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|23010399003|376014|7416014|22082099003|18002099003|11063799006|261009223027099003|10067099003|921020|56012099006;
X-Microsoft-Antispam-Message-Info: JjlfhUSi8PCjykKrF3PVuqAjU0D4jly8HGhmfmjcKOPaMN1K0kZ7Qae/kqUtsKEiQWrsIFSLjq2cV30Wa6PknXtEQdiOZOfL3/KYoIMqvXsxJ3bnQ6eahDgpBjg4eLkf3j8zpfCOTZ73H+lU7T8l88NMn0mOYB7v4WotNwvtHj6n9CuxMCVmoUO8x50oM0Hirs1T7iQrTQgVqAOh2QqIRCknagNa05Gbu7p16pn84X74dvvkwoteNoPYx682qd+W1RZLmbIrAmU4aHPAlNMw6YuiZWVfzTLAeZKQP92YZmdQq2hFmK1HBGH/sqdlZpSTeBcdyu32YLJDOy8D2qIwKBUaSUy1PMQ20TXzG+p3RwM0waUyFHwTJHuMSKeLC4ku+KVJ5T8rZONoDW8VjcrjHWECS13g+Y/wMN7MXV1a0v2b7m2fXs7EZIg6I35gGk0pvPABi1vKH3i3I+ki11t6VGjgRfRC0wBD2eC0o6t6toxo//zgrFRI5ctLZLhEIuaHeSeqlxpyu6yNwsa1FgswQcKzEbvGWrqRA9/P+LfCfinzNNI02Szs+Ioj0D8KVJ+8JB9zQxZJPddDG2+86hWZucW1kCN+d4JDmFc3bfNQO3OByN/U/e2esMEXj8aGJ4j3IShMTsaNiiPYiz3zp93r+3it9dSko2akcYkjSyuJDprSOhSRzRTU12+TBquM+41ZuawC2OSAAC/rFo4nOWN9EA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AMBPR04MB12445.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(23010399003)(376014)(7416014)(22082099003)(18002099003)(11063799006)(261009223027099003)(10067099003)(921020)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTI2eE45T3JXN0VWenh3bGpHZFVFcHVESTdqeVNRMkRKQlJGNjBLalhQQW0y?=
 =?utf-8?B?MWZLSHdEUjJQVXBFSmJoZE5vcDAydTRKdjlybHErTjl0cVJyN2tPZlBYQ0RV?=
 =?utf-8?B?VU9yaW1wMjBZUzRBQzlvQ3AxUXcxYnR3MzBiU3YrRnJOZmlUZW5JWmh0Ty9q?=
 =?utf-8?B?MFpJWXBpeXl2cm12b2NUM25vbTZzT3J6TmY4cUNsRDhVaXljSHVzQkpxYVZn?=
 =?utf-8?B?ZlZKVGJxNEVCeHVMNWdzOUM2b05IdTcvMkRnVVZHbkdTeEFOa2E5RTlqQU9i?=
 =?utf-8?B?ZEc3d252MGxjcWRHcDJaWGMrb3kvelR2NGJXbXRlR05FMUxGc1hQbjFaUlNj?=
 =?utf-8?B?KzZ6ZWtkanFNWkJzdy9CSnRrd29FYnZQUlFKSTZQVUZXbzYzZncwbDRtWCtQ?=
 =?utf-8?B?d3JXcURLVCtRUW85Q3M2SjdGeWxjeTVjQS9jaVlKQjZhdUI4Wmt0USsrL1FX?=
 =?utf-8?B?eHhDQ0dVU0FVb1MrdTVEa3JYdm13ZHpIY1dubzNJeldyN1NVc2FXSUduVEla?=
 =?utf-8?B?RnAzS0tHODFZTVVtcmlwV08zNnZ1aDVWdzlrdGtscHpLNjY5OXEvQk5tVzVL?=
 =?utf-8?B?RkVsZHpQQjVKNThFZVdrVXBoL1BzOWVpUHJYdkZrL3U1WFZiNExVZGVCL1h6?=
 =?utf-8?B?TWY2aWhIcVVvOHZsNHpweW0wSXd4RENvRXJzbS9RQUdzd0tueVc3RTMvUk5L?=
 =?utf-8?B?UzdWcTErcndXeHh5dFhsR2QxUzR1RmFWcldob0pweHhDNWpGTXJzc0VsUFlK?=
 =?utf-8?B?UXU4NWpEMVdQVjBqY0lnYVo1U0VmekJmWWpkeXhpNHc1cHQ3TTBZS0UzcitB?=
 =?utf-8?B?dW5walJvM1ZramdIRjlFNGJmKzYzNTQxdEoyejNEZjlYeXB5UzJ2bXpsMHc5?=
 =?utf-8?B?RU9QYWNCc1drUTlCQTRFd3o5K3Exc2pVTGJuZ20zRUdlQ2gxcGdodUxZbDA2?=
 =?utf-8?B?OVNSQWhpSU1EZENHRW1tdTMyeFhlbVluYnB3R2pJbXVCSTg1S2xwRk1xdHBj?=
 =?utf-8?B?eW00WHk2dWwxZ3NndmJkYmRIOU9mdEhLZ3NEeGdTOGNzQ0gxaHhaWE15SWl1?=
 =?utf-8?B?Z0pKWXI0WGZHMWpDeTF2dEJ4WlRLbWs5ZkJLZlAyRzg1c0hmOFBONFZGRW5E?=
 =?utf-8?B?M1QzOTBRcGltWk5mWlo2bWl3LzRGdlNNM1lmREZXZ05ldWdycDFMN0E4M2lu?=
 =?utf-8?B?a0FkamdNazJMUjliRkVBSjExaWZ1UjlaQjdJNUZIZGNhbkc2RDRjeGhFK01r?=
 =?utf-8?B?dkFFSGt1YVNlcEdNcldpR3VaUFZGalU2K0JGMURPTlYzRDNZTUl5dStTTTFw?=
 =?utf-8?B?enFXdHhNSEEyYzFXRWNPdnRMMHo1Nzlpbm9RYlpnSDhlbU9ZODQ4aXJ0cDhU?=
 =?utf-8?B?amIwZk56Lzc0S00wWlcwNG5NSk00SU9oS2dXcFRwQTVzR3hLU3N6L3FZY2lt?=
 =?utf-8?B?VnQ5eUJNbFdERWIyTkNMeCtoSlJ5V2toelZZUFJNbFJHc3NGd0R2Umc4WDN4?=
 =?utf-8?B?emVmeDBxWVBFN3hXMXJkbjM4MlhpZjE4aExYRkxNb0dZTDNZWmwxVVhMM0NX?=
 =?utf-8?B?Ykk5NjlsSVNLOHJBaCtRb0dsYk1DUndvMlhDczNJVjZBNVVsZW1IVUdHZ0Q4?=
 =?utf-8?B?b08rTnp4OUJtOVVGZzJMc2wzUVkvYkRWZ3R2aE15b255b0pCMzJBVmZ5NGJl?=
 =?utf-8?B?Tm1kVXdrSm9uRHZWaWhOazdZZG1BQVBlbHBiUktibGNjbDhMR2l4WnV4SkdT?=
 =?utf-8?B?SjRscXU2elE5U3Z0cHRITG5xQURHQ3JrVE5FTEIrR3dmUEw4OCs3em42SStl?=
 =?utf-8?B?RlFvR3NXSVFSUExnWUJzWG1kOU9UMkptclVRNGcvWk92SkJHMGhNcW5WSVov?=
 =?utf-8?B?cytMMHJLWXlqY1RrcUtDelE1V0xFQ2ZXanhnTHl1VzAwbGFSYml0L2dXVlhF?=
 =?utf-8?B?dHJxSi94bEdmQVluTXZONllQbHZqSnBwZTVPWVF5OUNRM0Jadk5aUWRIMERH?=
 =?utf-8?B?VUlwNEJJVmx4OHJURW1CV0RwQ2RESC95VWxwY0wxTHBHN1l5cXZFd0N5MVpH?=
 =?utf-8?B?ck9UVDBPWkZSWlI2MHBnZEI5c0h1dnBPZDlMbTI2YndYT2JYWFVsSWdScmNk?=
 =?utf-8?B?dGgveW1hU3hyY1R5amt6WnRGUXFsaVdaOUJJMUxiQ0RuL3dBMlE4QnVSNzBB?=
 =?utf-8?B?MFlBdEc1b3YzWlJqT1l2VHRSaXYzVjRIblhQc1hZNnNqdzJxa2t5d0ZtVDIy?=
 =?utf-8?B?TGgxbE1WK3VZRHk2cGJzRlMveGwwMmQ0Z0U1YUEwby93U1phYnRtQjh3Sk54?=
 =?utf-8?B?REpIWFhpK1dsY0hUTWJpc3RKZ3ZXRm1vcHdNdnllZ2d5M0lDeUM3SDl1QlNj?=
 =?utf-8?Q?q3YHZkV7WSR7fyNbzktPO/tGlRancr+Dg3H/j?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b25a9a6-6637-46f4-8599-08df2ee6a4d3
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 20:13:45.6554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVFNGSN4hrsw6jOGwxhx3+0IO3pRN1x/OduT+2eeYoEBIE/KuJeo2mKPMW6ad98HqMnpxRmM4N/pmNO96ZNuFB9VDCKVfZp+b8udL/0ltAiTkSggB+o7JkAJDG70QX6g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11030
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
Change in v3
- add panel info at overlay file.
- add bus-width = <18>, which only connect 18 lines.
- rename to waiken,101wx001-wct

change in v2
- remove iomux hog (sashiko)
- add power-supply
---
 arch/arm64/boot/dts/freescale/Makefile             |   3 +
 .../dts/freescale/imx8dxl-evk-lcdif-101wx001.dtso  | 119 +++++++++++++++++++++
 2 files changed, 122 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index a80cccf34eb56..b5d5e6bd8ce06 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -113,6 +113,9 @@ dtb-$(CONFIG_ARCH_MXC) += imx8dx-colibri-iris-v2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8dx-colibri-iris.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8dxl-evk.dtb
 
+imx8dxl-evk-lcdif-101wx001-dtbs += imx8dxl-evk.dtb imx8dxl-evk-lcdif-101wx001.dtbo
+dtb-$(CONFIG_ARCH_MXC) += imx8dxl-evk-lcdif-101wx001.dtb
+
 imx8dxl-evk-pcie-ep-dtbs += imx8dxl-evk.dtb imx-pcie0-ep.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx8dxl-evk-pcie-ep.dtb
 DTC_FLAGS_imx8dxl-hummingboard-telematics := -@
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk-lcdif-101wx001.dtso b/arch/arm64/boot/dts/freescale/imx8dxl-evk-lcdif-101wx001.dtso
new file mode 100644
index 0000000000000..39abf9b3884ea
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk-lcdif-101wx001.dtso
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

