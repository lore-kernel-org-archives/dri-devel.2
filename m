Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8D8FE5214
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 12:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4018110E3D8;
	Fri, 24 Apr 2026 12:11:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="iRE6bdD9";
	dkim-atps=neutral
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011067.outbound.protection.outlook.com [52.101.125.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6505C10E3D8
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 12:11:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nojR1wHMmKATaCdKcFtd7DTC3Z38R2MTFXKV1+rY6b5kb3v2QrkNaEPaxtkus0WtPXCcnupANtKosIBADlff5ZVVcVRBcALNA8wWWIevqJZnmtdHTGnO4caPEs039SLVfvRZFN76M2pVhdt2dI+Kq3GHpBtIf/3xAspO+ZtfSsLKIgq4KeGYDITKYgbiK2NeND7Ngfx31CfPfs065fU4uJRINHkZDRgEfTMFR/Hl/sx37jaTdgFZmiFzSBmTjxO4S5p6qUfuqBdXz9lB0zEGb1oIPns7hPKwmgbymV4S5QvW5rnort7lCVqpSMGjL1gnjIDge5ByKAoKmOuQo5n8KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NXN2eLW3eNkpnD4IbCOWokhvCGNZ/3R/aSrILAuxVo=;
 b=lcnKDOzVERo2oUflTDNDt4tmbjQ6nrty4DOxo5XNhw+bKg9yVRERlk1tTiEmqOsExxLv/BMIrlCiaLlLsmXOvD1Shiu5mxRaLPoJ1BOFbXgKWU+IxlYla8/+TEbno6wU+VxaGq8kciI/oLecx78XlBfYYoRTL9FEzCJBdXYcPHgmCQE3mB2Lb7/GhaQHci0Vgc9r4FHkM2LtNhLmKgEPUU/9bD0yKOSFV99BqcPp509ZgbIYDgsylnO71IMt912dNvSScbxiEB2fmKjVJ0jiiiI04M2drTWVwY/uxecJaYs511aZlpSr+V4DZOyomAnrhfDR5cUWRTlpoOa3HkwsCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NXN2eLW3eNkpnD4IbCOWokhvCGNZ/3R/aSrILAuxVo=;
 b=iRE6bdD9ZSlOdwKBg2LqEd7/CqVyoD5rSdjYJn/xY0C/PkFvNsLKE7F7qNS9vBlHGgkQKVdlfrtWQl69AWap7s83M2OOPjUcfTp5tu4Y7ZWTtlctr0DwietMsilQFHcqIMYRlzqrxu3w1ScXHz4BquU08R6GYv2LOodgidkJC1Q=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY4PR01MB12956.jpnprd01.prod.outlook.com (2603:1096:405:1e6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 12:11:50 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 12:11:50 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Myeonghun Pak <mhun512@gmail.com>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drm/renesas: rz-du: Fix MIPI DSI host leak on probe
 failure
Thread-Topic: [PATCH] drm/renesas: rz-du: Fix MIPI DSI host leak on probe
 failure
Thread-Index: AQHc0+HZl+gWwITglk2v57yDSiNU5LXuHuiw
Date: Fri, 24 Apr 2026 12:11:50 +0000
Message-ID: <TY3PR01MB11346F8E6E2B73C32DF73E0B1862B2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260424115936.7930-1-mhun512@gmail.com>
In-Reply-To: <20260424115936.7930-1-mhun512@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY4PR01MB12956:EE_
x-ms-office365-filtering-correlation-id: ce29920c-5b29-4abe-145f-08dea1faaa8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: M3R+A0GPb3aFJu59wGdYsPSntpiB245B7pVs/Atb+JYM33wyENeWwBi7ClGLBSfKxUGsAmzP8eQup8EefSna4u0f7o90LmOTLTFCsA1adejrTcOYK2POj2QcV8jjkpctsQ1+EHN3DwSvp2vnME267QHcR1SvYTVO8BkwPzonhAYc1GqGbMWrY90SJa9ub+EOT/Xn3co/HJpL41kqMRGOJabb2j+WAzVZi31gCvYm8fxGuZj7zBuvaNlEkEzg6ZwXhfEc9aX9SOfdE3+UNy7BwA19BNS+HaU2ZHqhmWCs6u0+S7RuOKQenElMrzPxTVNBuGf0IFmj6zCOnU0R0nxm85PeDPs4YH2NguLGHjiiJf+m1McXs7+9wIQu34zoFfexVHfYvQv22waf+2LBhq9CKe0EYW3qo3wOXfGiEOoOGzMcqRkMuHfL+epT8YaD9UEqOYOoEGu45tgPOAu2tMA/DbW/egwg77YG69HHltb06GoKOiatK7mYWEKnL0R8lWlSCepwCGeLAFyEuqZDBA6wg1RZQ5EhXTnbcaofEbZfhsdSEPC80QtShM/g3v6ExlWSMRvgfgqggrWZ4rNI7lD2eEdm/OEiF5CY9+AogWWaE394VubfLVId9P33a0MQ5ZfxJPBHb9uXSxlJ5cCE/HE2WvkIJjGrwj9MexPTReUZZMRNDrp4IpPuFMGXaXt+zc4UmoZ2iaWVeo6absC8Wz0inABGbNOHh5qulbTcjA1HQitwUF47jV6Iq1vrmtJcG2UP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NEZpgScmI9KPDc0t/Hw78oAE8cZwAN5PJMDnMCIcVFzyiRZ5Bt9gGh84Hmxe?=
 =?us-ascii?Q?mKKDLgoJF/hEwqWUdxzneLuMv+xLbiaCcjbkzDXtdIGz/6gctn/OhngSHp1W?=
 =?us-ascii?Q?YQMlUIxleiZ/FmXYJ8rIh0NH9OPS1jnNgFGOyTAN2GWG8zvs78vPYZQg58cu?=
 =?us-ascii?Q?CTA3RmKOJIdmeIC8yXzrmfIer8WQMibhKL6pGPxa6tk8skL0X5Ereq/uLvyq?=
 =?us-ascii?Q?yMcvDaaOZbMMcDgzQBIysmQHEyHAwmkBy4Dz+MkHI1m3W4OTqqa600awGPYl?=
 =?us-ascii?Q?ayPTn78StwEnOzbyZ6M6kt1TaLlivuI893y+ftA058TtOBbv2ZemeYgFXik1?=
 =?us-ascii?Q?qfWnVz+m2/yeVGXWgqov9CEIHCTb6iOxOGFP9J8ygqMoIOE1IHtW51bxO+is?=
 =?us-ascii?Q?GwhtQ3LKABifzO71XCvBIvlhGaLz63ILH4dmo43KYePNp/jJd1TV5+j9whrp?=
 =?us-ascii?Q?RezpUX/WmphB+J3B1YV2NVwrPDWY1CXEXis1LQabfkNyt5ka6SUrsXkNVAd2?=
 =?us-ascii?Q?yorRLzArmsvFybekgdB86cojkOS+Lzm3OkTfANyjy/eCLljqZU+cNu/Gl0sb?=
 =?us-ascii?Q?z9cYMSgFiuxOEBDSOAIwwrEBzuUgx6B7JxToCXuvoifFDAIIHs4NqGnUeApH?=
 =?us-ascii?Q?CtQeHarXhJSiwCGszhihq+nUdCWBmx31er6MNUQNppyWCowfYE1LoAnT0brA?=
 =?us-ascii?Q?DF8Yqeyun1cGzSzm5Ev90PJLvFBV9hG9rvouqKFtzlvd+THHoZe7ERbhnMol?=
 =?us-ascii?Q?HAtxgFY95/ZdMhZW08vy9tSl5xHLyFl/1XwD1Jf36ARwS8hLjxLwKUhKLQ7a?=
 =?us-ascii?Q?ksNBpmiA35NVsJXBqPJTy/D8weADZADr5N1/K69qKTd17W2/EBC2DyuXo9Qe?=
 =?us-ascii?Q?1kg4ny/b5EKeXTHmbO4fJNeYRToFUBKOhgqlxaT0/W4e7+9T+z78IEAN/5Nl?=
 =?us-ascii?Q?QdmlgRDCKM0ur5B2fu0/Xkt4Ny1NuAK0iVr9QAWFbl6aJDMBPaGa327DBzQn?=
 =?us-ascii?Q?sUh5uph+wbPvgjZm9PPYwlC4jDaaBPR8LI7Hs+a+nkBclUtV9IWKLQPptD3s?=
 =?us-ascii?Q?qfPtRGXYJNF3MVPxcs266nmFuvY8j1qMNuMdKuIRD3KNg/3f1cPAUguNcHm0?=
 =?us-ascii?Q?Ne5eav83D9ktc9bthW147Y24+dq/OFoEQhbDXv86LUfo8qM129J9knM5EJ05?=
 =?us-ascii?Q?Wu33nP+eNEEQBF86m+UZHkqAiir6ZNMwx7CrimHvRircSaF8Zf7IvuAb0eMy?=
 =?us-ascii?Q?PgHw4WCfESo+AJV3YPv9jOb14dWUDjFhjKJmc/V0MulHi0fvCGRSIDuXy91U?=
 =?us-ascii?Q?V6v/9eVRNzrGtUIBX5cpegGLnpMrJy6VpXrlaSGeM7zK/HlkLLauHW21jV4Q?=
 =?us-ascii?Q?ocdMHrcB3stamjV6GL/HfO4eP7q0zpHEFKMsWbm2Qns+s5UB5Pvf046SBAdW?=
 =?us-ascii?Q?Rf1k6uzS/OuQWW/TJ3CDQne1gWmnrYbtwcPqixM+IWikG1pXK0psq6L30xDB?=
 =?us-ascii?Q?RIS5BccnmQlh6LpmurlQIO2oJb3TfLDZUOAaz12IZzcfM8sOmNGZKbjv1nOF?=
 =?us-ascii?Q?ed6RA+bV5lC4ZfFy3H+sFewSInOsfGAKoje6kV0mOb3MPBWF1e1gjQs6lSav?=
 =?us-ascii?Q?yHE3SXRlpshLkUeP49uLCDJfOv+wO+T8BblptRxdQq/hi+Fj0EzbnyQlA1HS?=
 =?us-ascii?Q?zH/l4QGocXnsBxU4pUh2YxkL6heb2GqpcUgbch3s671eFUieltIjoMewYKIM?=
 =?us-ascii?Q?oXRTqygKDA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce29920c-5b29-4abe-145f-08dea1faaa8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 12:11:50.7125 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mtu+9BiISgQR2U/BMXK5K1id4LC8WnU+agGtTpx2nqIAtmKjjtQomaV7GjcWKxsdx1WtdCw82u0kU61h/iifNupzp4YQc1sVP4P5f/c3dBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12956
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

Hi Myeonghun Pak,

Thanks for the patch.

> -----Original Message-----
> From: Myeonghun Pak <mhun512@gmail.com>
> Sent: 24 April 2026 12:59
> Subject: [PATCH] drm/renesas: rz-du: Fix MIPI DSI host leak on probe fail=
ure
>=20
> rzg2l_mipi_dsi_probe() registers the MIPI DSI host before allocating the =
DCS buffer. If
> dma_alloc_coherent() fails, probe returns -ENOMEM directly and leaves the=
 host registered.
>=20
> The remove callback unregisters the host, but remove is only called after=
 a successful probe. Add a
> local unwind path that unregisters the host before disabling runtime PM o=
n the DCS buffer allocation
> failure path.


A similar patch [1] already posted

[1] https://lore.kernel.org/linux-renesas-soc/TY3PR01MB113464115454EB533EE6=
70E81862B2@TY3PR01MB11346.jpnprd01.prod.outlook.com/T/#m3c56399b78f8661ff2b=
5bfc2f2d8a1364a9ebf7d

Cheers,
Biju

>=20
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu=
/drm/renesas/rz-
> du/rzg2l_mipi_dsi.c
> index 29f2b7d24f..309fae1459 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> @@ -1476,14 +1476,19 @@ static int rzg2l_mipi_dsi_probe(struct platform_d=
evice *pdev)
>=20
>  	dsi->dcs_buf_virt =3D dma_alloc_coherent(dsi->host.dev, RZG2L_DCS_BUF_S=
IZE,
>  					       &dsi->dcs_buf_phys, GFP_KERNEL);
> -	if (!dsi->dcs_buf_virt)
> -		return -ENOMEM;
> +	if (!dsi->dcs_buf_virt) {
> +		ret =3D -ENOMEM;
> +		goto err_host_unregister;
> +	}
>=20
>  	return 0;
>=20
>  err_phy:
>  	dsi->info->dphy_exit(dsi);
>  	pm_runtime_put(dsi->dev);
> +	goto err_pm_disable;
> +err_host_unregister:
> +	mipi_dsi_host_unregister(&dsi->host);
>  err_pm_disable:
>  	pm_runtime_disable(dsi->dev);
>  	return ret;
> --
