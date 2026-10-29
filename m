Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C4360A2600
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=t7K6/Lh1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25D23112112;
	Thu, 29 Oct 2026 09:31:13 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010025.outbound.protection.outlook.com [52.101.69.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B14F6112112
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 09:31:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jb8o202vnRpao99yvaCDz+LGP3N0wc7078OOHcn0z/xxhjkqGOAFDkR/Xds8lVoz11DF84Mx6LEgaNC+jtT4AvWA34shM12xF6EvA3ozQ9LXpSel9xloi/Y7dRmWjXRbo8YgWdzvfBhaG0Z7v2nYq3ceEDGsgEKo+MU8H+WFQbAoxV5lnCcGKIgCRUnvocNM73YELfdhhduZBlmMWRg7UPFFzvOYStPjA36p73AaWcLZ792j88DWeF33gqR1TdA9nttifkSFoJYkC3iuCcEIgiRCVlYiBfgC/54jsa6Kd3kfF+movGUFSUocSi4Rv98wbWpKnauhyWVTWj7oAR1V/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3f4JlL/Lq4UVK+KUuf9gsC2xhpreisQLjDZzyrloJ4=;
 b=IUS/vTfLbv38r24Y1AI5ujgkJui/n5MWwtEwPGCUfch9wdEA4leFEYLm9jsvvlHQOm+5EpFrTLo4q6JkMMd6VunrPu5YJbLtdqSKup6qqNtRE4LSgqmkHxTDOTvsxnhB+KXT78P+iERo/dw5R6egamOXPYjTauTh7d3r+WJbPnjQFanklZT/oP+MMJpAY2cB+YII1JMSmK0Dn20xtGewDbiuUBrAw8wMsCQPPWBl6bSju0LKJbfL2g8rXu/+59rud/FCzeUmRS+x51068A6sSaS3EW2MaJqgBNAGiU+ew7Lh50u1MDjfHENilLSHeDAm0unhwWAWgSXEdgFXF6v1RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3f4JlL/Lq4UVK+KUuf9gsC2xhpreisQLjDZzyrloJ4=;
 b=t7K6/Lh1fRu0TEM2q0WNKqG6IjQyabJrbqXSjEabPfRhMAUba/nheA3jHuq7my2GUn26VFeeOnHgAPzJeK7XQcYVLURBOfGqkJLxl4CeoB603kfNIImqp8UaWjAd9DQCpquYmVSSKUwveIh8nDhHg5dgyeGhnMACxDeOkBVGeXaPf21QWOo58yA3xeVNsaFdqupAfn4P65aC0AwYbkfXUUq6aXHmU1QmpUaxFbI/iDab6BGikE2C/as2/etWzwDnVjuXm0iqG02a3p9bnHJKshsQOqyzCrtDXmSxBGW2qzvjatrCuU/vZsvzisfGIkrxdEAYdkrAXZEIfiV16A5n6Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by GVXPR04MB10681.eurprd04.prod.outlook.com
 (2603:10a6:150:226::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 09:31:01 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0546.021; Thu, 29 Oct 2026
 09:31:01 +0000
Date: Thu, 29 Oct 2026 11:30:55 +0200
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Liu Ying <victor.liu@nxp.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@mailbox.org>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v7 07/15] drm/imx: dc: Add PRG support
Message-ID: <auMIsiZ5ARIl-6N6@vm>
References: <20261026-imx8-dc-prefetch-v7-0-a0b50cc4fc65@nxp.com>
 <20261026-imx8-dc-prefetch-v7-7-a0b50cc4fc65@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026-imx8-dc-prefetch-v7-7-a0b50cc4fc65@nxp.com>
X-ClientProxiedBy: AM8P191CA0008.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::13) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|GVXPR04MB10681:EE_
X-MS-Office365-Filtering-Correlation-Id: f47da405-a5ea-425a-2ffc-08df359f588d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|19092799006|11063799006|4143699003|56012099006|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261022105027099003|261022075727099003|261021121427099003|261021123027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: iZn+lFjfmRuP3W461T1zBwQ2xfj3hPwXKyeusrNBGsIRhy15Hn8cVADBdGH/AQhBre7m696r5RVhROSQThg+daGVntjGgKHwvhDYoAdbp5i/7KRhniyB0pKMuxQGJBkEO3bcElIGZpyK/GOEtd1GNMalMUAZmj5MQp1ARvIBmKNEVmXYYQV/oAFCZTpxqDJyj6d/a26NnRqpRLGDOE5m8fiOLkPOoXM89J9w6MXYUBHA0QlEUKtnIO0qbEtPhDrW1xg8a7r2hr+jovR3rxy7fOJ9h8+sDdW5eJeYqiJjqkFxgWvCsi9ZgVYTFTsnf+jVGVPV9awRxa7sz2uh9/5hAwIyDYRQrZ5LBBEB7BfQhijIkUBWAL9c2aueLYAdD+w8BeEdH1rDyrK7k62G3g76Asq47fjqP+AhWEcRIKKcRwfq5X3WXCw+5Jctw4y7j2GG3FCtlGSGLwDBYSDjSopAOVbeb5koiNPBo80JOamkYAYVG9l17pDnuq/9ykq35eyIyxYFRI9K681dnPl9HpMfCZJ9Zg8KSNLozZ00990XlLfYzhohIYwNeTH1PUSJlF/pBtyPCVmJXP+VYNkPr6CM+un7oBNcjNVgFJc0VPTrfCayK7db8ZwZSDQ0y8IoucKSBxO8eRh7nUjCbAanGrDCOy+eQo/yZjmGATy0GwHvCGs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(19092799006)(11063799006)(4143699003)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NV0eyPMUt28vYbrnt5JhAsuNP9ErThw3XEctk31ut0kMEfjYh2WPNsFpMT8R?=
 =?us-ascii?Q?tD1BKcCufYi1fs9vJWF8fPSnhLU4Lp0b3C7UtSdARXAqLKM6QjUp7gkWTCq8?=
 =?us-ascii?Q?DSB3/Wc0hMWeICMRMVColfnC6k1l/6F2pxhMnjus294WzE/u3mM6WBHFLJLa?=
 =?us-ascii?Q?LemBxvKua475P3/oBnhqYTgF8DWQeHBHOyj1rQRHsqxBvWR2AH6Fv9k8TtKD?=
 =?us-ascii?Q?rD1nNRxP+cEXgYmW6PLCx8SRl4HQy+KvwRn5u2MFShdpwzqam/cPlfQdIO0O?=
 =?us-ascii?Q?3zqIpJjjCMifRyNJCyYEa1a2taLBi+rZeWBb0KVD/qbGP5xWT114K0tT70OP?=
 =?us-ascii?Q?bT96sWDo9428eDr0GuLJUJCyMoBIzuBmtqMswRiS6S8YHOXkmtHabbs8ISC2?=
 =?us-ascii?Q?zKNtJm55cWJ6rGseu4e7stHqIeYW/nAvk9K2yaKuydQFr+ir2nwjplFWw1t3?=
 =?us-ascii?Q?kUEYgEtA984cKlkTb+OKD3E9yGBuURSefZKNcdFjGiZNmAaOGKvmixYTBu7B?=
 =?us-ascii?Q?PfGRp0K8GMG87jWhKaGXFu7S/RAkTSWyrUBm5pGdNWFLuJMd31hk4FMdFzte?=
 =?us-ascii?Q?cpkJxDS4pb9aH7eEkF7Kxr9RFOWEzr4GEZs2nZVJpdZ8KlK0xxg0SRq/5FtA?=
 =?us-ascii?Q?4y0FiEmtRgaGLhWxENvbkb2Vo1cRHltGDQrjELvNy0vxK7ZaG07NQdwnM3KP?=
 =?us-ascii?Q?jbMqAZne/FXAZr8+U+j4AMynIhEbbxsj2neLCkDPa04jwFMLfFiPjR7c1rW1?=
 =?us-ascii?Q?7iw9teTeYyteQynM3/gu02CamfHvbqApQvCO7TF/ri2ttZBtm0octF8I9esd?=
 =?us-ascii?Q?+sulHKINi4b4M+lG5yVJUVvKNimtWFRsTX8iBV1+OtXaxraNnqg8P25CiI5w?=
 =?us-ascii?Q?jpAtD69pZNr05qiiUM+x6R1M4cQkDHo3F+yYmkLPqhziivBxWHRbBALqPSSP?=
 =?us-ascii?Q?Cmdu5UpqqD2qbn/Qbvrwwtssr5VVaO6F0BJFcVp9N1Yeyp8Lqa/yj8uN6kx6?=
 =?us-ascii?Q?NURKZtLsxSfVkSGwY+ZH34RHPLI7tI+NpRUCKhKqUfquwR8mItSemLpbYO4k?=
 =?us-ascii?Q?v6xDGIDLAu+PimILcTFru/oPpfNIHiSU7FnBU+ZjTpe0roEvmO+Lf3leoyII?=
 =?us-ascii?Q?SuqWu5BJfU8N+GS2QbEgn9Q/iJiIsliEyhG0sMm+uTWfb9gNygUT5j3Fj5GC?=
 =?us-ascii?Q?bk9pUX9hHAInXuojVPhT/6uCZuVyDSoPYq+vKqi7jH0zRzkr5soHev94Q5q7?=
 =?us-ascii?Q?ExDtNluyAPGYCQP3dbMJVY8o8ZuAoR0l2nig15XMemFnnzi6CBYSKpvfjhf+?=
 =?us-ascii?Q?dERcphMYlaImxO5YJHFnTpr27bLUvXVNskxMugOJmQpV3Ib3+1X+sAOX1GAX?=
 =?us-ascii?Q?q9wgo6muWyiEmNIillzyng9Gz6GLqiIDXyefTt/rQyMFJyAYY7rNW1F1BhSq?=
 =?us-ascii?Q?HIGtj0+owlC/6kEj1s+6bAUDBBE9Z5wRwC5Ah/INvgYc7rJyVXrDfLf9WTU1?=
 =?us-ascii?Q?vSNPBLG7Jdp0sXubKW3TT9Xu79bMCNPVsaIraMj4UzJn/c0e1CRqzxtVZHaU?=
 =?us-ascii?Q?XDMMIQ691QsJa67KMfmFkPZSWpiTHCisdyt/feiF4te4uyvFJ73BmYSwm2Fx?=
 =?us-ascii?Q?jNfisaOAiITlp4CTLNe/BPbo+/iNwWvPps+UczswwHRZ29UG+LjFQ+MMTsdT?=
 =?us-ascii?Q?JxQi4q+ccSohbCmqtVhW2hK1zjgFUowOw2htmqwapoqDXeVTkZgeFfdIV/3n?=
 =?us-ascii?Q?ah6TOCnQDZ49aTeK5WSd/iJqcgs6v7M=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f47da405-a5ea-425a-2ffc-08df359f588d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 09:31:01.3345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3bQPzMVrhJSjHaKwSCL7jOOKVM/vadAkpnYFDmPBaFB2kiz5fJYr3/BHEQar+fZeAhjmqZVxYP5hFvhn15nug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10681
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 06:05:12PM +0800, Liu Ying wrote:
> Display Prefetch Resolve Gasket(PRG) is a part of a FetchUnit's
> prefetch engine.  It sits between a Display Prefetch Resolve
> Channel(DPRC) and a FetchUnit.  Add a platform driver to support
> the PRG.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v7:
> - Collect Maxime's A-b tag.
> - Return 128B burst size from dc_prg_burst_size_fixup() when baddr == 0.
>   This avoids undefined behavior of __ffs(0).  (Sashiko AI bot)
> - Initialize and declare prg_node at the same time.  (Sashiko AI bot)
> - Add device link between PRG's consumer and PRG.  (Sashiko AI bot)
> 
> v6:
> - Include "dc-drv.h" to avoid build warning with C=1.
> - Fix PRG BYPASS programming.
> 
> v4:
> - Sort bits and bitfields in descending order for register PRG_CTRL.
> 
> v2:
> - Manage clocks with bulk interfaces.  (Frank)
> - Collect Frank's R-b tag.
> ---
>  drivers/gpu/drm/imx/dc/Makefile |   2 +-
>  drivers/gpu/drm/imx/dc/dc-drv.c |   1 +
>  drivers/gpu/drm/imx/dc/dc-drv.h |   1 +
>  drivers/gpu/drm/imx/dc/dc-prg.c | 314 ++++++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/imx/dc/dc-prg.h |  35 +++++
>  5 files changed, 352 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/imx/dc/Makefile b/drivers/gpu/drm/imx/dc/Makefile
> index b9d33c074984..e3a06ee3ce1a 100644
> --- a/drivers/gpu/drm/imx/dc/Makefile
> +++ b/drivers/gpu/drm/imx/dc/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  imx8-dc-drm-objs := dc-cf.o dc-crtc.o dc-de.o dc-drv.o dc-ed.o dc-fg.o dc-fl.o \
> -		    dc-fu.o dc-fw.o dc-ic.o dc-kms.o dc-lb.o dc-pe.o \
> +		    dc-fu.o dc-fw.o dc-ic.o dc-kms.o dc-lb.o dc-pe.o dc-prg.o  \
>  		    dc-plane.o dc-tc.o
>  
>  obj-$(CONFIG_DRM_IMX8_DC) += imx8-dc-drm.o
> diff --git a/drivers/gpu/drm/imx/dc/dc-drv.c b/drivers/gpu/drm/imx/dc/dc-drv.c
> index 09387d62cc0b..1d01f896e427 100644
> --- a/drivers/gpu/drm/imx/dc/dc-drv.c
> +++ b/drivers/gpu/drm/imx/dc/dc-drv.c
> @@ -351,6 +351,7 @@ static struct platform_driver * const dc_drivers[] = {
>  	&dc_ic_driver,
>  	&dc_lb_driver,
>  	&dc_pe_driver,
> +	&dc_prg_driver,
>  	&dc_tc_driver,
>  	&dc_driver,
>  };
> diff --git a/drivers/gpu/drm/imx/dc/dc-drv.h b/drivers/gpu/drm/imx/dc/dc-drv.h
> index 1ec9304329eb..27ef2c552549 100644
> --- a/drivers/gpu/drm/imx/dc/dc-drv.h
> +++ b/drivers/gpu/drm/imx/dc/dc-drv.h
> @@ -81,6 +81,7 @@ extern struct platform_driver dc_fw_driver;
>  extern struct platform_driver dc_ic_driver;
>  extern struct platform_driver dc_lb_driver;
>  extern struct platform_driver dc_pe_driver;
> +extern struct platform_driver dc_prg_driver;
>  extern struct platform_driver dc_tc_driver;
>  
>  static inline int dc_subdev_get_id(const struct dc_subdev_info *info,
> diff --git a/drivers/gpu/drm/imx/dc/dc-prg.c b/drivers/gpu/drm/imx/dc/dc-prg.c
> new file mode 100644
> index 000000000000..43df5683b24d
> --- /dev/null
> +++ b/drivers/gpu/drm/imx/dc/dc-prg.c
> @@ -0,0 +1,314 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>

This header can be removed.

> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/list.h>
> +#include <linux/module.h>

This one too.

[...]

> +
> +void dc_prg_disable(struct dc_prg *prg)
> +{
> +	regmap_write(prg->reg, PRG_CTRL, BYPASS);
> +
> +	pm_runtime_put(prg->dev);

I have a question about this. I see Sashiko also flagged an issue regarding the
unconditional put when the pm_runtime_resume_and_get() fails in
dc_prg_configure(). The resume is, probably, unlikely to fail. But, I see a
situation where the dc_prg_configure() is never called: when the plane is
invisible. The dc_prg_disable() would still be called in flush() when the plane
is disabled, would it not?

> +}
> +
> +void dc_prg_disable_at_boot(struct dc_prg *prg)
> +{
> +	regmap_write(prg->reg, PRG_CTRL, BYPASS);
> +
> +	clk_bulk_disable_unprepare(prg->num_clks, prg->clks);
> +}
> +
> +static unsigned int dc_prg_burst_size_fixup(dma_addr_t baddr)
> +{
> +	unsigned int burst_size;
> +
> +	if (baddr == 0)
> +		return 128U;
> +
> +	burst_size = 1 << __ffs(baddr);
> +	burst_size = round_up(burst_size, 8);
> +	burst_size = min(burst_size, 128U);
> +
> +	return burst_size;
> +}
> +
> +static unsigned int
> +dc_prg_stride_fixup(unsigned int stride, unsigned int burst_size)
> +{
> +	return round_up(stride, burst_size);
> +}
> +
> +void dc_prg_configure(struct dc_prg *prg,
> +		      unsigned int width, unsigned int height,
> +		      unsigned int stride, unsigned int bits_per_pixel,
> +		      dma_addr_t baddr, bool start)
> +{
> +	struct device *dev = prg->dev;
> +	unsigned int burst_size;
> +	u32 val;
> +	int ret;
> +
> +	if (start) {
> +		ret = pm_runtime_resume_and_get(dev);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to get RPM: %d\n", ret);
> +			return;
> +		}
> +	}
> +
> +	burst_size = dc_prg_burst_size_fixup(baddr);
> +
> +	stride = dc_prg_stride_fixup(stride, burst_size);
> +
> +	regmap_write(prg->reg, PRG_STRIDE, STRIDE(stride));
> +	regmap_write(prg->reg, PRG_WIDTH, WIDTH(width));
> +	regmap_write(prg->reg, PRG_HEIGHT, HEIGHT(height));
> +	regmap_write(prg->reg, PRG_OFFSET, 0);
> +	regmap_write(prg->reg, PRG_BADDR, baddr);
> +
> +	val = SHADOW_LOAD_MODE | SC_DATA_TYPE_8BIT | HANDSHAKE_MODE_4LINES;
> +
> +	switch (bits_per_pixel) {
> +	case 32:
> +		val |= DES_DATA_TYPE_32BPP;
> +		break;
> +	case 24:
> +		val |= DES_DATA_TYPE_24BPP;
> +		break;
> +	case 16:
> +		val |= DES_DATA_TYPE_16BPP;
> +		break;
> +	case 8:
> +		val |= DES_DATA_TYPE_8BPP;
> +		break;
> +	}
> +
> +	/* no shadow for the first frame */
> +	val |= start ? BYPASS : SHADOW_EN;
> +
> +	regmap_write(prg->reg, PRG_CTRL, val);
> +}
> +
> +void dc_prg_reg_update(struct dc_prg *prg)
> +{
> +	regmap_write(prg->reg, PRG_REG_UPDATE, REG_UPDATE);
> +}
> +
> +void dc_prg_shadow_enable(struct dc_prg *prg)
> +{
> +	regmap_write(prg->reg, PRG_CTRL + SET, SHADOW_EN);
> +}
> +
> +bool dc_prg_stride_supported(struct dc_prg *prg,

It looks like you're not using prg. Can it be removed?

-- 
Thanks,
Laurentiu
