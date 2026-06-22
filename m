Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4E1CDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 16:13:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E21610E742;
	Mon, 22 Jun 2026 16:13:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="U3TNNIs6";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010057.outbound.protection.outlook.com [52.101.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A82E10E742
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 16:13:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0Yu8Wv8zuGacQoVHYLFgBK6UXm6dxULHDgmGP3wNlmie54meMG64k97J+a8X8EAej9dtNOSL8lpjN57UEeq+KM0nOoGeIbkcNfQrNULksUWclQQY/3GhG8rw4E8MGzG/oPZkclCBKYgwFhbL3YyCpSjAguvytUcnEaCwQvAN9POInUnZcAL2yz1khnwyAMtZmuCgLdTK9DK9/M0Gdujpp+YQoz2e47TL/uYbJvjyZwKwtTOKQg2VHIITySCR5oCGwOeZZoY9x8KfVreDPysXW0krDOhyR4QCgmCr85+w/6A59UNwNbnmkcOTb9WgKirvjSmMWQwvtIi0QX3c0zanA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y31eW8XBObbHYeMRwo1e6dICXNWmbiTFs9DKyduRqNY=;
 b=tX/yB+LLsE78oJq+Uv8XgtXA2/ZWZf+JQTTxb225Z+PgN0hzUzd1+K5JDkAVCYCuEb18icKCkfYUJEQOmLY0uc40eJUq/WtxYrvqOVxzqtYQKJc93rrknCqXqxRfMjOrlZawD1xrQKVQNeLS5RAN+8d67KhFZiwEpxBbS32JBF2p9WpjgNlZbi2cAbstTNBmt2ygqR1CzHgVe/rzizB53vltJR6ddjIkluvtWl7ZRNH5ygXb/ibNMWhDx6zodUOVc6Uk4SHqxzUZq0V77jiKeArf+lsRpSfptrYo/txdubprFOJ/ssNw/KdrO/30U0FehcQKqfuEygsuT2sPXh56JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y31eW8XBObbHYeMRwo1e6dICXNWmbiTFs9DKyduRqNY=;
 b=U3TNNIs6aQQDaAOdRwH1gworK2yHxYkkFJtniHo4pq4aKRXdcEPzsUyOBxe625oz3nLbdnI7MJ6iHxeo7BRNepLpdWHMWo7EgMkAfnQqlFoQZfsr2uGts8dItnpUCzz5dhRBtrSSg4hWVuMEkP+D2e+cmmEiocWS/bW/q5eE2lwJ3fWcaVQ4DXnxlsyzKQwv64QSuEwvclYlzMZXKPQh3fSspi+9Mw+uzy3vrFxjjQkZQrWG5oH10G9RcIUdYrwGDP+of9XC41ylYHSr+1QKJwdwh7wFiZ7OwYeV9dMkJTJSgQe1ZKALU2KysFapoj83Edr2mofNOyiru+jxrSwuKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 16:13:22 +0000
Received: from CH0PR12MB8488.namprd12.prod.outlook.com
 ([fe80::c565:c0e5:2c8b:c315]) by CH0PR12MB8488.namprd12.prod.outlook.com
 ([fe80::c565:c0e5:2c8b:c315%5]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 16:13:22 +0000
Date: Mon, 22 Jun 2026 18:13:15 +0200
From: Thierry Reding <treding@nvidia.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch, rayyan@ansari.sh, 
 dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev, 
 Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 5/6] drm/sysfb: simpledrm: Validate mmap size against
 framebuffer size
Message-ID: <ajleu0THc75Ex7uN@orome>
X-NVConfidentiality: public
References: <20260622132433.722823-1-tzimmermann@suse.de>
 <20260622132433.722823-6-tzimmermann@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6oo5aay7mbhbwwq2"
Content-Disposition: inline
In-Reply-To: <20260622132433.722823-6-tzimmermann@suse.de>
X-ClientProxiedBy: BE1P281CA0228.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8c::7) To CH0PR12MB8488.namprd12.prod.outlook.com
 (2603:10b6:610:18d::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8488:EE_|MN2PR12MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: a3de6d2d-4c58-4fa3-9f73-08ded0792e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|7416014|376014|10070799003|18002099003|22082099003|56012099006|11063799006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: tji4nFY6NEBN/ITZrg46K2BOgfYZVcy70QN0Nvw0R0Yg+ll/T+xnDlp9zBUMZn/fXBc2squq1Xf1lbA5BepD+Go3AkVi34WZLw8zT/2pwxOJ0BcSmBaGxRjys0fsivoVCkhW6WqMGFOop6xNb7DRYxILAvjs0vKRKlga5Vz/xXU8byJz4QzS21VdymN6w+1jEOuAItfI+9KGtdT12/i/HATVzZg898y9Ym2BQHuhTEsZWu3BtZU4gbf5wEl25Pm0XAnpGxMtJmgMLuMee4sePC26czEltyMBBY09kIFY5X+HFWhFBbbI+u1zjsh/KnBUeBJnasCPWJSzIaRqJlCDSJ4QI2oyMLV/0tUyHWjvsKvhDPFHQQPFo1PXOUoSMaOnlVi+isVzG4ctI9uEuCK1kBc3YdeUa7ZixBhZcFf0atAd/kuDAkBrfaqz4sYJMBLvx3AkO+zDnYpdIJeqEVi95Oix2oNSroZt3eR0MDgjKExmGZMD+eRYYD9AYYvYAxVnsoMzrPxAlzXT66HZEqLc8vy6oju6L15x3/7ddBtk7DIhAlCB7m4zuUgsb3B5GanJ7uYwU/KmqdT5P2D05W95Si8Z0mMmm1iw1XAiytV/5t0bqKC4ofpIkVZ2kaB19Y7ZEB/JRTCz4KWfq0oqvNyJ/W8h98veIBVOV0k0gZ9qMSg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(10070799003)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gYQF2+kFgDc88ksEmHW9Gr2rsipxz10MK3fX48bGLm+RggLLAnBh/wZPOmzb?=
 =?us-ascii?Q?YP1Ph+WrgYXIqxaf8gVpfdslv1a1AL1M8/rt0X5Wwn7HNLeRhmxIHnWx3kH2?=
 =?us-ascii?Q?xsqvmikvMkIRIqcLJMmiUw8M/cv96yX090A88+04XIx1/njPKxEMso0wgyV0?=
 =?us-ascii?Q?wPL7oe6F0dF+Rqig+Jl8kY/SOt6XKITSWurPpqY/+WdOcbUehWSVrUuNfKT3?=
 =?us-ascii?Q?U1qLGZ27ZyyVPPpv4+Esbxx2dEr/QlixG0RCQFQef5881uYP6UdkTdQZDmg6?=
 =?us-ascii?Q?8BdeCyCE6i7XrHKlkET90NuIXKDRM3EiRJL5VU1PIntSOZOHL1NMV8lvMzJ0?=
 =?us-ascii?Q?MfjuFR2LJAUpGGGAp48mPw1NcU4m/nvQWvvwR6rwmulWFBD4kmC5vBOsoYbw?=
 =?us-ascii?Q?SBh20UfjWYQaohKSX/pTg380he0zKPKD33bsSL9ryOn9XJmauNLc0C/d3EYQ?=
 =?us-ascii?Q?LsBHKIEfnl1ZmmgZB0djn2hpUk6MGM1XfCEVRUMB7YcFbN2nymjEynKHt6rF?=
 =?us-ascii?Q?ihWUieZm2VGIvuYRADB8nYn97xcr93DeUPLi6r6RgkRfyw9bSHBcKNaBMUCS?=
 =?us-ascii?Q?lkWf4+ZWP36LWt7c8YUhPvsGztBb9SU2iGZEUFj+Lcq906TOJ1pvQWasliiP?=
 =?us-ascii?Q?mNTtahbDB8t2+yFHu0lMQ1WcwdZylQAbkrYmiGOjnJJubphdFUllc0aNf0hl?=
 =?us-ascii?Q?GfRG5B3IWCqKGS47+I3sgj43M5yklVD8IRetunczEl3SEEQjeEt+A/njsmCX?=
 =?us-ascii?Q?hJvzgxaIHSucY1CKrJiWqdXI61tWCpkjrbzaIFrvUI+lcadz/RYcG2gLWrjE?=
 =?us-ascii?Q?PajD3Jjah7tyOLUDtPqAMcVYNe+iN2Exx/RWJXrd/6s7sScgF2meJdlq6hec?=
 =?us-ascii?Q?07tsqKDHDrgg3nDgrSZeVQf/juv6gDExWozAIyAplRHkKJgcWFhPTH2pxGmn?=
 =?us-ascii?Q?ROqZZzyUx7CML+5ypNoyOHj3WDGwX0IhNWX4b/YAYMnSWlCleYZEHGEH/Jhl?=
 =?us-ascii?Q?IWuH3pNomTTFwatsXTSLXPLiszavplCBk5PTi2fKpgoST0eFTMkIIZQbvXWD?=
 =?us-ascii?Q?O4HEc5T3rWI6yr3/lBnMcjeRpco5bILWGtUu4P0+rOl5GIq5AQw8ednpOL5y?=
 =?us-ascii?Q?1nyoqLUCx8bP5SYGz81DwfB6Av1wRUbQW/jtFX+id38T7iHeWIg/0WL0tFE+?=
 =?us-ascii?Q?zEY6TnAn0/p9iZvCMXBXGygQl6z7JWeIVVhgTKkVkNt/JXcNxg/caCur5fSc?=
 =?us-ascii?Q?PyvA7bUuHX+Fb1gTArN+wtHa3qNg/NzGdgItJabznhXjr4aZLKAZQKjTdQg2?=
 =?us-ascii?Q?CPIexgTQZ+9KKDNFSIjkjo+3xrIzi9ZW4s4cO8JLJygYISAqEcTUXMXq+RKk?=
 =?us-ascii?Q?L4Yn8d6WP3gV8csnMPrQ/e3broNg3ftYVMq6Cur6F3WtdnbV1hzkAy8dF2eJ?=
 =?us-ascii?Q?P4PSXEeAmlWyLI678ULIl8dQtLMLVSRvlIdRDKNfoxYJ+IrArFMugfeMT31P?=
 =?us-ascii?Q?CPiD1w7ZIBSZbeeg5FVdHpiNrYb3pJX6Xa+XUavuEoaAhcZjb2wYfEzMwUzO?=
 =?us-ascii?Q?fhXlcL9OUb+uTup35K7GuP8yFblnKlNFQDX+zcNzyZiaW9PnJY8RrKziUcdM?=
 =?us-ascii?Q?1axbcs6HAmb7GB5XOsj2vSaRXwrt1gT0SUh4SaXxwosUjJp4krR0aGeQJta9?=
 =?us-ascii?Q?0iXMvxuSWenPNlFtH2tl7GVKPWqfYYOjXT3zHzNZ11IeKIgpyuSlb78kV/NB?=
 =?us-ascii?Q?qKTv2315y+7urypKo1BX+QAcEMsCYeM5dJPksOj+ZPBGDqVTQSvsbFN5+N3E?=
X-MS-Exchange-AntiSpam-MessageData-1: aReflnHym5XAKQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3de6d2d-4c58-4fa3-9f73-08ded0792e91
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 16:13:22.5766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NnPDOz+TAqSw2irkJJTI4nnjRymt5itIuJV2IXLNBocrH/q75ZuyMWiSPR6MSmtgmvxguelV+8nLTQDZqyMnhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320
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

--6oo5aay7mbhbwwq2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 5/6] drm/sysfb: simpledrm: Validate mmap size against
 framebuffer size
