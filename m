Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC4ECA5FA5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 07:30:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB77710F59D;
	Thu,  1 Oct 2026 07:30:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="uU9FkWao";
	dkim-atps=neutral
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010065.outbound.protection.outlook.com [52.101.228.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 172D410F59D
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 07:30:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjGaeIOlIiLMf1XDVLGro7w+KHUv91aRCP4qpgGM5rwT+Z3L4B6xgggrx3e7MJlrunvgS6krvQGdIsa4GqtSvHKPebWbKUzPkZ/RVUHE2Y9fIBTWmhgYKsvPKGFXgsAj7uL4POxmXxyXqysZWfE01MOSh1kIRfkuLd4B/8L/VKyAw+JrZPH02Ke6kFm5GFMqMyeSvNvn5EF4AC50vE3lzXaxjFv4K1kEfKZjgvgQxfOy5fS6GgUu8bl/DR1mkr/M49LIqSKJZVw6wn70+ruBn/zCiLouIdMrplDHRVZfR8XlM0YhwwC0cZYl/eCWBsfygFSS0YSTzkF04VBJp2puaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWtJ+JFqi2LuY0U56ScHSdJM1M9q0I8CaYBwko3CgTo=;
 b=HCJmcE+pv8LAY9srvSE0B+nlyRsOCkG1zpBWjyR/cdsonSHtLv6gePw/ZxXphzbrn+nHcScddckSESbwdFLZ929DRC9cx4HMlvP061gTpW+DJyZ+ziMXSACmp7dUA5/vVVzITWwteNBZsLWrvkdqR6hwZnfcxd91mG2GyhJ25IlGEbik+qsNQ3ysb+P56jb9ztxH2BB9Y4Ob8NHG//dZ2uMLmNs6PqQnA/AA4MQUtu8KSjhGO0ADeBc921kaiXPAKFhKLq8nx9QPQKf9sO3sHH4Oh4jFqjTqy9GGUc1Yo/uTTEIt3heKqr/wKCg7i85FpED+fNgK2GzTu6sChSUD9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWtJ+JFqi2LuY0U56ScHSdJM1M9q0I8CaYBwko3CgTo=;
 b=uU9FkWaoHMX118F4qaBdNSWfpR1AKsqP0xvHVP1jxFK1CwcHNySrrc4Is2IokYTrXMMIr4jrwn0GgVhbPsn36xOlGC5NZytvREB60LEvwKdxCzWpowKcl9xnt3DK0VeqHFUMYHOeKxAy8EFUdsUWAC6gRobZ74/EQwqwO+3NyAc=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB11976.jpnprd01.prod.outlook.com (2603:1096:604:236::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 07:30:05 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 07:29:59 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "biju.das.au" <biju.das.au@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Geert Uytterhoeven
 <geert+renesas@glider.be>, "magnus.damm" <magnus.damm@gmail.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, "biju.das.au"
 <biju.das.au@gmail.com>, Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: RE: [PATCH v4 6/9] drm: renesas: rz-du: Add RZ/G3L (R9A08G046) DU
 support
Thread-Topic: [PATCH v4 6/9] drm: renesas: rz-du: Add RZ/G3L (R9A08G046) DU
 support
Thread-Index: AQHdUOBA9aXOKCp0XES08Uub8ggX7LboSsYA
Date: Thu, 1 Oct 2026 07:29:58 +0000
Message-ID: <TY3PR01MB113461A1CE4CD7D34D2534FAA868A2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260930133257.23210-1-biju.das.jz@bp.renesas.com>
 <20260930133257.23210-7-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260930133257.23210-7-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB11976:EE_
x-ms-office365-filtering-correlation-id: 41aa28a0-4837-4403-bd09-08df1f8dcc5b
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|5023799004|56012099006|4143699003|3023799007|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: I/KK8epqzrVlcobjZ0tNOiFfcQKfkv9tHw++Qtc5+EwEZhJWaeZ64k0dDRNLnFBCexNbEGAmbPavt6NBazcoILnr80h/IoTukb+QFlmwxU+tXSdKy0z+/dCgF6wEcZaxvd2BKfCJ1heC/UTGqr9Om0m5BjAh2pCAER55JIVtl1O+dEUvgrevRqBTKuQwkaAVQD50BXg9Ch20DiBkvuIzlJfjCATUvLzEVKG2TnLN1TSqs5+jbqN13j6VffLXj33ROS2280Zhw47ni2j6jCC1WZzQOC9x8dSbFQF5RkyjIrmIxwciE04KNYxvugkY25DYjYI0CT2cA8lCBd5+j1nrDYXIyq7mN+YZbXLZIEF0wIcHWzo3wpoyYYVyatWEyzDdy2IEtayXuYuN6cbfb4XiqovwOCcqAcFMS3Pu8+B+sXvDpKX9pU7DP2QBkvTZbDCNtvZXDNzaETJfH6SpPjBQhdOxIVuBNYCTQo+SaNp1AOKcY3kx5tHvHusc/bV4QqPnOeNBrKZDtpzp4Ym6ghSUeVb8cXDHRQOYk/XROwB0Tlz0Kw+AFfW1QlBHMh3Ul2f1AcdKLfImbIWB0+BXoZzYtZk17WqF53QbxsriJcPan09gfvYG+eRrrW42qFNY6mdXaZXL/5MCdAH78QYMMzHNhaKuEd/PhdUFhfd+i9lAVcVetag7FIA5J1FtJ5KUT05a3qsjd+UDMFBJ3FYsAJ8J1OX2e2uzCsVTlcw1ltrFAUw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(5023799004)(56012099006)(4143699003)(3023799007)(11063799006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uXD7xopCnU3FMHvWp+S/yV0gv5uuvVDWpl1D6+gTsowP0hPbtibsdH5HwdV6?=
 =?us-ascii?Q?pNOAfx5i5NdpWPrgufsVrxUvyMUKdL6vdQq7nt6ZK4OsTAQDvHKLR7jb+NAY?=
 =?us-ascii?Q?YxeCVoFxC/IvpsnvJBub43lP/XCJkEjbua6iFxWyIM/ncQ7F8JW3MLwI+JVj?=
 =?us-ascii?Q?FlJr2mGzVhfV+VzTcA+6AqTAAWHZhksD31QtJHNOFYMj2alLz7OXwEZbyowL?=
 =?us-ascii?Q?smhiS2d7On4pDUgxFSEbJbcXVOHVA9MEBJzxwQo+UhiZkZGJKUkidlmf0XWX?=
 =?us-ascii?Q?ee8A44sdN4eSudnrL9P0yBFbTajsBaDGbNaSp+QvAina6T1o+xby6GGNl0Gi?=
 =?us-ascii?Q?07NUIQYWVwRBNKreUxl0dpzWhp38pzX+s25zH5h4G/eRZFubz37NndBuG6Xh?=
 =?us-ascii?Q?erM3WYGRboZs/rcyFGc5Auqh7d9t1vU0dFoOB9cBtqvB1kPAmfs60SRLs8ly?=
 =?us-ascii?Q?ZQwE5Shh0FiAao8B6wkFkjUNm/2SoJOf1HrMHb/0Qy6BuzloKGPPnD5hM1lh?=
 =?us-ascii?Q?Lvm841Qzn9rNYbY/hNsgbjQLV3C81eJlNhXIAoCBveZaAduz0iRl1J2DrRE0?=
 =?us-ascii?Q?M7hhhzVhk7Z0Dh3O86jZra7HMcqk9bCfsw5MTwe3EsHvrUPAH1+t0NMFYqNr?=
 =?us-ascii?Q?PmQXBErNJha+wQwqjnc9LTpFC2Qi/n07ibLRAS5tbVIcdnq3R9H0iWI/7I5h?=
 =?us-ascii?Q?hTA7p+YbgRnODkyXHbUrWIWy2ZIv0yJZzWdlHk5eRiyT4kllSV6WTZQhTztu?=
 =?us-ascii?Q?3lJGtbiKb7oWabwh4dFPL0DCbdh7WyGQoJTD3LyhsHsP9LsPNQKF/oRqBvod?=
 =?us-ascii?Q?T/ZFug/7LQtH/DC72eY8SP89gIu7co4Ezj2J70m3P7JhN61RJut5s06ZDhS3?=
 =?us-ascii?Q?b13Xt6B1nt5TjXoh6VvkNljWHvrlddnvxCmIjO7ccH4Z9rcUT49wgKWGTW5+?=
 =?us-ascii?Q?jKwCMuUlKd2Yukt24X/D7L25m9SpFUuhJd7EJ1A6vkbqKm8KCeP4VioGgqbP?=
 =?us-ascii?Q?IJkReXluqIHg69XBFm4e/iEssXpap9a2KD+sbM9625PhJwiFCwFn8ObQvVnk?=
 =?us-ascii?Q?bbwv7x6sMpJBnCLYUTSO4Pr58dfrcmbkzf6gHTKomrJ6lY4uL9GGwrrIasw8?=
 =?us-ascii?Q?zPgtwWOmmghGIPyWrGLHNx3S02t3ihckcT4J05REwM8hpbrPZF/OVoMpN/oS?=
 =?us-ascii?Q?DktePFNFrEEDwg205SYsDcMojwesV/55nZT27CSXqkTgRWOCtrK1aPUsnVdP?=
 =?us-ascii?Q?Yr8F/qUDb4g0KctDNQ4cNdSjIQW0+ViBIsoy73nCTL79qzV7ZtO5D2ZICagG?=
 =?us-ascii?Q?BJt+7+S60YABWrE2XUDCG//sNCo8xKaFHV2dCVM2O3usrzokAju9xoynKX4K?=
 =?us-ascii?Q?csBeO6Vh0KkwVIH4Vz4I72C54LGAn/Iid06jJp5HPxqUc0HAecuEKyXYCb7R?=
 =?us-ascii?Q?QA8c8VS1k3ymn3GylOmI/q/F2oq9FUqqAeWqLNOCqeg9rTCrMo/aBnFuWBkX?=
 =?us-ascii?Q?cL3KPrynZVWPCVaEsr6zC/BOjV+lkggl4FsfrTS0APVLb3ngyNsjefzgg6Uj?=
 =?us-ascii?Q?7YzESQQ8M/BDUtRv2eAON/GfSdsQSJvmsohBw7g+G1PN6OgB7oTCLjeTzb/H?=
 =?us-ascii?Q?j2FYKh1+hMsDHH5f/fl5ELqXBAgkxKB2stIHKOy+uMAoAKKU+yBE7f+JW6hs?=
 =?us-ascii?Q?fSZKABICH15b9plmZO9C8j79+l+Z6IT4AQZ3NIfV2JvWPGPqAGh1AtTWLxlv?=
 =?us-ascii?Q?XlQ59GnA4A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41aa28a0-4837-4403-bd09-08df1f8dcc5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 07:29:58.9152 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q+DYXk8xCoIoZPkP8DHYsxwD8UOYQpE+nZy5Cd8CxYLzJpk6NTjFVlXUrzSsu5xBn7c1Q6SSVlzhq4UY40DPDn97UM7ufnDuNr+jihv0ia8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11976
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

Hi All,

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 30 September 2026 14:33
> Subject: [PATCH v4 6/9] drm: renesas: rz-du: Add RZ/G3L (R9A08G046) DU su=
pport
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Add Display Unit support for the Renesas RZ/G3L SoC (R9A08G046). It is si=
milar to the one found on
> RZ/G2L, but has LVDS support.
>=20
> Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v3->v4:
>  * Updated the mode_clock_min from 5440->5400 kHz.

I got a response from hardware team and this value
is 5440 kHz. Hardware team will update the section
1.1.3.9 Display Interfaces with 5.44 MHz.

Cheers,
Biju

>  * Collected tag.
> v2->v3:
>  * Set duty cycle handling in DU encoder
>  * Added min/max frequencies for DPI.
> v1->v2:
>  * Dropped the macro RZG2L_DU_FEATURE_SMUX2_DSI_CLK and RZG2L_DU_MAX_LVDS=
.
>  * Dropped the variable rcdu from struct rzg2l_du_encoder.
>  * Dropped the variable lvds from struct rzg2l_du_device.
> ---
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  | 24 ++++++++++++++++++-  =
drivers/gpu/drm/renesas/rz-
> du/rzg2l_du_drv.h  |  3 ++-  .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.c=
  | 24 +++++++++++++++++++
>  3 files changed, 49 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/d=
rm/renesas/rz-du/rzg2l_du_drv.c
> index 3d13f61d3c97..adec94a55407 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> @@ -55,6 +55,26 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a0=
7g044_info =3D {
>  	.mode_clock_max =3D 83500,
>  };
>=20
> +static const struct rzg2l_du_device_info rzg2l_du_r9a08g046_info =3D {
> +	.channels_mask =3D BIT(0),
> +	.routes =3D {
> +		[RZG2L_DU_OUTPUT_DSI0] =3D {
> +			.possible_outputs =3D BIT(0),
> +			.port =3D 0,
> +		},
> +		[RZG2L_DU_OUTPUT_DPAD0] =3D {
> +			.possible_outputs =3D BIT(0),
> +			.port =3D 1,
> +		},
> +		[RZG2L_DU_OUTPUT_LVDS0] =3D {
> +			.possible_outputs =3D BIT(0),
> +			.port =3D 2,
> +		},
> +	},
> +	.mode_clock_min =3D 5400,
> +	.mode_clock_max =3D 87000,
> +};
> +
>  static const struct rzg2l_du_device_info rzg2l_du_r9a09g057_info =3D {
>  	.channels_mask =3D BIT(0),
>  	.routes =3D {
> @@ -81,6 +101,7 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a0=
9g077_info =3D {  static const
> struct of_device_id rzg2l_du_of_table[] =3D {
>  	{ .compatible =3D "renesas,r9a07g043u-du", .data =3D &rzg2l_du_r9a07g04=
3u_info },
>  	{ .compatible =3D "renesas,r9a07g044-du", .data =3D &rzg2l_du_r9a07g044=
_info },
> +	{ .compatible =3D "renesas,r9a08g046-du", .data =3D
> +&rzg2l_du_r9a08g046_info },
>  	{ .compatible =3D "renesas,r9a09g057-du", .data =3D &rzg2l_du_r9a09g057=
_info },
>  	{ .compatible =3D "renesas,r9a09g077-du", .data =3D &rzg2l_du_r9a09g077=
_info },
>  	{ /* sentinel */ }
> @@ -92,7 +113,8 @@ const char *rzg2l_du_output_name(enum rzg2l_du_output =
output)  {
>  	static const char * const names[] =3D {
>  		[RZG2L_DU_OUTPUT_DSI0] =3D "DSI0",
> -		[RZG2L_DU_OUTPUT_DPAD0] =3D "DPAD0"
> +		[RZG2L_DU_OUTPUT_DPAD0] =3D "DPAD0",
> +		[RZG2L_DU_OUTPUT_LVDS0] =3D "LVDS0"
>  	};
>=20
>  	if (output >=3D ARRAY_SIZE(names))
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu/d=
rm/renesas/rz-du/rzg2l_du_drv.h
> index baf076d69cda..e9626ef37cde 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> @@ -25,6 +25,7 @@ struct drm_property;
>  enum rzg2l_du_output {
>  	RZG2L_DU_OUTPUT_DSI0,
>  	RZG2L_DU_OUTPUT_DPAD0,
> +	RZG2L_DU_OUTPUT_LVDS0,
>  	RZG2L_DU_OUTPUT_MAX,
>  };
>=20
> @@ -33,7 +34,7 @@ enum rzg2l_du_output {
>   * @possible_outputs: bitmask of possible outputs
>   * @port: device tree port number corresponding to this output route
>   *
> - * The DU has 2 possible outputs (DPAD0, DSI0). Output routing data
> + * The DU has 3 possible outputs (DPAD0, DSI0, LVDS0). Output routing
> + data
>   * specify the valid SoC outputs, which CRTC can drive the output, and t=
he type
>   * of in-SoC encoder for the output.
>   */
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c b/drivers/g=
pu/drm/renesas/rz-
> du/rzg2l_du_encoder.c
> index 3d0999e4fcfd..a1b48973aa8e 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
> @@ -7,6 +7,7 @@
>   * Based on rcar_du_encoder.c
>   */
>=20
> +#include <linux/clk.h>
>  #include <linux/export.h>
>  #include <linux/of.h>
>=20
> @@ -15,6 +16,7 @@
>  #include <drm/drm_bridge_connector.h>
>  #include <drm/drm_panel.h>
>=20
> +#include "rzg2l_du_crtc.h"
>  #include "rzg2l_du_drv.h"
>  #include "rzg2l_du_encoder.h"
>=20
> @@ -64,8 +66,30 @@ rzg2l_du_encoder_mode_valid(struct drm_encoder *encode=
r,
>  	return MODE_OK;
>  }
>=20
> +static void rzg2l_du_encoder_atomic_mode_set(struct drm_encoder *encoder=
,
> +					     struct drm_crtc_state *crtc_state,
> +					     struct drm_connector_state *conn_state) {
> +	struct rzg2l_du_encoder *renc =3D to_rzg2l_encoder(encoder);
> +	struct rzg2l_du_crtc *rcrtc =3D to_rzg2l_crtc(crtc_state->crtc);
> +	struct clk *clk_parent;
> +
> +	clk_parent =3D clk_get_parent(rcrtc->rzg2l_clocks.dclk);
> +
> +	/*
> +	 * Request appropriate duty cycle
> +	 * - LVDS path has DUTY H/L=3D4/3, 4/7 duty cycle.
> +	 * - DSI/RGB path has symmetric 50% duty cycle.
> +	 */
> +	if (renc->output =3D=3D RZG2L_DU_OUTPUT_LVDS0)
> +		clk_set_duty_cycle(clk_parent, 4, 7);
> +	else
> +		clk_set_duty_cycle(clk_parent, 1, 2); }
> +
>  static const struct drm_encoder_helper_funcs rzg2l_du_encoder_helper_fun=
cs =3D {
>  	.mode_valid =3D rzg2l_du_encoder_mode_valid,
> +	.atomic_mode_set =3D rzg2l_du_encoder_atomic_mode_set,
>  };
>=20
>  int rzg2l_du_encoder_init(struct rzg2l_du_device  *rcdu,
> --
> 2.43.0

