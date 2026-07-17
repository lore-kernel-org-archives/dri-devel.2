Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DED5C44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 05:18:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8047510E74D;
	Fri, 17 Jul 2026 05:18:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="eg9aiq5q";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013035.outbound.protection.outlook.com [40.107.159.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E62210E74D
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 05:18:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhnrYLzy1EWfIyoqHMQV7RcMHqBGlRD6S3VZfBvRdVtg8KV5Jv5Q9kQ97mG4Kk2ONWQ3UdZnXB6UDJsJln0fnf+Isg4FK2UoCy4tMUM+n65JAvLt2woIFdUdP75k5Il9hwcBEl8X5JjHQXvxcfgXV/MD3H7kpjQyRw+Miyh9E4hrhzbLVFxKdPfS2boIdloTn6EksZadUaE0+pGRj1X+Bhe5Ky6m17q0O2MYFQfehl6JaVZNk7VbGqJt99/f4fihoiG/QfknBFQMm8IKrEt8X+Ra8g4DQZhc3TsRp7nB4unzaOlF8t87NY+1nPVZkXA9N5bLn/i5+4CUguClipimWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiUBAgom9XfeTiiJSf/VbZuIfnfNE/Jw4jXpOY0fbeU=;
 b=RfQR2a503lQzDdI9dsr2kVoBo2u9Baa6OdllfAKPy6NSSqBTzUpSDcj9tOO0WjJ/JQdKXsyM1jdwyibUz1/JiB825Oh/5Nar8HExUpEhmJKKAzb6D7lCRMa0V9B9lmXUs+fn9osfAr0rrQmDLbxEoFTz1sKGD8rSUp/bssNmPgKSpBI2OS01h3v0FPtqfB6aRIATzoGw5zRYk5q7ucsKdyAGRs+lXpYrI2iVGBdlMCBNmxYd3y8Y5Guq9kLmK4luJSb2FMPb5S9aCzCdcmrmgDaD0KNwiB7ymsGU4sKgejysqxmklI4JwFRUMHtFthS3YOcPwqVSzLrqkCZ/vSjTaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiUBAgom9XfeTiiJSf/VbZuIfnfNE/Jw4jXpOY0fbeU=;
 b=eg9aiq5qDeOGypMEceoMWe+gurMPzlJHxhTG41B/THCuRV1HN0WVLIojskOQ+nFli9DloTnd56Hl8I3D9VaLPJBnXsAvCoRl4n3VvdTsf3MB0BR8ZgTLD8rykrMlyDp5GlDxeiHvInGI/TiGZXoOyO5ZH2rcg84H9NSKmpqGD+JK1pPBHCQy6yjZWXviGs7T5ShY7CQGbGJwNABhsk9uJvdJmWXwnkTFJdnoZrtUlF4ZuXsZUe5D775lUtyeQHQmk2idtmuEpeTHTjPID+50KA7TKYWkWN7wf5fxuvgMjoSxt6czkDq3qCZwTa/Hkl8qH70vSq65PSaWsNXb1n0x3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by VI2PR04MB10548.eurprd04.prod.outlook.com (2603:10a6:800:27d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 05:18:11 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 05:18:10 +0000
Date: Fri, 17 Jul 2026 13:19:40 +0800
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
Subject: Re: [PATCH v2 1/7] dt-bindings: lcdif: add compatible string for
 i.MX8QXP and i.MX8DXL
Message-ID: <alm7bB64Y4fPYO_C@raspi>
References: <20260715-dxl_lcdif-v2-0-da797562636e@nxp.com>
 <20260715-dxl_lcdif-v2-1-da797562636e@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715-dxl_lcdif-v2-1-da797562636e@nxp.com>
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|VI2PR04MB10548:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d53c6da-bf83-4c9a-a88c-08dee3c2cae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|1800799024|7416014|376014|366016|18002099003|22082099003|10067099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ChoYheWG68Ej4YQ9WU5q0v2ynRsAHbd2jjTtj0JImNtrSIMPXoAQRgWC/Mus92fKhQumqAwDSfrADIkQ+zCXXfLjqeGsejkgtAOIC2fJ1fqTMtttcgC4PKCziAsq3uwEFc1L4GXp10Mm5CLwcBvZ7cxgNXoKtkZlFvL82C9oFtwv3pTFWKWL/LPSkIbN1UEc+l/YbYzWNndvc1Q9XeeZ74ugv3bf1G08yQAzqMfONliBwvrG9BLQgvdBhtEROoAnNsruBGslEW00LXVZ47wVVJOwucWhq8IDev0U1IWGuIin4hADqoEVJQF2k5TLQ/jzhRrYzlSS0FLBtYOFZ9vFix9utsD3E+0M21qq7/vk7eYHw7a46fQ26UDAiTqlvznUX4+qL4UstQ+p1cUSIhsnNORKzvmDHHd5IVXdC9VViea6Ebr6yu5pWFayY1BfHNZee5Pgv68D/6TjOaYrxLx6zKnb2GiOOSsNr/yIR+vLKVU0DOWQqES2gyGxpjMsn+pLyWuFSOj7MmOzhRQLndhG8ymmNkP2qvVEPiA7lIUPEpQRGESiP9NKyUx/T3GQrqnhvIBG9tJ3Hj4G0ib+4iTiiQsCTXsTiS/vVdQ7StJVOpi3Hmoftn4jDxIg6a2JrJwhBUcjC9+uOWHJuy+ikfioxOFqSqMa5v6/R6qzEj6LNNw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(1800799024)(7416014)(376014)(366016)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1dUPtKZ8yUijHvR9noTpvAHiCHFJmLw+Rln1Z3stQHsHoOXDQyoLVUHUoObc?=
 =?us-ascii?Q?CCXWdlD/adMbaGVM+H9fq1ukZyGtNepiILTfVD5rLwYC65KwqOca1f5EOKVz?=
 =?us-ascii?Q?/Nvj3l48x4TgS566+bopDPYmkkQzm3MTeC83rk39YxnfYQFGzW8KWamEeURY?=
 =?us-ascii?Q?dilXMOjT0LfGAme4fIwQ8bfIns1QPFpvpwcoTsiL5SmauMJJ+oPZzUAYYGyX?=
 =?us-ascii?Q?nQAN+2iyh4zk0zu0O9U8hR+Zrji7OkMkmfp3uZRwBdB/+9YtzpjBRQs8wEqr?=
 =?us-ascii?Q?IzGzp95tfcXR0vfQKmRH7oKiMwigGVTIc/GBZJZusEB7l1n50Xfja9oNo2FJ?=
 =?us-ascii?Q?iSnmsq7gpZRHqdLPW5hmGlA6YOPC/wWgLXVzX9bfMl0YsnlI0txm2PBDw8aq?=
 =?us-ascii?Q?lXk/TT7FLgZhzgtADGTA4C2DOV5KogDmElPu2FwbvRKshsAWwZu2iBKiBeaw?=
 =?us-ascii?Q?W9hf2Ljwi2NfSyenXzruRMx7fok6+ZI7pUuuLmw4Ot+1W9qdDb65+WjYQdeE?=
 =?us-ascii?Q?ajAdQgG0abb6fGjcj3U0USIlOoK9nO1mOrAf6F3xim98sWMb1mmp3UF+TDv1?=
 =?us-ascii?Q?b4vVAbXT4H2JZsA3Twnb6tndZ3zxDKrs89mK+sTX+EqvsG9OY7Zs6V8aAfYY?=
 =?us-ascii?Q?FjaRvRSWxh0oxh0DqX5Iy4U5yZ/ZByIC9cTEBoM9FZfOceTObA55/6EpmDfp?=
 =?us-ascii?Q?9/1T4Yg4UuvHNiOnS+BmAgh3nQvUcwfp+LKQ1jffFGgY7ewV9MTr75ZSu8OP?=
 =?us-ascii?Q?oD28n5GqPWzpssJRBF+Zs+SnN+RJ9o0oiXmHemm8AgiJHuRNYSL3kUiyE84I?=
 =?us-ascii?Q?MygHau29WxOCCAhob7hqG01VOZskcs6TiF+AwMA5mX/VxQwWrkIaVYBekRfZ?=
 =?us-ascii?Q?8uRsF5jDfzVu/N/tLYxG1/zHU+pkBOrfYXl1Yi1/xYtOBcW80j6BRWqdzjZ+?=
 =?us-ascii?Q?BjMS9n5aITjOi03k6IsjgWD4lfrPxuKrUTXThcCgW33j1gL5URzWeVdhO764?=
 =?us-ascii?Q?kWyTESl8dUuE2ngkBO33x2S7EXs7NrsyNjF0sxOEJJAmpo8zBGsf6d52g/Cc?=
 =?us-ascii?Q?8PHuwxpeV5Croz/KVeiyTIxETSDaqkG4M9B9mMBWAgsJZo+a/8iLZxcIJ9VF?=
 =?us-ascii?Q?1jRabkZNRNW/Gj5FqrojG3D4YwGsZ/1nxShVfxblScLo8SwqguboDjI0uXZK?=
 =?us-ascii?Q?QKS1XoHPo4x8spcwZl5u8ALy0jMSEnkgBBubiUZLySpzAsBoxdbf61EFwcCa?=
 =?us-ascii?Q?5JAjZmgC0Vlql3ZYHuNwTgheP10PNJbN2zGc/dQqvx/99WZp3aeAKqZeh2Yw?=
 =?us-ascii?Q?ju7o3t+zFDcnFrSv/leIMLd7ZvyRpWv4v6Dokr+PwK5SV4XE+xSXYjwcmSRA?=
 =?us-ascii?Q?tiVg6JaVdavXwEM7si5SQc00/w1vuy1ITJRcQewN5kTOPMUdxhvLPPZJEzFn?=
 =?us-ascii?Q?BRdMACzlHm1meGigQ+sMmuaAwmHaI9gEOtYMLQw2+4v9UKzR10m6Rm2HRQZn?=
 =?us-ascii?Q?aMZ08gJJV8t2ktFJvxPrJNyOMTgAHo4iw+ld/PFVOTRt3dHoFWwyWnbPZotz?=
 =?us-ascii?Q?+24gErjRfHomdFZr05fs+VsCRZv+y3XuaJWRgnqzepxOr2PBG5ASaqHHIAAi?=
 =?us-ascii?Q?v7n43zuO5lorqu6aEJeG+DL2QmRp+N2P7oCGJL0mHz0vfs6KBTuBkTR8sqLx?=
 =?us-ascii?Q?4tBfjUMPX2nPSqpCDMDkkQ7priX7w4nuObQkSi8b+23ivjR+vnv57wUsNFT6?=
 =?us-ascii?Q?vEoJ7fSGqQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d53c6da-bf83-4c9a-a88c-08dee3c2cae6
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 05:18:10.8530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1DZLeEeEnIYOI5QVw4T84SOOyRMaWk3Yec7mPKIuiVU2C5DoZPDd/7z6iWG4UF/7vvbutzWO7np/Axy81Xr6vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10548
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

On Wed, Jul 15, 2026 at 02:34:46PM -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> i.MX8QXP and i.MX8DXL have lcdif, which back compatible with i.MX6SX. Add
> front compatible string "fsl,imx8dxl-lcdif" and "fsl,imx8qxp-lcdif", which
> fallback to "fsl,imx6sx-lcdif".
> 
> Required power-domains for both.

Need to add a constraint for both that only allows 3 clocks and clock-names?

> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v2
> - require power-domains (sashiko)
> ---
>  Documentation/devicetree/bindings/display/fsl,lcdif.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> index 2dd0411ec6516..f16bef7f68535 100644
> --- a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> +++ b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> @@ -28,9 +28,11 @@ properties:
>                - fsl,imx6sll-lcdif
>                - fsl,imx6ul-lcdif
>                - fsl,imx7d-lcdif
> +              - fsl,imx8dxl-lcdif
>                - fsl,imx8mm-lcdif
>                - fsl,imx8mn-lcdif
>                - fsl,imx8mq-lcdif
> +              - fsl,imx8qxp-lcdif
>            - const: fsl,imx6sx-lcdif
>  
>    reg:
> @@ -152,9 +154,11 @@ allOf:
>            contains:
>              enum:
>                - fsl,imx6sl-lcdif
> +              - fsl,imx8dxl-lcdif
>                - fsl,imx8mm-lcdif
>                - fsl,imx8mn-lcdif
>                - fsl,imx8mp-lcdif
> +              - fsl,imx8qxp-lcdif
>                - fsl,imx93-lcdif
>      then:
>        required:
> 
> -- 
> 2.43.0
> 

-- 
Regards,
Liu Ying
