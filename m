Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4690606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=brqUSAKe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A10910E1FB;
	Wed, 21 Oct 2026 08:24:17 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010052.outbound.protection.outlook.com [52.101.84.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAE4B10E1FB
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:24:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbRGoFgez0Gcun1m33/x4L/G83OdYEA2pRkCpgQfxCbtWNQYJqnjyHaJfoYP0YMXryk35V3ukTATfxP4ryEQPunUbKuxbQVwY4e/HK5B89bWmB6+prILZzfN0dNAjSbxFYC+cCUEkU6fwS5zpyD9hEFpCelFWAWjygrTrSKmhsFbFjYLwuh6ux1wQqb/bH/Cm3qUc69ubyq4iKpWN7FFPA6Omjbj76bFMzjTEiuuRo48JmoUD6wFsXkUEg0W5MUdN8kQVu6VUuJK7ZjIVERNdcIE6aHJi/GPTXYhjJLFqmW5DxZ7uROjh7WlP9JNyiJuax8O//9Yktw7DImtBogZYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHHG3qrzACfsyC5dlg+rX/Kf5fRZbghL3MQvRvx8BJM=;
 b=QnwykF+ur9PGnrGHWIM4VZVQTtgkPJRmQ+im+YOsm5RG+/y0Q6GJlF9EzoZ4iia3rZFYzL/2Sk+v6ZxuvwHxZ+46/u8ypdx2pjeYmzhakGxTr/1/G/541Tc/tmzLFX7n+LHtkwbsIg49w3zvIqySFFWQ7Uc6I6CKspHAhmx/t2Q86OfgFfgjkMRBaumMqsHBkuqeLXoUS2VzxxDCzdbeFtYhKIbMSl+qVbCl4DKoOeVKd1hv81hTlAc6Z5r2qnBOcXlWrCnz1nEUPDnEBvIDXs8T95uYIi6QBoztwGXlHDLPqBvgFMMtVTlUIUgqvKZTd3DCvIJIEDe/6UB2dOWHhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHHG3qrzACfsyC5dlg+rX/Kf5fRZbghL3MQvRvx8BJM=;
 b=brqUSAKeLQLDTUhA9souXC0AMJFJIbYYBFpU9UfJrHUTEje+5ppHo0szdRWEy6b0BFs+KFyNtYjcIzAkm+pConIPsaMEufso1SoBY522PQVi4vE+sMp6mxldI1l/aUSPZuMllk1RskUHbwOwAZg4sXDRgcbW3U3msD/G4Fv7VI/w0FYOIWsXiiuDpDHEwuqbVZKj1aHKpVGLhqaMI/Y7YxpDOUhWOzXG6Lt/qZtjOA+7nbrjXvKm55stMPrP0ynGvCC5rYmmb7Sfb8y/KmbqsZwSk6VgLJdx3b6Oi8uJ10G21MbtEOoI54UCb8WknM5S/cP8ytRSm88DeICHqFu3OA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by VI2PR04MB10906.eurprd04.prod.outlook.com (2603:10a6:800:277::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 08:24:04 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 08:24:04 +0000
Date: Wed, 21 Oct 2026 16:25:40 +0800
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
Subject: Re: [PATCH v3 3/7] drm/panel: simple: Add Waiken WKS101WX001-WCT
 panel support
Message-ID: <ath3BGt9qmS-amTo@raspi>
References: <20261020-dxl_lcdif-v3-0-adc944659e14@nxp.com>
 <20261020-dxl_lcdif-v3-3-adc944659e14@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020-dxl_lcdif-v3-3-adc944659e14@nxp.com>
X-ClientProxiedBy: SI1PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::6) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|VI2PR04MB10906:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f1170b-3a9f-41a8-326f-08df2f4cab36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|19092799006|23010399003|1800799024|261009223027099003|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: YNZ7yVbZeIJ/uIcvPjetvdh6M0O0JMbzaSzXcBfWeevt2Lspv0ztFyRTskfXN8FREpwehuU8gf8iyF36SSFz37DFSQa5L0JDwIxoq71jwbLhzQbq04vWzPlXWKFKQblSjgwfibcanq02LdaU9wYRuucsUeib97iklA6Cts6CpOrmZnMsRr+MDuIsVi8QavbizrRmNIJJC/+ixFotyvNJnl3RvIdzuTFuQog6j6SkaLtNgYignGjQY0Z6IO3zIG9JnY1csFvgfrvZ1rZWVdIg3cCCs/eFewlVMOKhgK6ZuCnBScq0KwfiSxYCiz6B701wy9vhMClGLrPgK5mucEDYxCWydZpuc1khEJuN1vfop2hXFhL9FD03knevuL5IUoL3vgGvfa3ADS5y/fdtlCTLNIkA/4xluwaKllyQKHEg/br9UEhmu7ulhX0NUo4/S4VZIqqflAVihyiqBJMLodKCvcPDt9aPZ2a/p9Phtblz2sF83N0WI3aiGmJ9D21iSENDUljzMebICqIeGJHB+Sc42GPD13hYw+NHisbEjEOoW0LhGqHbnNwSdX01ulwnXUU9ccwK8oNNLCO1ndUkEw6AfcoV06KA9EdutfVAr1ln/YjciyqAjRlYvX7zGc86zhbT2CaLJnfDPraMJwXyfr7yncft2t0DrIePDEXd2cR4GXE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(19092799006)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bV00cBVOUjLMIoxsCBHOL0Ihr97sxoivHhabr6OJSrRmENCdNmR/cgj1iNKf?=
 =?us-ascii?Q?J5d4IU+FPI9J9yG/InxkztThGy56P+tJS7N4sWlOLh9I3NbayoSM+vTDSu2Z?=
 =?us-ascii?Q?mudPXnJgDGL9h9WGz7LbVrztQWycPXFKozHYRGJ8sDGSzwnnhg4wywPxPE3c?=
 =?us-ascii?Q?h+so3H4UOgYtJBTUxTOhPr2lF3xbfvswqRyxn+aHnf+UvasYHLvQAdoZSB4Q?=
 =?us-ascii?Q?G7SthxJOaaI3CB/Y0AwX803CJRK5C7ivGmP8rFBDMhgDCuYmk0hm9IC050sC?=
 =?us-ascii?Q?d/ljpqRLKRludom4t+xKGFYYDyvwkOjWfUiZzse35YyMtpU2BvV7+7uaEziW?=
 =?us-ascii?Q?UuBAYyu3vj8WjSe9xbYFlIJBfw0IyzGqev9qaDSnnsYAO0TUGFVtlVgAZmdD?=
 =?us-ascii?Q?hSxpJBPPvrw4ndcygmRqE4xkPVeZUlRMjObADVSDPJXKnMMoPeXAEYx+eQCW?=
 =?us-ascii?Q?9Zr40SQ87d6F+X4DvNe9XC9NKYcWO1XsvA66ZOUv37zJunJ5am8t5kcDImsi?=
 =?us-ascii?Q?Zaxn5VGJOIiDGhX7icykeCvwUeqLZLBi4RPD+tNew05TjqW9miDCUYuaQK1j?=
 =?us-ascii?Q?QRI1GP/UEE7u96nS5b64btyoAnCuzfmMGfZDxIWbiKUrfsfJ0HMEviHBAcBm?=
 =?us-ascii?Q?uD92UiWgk1NIGL+k6Y5prnkUhllBF1skHT9W3ERBQSlgNtz56MlSlwiMfJme?=
 =?us-ascii?Q?gxCCwXgjP17qIqXDj4iqXfVJwa7vUg0kHbS+cmToT61Zp76EIiTzof3wuqv0?=
 =?us-ascii?Q?9Re1JCAFOBWPMqiJhs5AIXmiExdeY7XDCX3vk47jGlrNdTVDPGPkpHzwbfj/?=
 =?us-ascii?Q?o8tgasvs2P7eOBeap0g9W+K5KcZmdFYZeZqQrWCpVlSNsASsDS75OFtjupDA?=
 =?us-ascii?Q?DIBpu04zKM4xB8gosihoMbz3wtKQZrvE8aZJJ6JcprSNhXJSUZ/CcFeXrJSn?=
 =?us-ascii?Q?nxchxSpcNO8goR759jZEvEnGcFsCJiJyuK/zANBphKsNzPK8lzmTE7EUevHM?=
 =?us-ascii?Q?K5P1p5GkjqtSbfRB5w3KZdn3HMj6q3Ae4UqfSNGi2XqY1pAEajUA4ZBFXKMX?=
 =?us-ascii?Q?sIn6canAaYatkRauPwKU7T4GYX3kCscdgPfVdIZvMS4Midtchr54Xgv/x6UO?=
 =?us-ascii?Q?pqfMn55667tFvX9sGujHN+scGsP5gpvYd9IEZ09HtgJXk06hBsDpnIJ4El5X?=
 =?us-ascii?Q?0UEipPhRLTu+T/SXfkCAUPQ/4nOZPH35UVzRzrHE2yYEBtvIBRql6Qx4VZJp?=
 =?us-ascii?Q?DoB74fwTz5iBSMw8093l5O/TcM+G/3icmXbGMWWxALlgRetXyCE3twgioUFt?=
 =?us-ascii?Q?sptsuMKU+eZSJMNu43X5SvwuM5E/hMh/FwmiaXM7rk+mZ8KV5TAxqwyby0xB?=
 =?us-ascii?Q?pu5cs1gfej1LngNmnlJ+2LwKgkezFp2X+Qv28+YOI4aww6hzGmLD6aDtrUQq?=
 =?us-ascii?Q?dhCuIeGGLUbDZjQmkBF+s+VNKj7UE+NBNeRUb0bjz02iGzxmQbjF5JTi0xnu?=
 =?us-ascii?Q?Npd4YgHR6/wSFmBRkrjqZYg0cwvNjrv76JRIHNnPeGqvjLmB+ruiqlAs2TBD?=
 =?us-ascii?Q?fm0aWZlMvqmWI7c6QgkUT85iV2bpNDavpE2jAmwChhzRFi51BmLOOhXQT1K/?=
 =?us-ascii?Q?1Lcq14wTkuyroVHe53676SV3rvEFzTy7kKpz61HUihtu6xfx9mwle/n8krQH?=
 =?us-ascii?Q?sQHX0np79Yz5mnMW7H18S48zf3abEENz/lDuqMsemBaxKBIRWaC20T0OfcND?=
 =?us-ascii?Q?zFG3rAmNOg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f1170b-3a9f-41a8-326f-08df2f4cab36
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 08:24:04.7084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQzrw4PR6h6LRHV7x/t9r8yGCwpak1pC34UnTPvX5T4Xq75IuIGZjD+bejFPssWjPvrVFtgwP3iX/wBgAaXK9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10906
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

On Tue, Oct 20, 2026 at 04:12:53PM -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Add support for the Waiken WKS101WX001-WCT, an industrial-grade 10.1-inch
> IPS TFT LCD panel with a capacitive touchscreen.
> 
> Although the module advertises LVDS support, enabling LVDS operation
> requires hardware modification, including the removal of several on-board
> resistors. As there are currently no known users of the LVDS configuration,
> only the default interface mode is supported.
> 
> If LVDS support is needed in the future, a dedicated driver can be
> introduced to handle switching between LVDS and LDB modes.

s/LDB/DPI/ ?

> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v3
> - add wct surfix and change to use MEDIA_BUS_FMT_RGB888_1X24
> - Add information about lvds support plan.
> 
> change in v2
> - update height to 135 from 136 (sashiko)
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index d7dbd7442919b..f2a1668087de7 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -5252,6 +5252,34 @@ static const struct panel_desc vl050_8048nt_c01 = {
>  	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE,
>  };
>  
> +static const struct drm_display_mode waiken_101wx001_mode = {

To align with the compatible string:
s/101wx001/101wx001_WCT/

> +	.clock = 71100,
> +	.hdisplay = 1280,
> +	.hsync_start = 1280 + 70,
> +	.hsync_end = 1280 + 70 + 10,
> +	.htotal = 1280 + 70 + 10 + 80,
> +	.vdisplay = 800,
> +	.vsync_start = 800 + 10,
> +	.vsync_end = 800 + 10 + 3,
> +	.vtotal = 800 + 10 + 3 + 10,
> +	.width_mm = 217,
> +	.height_mm = 135,
> +	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
> +};
> +
> +static const struct panel_desc waiken_101wx001_panel = {

Ditto.

-- 
Regards,
Liu Ying
