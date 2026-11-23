Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C102606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=v0vWeWxZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 807D310E81F;
	Mon, 23 Nov 2026 16:37:21 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010067.outbound.protection.outlook.com [52.101.228.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BBBC10E81F
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:37:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWAE1NoZZktUYD+pCxgUHN6ZQ9O5duNlkYEqNdmR5/E4mW8DRVkmznW0o2SIva9vrCewNeBQi6eVZjx9dSfBMXLP8zumpq9Jk3KA3b2gZZPUo25qLQIxUn1Ng4I02rwlSdTWm6WHCnujxUfpLyjOYeH5dwGezG3HjkuQ4oXzN1RRMtS+ZYbii41YEg3hxBTC8p+HRTuWxCJl2jBddmg7QuzixkO0Tj14AqdgyQ0qQKAuwRohV95fMd8v0RY3zo1CSEqPnHy9XKRzJ40I2ZKMEFFa4sMRN4bUHOTDcarn3bvEp/spMWr3q54HTJa2aKH3GWWXaTJwNKEGErR8+/vKUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwZ5wuL7aU6V1maTKCO8aoXsbLF/1B4ztV4vdP6tg8M=;
 b=JyFw7EqSgWKMMmKH9DNTc0cbAgoznnw1QSA0mtYgjp6wbmLkXAcbJQdgeqBTbGXwUyNQMQ8Br8zAkLm+XTli1SGZ8XHKZAK8ENtB+4pHZh/TzeKWP2v8hLzd+ijXq/uRF+MiFokJwHCW2uyUIwyc2ghkJ7lNqcYB5ed35ohXjpwOoxLWamVMgeOwE267J4tEIcPPTmzDxDmhqWb4/gewvQBvvnCxPYFyngDyBuXeDBNzlNf42sAwWJ+gaYbhfUCuceO+QJEhyNIwiVuejS7uk0451gRlqLjpjSXsTXFLGBz4zJj/nDCMah5rTVHGUqGaUc7+nuih/EIjQ3txjSgbdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwZ5wuL7aU6V1maTKCO8aoXsbLF/1B4ztV4vdP6tg8M=;
 b=v0vWeWxZN8CPdKoEuLbUr2W4LDMMMF7EkZVMGXe02MzzaOLY6zffuw9dAHcpXkEEd7wMjicy4tbHweJ2wXEyXsLt95VgjxUM3iLp+q2iy/CtkzpFAnEt8KHejCXuZulIT6a/Bnooe8HI6fWgHdW2BD/oHtKkgaWQlNqcPPzZldI=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by OS7PR01MB14820.jpnprd01.prod.outlook.com (2603:1096:604:398::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 16:37:11 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 16:37:11 +0000
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
Subject: RE: [PATCH v10 06/12] drm: renesas: rz-du: Make the CRTC index
 relative to the DRM device
Thread-Topic: [PATCH v10 06/12] drm: renesas: rz-du: Make the CRTC index
 relative to the DRM device
Thread-Index: AQHdc2l/CzWzTm+fYkKfdsqmbKSfkrc76m3w
Date: Mon, 23 Nov 2026 16:37:11 +0000
Message-ID: <TYYPR01MB6603CEBF9A3145D374663CEC86452@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <04be21c034849955186adc9af9f6e70c9f740be0.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <04be21c034849955186adc9af9f6e70c9f740be0.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|OS7PR01MB14820:EE_
x-ms-office365-filtering-correlation-id: 2ceaa67b-62b1-45aa-299e-08df498005cb
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|38070700021|10067099003|261009223027099003|4143699003|56012099006|11063799006|5023799004|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261026140227099003|261028144727099003|261102123227099003|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: J5viTtG8JCHblJIJUwJdfOSmGB9l+W7vVKvYynzfr9ISPOXK/Goft3Pf8U77SqY6jVHSDG4wXEWwJEiqrWKmDd9/i+GXEWHi4gCo7g889gcvx9/kGljH2nuT/5OXw3mQntzSOzHkAcyEjRfkk+VljWBdo6gQBp6R0eYowC+NVWiVi3U2ch+58Dlb/MAjzn02NSBivPnrLISXF9Of6fmFaYYr82rmbp/Z33D5cH/M+iLtERQTa4Kwd9HLKfJp7i+N8xvi9A7V9BFZnOdFyK9rh+Rc816lCSK7p0clfRMMmTsr1ksX/+qH2p5bUZDK53B3UXVO22bKiEujuwY+Jj4K2ZukztKyAJ22kCz5vz9B6a+nHA660sf/u1ZQieBCAN97CzklLUA5gjj/LI03PSJCE18DMtFmy1medF25VgFW/hC2jsu1brEN2QITyso6/gOdbZ0jQmLurjjLgXXiLVQmN/nVGPNPAYkiYvANcRPkleK1eJPxqEYI0HCV/QVWl0pmcEKRGbE/RjRyMuWwfiQZ/GLYdEyhfDl5X0xNubdY0WyxcRhl5PEk8RGQQESCTpy9AbfrA+kSbym8x1nT2dMY4YrsT+XNvcyKBQ9wT11hlTm2Yn80C3cUz1KKEykJUNqcrrrEtN+0DIYITiNgz86XHgCTztkW2aECE6kVeBgdD3oazXPD6hbNcMKvcWSlJkTtay7lqh21sTdTQqsRkH1rnaE35FHImRIMui7z2MJWTuA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYYPR01MB6603.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(261009223027099003)(4143699003)(56012099006)(11063799006)(5023799004)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261026140227099003)(261028144727099003)(261102123227099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?esHnyG0eG2m8zTXq+VqHJYO0rH9MB2LWA0WnNfbdSGyb+1He9iZYy9cVyXXP?=
 =?us-ascii?Q?z6umr3/xYcvqECAFYgaOsjaNdisuP4MW49gejXP7pI7rJEXxiJjtUaLMB/F6?=
 =?us-ascii?Q?k46ql9HyYyR0AlDkv2neWeM4ixnYK61Qq3vDgM+mvC11Lo/oYmBFgptLBq1X?=
 =?us-ascii?Q?puVasDwHNgLv2oGv30R6iYuA7j7bat4Jqcv2vKW7QZQq2RPtzlLS+svRCZQB?=
 =?us-ascii?Q?tO65iztn4dE9GZrT8wnyn65PVpT5IT4mGvmGwebTiFC8r0NzCLCN9wRC8FcV?=
 =?us-ascii?Q?73HCV5xPV63BRofcrGvktUY6u9K9bW5P9iJfYf3TfDaVspTgcwCSWdoEP8+S?=
 =?us-ascii?Q?JlLrWJb4/6wUGFVjx1/4AeHJ4rzx4JhDB9Kh3Fkyl2OVFbuLEcJQz0Qspqgd?=
 =?us-ascii?Q?urixsZDblPiibpf41xQnwGw0yFFfOHq+L0VJ85Gbq412G1P6YsyzAKQwfREK?=
 =?us-ascii?Q?Fu8qnDHCvR7ZHOpE8fnYpD3EvGZydx3wWqt/VwI56EA/JiFjjYq1zGsy5WRe?=
 =?us-ascii?Q?xv0GHqmgx9pT9kLIYMfD5ZMIiyki02HDVOphtRNM2/bT4k6Rh29OKxL6Ew6N?=
 =?us-ascii?Q?RBYdbybLAsSPkgwHGJE7p2fuI/HAk88cbmiItJrVGmFfzoUlMWwdX4tfYeQD?=
 =?us-ascii?Q?iyiT2lCWc901s4G2BSZYeFJkctAhF1JJBMd7iZaMXt5Il0DMwhjbOU19LOlK?=
 =?us-ascii?Q?6Qtv0MQe4f/crHgcks+AgYF2QpjAqeB5Ss2EH8C0av+0IezQUBuHWq+wi9f0?=
 =?us-ascii?Q?TkRcdVqABrURM+RGf4JFLkc2dEND/EF310XCfDvDd6aAYTBJ6sGNtF5IOcIF?=
 =?us-ascii?Q?//o3pWjDaqN5mtrWkxrxyLk2T3zMMjkMaIBsoUbYU2krNjT8hcNyncOqeZnj?=
 =?us-ascii?Q?HqocMmhNE9bGLXQRDLwmT0j2fVBwlanz8kfFT8FtVJTbIbEYV4U0NEx+MYLE?=
 =?us-ascii?Q?mKaJ7jxLm7IKhmVk3zASZFe35PZtdLoa4tx0mPMNYLmtToKd5nZFJ0JjYyR/?=
 =?us-ascii?Q?hItZuUywn2Nl9c0zpD8hVFl/5yDuLJDlVT1Nbb3IYjim+dJAdbWno4bwtdCT?=
 =?us-ascii?Q?qyOAMZorCEY7r7ltUN8Agl0dUDMg2KPj9UxWQZBjM+rvYxOmSubIIvFf6xzn?=
 =?us-ascii?Q?k+/PxAYD0Wf9OLk2oGBmZXqjg90nIMXhjLke15HL8yX34ilzomYD3VVInEl6?=
 =?us-ascii?Q?MLoChhcn2mLsVSXXsDYCbRDnBeVxlNYdTleE5vMH+vJeyBls2G2Sf5EgE0iT?=
 =?us-ascii?Q?dvivCDHSqxFi8nsITAlGWA2VvcgbDFTgXi4hlgr9SEF27BwQrQ23WVx3lrPg?=
 =?us-ascii?Q?Mrz7yrUGusmSlA1cJp7ba8aZloyrR3ibjXT2SZNWOiTP2yP3mthAQa7Gcjp/?=
 =?us-ascii?Q?2Y4Dlbu7mkCKHtPsPa3kZkmiz6t+9JFphOrH9kUZJaUN84GQgMs9l53yCJyy?=
 =?us-ascii?Q?tPSEzEpVSj9BxazEvspMnLfBH7Qfg36VFwkEyuyDXfLdI5MJ8v/5O2lub94R?=
 =?us-ascii?Q?v4pyVe+YfZevCRlNsnz3+o4Aike2XVu42ZXML070ejiIfPgOJlk7mtIkRnu9?=
 =?us-ascii?Q?sMFFKwIfffFPacTySbpzUk3p4iO6y4ss5qvgN2kYujmMUay2X8io1B/BJ98d?=
 =?us-ascii?Q?75X3thC1/YscucW4V5mv/2C3/Dcl8EB916qlLM9KOVU/hLp9JGY/SWWgV74T?=
 =?us-ascii?Q?A6XCLhJargr8PmUSjgt3vU3J2xRGUFVuzVSKX3jk9pRpM9o4c8l/6GGZeiK6?=
 =?us-ascii?Q?yG8//fNQvg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6603.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ceaa67b-62b1-45aa-299e-08df498005cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 16:37:11.1370 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rBzwPr/OMOIZqa92E4BPpRyf/2sAwYl4CkF8uwGVJ5nWJuD0FzdYmDbbnDeorGCURQox6uWX9UhQsR5g7ySZqOMd2uxHGM2srPK5BotjEpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14820
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
> Subject: [PATCH v10 06/12] drm: renesas: rz-du: Make the CRTC index relat=
ive to the DRM device
>=20
> The possible_crtcs masks of planes and encoders hold CRTC indices within =
the DRM device, but
> rzg2l_du_vsps_init() and
> rzg2l_du_modeset_init_finish() build them from the index of the CRTC with=
in the DU instance. The two
> only match while an instance owns the whole DRM device.
>=20
> In preparation for supporting RZ/G3E, where two instances share one, reco=
rd in each instance the index
> of its first CRTC and offset the masks by it. The index is zero for insta=
nces that own their DRM
> device, so their masks are unchanged.
>=20
> No functional change intended.
>=20
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
> v9->v10:
>  - No changes.
>=20
> v8->v9:
>  - New patch.
>=20
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h | 1 +  drivers/gpu/drm/rene=
sas/rz-du/rzg2l_du_kms.c | 4
> ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu/d=
rm/renesas/rz-
> du/rzg2l_du_drv.h
> index 47ceaf892339..2952c9d7348b 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> @@ -70,6 +70,7 @@ struct rzg2l_du_device {
>  	void __iomem *mmio;
>=20
>  	struct drm_device *ddev;
> +	unsigned int index;
>=20
>  	struct rzg2l_du_crtc crtcs[RZG2L_DU_MAX_CRTCS];
>  	unsigned int num_crtcs;
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c b/drivers/gpu/d=
rm/renesas/rz-
> du/rzg2l_du_kms.c
> index 73cb3199f90f..456b29538db9 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
> @@ -367,7 +367,7 @@ static int rzg2l_du_vsps_init(struct rzg2l_du_device =
*rcdu)
>  		else
>  			vsps[vsps_count++].np =3D args.np;
>=20
> -		vsps[j].crtcs_mask |=3D BIT(i);
> +		vsps[j].crtcs_mask |=3D BIT(rcdu->index + i);
>=20
>  		/*
>  		 * Store the VSP pointer and pipe index in the CRTC. If the @@ -480,7 =
+480,7 @@ int
> rzg2l_du_modeset_init_finish(struct drm_device *dev)
>  		const struct rzg2l_du_output_routing *route =3D
>  			&renc->dev->info->routes[renc->output];
>=20
> -		encoder->possible_crtcs =3D route->possible_outputs;
> +		encoder->possible_crtcs =3D route->possible_outputs <<
> +renc->dev->index;

If you define struct rzg2l_du_device *rcdu =3D renc->rcdu; in patch#5

encoder->possible_crtcs =3D route->possible_outputs << rcdu->index;

Cheers,
Biju


>  		encoder->possible_clones =3D (1 << num_encoders) - 1;
>  	}
>=20
> --
> 2.54.0

