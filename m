Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8418CC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B76E710EF63;
	Thu, 27 Aug 2026 09:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="vqqd01XC";
	dkim-atps=neutral
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010035.outbound.protection.outlook.com [52.101.229.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0BFF10EF63
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 09:54:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/5R+CfqrFRWZE/iP2jKJMeFapst/s19YvmNeKSCeLFaTQ2X/ld7nfEy/GQoIHQ5rdlCa3CMTRJZ2ELpIJHSiamZNHFCsLqRJv8W2MmeloB5qF/iaHQ2zx0YZjn9OgbOLnJC/dOXex2EQINIqZFB2r2qJu6s68sQdZNPHxzcoocBypIBFea9Pecj32VVrZnG0Tmn6YAKIE+WfPepH29xE7yIcXYGZBv5PLG0rcu+Ppv+mfcABO0nQD8JeBHBKhhvGL8NPy7zFWcjogjlQlZFVaH8l8w/My9cxycG3QMWQcuZNMsVc7RTbzHkdweqBIT5vOkhdhxCoxCyUYfyUhxtoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaJHtES7TOA8k/HbVilXgUdWCjCIetN+uOzShVTQD98=;
 b=bIhX1Ft3eWYo+fdhUARmjxJvx9OSF2fvWiktVxQ82v4Wpenz56P+Wv0d1sh74KVum9puTDFv6b82QqJq3GLiWG9cnKg2qZBz8mO0qet9iTvPlqr2kI/hEQ+MREVF5KxbL3ZtfnqXXIatM6aPxBv3mzkb5kMiYk0MZ/qvHgWIqjuQ7SZNy2eYj4MSzOi3hKSl/ZFDOLGjGr4TIvgGqdhR4NurtKG7wSozPDTrH+MniUlR6cY2fHndl7zfo4wWXPUxeK/rD8dfzM+Hk31WJ4WT6pMBI+Cr/d3dpuattMIhxCDjn85Nh0Gi1TudsBY1HPPbhBB2uNOHpOzmCO8F917x6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaJHtES7TOA8k/HbVilXgUdWCjCIetN+uOzShVTQD98=;
 b=vqqd01XCd+yXPNibYiCSuSHNqeKpRP8rjZUP8YREbzvi7ECS1glKN1VzyFBs5u5XSrytV71sU9MgOai3I/WRw6DOp5o1jceuCsojCjA8Pnf2/0OrOXPDeEFswOkuobvZfiy8Ff0Njvi5aqe6vDVps60bIHvPC15mxmp5sXu8GmI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TYWPR01MB10224.jpnprd01.prod.outlook.com (2603:1096:400:1e5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 09:54:28 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 09:54:28 +0000
Date: Thu, 27 Aug 2026 11:54:12 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 05/13] drm: renesas: rzg2l_mipi_dsi: Add RZ/G3L MIPI
 DSI support
Message-ID: <apAJRBTNAPW4ZOeO@tom-desktop>
References: <20260826174854.199139-1-biju.das.jz@bp.renesas.com>
 <20260826174854.199139-6-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826174854.199139-6-biju.das.jz@bp.renesas.com>
X-ClientProxiedBy: FR2P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::17) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TYWPR01MB10224:EE_
X-MS-Office365-Filtering-Correlation-Id: 9efa727a-df7f-4497-cd32-08df04212f18
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|52116014|23010399003|376014|38350700014|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VV1O/zNbvsUYahvdAwTYThQE21nmYuw0aMp3N2uIojnfnm3QLc4WF1Ayy8O9FFKmb7SPlOuNLJVnV7LhM1Ol3emq1Rs18aqtkBhECubraBqhvJaEcD/o5JbR43a2G5zv5CyDixvjGeH6s/aRZuRsNH7TjC9nM1wlef5Li527guOfUdFlNYS/3gP0BNtSgO2IZkuHAol6YBbPOtFhKIO49nVRdckFbDYd/z1vIfJI+0+oDcCJNE0xPLo74V97z+2yZ+Y01JWtkw5nruE5nk39pWrLwbMU5TiqZYd2CiQG5iStWW2C+BOnxBtKQI1/8iZYwlTeyVoctLeXLJ6filc9lxCP/M1iok7CvZ4oAPqgRX2trVeDU+DcLRNfwzEuPmSlPS5by1SNCEpWXi3/O7/D1C18mJyGzSqzbVr5N/Q+HYPqHDWiuBVCROYEB8o7XH7wAuVOTtD4e2sgouBRt5xk/S/Fo3s4AAhFW1r0nabFDu/Zt3DXNS7Ffh5R5B4ln41boL+SKgplkDKd5NApadFed8U9Xb/5gE2nBjXXP1geCyc3vpvgjhsQI2vB0kjP8f6Zbg97oIO/j5KpMzsHMgNSAfiolbTzmPEdc4ytRQNPrRquy26MIvZqYohaRh+Xwcbc98JNJzn44jTVjqhIMoQ4/u3pHWqfBkEfhSwqXyBMDXCnycDcYsjMjaOdc4kr+hKuW4yo4ee6S+OWdXAgveggcGi8cHdUFxlthendZq4ilsM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(23010399003)(376014)(38350700014)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GKGBPA+wjSra24vOkYyy6/0++iemz/vwTA5K/dn4ge4Y2hNeJCusAr1Emgsb?=
 =?us-ascii?Q?Sg4/vvsZP8uKFoCOz7S0uVbo/1sCYC5RBjsu6hJASw4olelgtvJpxMgoH6Y+?=
 =?us-ascii?Q?ZWqsnu0f00/Ls3qObfrEpOjDf89vTh8jUkZ6CDDodkWYBcAOez9Vw99h6vCV?=
 =?us-ascii?Q?roUzEX4VbCem4wXnvmpfFrFVIMkuWAeL7ygcBpmy5PvcoXSKVUdmatuLrVj2?=
 =?us-ascii?Q?2Du50Dnncm8Ipc8ArRgKxd+mB2YiK3BM6KAdPHgOTi64xjZZa4SCfBSs9hT+?=
 =?us-ascii?Q?sRzuuCA1YWmHgqAAuM6tsg8NlblHETE8Djzt/CNSdbX8YI3hGRZ1I04dPjW9?=
 =?us-ascii?Q?obx8yF9oMHvmz7vrGbq0TxN0BYDCyWeQr1/ImzXQwzVS2qqRWhxJ1K64O+4c?=
 =?us-ascii?Q?gT09e35enIoBoWEKs3KqIYD+TxEozYeczVdLRifL3h1o4Gz+Ef1i+ue6zpni?=
 =?us-ascii?Q?AI7AsnRlYaiz6Yw6MFsEQQz+a30invDQbRJEeYJUVsCJ191FXkSiaNN99P7f?=
 =?us-ascii?Q?9GRACY38w2YZj9h/Kub5tNdOfkEfu5LqRiq9tS/Vir2IeoLjkP+q1SZkrfSi?=
 =?us-ascii?Q?RO8BLKO/HNru4cTVeUMkwU4QDzZNF7pEs1hxM8Sg5Mv0VDvGCR5naMKbQoUN?=
 =?us-ascii?Q?oMlBZs9SR8OH/FtxGBoQan1Z2pGvOKXgM/3wJ58nleuqBBSdqsHIk9XjjeLH?=
 =?us-ascii?Q?k6N62GdwbXzNXfmInBNuJysVccHFHBiZoYGZj+g7w8OWrWCLMTy2ZqV6vJrJ?=
 =?us-ascii?Q?AQ5fk1ZCSWGZKoV567m2SZ7RpbjPYerywdHR9TdipDxtlvf1xp5UgVHu2hPa?=
 =?us-ascii?Q?pev47+w7v00WwtAT9szsDxTyk/y+Tl14/2gsimskaBs1MIJqyn9WXtDunwbX?=
 =?us-ascii?Q?QBjGZo8yfMjF0rkIuSSAeA9ulUL8tEw0oeddSai2YppWp/ZLLZbjYYv8A90v?=
 =?us-ascii?Q?Y6E1AFGMh1E2YhIL4O/KpTKX4bQFqqpmhiv4/bewPjkjJ0/bLnTVNmwzQSnX?=
 =?us-ascii?Q?HFh0rZxFE3QgFUTnMJ3VdbwXHM0Xa7exaQeBe1dNJ/8+jRkW+0pfTQUJTUI/?=
 =?us-ascii?Q?rrTASCOb4KWrl0e/wTKrBSDhZ0Vu4bk3igATcPDvpeA5llNHagHR/2NqsmCd?=
 =?us-ascii?Q?ygm2MJIJUzWOc+TFIFO8hg7Hvk9QvvBNJB8nAy1Rf+n7fDVK5GLnJSEzQVGE?=
 =?us-ascii?Q?/X3IqrGwCCCbWKGDEKKiM+pN5CakwOf4UzxXiFwI5KCy56QShjbUXp+RQP+m?=
 =?us-ascii?Q?WES8rQWyM1FFJMtlZ28YsGjZFpOmEdLfq1wmYmwm77RzhLYs//GR4q5rZVzV?=
 =?us-ascii?Q?HMcogwV7fPAW4PBmKN3+W8kU/UIwBoYy+tFEr83yXAvQr/8LB5J6yd+JqI4m?=
 =?us-ascii?Q?LWWtCEDNbPqvhuq/XFaGb+rViHXrTOGy79acJkDoYVlknNAUecXvGuJ0GZ5M?=
 =?us-ascii?Q?JpCWCHfnEqKfzTnpHWoKsuUyiqqkPPzPM0QYYh+MTJB50FGtFYPy1rLPMjuB?=
 =?us-ascii?Q?Z9FipUYoLjg2dwhiYDUj9oN8whqWJx8A9/ldKCoNU6YN7W04Zjhso3T9wpWx?=
 =?us-ascii?Q?wL1dmupGs9f9ILw+mjdmiB2p7EpRchblMwmFXIUHK9ia5dowdvnBnjc6Kd/V?=
 =?us-ascii?Q?n+MSwMpMw63BC5mhgGApu/BGoLdc7Wi/DfUdxip24xJUTIGLH+6UNr6d6F9P?=
 =?us-ascii?Q?RQOUYS3+UbwK/GS3BKjZN9mo8JyqpnhlKMKwu5RaRL/s8qlTgd8G0ZxQGrjw?=
 =?us-ascii?Q?aCGtuRaflve5+IMXsxB7OfKGeYCKG8gzI1jcFezo3fdI36alWs7v?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9efa727a-df7f-4497-cd32-08df04212f18
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 09:54:28.4096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: McRREtvM+8f3blrPqbXDxV0dwdkPU7S0BeHdT5iS4nwXb+gVno/tz4xpkt925IaH1uAOskel/GQ3cyH9Pf5yBLGw+iK2r1+2QtP3T6sgCUvUeWy/wHD2DXw5ymQpDAaA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10224
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

