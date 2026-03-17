Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98AA6FD8765
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 13:03:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1ED210E421;
	Tue, 17 Mar 2026 13:03:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="KyngZpJW";
	dkim-atps=neutral
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011033.outbound.protection.outlook.com [52.101.125.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39AE610E421
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 13:03:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmpjXo+Fpz0JHtzxZE1uNwETJXZrf3MWXrsBvFQZ13LNOmAbg2tr9qdSSvTw/PrxBmjBnbXcCec1u0qh7htBCqIZlqkyoqx/R20Q7ExEGM7eKmLalGYn9HhaWZHzjden3a0nNAONlgmD/cADYhrC+qMw3VYTtZzIF9MutVOeDiVgQFVKaO0uw5p46Nsy1ERqwbkdKJuXIIQ23DlMP3RUefxcUGfTh9y6cHLhTGrxe2oIam9qb0/1rbG2qkGTDn9CKe8qBEY08qGQ+/zlJt3biwCza464XJIYVfYWEtmaRFO83rYEfzD7m7x5q/Kxd9bwiEl20VeRcpZRp0+5E8+G8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwKB4CZwNW/AKuQNH5BFvrBUehY6XlnHkzBObKaSxRA=;
 b=o/UItC+Y2oJ2K2yQsnNhwJFuutRJwvOXrdEy+DeJ1dWj1UXD9w7zfIxE9tSoBgBHHjSk4A1M18NQdxx4CBRA5LEcdtPbARUw/o8cYRtfH7LZtbjYimXY3dKBP7XDR3vQWKud5Zuiqc0MPhS0NcwnSoAv535D6/4wqoN/pd1CV0L8qE8FtsNZESez5KuJHKT4EhZoz3dY9dVJMr5hpfVMgOYkHwolZX8ocM6zw1E26Sh4LFc/Bi+pTwCkpLUUPaOk3F3Q6WmrcEoFFVKxVSDrF23pSJrTmfQqGLT1RpyvcDs9WxgdaNyPzLRMdL3v0tkDQQ14ZcJpuHVKWy7jyCMAfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwKB4CZwNW/AKuQNH5BFvrBUehY6XlnHkzBObKaSxRA=;
 b=KyngZpJWY2rTs/robGC/mLYXy/4MibM4uBks+wNafnBz/Paj2t0kCMsi47TTZEZgOG+bOaDLH2sMGKvaftxubSV0rVRC/810k4BhoSloSghFCK3G4orVmak++BxY9MsRpdOfgtFYB/fDcy6KU5J0tLicr1ElXnrhUC7o16OJfsw=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY6PR01MB17298.jpnprd01.prod.outlook.com (2603:1096:405:35b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 13:03:19 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 13:03:19 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, Tommaso Merciai
 <tomm.merciai@gmail.com>, geert <geert@linux-m68k.org>, laurent.pinchart
 <laurent.pinchart@ideasonboard.com>
CC: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 magnus.damm <magnus.damm@gmail.com>, Laurent Pinchart
 <laurent.pinchart+renesas@ideasonboard.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH v5 12/20] drm: renesas: rz-du: mipi_dsi: Add
 RZ_MIPI_DSI_FEATURE_GPO0R feature
Thread-Topic: [PATCH v5 12/20] drm: renesas: rz-du: mipi_dsi: Add
 RZ_MIPI_DSI_FEATURE_GPO0R feature
Thread-Index: AQHcnQX+FR544OmisE65x0Wi4LugKbWy4jAw
Date: Tue, 17 Mar 2026 13:03:19 +0000
Message-ID: <TY3PR01MB113466CEA27DC0486501E89C38641A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <cover.1770996493.git.tommaso.merciai.xr@bp.renesas.com>
 <d1f47b9719edab4e85a8971020c7d7f51fff39e3.1770996493.git.tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <d1f47b9719edab4e85a8971020c7d7f51fff39e3.1770996493.git.tommaso.merciai.xr@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY6PR01MB17298:EE_
x-ms-office365-filtering-correlation-id: a3d752f8-8000-4337-bfc2-08de84258fd7
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: WkFjBxM8/nVhH7yR2M9LeokBrF8qYGv3sY7b5A0RUj/sIQLharTZgPbe3naXlvHT7wN01f69hnPcjerMFOcIqvQ5p7RcjgVBuRgIgvCVGwAwgnF4ntvda1W30f3pmBMakQ7mqDSQ4mTpXWe5qJ3uCSkoQxxlUhdFYJyigcDzw+S9TPgGtvfjrHYDt+f4YOi7IGZg/p7OzYcQn23G9YpUm0AsgDeKfk296ZdhHLsNP6YY94ta8mWfClrh8xE81iu/mKaOkIMzk53ztYbTS4ME2al5aV3T+c/Xx1nK2gv5vOgHjZKu5T7IgrWHXx32gId73GGwMlacJtRXgpd8rd1DVU//y4JW7+KroUMS/bhzThNqnJpYxuVPbkTVaigxt1Y8kDhGQWTgEfarfjsvktMrHmTtR5vTD54+rpIL/eS3rEqR1Y/A8Ej3LsRXSh8YkGB8G1IITU5YTmHk5yKSP8begIToWAUE4E2Kpe0ZjWMSL905NSEhSjqNUodIkZww41VthPu8PCGFFqcX3pd4ebn5/FOD67S8ZyHZHhgowANBiHEElIBs9uaU9vuhzC6+K2esKfEW0iwIAQ+ni7cdDmnc9qRFbvT3hJLX75AJNjyLVimBRuXTWY4RMBTQ1DIK0tX1I2UHyv6z7UK0VMHQfywHxbPfP/QqrdnzZOUii7PRhjReCkFT/niTVRm1lbkz9OBRLDDdAkCNXbqCIaEZYY7UCSzoiyEpI5EfvFELwi4GXMqtPPuv/18jWBK/Uc1rEv8nHEMCHzCWxUj1KrpXvGHpgpMRaCtKflyt7Du7eQsAZMk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RcctffqA2GFhzUh9TlAnFgCbT5V4cxp36dVbyxdGcBTuPAs9MKyBHOAiVfJ9?=
 =?us-ascii?Q?QX49FRJe8j8CmfXxpLRSl5wVL2+dQMUaR03cljVvYm943rPzYsksIZwZ0pWr?=
 =?us-ascii?Q?hRn6C+IiNiOHAohQ0p0eRYualFBf+MXVKgRhLOujmCYoq2400wFQNLwXkzjV?=
 =?us-ascii?Q?C8TReZ9eQQp5xIw5/1ow+9rhacLHPKfzg8E5mgqrjyWI2JKdV7hHzxn+p0BQ?=
 =?us-ascii?Q?FJL2NXUH8OXtOwzvRVstnPiePG1H8lEXladDKzihD0DQvQPM9rOaxAmsuwsT?=
 =?us-ascii?Q?Pw9fc3+Und8DXn3Tf4PDXxxY9emKpXkKC/zKK4UktdvcbSnbAoDek42OS5oj?=
 =?us-ascii?Q?LBKRqRG8Pd3Y1H7PgGoW8zUr8jVZcVFA1BQ/8FVZjFgEl5VHD8mLwf6M3FFQ?=
 =?us-ascii?Q?7BFf4cbw8ULVM/doGV3RKudyFGt+eNR5Mp/9eVyusiMT1lNjmv+8fAVFWdWg?=
 =?us-ascii?Q?+KX7ifQTn1W5OxJgDA9DPNLxEtSIlfg7v7dlhO4Ul6b991EwU3xw31XXaQR0?=
 =?us-ascii?Q?tIDefQ7h2YR/NsRAqnGxlzVzGoKKuMxs+wfVHsygISCTXuG6KwQwfbbr/yQl?=
 =?us-ascii?Q?X0dogQr5xw1gz8S+/ru1D/uXN5kChP6pHlUryGFTwcpx323Og9peqz6rzOsZ?=
 =?us-ascii?Q?v0UkW7ePkOb1xcQWJliBdOiokVYQbNZex0c7LL5XXS7iCip4ofHPSON+uogO?=
 =?us-ascii?Q?iYickg3CX4cncjxW7tAoxlUSKuuJf+GucnkswTUKzm9brm2xRgfl96dtcdiH?=
 =?us-ascii?Q?qIC0MVLXH6S7L242fltHlvxdl4xtDL61ywYp2RrEoDn2XaStpS85WfefM+kk?=
 =?us-ascii?Q?e1TSKw8RAOsWVEHn6efeLEl03oDc2yWFa3p31uoDSKYhIzfm4TSoxQ6UHpId?=
 =?us-ascii?Q?uhltZ8RqKYLk373gGEtIrt9xSC4VEaseJmK+U569qL2hBvPn/fPf+iIre7qy?=
 =?us-ascii?Q?vSQ+LiXNUEGs378BYaFmhrWHqAliQz9aNORCui+EiYrF5w2s3OG+gaBsYGsz?=
 =?us-ascii?Q?0teQY570qyqWEwKrfYb2F/rPNyixOced+how92EtaLaRZTcSWsVE5MUtx3wb?=
 =?us-ascii?Q?lkWdy0MLaMJaCkQIXpaBJaLnUriXvEoRFQOUeDk4nDpIX3uXix1nogRKiD48?=
 =?us-ascii?Q?BIf4n+5Mra+kgUpfIukB5QLKEkz1COoUUej62/EFo0h6eIwT0pKC0wydL03P?=
 =?us-ascii?Q?dTJNzCskJaPFa1iXpgpAbDGm9vei52qc0jnKQTnSxU3xIm6g1oi7F2yNMVYx?=
 =?us-ascii?Q?FCG9vaVIiJJ/pEEtNHBV3MslU69ioz/wnl135AXgFeryqMYfPG4mO9PfK25k?=
 =?us-ascii?Q?UVXGkvOn1quWqR4mwGoymntCB3s0eop2i/Rz+dQtbFTHGkm6vD2zR9PEHmwJ?=
 =?us-ascii?Q?eMD6SrL95uv8xX7xHMuafjH9gWK1h/V1Vgrw1enf8F4M8VVXitGg4Zn2UdrU?=
 =?us-ascii?Q?WBnXRs/7kHjMKBHuvtrclexjxx8k7/nRjBtmWsqHBaBPPj3zLNy+OrrfwI5q?=
 =?us-ascii?Q?tPpl9fy0pD8/3SFzUmoKrMc36reJSEZ7Q6uKNV99BwKvrg19Un2GD7exbLMA?=
 =?us-ascii?Q?eiFQQIhfGRWPHXMhi2UPvDoiSvxDd2e61I9hpVa8BYr3EcKEm60GnldiFEs3?=
 =?us-ascii?Q?cbiRP5hS2W04LB+K9R3eUD3bOpalUwYwFQaU5/5Ek/LgjM7NvSm1BmLrMR8d?=
 =?us-ascii?Q?1KW3rSIFeqxNyWDrUtgPSRZ4Gs5254gaFCrCayVO14RLrtrhAMv0pyY76aSb?=
 =?us-ascii?Q?lUri3k3uYA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d752f8-8000-4337-bfc2-08de84258fd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 13:03:19.4584 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T+ePWBnoe8JS/7ryFXSmhDMMT69GBIfMbwg9x5iBIspSRh47mhEIjtHXNqfWlLWF6SkganlVphG1GRhaQi8nEkLMEh8VvBrLpK0BR5h+S8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6PR01MB17298
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

Hi Tommaso,

Thanks for the patch.

> -----Original Message-----
> From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Sent: 13 February 2026 16:28
> Subject: [PATCH v5 12/20] drm: renesas: rz-du: mipi_dsi: Add RZ_MIPI_DSI_=
FEATURE_GPO0R feature
>=20
> The MIPI DSI ip found in the RZ/G3E SoC select the video input clock base=
d on the DU instance actually
> connected using the GPO0R register.
>=20
> Add this feature to the driver using `RZ_MIPI_DSI_FEATURE_GPO0R`, update =
the code accordingly to
> manage the vclk selection with the introduction of `rzg2l_mipi_dsi_get_in=
put_port()`.
>=20
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
> v4->v5:
>  - No changes.
>=20
> v3->v4:
>  - No changes.
>=20
> v2->v3:
>  - No changes.
>=20
> v1->v2:
>  - No changes.
>=20
>  .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 63 +++++++++++++++++--
>  .../drm/renesas/rz-du/rzg2l_mipi_dsi_regs.h   |  3 +
>  2 files changed, 60 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu=
/drm/renesas/rz-
> du/rzg2l_mipi_dsi.c
> index 8ea8594afee8..35de1a964dc0 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> @@ -37,7 +37,9 @@ MODULE_IMPORT_NS("RZV2H_CPG");
>=20
>  #define RZG2L_DCS_BUF_SIZE	128 /* Maximum DCS buffer size in external me=
mory. */
>=20
> +#define RZ_MIPI_DSI_MAX_INPUT	2
>  #define RZ_MIPI_DSI_FEATURE_16BPP	BIT(0)
> +#define RZ_MIPI_DSI_FEATURE_GPO0R	BIT(1)
>=20
>  struct rzg2l_mipi_dsi;
>=20
> @@ -81,13 +83,14 @@ struct rzg2l_mipi_dsi {
>  	struct drm_bridge bridge;
>  	struct drm_bridge *next_bridge;
>=20
> -	struct clk *vclk;
> +	struct clk *vclk[RZ_MIPI_DSI_MAX_INPUT];
>  	struct clk *lpclk;
>=20
>  	enum mipi_dsi_pixel_format format;
>  	unsigned int num_data_lanes;
>  	unsigned int lanes;
>  	unsigned long mode_flags;
> +	u8 vclk_idx;
>=20
>  	struct rzv2h_dsi_mode_calc mode_calc;
>=20
> @@ -552,8 +555,8 @@ static int rzg2l_dphy_conf_clks(struct rzg2l_mipi_dsi=
 *dsi, unsigned long mode_f
>  	unsigned long vclk_rate;
>  	unsigned int bpp;
>=20
> -	clk_set_rate(dsi->vclk, mode_freq * KILO);
> -	vclk_rate =3D clk_get_rate(dsi->vclk);
> +	clk_set_rate(dsi->vclk[dsi->vclk_idx], mode_freq * KILO);
> +	vclk_rate =3D clk_get_rate(dsi->vclk[dsi->vclk_idx]);
>  	if (vclk_rate !=3D mode_freq * KILO)
>  		dev_dbg(dsi->dev, "Requested vclk rate %lu, actual %lu mismatch\n",
>  			mode_freq * KILO, vclk_rate);
> @@ -764,6 +767,11 @@ static int rzg2l_mipi_dsi_startup(struct rzg2l_mipi_=
dsi *dsi,
>  	if (ret < 0)
>  		goto err_phy;
>=20
> +	if (dsi->info->features & RZ_MIPI_DSI_FEATURE_GPO0R)
> +		rzg2l_mipi_dsi_link_write(dsi, GPO0R, dsi->vclk_idx);

As per "9.5.3.1 Power on Reset and Initial Settings for All Operations"
This needs to be set before PLLENR.PLLEN.

Cheers,
Biju


> +
> +	dev_dbg(dsi->dev, "selected du%d input channel\n", dsi->vclk_idx);
> +
>  	/* Enable Data lanes and Clock lanes */
>  	txsetr =3D TXSETR_DLEN | TXSETR_NUMLANEUSE(dsi->lanes - 1) | TXSETR_CLE=
N;
>  	rzg2l_mipi_dsi_link_write(dsi, TXSETR, txsetr); @@ -1006,6 +1014,37 @@ =
static int
> rzg2l_mipi_dsi_stop_video(struct rzg2l_mipi_dsi *dsi)
>  	return ret;
>  }
>=20
> +static int rzg2l_mipi_dsi_get_input_port(struct rzg2l_mipi_dsi *dsi) {
> +	struct device_node *np =3D dsi->dev->of_node;
> +	struct device_node *remote_ep, *ep_node;
> +	struct of_endpoint ep;
> +	bool ep_enabled;
> +	int in_port;
> +
> +	/* DSI can have only one port enabled */
> +	for_each_endpoint_of_node(np, ep_node) {
> +		of_graph_parse_endpoint(ep_node, &ep);
> +		if (ep.port >=3D RZ_MIPI_DSI_MAX_INPUT)
> +			break;
> +
> +		remote_ep =3D of_graph_get_remote_endpoint(ep_node);
> +		ep_enabled =3D of_device_is_available(remote_ep);
> +		of_node_put(remote_ep);
> +
> +		if (ep_enabled) {
> +			in_port =3D ep.port;
> +			break;
> +		}
> +	}
> +
> +	if (!ep_enabled)
> +		return -EINVAL;
> +
> +	dev_dbg(dsi->dev, "input port@%d\n", in_port);
> +	return in_port;
> +}
> +
>  /* ---------------------------------------------------------------------=
--------
>   * Bridge
>   */
> @@ -1408,9 +1447,21 @@ static int rzg2l_mipi_dsi_probe(struct platform_de=
vice *pdev)
>  	if (IS_ERR(dsi->mmio))
>  		return PTR_ERR(dsi->mmio);
>=20
> -	dsi->vclk =3D devm_clk_get(dsi->dev, "vclk");
> -	if (IS_ERR(dsi->vclk))
> -		return PTR_ERR(dsi->vclk);
> +	dsi->vclk[0] =3D devm_clk_get(dsi->dev, "vclk");
> +		if (IS_ERR(dsi->vclk[0]))
> +			return PTR_ERR(dsi->vclk[0]);
> +
> +	if (dsi->info->features & RZ_MIPI_DSI_FEATURE_GPO0R) {
> +		dsi->vclk[1] =3D devm_clk_get(dsi->dev, "vclk2");
> +		if (IS_ERR(dsi->vclk[1]))
> +			return PTR_ERR(dsi->vclk[1]);
> +
> +		ret =3D rzg2l_mipi_dsi_get_input_port(dsi);
> +		if (ret < 0)
> +			return dev_err_probe(dsi->dev, -EINVAL,
> +					     "No available input port\n");
> +		dsi->vclk_idx =3D ret;
> +	}
>=20
>  	dsi->lpclk =3D devm_clk_get(dsi->dev, "lpclk");
>  	if (IS_ERR(dsi->lpclk))
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi_regs.h b/driver=
s/gpu/drm/renesas/rz-
> du/rzg2l_mipi_dsi_regs.h
> index 2bef20566648..cee2e0bc5dc5 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi_regs.h
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi_regs.h
> @@ -83,6 +83,9 @@
>  #define LINKSR_SQCHRUN1			BIT(4)
>  #define LINKSR_SQCHRUN0			BIT(0)
>=20
> +/* RZ/G3E General Purpose Output 0 Register */
> +#define GPO0R				0xc0
> +
>  /* Tx Set Register */
>  #define TXSETR				0x100
>  #define TXSETR_NUMLANECAP		(0x3 << 16)
> --
> 2.43.0