MIME-Version: 1.0

On Mon, Jun 22, 2026 at 03:19:39PM +0200, Thomas Zimmermann wrote:
> The size of the mmap'ed framebuffer could be smaller than the minimum
> required framebuffer size. Validate the resource size against the
> framebuffer size.
>=20
> Buggy firmware that triggers this check should be fixed up with a quirk
> on a case-by-case base.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Suggested-by: Sashiko <sashiko-bot@kernel.org>
> ---
>  drivers/gpu/drm/sysfb/simpledrm.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/si=
mpledrm.c
> index 76b9a3f5c4ef..a04f0c852ea4 100644
> --- a/drivers/gpu/drm/sysfb/simpledrm.c
> +++ b/drivers/gpu/drm/sysfb/simpledrm.c
> @@ -6,6 +6,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_clk.h>
>  #include <linux/of_reserved_mem.h>
> +#include <linux/overflow.h>
>  #include <linux/platform_data/simplefb.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
> @@ -624,6 +625,7 @@ static struct simpledrm_device *simpledrm_device_crea=
te(struct drm_driver *drv,
>  	u16 width_mm =3D 0, height_mm =3D 0;
>  	struct device_node *panel_node;
>  	const struct drm_format_info *format;
> +	u64 size;
>  	struct resource *res, *mem =3D NULL;
>  	struct drm_plane *primary_plane;
>  	struct drm_crtc *crtc;
> @@ -704,6 +706,15 @@ static struct simpledrm_device *simpledrm_device_cre=
ate(struct drm_driver *drv,
>  		}
>  		stride =3D pitch;
>  	}
> +	if (check_mul_overflow(height, stride, &size)) {
> +		drm_err(dev, "framebuffer size exceeds maximum\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +	size =3D ALIGN(size, PAGE_SIZE);
> +	if (size < PAGE_SIZE) {
> +		drm_err(dev, "framebuffer alignment exceeds maximum\n");

That error message doesn't make sense to me. Maybe "framebuffer
alignment below minimum", or something along those lines?

With that fixed:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--6oo5aay7mbhbwwq2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmo5XxsACgkQ3SOs138+
s6GKZA//Tjw7Ier1XifCZwPetCAvbg6E4RwcP2rEpAUZFulLC+7NHHVz85djqOCJ
U3SQnA3CdUY3lcR5fTeefGvJxwA5X/5zg/Ij+R8ETzB1OCpqGFNesLd9WbXKZgaF
m3YFMIBs1qtlANl/whWj/mjY+QezZvJEWfUvBoffz4Kqg7UWsBlXmjbYpLM+SpIt
E55HlF6c05thuE9bxC6shJOl+8IV0x2om2iA0y6PSgLN1T1QFWTR5SYWeYkWo2o2
MptxoFQlgVkCQNrT+mMgxkyQPf5Rq1qYVTuBHXXKhqmyvZGln2ICMwTL25ccQalZ
WtA8Yzm60x6hcvKHrPFoe4PzW5OCy6P3UYvXYeS29Oulf2U0UtW7UnJVXXiK4Z0O
m22nENSFcGxvB8FihqMKqGBvjeBzDOU6cgLzFnTzVgnlpoqZR0khTrA6JhoTk+bR
DT8zqOJ2wmlybB+28GNhSs4aFtuhmsSR2BtKLCLPmldf8vn49UHuQXRozj5f56TZ
IISbxr0hlKd7lK2KWw9Bp1iJwLOIOObNEGSBgcsDIUc3x2mzs6ykIAyTZj3PnoYh
yX0lFrZISEa7KvCjWni/HOp8CL/TueGiLFyB25jofuuyKLK+ogGvAvCmMBbBhFJo
BPpFTKp8z1YcUf7I6c9sUYLZgonHkegTAHpPRsGms1qjKhyK4qg=
=zbyw
-----END PGP SIGNATURE-----

--6oo5aay7mbhbwwq2--