Hi Biju,
Thanks for your patch.

On Wed, Aug 26, 2026 at 06:48:39PM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> Add support for the MIPI DSI controller found on the Renesas RZ/G3L
> (R9A08G046) SoC. The D-PHY global timing table of RZ/G3L SoC different
> compared to the other SoCs. Introduce a dedicated D-PHY global timing
> table rzg3l_mipi_dsi_global_timings and wire it up via a new
> rzg3l_mipi_dsi_info hw_info variant for RZ/G3L SoC.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Moved set duty cycle to DU encoder.
> v1->v2:
>  * Replaced syscon_field->pwrrdy in struct rzg3l_mipi_dsi_info.
> ---
>  .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 117 ++++++++++++++++++
>  1 file changed, 117 insertions(+)
> 
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> index 7df5f4a4161b..88ec0612d529 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> @@ -226,6 +226,107 @@ static const struct rzg2l_mipi_dsi_timings rzg2l_mipi_dsi_global_timings[] = {
>  	},
>  };
>  
> +static const struct rzg2l_mipi_dsi_timings rzg3l_mipi_dsi_global_timings[] = {
> +	{
> +		.hsfreq_max = 100000000,
> +		.t_init = 79801,
> +		.tclk_prepare = 10,
> +		.ths_prepare = 18,
> +		.tclk_zero = 35,
> +		.tclk_pre = 13,
> +		.tclk_post = 94,
> +		.tclk_trail = 10,
> +		.ths_zero = 16,
> +		.ths_trail = 22,
> +		.ths_exit = 15,
> +		.tlpx = 9,

Ok

> +	},
> +	{
> +		.hsfreq_max = 150000000,
> +		.t_init = 79801,
> +		.tclk_prepare = 10,
> +		.ths_prepare = 16,
> +		.tclk_zero = 35,
> +		.tclk_pre = 13,
> +		.tclk_post = 94,
> +		.tclk_trail = 10,
> +		.ths_zero = 16,
> +		.ths_trail = 15,
> +		.ths_exit = 15,
> +		.tlpx = 9,

Ok

> +	},
> +	{
> +		.hsfreq_max = 250000000,
> +		.t_init = 79801,
> +		.tclk_prepare = 10,
> +		.ths_prepare = 13,
> +		.tclk_zero = 35,
> +		.tclk_pre = 13,
> +		.tclk_post = 58,
> +		.tclk_trail = 8,
> +		.ths_zero = 16,
> +		.ths_trail = 10,
> +		.ths_exit = 15,
> +		.tlpx = 9,

Ok

> +	},
> +	{
> +		.hsfreq_max = 400000000,
> +		.t_init = 79801,
> +		.tclk_prepare = 10,
> +		.ths_prepare = 12,
> +		.tclk_zero = 35,
> +		.tclk_pre = 4,
> +		.tclk_post = 58,
> +		.tclk_trail = 7,
> +		.ths_zero = 16,
> +		.ths_trail = 9,
> +		.ths_exit = 15,
> +		.tlpx = 9,

Ok

> +	},
> +	{
> +		.hsfreq_max = 600000000,
> +		.t_init = 79801,
> +		.tclk_prepare = 10,
> +		.ths_prepare = 11,
> +		.tclk_zero = 35,
> +		.tclk_pre = 4,
> +		.tclk_post = 35,
> +		.tclk_trail = 5,
> +		.ths_zero = 16,
> +		.ths_trail = 6,
> +		.ths_exit = 15,
> +		.tlpx = 9,

Ok

> +	},
> +	{
> +		.hsfreq_max = 1000000000,
> +		.t_init = 79801,
> +		.tclk_prepare = 10,
> +		.ths_prepare = 11,
> +		.tclk_zero = 35,
> +		.tclk_pre = 4,
> +		.tclk_post = 35,
> +		.tclk_trail = 5,
> +		.ths_zero = 16,
> +		.ths_trail = 6,
> +		.ths_exit = 15,
> +		.tlpx = 9,

Ok

> +	},
> +	{
> +		.hsfreq_max = 1500000000,
> +		.t_init = 79801,
> +		.tclk_prepare = 10,
> +		.ths_prepare = 11,
> +		.tclk_zero = 35,
> +		.tclk_pre = 4,
> +		.tclk_post = 35,
> +		.tclk_trail = 4,
> +		.ths_zero = 16,
> +		.ths_trail = 5,
> +		.ths_exit = 15,
> +		.tlpx = 9,

Ok

> +	},
> +};


