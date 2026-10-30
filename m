Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4B4606A32E
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=L+4XH4eb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A2F51127FC;
	Fri, 30 Oct 2026 13:05:58 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013059.outbound.protection.outlook.com
 [40.107.162.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A1371127CF
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 13:05:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ehtt53d7DBfk5632fPQ3sNumxKMw0/HbwQdOPHtBX6xOTMDGMjV6scN+/XJhd+F5gbr63ZlB1VGrli2vS45QGBtIB4GaOcnqkjiOX08WHGmzpVdwIMBC8Hjq9DT/XRn2oUl3R68ZPmXEPchQkOX3IO+OOraAX5o4tHKq3oNzCtU0E4pXyVmN26x1kx/bDyXzT2uh7RLWHYvpRc7YuPFcrXMc87808oA9SYr46LPgy6zY8+nU4Tybf3Ikqw/1NHkRx9GKkYSOX9zL8+uoQIJ1hIHsMhpjPc1B0C3ERpN0Yz/QnVgQnsVE9HafyGf1+FBpr9zSgDNsI2aV087nlLINMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14PfnsdPhnqz2A3Lf0RDtajzYPCsZBzqqFsm84SgIKI=;
 b=c5ddbReEu3veIadsQClpHiuucWvfBkoGaQ6e8HZ65OCUv0E2DDGgzqGB5udbGE5JrLCOF+CmO1MYKWs6xhzE3zPSWC91lN1QeBhTAMVHoB8N7oEHznm/aTd8kU8Lq9tJiBtNXvcvqVjp6vCeYk3v8qZxagldLInxNh0CE8bF7BsFIE+4/Rx+gKnw7kUSD4RoiFzMOftbYFQ7aSEU7EUCJK0MERKxzEDaF4yMnq0jl/xG1RPsqCF0jrBwh1aLj74xrmNQEbtsTMPFx2DY+3lxqHnpN3wmkOTc1pREq224g1oHWIYoU5ji+714U5aOuLn8Y+NF4cL5PE1w3MfzQrrfTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14PfnsdPhnqz2A3Lf0RDtajzYPCsZBzqqFsm84SgIKI=;
 b=L+4XH4ebNOS2/juD6HoiPDVDWA5ZWegV10z2Z1yvOu+bxmMD2KiAZ1cDLZ9R/OCoo5C23oJ7xdL7x3oRjU5SwvJJgmP4DoZFm7vvHfxO5V0vvW2G726UG1iq23Jx5Mum/JQlhL/ahWGlQ6zwHXmjrFNZfVaSt+0DdlYJs8W00Khf/3vDQK0Fqrx14fytNX6HEXAyffW11upT3DezNricZ7kZFjCJdT1U8WyDFOzC9Ymc4GJpqSMDyfmTdWO35BUM1JrzKvW+jYbvcPDKDHzAYVJrfK+ULLTCISC8sbBHhHsfVxOeFVHgE0sQvVmXNU/HYq/mOJoa9Zv0ypR8Xlxxkg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by AM9PPF97652C55F.eurprd04.prod.outlook.com
 (2603:10a6:20f:fff1::a14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 13:05:49 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 13:05:49 +0000
Date: Fri, 30 Oct 2026 15:05:45 +0200
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
Subject: Re: [PATCH v8 07/15] drm/imx: dc: Add PRG support
Message-ID: <auSNHjK_WDLfLCUr@vm>
References: <20261030-imx8-dc-prefetch-v8-0-c4f81afd4533@nxp.com>
 <20261030-imx8-dc-prefetch-v8-7-c4f81afd4533@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030-imx8-dc-prefetch-v8-7-c4f81afd4533@nxp.com>
X-ClientProxiedBy: AS4P189CA0002.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::11) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|AM9PPF97652C55F:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ca6f336-2bab-442c-8e5a-08df368684b5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|19092799006|5023799004|11063799006|4143699003|56012099006|261009223027099003|261028144727099003|261026140227099003|261021123027099003|261021121427099003|261022105027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AgDB8Au9SHLTdYA6u3nlUl69u/DYByeCV0GKYMVj+vWz5dJbPLgoo4nkDnx8ZM+kOIRH6oFEpLmuP8E0CxMioCt93OnAkgUPY1s18lfShO6i+wovdlpPk0pakRWYMFHIk0lbmvS64EEhJVzAHhF6ICJoebv9CNt+kuLbu4QXVL0shpjGTF9Ol9Ji0SVU5sAVb5XsD+FnHeq7AIxCzc4SzUtfwL09kLPS7ji39M0uwBFEZ5IyI0SrKApXiaZ1t45dMP2pGB7zlwH/Gn4QasoD3XEWhXgU5IDxQEzFAE09xr2IrOyvsBE80ktOQ1Uhr6BNlpFmZRe66YEWXx7u088cgiqOnA9Fs5TKVB+i5mrwNpTIi50sUWxnM9s33CgT5SSvMKYr/7YjI7uDmiDgKQ5zpaROrwqN3rzbve95w4fFFN95sdbSYRq0XRDD5o+UVYfvC1GTMi/yE1fOxXIyak1ckzXm/3m5tCSRHNnX7d5Tez35FmSVAELOdAMS/8uw9sSqJzKSRcp4NQL8E49G52LL9exq6IwSn29M+6zcGpC9X/yk2Ym+gEQIdwjrYMS3143sonPiyZc603tSVl77M3p/faIz5u1cQadmFrfWLqUqgKYyR/V2pOYhy95/EQxi4JFYLQs0DyhwTXfJg8AuT8V1PkAjt/cyuNG4tq2Oh8YLeHM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(19092799006)(5023799004)(11063799006)(4143699003)(56012099006)(261009223027099003)(261028144727099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022105027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rzuVYVoFMvNrTj18v21jp0nm2X9YV4nUtZcEjNpwFqJnUPDlP89EX0QG7iYA?=
 =?us-ascii?Q?5g4h+ayo4V1Ojl+LVMYySfXcZHu2E7RYyogfPS/39Mzhir3hoJ/i/QFblTvZ?=
 =?us-ascii?Q?f5HnZWiyfREE7mENGFax98VguCceF9yu1niXugyNbdibGHEHFzUdh4v0Ctkk?=
 =?us-ascii?Q?HSQo4ouEUnuQS3QjUzlbeACMdJ9j9JQ6l3Kz5yFVkioc0+fSjglFMmukt6yx?=
 =?us-ascii?Q?vg1buk5PEVF66bQO/ZN2YR7Ye3MZoLjRtuGcra5UEEAJh7at6VjIfWvjPe3g?=
 =?us-ascii?Q?HcuWORrKFKAZPbbpFnFeX6BXD/rk/7WjQGK+j+9iti7J0OPyMR64lONLpYnJ?=
 =?us-ascii?Q?NkRUwvbDwXffrcCVjyNxUZoPOz92TiB9B4feO2QHvrSnKSSY+g/rt/0ZbpTW?=
 =?us-ascii?Q?gj5TNHlG86RSJ0QEJp0gnqKv6HTswG5T5bUkw6SWCDjQ91V6Wv8rwg43N9aB?=
 =?us-ascii?Q?hce34fcmhFHQxTAp5h2nrbsCT4J3HVE4llvLNogZtZ52aaYvTWB0DJHmNXXR?=
 =?us-ascii?Q?oQMVkN0PYfFPwZlnH/KwgrWHFn2Qogm2yim68bf/o+M4LnyLF145m35i8xl7?=
 =?us-ascii?Q?2ydDUGX69OwMpZ2w7BtQxFxBaVJcQ5vjeSJvktwQQfO6OAUR6AelgsTJv7Nr?=
 =?us-ascii?Q?xwXYMaErteXoSof01PVt3fwET4m9aSqIfP6QhkDJmR4rrJpQyP2S56xBvKYo?=
 =?us-ascii?Q?2rHkpFL5TldctHsBhcxHjBnVr3bTc3TmPDzJBPGOO6Fa98S/pdYr7ZnWmkg3?=
 =?us-ascii?Q?j3T/f/Ad9aQlrugDAFFWqGRJ2FztxNAZvPrABHKygRGlKeX5u47HmoEMk8Oz?=
 =?us-ascii?Q?9Kh3MBIQMuUSguDyeWoK4XQWbXs4pkfj/Gbj3zpKAQu7jfCtx7BKtElXILuI?=
 =?us-ascii?Q?AsvvNQwBBSYdjrY4y1Ho0gc89dbe8Q9N5ZFWooJ0QF0qXFeJwNe8TRsosuHO?=
 =?us-ascii?Q?dFi9pnqwSI8Ffhuk1t/9sxrgxyLXqdAIWnnxOIkbPvRu8vOPMo1v4+4ord3q?=
 =?us-ascii?Q?h1inPSwGJLJjJgvMjlNgW1R3DlA27/OEeExO6Q+IPuOfrBmmxPc6H6lPvkxf?=
 =?us-ascii?Q?4g2Hzg6DeTqm8/7jcIZOlW+vHkWT6qZAMd3oYynpm3LNNz7Gl3JPV5jvnD9n?=
 =?us-ascii?Q?k7FPxM3sxge1Bp7JlIC9WKuidd+borU3v5FTwgHt58Jpixe3bctLXJZe6sPJ?=
 =?us-ascii?Q?R1O2AqMgHGq6y0OA//FWmyAS0HEsn0oP0bur+87Kfpe8f3mEiM02nOQYUU5t?=
 =?us-ascii?Q?3+4P5Z48+Bi8E34ZOMFCPV1J/jaVuaNJxI1QHA9tIEUIM1XICq2ngc2Os4S6?=
 =?us-ascii?Q?qiApWuSwXipOTXALTsQHxUfzFqu2hppKkG412Dd1hJR0YoGBZkrO3wufmJPE?=
 =?us-ascii?Q?vhhLaNnkkJeTkVXBqlzbHjOsFIgZmZxxnwoDH11QYI4tlbm+sjR9djYhE8Gu?=
 =?us-ascii?Q?1jPodcIfjEKGtGqMcFwZ8b/lkQmJDeHc1veTacf31a13Gl6Diy95dwCPrKR5?=
 =?us-ascii?Q?/BhNKU2v4WwtnKDz3AG6Nswr1cTeLK59f9OgewdmC22UZ0HDz7qXU2xTjTmi?=
 =?us-ascii?Q?BwiKHkLbdjvlXsgw8wbub0fZBLegeB9ESMTb5a/7f1yDW0yyWdoZFJupleSH?=
 =?us-ascii?Q?R7sJfYoO08TXO0SQMif7KSIYdZHRfRNl5q4tau8JR9IT2HpfV1QEGS1cii2U?=
 =?us-ascii?Q?MK7HL8hrXUM0N4K7QeV6RHz3jdjmeD9GX4RDeYHZjydgGxLY9tuAMTyV7m0Z?=
 =?us-ascii?Q?uAMzJjViCQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca6f336-2bab-442c-8e5a-08df368684b5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 13:05:49.1425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vaBOpMICMsXbirL6IK/UpogHheeNVorTMiRXXZMJrHL9aon6MK5D+q7nfkSgW3Rj/jwlNTt91V0F+rTKsu25Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PPF97652C55F
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

On Fri, Oct 30, 2026 at 05:54:31PM +0800, Liu Ying wrote:
> Display Prefetch Resolve Gasket(PRG) is a part of a FetchUnit's
> prefetch engine.  It sits between a Display Prefetch Resolve
> Channel(DPRC) and a FetchUnit.  Add a platform driver to support
> the PRG.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v8:
> - Fix dc_prg_burst_size_fixup() to avoid overflowing signed integer 1.
>   (Sashiko AI bot)
> - Check device_link_add()'s return value and bail out if needed.
>   (Sashiko AI bot)
> - Drop unused header files.  (Laurentiu)
> 
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
>  drivers/gpu/drm/imx/dc/dc-prg.c | 318 ++++++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/imx/dc/dc-prg.h |  35 +++++
>  5 files changed, 356 insertions(+), 1 deletion(-)
>

[...]

> diff --git a/drivers/gpu/drm/imx/dc/dc-prg.c b/drivers/gpu/drm/imx/dc/dc-prg.c
> new file mode 100644
> index 000000000000..46108f7e09af
> --- /dev/null
> +++ b/drivers/gpu/drm/imx/dc/dc-prg.c

[...]

> +
> +bool dc_prg_stride_supported(struct dc_prg *prg,

I searched all commits and this function is never touched again. So, you could
safely get rid of 'prg' argument since it's never used.

Otherwise:
Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

> +			     unsigned int stride, dma_addr_t baddr)
> +{
> +	unsigned int burst_size;
> +
> +	burst_size = dc_prg_burst_size_fixup(baddr);
> +
> +	stride = dc_prg_stride_fixup(stride, burst_size);
> +
> +	if (stride > DPU_PRG_MAX_STRIDE)
> +		return false;
> +
> +	return true;
> +}

[...]

-- 
Thanks,
Laurentiu
