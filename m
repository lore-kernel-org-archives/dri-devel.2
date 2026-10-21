Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF51C606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=I5WR3Rx5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F09510E03D;
	Wed, 21 Oct 2026 08:21:00 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013022.outbound.protection.outlook.com [52.101.72.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D2E510E03D
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:20:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxFEtG7FyxKZt71ij/48AZb2+73M3WQTU0U9zyDsXOovOUlVS4faBVLAjh6ZRcUVtNlp9iRFRIsl+pqD5WF4is/l1Fhu+My6ePWna3gGqA16acq8dfTcI4pl+xCjx9GS7r/twMoyZzhqhyswUYNeLLAwH3tU4gKLsBYdaW2BhZFnE5Baotoq27+NI/XDyIjchwCch3gTwup8t9iPA0RYovjO7QEgNSpcqS/XG3+JekTevLEY2hUw4f0QtPozAFfTTU9N2+O+LdGI7HfdwIGQZ0yfPa41+/J6VCVch0P+B4T+ftg87X0xmZOORh7IRgM/hZXBX9BWGitocv8kEE5Q4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UR5mP3A3AJ2EuxfPOSChtpb5gSEc8MX0E1UWyklf2gA=;
 b=QAsOhRRbip2nj/ZtO5P85eP9b/bdUAOo8dCOYapvRF6DKgDFPuJPCYlBPsvYEKZM+oCpNixaLhNtJ0MNwPBYEv+BqNqY1k4MObr98Y5NOs3VKJXu6kZTpU24ga4P0zCIV1ppuhrn1fqxrO90mybiSvDWbEslJUF79NCVL7P3mU0fLT5hhMNTJl6nSB2wJ5opQTkZ75kUcbyipCwvmluVxCsmRbWe7blphCu0CEE2SdcbvGJH4IuhccwiL2CrShfHOMeFazAQ6VIJjZIRZERcFtKuLD7oki1UtrUEVjgdDR1CK5IsKDAXcTfZHh0i/UA3iwZlCY9MzEjvRnKw/LWjVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UR5mP3A3AJ2EuxfPOSChtpb5gSEc8MX0E1UWyklf2gA=;
 b=I5WR3Rx5wPOAgi9clEjvufV24mKii3hgmLcftFXEODjxDCAAjRWGNPRr/WI1OSnP7t2erDpBuOY+uM06gTjc/XRaQmdlnzU2aAupU0X2E35jVrlTILsFvSMxkOaAe0jQBKu52nMkNwsLhdrYz6mK9qtRTuMZxjA3C3fgKep6pl5KDBm/mhK/5kWgwYmiau/JMgK4gu6+8E4RvH4UtDIeYEGqL72F5CVgK40gEN/hZQ2wdO3YL8vTrf3Af8Z3yu2+dFxHA+mRdRwQqGuOWTu2iyKy73VFUW/Y53TxfpahrC4imBKGDHR2jsuoY8zDz8sVnLgvnJyB6OKcr5Lbb02mVg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by AS4PR04MB9411.eurprd04.prod.outlook.com (2603:10a6:20b:4ea::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 08:20:49 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 08:20:49 +0000
Date: Wed, 21 Oct 2026 16:22:23 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Frank.Li@oss.nxp.com
Cc: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Robert Chiras <robert.chiras@nxp.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v3 2/7] dt-bindings: display: simple: Add
 waiken,101wx001-wct
Message-ID: <ath2PxwlZLyyHsxH@raspi>
References: <20261020-dxl_lcdif-v3-0-adc944659e14@nxp.com>
 <20261020-dxl_lcdif-v3-2-adc944659e14@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020-dxl_lcdif-v3-2-adc944659e14@nxp.com>
X-ClientProxiedBy: MA5P287CA0266.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::14) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|AS4PR04MB9411:EE_
X-MS-Office365-Filtering-Correlation-Id: ef228ba1-33d0-473e-a234-08df2f4c36df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|23010399003|19092799006|1800799024|56012099006|261009223027099003|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MdpWsExCY7ytbtt4teWQXHDKltJRhGur58poM6oBTepK0qBZt/LlUPdWMwAomvf+6QESiXMov9wGPTVFD+gKm75zoKTK6G/+W1JB6kzaI98URZgUtG0uBXxAmF+hHFPDkcHffnkSWi+9/RJCiztUl23OGup8Tm18y3RwnxynBfS0If+cL2/K3ylrXBW+QWAKwu8zOtnaXDGx4KPeSG2bPalKOx+zGIydPuOQe0BV2Oy/AFQcwXW0DVP+jr4820IivtYG0jaK1bQeVm7RAkKbKiv26QZ2aSS9f9j7zEgW95UwGVReNu9s+9yW/sM5JokXsqgEFaL/3d/LZ0bcPHC3zEdlJns/CjrHwz0+8JtxGBxjpC++82Pdm4QnxmfTbIVfGMC9Bz7ipeKAp5TIAk1v300J4UCQ7Ydg/HRF/HhrGH89jkCyEqK1OhFsUJvw9KdDepIofN+m/xze4+u0DW5s8aC91R7DufdSOleo6ZvsEvtxOzSLwVOk9hRqUvErSToNfFqDJTGUaDirPJB+x4gadhFRaIdfufnkM4XFHR7OaXpZ+QMSyc2zm/7I5zHbEGUEf+V/qVeFcqTQU9HvwVzea6HeHclB2SMgIapcctrLzx2EtnS4AUTEW4Bjad2X3j+Cc6nPmSN3JjnngG3yXZY2Fq3WDbJr/2/gVcJWVpHkrFk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(23010399003)(19092799006)(1800799024)(56012099006)(261009223027099003)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3WFlb4O+ROBmEnoKJdKWcq/xd8l3tBW4qsIqxxvSIrSg20zYrUWnk7PbXEhC?=
 =?us-ascii?Q?Wklhkct1FVYuEqw1sSv6ERYzOc7q+QCf46BJNWNutA/wDNgTWSDNtMLXGa0d?=
 =?us-ascii?Q?1tNlqUvcwYAC957KLpuEccJrsajWUDFTjJzgQ6M/EGti5T3BPpS0rqaVXx/T?=
 =?us-ascii?Q?syuLEW0Cz+7ieBMVg1eg88mS9mUiATvD0xA4/KS1NGsA7hziH3OWrnqetWP5?=
 =?us-ascii?Q?62/eQJ60rshqwE58h3xSWgOCnIMhj9cD5JCOl76VqnP0oMcAMsTU3ervSdJ3?=
 =?us-ascii?Q?Z1BwFrmrulHzuy7Z5esb5zKbont2MsX/AwLI09O5xuKR5TSdUWSJ1Ss8kuck?=
 =?us-ascii?Q?w//PomaynKkqxLq0E1Y18YnlrFSZZmmGIjXOFQQMqHGwQK3GSe6XORZJFYPM?=
 =?us-ascii?Q?yyjewnt64ayex/Xf/8as9ksSa7/f5hzsRWCvdGW2+rCWN4/n+rOnMqJ3tYG/?=
 =?us-ascii?Q?M1OQy6faaDuqDJDRHjJNJ/JQep5lVMRPsakd8E8QGDuBRn986+mXFBoPnM6s?=
 =?us-ascii?Q?naf5xoTgCpvhJFsRScsoqNnrDD83OOtCkf4i6dH1VUjk2PiGb7N8AjXA/jCt?=
 =?us-ascii?Q?Cf5fdr1opcuaq2Opr4UqvHZBvYSnAiNPdhdFgbuY47UcLYoKUrHTLZt/9flZ?=
 =?us-ascii?Q?3ARtVG4VW0N4z7XUMRzQ05gTf9uY2JrbsQWDLEHYOA/sgS5BSpA9rwnruFgd?=
 =?us-ascii?Q?+cl5ic5A/DgoeY/GReGSbwdvL7JDzkdPQq1Mc95gnqrFeIpaZ7wFftP2oBYM?=
 =?us-ascii?Q?4zVHCuDMQG/CSB+4SlBwPbNVof+qNMR/ntwHSORpROqmJ8PMoEOAWJ8K7GBS?=
 =?us-ascii?Q?vO+WmtGDs4t4Q9y4XUoIzaSHAk4zDQbEYnT/DQaR1M/QrE8+5tvXPzPvdIFR?=
 =?us-ascii?Q?qq8S+5Hq3N1XvWR2Q/iRlGiCn/zwoXOKVCfN/o5bJ5x01KnVZ6xijld7ZlA6?=
 =?us-ascii?Q?KYdKr0STcPWwptkwtXVQrWJgZHWVTTjZF6uBlQlNUVoPtswEpL95F3nQfkR8?=
 =?us-ascii?Q?inKnN8P5fAP++NtAAmlAEq/KSsRs+cHIltxY2NUKgwPkEkgb8+oK20DsKAhK?=
 =?us-ascii?Q?B2Q+qfGdh4xfWa4Y0aRziHrgUGk9GQw9+GUEQtWYQJsqpPdyqUMUUIv8YrX3?=
 =?us-ascii?Q?4+seSTS/w38dH01xv2HH18/5sSmnGL2s6S9cV8zTvULtXzfc4Z1GFYFM41eV?=
 =?us-ascii?Q?NOI40KAQCFE2BDp8ACLthhgYZGgJLUZLUG9owKvbOGOnQdUfU8lEFCEDR6vz?=
 =?us-ascii?Q?XlLakCTF0pGKZIaW2jWh5iZVbztsoAPYy+GrNgbYhDdVHU2i39yJbKAEr5X1?=
 =?us-ascii?Q?552ducWvH86pRW54Cmvl5OGzOr19PJS5qWyAwVYV3Tg9oHhT7IDdaRJTB8gc?=
 =?us-ascii?Q?N07CoUzPwSHYAU5mmEQWCmPoaOXVB0bcbrSC0+78pwrg2tcPYThpbf58AUIh?=
 =?us-ascii?Q?hzL1W/FLHC+2h1qs5K8YDt8O89SEjGJ5+g+obO0ba+6P83sBAJuDqw53ejlV?=
 =?us-ascii?Q?ckGDPRucmS0Mfa4a00qYOvMoSvZ4ZrU8ry4gMOcWyhZonBUrmzoOWZ7pVelz?=
 =?us-ascii?Q?T70sgE61ZzmyWCI0aF4at7XJFWDPwq4DXlCBIjH6SrpT6QraFPHd86HTzSSM?=
 =?us-ascii?Q?x2S5SUo0Vg4uYAjoYXucFf+0ahDS/StlfarPTCZky8LESEw9+HvBOQ0qqV6b?=
 =?us-ascii?Q?lNc8wCQ+hio5af54SHBOPXgh4L/p1txKCYBoc9aWrtnd7yhP5amH9oUmHilh?=
 =?us-ascii?Q?WjkH/Tq94w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef228ba1-33d0-473e-a234-08df2f4c36df
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 08:20:49.6480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7GDNFvyRX8affn9H/t8FkG/ZiqukMB/psjm193I73ISXzbe7XtmlBY2GZjUipYgbILB/DzPn6vEXZRVOww6sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9411
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 04:12:52PM -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Add WKS101WX001-WCT panel, which is an industrial-grade 10.1-inch IPS TFT
> LCD capacitive touch screen display module.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v3
> - Use Waiken Technology Limited in description
> - Use 10.1" at comments
> - Use waiken,101wx001-wct
> ---
>  Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 2 ++
>  Documentation/devicetree/bindings/vendor-prefixes.yaml            | 2 ++
>  2 files changed, 4 insertions(+)

Acked-by: Liu Ying <victor.liu@nxp.com>