This is aligned with:

9.5 MIPI DSI Interface (DSI)
Table 9.5-4 (Recommended Setting Values of the DSI D-PHY Timing
Register)

Of the the RZ/G3L reference manual.

> +
>  /**
>   * struct rzv2h_mipi_dsi_timings - Timing parameter table structure
>   *
> @@ -1580,7 +1681,23 @@ static const struct rzg2l_mipi_dsi_hw_info rzg2l_mipi_dsi_info = {
>  	.activation_dly = 1000,
>  };
>  
> +static const struct rzg2l_mipi_dsi_hw_info rzg3l_mipi_dsi_info = {
> +	.dphy_init = rzg2l_mipi_dsi_dphy_init,
> +	.dphy_exit = rzg2l_mipi_dsi_dphy_exit,
> +	.dphy_conf_clks = rzg2l_dphy_conf_clks,
> +	.dsi_global_timings = rzg3l_mipi_dsi_global_timings,
> +	.num_dsi_global_timings = ARRAY_SIZE(rzg3l_mipi_dsi_global_timings),
> +	.link_reg_offset = 0x10000,
> +	.dphyctrl0_init_val = DSIDPHYCTRL0_CMN_MASTER_EN | DSIDPHYCTRL0_EN_BGR,
> +	.min_dclk = 5440,
> +	.max_dclk = 187500,
> +	.activation_dly = 100,
> +	.features = RZ_MIPI_DSI_FEATURE_16BPP,
> +	.pwrrdy = true,
> +};
> +
>  static const struct of_device_id rzg2l_mipi_dsi_of_table[] = {
> +	{ .compatible = "renesas,r9a08g046-mipi-dsi", .data = &rzg3l_mipi_dsi_info, },

Looks good to me.

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

Kind regards,
Tommaso

>  	{ .compatible = "renesas,r9a09g057-mipi-dsi", .data = &rzv2h_mipi_dsi_info, },
>  	{ .compatible = "renesas,rzg2l-mipi-dsi", .data = &rzg2l_mipi_dsi_info, },
>  	{ /* sentinel */ }
> -- 
> 2.43.0
> 
