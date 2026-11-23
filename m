Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0DF606A332
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=RzwmmUBY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88E0910E800;
	Mon, 23 Nov 2026 15:55:16 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011007.outbound.protection.outlook.com [52.101.125.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A890110E800
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:55:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WI66egRAveI3mUSB/Y+EIkBXrZTNjIBDwV+19JILMsV15lgHrWut6qs2n0uHOXS2SCzez6Tni6wJ14f0Nwq/ZssFRGhB3XWgWSV8Ds9ERDEBdM1unBnAT1CZUzu15Tf0cQtzfpLckLvJdXRuj7K+Tw+eJwtnWmsYSf8WE09AQp3u/+zY0N1b8MX8I0hdT3oKcP60KJGTcCHa5oRfqzdfxWtm5MGU6XryON/KQ7f7sYf6RQPIJbCiwVZS76tYC4S2yCDWGuyPDs3Kvi8Tj2e7VY+/kv5OSAJzW3M4ZQxSqcoxaPGb90Iqz8QL/BkTZBjiZEmjMabP52VicgPpYa/opQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmG0rbnnfLtWH5aPfB+mbwNH2jm9+sWUakR7U+/yEP4=;
 b=A0l1dO1nxxaMEgvZ2C1pVxAE/XaEnI/VQeyEckGap9yjyWgCBWyxtXzr8xe0iyZQ07Fz5pkWQB88zgyqTVZ5OiIvev8d4PIX2cwGIqUVol9u6Gt/vKPE4MIlMtlYuXmwruEoybtyUHkCnigocXldYtbxA5zPMIO94zSpVolJiSdajByF9XBsjXcm74sW2sx8myEKGQ26nH6I9abScmimiriiJPy7RLx9WTSUoYZ1FKoiKHsGPtvG6N9ym+Ca10ckLVBACY6+PlFo9IWaV5E0qK3g+ugjWEWzpEIWMdla+IC/uh0BMpK/HoZZY5iuBkDkFHQloEkuz/Eq5ZLed6j6vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmG0rbnnfLtWH5aPfB+mbwNH2jm9+sWUakR7U+/yEP4=;
 b=RzwmmUBY8rkgsXdqhfiV4meYVbHauIn/nJQqftJglFS92mM1zij4GTwvo2T3TfQW0gKOis9IWilBEW0saLvI7QClskYju1rTlndra3RH1BbbfahGRM3tJS5CNSav9RcdQtNHsZ7n5ZwohZIH9BsjyYqMZUyY3u/gm3nmzS4AHQU=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by OS9PR01MB14268.jpnprd01.prod.outlook.com (2603:1096:604:367::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 15:55:05 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 15:55:05 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, Tommaso Merciai
 <tomm.merciai@gmail.com>, Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 "magnus.damm" <magnus.damm@gmail.com>, Laurent Pinchart
 <laurent.pinchart+renesas@ideasonboard.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v10 03/12] drm: renesas: rz-du: Reference the DRM device
 by pointer
Thread-Topic: [PATCH v10 03/12] drm: renesas: rz-du: Reference the DRM device
 by pointer
Thread-Index: AQHdc2lzLvef3a1Rkk2a0VWXEC5J87c71AUw
Date: Mon, 23 Nov 2026 15:55:04 +0000
Message-ID: <TYYPR01MB66036F725B906B38CE740B3986452@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <249e7d61f9ab39a9d4cbc8349fabdaf65899c9c9.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <249e7d61f9ab39a9d4cbc8349fabdaf65899c9c9.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|OS9PR01MB14268:EE_
x-ms-office365-filtering-correlation-id: 1212afec-5733-49ac-d25c-08df497a2422
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|23010399003|18002099003|22082099003|3023799007|56012099006|11063799006|261009223027099003|4143699003|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|38070700021|10067099003;
x-microsoft-antispam-message-info: d7u3rOUE1kg1RiogFIGEFi8doGoK6baZii0WpG10EphNkGwx10ivq0QXPoEMf5v1m9+bVjgzmZunjDcp/bLB9xkL5RF21AOBZ9jaLU5gFJQXl3Q4VAE1mIlAYTj9QRXEHopah84BsoSXAfggpTyYloiS1Vjb/70sFqfRXezRYWPi4d7Ed/LEpX2u4Oodf0GNTWId8jV0MuM+a1qnvKWneJemcH1xp5+KO0TGoutMF7bJ86YNzQuSp029Vh9aYNnqNbFZXixizmvT/KnjU49SAIzLs2aK9a5umrmaBQ7wBtqkLClo1AVnR928lO6MPbcKDWQqt5MUSMJ6Kx9ABNUr31JiiQx77AdiOoPoOJVl6XWWPXW5j8mfXfbDhI2CSDcJeth+SCy0uJJ2eQotoSO1EBXcTUgU+asoILLHO+gyCp3wOfCD4X4flmPowEGK8eNd3JIh/PQfoE9Oo0SqXU5EJ1ZIZ2xt81QujeRDhmPSsWs61bvWeDqqcbkBEcfTQBlkD7uX/Ss+6lO9X1bq5ozlrT7CCqKKYDp8gftOEJH3H0blRip5VJ0x9vER/njFs+KgqpVuQj+H43jUl5hj9Vnegb37OUqlo0dqpa3wDfog8UiA4jLADp2H44VyhYzKswnlejKP/uT2Dho5m82Sp3N2zFND5BzSml6I2iyb/yomZznnjLC/FNgNxW5RTM+Caj2D6JIACL/zXR9IFidnf5DMj4umMXlxJVMY6F+mIMtMQ1U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYYPR01MB6603.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(261009223027099003)(4143699003)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/kTMQdL7mb83iKwnucLwYdO1i1GNi3f0A0yEI3uQrAWMgZr764nUkmVWlJ2s?=
 =?us-ascii?Q?y0si0yhtVIMCb1HFaKOwqzXyOTiiECJUXri157G0tSPsTY4pHXc7erawTHa4?=
 =?us-ascii?Q?xKFdu1riwtv+QaWWjSX5KAa9YMUL2YJyG7GdrPQkARkbz0UOaPm3vzFv42V1?=
 =?us-ascii?Q?HWTctS/ICMVWQ74eAyVTqFnYCMzfXpQ6z3iLSeNgwv+iLph5UWYk1y8wjVCP?=
 =?us-ascii?Q?BXr4ZnoZmmHDad9jradCT4XjqDVE7reLkph9AngQAoK+yPo2X1UALDRSr0Hd?=
 =?us-ascii?Q?dvsIyO350eJNNDYjuDHHOiAEYMDVx9a9UFq5TRyIBbyoE3DWvVJ72FNsuR6P?=
 =?us-ascii?Q?QySVj43YVkZlegeQw06JEiUsgX6XJRaFRZ+DVOYLNuVExMSik/7KvG/50aFe?=
 =?us-ascii?Q?GBGfz7GYHzDN61V1hNVksmDCbJyS/iqogvTtaXyqHvltT0NgN32WG/9iel9S?=
 =?us-ascii?Q?C/6ZiMHKN4/dAWnRx9RKQ5x8jp/+y5lYtlXOrjwiBQ+x7vgcYEzo/zwKT0VL?=
 =?us-ascii?Q?1bPmutvDONh49FGVnTXyrmFKUYRR7zZ6Q3q/xYmoP3hTD7MG2WdhNskr+LPZ?=
 =?us-ascii?Q?3PGFn7IZduZbcOUcEBdvzVYSRL5W0n3pET4EOZdI20lHMAb6hoj7i+RDIqKa?=
 =?us-ascii?Q?0X2iu966wiOG85J2ytijKfNzCe2A7WZk5WYyZmx85oN8W9XV1T0YMho0uFHG?=
 =?us-ascii?Q?OAxt2J8w2utVEyg5eopqhZ2r5piKq35uz9HCXVWgOAQBl7Ksv460+sY/6S9M?=
 =?us-ascii?Q?+tXSaisvlShnq92G5LwHs5bMU9mxiSiIDPiq9QdunMlotwvMBp3+ye0+CA0z?=
 =?us-ascii?Q?bMtujnjHQN5dEHehOHjUcCPzQjV3/3EY3KWBgHQBn/sMMVJXVvBZXkUkNal3?=
 =?us-ascii?Q?fdHx5kwMQZZ9R9zaNYrO7r/CCGPa34OD7VIPvumAafj7gkq/cGaivnr9/7iI?=
 =?us-ascii?Q?UZKrFtyfBgU1YY3IbD/zffzoHKroDpJv1ybfAfcWGDnmoDpZ8Xm8d2CjGz7U?=
 =?us-ascii?Q?akfyDI5G2Yv02wkwLajRb7LelI09NlcorqUmaVopUVEZFfh7+XxWRCZBcW9Z?=
 =?us-ascii?Q?GPfVZMeNHxa+fVrfxAGnhut0ixcEQoXS3lNfv++vHtdX0uNhjY6mEiLtmZxb?=
 =?us-ascii?Q?Kj7J1UmRBEfeEhZ3sjjOyXLKh+y/wsGYLQaG6iX/UUTVCKkkQ/VfWvOVRM0j?=
 =?us-ascii?Q?IGhQsTY3PDasmlu3eEayREoNQlkhmNCnk+I2LelPhVXkPHxjIqbC0m/xmmT6?=
 =?us-ascii?Q?+2N8bvYo3xEeA29fDhn+wRGQNwV0lp2FsM+LDqRh+/N5PW6R2vncYkRxzcW5?=
 =?us-ascii?Q?H0jB3oxVev5OtYcoLCoAIZcA0Gw50wViSa6Mdc0u7n+48buVJrzczPoQKaIE?=
 =?us-ascii?Q?Rd1av/nAkxLrSdVIZ2Jbjmrrh3Xggwh/Mf1psxJVcvAxKeIp5cdxhL+INPjh?=
 =?us-ascii?Q?2ul8FcrD6Q4Z4U9ouSdsrUrbtPI2vbeYAmJ1ks7+gSnt2eLqPojgmOtRek9I?=
 =?us-ascii?Q?x7AzoZVeKMO5QUjRGjsuMG2OTISRX59L7qcUoJe2KdcJ1846ClWWyP0+sBBO?=
 =?us-ascii?Q?KhdrmIWlBpA+ghYgv3E0fCzNmpANRk+Jv5K/G+fZ/WbgdyTv6lUDia3hkB1g?=
 =?us-ascii?Q?TBe+aWHWhrJVcADelrjOHgzoH7zHJ+rvFyOF2xjyVPOd8CFdMsfO14fFHY8e?=
 =?us-ascii?Q?HHA3gtMUX8Y5N4i1lfcHfPnp9IlkwlciZD7QjcjAS5iKzU7BNTYBqG4ix5Xo?=
 =?us-ascii?Q?rggkW3P+Xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6603.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1212afec-5733-49ac-d25c-08df497a2422
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 15:55:05.0526 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x6KumQ8Bz2yev1YppU/D7/f0mvO/6PmV2CC4QtBrJv+zCeGyC9vsAUz0OXEiuUK3haOETV5XpUBApsNwUMccyZclgjSXcz1rVNcU1SQoIOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14268
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

Hi Tommaso,

> -----Original Message-----
> From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Sent: 13 November 2026 12:20
> Subject: [PATCH v10 03/12] drm: renesas: rz-du: Reference the DRM device =
by pointer
>=20
> struct rzg2l_du_device embeds the DRM device, which makes a DU instance a=
nd the DRM device one and the
> same. RZ/G3E has two instances that have to share a single DRM device.
>=20
> In preparation of supporting it, reference the DRM device by pointer and =
give it a container of its
> own. The instance is allocated with the DRM device rather than with the p=
latform device, as the CRTC
> and VSP cleanup handlers point into it and run once the DRM device is rel=
eased.
>=20
> No functional change intended.
>=20
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
> v9->v10:
>  - Rebased on top of [1], converted the PM ops too.
>  - Kept rzg2l_du_device as platform drvdata, use rcdu->ddev.
>=20
> v9->v10:
>  - No changes just rebased.

Duplicate change log v9->v10.

>=20
> v8->v9:
>  - New patch.
>=20
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c |  2 +-  drivers/gpu/drm/r=
enesas/rz-du/rzg2l_du_drv.c
> | 39 ++++++++++++-------  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  |=
  7 +---
>   .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.c  |  8 ++--  .../gpu/drm/re=
nesas/rz-
> du/rzg2l_du_encoder.h  |  1 +  drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms=
.c  |  2 +-
> drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c  |  4 +-
>  7 files changed, 35 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c b/drivers/gpu/=
drm/renesas/rz-
> du/rzg2l_du_crtc.c
> index c57884ab5b9b..398532933013 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
> @@ -411,7 +411,7 @@ int rzg2l_du_crtc_create(struct rzg2l_du_device *rcdu=
)
>=20
>  	primary =3D &rcrtc->vsp->planes[rcrtc->vsp_pipe]->plane;
>=20
> -	ret =3D drmm_crtc_init_with_planes(&rcdu->ddev, crtc, primary, NULL,
> +	ret =3D drmm_crtc_init_with_planes(rcdu->ddev, crtc, primary, NULL,
>  					 &crtc_funcs_rz, NULL);
>  	if (ret < 0)
>  		return ret;
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/d=
rm/renesas/rz-
> du/rzg2l_du_drv.c
> index c7d71dd9198e..57197356143f 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> @@ -17,6 +17,7 @@
>  #include <drm/drm_drv.h>
>  #include <drm/drm_fbdev_dma.h>
>  #include <drm/drm_gem_dma_helper.h>
> +#include <drm/drm_managed.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_probe_helper.h>
>=20
> @@ -148,14 +149,14 @@ static int rzg2l_du_pm_suspend(struct device *dev) =
 {
>  	struct rzg2l_du_device *rcdu =3D dev_get_drvdata(dev);
>=20
> -	return drm_mode_config_helper_suspend(&rcdu->ddev);
> +	return drm_mode_config_helper_suspend(rcdu->ddev);
>  }
>=20
>  static int rzg2l_du_pm_resume(struct device *dev)  {
>  	struct rzg2l_du_device *rcdu =3D dev_get_drvdata(dev);
>=20
> -	return drm_mode_config_helper_resume(&rcdu->ddev);
> +	return drm_mode_config_helper_resume(rcdu->ddev);
>  }
>=20
>  static DEFINE_SIMPLE_DEV_PM_OPS(rzg2l_du_pm_ops,
> @@ -165,10 +166,14 @@ static DEFINE_SIMPLE_DEV_PM_OPS(rzg2l_du_pm_ops,
>   * Platform driver
>   */
>=20
> +struct rzg2l_du_drm {
> +	struct drm_device ddev;
> +};

> +
>  static void rzg2l_du_remove(struct platform_device *pdev)  {
>  	struct rzg2l_du_device *rcdu =3D platform_get_drvdata(pdev);
> -	struct drm_device *ddev =3D &rcdu->ddev;
> +	struct drm_device *ddev =3D rcdu->ddev;
>=20
>  	drm_dev_unregister(ddev);
>  	drm_atomic_helper_shutdown(ddev);
> @@ -180,28 +185,34 @@ static void rzg2l_du_shutdown(struct platform_devic=
e *pdev)  {
>  	struct rzg2l_du_device *rcdu =3D platform_get_drvdata(pdev);
>=20
> -	drm_atomic_helper_shutdown(&rcdu->ddev);
> +	drm_atomic_helper_shutdown(rcdu->ddev);
>  }
>=20
>  static int rzg2l_du_probe(struct platform_device *pdev)  {
>  	struct rzg2l_du_device *rcdu;
> +	struct rzg2l_du_drm *rzgdrm;
>  	int ret;
>=20
>  	if (drm_firmware_drivers_only())
>  		return -ENODEV;
>=20
>  	/* Allocate and initialize the RZ/G2L device structure. */
> -	rcdu =3D devm_drm_dev_alloc(&pdev->dev, &rzg2l_du_driver,
> -				  struct rzg2l_du_device, ddev);
> -	if (IS_ERR(rcdu))
> -		return PTR_ERR(rcdu);
> +	rzgdrm =3D devm_drm_dev_alloc(&pdev->dev, &rzg2l_du_driver,
> +				    struct rzg2l_du_drm, ddev);
> +	if (IS_ERR(rzgdrm))
> +		return PTR_ERR(rzgdrm);
>=20
> -	rcdu->dev =3D &pdev->dev;
> -	rcdu->info =3D of_device_get_match_data(rcdu->dev);
> +	rcdu =3D drmm_kzalloc(&rzgdrm->ddev, sizeof(*rcdu), GFP_KERNEL);
> +	if (!rcdu)
> +		return -ENOMEM;
>=20
>  	platform_set_drvdata(pdev, rcdu);

Previously this code is after rcdu->info.=20

>=20
> +	rcdu->dev =3D &pdev->dev;
> +	rcdu->info =3D of_device_get_match_data(rcdu->dev);
> +	rcdu->ddev =3D &rzgdrm->ddev;
> +
>  	/* I/O resources */
>  	rcdu->mmio =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(rcdu->mmio))
> @@ -228,18 +239,18 @@ static int rzg2l_du_probe(struct platform_device *p=
dev)
>  	 * Register the DRM device with the core and the connectors with
>  	 * sysfs.
>  	 */
> -	ret =3D drm_dev_register(&rcdu->ddev, 0);
> +	ret =3D drm_dev_register(&rzgdrm->ddev, 0);
>  	if (ret)
>  		goto error;
>=20
> -	drm_info(&rcdu->ddev, "Device %s probed\n", dev_name(&pdev->dev));
> +	drm_info(&rzgdrm->ddev, "Device %s probed\n", dev_name(&pdev->dev));
>=20
> -	drm_client_setup(&rcdu->ddev, NULL);
> +	drm_client_setup(&rzgdrm->ddev, NULL);
>=20
>  	return 0;
>=20
>  error:
> -	drm_kms_helper_poll_fini(&rcdu->ddev);
> +	drm_kms_helper_poll_fini(&rzgdrm->ddev);
>  	return ret;
>  }
>=20
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu/d=
rm/renesas/rz-
> du/rzg2l_du_drv.h
> index e9626ef37cde..47ceaf892339 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> @@ -69,7 +69,7 @@ struct rzg2l_du_device {
>=20
>  	void __iomem *mmio;
>=20
> -	struct drm_device ddev;
> +	struct drm_device *ddev;
>=20
>  	struct rzg2l_du_crtc crtcs[RZG2L_DU_MAX_CRTCS];
>  	unsigned int num_crtcs;
> @@ -77,11 +77,6 @@ struct rzg2l_du_device {
>  	struct rzg2l_du_vsp vsps[RZG2L_DU_MAX_VSPS];  };
>=20
> -static inline struct rzg2l_du_device *to_rzg2l_du_device(struct drm_devi=
ce *dev) -{
> -	return container_of(dev, struct rzg2l_du_device, ddev);
> -}
> -
>  static inline bool rzg2l_du_has(struct rzg2l_du_device *rcdu,
>  				unsigned int feature)
>  {
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c b/drivers/g=
pu/drm/renesas/rz-
> du/rzg2l_du_encoder.c
> index a1b48973aa8e..5c21c5f9fbaf 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
> @@ -52,8 +52,7 @@ rzg2l_du_encoder_mode_valid(struct drm_encoder *encoder=
,
>  			    const struct drm_display_mode *mode)  {
>  	struct rzg2l_du_encoder *renc =3D to_rzg2l_encoder(encoder);
> -	struct rzg2l_du_device *rcdu =3D to_rzg2l_du_device(renc->base.dev);
> -	const struct rzg2l_du_device_info *info =3D rcdu->info;

Maybe to keep the change minimal

       struct rzg2l_du_device *rcdu =3D renc->rcdu;
	 const struct rzg2l_du_device_info *info =3D rcdu->info;

> +	const struct rzg2l_du_device_info *info =3D renc->dev->info;
>=20
>  	if (renc->output !=3D RZG2L_DU_OUTPUT_DPAD0)
>  		return MODE_OK;
> @@ -133,12 +132,13 @@ int rzg2l_du_encoder_init(struct rzg2l_du_device  *=
rcdu,
>  	dev_dbg(rcdu->dev, "initializing encoder %pOF for output %s\n",
>  		enc_node, rzg2l_du_output_name(output));
>=20
> -	renc =3D drmm_encoder_alloc(&rcdu->ddev, struct rzg2l_du_encoder, base,
> +	renc =3D drmm_encoder_alloc(rcdu->ddev, struct rzg2l_du_encoder, base,
>  				  &rzg2l_du_encoder_funcs, DRM_MODE_ENCODER_NONE,
>  				  NULL);
>  	if (IS_ERR(renc))
>  		return PTR_ERR(renc);
>=20
> +	renc->dev =3D rcdu;
>  	renc->output =3D output;
>  	drm_encoder_helper_add(&renc->base, &rzg2l_du_encoder_helper_funcs);
>=20
> @@ -153,7 +153,7 @@ int rzg2l_du_encoder_init(struct rzg2l_du_device  *rc=
du,
>  	}
>=20
>  	/* Create the connector for the chain of bridges. */
> -	connector =3D drm_bridge_connector_init(&rcdu->ddev, &renc->base);
> +	connector =3D drm_bridge_connector_init(rcdu->ddev, &renc->base);
>  	if (IS_ERR(connector)) {
>  		dev_err(rcdu->dev,
>  			"failed to created connector for output %s (%ld)\n", diff --git
> a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h b/drivers/gpu/drm/rene=
sas/rz-du/rzg2l_du_encoder.h
> index 3e430c1f6132..dfffcc14e0a3 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h
> @@ -17,6 +17,7 @@ struct rzg2l_du_device;
>=20
>  struct rzg2l_du_encoder {
>  	struct drm_encoder base;
> +	struct rzg2l_du_device *dev;

dev->rcdu for consistency

Cheers,
Biju

>  	enum rzg2l_du_output output;
>  };
>=20
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c b/drivers/gpu/d=
rm/renesas/rz-
> du/rzg2l_du_kms.c
> index 87f171145a23..13d14ecacba9 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
> @@ -402,7 +402,7 @@ static int rzg2l_du_vsps_init(struct rzg2l_du_device =
*rcdu)
>=20
>  int rzg2l_du_modeset_init(struct rzg2l_du_device *rcdu)  {
> -	struct drm_device *dev =3D &rcdu->ddev;
> +	struct drm_device *dev =3D rcdu->ddev;
>  	struct drm_encoder *encoder;
>  	unsigned int num_encoders;
>  	int ret;
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c b/drivers/gpu/d=
rm/renesas/rz-
> du/rzg2l_du_vsp.c
> index 12fe35740c62..4df4f0ff0ed5 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
> @@ -298,7 +298,7 @@ int rzg2l_du_vsp_init(struct rzg2l_du_vsp *vsp, struc=
t device_node *np,
>=20
>  	vsp->vsp =3D &pdev->dev;
>=20
> -	ret =3D drmm_add_action_or_reset(&rcdu->ddev, rzg2l_du_vsp_cleanup, vsp=
);
> +	ret =3D drmm_add_action_or_reset(rcdu->ddev, rzg2l_du_vsp_cleanup, vsp)=
;
>  	if (ret < 0)
>  		return ret;
>=20
> @@ -324,7 +324,7 @@ int rzg2l_du_vsp_init(struct rzg2l_du_vsp *vsp, struc=
t device_node *np,
>  					 : DRM_PLANE_TYPE_OVERLAY;
>  		struct rzg2l_du_vsp_plane *plane;
>=20
> -		plane =3D drmm_universal_plane_alloc(&rcdu->ddev, struct rzg2l_du_vsp_=
plane,
> +		plane =3D drmm_universal_plane_alloc(rcdu->ddev, struct
> +rzg2l_du_vsp_plane,
>  						   plane, crtcs, &rzg2l_du_vsp_plane_funcs,
>  						   rzg2l_du_vsp_formats,
>  						   ARRAY_SIZE(rzg2l_du_vsp_formats),
> --
> 2.54.0

